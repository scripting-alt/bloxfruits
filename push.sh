#!/bin/bash

read -p "Mensagem do commit: " msg

git add .

if git diff --cached --quiet; then
    echo "Nenhuma alteração para commit."
    exit 0
fi

git commit -m "$msg" && git push