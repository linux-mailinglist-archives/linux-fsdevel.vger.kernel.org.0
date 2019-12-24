Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3818B129D6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Dec 2019 05:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfLXEkP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Dec 2019 23:40:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46828 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLXEkO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Dec 2019 23:40:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBO4d33E182770;
        Tue, 24 Dec 2019 04:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=LO0g3wepY9u21Q7xs4So29a9ip+iW7caeIHGsYLhc7A=;
 b=RLG8kydJC5GJkfLdYFvEiu0uj01JMr0M95ZmW83l/+mgSPhl3RIxt/vgOz2bs/+fN/jS
 9SZbZ1YPI0ytyuJ9j0BNuwz92fnEEhCpHKhd8eR92B6OSVC8NFf/7Pt7zUlV60Wltc0P
 IYOB+YE+IbHay4SSCRvqTEcH202H5qzNh9haniGjdlg+p62N9n/RIG4yCf4iMHBuYu6a
 w/KDZX6aXTGL+7/2IaJAHifSKauL56kPIIQFIK2N9OeH+dpAZDBu1CvDYGTUm//qEYFp
 wIsJyQBD3ZRdGKTXMNiWZV9Dw/59WiNazvOG0TnIAULIU87NQea7v/DDwh54U3tGaC3g Xg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2x1atthvcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Dec 2019 04:40:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xBO4d0UU095938;
        Tue, 24 Dec 2019 04:40:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2x3brd04r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Dec 2019 04:40:04 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xBO4e3h6001315;
        Tue, 24 Dec 2019 04:40:03 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Dec 2019 20:40:03 -0800
