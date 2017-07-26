FROM resin/rpi-raspbian:latest

RUN apt-get update && apt-get install \
	python \
	python-dev \
	python-pip \
	python-requests \
	python-scrapy \
	python-pillow \
	ipython 
	
	
RUN pip install \
	pushbullet.py \
	feedparser \
	beautifulsoup \
	twisted \
	numpy \
	plotly \
#	scipy \
	matplotlib \
	plyer \
	chatterbot

CMD /bin/bash
	
