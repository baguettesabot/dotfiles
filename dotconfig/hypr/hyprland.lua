-- host machine detection, as required

local handle = io.popen('hostnamectl hostname')
local host = handle:read()

-- todo: check if valid host, optional

local local_monitor = require(host .. '/monitor')
local local_input = require(host .. '/input')
local local_device = require(host .. '/device')

-- env vars

hl.env('XDG_CURRENT_DESKTOP', 'Hyprland')
hl.env('XDG_SESSION_TYPE', 'wayland')
hl.env('XDG_SESSION_DESKTOP', 'Hyprland')

hl.env('GBM_BACKEND', 'nvidia-drm')
hl.env('__GLX_VENDOR_LIBRARY_NAME', 'nvidia')
hl.env('LIBVA_DRIVER_NAME', 'nvidia')

hl.env('ELECTRON_OZONE_PLATFORM_HINT', 'auto')

hl.env('XCURSOR_SIZE', 8)
hl.env('HYPRCURSOR_SIZE', 8)

-- programs + autostart

local terminal = 'foot'

hl.on('hyprland.start', function ()
	hl.exec_cmd('waybar & hyprpaper')
end)

-- monitor :)

for k,v in ipairs(local_monitor) do
	hl.monitor(v)
end

-- input

hl.config({ input = local_input })
for k,v in ipairs(local_device) do
	hl.device(v)
end

-- window & config

hl.config({
	general = {
		layout = 'dwindle',
		gaps_in = 2,
		gaps_out = 5,
		border_size = 1,
		col = {
			active_border = { colors = { 'rgba(33ccffee)', 'rgba(00ff99ee)' }, angle = 45 },
			inactive_border = 'rgba(595959aa)',
		},
		resize_on_border = true
	},
	decoration = {
		rounding = 5,
		blur = {
			enabled = false,
			size = 3,
			passes = 1
		}
	},
	animations = {
		enabled = true
	},
	dwindle = {
		preserve_split = true
	}
})