Date:   Mon, 23 Dec 2019 20:40:01 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 1/2] fs: New zonefs file system
Message-ID: <20191224044001.GA2982727@magnolia>
References: <20191224020615.134668-1-damien.lemoal@wdc.com>
 <20191224020615.134668-2-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191224020615.134668-2-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9480 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=52 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1912240038
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9480 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=52 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1912240038
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 24, 2019 at 11:06:14AM +0900, Damien Le Moal wrote:
> zonefs is a very simple file system exposing each zone of a zoned block
> device as a file. Unlike a regular file system with zoned block device
> support (e.g. f2fs), zonefs does not hide the sequential write
> constraint of zoned block devices to the user. Files representing
> sequential write zones of the device must be written sequentially
> starting from the end of the file (append only writes).
> 
> As such, zonefs is in essence closer to a raw block device access
> interface than to a full featured POSIX file system. The goal of zonefs
> is to simplify the implementation of zoned block devices support in
> applications by replacing raw block device file accesses with a richer
> file API, avoiding relying on direct block device file ioctls which may
> be more obscure to developers. One example of this approach is the
> implementation of LSM (log-structured merge) tree structures (such as
> used in RocksDB and LevelDB) on zoned block devices by allowing SSTables
> to be stored in a zone file similarly to a regular file system rather
> than as a range of sectors of a zoned device. The introduction of the
> higher level construct "one file is one zone" can help reducing the
> amount of changes needed in the application as well as introducing
> support for different application programming languages.
> 
> Zonefs on-disk metadata is reduced to an immutable super block to
> persistently store a magic number and optional features flags and
> values. On mount, zonefs uses blkdev_report_zones() to obtain the device
> zone configuration and populates the mount point with a static file tree
> solely based on this information. E.g. file sizes come from the device
> zone type and write pointer offset managed by the device itself.
> 
> The zone files created on mount have the following characteristics.
> 1) Files representing zones of the same type are grouped together
>    under a common sub-directory:
>      * For conventional zones, the sub-directory "cnv" is used.
>      * For sequential write zones, the sub-directory "seq" is used.
>   These two directories are the only directories that exist in zonefs.
>   Users cannot create other directories and cannot rename nor delete
>   the "cnv" and "seq" sub-directories.
> 2) The name of zone files is the number of the file within the zone
>    type sub-directory, in order of increasing zone start sector.
> 3) The size of conventional zone files is fixed to the device zone size.
>    Conventional zone files cannot be truncated.
> 4) The size of sequential zone files represent the file's zone write
>    pointer position relative to the zone start sector. Truncating these
>    files is allowed only down to 0, in wich case, the zone is reset to
>    rewind the zone write pointer position to the start of the zone, or
>    up to the zone size, in which case the file's zone is transitioned
>    to the FULL state (finish zone operation).
> 5) All read and write operations to files are not allowed beyond the
>    file zone size. Any access exceeding the zone size is failed with
>    the -EFBIG error.
> 6) Creating, deleting, renaming or modifying any attribute of files and
>    sub-directories is not allowed.
> 7) There are no restrictions on the type of read and write operations
>    that can be issued to conventional zone files. Buffered, direct and
>    mmap read & write operations are accepted. For sequential zone files,
>    there are no restrictions on read operations, but all write
>    operations must be direct IO append writes. mmap write of sequential
>    files is not allowed.
> 
> Several optional features of zonefs can be enabled at format time.
> * Conventional zone aggregation: ranges of contiguous conventional
>   zones can be agregated into a single larger file instead of the
>   default one file per zone.
> * File ownership: The owner UID and GID of zone files is by default 0
>   (root) but can be changed to any valid UID/GID.
> * File access permissions: the default 640 access permissions can be
>   changed.
> 
> The mkzonefs tool is used to format zoned block devices for use with
> zonefs. This tool is available on Github at:
> 
> git@github.com:damien-lemoal/zonefs-tools.git.
> 
> zonefs-tools also includes a test suite which can be run against any
> zoned block device, including null_blk block device created with zoned
> mode.
> 
> Example: the following formats a 15TB host-managed SMR HDD with 256 MB
> zones with the conventional zones aggregation feature enabled.
> 
> $ sudo mkzonefs -o aggr_cnv /dev/sdX
> $ sudo mount -t zonefs /dev/sdX /mnt
> $ ls -l /mnt/
> total 0
> dr-xr-xr-x 2 root root     1 Nov 25 13:23 cnv
> dr-xr-xr-x 2 root root 55356 Nov 25 13:23 seq
> 
> The size of the zone files sub-directories indicate the number of files
> existing for each type of zones. In this example, there is only one
> conventional zone file (all conventional zones are agreggated under a
> single file).
> 
> $ ls -l /mnt/cnv
> total 137101312
> -rw-r----- 1 root root 140391743488 Nov 25 13:23 0
> 
> This aggregated conventional zone file can be used as a regular file.
> 
> $ sudo mkfs.ext4 /mnt/cnv/0
> $ sudo mount -o loop /mnt/cnv/0 /data
> 
> The "seq" sub-directory grouping files for sequential write zones has
> in this example 55356 zones.
> 
> $ ls -lv /mnt/seq
> total 14511243264
> -rw-r----- 1 root root 0 Nov 25 13:23 0
> -rw-r----- 1 root root 0 Nov 25 13:23 1
> -rw-r----- 1 root root 0 Nov 25 13:23 2
> ...
> -rw-r----- 1 root root 0 Nov 25 13:23 55354
> -rw-r----- 1 root root 0 Nov 25 13:23 55355
> 
> For sequential write zone files, the file size changes as data is
> appended at the end of the file, similarly to any regular file system.
> 
> $ dd if=/dev/zero of=/mnt/seq/0 bs=4K count=1 conv=notrunc oflag=direct
> 1+0 records in
> 1+0 records out
> 4096 bytes (4.1 kB, 4.0 KiB) copied, 1.05112 s, 3.9 kB/s
> 
> $ ls -l /mnt/seq/0
> -rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/sdh/seq/0
> 
> The written file can be truncated to the zone size, prventing any
> further write operation.
> 
> $ truncate -s 268435456 /mnt/seq/0
> $ ls -l /mnt/seq/0
> -rw-r----- 1 root root 268435456 Nov 25 13:49 /mnt/seq/0
> 
> Truncation to 0 size allows freeing the file zone storage space and
> restart append-writes to the file.
> 
> $ truncate -s 0 /mnt/seq/0
> $ ls -l /mnt/seq/0
> -rw-r----- 1 root root 0 Nov 25 13:49 /mnt/seq/0
> 
> Since files are statically mapped to zones on the disk, the number of
> blocks of a file as reported by stat() and fstat() indicates the size
> of the file zone.
> 
> $ stat /mnt/seq/0
>   File: /mnt/seq/0
>   Size: 0       Blocks: 524288     IO Block: 4096   regular empty file
> Device: 870h/2160d      Inode: 50431       Links: 1
> Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/  root)
> Access: 2019-11-25 13:23:57.048971997 +0900
> Modify: 2019-11-25 13:52:25.553805765 +0900
> Change: 2019-11-25 13:52:25.553805765 +0900
>  Birth: -
> 
> The number of blocks of the file ("Blocks") in units of 512B blocks
> gives the maximum file size of 524288 * 512 B = 256 MB, corresponding
> to the device zone size in this example. Of note is that the "IO block"
> field always indicates the minimum IO size for writes and corresponds
> to the device physical sector size.
> 
> This code contains contributions from:
> * Johannes Thumshirn <jthumshirn@suse.de>,
> * Darrick J. Wong <darrick.wong@oracle.com>,
> * Christoph Hellwig <hch@lst.de>,
> * Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com> and
> * Ting Yao <tingyao@hust.edu.cn>.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---

