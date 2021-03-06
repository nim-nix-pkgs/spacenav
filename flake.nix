{
  description = ''Bindings for libspnav, the free 3Dconnexion device driver'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs."spacenav-master".dir   = "master";
  inputs."spacenav-master".owner = "nim-nix-pkgs";
  inputs."spacenav-master".ref   = "master";
  inputs."spacenav-master".repo  = "spacenav";
  inputs."spacenav-master".type  = "github";
  inputs."spacenav-master".inputs.nixpkgs.follows = "nixpkgs";
  inputs."spacenav-master".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@inputs:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib"];
  in lib.mkProjectOutput {
    inherit self nixpkgs;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
    refs = builtins.removeAttrs inputs args;
  };
}