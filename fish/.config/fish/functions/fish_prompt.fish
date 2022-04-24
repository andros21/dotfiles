function fish_prompt

   # --------------------------------------------
   # Pythonic prompt, very clean and simple,
   # selected with fish_config with custom colors
   # and append git_prompt_status
   # --------------------------------------------

   # Line 1
   #
   if not set -q VIRTUAL_ENV_DISABLE_PROMPT
      set -g VIRTUAL_ENV_DISABLE_PROMPT true
   end

   # std prompt
   #
   set_color yellow
   printf '%s' (whoami)
   set_color normal
   printf ' at '

   set_color magenta
   printf '%s' (prompt_hostname)
   set_color normal
   printf ' in '

   set_color $fish_color_cwd
   printf '%s' (prompt_pwd)
   set_color normal

   # git prompt
   #
   append_git_prompt

   # Line 2
   #

   # break line
   #
   echo

   # fish mode vi prompt
   #
   #fish_mode_vi_prompt

   # virtual env prompt
   #
   if test $VIRTUAL_ENV
      printf "(%s) " (set_color blue)(basename $VIRTUAL_ENV)(set_color normal)
   end
   printf '$ '
   set_color normal
end


function fish_mode_vi_prompt -d "Outputs the mode indicator for use in vi-mode"
   switch $fish_bind_mode
      case default
         set_color red
         printf '[N] '
      case insert
         set_color green
         printf '[I] '
      case replace_one
         set_color yellow
         printf '[R] '
      case visual
         set_color brmagenta
         printf '[V] '
      case '*'
         set_color red
         printf '[?] '
   end
   set_color normal
end

function append_git_prompt -d "Append git prompt"

   # ---------------------------------------------
   # https://github.com/magicmonty/bash-git-prompt
   # ---------------------------------------------

   if not set -q __GIT_PROMPT_DIR
      set __GIT_PROMPT_DIR ~/.config/fish/functions/.fish-git-prompt
   end

   # Colors
   # Reset
   set ResetColor (set_color normal)       # Text Reset

   # Regular Colors
   set Red (set_color red)                 # Red
   set Yellow (set_color yellow);          # Yellow
   set Blue (set_color blue)               # Blue
   set WHITE (set_color white)

   # Bold
   set BGreen (set_color -o green)         # Green

   # High Intensty
   set IBlack (set_color -o black)         # Black

   # Bold High Intensty
   set BRed (set_color -o red)             # Red

   # Default values for the appearance of the prompt. Configure at will.
   set GIT_PROMPT_PREFIX "["
   set GIT_PROMPT_SUFFIX "]"
   set GIT_PROMPT_SEPARATOR " |"
   set GIT_PROMPT_BRANCH "$BRed"
   set GIT_PROMPT_STAGED "$Yellow+"
   set GIT_PROMPT_CONFLICTS "$Red✖"
   set GIT_PROMPT_CHANGED "$Blue!"
   set GIT_PROMPT_REMOTE " "
   set GIT_PROMPT_UNTRACKED "?"
   set GIT_PROMPT_STASHED "⚑ "

   set -e __CURRENT_GIT_STATUS
   set gitstatus "$__GIT_PROMPT_DIR/gitstatus.py"

   set _GIT_STATUS (python3 $gitstatus)
   set __CURRENT_GIT_STATUS $_GIT_STATUS

   set __CURRENT_GIT_STATUS_PARAM_COUNT (count $__CURRENT_GIT_STATUS)

   if not test "0" -eq $__CURRENT_GIT_STATUS_PARAM_COUNT
      set GIT_BRANCH $__CURRENT_GIT_STATUS[1]
      set GIT_REMOTE "$__CURRENT_GIT_STATUS[2]"
      if contains "." "$GIT_REMOTE"
         set -e GIT_REMOTE
      end
      set GIT_STAGED $__CURRENT_GIT_STATUS[3]
      set GIT_CONFLICTS $__CURRENT_GIT_STATUS[4]
      set GIT_CHANGED $__CURRENT_GIT_STATUS[5]
      set GIT_UNTRACKED $__CURRENT_GIT_STATUS[6]
      set GIT_STASHED $__CURRENT_GIT_STATUS[7]
      set GIT_CLEAN $__CURRENT_GIT_STATUS[8]
   end

   if test -n "$__CURRENT_GIT_STATUS"

      if [ "$GIT_CLEAN" = "1" ]
         set GIT_PROMPT_BRANCH "$BGreen"
         set GIT_PROMPT_SEPARATOR ""
      end

      set STATUS " $GIT_PROMPT_PREFIX$GIT_PROMPT_BRANCH$GIT_BRANCH$ResetColor"

      if set -q GIT_REMOTE
         set STATUS "$STATUS$GIT_PROMPT_REMOTE$GIT_REMOTE$ResetColor"
      end

      set STATUS "$STATUS$GIT_PROMPT_SEPARATOR"

      if [ $GIT_STAGED != "0" ]
         set STATUS "$STATUS $GIT_PROMPT_STAGED$GIT_STAGED$ResetColor"
      end

      if [ $GIT_CONFLICTS != "0" ]
         set STATUS "$STATUS $GIT_PROMPT_CONFLICTS$GIT_CONFLICTS$ResetColor"
      end

      if [ $GIT_CHANGED != "0" ]
         set STATUS "$STATUS $GIT_PROMPT_CHANGED$GIT_CHANGED$ResetColor"
      end

      if [ "$GIT_UNTRACKED" != "0" ]
         set STATUS "$STATUS $GIT_PROMPT_UNTRACKED$GIT_UNTRACKED$ResetColor"
      end

      if [ "$GIT_STASHED" != "0" ]
         set STATUS "$STATUS $GIT_PROMPT_STASHED$GIT_STASHED$ResetColor"
      end

      #if [ "$GIT_CLEAN" = "1" ]
      #    set STATUS "$STATUS $GIT_PROMPT_CLEAN"
      #end

      set STATUS " on$STATUS$ResetColor$GIT_PROMPT_SUFFIX"

   else

   set STATUS ""

   end

      printf $STATUS

end
