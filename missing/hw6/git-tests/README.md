# Git-practice

For testing:

git filter-branch

```shell
git filter-branch --force --index-filter \
  "git rm --cached --ignore-unmatch PATH-TO-YOUR-FILE-WITH-SENSITIVE-DATA" \
  --prune-empty --tag-name-filter cat -- --all

this command will delete the file both locally and remotely
```



git rm

```shell
git rm --cached <filename>
git rm --cached -r <dir_name>
git commit -m "Removed folder from repository"
git push origin main

this command will only delete the remote file
```



BFG Repo-Cleaner

```shell
bfg --delete-files YOUR-FILE-WITH-SENSITIVE-DATA
```