hl.curve('default_curve', { type = 'bezier', points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({ leaf = 'windows', enabled = true, speed = 1, bezier = 'default_curve' })
hl.animation({ leaf = 'border', enabled = true, speed = 10, bezier = 'default_curve' })
hl.animation({ leaf = 'borderangle', enabled = true, speed = 8, bezier = 'default_curve' })
hl.animation({ leaf = 'fade', enabled = true, speed = 3, bezier = 'default_curve' })
hl.animation({ leaf = 'workspaces', enabled = true, speed = 1, bezier = 'default_curve' })

hl.window_rule({ match = { class = '^(foot)' }, opacity = '0.8 0.7 0.9' })
hl.window_rule({ match = { class = '.*' }, suppress_event = 'maximize' })

-- misc

hl.config({
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true
	},
	cursor = {
		no_hardware_cursors = 1
	}
	
})

-- general binds

local modKey = 'SUPER'

hl.bind(modKey .. ' + Q', hl.dsp.exec_cmd(terminal))
hl.bind(modKey .. ' + R', hl.dsp.exec_cmd('tofi-drun'))
hl.bind(modKey .. ' + C', hl.dsp.window.close())
hl.bind(modKey .. ' + O', hl.dsp.window.fullscreen({ mode = 'fullscreen', action = 'toggle' }))
hl.bind(modKey .. ' + M', hl.dsp.exec_cmd('command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch "hl.dsp.exit()"'))

-- PrtSc, screenshot select rectangle region

hl.bind('code:107', hl.dsp.exec_cmd('grim -g "$(slurp -d)"'))

-- media

hl.bind('XF86AudioRaiseVolume', hl.dsp.exec_cmd('wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+'), { repeating = true })
hl.bind('XF86AudioLowerVolume', hl.dsp.exec_cmd('wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%-'), { repeating = true })
hl.bind('XF86AudioMute', hl.dsp.exec_cmd('wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle'))
hl.bind('XF86AudioNext', hl.dsp.exec_cmd('playerctl next'))
hl.bind('XF86AudioPrev', hl.dsp.exec_cmd('playerctl previous'))
hl.bind('XF86AudioPlay', hl.dsp.exec_cmd('playerctl play-pause'))

-- screen brightness

hl.bind('XF86MonBrightnessUp', hl.dsp.exec_cmd('brightnessctl set 5%+'), { repeating = true })
hl.bind('XF86MonBrightnessDown', hl.dsp.exec_cmd('brightnessctl set 5%-'), { repeating = true })

-- Move focus with SUPER + vim movement keys

hl.bind(modKey .. ' + H', hl.dsp.focus({ direction = 'left' }))
hl.bind(modKey .. ' + L', hl.dsp.focus({ direction = 'right' }))
hl.bind(modKey .. ' + K', hl.dsp.focus({ direction = 'up' }))
hl.bind(modKey .. ' + J', hl.dsp.focus({ direction = 'down' }))

-- Move window with SUPER + SHIFT + vim movement keys

hl.bind(modKey .. ' + SHIFT + H', hl.dsp.window.move({ direction = 'left' }))
hl.bind(modKey .. ' + SHIFT + L', hl.dsp.window.move({ direction = 'right' }))
hl.bind(modKey .. ' + SHIFT + K', hl.dsp.window.move({ direction = 'up' }))
hl.bind(modKey .. ' + SHIFT + J', hl.dsp.window.move({ direction = 'down' }))

-- Resize window with SUPER + ALT + vim movement keys

hl.bind(modKey .. ' + ALT + H', hl.dsp.window.resize({ x = -25, y = 0 }))
hl.bind(modKey .. ' + ALT + L', hl.dsp.window.resize({ x = 25, y = 0 }))
hl.bind(modKey .. ' + ALT + K', hl.dsp.window.resize({ x = 0, y = -25 }))
hl.bind(modKey .. ' + ALT + J', hl.dsp.window.resize({ x = 0, y = 25 }))

-- Move active window to a workspace with SUPER + SHIFT + [0-9]

hl.bind(modKey .. ' + SHIFT + 1', hl.dsp.window.move({ workspace = 1 }))
hl.bind(modKey .. ' + SHIFT + 2', hl.dsp.window.move({ workspace = 2 }))
hl.bind(modKey .. ' + SHIFT + 3', hl.dsp.window.move({ workspace = 3 }))
hl.bind(modKey .. ' + SHIFT + 4', hl.dsp.window.move({ workspace = 4 }))
hl.bind(modKey .. ' + SHIFT + 5', hl.dsp.window.move({ workspace = 5 }))
hl.bind(modKey .. ' + SHIFT + 6', hl.dsp.window.move({ workspace = 6 }))
hl.bind(modKey .. ' + SHIFT + 7', hl.dsp.window.move({ workspace = 7 }))
hl.bind(modKey .. ' + SHIFT + 8', hl.dsp.window.move({ workspace = 8 }))
hl.bind(modKey .. ' + SHIFT + 9', hl.dsp.window.move({ workspace = 9 }))
hl.bind(modKey .. ' + SHIFT + 0', hl.dsp.window.move({ workspace = 10 }))

-- Move to a workspace with SUPER + [0-9]

hl.bind(modKey .. ' + 1', hl.dsp.focus({ workspace = 1 }))
hl.bind(modKey .. ' + 2', hl.dsp.focus({ workspace = 2 }))
hl.bind(modKey .. ' + 3', hl.dsp.focus({ workspace = 3 }))
hl.bind(modKey .. ' + 4', hl.dsp.focus({ workspace = 4 }))
hl.bind(modKey .. ' + 5', hl.dsp.focus({ workspace = 5 }))
hl.bind(modKey .. ' + 6', hl.dsp.focus({ workspace = 6 }))
hl.bind(modKey .. ' + 7', hl.dsp.focus({ workspace = 7 }))
hl.bind(modKey .. ' + 8', hl.dsp.focus({ workspace = 8 }))
hl.bind(modKey .. ' + 9', hl.dsp.focus({ workspace = 9 }))
hl.bind(modKey .. ' + 0', hl.dsp.focus({ workspace = 10 }))

-- prev/next open workspace w/ SUPER + B/F

hl.bind(modKey .. ' + B', hl.dsp.focus({ workspace = 'e-1' }))
hl.bind(modKey .. ' + F', hl.dsp.focus({ workspace = 'e+1' }))

-- prev/next relative workspace w/ SUPER + pg up/down

hl.bind(modKey .. ' + page_up', hl.dsp.focus({ workspace = '-1' }))
hl.bind(modKey .. ' + page_down', hl.dsp.focus({ workspace = '+1' }))

-- Move/resize windows with SUPER + LMB/RMB and dragging

hl.bind(modKey .. ' + mouse:272', hl.dsp.window.drag(), { mouse = true})
-- hl.bind(modKey .. ' + mouse:273', hl.dsp.window.resize(), { mouse = true})
