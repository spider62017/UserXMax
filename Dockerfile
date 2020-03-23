# We're using Alpine Edge
FROM alpine:edge

# We have to uncomment Community repo for some packages
RUN sed -e 's;^#http\(.*\)/edge/community;http\1/edge/community;g' -i /etc/apk/repositories

# install ca-certificates so that HTTPS works consistently
# other runtime dependencies for Python are installed later
RUN apk add --no-cache ca-certificates
RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

# Installing Packages
RUN apk add --no-cache --update \
    bash \
    build-base \
    bzip2-dev \
    curl \
    coreutils \
    figlet \
    gcc \
    g++ \
    git \
    aria2 \
    util-linux \
    libevent \
    libjpeg-turbo-dev \
    jpeg-dev \
    jpeg \
    libc-dev \
    libffi-dev \
    libpq \
    libwebp-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    musl-dev \
    neofetch \
    openssl-dev \
    postgresql \
    postgresql-client \
    postgresql-dev \
    openssl \
    pv \
    jq \
    wget \
    python \
    python-dev \
    python3 \
    python3-dev \
    readline-dev \
    ffmpeg \
    figlet \
    sqlite-dev \
    sudo \
    chromium \
    chromium-chromedriver \
    zlib-dev \
    zip \
    megatools \
    nodejs \
    freetype-dev


RUN curl https://cli-assets.heroku.com/install.sh | sh


RUN python3 -m ensurepip \
    && pip3 install --upgrade pip setuptools \
    && rm -r /usr/lib/python*/ensurepip && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
    rm -r /root/.cache

#
# Clone repo and prepare working directory
#
RUN git clone 'https://github.com/HitaloSama/TG-UBotX.git' /root/userbot
RUN mkdir /root/userbot/bin/
WORKDIR /root/userbot/

#
# Copies session and config (if it exists)
#
COPY ./sample_config.env ./userbot.session* ./config.env* /root/userbot/

#
# Install requirements
#
RUN pip3 install -r requirements.txt --upgrade
CMD ["python3","-m","userbot"]
