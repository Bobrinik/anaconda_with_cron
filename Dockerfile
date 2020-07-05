FROM continuumio/anaconda3:latest

RUN useradd -m john \
    && /opt/conda/bin/conda install jupyter -y --quiet \
    && mkdir /opt/notebooks

COPY cron_schedule /etc/cron.d/cron_schedule
COPY /notebooks /opt/notebooks

RUN apt-get update \
    && apt install -y --no-install-recommends curl wget unzip cron vim procps sudo \
    && conda config --add channels conda-forge \
    && conda install twilio requests nbconvert\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/log/* \
    && adduser john sudo && echo "john ALL = (root) NOPASSWD: /usr/sbin/cron" >> /etc/sudoers.d/cron \
    && chown -R john /opt/notebooks \
    && chmod 644 /etc/cron.d/cron_schedule \
    && crontab /etc/cron.d/cron_schedule


USER john

COPY start.sh start.sh

CMD ["./start.sh"]