<snip>
>  MAINTAINERS                |    9 +
>  fs/Kconfig                 |    1 +
>  fs/Makefile                |    1 +
>  fs/zonefs/Kconfig          |    9 +
>  fs/zonefs/Makefile         |    4 +
>  fs/zonefs/super.c          | 1165 ++++++++++++++++++++++++++++++++++++
>  fs/zonefs/zonefs.h         |  169 ++++++
>  include/uapi/linux/magic.h |    1 +
>  8 files changed, 1359 insertions(+)
>  create mode 100644 fs/zonefs/Kconfig
>  create mode 100644 fs/zonefs/Makefile
>  create mode 100644 fs/zonefs/super.c
>  create mode 100644 fs/zonefs/zonefs.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a049abccaa26..8eb6f02a1efa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18284,6 +18284,15 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  F:	arch/x86/kernel/cpu/zhaoxin.c
>  
> +ZONEFS FILESYSTEM
> +M:	Damien Le Moal <damien.lemoal@wdc.com>
> +M:	Naohiro Aota <naohiro.aota@wdc.com>
> +R:	Johannes Thumshirn <jth@kernel.org>
> +L:	linux-fsdevel@vger.kernel.org
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
> +S:	Maintained
> +F:	fs/zonefs/
> +
>  ZPOOL COMPRESSED PAGE STORAGE API
>  M:	Dan Streetman <ddstreet@ieee.org>
>  L:	linux-mm@kvack.org
> diff --git a/fs/Kconfig b/fs/Kconfig
> index 7b623e9fc1b0..a3f97ca2bd46 100644
> --- a/fs/Kconfig
> +++ b/fs/Kconfig
> @@ -40,6 +40,7 @@ source "fs/ocfs2/Kconfig"
>  source "fs/btrfs/Kconfig"
>  source "fs/nilfs2/Kconfig"
>  source "fs/f2fs/Kconfig"
> +source "fs/zonefs/Kconfig"
>  
>  config FS_DAX
>  	bool "Direct Access (DAX) support"
> diff --git a/fs/Makefile b/fs/Makefile
> index 1148c555c4d3..527f228a5e8a 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -133,3 +133,4 @@ obj-$(CONFIG_CEPH_FS)		+= ceph/
>  obj-$(CONFIG_PSTORE)		+= pstore/
>  obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
>  obj-$(CONFIG_EROFS_FS)		+= erofs/
> +obj-$(CONFIG_ZONEFS_FS)		+= zonefs/
> diff --git a/fs/zonefs/Kconfig b/fs/zonefs/Kconfig
> new file mode 100644
> index 000000000000..6490547e9763
> --- /dev/null
> +++ b/fs/zonefs/Kconfig
> @@ -0,0 +1,9 @@
> +config ZONEFS_FS
> +	tristate "zonefs filesystem support"
> +	depends on BLOCK
> +	depends on BLK_DEV_ZONED
> +	help
> +	  zonefs is a simple File System which exposes zones of a zoned block
> +	  device as files.

I wonder if you ought to mention here some examples of zoned block
devices, such as SMR drives?

> +
> +	  If unsure, say N.
> diff --git a/fs/zonefs/Makefile b/fs/zonefs/Makefile
> new file mode 100644
> index 000000000000..75a380aa1ae1
> --- /dev/null
> +++ b/fs/zonefs/Makefile
> @@ -0,0 +1,4 @@
> +# SPDX-License-Identifier: GPL-2.0
> +obj-$(CONFIG_ZONEFS_FS) += zonefs.o
> +
> +zonefs-y	:= super.o
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> new file mode 100644
> index 000000000000..417de3099fe0
> --- /dev/null
> +++ b/fs/zonefs/super.c

<snip>

> +static int zonefs_report_zones_err_cb(struct blk_zone *zone, unsigned int idx,
> +				      void *data)
> +{
> +	struct inode *inode = data;
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	loff_t pos;
> +
> +	/*
> +	 * The condition of the zone may have change. Check it and adjust the
> +	 * inode information as needed, similarly to zonefs_init_file_inode().
> +	 */
> +	if (zone->cond == BLK_ZONE_COND_OFFLINE) {
> +		inode->i_flags |= S_IMMUTABLE;

Can a zone go from offline (or I suppose readonly) to one of the other
not-immutable states?  If a zone comes back online, you'd want to clear
S_IMMUTABLE.

> +		inode->i_mode = S_IFREG;

i_mode &= ~S_IRWXUGO; ?

Note that clearing the mode flags won't prevent programs with an
existing writable fd from being able to call write().  I'd imagine that
they'd hit EIO pretty fast though, so that might not matter.

> +		zone->wp = zone->start;
> +	} else if (zone->cond == BLK_ZONE_COND_READONLY) {
> +		inode->i_flags |= S_IMMUTABLE;
> +		inode->i_mode &= ~(0222); /* S_IWUGO */

Might as well just use S_IWUGO directly here?

> +	}
> +
> +	pos = (zone->wp - zone->start) << SECTOR_SHIFT;
> +	zi->i_wpoffset = pos;
> +	if (i_size_read(inode) != pos) {
> +		zonefs_update_stats(inode, pos);
> +		i_size_write(inode, pos);
> +	}
> +
> +	return 0;
> +}

