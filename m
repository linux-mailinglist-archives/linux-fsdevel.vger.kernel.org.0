Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 545D29ACDB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404898AbfHWKMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:12:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:49180 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404700AbfHWKML (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:12:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 20994B06B;
        Fri, 23 Aug 2019 10:12:10 +0000 (UTC)
Subject: Re: [PATCH V3] fs: New zonefs file system
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Matias Bjorling <matias.bjorling@wdc.com>
References: <20190821070308.28665-1-damien.lemoal@wdc.com>
From:   Hannes Reinecke <hare@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=hare@suse.de; prefer-encrypt=mutual; keydata=
 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
 azzYF4VRJsdl+d0MCaSy8mUh
Message-ID: <5b52c0d5-fc9c-f671-a31f-7b828c767788@suse.de>
Date:   Fri, 23 Aug 2019 12:12:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190821070308.28665-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/19 9:03 AM, Damien Le Moal wrote:
> zonefs is a very simple file system exposing each zone of a zoned
> block device as a file. zonefs is in fact closer to a raw block device
> access interface than to a full feature POSIX file system.
> 
> The goal of zonefs is to simplify implementation of zoned block device
> raw access by applications by allowing switching to the well known POSIX
> file API rather than relying on direct block device file ioctls and
> read/write. Zonefs, for instance, greatly simplifies the implementation
> of LSM (log-structured merge) tree structures (such as used in RocksDB
> and LevelDB) on zoned block devices by allowing SSTables to be stored in
> a zone file similarly to a regular file system architecture, hence
> reducing the amount of change needed in the application.
> 
> Zonefs on-disk metadata is reduced to a super block to store a magic
> number, a uuid and optional features flags and values. On mount, zonefs
> uses blkdev_report_zones() to obtain the device zone configuration and
> populates the mount point with a static file tree solely based on this
> information. E.g. file sizes come from zone write pointer offset managed
> by the device itself.
> 
> The zone files created on mount have the following characteristics.
> 1) Files representing zones of the same type are grouped together
>    under a common directory:
>   * For conventional zones, the directory "cnv" is used.
>   * For sequential write zones, the directory "seq" is used.
>   These two directories are the only directories that exist in zonefs.
>   Users cannot create other directories and cannot rename nor delete
>   the "cnv" and "seq" directories.
> 2) The name of zone files is by default the number of the file within
>    the zone type directory, in order of increasing zone start sector.
> 3) The size of conventional zone files is fixed to the device zone size.
>    Conventional zone files cannot be truncated.
> 4) The size of sequential zone files represent the file zone write
>    pointer position relative to the zone start sector. Truncating these
>    files is allowed only down to 0, in wich case, the zone is reset to
>    rewind the file zone write pointer position to the start of the zone.
> 5) All read and write operations to files are not allowed beyond the
>    file zone size. Any access exceeding the zone size is failed with
>    the -EFBIG error.
> 6) Creating, deleting, renaming or modifying any attribute of files
>    and directories is not allowed. The only exception being the file
>    size of sequential zone files which can be modified by write
>    operations or truncation to 0.
> 
> Several optional features of zonefs can be enabled at format time.
> * Conventional zone aggregation: contiguous conventional zones can be
>   agregated into a single larger file instead of multiple per-zone
>   files.
> * File naming: the default file number file name can be switched to
>   using the base-10 value of the file zone start sector.
> * File ownership: The owner UID and GID of zone files is by default 0
>   (root) but can be changed to any valid UID/GID.
> * File access permissions: the default 640 access permissions can be
>   changed.
> 
> The mkzonefs tool is used to format zonefs. This tool is available
> on Github at: git@github.com:damien-lemoal/zonefs-tools.git.
> zonefs-tools includes a simple test suite which can be run against any
> zoned block device, including null_blk block device created with zoned
> mode.
> 
> Example: the following formats a host-managed SMR HDD with the
> conventional zone aggregation feature enabled.
> 
> mkzonefs -o aggr_cnv /dev/sdX
> mount -t zonefs /dev/sdX /mnt
> ls -l /mnt/
> total 0
> dr-xr-xr-x 2 root root 0 Apr 11 13:00 cnv
> dr-xr-xr-x 2 root root 0 Apr 11 13:00 seq
> 
> ls -l /mnt/cnv
> total 137363456
> -rw-rw---- 1 root root 140660178944 Apr 11 13:00 0
> 
> ls -Fal -v /mnt/seq
> total 14511243264
> dr-xr-xr-x 2 root root 15942528 Jul 10 11:53 ./
> drwxr-xr-x 4 root root     1152 Jul 10 11:53 ../
> -rw-r----- 1 root root        0 Jul 10 11:53 0
> -rw-r----- 1 root root 33554432 Jul 10 13:43 1
> -rw-r----- 1 root root        0 Jul 10 11:53 2
> -rw-r----- 1 root root        0 Jul 10 11:53 3
> ...
> 
> The aggregated conventional zone file can be used as a regular file.
> Operations such as the following work.
> 
> mkfs.ext4 /mnt/cnv/0
> mount -o loop /mnt/cnv/0 /data
> 
> Contains contributions from Johannes Thumshirn <jthumshirn@suse.de>
> and Christoph Hellwig <hch@lst.de>.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
> Changes from v2:
> * Addressed comments from Darrick: Typo, added checksum to super block,
>   enhance cheks of the super block fields validity (used reserved bytes
>   and unknown features bits)
> * Rebased on XFS tree iomap-for-next branch
> 
> Changes from v1:
> * Rebased on latest iomap branch iomap-5.4-merge of XFS tree at
>   git://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
> * Addressed all comments from Dave Chinner and others
> 
>  MAINTAINERS                |   10 +
>  fs/Kconfig                 |    2 +
>  fs/Makefile                |    1 +
>  fs/zonefs/Kconfig          |    9 +
>  fs/zonefs/Makefile         |    4 +
>  fs/zonefs/super.c          | 1083 ++++++++++++++++++++++++++++++++++++
>  fs/zonefs/zonefs.h         |  177 ++++++
>  include/uapi/linux/magic.h |    1 +
>  8 files changed, 1287 insertions(+)
>  create mode 100644 fs/zonefs/Kconfig
>  create mode 100644 fs/zonefs/Makefile
>  create mode 100644 fs/zonefs/super.c
>  create mode 100644 fs/zonefs/zonefs.h
> 
[ .. ]
> @@ -261,6 +262,7 @@ source "fs/romfs/Kconfig"
>  source "fs/pstore/Kconfig"
>  source "fs/sysv/Kconfig"
>  source "fs/ufs/Kconfig"
> +source "fs/ufs/Kconfig"
>  
>  endif # MISC_FILESYSTEMS
>  
Hmm?
Duplicate line?

