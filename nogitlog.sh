git checkout --orphan temp_branch

git add -A

git commit -am "purged commits"

git branch -D main

git branch -m main

git push -f origin main