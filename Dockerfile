FROM continuumio/anaconda3:latest

RUN useradd -m john \
    && /opt/conda/bin/conda install jupyter -y --quiet \
    && mkdir /opt/notebooks

RUN apt-get update \
    && apt install -y --no-install-recommends curl wget unzip cron vim procps sudo \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/* \
    && adduser john sudo && echo "john ALL = (root) NOPASSWD: /usr/sbin/cron" >> /etc/sudoers.d/cron

USER john

COPY start.sh start.sh

CMD ["./start.sh"]