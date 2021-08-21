FROM ubuntu:20.04

# sudo tee /etc/apt/sources.list.d/pritunl.list << EOF
# deb http://repo.pritunl.com/unstable/apt focal main
# EOF

RUN sed -i "s*archive.ubuntu.com*mirror.amscloud.co.id*g" /etc/apt/sources.list
RUN apt-get update && apt-get install -y gnupg2 
RUN echo "deb http://repo.pritunl.com/unstable/apt focal main" > /etc/apt/sources.list.d/pritunl.list && \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A && apt update && \
	apt install pritunl gettext-base -y
	

RUN mkdir /app
WORKDIR /app

RUN /usr/lib/pritunl/bin/python -m pip install 'mongo[srv]' dnspython

RUN rm -rf /tmp/* /var/cache/*
# COPY scripts .
# RUN chmod +x /app/install.sh && /app/install.sh
# RUN cat /app/scripts/install.sh
# RUN
# RUN pritunl set app.server_port 80 && \
# 	pritunl set app.server_ssl false && \
# 	pritunl set app.reverse_proxy true

EXPOSE 80/tcp 443/tcp 1194/tcp 1194/udp 1195/udp 9700/tcp

COPY entrypoint.sh .
ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["pritunl", "start"]