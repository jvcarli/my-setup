#!/usr/bin/env bash
# https://unix.stackexchange.com/questions/105424/mirroring-a-pane-between-two-windows
# https://unix.stackexchange.com/questions/409861/is-it-possible-to-send-input-to-a-tmux-session-without-connecting-to-it

PYTHON_SESSION=$(tmux ls | grep python | awk '{print $1}' | sed 's/.$//')

function create_python_workflow() {

    # Welcome message
    echo "Entering python dev mode"
    #sleep 1

    # Create a tmux session for sharing it and detach it
    tmux new -s shared \; detach

    # Remove tmux status bar from the shared session and
    # clear screen: zsh has a bug when screen is resized
    tmux send-keys -t shared "tmux set status off" ENTER

    # Optional, makes prefix key available on the inner nested session
    tmux send-keys -t shared "tmux set-option prefix C-o" ENTER # change prefix key

    # Crate a new tmux session called python.
    # Inside the first window unset TMUX env variable and attach to the shared sesion
    # Create a second tmux window
    # Inside the second window unset TMUX env variable and attac to the shared session,
    # then create an horizontal split
    tmux new -s python \; send-keys -t python "unset TMUX" Enter \; send-keys -t python "tmux attach-session -t shared" Enter \; new-window \; send-keys -t python "unset TMUX" Enter \; send-keys -t python "tmux attach-session -t shared" Enter \; split-window -h

}


function enter_python_workflow() {

    echo "Python dev mode tmux session already exists. Attaching to it."
    sleep 1
    tmux attach-session -t $PYTHON_SESSION

}

############ run script ################

# if session already exists attach to it, else create it
if [ "$PYTHON_SESSION" = "python" ];
then
    enter_python_workflow
else
    create_python_workflow
fi
