local git = { url = "https://github.com/" }
function git.available() return vim.fn.executable "git" == 1 end

function git.git_version()
  local output = git.cmd({ "--version" }, false)
  if output then
    local version_str = output:match "%d+%.%d+%.%d"
    local major, min, patch = unpack(vim.tbl_map(tonumber, vim.split(version_str, "%.")))
    return { major = major, min = min, patch = patch, str = version_str }
  end
end

return git
