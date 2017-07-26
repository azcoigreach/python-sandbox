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
	
	
RUN pip install -y \
	pushbullet.py \
	feedparser \
	beautifulsoup4 \
	twisted \
	numpy \
	plotly \
#	scipy \
	matplotlib \
	plyer \
	chatterbot \
	tweepy \
	wordcloud \
	psutil \
	progressbar2 \
	pandas \
	pandas-datareader \
	onlykey \
	evernote \
	cryptography
	

CMD /bin/bash
	
