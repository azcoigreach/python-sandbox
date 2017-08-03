FROM debian:jessie

RUN apt-get update

RUN apt-get install -y openssh-server \
	supervisor \
	htop \
	nano \
	curl \
	apt-transport-https
	
RUN apt-get install -y \
	python \
	python-dev \
	python-pip \
	python-requests \
	python-scrapy \
	python-pillow \
	ipython 
		
RUN pip install \
	tweepy \
	bottle \
	multiprocessing
	
RUN pip install argparse

RUN echo 'syncthing:x:1000:1000::/var/syncthing:/sbin/nologin' >> /etc/passwd \
    && echo 'syncthing:!::0:::::' >> /etc/shadow \
    && mkdir /var/syncthing \
    && chown syncthing /var/syncthing

RUN curl -s https://syncthing.net/release-key.txt | apt-key add - \
    && echo "deb https://apt.syncthing.net/ syncthing stable" | tee /etc/apt/sources.list.d/syncthing.list \
    && apt-get update \
    && apt-get install syncthing -y
    
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

USER syncthing
ENV STNOUPGRADE=1

EXPOSE 22 8385
CMD ["/usr/bin/supervisord"]
	
