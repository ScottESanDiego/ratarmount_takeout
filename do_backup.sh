#!/bin/sh
# Example!
#docker run --rm -ti -v /data/shared/scotte/GPhotos_Takeout:/takeout -v /home/scotte/ratar_index:/index -v /data/media/Pictures/ScottESanDiego:/photos -v /etc/localtime:/etc/localtime:ro --cap-add SYS_ADMIN --device /dev/fuse scotte/ratarmount
