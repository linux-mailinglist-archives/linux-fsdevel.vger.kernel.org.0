Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A97B312F207
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2020 01:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgACAMt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Jan 2020 19:12:49 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38114 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgACAMt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Jan 2020 19:12:49 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0030BCo6171840;
        Fri, 3 Jan 2020 00:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=BqWq2d+VT0OaG6IclqnygqwQAWlvxEGVOOhc//ecqbU=;
 b=JdeODqnx3Q0EdqHvQDofjFuGWRUI3eW7b0YK//zS1MO7gyI3aW7cnG+N7Tckxt1shvG7
 sC7FUV2DZXC/mOxZ0w0yUo5xEleOzkAxGZnchpb7PtK/eKFc0ID4NLHdXGQEJzgC8Vva
 sFbv/l4a7ZAwj71oM9arJ33rjFqDlTVGhLuJXdvCBq3RFIb2WKyCjT8ppgv6CRitPS3m
 lLXfnv8h0UTEuIIcS9sDN3Nw9RVREgF5aFG7pEyRaA9tr9jqrUYK9GVS/hpgh2wsk4P8
 aWla5V06xPCDnhduH/yzMZtH+dxCGBch2tBTI+LIAnVOyL2Kd6TFkRjIzz7VFHml+0wE 3w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2x5y0psy70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 00:12:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00308EYd035064;
        Fri, 3 Jan 2020 00:12:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2x8bstns7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jan 2020 00:12:42 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0030CbXZ008634;
        Fri, 3 Jan 2020 00:12:38 GMT
