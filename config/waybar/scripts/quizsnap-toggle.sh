#!/bin/bash
# Toggle entre waybar normal y waybar con QuizSnap

QUIZ_CONFIG="$HOME/.config/waybar/config-quiz"
QUIZ_STYLE="$HOME/.config/waybar/style-quiz.css"
CACHE="$HOME/.cache/quizsnap/result.json"
PYTHON="$HOME/.config/quizsnap/.venv/bin/python"
SCAN="$HOME/.config/quizsnap/quizsnap_scan.py"
CLIP="$HOME/.config/quizsnap/quizsnap_clipboard.py"

_bind_quiz() {
    hyprctl keyword bind "CTRL SHIFT, S, exec, $PYTHON $SCAN"
    hyprctl keyword bind "CTRL SHIFT, C, exec, $PYTHON $CLIP"
}

_unbind_quiz() {
    hyprctl keyword unbind "CTRL SHIFT, S"
    hyprctl keyword unbind "CTRL SHIFT, C"
}

_waybar_normal() {
    pkill waybar
    rm -f "$CACHE"
    _unbind_quiz
    waybar &
}

if pgrep -f "config-quiz" > /dev/null 2>&1; then
    _waybar_normal
else
    pkill waybar
    waybar -c "$QUIZ_CONFIG" -s "$QUIZ_STYLE" &
    _bind_quiz
fi
