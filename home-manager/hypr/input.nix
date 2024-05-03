{
  pkgs,
  lib,
  input,
  config,
  ...
}:
{
  options = {
    hypr-inputs.enable = 
      lib.mkEnableOption "enables hypr-inputs";
  };

  config = lib.mkIf config.hypr-inputs.enable {
    wayland.windowManager.hyprland.settings = {
      input = {
        # Appropriate XKB keymap parameter
        # tbh, i'll never use it
        # string: [[empty]]
        kb_model = "";
        # Appropriate XKB keymap parameter
        # string: "us"
        kb_layout = "us";
        # Appropriate XKB keymap parameter
        # string: [[empty]]
        kb_variant = "";
        # Appropriate XKB keymap parameter
        # string: [[empty]]
        kb_options = "";
        # Appropriate XKB keymap parameter
        # string: [[empty]]
        kb_rules= "";
        # Path to custom .xkb file
        # string: [[empty]]
        kb_file = "";
        # Engage numlock by default
        # bool: false
        numlock_by_default = false;
        # Determines how keybinds act when multiple layouts are used.
        # bool: false
        resolve_binds_by_sym = false;
        # Repeat rate for held-down keys, in repeats/sec
        # int: 25
        repeat_rate = 25;
        # Delay before held-down key is repeated, in milliseconds
        # int: 600
        repeat_delay = 600;
        # Sets mouse input sensitivity. [-1.0 - 1.0]
        # float: 0.0
        sensitivity = 0.0;
        accel_profile = "";
        # Force no cursor acceleration. Bypasses most settings to get as raw as possible.
        # NOT RECOMMENDED
        # bool: false
        force_no_accel = false;
        # Switches lmb and rmb
        # bool: false
        left_handed = false;
        scroll_points = "";
        scroll_method = "";
        scroll_button = 0;
        scroll_button_lock = 0;
        scroll_factor = 1.0;
        natural_scroll = false;
        follow_mouse = 1;
        mouse_refocus = true;
        float_switch_override_focus = 1;
        special_fallthrough = false;
        off_window_axis_events = 1;
    };
  };
 }; 
}
