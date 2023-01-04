-- This module contains defaults for substitutions
-- hanlders get a config table with the following spec
-- config = {
--   filename  = <absolute path of buffer file>,
--   author    = <name provided in 'author' in setup config>,
--   namespace = <ns provided in 'namespace' in setukp config>,
--   <inserts any user defined config in here>
-- }

local Utils = require("skel-nvim.utils")
local M = {}


function M.get_filename(cfg)
  return vim.fs.basename(cfg.filename)
end

function M.get_author(cfg)
  return cfg.author
end

function M.get_date(cfg)
  return os.date("%x")
end

-- cpp speficifics

-- given filename: "test.h" -> "TEST_H"
function M.get_cppheaderguard(cfg)
  local name, _, _ = Utils.get_basename_parts(cfg.filename)
  return string.gsub(name:upper(), "%.", "_")
end

-- given filename: "test.t.h" -> "TEST_T_H"
function M.get_testheaderguard(cfg)
  local name, _, _ = Utils.get_basename_parts(cfg.filename)
  return string.gsub(name:upper(), "%.", "_")
end

-- given filename: test.cpp, --> #include <testh.h>
function M.get_headerinclude(cfg)
  local _, base, _ = Utils.get_basename_parts(cfg.filename)
  return "#include <"..base..".h>"
end

-- given filename: test.cpp, --> #include "testh.h"
function M.get_headerinclude_quote(cfg)
  local _, base, _ = Utils.get_basename_parts(cfg.filename)
  return '#include "'..base..'.h"'
end

-- given filename: test.cpp -> Test
function M.get_classname(cfg)
  local _, base, _ = Utils.get_basename_parts(cfg.filename)
  return Utils.title_case(base)
end

-- given filename: app_xyz_test.cpp -> Test
function M.get_classname2(cfg)
  local _, base, _ = Utils.get_basename_parts(cfg.filename)
  if base:find("_") ~= nil then
      -- strip all leading <word>_
      base = base:match(".*_([^_]*)$")
  end
  return Utils.title_case(base)
end

-- given namespace: {"org", "app"}, yields
-- namespace org {
-- namespace app {
function M.get_namespaceopen(cfg)
  local ns = cfg.namespace
  local width = Utils.max_len(ns)
  local lines = {}
  for _, v in ipairs(ns) do
    lines[#lines + 1] = string.format("namespace %-"..width.."s {",v)
  end
  return lines
end

-- given namespace: {"org", "app"}, yields
-- } // namespace app
-- } // namespace org
function M.get_namespaceclose(cfg)
  local ns = cfg.namespace
  local lines = {}
  for i = #ns, 1, -1 do
    lines[#lines + 1] = string.format("} // namespace %s",ns[i])
  end
  return lines
end




return M
