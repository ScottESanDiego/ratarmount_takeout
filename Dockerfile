FROM python:3.9

RUN apt update \
    && apt install -y python3-fusepy fuse rdfind rsync \
    && pip install ratarmount \
    && rm -rf /var/lib/apt/lists/*

VOLUME /takeout
VOLUME /index
VOLUME /photos

COPY backup_files.sh /
CMD ["/backup_files.sh"]
