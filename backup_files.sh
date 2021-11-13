#!/bin/sh
#
TARBALLS="/takeout"
INDEX="/index"
DESTINATION="/photos"
TMPMOUNT="/mnt"

if [ `mountpoint -d ${INDEX}` != `mountpoint -d /` ] ; then
	echo "Using persistent cache at ${INDEX}"
fi

if [ `mountpoint -d ${TARBALLS}` != `mountpoint -d /` ] ; then
	echo "Takeout tarfiles will be mounted to ${TARBALLS}"
else
	echo "The ${TARBALLS} location must be a mountpoint"
	exit 1
fi

if [ `mountpoint -d ${DESTINATION}` != `mountpoint -d /` ] ; then
	echo "Photos tarfiles will be mounted to ${DESTINATION}"
else
	echo "The ${DESTINATION} location must be a mountpoint"
	exit 1
fi

# Mount all tarballs in ${TARBALLS} into a single mount point
# If a folder is passed in at ${INDEX} then it can be used as a persistent cache, otherwise it'll just be in the container
ratarmount --index-folder ${INDEX} ${TARBALLS}/* ${TMPMOUNT}

# Sync contents from mount point to backup ${DESTINATION}
# Relies on --checksum since file times are not stable
#rsync --dry-run --itemize-changes --inplace --archive --delete --checksum ${TMPMOUNT}/ ${DESTINATION}/
rsync --itemize-changes --inplace --archive --delete --checksum --modify-window 86400 --omit-dir-times ${TMPMOUNT}/ ${DESTINATION}/

# Hard link identical files, but don't bother saving results
rdfind -makehardlinks true -makeresultsfile false ${DESTINATION}

# Be kind and unmount the mount before exiting
fusermount -u ${TMPMOUNT}
