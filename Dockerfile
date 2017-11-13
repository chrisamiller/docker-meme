FROM ubuntu:zesty

MAINTAINER Chris Miller <c.a.miller@wustl.edu>

LABEL docker image for the MEME package (http://meme.ebi.edu.au/)

#dependencies
RUN apt-get -y update && apt-get -y --no-install-recommends install wget build-essential imagemagick libxml-simple-perl libxml-sax-expat-perl libxml-compile-soap-perl libxml-compile-wsdl11-perl libconfig-json-perl  libhtml-treebuilder-libxml-perl libhtml-template-perl libhtml-parser-perl zlib1g-dev
	
#install meme
RUN mkdir /opt/meme && cd /opt/meme && wget http://meme-suite.org/meme-software/4.12.0/meme_4.12.0.tar.gz && tar -xzvf meme_4.12.0.tar.gz && cd meme_4.12.0 && ./configure --prefix / --with-url="http://meme-suite.org" && make && make install

# Clean up
   RUN cd / && \
   rm -rf /tmp/* && \
   apt-get autoremove -y && \
   apt-get autoclean -y && \
   rm -rf /var/lib/apt/lists/* && \
   apt-get clean

# needed for MGI data mounts
RUN apt-get update && apt-get install -y libnss-sss && apt-get clean all
