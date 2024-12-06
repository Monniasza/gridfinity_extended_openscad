// include instead of use, so we get the pitch
include <../modules/gridfinity_constants.scad>
include <../modules/functions_general.scad>
use <../modules/module_gridfinity_baseplate.scad>

scenario = "demo"; //["demo","baseplate","magnet","weighted", "lid","lid_flat_base","lid_half_pitch","customsize"]
showtext = true;

//Include help info in the logs
help=false;
setViewPort=true;

$vpr = setViewPort ? [60,0,320] : $vpr;
$vpt = setViewPort ? [32,13,16] : $vpt; //shows translation (i.e. won't be affected by rotate and zoom)
$vpf = setViewPort ? 25 : $vpf; //shows the FOV (Field of View) of the view [Note: Requires version 2021.01]
$vpd = setViewPort ? 280 : $vpd;//shows the camera distance [Note: Requires version 2015.03]
     
     
//Array index
iwidth = 0;
idepth = 1;
ioversizeMethod=2;
iplateStyle = 3;
iplateOptions = 4;
ilidOptions = 5;
icustomGridEnabled = 6;
igridPositions=7;
icutx = 8;
icuty = 9;
  
  //Basic cup default settings for demo
defaultDemoSetting = 
    //width, depth, iplateStyle, iplateOptions, ilidOptions, 
    [3,2,"fill","base","default","",
    //icustomGridEnabled,igridPositions,cutx,cuty
    false,"",0,0];
     
selectedScenario = 
  scenario == "demo" ? [["Base Plate", 12,[]],
      ["Simple", false,[[iplateStyle, "base"], [iplateOptions, ""]]],
      ["Efficient Magnet", false,[[iplateStyle, "base"], [iplateOptions, "magnet"]]],
      ["Weighted", false,[[iplateStyle, "base"], [iplateOptions, "weighted"]]],
      ["Woodscrew", false,[[iplateStyle, "base"], [iplateOptions, "woodscrew"]]],
      ["CNC or Laser cut", false,[[iplateStyle, "base"], [iplateOptions, "cnc"]]],
      ["CNC cut with Magnet", false,[[iplateStyle, "base"], [iplateOptions, "cncmagnet"]]],
      ["Lid", false,[[iplateStyle, "lid"], [iplateOptions, ""]]],
      ["Lid Flat Base", false,[[iplateStyle, "lid"], [ilidOptions,"flat"]]],
      ["Lid Half Pitch", false,[[iplateStyle, "lid"], [ilidOptions,"halfpitch"]]],
      ["Simple - fill", false,[[iwidth,3.5], [idepth,2.2], [iplateStyle, "base"], [iplateOptions, ""]]],
      ["CNC - crop", false,[[iwidth,3.5], [idepth,2.2], [iplateStyle, "base"], [iplateOptions, "cnc"], [ioversizeMethod,"crop"]]],
      ["Custom",false,[[iplateOptions,"default"],[icustomGridEnabled,true],
          [igridPositions,"3,4,0,0|2,2,0,0|2,2,2,0|6,2,2,0"]]]]
      
  : scenario == "baseplate" ? [["", 1,[[iplateStyle, "base"]]],
      ["Base Plate", false,[[iplateStyle, "default"],[iplateOptions,""]]]]
      
  : scenario == "magnet" ? [["Magnet",4,[[iplateStyle, "base"], [iplateOptions,"magnet"]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]
      
  : scenario == "weighted" ? [["Weighted",4,[[iplateStyle, "base"], [iplateOptions,"weighted"]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]
      
  : scenario == "lid" ? [["Lid",4,[[iplateStyle, "lid"], [iplateOptions,""], [ilidOptions,"default"]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]
      
  : scenario == "lid_flat_base" ? [["Lid flat base",4,[[iplateStyle, "lid"], [iplateOptions,""], [ilidOptions,"flat"]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]

  : scenario == "lid_half_pitch" ? [["Lid half pitch",4,[[iplateStyle, "lid"], [iplateOptions,""], [ilidOptions,"halfpitch"]]],
      ["",false,[[icuty,false]]],
      ["",false,[[icuty,true]]],
      ["bottom",true,[[icuty,false]]],
      ["bottom",true,[[icuty,true]]]]

  : scenario == "customsize" ? [["Custom Size",3,[[iplateStyle, "base"], [ilidOptions,"halfpitch"]]],
      ["Base",false,[[iplateOptions,"default"],[icustomGridEnabled,true],
          [igridPositions,"3,4,0,0|2,2,0,0|2,2,2,0|6,2,2,0"]]],
      ["Magnet",false,[[iplateOptions,"magnet"],[icustomGridEnabled,true],
          [igridPositions,"3,4,0,0|2,2,0,0|6,2,2,2|0,6,2,2"]]],
      ["Weighted",false,[[iplateOptions,"weighted"],[icustomGridEnabled,true],
          [igridPositions,"3,4,0,0|2,2,0,5|6,2,2,2|0,6,2,2|0,0,6,10"]]]]
      : []; //
      
//animation = len(options) >= round($t*(len(options))) ? options[round($t*(len(options)))] : options[0];
//echo(time=$t*(len(options)), options = len(options), t=$t, animation=animation);

scenarioDefaults = selectedScenario[0];
animationStep = len(selectedScenario) >= round($t*(len(selectedScenario)-1)) ? selectedScenario[min(round($t*(len(selectedScenario)-1))+1,len(selectedScenario)-1)] : selectedScenario[1];  
currentStepSettings = replace_Items(concat(scenarioDefaults[2],animationStep[2]), defaultDemoSetting);

echo(defaultDemoSetting=defaultDemoSetting);
echo("🟧gridfinity_baseplate",scenario = scenario, steps=len(selectedScenario)-1, t=$t, time=$t*(len(selectedScenario)-1));
echo(animationStep=animationStep);
echo(currentStepSettings=currentStepSettings);

if(showtext)
color("GhostWhite")
translate($vpt)
rotate($vpr)
translate([0,-40,60])
 linear_extrude(height = 0.1)
 text(str(scenarioDefaults[0], " - ", animationStep[0]), size=5, valign = "center", halign = "center");

if(scenarioDefaults[0] != "unknown scenario")
rotate(animationStep[1] ? [180,0,0] : [0,0,0]) 
translate(animationStep[1] ? [0,-gf_pitch,0] : [0,0,0])
gridfinity_baseplate(
  num_x = currentStepSettings[iwidth],
  num_y = currentStepSettings[idepth],
  oversizeMethod = currentStepSettings[ioversizeMethod],
  plateStyle = currentStepSettings[iplateStyle],
  plateOptions = currentStepSettings[iplateOptions],
  lidOptions = currentStepSettings[ilidOptions],
  customGridEnabled = currentStepSettings[icustomGridEnabled],
  gridPositions=currentStepSettings[icustomGridEnabled] ? splitCustomConfig(currentStepSettings[igridPositions]) : [],
  cutx = currentStepSettings[icutx],
  cuty = currentStepSettings[icuty]);