Received: from localhost (/10.145.178.64)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 02 Jan 2020 16:12:37 -0800
Date:   Thu, 2 Jan 2020 16:12:35 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Damien Le Moal <damien.lemoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v4 2/2] zonefs: Add documentation
Message-ID: <20200103001235.GE1508633@magnolia>
References: <20191225081716.327348-1-damien.lemoal@wdc.com>
 <20191225081716.327348-3-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225081716.327348-3-damien.lemoal@wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001030000
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9488 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001030000
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 25, 2019 at 05:17:16PM +0900, Damien Le Moal wrote:
> Add the new file Documentation/filesystems/zonefs.txt to document
> zonefs principles and user-space tool usage.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  Documentation/filesystems/zonefs.txt | 215 +++++++++++++++++++++++++++
>  MAINTAINERS                          |   1 +
>  2 files changed, 216 insertions(+)
>  create mode 100644 Documentation/filesystems/zonefs.txt
> 
> diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesystems/zonefs.txt
> new file mode 100644
> index 000000000000..4623c659e5ee
> --- /dev/null
> +++ b/Documentation/filesystems/zonefs.txt
> @@ -0,0 +1,215 @@
> +ZoneFS - Zone filesystem for Zoned block devices
> +
> +Overview
> +========
> +
> +zonefs is a very simple file system exposing each zone of a zoned block device
> +as a file. Unlike a regular file system with zoned block device support (e.g.
> +f2fs), zonefs does not hide the sequential write constraint of zoned block
> +devices to the user. Files representing sequential write zones of the device
> +must be written sequentially starting from the end of the file (append only
> +writes).
> +
> +As such, zonefs is in essence closer to a raw block device access interface
> +than to a full featured POSIX file system. The goal of zonefs is to simplify
> +the implementation of zoned block device support in applications by replacing
> +raw block device file accesses with a richer file API, avoiding relying on
> +direct block device file ioctls which may be more obscure to developers. One
> +example of this approach is the implementation of LSM (log-structured merge)
> +tree structures (such as used in RocksDB and LevelDB) on zoned block devices
> +by allowing SSTables to be stored in a zone file similarly to a regular file
> +system rather than as a range of sectors of the entire disk. The introduction
> +of the higher level construct "one file is one zone" can help reducing the
> +amount of changes needed in the application as well as introducing support for
> +different application programming languages.
> +
> +zonefs on-disk metadata
> +-----------------------
> +
> +zonefs on-disk metadata is reduced to an immutable super block which
> +persistently stores a magic number and optional feature flags and values. On
> +mount, zonefs uses blkdev_report_zones() to obtain the device zone configuration
> +and populates the mount point with a static file tree solely based on this
> +information. File sizes come from the device zone type and write pointer
> +position managed by the device itself.
> +
> +The super block is always written on disk at sector 0. The first zone of the
> +device storing the super block is never exposed as a zone file by zonefs. If
> +the zone containing the super block is a sequential zone, the mkzonefs format
> +tool always "finishes" the zone, that is, it transitions the zone to a full
> +state to make it read-only, preventing any data write.
> +
> +Zone type sub-directories
> +-------------------------
> +
> +Files representing zones of the same type are grouped together under the same
> +sub-directory automatically created on mount.
> +
> +For conventional zones, the sub-directory "cnv" is used. This directory is
> +however created if and only if the device has usable conventional zones. If
> +the device only has a single conventional zone at sector 0, the zone will not
> +be exposed as a file as it will be used to store the zonefs super block. For
> +such devices, the "cnv" sub-directory will not be created.
> +
> +For sequential write zones, the sub-directory "seq" is used.
> +
> +These two directories are the only directories that exist in zonefs. Users
> +cannot create other directories and cannot rename nor delete the "cnv" and
> +"seq" sub-directories.
> +
> +The size of the directories indicated by the st_size field of struct stat,
> +obtained with the stat() or fstat() system calls, indicates the number of files
> +existing under the directory.
> +
> +Zone files
> +----------
> +
> +Zone files are named using the number of the zone they represent within the set
> +of zones of a particular type. That is, both the "cnv" and "seq" directories
> +contain files named "0", "1", "2", ... The file numbers also represent
> +increasing zone start sector on the device.
> +
> +All read and write operations to zone files are not allowed beyond the file
> +maximum size, that is, beyond the zone size. Any access exceeding the zone
> +size is failed with the -EFBIG error.
> +
> +Creating, deleting, renaming or modifying any attribute of files and
> +sub-directories is not allowed.
> +
> +The number of blocks of a file as reported by stat() and fstat() indicates the
> +size of the file zone, or in other words, the maximum file size.
> +
> +Conventional zone files
> +-----------------------
> +
> +The size of conventional zone files is fixed to the size of the zone they
> +represent. Conventional zone files cannot be truncated.
> +
> +These files can be randomly read and written, using any form of IO operation:
> +buffered IOs, direct IOs, memory mapped IOs (mmap), etc. There are no IO
> +constraint for these files beyond the file size limit mentioned above.
> +
> +Sequential zone files
> +---------------------
> +
> +The size of sequential zone files present in the "seq" sub-directory represents
> +the file's zone write pointer position relative to the zone start sector.
> +
> +Sequential zone files can only be written sequentially, starting from the file
> +end, that is, write operations can only be append writes. Zonefs makes no
> +attempt at accepting random writes and will fail any write request that has a
> +start offset not corresponding to the end of the last issued write.
> +
> +In order to give guarantees regarding write ordering, zonefs also prevents
> +buffered writes and mmap writes for sequential files. Only direct IO writes are
> +accepted. There are no restrictions on read operations nor on the type of IO
> +used to request reads (buffered IOs, direct IOs and mmap reads are all
> +accepted).
> +
> +Truncating sequential zone files is allowed only down to 0, in which case, the
> +zone is reset to rewind the file zone write pointer position to the start of
> +the zone, or up to the zone size, in which case the file's zone is transitioned
> +to the FULL state (finish zone operation).
> +
> +zonefs format options
> +---------------------
> +
> +Several optional features of zonefs can be enabled at format time.
> +* Conventional zone aggregation: ranges of contiguous conventional zones can be
> +  aggregated into a single larger file instead of the default one file per zone.
> +* File ownership: The owner UID and GID of zone files is by default 0 (root)
> +  but can be changed to any valid UID/GID.
> +* File access permissions: the default 640 access permissions can be changed.
> +
> +User Space Tools
> +----------------
> +
> +The mkzonefs tool is used to format zoned block devices for use with zonefs.
> +This tool is available on Github at:
> +
> +https://github.com/damien-lemoal/zonefs-tools
> +
> +zonefs-tools also includes a test suite which can be run against any zoned
> +block device, including null_blk block device created with zoned mode.
> +
> +Examples
> +--------
> +
> +The following formats a 15TB host-managed SMR HDD with 256 MB zones
> +with the conventional zones aggregation feature enabled.
> +
> +# mkzonefs -o aggr_cnv /dev/sdX
> +# mount -t zonefs /dev/sdX /mnt
> +# ls -l /mnt/
> +total 0
> +dr-xr-xr-x 2 root root     1 Nov 25 13:23 cnv
> +dr-xr-xr-x 2 root root 55356 Nov 25 13:23 seq
> +
> +The size of the zone files sub-directories indicate the number of files
> +existing for each type of zones. In this example, there is only one
> +conventional zone file (all conventional zones are aggregated under a single
> +file).
> +
> +# ls -l /mnt/cnv
> +total 137101312
> +-rw-r----- 1 root root 140391743488 Nov 25 13:23 0
> +
> +This aggregated conventional zone file can be used as a regular file.
> +
> +# mkfs.ext4 /mnt/cnv/0
> +# mount -o loop /mnt/cnv/0 /data
> +
> +The "seq" sub-directory grouping files for sequential write zones has in this
> +example 55356 zones.
> +
> +# ls -lv /mnt/seq
> +total 14511243264
> +-rw-r----- 1 root root 0 Nov 25 13:23 0
> +-rw-r----- 1 root root 0 Nov 25 13:23 1
> +-rw-r----- 1 root root 0 Nov 25 13:23 2
> +...
> +-rw-r----- 1 root root 0 Nov 25 13:23 55354
> +-rw-r----- 1 root root 0 Nov 25 13:23 55355
> +
> +For sequential write zone files, the file size changes as data is appended at
> +the end of the file, similarly to any regular file system.
> +
> +# dd if=/dev/zero of=/mnt/seq/0 bs=4096 count=1 conv=notrunc oflag=direct
> +1+0 records in
> +1+0 records out
> +4096 bytes (4.1 kB, 4.0 KiB) copied, 1.05112 s, 3.9 kB/s
> +
> +# ls -l /mnt/seq/0
> +-rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/seq/0
> +
> +The written file can be truncated to the zone size, preventing any further
> +write operation.
> +
> +# truncate -s 268435456 /mnt/seq/0
> +# ls -l /mnt/seq/0
> +-rw-r----- 1 root root 268435456 Nov 25 13:49 /mnt/seq/0
> +
> +Truncation to 0 size allows freeing the file zone storage space and restart
> +append-writes to the file.
> +
> +# truncate -s 0 /mnt/seq/0
> +# ls -l /mnt/seq/0
> +-rw-r----- 1 root root 0 Nov 25 13:49 /mnt/seq/0
> +
> +Since files are statically mapped to zones on the disk, the number of blocks of
> +a file as reported by stat() and fstat() indicates the size of the file zone.
> +
> +# stat /mnt/seq/0
> +  File: /mnt/seq/0
> +  Size: 0         	Blocks: 524288     IO Block: 4096   regular empty file
> +Device: 870h/2160d	Inode: 50431       Links: 1
> +Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)
> +Access: 2019-11-25 13:23:57.048971997 +0900
> +Modify: 2019-11-25 13:52:25.553805765 +0900
> +Change: 2019-11-25 13:52:25.553805765 +0900
> + Birth: -
> +
> +The number of blocks of the file ("Blocks") in units of 512B blocks gives the
> +maximum file size of 524288 * 512 B = 256 MB, corresponding to the device zone
> +size in this example. Of note is that the "IO block" field always indicates the
> +minimum IO size for writes and corresponds to the device physical sector size.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8eb6f02a1efa..66f348fa90df 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18292,6 +18292,7 @@ L:	linux-fsdevel@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
>  S:	Maintained
>  F:	fs/zonefs/
> +F:	Documentation/filesystems/zonefs.txt
>  
>  ZPOOL COMPRESSED PAGE STORAGE API
>  M:	Dan Streetman <ddstreet@ieee.org>
> -- 
> 2.24.1
> 
