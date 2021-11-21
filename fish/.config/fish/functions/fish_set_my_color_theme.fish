# Set my color theme using universal variables
function fish_set_my_color_theme -d "Set my color theme"
   set -U fish_color_autosuggestion 969896
   set -U fish_color_cancel \x2dr
   set -U fish_color_command c397d8
   set -U fish_color_comment e7c547
   set -U fish_color_cwd green
   set -U fish_color_cwd_root red
   set -U fish_color_end c397d8
   set -U fish_color_error d54e53
   set -U fish_color_escape 00a6b2
   set -U fish_color_history_current \x2d\x2dbold
   set -U fish_color_host normal
   set -U fish_color_host_remote yellow
   set -U fish_color_match \x2d\x2dbackground\x3dbrblue
   set -U fish_color_normal normal
   set -U fish_color_operator 00a6b2
   set -U fish_color_param 7aa6da
   set -U fish_color_quote b9ca4a
   set -U fish_color_redirection 70c0b1
   set -U fish_color_search_match bryellow\x1e\x2d\x2dbackground\x3dbrblack
   set -U fish_color_selection white\x1e\x2d\x2dbold\x1e\x2d\x2dbackground\x3dbrblack
   set -U fish_color_status red
   set -U fish_color_user brgreen
   set -U fish_color_valid_path \x2d\x2dunderline
   set -U fish_pager_color_completion normal
   set -U fish_pager_color_description B3A06D\x1eyellow
   set -U fish_pager_color_prefix white\x1e\x2d\x2dbold\x1e\x2d\x2dunderline
   set -U fish_pager_color_progress brwhite\x1e\x2d\x2dbackground\x3dcyan
   # Ok all done, set it
   set -U fish_my_color_theme set
end
