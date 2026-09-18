extends Node2D

# Multi-language support
var current_language: String = "vi"  # Default: Vietnamese (vi, en, zh)
var translations: Dictionary = {
	"vi": {
		"hp": "Máu",
		"height": "Độ cao",
		"best": "Kỉ lục",
		"game_over": "GAME OVER",
		"tap_restart": "NHẤN ĐỂ CHƠI LẠI",
		"tap_play": "NHẤN ĐỂ CHƠI",
		"select_language": "Chọn Ngôn Ngữ",
		"title": "CÁ VƯỢT THÁC"
	},
	"en": {
		"hp": "Health",
		"height": "Height",
		"best": "Best",
		"game_over": "GAME OVER",
		"tap_restart": "TAP TO RESTART",
		"tap_play": "TAP TO PLAY",
		"select_language": "Select Language",
		"title": "SALMON RUN"
	},
	"zh": {
		"hp": "生命",
		"height": "高度",
		"best": "最佳",
		"game_over": "游戏结束",
		"tap_restart": "点击重新开始",
		"tap_play": "点击开始游戏",
		"select_language": "选择语言",
		"title": "鲑鱼大冒险"
	}
}

# Game variables
var player_pos: Vector2
var player_velocity: Vector2
var player_size: float = 20
var player_max_size: float = 40
var player_min_size: float = 10
var player_color: Color = Color.BLUE
var player_hp: int = 3
var max_hp: int = 3

# Game physics
var gravity: float = 400
var jump_force: float = -300
var screen_width: float
var screen_height: float

# Obstacles and enemies
var obstacles: Array = []
var enemies: Array = []
var food: Array = []
var spawn_timer: float = 0
var spawn_interval: float = 2.0
var enemy_spawn_timer: float = 0
var enemy_spawn_interval: float = 3.0
var food_spawn_timer: float = 0
var food_spawn_interval: float = 4.0

# Game state
var score: float = 0
var max_score: float = 0
var game_over: bool = false
var invincible_timer: float = 0
var invincible_duration: float = 0.5
var showing_language_select: bool = true  # Show language select on startup
var game_started: bool = false  # Has game been played once

# UI
var ui_font: Font
var ui_font_size: int = 40
var language_buttons: Array = [
	{"lang": "vi", "name": "🇻🇳 Việt Nam", "rect": Rect2(0, 0, 0, 0)},
	{"lang": "en", "name": "🇬🇧 English", "rect": Rect2(0, 0, 0, 0)},
	{"lang": "zh", "name": "🇨🇳 中文", "rect": Rect2(0, 0, 0, 0)}
]

func get_text(key: String) -> String:
	"""Get translated text for current language"""
	if translations[current_language].has(key):
		return translations[current_language][key]
	return key  # Fallback to key if not found

func _ready():
	screen_width = get_viewport_rect().size.x
	screen_height = get_viewport_rect().size.y
	
	# Initialize player position
	player_pos = Vector2(screen_width * 0.2, screen_height * 0.5)
	player_velocity = Vector2.ZERO
	
	# Setup font
	ui_font = SystemFont.new()
	
	set_process_input(true)

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			var mouse_pos = event.position
			
			# Handle language selection
			if showing_language_select:
				for btn in language_buttons:
					if btn.rect.has_point(mouse_pos):
						current_language = btn.lang
						showing_language_select = false
						game_started = true
						return
			
			# Handle game controls
			if game_started:
				if game_over:
					restart_game()
				else:
					player_velocity.y = jump_force

