FROM debian:sid
RUN apt update
RUN apt install -y vim bash xfce4-terminal mate-desktop-environment-extras aqemu sudo curl wget aria2 qemu-system-x86 htop chromium screen tigervnc-standalone-server python3-pip python3-websockify python3 git fuse libfuse2 xdotool
RUN apt remove -y lxlock
RUN apt remove -y light-locker xscreensaver-data xscreensaver
RUN useradd -d /home/user -s /bin/bash -m -u 1000 user
RUN chown user -R /home/user; echo "cd ~" > /home/user/.bashrc;
RUN chown root:shadow /etc/shadow; chmod u=r,g=r /etc/shadow;
RUN chmod 2755 /sbin/unix_chkpwd || echo "文件不存在，无视"
RUN sed -i '/@xscreensaver -no-splash/d' /etc/xdg/lxsession/LXDE/autostart || echo "配置不存在，无视"
RUN git clone https://github.com/novnc/noVNC.git noVNC
RUN mkdir -p /home/user/.vnc
RUN chmod -R 777 /home/user/.vnc /tmp
ARG VNC_RESOLUTION
RUN --mount=type=secret,id=VNC_PASSWORD,mode=0444,required=true \
   echo 'user:$(cat /run/secrets/VNC_PASSWORD)' | chpasswd && \
   cat /run/secrets/VNC_PASSWORD | vncpasswd -f > /home/user/.vnc/passwd
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH
CMD vncserver -SecurityTypes VncAuth -rfbauth /home/user/.vnc/passwd -geometry $VNC_RESOLUTION && ./noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 0.0.0.0:7860