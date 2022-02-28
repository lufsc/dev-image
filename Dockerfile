FROM archlinux:base-devel

RUN pacman-key --init && \
    pacman -Suy --noconfirm sudo

COPY sudoers /etc/sudoers
COPY dotfiles /etc/skel/dotfiles
COPY dotfiles /root/dotfiles

RUN /root/dotfiles/install.sh ~ && \
    groupadd sudo && \
    useradd -mUG sudo -p resu user

USER user
WORKDIR /home/user
COPY dotfiles dotfiles
RUN dotfiles/install.sh ~

ENTRYPOINT [ "/bin/zsh" ]
