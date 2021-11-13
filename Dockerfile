FROM python:3.9

RUN apt update && \
	apt install -y python3-fusepy fuse rdfind rsync

RUN pip install ratarmount

VOLUME /takeout
VOLUME /index
VOLUME /photos

COPY backup_files.sh /
CMD ["/backup_files.sh"]
