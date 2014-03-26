# cloudfleet cockpit
#
# VERSION 0.2

FROM dockerfile/nodejs

ADD . $HOME/cockpit
RUN cd $HOME/cockpit/; scripts/install.sh

CMD cockpit/scripts/start.sh

EXPOSE 3000
