#!/bin/bash
hosts=($(grep -E "^Host havoc-(av|do)-" ~/.ssh/config.d/recon | awk '{print $2}'))
tmux new-window "ssh ${hosts[0]}"
for host in "${hosts[@]:1}"; do 
    tmux split-window -d "ssh $host"
    tmux select-layout tiled
done
tmux set-window-option synchronize-panes on
