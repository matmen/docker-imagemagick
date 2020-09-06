FROM phusion/baseimage:18.04-1.0.0

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /usr/local/src

RUN apt-get update && \
	apt-get install -y \
	build-essential \
	autoconf \
	ca-certificates \
	libc-dev \
	pkg-config \
	libmagickwand-dev \
	git \
	wget \
	libjpeg-dev \
	libpng-dev \
	libtiff-dev \
	libgif-dev

RUN wget -q https://github.com/webmproject/libwebp/archive/v1.0.0.tar.gz -O WEBP.tar.gz && \
	mkdir WEBP && \
	tar zxf WEBP.tar.gz -C WEBP --strip-components=1 && \
	rm WEBP.tar.gz && \
	( cd WEBP && \
	./autogen.sh && \
	./configure && \
	make && \
	make install ) && \
	rm -rf ./WEBP/

RUN git clone --depth 1 https://github.com/ImageMagick/ImageMagick.git ImageMagick && \
	( cd ImageMagick && \
	./configure && \
	make && \
	make install && \
	ldconfig /usr/local/lib ) && \
	rm -rf ./ImageMagick/ && \
	apt-get clean