<snip>

> +static void zonefs_init_file_inode(struct inode *inode, struct blk_zone *zone)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct zonefs_inode_info *zi = ZONEFS_I(inode);
> +	umode_t	perm = sbi->s_perm;
> +
> +	if (zone->cond == BLK_ZONE_COND_OFFLINE) {
> +		/*
> +		 * Dead zone: make the inode immutable, disable all accesses
> +		 * and set the file size to 0.
> +		 */
> +		inode->i_flags |= S_IMMUTABLE;
> +		zone->wp = zone->start;
> +		perm = 0;
> +	} else if (zone->cond == BLK_ZONE_COND_READONLY) {
> +		/* Do not allow writes in read-only zones */
> +		inode->i_flags |= S_IMMUTABLE;
> +		perm &= ~(0222); /* S_IWUGO */
> +	}
> +
> +	zi->i_ztype = zonefs_zone_type(zone);
> +	zi->i_zsector = zone->start;
> +	zi->i_max_size = min_t(loff_t, MAX_LFS_FILESIZE,
> +			       zone->len << SECTOR_SHIFT);
> +	if (zi->i_ztype == ZONEFS_ZTYPE_CNV)
> +		zi->i_wpoffset = zi->i_max_size;
> +	else
> +		zi->i_wpoffset = (zone->wp - zone->start) << SECTOR_SHIFT;
> +
> +	inode->i_mode = S_IFREG | perm;
> +	inode->i_uid = sbi->s_uid;
> +	inode->i_gid = sbi->s_gid;
> +	inode->i_size = zi->i_wpoffset;
> +	inode->i_blocks = zone->len;
> +
> +	inode->i_fop = &zonefs_file_operations;
> +	inode->i_op = &zonefs_file_inode_operations;
> +	inode->i_mapping->a_ops = &zonefs_file_aops;
> +
> +	sb->s_maxbytes = max(zi->i_max_size, sb->s_maxbytes);

Uhh, just out of curiosity, can zones be larger than 16T?  Bad things
happen on 32-bit kernels when you set s_maxbytes larger than that.

(He says with the hubris of having spent days sorting out various
longstanding bugs in 32-bit XFS.)

Anyway, looks good.

--D

