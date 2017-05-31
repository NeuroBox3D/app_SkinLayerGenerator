--[[!
-- \file skin_layer_generator.lua script 
-- \brief generate skin layers - in case of questions:
-- \author stephan grein <grein@temple.edu>
--]]

--------------------------------------------------------------------------------
-- ug specific settings
--------------------------------------------------------------------------------
SetOutputProfileStats(false)
ug_load_script("ug_util.lua")
InitUG(3, AlgebraType("CPU", 1));
AssertPluginsLoaded({"SkinLayerGenerator", "ProMesh"})
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- mesh settings
-- radius: base radius of cylindrical section
-- center: center of cylinder base
-- numVerts: number of vertices
-- setup: choose between two pre-defined skin sections
--
--------------------------------------------------------------------------------
radius   = util.GetParamNumber("-radius", 1)
center   = util.GetParam("-center", "(0, 0, 0)")
numVerts = util.GetParamNumber("-verts", 12)
setup    = util.GetParam("-setup", "FIRST")

--------------------------------------------------------------------------------
-- add skin layers 
--------------------------------------------------------------------------------
slg = SkinLayerGenerator()
if (setup == "FIRST") then
  slg:add_layer(6, 0.5, "Layer 1 (SSSC)")
  slg:add_layer(2, 0.5, "Layer 2 (SSC)")
  slg:add_layer_with_injection(4, 0.5, "Layer 3 (SC)", "Depot", 1, 0.1, 0.6)
  slg:add_layer(4, 0.5, "Layer 4 (ED)")
  slg:add_layer(0.2, 0.1, "Layer 5 (CZ)")
  slg:add_layer(0.5, 0.25, "Layer 6 (SCZ)")
elseif (setup == "SECOND") then
  slg:add_layer_with_injection(10, 0.5, "Layer 1 (SC)", "Depot", 1, 0.1, 0.6)
  slg:add_layer(2, 0.5, "Layer 2 (ED)")
  slg:add_layer(0.5, 0.5, "Layer 3 (Top)")
else
  error("Unknown (pre-defined) setup selected. Was: " .. setup)
end

--------------------------------------------------------------------------------
-- generate and export mesh
--------------------------------------------------------------------------------
slg:generate()