> diff --git a/fs/Makefile b/fs/Makefile
> index d60089fd689b..7d3c90e1ad79 100644
> --- a/fs/Makefile
> +++ b/fs/Makefile
> @@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
>  obj-$(CONFIG_CEPH_FS)		+= ceph/
>  obj-$(CONFIG_PSTORE)		+= pstore/
>  obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
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
> index 000000000000..5521c21fd34b
> --- /dev/null
> +++ b/fs/zonefs/super.c
[ .. ]

That whole thing looks good to me (with my limited fs skills :-),
however, some things I'd like to have clarified:

- zone state handling:
While you do have some handling for offline zones, I'm missing a
handling during normal I/O. Surely a zone can go offline via other means
(like the admin calling nasty user-space programs), which then would
result in an I/O error in the filesystem.
Shouldn't we handle this case when doing error handling?
IE shouldn't we look at the zone state when doing a REPORT ZONES, and
update it if required?
Similarly: How do we present zones which are not accessible? Will they
still show up in the directory? I think they should, but we should be
returning an error to userspace like EPERM or somesuch.

- zone sizes:
From what I've seen sequential zones can be appended to, ie they'll
start off at 0 and will increase in size. Conventional zones, OTOH,
apparently always have a fixed size. Is that correct?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      Teamlead Storage & Networking
hare@suse.de			                  +49 911 74053 688
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 247165 (AG München), GF: Felix Imendörffer
