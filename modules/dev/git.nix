# Git itself. Identity is per-user, so it lives in modules/users/.
{
  flake.modules.nixos.git = {
    programs.git.enable = true;
  };
}