func _process(delta: float):
	if showing_language_select or not game_started:
		return
	
	if game_over:
		return
	
	# Update player physics
	player_velocity.y += gravity * delta
	player_pos.y += player_velocity.y * delta
	
	# Screen boundaries
	if player_pos.y - player_size/2 < 0:
		player_pos.y = player_size/2
		player_velocity.y = 0
	
	if player_pos.y + player_size/2 > screen_height:
		on_player_hit()
	
	# Update invincible timer
	if invincible_timer > 0:
		invincible_timer -= delta
	
	# Spawn obstacles
	spawn_timer += delta
	if spawn_timer >= spawn_interval:
		spawn_obstacle()
		spawn_timer = 0
	
	# Spawn enemies
	enemy_spawn_timer += delta
	if enemy_spawn_timer >= enemy_spawn_interval:
		spawn_enemy()
		enemy_spawn_timer = 0
	
	# Spawn food
	food_spawn_timer += delta
	if food_spawn_timer >= food_spawn_interval:
		spawn_food()
		food_spawn_timer = 0
	
	# Update obstacles
	for obs in obstacles:
		obs.pos.x += obs.speed * delta
		if obs.pos.x > screen_width + 50:
			obstacles.erase(obs)
	
	# Update enemies
	for enemy in enemies:
		enemy.pos.x += enemy.speed * delta
		
		# Simple AI - move towards player
		if enemy.pos.y < player_pos.y - 30:
			enemy.pos.y += 50 * delta
		elif enemy.pos.y > player_pos.y + 30:
			enemy.pos.y -= 50 * delta
		
		# Check collision with player
		if check_circle_collision(player_pos, player_size/2, enemy.pos, enemy.size/2):
			if invincible_timer <= 0:
				on_player_hit()
		
		# Remove if off screen
		if enemy.pos.x > screen_width + 50:
			enemies.erase(enemy)
	
	# Update food
	for f in food:
		f.pos.x += f.speed * delta
		
		# Check collision with player
		if check_circle_collision(player_pos, player_size/2, f.pos, f.size/2):
			on_player_eat_food(f.type)
			food.erase(f)
		
		# Remove if off screen
		if f.pos.x > screen_width + 50:
			food.erase(f)
	
	# Update score based on height
	score = max(0, (screen_height - player_pos.y) / 10)
	if score > max_score:
		max_score = score

func spawn_obstacle():
	var obs = {}
	obs.pos = Vector2(screen_width, randf_range(screen_height * 0.3, screen_height * 0.7))
	obs.size = randf_range(30, 60)
	obs.speed = -200
	obs.type = randi() % 3  # 0: spike, 1: bomb, 2: water
	obstacles.append(obs)

func spawn_enemy():
	var enemy = {}
	enemy.pos = Vector2(screen_width, randf_range(screen_height * 0.2, screen_height * 0.8))
	enemy.size = randf_range(25, 35)
	enemy.speed = randf_range(-150, -250)
	enemy.color = Color.RED
	enemies.append(enemy)

func spawn_food():
	var f = {}
	f.pos = Vector2(screen_width, randf_range(screen_height * 0.2, screen_height * 0.8))
	f.type = randi() % 2  # 0: heal, 1: poison
	f.size = 12 if f.type == 0 else 16
	f.speed = -180
	f.color = Color.GREEN if f.type == 0 else Color.YELLOW
	food.append(f)

func on_player_hit():
	player_hp -= 1
	invincible_timer = invincible_duration
	
	if player_hp <= 0:
		game_over = true

func on_player_eat_food(food_type: int):
	if food_type == 0:  # heal
		player_hp = min(player_hp + 1, max_hp)
		player_size = min(player_size + 3, player_max_size)
	else:  # poison
		player_size = max(player_size - 5, player_min_size)

func check_circle_collision(pos1: Vector2, rad1: float, pos2: Vector2, rad2: float) -> bool:
	return pos1.distance_to(pos2) < rad1 + rad2

func restart_game():
	game_over = false
	player_pos = Vector2(screen_width * 0.2, screen_height * 0.5)
	player_velocity = Vector2.ZERO
	player_size = 20
	player_hp = max_hp
	score = 0
	obstacles.clear()
	enemies.clear()
	food.clear()
	invincible_timer = 0
	spawn_timer = 0
	enemy_spawn_timer = 0
	food_spawn_timer = 0
	# Keep current_language - no need to select again

