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
-- Mesh specifications
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
-- mesh generation
--------------------------------------------------------------------------------
slg = SkinLayerGenerator()
slg:generate()
