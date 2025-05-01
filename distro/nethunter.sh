DISTRO_NAME="Nethunter Minimal"
DISTRO_COMMENT="Rolling Release (2024.2)."

TARBALL_URL['aarch64']="https://kali.download/nethunter-images/kali-2025.1a/rootfs/kali-nethunter-rootfs-minimal-arm64.tar.xz"
TARBALL_SHA256['aarch64']="7bfb05c8b29813932f09999c9ad32d6b0aa0ca40667c2d1c926ecf0c3ed3c51e"
TARBALL_URL['arm']="https://kali.download/nethunter-images/kali-2025.1a/rootfs/kali-nethunter-rootfs-minimal-armhf.tar.xz"
TARBALL_SHA256['arm']="f424766aa5371f6a9588380c95ea9b16dffcdb39b0ab1f3630fdd613fa2ebbf3"
TARBALL_URL['i386']="https://kali.download/nethunter-images/kali-2025.1a/rootfs/kali-nethunter-rootfs-minimal-i386.tar.xz"
TARBALL_SHA256['i3686']="28291729a01d30a4bd02feb65c4365978a02e4752f936fb9dd26a1507652a429"

distro_setup() {
        # Set default shell to bash.
        run_proot_cmd usermod --shell /bin/bash root

        # Configure en_US.UTF-8 locale.
        sed -i -E 's/#[[:space:]]?(en_US.UTF-8[[:space:]]+UTF-8)/\1/g' ./etc/locale.gen
        run_proot_cmd DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

        # Buat direktori mount
        mkdir -p ./mnt/termux/bin
        mkdir -p ./mnt/termux/shared

        # Buat skrip untuk mount storage dan PATH Termux
        cat > ./etc/profile.d/termux-mount.sh <<- EOM
#!/bin/bash
if [ -d /host-rootfs/data/data/com.termux/files/home/bin ]; then
    mount --bind /host-rootfs/data/data/com.termux/files/home/bin /mnt/termux/bin
    export PATH="/mnt/termux/bin:\\$PATH"
fi

if [ -d /host-rootfs/data/data/com.termux/files/home/storage/shared ]; then
    mount --bind /host-rootfs/data/data/com.termux/files/home/storage/shared /mnt/termux/shared
fi
EOM

        chmod +x ./etc/profile.d/termux-mount.sh

proot-distro login nethunter  export PATH=$PATH:/data/data/com.termux/files/usr/bin
}