> +	sbi->s_blocks += zi->i_max_size >> sb->s_blocksize_bits;
> +	sbi->s_used_blocks += zi->i_wpoffset >> sb->s_blocksize_bits;
> +}
> +
> +static struct dentry *zonefs_create_inode(struct dentry *parent,
> +					const char *name, struct blk_zone *zone)
> +{
> +	struct inode *dir = d_inode(parent);
> +	struct dentry *dentry;
> +	struct inode *inode;
> +
> +	dentry = d_alloc_name(parent, name);
> +	if (!dentry)
> +		return NULL;
> +
> +	inode = new_inode(parent->d_sb);
> +	if (!inode)
> +		goto out;
> +
> +	inode->i_ino = get_next_ino();
> +	inode->i_ctime = inode->i_mtime = inode->i_atime = dir->i_ctime;
> +	if (zone)
> +		zonefs_init_file_inode(inode, zone);
> +	else
> +		zonefs_init_dir_inode(dir, inode);
> +	d_add(dentry, inode);
> +	dir->i_size++;
> +
> +	return dentry;
> +
> +out:
> +	dput(dentry);
> +
> +	return NULL;
> +}
> +
> +static char *zgroups_name[ZONEFS_ZTYPE_MAX] = { "cnv", "seq" };
> +
> +struct zonefs_zone_data {
> +	struct super_block *sb;
> +	unsigned int nr_zones[ZONEFS_ZTYPE_MAX];
> +	struct blk_zone *zones;
> +};
> +
> +/*
> + * Create a zone group and populate it with zone files.
> + */
> +static int zonefs_create_zgroup(struct zonefs_zone_data *zd,
> +				enum zonefs_ztype type)
> +{
> +	struct super_block *sb = zd->sb;
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct blk_zone *zone, *next, *end;
> +	char name[ZONEFS_NAME_MAX];
> +	struct dentry *dir;
> +	unsigned int n = 0;
> +
> +	/* If the group is empty, there is nothing to do */
> +	if (!zd->nr_zones[type])
> +		return 0;
> +
> +	dir = zonefs_create_inode(sb->s_root, zgroups_name[type], NULL);
> +	if (!dir)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The first zone contains the super block: skip it.
> +	 */
> +	end = zd->zones + blkdev_nr_zones(sb->s_bdev->bd_disk);
> +	for (zone = &zd->zones[1]; zone < end; zone = next) {
> +
> +		next = zone + 1;
> +		if (zonefs_zone_type(zone) != type)
> +			continue;
> +
> +		/*
> +		 * For conventional zones, contiguous zones can be aggregated
> +		 * together to form larger files.
> +		 * Note that this overwrites the length of the first zone of
> +		 * the set of contiguous zones aggregated together.
> +		 * Only zones with the same condition can be agreggated so that
> +		 * offline zones are excluded and readonly zones are aggregated
> +		 * together into a read only file.
> +		 */
> +		if (type == ZONEFS_ZTYPE_CNV &&
> +		    (sbi->s_features & ZONEFS_F_AGGRCNV)) {
> +			for (; next < end; next++) {
> +				if (zonefs_zone_type(next) != type ||
> +				    next->cond != zone->cond)
> +					break;
> +				zone->len += next->len;
> +			}
> +		}
> +
> +		/*
> +		 * Use the file number within its group as file name.
> +		 */
> +		snprintf(name, ZONEFS_NAME_MAX - 1, "%u", n);
> +		if (!zonefs_create_inode(dir, name, zone))
> +			return -ENOMEM;
> +
> +		n++;
> +	}
> +
> +	zonefs_info(sb, "Zone group \"%s\" has %u file%s\n",
> +		    zgroups_name[type], n, n > 1 ? "s" : "");
> +
> +	sbi->s_nr_files[type] = n;
> +
> +	return 0;
> +}
> +
> +static int zonefs_get_zone_info_cb(struct blk_zone *zone, unsigned int idx,
> +				   void *data)
> +{
> +	struct zonefs_zone_data *zd = data;
> +
> +	/*
> +	 * Count the number of usable zones: the first zone at index 0 contains
> +	 * the super block and is ignored.
> +	 */
> +	switch (zone->type) {
> +	case BLK_ZONE_TYPE_CONVENTIONAL:
> +		zone->wp = zone->start + zone->len;
> +		if (idx)
> +			zd->nr_zones[ZONEFS_ZTYPE_CNV]++;
> +		break;
> +	case BLK_ZONE_TYPE_SEQWRITE_REQ:
> +	case BLK_ZONE_TYPE_SEQWRITE_PREF:
> +		if (idx)
> +			zd->nr_zones[ZONEFS_ZTYPE_SEQ]++;
> +		break;
> +	default:
> +		zonefs_err(zd->sb, "Unsupported zone type 0x%x\n",
> +			   zone->type);
> +		return -EIO;
> +	}
> +
> +	memcpy(&zd->zones[idx], zone, sizeof(struct blk_zone));
> +
> +	return 0;
> +}
> +
> +static int zonefs_get_zone_info(struct zonefs_zone_data *zd)
> +{
> +	struct block_device *bdev = zd->sb->s_bdev;
> +	int ret;
> +
> +	zd->zones = kvcalloc(blkdev_nr_zones(bdev->bd_disk),
> +			     sizeof(struct blk_zone), GFP_KERNEL);
> +	if (!zd->zones)
> +		return -ENOMEM;
> +
> +	/* Get zones information */
> +	ret = blkdev_report_zones(bdev, 0, BLK_ALL_ZONES,
> +				  zonefs_get_zone_info_cb, zd);
> +	if (ret < 0) {
> +		zonefs_err(zd->sb, "Zone report failed %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ret != blkdev_nr_zones(bdev->bd_disk)) {
> +		zonefs_err(zd->sb, "Invalid zone report (%d/%u zones)\n",
> +			   ret, blkdev_nr_zones(bdev->bd_disk));
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static inline void zonefs_cleanup_zone_info(struct zonefs_zone_data *zd)
> +{
> +	kvfree(zd->zones);
> +}
> +
> +/*
> + * Read super block information from the device.
> + */
> +static int zonefs_read_super(struct super_block *sb)
> +{
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +	struct zonefs_super *super;
> +	u32 crc, stored_crc;
> +	struct page *page;
> +	struct bio_vec bio_vec;
> +	struct bio bio;
> +	int ret;
> +
> +	page = alloc_page(GFP_KERNEL);
> +	if (!page)
> +		return -ENOMEM;
> +
> +	bio_init(&bio, &bio_vec, 1);
> +	bio.bi_iter.bi_sector = 0;
> +	bio_set_dev(&bio, sb->s_bdev);
> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);
> +	bio_add_page(&bio, page, PAGE_SIZE, 0);
> +
> +	ret = submit_bio_wait(&bio);
> +	if (ret)
> +		goto out;
> +
> +	super = page_address(page);
> +
> +	stored_crc = le32_to_cpu(super->s_crc);
> +	super->s_crc = 0;
> +	crc = crc32(~0U, (unsigned char *)super, sizeof(struct zonefs_super));
> +	if (crc != stored_crc) {
> +		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",
> +			   crc, stored_crc);
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	ret = -EINVAL;
> +	if (le32_to_cpu(super->s_magic) != ZONEFS_MAGIC)
> +		goto out;
> +
> +	sbi->s_features = le64_to_cpu(super->s_features);
> +	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {
> +		zonefs_err(sb, "Unknown features set 0x%llx\n",
> +			   sbi->s_features);
> +		goto out;
> +	}
> +
> +	if (sbi->s_features & ZONEFS_F_UID) {
> +		sbi->s_uid = make_kuid(current_user_ns(),
> +				       le32_to_cpu(super->s_uid));
> +		if (!uid_valid(sbi->s_uid)) {
> +			zonefs_err(sb, "Invalid UID feature\n");
> +			goto out;
> +		}
> +	}
> +
> +	if (sbi->s_features & ZONEFS_F_GID) {
> +		sbi->s_gid = make_kgid(current_user_ns(),
> +				       le32_to_cpu(super->s_gid));
> +		if (!gid_valid(sbi->s_gid)) {
> +			zonefs_err(sb, "Invalid GID feature\n");
> +			goto out;
> +		}
> +	}
> +
> +	if (sbi->s_features & ZONEFS_F_PERM)
> +		sbi->s_perm = le32_to_cpu(super->s_perm);
> +
> +	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {
> +		zonefs_err(sb, "Reserved area is being used\n");
> +		goto out;
> +	}
> +
> +	uuid_copy(&sbi->s_uuid, &super->s_uuid);
> +	ret = 0;
> +
> +out:
> +	__free_page(page);
> +
> +	return ret;
> +}
> +
> +/*
> + * Check that the device is zoned. If it is, get the list of zones and create
> + * sub-directories and files according to the device zone configuration and
> + * format options.
> + */
> +static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
> +{
> +	struct zonefs_zone_data zd;
> +	struct zonefs_sb_info *sbi;
> +	struct inode *inode;
> +	enum zonefs_ztype t;
> +	int ret;
> +
> +	if (!bdev_is_zoned(sb->s_bdev)) {
> +		zonefs_err(sb, "Not a zoned block device\n");
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Initialize super block information: the maximum file size is updated
> +	 * when the zone files are created so that the format option
> +	 * ZONEFS_F_AGGRCNV which increases the maximum file size of a file
> +	 * beyond the zone size is taken into account.
> +	 */
> +	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
> +	if (!sbi)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&sbi->s_lock);
> +	sb->s_fs_info = sbi;
> +	sb->s_magic = ZONEFS_MAGIC;
> +	sb->s_maxbytes = 0;
> +	sb->s_op = &zonefs_sops;
> +	sb->s_time_gran	= 1;
> +
> +	/*
> +	 * The block size is always equal to the device physical sector size to
> +	 * ensure that writes on 512e devices (512B logical block and 4KB
> +	 * physical block) are always aligned to the device physical blocks
> +	 * (as required for writes to sequential zones on ZBC/ZAC disks).
> +	 */
> +	sb_set_blocksize(sb, bdev_physical_block_size(sb->s_bdev));
> +	sbi->s_blocksize_mask = sb->s_blocksize - 1;
> +	sbi->s_uid = GLOBAL_ROOT_UID;
> +	sbi->s_gid = GLOBAL_ROOT_GID;
> +	sbi->s_perm = 0640; /* S_IRUSR | S_IWUSR | S_IRGRP */
> +
> +	ret = zonefs_read_super(sb);
> +	if (ret)
> +		return ret;
> +
> +	memset(&zd, 0, sizeof(struct zonefs_zone_data));
> +	zd.sb = sb;
> +	ret = zonefs_get_zone_info(&zd);
> +	if (ret)
> +		goto out;
> +
> +	zonefs_info(sb, "Mounting %u zones",
> +		    blkdev_nr_zones(sb->s_bdev->bd_disk));
> +
> +	/* Create root directory inode */
> +	ret = -ENOMEM;
> +	inode = new_inode(sb);
> +	if (!inode)
> +		goto out;
> +
> +	inode->i_ino = get_next_ino();
> +	inode->i_mode = S_IFDIR | 0755;
> +	inode->i_ctime = inode->i_mtime = inode->i_atime = current_time(inode);
> +	inode->i_op = &simple_dir_inode_operations;
> +	inode->i_fop = &simple_dir_operations;
> +	set_nlink(inode, 2);
> +
> +	sb->s_root = d_make_root(inode);
> +	if (!sb->s_root)
> +		goto out;
> +
> +	/* Create and populate files in zone groups directories */
> +	for (t = 0; t < ZONEFS_ZTYPE_MAX; t++) {
> +		ret = zonefs_create_zgroup(&zd, t);
> +		if (ret)
> +			break;
> +	}
> +
> +out:
> +	zonefs_cleanup_zone_info(&zd);
> +
> +	return ret;
> +}
> +
> +static struct dentry *zonefs_mount(struct file_system_type *fs_type,
> +				   int flags, const char *dev_name, void *data)
> +{
> +	return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);
> +}
> +
> +static void zonefs_kill_super(struct super_block *sb)
> +{
> +	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
> +
> +	kfree(sbi);
> +	if (sb->s_root)
> +		d_genocide(sb->s_root);
> +	kill_block_super(sb);
> +}
> +
> +/*
> + * File system definition and registration.
> + */
> +static struct file_system_type zonefs_type = {
> +	.owner		= THIS_MODULE,
> +	.name		= "zonefs",
> +	.mount		= zonefs_mount,
> +	.kill_sb	= zonefs_kill_super,
> +	.fs_flags	= FS_REQUIRES_DEV,
> +};
> +
> +static int __init zonefs_init_inodecache(void)
> +{
> +	zonefs_inode_cachep = kmem_cache_create("zonefs_inode_cache",
> +			sizeof(struct zonefs_inode_info), 0,
> +			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),
> +			NULL);
> +	if (zonefs_inode_cachep == NULL)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +static void zonefs_destroy_inodecache(void)
> +{
> +	/*
> +	 * Make sure all delayed rcu free inodes are flushed before we
> +	 * destroy the inode cache.
> +	 */
> +	rcu_barrier();
> +	kmem_cache_destroy(zonefs_inode_cachep);
> +}
> +
> +static int __init zonefs_init(void)
> +{
> +	int ret;
> +
> +	BUILD_BUG_ON(sizeof(struct zonefs_super) != ZONEFS_SUPER_SIZE);
> +
> +	ret = zonefs_init_inodecache();
> +	if (ret)
> +		return ret;
> +
> +	ret = register_filesystem(&zonefs_type);
> +	if (ret) {
> +		zonefs_destroy_inodecache();
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit zonefs_exit(void)
> +{
> +	zonefs_destroy_inodecache();
> +	unregister_filesystem(&zonefs_type);
> +}
> +
> +MODULE_AUTHOR("Damien Le Moal");
> +MODULE_DESCRIPTION("Zone file system for zoned block devices");
> +MODULE_LICENSE("GPL");
> +module_init(zonefs_init);
> +module_exit(zonefs_exit);
> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
> new file mode 100644
> index 000000000000..0296b3426f7b
> --- /dev/null
> +++ b/fs/zonefs/zonefs.h
> @@ -0,0 +1,169 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Simple zone file system for zoned block devices.
> + *
> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.
> + */
> +#ifndef __ZONEFS_H__
> +#define __ZONEFS_H__
> +
> +#include <linux/fs.h>
> +#include <linux/magic.h>
> +#include <linux/uuid.h>
> +#include <linux/mutex.h>
> +#include <linux/rwsem.h>
> +
> +/*
> + * Maximum length of file names: this only needs to be large enough to fit
> + * the zone group directory names and a decimal value of the start sector of
> + * the zones for file names. 16 characters is plenty.
> + */
> +#define ZONEFS_NAME_MAX		16
> +
> +/*
> + * Zone types: ZONEFS_ZTYPE_SEQ is used for all sequential zone types
> + * defined in linux/blkzoned.h, that is, BLK_ZONE_TYPE_SEQWRITE_REQ and
> + * BLK_ZONE_TYPE_SEQWRITE_PREF.
> + */
> +enum zonefs_ztype {
> +	ZONEFS_ZTYPE_CNV,
> +	ZONEFS_ZTYPE_SEQ,
> +	ZONEFS_ZTYPE_MAX,
> +};
> +
> +static inline enum zonefs_ztype zonefs_zone_type(struct blk_zone *zone)
> +{
> +	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
> +		return ZONEFS_ZTYPE_CNV;
> +	return ZONEFS_ZTYPE_SEQ;
> +}
> +
> +/*
> + * In-memory inode data.
> + */
> +struct zonefs_inode_info {
> +	struct inode		i_vnode;
> +
> +	/* File zone type */
> +	enum zonefs_ztype	i_ztype;
> +
> +	/* File zone start sector (512B unit) */
> +	sector_t		i_zsector;
> +
> +	/* File zone write pointer position (sequential zones only) */
> +	loff_t			i_wpoffset;
> +
> +	/* File maximum size */
> +	loff_t			i_max_size;
> +
> +	/*
> +	 * To serialise fully against both syscall and mmap based IO and
> +	 * sequential file truncation, two locks are used. For serializing
> +	 * zonefs_seq_file_truncate() against zonefs_iomap_begin(), that is,
> +	 * file truncate operations against block mapping, i_truncate_mutex is
> +	 * used. i_truncate_mutex also protects against concurrent accesses
> +	 * and changes to the inode private data, and in particular changes to
> +	 * a sequential file size on completion of direct IO writes.
> +	 * Serialization of mmap read IOs with truncate and syscall IO
> +	 * operations is done with i_mmap_sem in addition to i_truncate_mutex.
> +	 * Only zonefs_seq_file_truncate() takes both lock (i_mmap_sem first,
> +	 * i_truncate_mutex second).
> +	 */
> +	struct mutex		i_truncate_mutex;
> +	struct rw_semaphore	i_mmap_sem;
> +};
> +
> +static inline struct zonefs_inode_info *ZONEFS_I(struct inode *inode)
> +{
> +	return container_of(inode, struct zonefs_inode_info, i_vnode);
> +}
> +
> +/*
> + * On-disk super block (block 0).
> + */
> +#define ZONEFS_SUPER_SIZE	4096
> +struct zonefs_super {
> +
> +	/* Magic number */
> +	__le32		s_magic;
> +
> +	/* Checksum */
> +	__le32		s_crc;
> +
> +	/* Features */
> +	__le64		s_features;
> +
> +	/* 128-bit uuid */
> +	uuid_t		s_uuid;
> +
> +	/* UID/GID to use for files */
> +	__le32		s_uid;
> +	__le32		s_gid;
> +
> +	/* File permissions */
> +	__le32		s_perm;
> +
> +	/* Padding to ZONEFS_SUPER_SIZE bytes */
> +	__u8		s_reserved[4052];
> +
> +} __packed;
> +
> +/*
> + * Feature flags: used on disk in the s_features field of struct zonefs_super
> + * and in-memory in the s_feartures field of struct zonefs_sb_info.
> + */
> +enum zonefs_features {
> +	/*
> +	 * Aggregate contiguous conventional zones into a single file.
> +	 */
> +	ZONEFS_F_AGGRCNV = 1ULL << 0,
> +	/*
> +	 * Use super block specified UID for files instead of default.
> +	 */
> +	ZONEFS_F_UID = 1ULL << 1,
> +	/*
> +	 * Use super block specified GID for files instead of default.
> +	 */
> +	ZONEFS_F_GID = 1ULL << 2,
> +	/*
> +	 * Use super block specified file permissions instead of default 640.
> +	 */
> +	ZONEFS_F_PERM = 1ULL << 3,
> +};
> +
> +#define ZONEFS_F_DEFINED_FEATURES \
> +	(ZONEFS_F_AGGRCNV | ZONEFS_F_UID | ZONEFS_F_GID | ZONEFS_F_PERM)
> +
> +/*
> + * In-memory Super block information.
> + */
> +struct zonefs_sb_info {
> +
> +	spinlock_t		s_lock;
> +
> +	unsigned long long	s_features;
> +	kuid_t			s_uid;
> +	kgid_t			s_gid;
> +	umode_t			s_perm;
> +	uuid_t			s_uuid;
> +	loff_t			s_blocksize_mask;
> +
> +	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];
> +
> +	loff_t			s_blocks;
> +	loff_t			s_used_blocks;
> +};
> +
> +static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
> +{
> +	return sb->s_fs_info;
> +}
> +
> +#define zonefs_info(sb, format, args...)	\
> +	pr_info("zonefs (%s): " format, sb->s_id, ## args)
> +#define zonefs_err(sb, format, args...)	\
> +	pr_err("zonefs (%s) ERROR: " format, sb->s_id, ## args)
> +#define zonefs_warn(sb, format, args...)	\
> +	pr_warn("zonefs (%s) WARN: " format, sb->s_id, ## args)
> +
> +#endif
> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> index 3ac436376d79..d78064007b17 100644
> --- a/include/uapi/linux/magic.h
> +++ b/include/uapi/linux/magic.h
> @@ -87,6 +87,7 @@
>  #define NSFS_MAGIC		0x6e736673
>  #define BPF_FS_MAGIC		0xcafe4a11
>  #define AAFS_MAGIC		0x5a3c69f0
> +#define ZONEFS_MAGIC		0x5a4f4653
>  
>  /* Since UDF 2.01 is ISO 13346 based... */
>  #define UDF_SUPER_MAGIC		0x15013346
> -- 
> 2.24.1
> 
