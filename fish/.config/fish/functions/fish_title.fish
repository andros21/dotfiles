# Change terminal app window title
function fish_title -d "Title to show above terminal app"
    printf "%s" (whoami)@(hostname):(prompt_pwd)
end

