{ unstablePkgs, ... }:

{
  home.packages = with unstablePkgs; [
    colima
  ];
}
