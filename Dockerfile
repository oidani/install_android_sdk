FROM ubuntu
RUN apt update &&\
    apt install -y bash\
    wget\
    unzip\
    vim