{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: 
{
  options = {
    hypr.enable = 
      lib.mkEnableOption "enables hypr";
  };

  config = lib.mkIf config.hypr.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      plugins = [
        inputs.hyprland-plugins.packages."${pkgs.system}".borders-plus-plus
      ];

      settings = {
        "$mod" = "SUPER";
        bind = [
          "ALT, M, exec, alacritty"
	  "$mod, 1, exec, hyprctl dispatch exit"
        ];

        # "plugin:borders-plus-plus" = {
          # add_borders = 1; # 0 - 9

	  # add up to 9 borders
 	  # "col.border_1" = "rgb(123456)";
 	  # "col.border_2" = "rgb(654321)";

	  # -1 means "default" as in the one defined in general:border_size
 	  # border_size_1 = 10;
 	  # border_size_2 = 5;

	  # makes outer edges match rounding of the parent. Turn on / off to better understand. Default = on.
 	  # natural_rounding = "yes";
        #};
      };
    };
  };
}
