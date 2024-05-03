{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: 
{
  imports = [
    ./input.nix
  ];
  options = {
    hypr.enableHypr = 
      lib.mkEnableOption "enables hypr";
    hypr.enableBorders =
      lib.mkEnableOption "enables borders++";
    hypr.enableBars =
      lib.mkEnableOption "enables hyprbar";
  };

  config = lib.mkIf config.hypr.enableHypr {
    hypr-inputs.enable = true;
    wayland.windowManager.hyprland = {
      # enable = true;
      
      # we don't want plugins yet
      # plugins = [
        # (lib.mkIf config.hypr.enableBorders inputs.hyprland-plugins.packages.x86_64-linux.borders-plus-plus)
      	# (lib.mkIf config.hypr.enableBars inputs.hyprland-plugins.packages.x86_64-linux.hyprbars)
      # ];

      settings = {
        "$mod" = "SUPER";
        bind = [
          "ALT, M, exec, alacritty"
	  "$mod, 1, exec, hyprctl dispatch exit"
        ];
	
	# Just kind of guessed this one.
	# Good job me.
	exec-once = [
	  "waybar"
	];

	# Variables
	# TYPE: DEFAULT_VALUE;
	general = {
	  # Mouse sensitivity, legacy, may bug out if not 1.0, prefer input:sensitivy
	  # float: 1.0
	  sensitivity = 1;  
	  # Size of the border around windows
	  # int: 1
	  border_size = 1;
	  # Disable borders for floating windows
	  # bool: false
	  no_border_on_floating = false;
          # Gaps between windows, also supports css style gaps (top, right, bottom, left -> 5,10,15,20)
	  # allegedly. not sure how it works
	  # TODO: figure out gap_in/gap_out css styling?
	  # int: 5
	  gaps_in = 4;
	  # gaps_in = [5 10 15 20];
	  # Gaps between windows and monitor edges, also supports css style gaps
	  # int: 20;
	  gaps_out = 10;
	  # Border colors for inactive/active windows
	  # gradient: rgba(ff444444)/rgba(ffffffff)
	  "col.inactive_border" = "rgba(ff444444)";
	  "col.active_border" = "rgba(ffffffff)";
	  # Border colors inactive/active windows that cannot be added to a group
	  # gradient: rgba(ffffaaff)/rgba(ffff00ff)
	  "col.nogroup_border" = "rgba(ffffaaff)";
	  "col.nogroup_border_active" = "rgba(ffff00ff)";
	  # In seconds, amount of time before a cursor gets hidden due to inactivity
	  # Set to 0 is disable
	  # int: 0
	  cursor_inactive_timeout = 5;
	  # TODO: nanikore?
	  # Which layout to use [dwindle/master]
	  # str: "dwindle"
	  # layout = "dwindle"
	  # If true, will not teleport cursor in many cases (focusing, keybinds, etc)
	  # bool: false
	  no_cursor_warps = false;
	  # if true, will not fall back to the next available window when moving focus in a direction where no window was found
	  # bool: false
	  no_focus_fallback = false;
	  # if true, will also apply the sensitivity to raw mouse output (eg sensitivity in games)
	  # REALLY NOT RECOMMEND
	  # bool: false
	  # apply_sens_to_raw = false;
	  # Enables resigin windows by clicking and dragging on borders and gaps
	  # bool: false
	  resize_on_border = false;
	  # extends area around border where you can click and drag
	  # only used for general:resize_on_border
	  # int: 15;
	  extend_border_grab_area = 15;
	  # show cursor icon when hovering over borders
	  # only used with general:resize_on_border
	  # bool: true
	  hover_icon_on_border = true;
	  # master switch to allow tearing to occur
	  # https://wiki.hyprland.org/Configuring/Tearing/
	  # bool: false
	  allow_tearing = false;
	  # Force floating windows to use a specific corner when being resized
	  # 1-4 clockwise from top left; 0 disables
	  # int: 0
	  resize_corner = 0;
	};

        # Decoration
	decoration = {
	  # equivalent to css' border-radius; in px
	  # int: 0
          rounding = 6;
	  # Opacity of active/inactive/fullscreen windows
	  # int: 1 / 1 / 1
          active_opacity = 1;
	  inactive_opacity = 1;
	  fullscreen_opacity = 1;
	  # enable drop shadows on windows
	  # bool: true;
	  drop_shadow = true;
	  # Shadow range in layout px
	  # int: 4
	  shadow_range = 4;
	  # in what power to render the falloff (higher = faster falloff) [1-4]
	  # int: 3
	  shadow_render_power = 3;
	  # if true, shadow will not be rendered behind the window, only around it
	  # bool: true;
	  shadow_ignore_window = true;
	  # Shadow color, alpha dictates opacity (duh?)
	  # color: rgba(ee1a1a1a)
	  "col.shadow" = "rgba(ee1a1a1a)";
	  # Shadow color for inactive window, if not set, then fallback to col.shadow
	  # color: UNSET
	  # "col.shadow_inactive" = "rgba(ee1a1a1a)";
	  # Shadow rendering offset
	  # vec2: "0 0"; # [0, 0];
	  shadow_offset = "0 0";
	  # Shadow's scale [0.0 - 1.0]
	  # float: 1.0
	  shadow_scale = 1.0;
	  # Enables dimming of inactive windows
	  # bool: false;
	  dim_inactive = false;
	  # How much inactive windows should be dimmed [0.0 - 1.0];
	  # float: 0.5
	  dim_strength = 0.5;
	  # How much to dim the rest of the screen when a special workspace is open [0.0 - 1.0]
	  # float: 0.2;
	  dim_special = 0.2;
	  # How much the dimaround window rule should dim by. [0.0 - 1.0];
	  # float: 0.4;
	  dim_around = 0.4;
	  # Path to custom shader to be applied at the end of rendering
	  #screen_shader = "";
	  
	  # Blur
	
	  blur = {
	    # enable kawase window background blur
	    # bool: true;
	    enabled = true;
	    # Blur size (distance)
	    # int: 8
	    size = 8;
	    # Number of blur passes to perform
	    # int: 1;
	    passes = 1;
	    # Make the blur layer ignore the opacity of the window
	    # bool = false
	    ignore_opacity = false;
	    # Whether to enable further optimizations to the blur
	    # Recommend ON
	    # bool: true;
	    new_optimizations = true;
	    # If enabled, floating windows will ignore tiled windows in their blur.
	    # Only available if blur:new_optimizations is true
	    # Performance buff to floating blur
	    xray = false;
	    # amount of noise to apply
	    # float: 0.0117
	    noise = 0.0117;
	    # float: 0.8916
	    contrast = 0.8916;
	    # float: 0.8172
	    brightness = 0.8172;
	    # float: 
	    # vibrancy = 0.1696;
	    # float: 0.0;
	    # vibrancy_darkness = 0.0;
	    # whether to blur behind the special workspace (EXPENSIVE)
	    # bool: false;
	    special = false;
	    # whether to blur popups (eg right-click menus)
            # bool: false;
	    popups = false;
	    # works like ignorealpha in layer rules
	    # if pixel opacity is below set value, will not blur [0.0 - 1.0];
	    # float: 0.2;
	    popups_ignorealpha = 0.2;
	  };
	};

	

        "plugin:borders-plus-plus" = {
          add_borders = 0; # 0 - 9

	  # add up to 9 borders
 	  "col.border_1" = "rgb(123456)";
 	  "col.border_2" = "rgb(654321)";

	  # -1 means "default" as in the one defined in general:border_size
 	  border_size_1 = 1;
 	  # border_size_2 = 1;

	  # makes outer edges match rounding of the parent. Turn on / off to better understand. Default = on.
 	  natural_rounding = true;
        };
      };
    };
  };
}
