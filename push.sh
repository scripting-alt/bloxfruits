#!/bin/bash

read -p "Mensagem do commit: " msg

git add .
git commit -m "$msg"
git push