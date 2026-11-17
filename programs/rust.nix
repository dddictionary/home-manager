{ pkgs, ... }:

{
  # rustup manages toolchains in ~/.rustup (rust-toolchain.toml, nightly,
  # extra targets). After a fresh install, run once:
  #   rustup default stable && rustup component add rust-analyzer
  # Keep RUSTUP_HOME at its default: on Shopify Macs, Santa (Lockdown) kills
  # rustup-downloaded toolchains outside ~/.rustup.
  # World zones provide their own pinned toolchain via `dev up`.
  home.packages = [ pkgs.rustup ];

  # Binaries from `cargo install`.
  home.sessionPath = [ "$HOME/.cargo/bin" ];
}
