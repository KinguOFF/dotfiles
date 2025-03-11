#!/usr/bin/env fish
if systemctl --user is-active hypridle.service
    systemctl --user stop hypridle.service
else
    systemctl --user start hypridle.service
end
