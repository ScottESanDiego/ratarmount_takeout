# ratarmount_takeout
Use `ratarmount` to rsync Google Takeout photos.  Also uses `rdfind` to hardlink items to reduce space

## Way to execute
Requires 2 volumes, potentially 3

`/takeout` should be a directory with the .tgz files from Google Takeout in them. e.g.,:
```
scotte ~/projects: ls /data/shared/scotte/GPhotos_Takeout
takeout-20211110T224528Z-001.tgz  takeout-20211110T224528Z-003.tgz  takeout-20211110T224528Z-005.tgz
takeout-20211110T224528Z-002.tgz  takeout-20211110T224528Z-004.tgz  takeout-20211110T224528Z-006.tgz
```

`photos` should be where things will get rsync'ed to. e.g.,:
```
scotte ~/projects: ls /data/media/Pictures/ScottESanDiego/
Takeout
```

`index` is optional, but should be a directory where the ratarmount index files are stored. Else, they will get recreated on each invocation (potentially ~20-30m).

## How to run
`docker run --rm -ti -v /data/shared/scotte/GPhotos_Takeout:/takeout -v /home/scotte/ratar_index:/index -v /data/media/Pictures/ScottESanDiego:/photos -v /etc/localtime:/etc/localtime:ro --cap-add SYS_ADMIN --device /dev/fuse scotte/ratarmount`
