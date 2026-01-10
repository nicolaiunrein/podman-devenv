FROM alpine

RUN apk add \
  zsh \
  neovim \
  ripgrep \
  yq \
  jq \
  starship 


RUN apk add \
  zoxide \
  curl \
  git


ENV EDITOR=nvim
ENV SHELL=zsh
ENV ZINIT_HOME="/root/.config/zinit"

RUN mkdir -p $(dirname $ZINIT_HOME) && \
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"

RUN git clone https://github.com/jeffreytse/zsh-vi-mode.git /root/.config/zsh-vi-mode

RUN apk add fzf

COPY ./config /root/.config

RUN ln -s ~/.config/zshrc ~/.zshrc
RUN ln -s ~/.config/gitconfig ~/.gitconfig


CMD ["zsh"]
