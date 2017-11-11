# Git

## git merge
git merge 当merge的分支发生变化，但本地没有变化的时候，不会创建新的commit
git merge 当两个分支都发生变化，且没有发生冲突的时候，会自动创建一个merge-commit
git merge 当两个分支都发生变化，且发生了冲突的时候，需要手动解决冲突后创建commit

## git rebase
https://git-scm.com/docs/git-rebase
git rebase 会将合并分支的新的 commits 放置在当前分支的 commits 之前