class CfgPatches 
{
	class FA_mineDetector
	{
		units[] = {};
		weapons[] = {};
		requiredAddons[] = {"a3_sounds_f",
      "a3_sounds_f_bootcamp",
      "a3_sounds_f_epb",
      "a3_sounds_f_epc",
      "cba_xeh",
      "extended_eventhandlers",
      "cba_extended_eventhandlers"};
		requiredVersion = 0.1;
		author[] = {"Wolfenswan"};
		authorUrl = "wwww.folkarps.com";
	};
};

class Extended_PostInit_EventHandlers
{
  FA_mineDetectorInit = "[] execVM 'FA_minedetector\init.sqf';";
};

class CfgFunctions
{ 
  class FA
  {
    class functions {
      class minedetector  {file = "FA_minedetector\fn_mineDetectorLoop.sqf";};
    };
  };
};