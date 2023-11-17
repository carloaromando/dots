{
  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "$HOME/.password-store";
      PASSWORD_STORE_SIGNING_KEY = "032746AC6169C8B56D78744AFD7A0F3C40B44177";
    };
  };
}
