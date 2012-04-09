#!/bin/bash
# Запуск|открытие сессии tmux при старте zsh

tmux new-session -d -s work # Создание сессии

tmux new-window -t work:1 # Новое окно
tmux new-window -t work:2 # Второе новое окно
tmux new-window -t work:3 # Третье новое окно

tmux send-keys -t work:1 'htop' C-m # Открываем в первом окне htop
tmux send-keys -t work:2 'watch -n5 who' C-m # Открываем watch -n5 who во второй вкладке

tmux select-window -t work:1 # Открываем первое окно
tmux split-window -h # Горизонтальный сплит
tmux clock # Открываем часы в только что разделенной части
tmux split-window -v # Вертикальный сплит

tmux -2 attach-session -t work # Открываем сессию
