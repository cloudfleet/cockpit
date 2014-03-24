# cloudfleet cockpit
#
# VERSION 0.1

FROM dockerfile/nodejs

RUN echo deb http://pagekite.net/pk/deb/ pagekite main | sudo tee -a /etc/apt/sources.list
RUN sudo apt-key adv --recv-keys --keyserver keys.gnupg.net AED248B1C7B2CAC3
RUN sudo apt-get update
RUN sudo apt-get install -y python-software-properties python g++ make pagekite
RUN git clone https://github.com/cloudfleet/cockpit.git
RUN cd cockpit; npm install

CMD cd cockpit; node cockpit.js

EXPOSE 3000
