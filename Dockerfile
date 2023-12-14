FROM debian:sid
RUN apt update
RUN useradd -m -u 1000 user
RUN apt install xfce4-terminal lxde aqemu sudo curl wget aria2 qemu-system-x86 htop chromium screen tigervnc-standalone-server python3-pip python3-websockify python3 git -y
RUN git clone https://github.com/novnc/noVNC.git noVNC
ARG VNC_PWD
RUN mkdir -p /root/.vnc /home/user/.vnc
RUN echo $VNC_PWD | vncpasswd -f > /root/.vnc/passwd
RUN echo $VNC_PWD | vncpasswd -f > /home/user/.vnc/passwd
RUN chmod -R a+rw /root/.vnc /home/user/.vnc
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH
CMD vncserver -SecurityTypes None -geometry 1366x768 && ./noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 0.0.0.0:7860