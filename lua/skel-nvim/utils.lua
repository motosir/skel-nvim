local M = {}

function M.get_basename_parts(filename)
  local basename = vim.fs.basename(filename)
  local base, extensions = string.match(basename, "([^.]+)(.*)")
  return basename, base, extensions
end


function M.title_case(str)
 return str:gsub("%a", string.upper, 1)
end

function M.max_len(array)
  local max = 0
  for _, v in ipairs(array) do
    if #v > max then max = #v end
  end
  return max
end

function M.fileexists(filepath)
  local f=io.open(filepath, "r")
  if f ~= nil then io.close(f) return true else return false end
end

-- get table size
function M.size(tbl)
  local count = 0
  if tbl == nil then return count end
  for _,_ in pairs(tbl) do
    count = count + 1
  end
  return count
end

return M
