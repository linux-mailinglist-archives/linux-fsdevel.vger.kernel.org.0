Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD57213BC7F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729439AbgAOJgL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 04:36:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:55304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729274AbgAOJgK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:36:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 24883AC6E;
        Wed, 15 Jan 2020 09:36:06 +0000 (UTC)
Subject: Re: [PATCH v7 1/2] fs: New zonefs file system
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
References: <20200115062859.1389827-1-damien.lemoal@wdc.com>
 <20200115062859.1389827-2-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <c2aad064-a8a8-e1fa-28ca-b18c5be1f0b7@suse.de>
Date:   Wed, 15 Jan 2020 10:36:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200115062859.1389827-2-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/15/20 7:28 AM, Damien Le Moal wrote:
> zonefs is a very simple file system exposing each zone of a zoned block
> device as a file. Unlike a regular file system with zoned block device
> support (e.g. f2fs), zonefs does not hide the sequential write
> constraint of zoned block devices to the user. Files representing
> sequential write zones of the device must be written sequentially
> starting from the end of the file (append only writes).
> 
> As such, zonefs is in essence closer to a raw block device access
> interface than to a full featured POSIX file system. The goal of zonefs
> is to simplify the implementation of zoned block device support in
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
> persistently store a magic number and optional feature flags and
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
>    files is allowed only down to 0, in which case, the zone is reset to
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
>   zones can be aggregated into a single larger file instead of the
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
> conventional zone file (all conventional zones are aggregated under a
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
> 4096 bytes (4.1 kB, 4.0 KiB) copied, 0.000452219 s, 9.1 MB/s
> 
> $ ls -l /mnt/seq/0
> -rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/seq/0
> 
> The written file can be truncated to the zone size, preventing any
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
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  MAINTAINERS                |    9 +
>  fs/Kconfig                 |    1 +
>  fs/Makefile                |    1 +
>  fs/zonefs/Kconfig          |    9 +
>  fs/zonefs/Makefile         |    4 +
>  fs/zonefs/super.c          | 1177 ++++++++++++++++++++++++++++++++++++
>  fs/zonefs/zonefs.h         |  175 ++++++
>  include/uapi/linux/magic.h |    1 +
>  8 files changed, 1377 insertions(+)
>  create mode 100644 fs/zonefs/Kconfig
>  create mode 100644 fs/zonefs/Makefile
>  create mode 100644 fs/zonefs/super.c
>  create mode 100644 fs/zonefs/zonefs.h
> 

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Felix Imendörffer
