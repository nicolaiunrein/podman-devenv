FROM alpine

RUN apk add rustup

RUN rustup-init -y

ENV PATH="$PATH:/root/.cargo/bin"

RUN rustup default nightly

RUN apk add build-base curl bash

RUN curl -L --proto '=https' --tlsv1.2 -sSf https://raw.githubusercontent.com/cargo-bins/cargo-binstall/main/install-from-binstall-release.sh | bash


RUN apk add \
  curl \
  fzf \
  git \
  jq \
  neovim \
  ripgrep \
  tmux \
  yq \
  zoxide \
  zsh \
  zsh-vcs \
  stow \
  ;


ENV EDITOR=nvim
ENV SHELL=zsh
ENV HOME=/root
ENV TERM=screen-256color

WORKDIR /root

RUN mkdir -p /root/config/common
RUN git clone https://github.com/jeffreytse/zsh-vi-mode.git .zsh-vi-mode

RUN rustup component add rust-analyzer

RUN apk add tree-sitter-cli
RUN apk add neovim-doc

COPY ./home /root/config
RUN mv .zsh-vi-mode /root/config/common
RUN cd /root/config && stow common && stow nvim

# RUN ln -sf /src/nvim/.config /root/.config
# RUN ln -s ~/.config/zshrc ~/.zshrc
# RUN ln -s ~/.config/gitconfig ~/.gitconfig
# RUN ln -s ~/.config/.tmux.conf ~/.tmux.conf
RUN nvim --headless +qa

CMD ["zsh"]
