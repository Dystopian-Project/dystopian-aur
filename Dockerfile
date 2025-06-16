FROM archlinux:latest

LABEL net.dcxdev.dystopian.author="DCx7c5 <dcxdevelopment@protonmail.com>"
LABEL net.dcxdev.dystopian.aur_repo=true
LABEL net.dcxdev.dystopian.service=aur_repo
LABEL net.dcxdev.dystopian.host=aur.dystopian.dcxdev.net

ARG USER=$USER
ENV USER=$USER
ENV TERM=xterm-256color

RUN pacman -Syuq --noconfirm  --noprogressbar --ignore linux --ignore linux-firmware --needed base-devel  \
    devtools \
    dbus \
    sudo \
    libsodium \
    libevdev \
    bzip2 \
    expat \
    gdbm  \
    libffi \
    libnsl \
    libxcrypt \
    libzip \
    openssl \
    zlib \
    tzdata \
    mpdecimal \
    ccache \
    python \
    git \
    && rm -rf /var/lib/pacman/sync/*

COPY --chmod=750 entrypoint.sh /entrypoint.sh

RUN dbus-uuidgen --ensure=/etc/machine-id \
    && groupadd $USER \
    && useradd -m -g $USER -s /bin/bash -r $USER \
    && usermod -aG wheel $USER \
    && echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/wheel

USER $USER:$USER

WORKDIR /project/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/bin/bash"]
