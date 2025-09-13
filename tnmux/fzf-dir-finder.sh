#!/bin/bash

# Получаем ID панели, в которую нужно отправить команду, из аргументов скрипта
TARGET_PANE_ID="$1"

# Ищем директории, начиная с домашней, и передаем в fzf
# Используем find ... -print0 | fzf --read0 для корректной работы с пробелами
selected_dir=$(find ~ -type d -print0 2>/dev/null | fzf --read0)

# Если директория была выбрана (т.е. строка не пустая)
if [[ -n "$selected_dir" ]]; then
    # Отправляем команду cd в целевую панель, затем очищаем экран
    tmux send-keys -t "$TARGET_PANE_ID" "cd \"$selected_dir\" && clear" C-m
else
    # Если ничего не выбрано или fzf не сработал, ждем 5 секунд для отладки
    echo "No directory selected or fzf failed. Press Enter to close."
    read -p "" -t 5
fi