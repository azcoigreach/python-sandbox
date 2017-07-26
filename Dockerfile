FROM debian:jessie

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y \
	python \
	python-dev \
	python-pip \
	python-requests \
	python-scrapy \
	python-pillow \
	ipython 
		
RUN pip install \
	pushbullet.py \
	tweepy \
	psutil \
	evernote \
	webapp
	
RUN apt-get install -y \
	nano \
	htop

CMD /bin/bash
	
