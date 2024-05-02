{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      "$mod" = "SUPER";
      bind = [
        "ALT, M, exec, alacritty"
      ];
      #"plugins:borders-plus-plus" = {
      #  add_borders = 1; # 0 - 9

	# add up to 9 borders
#	"col.border_1" = "rgb(ffffff)";
#	"col.border_2" = "rgb(2222ff)";

	# -1 means "default" as in the one defined in general:border_size
#	border_size_1 = 10;
#	border_size_2 = -1;

	# makes outer edges match rounding of the parent. Turn on / off to better understand. Default = on.
	# natural_rounding = yes;
        

#      };
    };
  };
}
