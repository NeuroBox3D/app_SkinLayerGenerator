--[[!
-- \file skin_layer_generator.lua
-- \brief generate skin layers
-- \author stephan grein <grein@temple.edu>
--]]

--------------------------------------------------------------------------------
-- Simulation setup
--------------------------------------------------------------------------------
SetOutputProfileStats(false)
ug_load_script("ug_util.lua")
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Mesh specifications (default parameters)
--------------------------------------------------------------------------------
radius   = util.GetParamNumber("-radius", 1)
center   = util.GetParam("-center", "(0, 0, 0)")
numVerts = util.GetParamNumber("-verts", 12)

--------------------------------------------------------------------------------
-- ug specifics
--------------------------------------------------------------------------------
InitUG(3, AlgebraType("CPU", 1));
AssertPluginsLoaded({"SkinLayerGenerator", "ProMesh"})

--------------------------------------------------------------------------------
-- mesh generation (different setups)
--------------------------------------------------------------------------------
setup="SECOND"
slg = SkinLayerGenerator()
--- select setup
if (setup == "FIRST") then
  slg:add_layer(6, 0.5, "Layer 1 (SSSC)")
  slg:add_layer(2, 0.5, "Layer 2 (SSC)")
  slg:add_layer_with_injection(4, 0.5, "Layer 3 (SC)", "Depot", 1, 0.1, 0.6, true)
  slg:add_layer(4, 0.5, "Layer 4 (ED)")
  slg:add_layer(0.2, 0.1, "Layer 5 (CZ)")
  slg:add_layer(0.5, 0.25, "Layer 6 (SCZ)")
elseif (setup == "SECOND") then
  slg:add_layer_with_injection(10, 0.5, "Layer 1 (SC)", "Depot", 1, 0.1, 0.5, true)
  slg:add_layer(2, 0.5, "Layer 2 (ED)")
  slg:add_layer(0.5, 0.5, "Layer 3 (Top")
else
  error("Wrong setup selected, only FIRST and SECOND are available.")
end
--- generate
slg:generate()
