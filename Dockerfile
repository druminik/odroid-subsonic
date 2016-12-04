FROM druminik/odroid-java

MAINTAINER dominik_l@gmx.net

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    apt-get update && \
    apt-get install -y wget &&\ 
    apt-get clean &&\
    cd /tmp &&\
    wget --quiet http://subsonic.org/download/subsonic-6.0.deb &&\
    dpkg -i /tmp/subsonic-6.0.deb && rm -f /tmp/*.deb &&\
    ln /var/subsonic/transcode/ffmpeg /var/subsonic/transcode/lame /usr/local/bin

RUN mkdir /var/music /var/playlists /var/podcasts

# Create hardlinks to the transcoding binaries.
# This way we can mount a volume over /var/subsonic.
# Apparently, Subsonic does not accept paths in the Transcoding settings.
# If you mount a volume over /var/subsonic, create symlinks
# <host-dir>/var/subsonic/transcode/ffmpeg -> /usr/local/bin/ffmpeg
# <host-dir>/var/subsonic/transcode/lame -> /usr/local/bin/lame

VOLUME /var/subsonic

COPY startup.sh /startup.sh

EXPOSE 4040

CMD []
ENTRYPOINT ["/startup.sh"]
