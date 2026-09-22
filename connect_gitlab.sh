#!/bin/bash

cd "/c/demo/myTools/DateTimeComponent.4dbase"

# Ajouter le remote GitLab
git remote remove origin 2>/dev/null
git remote add origin https://gitlab.com/fmainguene-group/datetime-4d.git

# Récupérer les branches depuis GitLab
git fetch origin

# Configurer la branche locale
git branch -u origin/main main 2>/dev/null

echo "Dépôt connecté à GitLab avec succès."
git remote -v