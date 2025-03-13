function hypridle-toggle
    if systemctl --user --now is-active hypridle.service
        systemctl --user --now stop hypridle.service
    else
        systemctl --user --now start hypridle.service
    end
end
