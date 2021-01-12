FROM archlinux

RUN pacman --noconfirm -Syu

RUN pacman --noconfirm -S sudo base base-devel enchant libedit libmcrypt libzip libxslt git

RUN useradd -m -G wheel -s /bin/bash -d /home/builder builder

RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    sed -i -e 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j12"/g' -e 's/-march=x86-64 -mtune=generic/-march=native/' -e 's/xz -c -z/xz -c -z -T 4/' /etc/makepkg.conf

USER builder

RUN mkdir /home/builder/makepkg && chown -R builder.builder /home/builder

VOLUME /home/builder/makepkg
WORKDIR /home/builder/makepkg

ENTRYPOINT '/bin/bash'
CMD ['build.sh']