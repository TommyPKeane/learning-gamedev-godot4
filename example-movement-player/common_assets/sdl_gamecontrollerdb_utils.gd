# SDL GameController Utilities
#
# References:
# - https://github.com/mdqinc/SDL_GameControllerDB/blob/master/gamecontrollerdb.txt
extends Object
class_name SDLGameControllerUtils

const SDL_FILE_COMMENT_SUBSTR: String = "#"
const DEFAULT_SDL_FILE: String = "res://common_assets/sdl_gamecontrollerdb/gamecontrollerdb.txt"
const DEFAULT_WINDOWS_SDL_FILE: String = "res://common_assets/sdl_gamecontrollerdb/gamecontrollerdb-windows.txt"
const DEFAULT_LINUX_SDL_FILE: String = "res://common_assets/sdl_gamecontrollerdb/gamecontrollerdb-linux.txt"
const DEFAULT_MACOS_SDL_FILE: String = "res://common_assets/sdl_gamecontrollerdb/gamecontrollerdb-macos.txt"
const DEFAULT_ANDROID_SDL_FILE: String = "res://common_assets/sdl_gamecontrollerdb/gamecontrollerdb-android.txt"
const DEFAULT_IOS_SDL_FILE: String = "res://common_assets/sdl_gamecontrollerdb/gamecontrollerdb-ios.txt"

static func get_default_filename_by_os() -> String:
	var sdl_default_filename: String
	var crnt_os_name: String = OS.get_name()
	if crnt_os_name == "Windows":
		sdl_default_filename = DEFAULT_WINDOWS_SDL_FILE
	elif crnt_os_name == "macOS":
		sdl_default_filename = DEFAULT_MACOS_SDL_FILE
	elif crnt_os_name == "Linux":
		sdl_default_filename = DEFAULT_LINUX_SDL_FILE
	elif crnt_os_name == "Android":
		sdl_default_filename = DEFAULT_ANDROID_SDL_FILE
	elif crnt_os_name == "iOS":
		sdl_default_filename = DEFAULT_IOS_SDL_FILE
	else:
		sdl_default_filename = DEFAULT_SDL_FILE  # Unknown OS
	return sdl_default_filename

static func parse_and_load_sdl_gamecontrolldb_txt(txt_filepath: String) -> void:
	print(OS.get_name())
	var file_obj = FileAccess.open(txt_filepath, FileAccess.READ)
	var controller_mappings_added: int = 0
	while file_obj.get_position() < file_obj.get_length():
		var crnt_line = file_obj.get_line()
		if crnt_line.begins_with(SDL_FILE_COMMENT_SUBSTR):
			continue  # Line is commented-out
		elif crnt_line.length() < 3:
			continue  # Line is blank or too short
		else:
			Input.add_joy_mapping(crnt_line, true)
			controller_mappings_added += 1
	file_obj.close()
	print("Loaded %0d Controller Mappings" % controller_mappings_added)
	return
