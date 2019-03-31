touch kw-time.csv
for
  git log --follow --format=%ai -- Uhlmann\,\ 2017.\ Arabic\ Instruction\ in\ Israel.md | tail -1
end for
