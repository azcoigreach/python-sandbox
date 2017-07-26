FROM debian:jessie

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y openssh-server \
	supervisor \
	htop \
	nano
	
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

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
	wordcloud \
	pandas \
	pandas-datareader \
	pgpy \
	numpy


# SET ROOT PASSWORD 
RUN echo 'root:screencast' | chpasswd && \
  mkdir /var/run/sshd && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config && \
    sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    mkdir /root/.ssh
 
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
RUN echo 'export LANG="en_US.UTF-8"' >> /etc/profile
 
EXPOSE 22
CMD ["/usr/bin/supervisord"]
	