func _draw():
	# Draw background (water)
	draw_rect(Rect2(0, 0, screen_width, screen_height), Color(0.2, 0.5, 0.8))
	
	# Draw water waves effect
	var wave_offset = fmod(Time.get_ticks_msec() / 1000.0 * 50, 40)
	for i in range(0, int(screen_width), 40):
		draw_line(Vector2(i + wave_offset, screen_height - 20), 
				  Vector2(i + wave_offset + 20, screen_height - 10), 
				  Color(0.1, 0.6, 0.9), 2)
	
	# Draw language selection screen
	if showing_language_select:
		draw_rect(Rect2(0, 0, screen_width, screen_height), Color(0, 0, 0, 0.8))
		draw_string(ui_font, Vector2(screen_width/2 - 200, screen_height/2 - 200), get_text("title"), HORIZONTAL_ALIGNMENT_LEFT, -1, 60)
		draw_string(ui_font, Vector2(screen_width/2 - 250, screen_height/2 - 80), get_text("select_language"), HORIZONTAL_ALIGNMENT_LEFT, -1, 40)
		
		# Draw language buttons
		var button_width = 150
		var button_height = 60
		var start_x = (screen_width - (button_width * 3 + 40)) / 2
		var start_y = screen_height/2 + 40
		
		for i in range(3):
			var btn = language_buttons[i]
			var x = start_x + (button_width + 20) * i
			var y = start_y
			
			btn.rect = Rect2(x, y, button_width, button_height)
			
			# Draw button
			draw_rect(btn.rect, Color(0.1, 0.5, 0.9))
			draw_rect(btn.rect, Color(0.3, 0.7, 1), false, 3)
			
			# Draw text
			draw_string(ui_font, Vector2(x + 10, y + 40), btn.name, HORIZONTAL_ALIGNMENT_LEFT, -1, 30)
		
		queue_redraw()
		return
	
	# Draw game if started
	if game_started:
		# Draw player (fish)
		draw_circle(player_pos, player_size/2, player_color)
		# Draw fish eye
		var eye_pos = player_pos + Vector2(player_size/4, -player_size/6)
		draw_circle(eye_pos, player_size/8, Color.WHITE)
		draw_circle(eye_pos + Vector2(2, 0), player_size/12, Color.BLACK)
		
		# Draw invincible effect
		if invincible_timer > 0 and fmod(invincible_timer * 10, 2) < 1:
			draw_circle(player_pos, player_size/2 + 3, Color(1, 1, 1, 0.3))
		
		# Draw obstacles
		for obs in obstacles:
			match obs.type:
				0:  # Spike
					draw_circle(obs.pos, obs.size/2, Color.DARK_RED)
					draw_line(obs.pos - Vector2(0, obs.size/2), obs.pos + Vector2(0, obs.size/2), Color.RED, 3)
				1:  # Bomb
					draw_circle(obs.pos, obs.size/2, Color.BLACK)
					draw_circle(obs.pos, obs.size/3, Color.DARK_GRAY)
				2:  # Water current
					var rect = Rect2(obs.pos - Vector2(obs.size/2, 40), Vector2(obs.size, 80))
					draw_rect(rect, Color(0, 0.8, 1, 0.3))
					# Draw arrows
					for y in range(-40, 40, 20):
						draw_line(obs.pos + Vector2(-10, y), obs.pos + Vector2(10, y), Color.CYAN, 2)
		
		# Draw enemies (predator fish)
		for enemy in enemies:
			draw_circle(enemy.pos, enemy.size/2, enemy.color)
			# Draw predator markings
			draw_line(enemy.pos - Vector2(enemy.size/3, 0), enemy.pos + Vector2(enemy.size/3, 0), Color.DARK_RED, 2)
		
		# Draw food
		for f in food:
			draw_circle(f.pos, f.size/2, f.color)
			if f.type == 0:  # heal
				draw_line(f.pos - Vector2(5, 0), f.pos + Vector2(5, 0), Color.WHITE, 2)
				draw_line(f.pos - Vector2(0, 5), f.pos + Vector2(0, 5), Color.WHITE, 2)
		
		# Draw UI
		var hp_text = get_text("hp") + ": %d/%d" % [player_hp, max_hp]
		var height_text = get_text("height") + ": %.0f" % score
		var best_text = get_text("best") + ": %.0f" % max_score
		
		draw_string(ui_font, Vector2(20, 50), hp_text, HORIZONTAL_ALIGNMENT_LEFT, -1, ui_font_size)
		draw_string(ui_font, Vector2(20, 100), height_text, HORIZONTAL_ALIGNMENT_LEFT, -1, ui_font_size)
		draw_string(ui_font, Vector2(screen_width - 350, 50), best_text, HORIZONTAL_ALIGNMENT_LEFT, -1, ui_font_size)
		
		# Draw game over screen
		if game_over:
			draw_rect(Rect2(0, 0, screen_width, screen_height), Color(0, 0, 0, 0.7))
			draw_string(ui_font, Vector2(screen_width/2 - 200, screen_height/2 - 100), get_text("game_over"), HORIZONTAL_ALIGNMENT_LEFT, -1, 60)
			draw_string(ui_font, Vector2(screen_width/2 - 150, screen_height/2), height_text, HORIZONTAL_ALIGNMENT_LEFT, -1, 50)
			draw_string(ui_font, Vector2(screen_width/2 - 250, screen_height/2 + 100), get_text("tap_restart"), HORIZONTAL_ALIGNMENT_LEFT, -1, 40)
	
	queue_redraw()
