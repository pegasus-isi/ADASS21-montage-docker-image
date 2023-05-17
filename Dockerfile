FROM pegasus/tutorial:5.0.1 

# install build dependencies
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y install make gcc

ENV HOME=/home/scitech
ENV MONTAGE_HOME=${HOME}/Montage

WORKDIR ${HOME}
USER scitech

# get montage dev branch and build
RUN git clone https://github.com/Caltech-IPAC/Montage.git \
    && cd ${MONTAGE_HOME} \
    && git checkout b571d7541e4d86be38b29fdcac712f417a2d8374 \
    && ./configure \
    && make 

# build mAddMem executable
WORKDIR ${MONTAGE_HOME}
RUN cd ./MontageLib/AddMem \
    && make \
    && cp mAddMem ${MONTAGE_HOME}/bin/mAddMem

# add Montage binaries to PATH
RUN printf "export PATH=${MONTAGE_HOME}/bin:\$PATH" >> ~/.bashrc
COPY ./kernel.json /usr/local/share/jupyter/kernels/python3/kernel.json

# copy montage notebook into image
WORKDIR ${HOME}/notebooks
COPY ./PegasusMontage ./PegasusMontage/
USER root
RUN chown --recursive scitech ./PegasusMontage

# install python dependencies
USER scitech
RUN pip3 install --user -r ./PegasusMontage/requirements.txt

# the supervisord CMD from the parent docker image needs to run as root
USER root
