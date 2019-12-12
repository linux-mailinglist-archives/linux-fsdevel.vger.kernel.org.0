Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400CC11D5EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 19:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbfLLSi2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 13:38:28 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:21723 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbfLLSiW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 13:38:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576175903; x=1607711903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HWw4HPmaqj/DCogMiT3WeA1P5qRnG0HtpKKSt3LN+ec=;
  b=TbKIgu14cg9f+hp8m86GrlLAj5PDOaKd4f0Wl1vL4xE/QhzhCbotHzM1
   4tfIJCM7Glto8tc19KOU8eww7/m9xNbWadxlvnQjBBa6NxgKKWeqfn7gt
   rggfxjXiM3qhS4ooq2x3TbJ93tZzQUHRYKJp6AqfsRvYeX2ab4bwWAFLw
   PMM6V7bzEeE08kfxPUXPuVZFF0nUiPZU9St+YXgoRuYMsSFQtRidKEnEl
   sLathXV6NrjHezuvWNnBp98j2PWGKCEis7k9t0PnvXrLf0BYW9Mnt86kW
   eZiMX/fSJOcpKqWzj8qidryhUupYksllWmahdkXAlVhX90L58K9NlfwNR
   A==;
IronPort-SDR: PlH4wzhSvWnH5TqxL/gg0S3FN0EKdo4ZcY2qO5QdrPZYlGZcXj9UvGm7KzTzoMeWDFAEPXO+RQ
 izP1Ry6qRPXi6pTkJPIDemoJLLomoaf9RvEfED0HmOZ0FQFfrz448LGJjMKW58JhPws3SSzbDU
 iippTgyPTrgYV6ydqS3qb/yaGuMVpPSuCm65SzvFlC15t2idq/lLEa7fGcgtQqF4Om/bI8DAFL
 ypf19VWB3RVdFHA8l3CL6r+s6BmuEzFHbaBk+5ZydVZg7iIWepiN0kK6IrcJxaxydbqFehm0oA
 8Kk=
X-IronPort-AV: E=Sophos;i="5.69,306,1571673600"; 
   d="scan'208";a="129654460"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 02:38:22 +0800
IronPort-SDR: f8ZLBUuVAnGhIIbrQYrkDux53HkChJ7rqVxQoEa5xYuQOtHiqfuteRTpxk+8oQ5HWuLz3vs+vc
 LGyfxgqUEgRoIZSwxolr6aRBWADnfwcFchEvjXW0S4raEAae4PIJYymjGG/FMVM/84WCKicyJZ
 VuL2ogX8w8NmOy6rqTbBXNMNXA2GULRz3wnuaBfimCxFDfr227A9n1FyFq7gTYwUFBl378BQ6/
 3e066gpRNsylxShHPDSK0CFCeIAo1cXv0zbodf2+QSOClQGks7guVVc7EambX/aixHCIHZGNKM
 BBuZJC1a9JbZNzNAf7pXAxav
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 10:32:55 -0800
IronPort-SDR: uQaXpSGOE2pW11E0mSXYRIseDdhM58AfVwA8AQzfkrddDmTf6TApHLQlYvLqOo+Aqtke6IZPyo
 1r0hS3f3beh80SYGdiftoCjRAInwN7FB92aW4Z0zh/80BB8TdjYVnGoNB98OZatuurSLNur4xt
 8V9F7qxKu31PDYrcAuPcHVv91pk5WgCWhoVvf1njCkU67N4V4u7aTeSMTgeTmWxnrmxWdMyvvv
 YA8ohRsAXHBFTwLzqKsSBVcXHU610/1WZ4JguYVuKtHCUimPz18ilAN7OoY8zTx1rce5I3e3It
 ltM=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 10:38:20 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] zonefs: Add documentation
Date:   Fri, 13 Dec 2019 03:38:16 +0900
Message-Id: <20191212183816.102402-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212183816.102402-1-damien.lemoal@wdc.com>
References: <20191212183816.102402-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the new file Documentation/filesystems/zonefs.txt to document zonefs
principles and user-space tool usage.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/filesystems/zonefs.txt | 150 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 2 files changed, 151 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt

diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesystems/zonefs.txt
new file mode 100644
index 000000000000..e5d798f4087d
--- /dev/null
+++ b/Documentation/filesystems/zonefs.txt
@@ -0,0 +1,150 @@
+ZoneFS - Zone filesystem for Zoned block devices
+
+Overview
+========
+
+zonefs is a very simple file system exposing each zone of a zoned block device
+as a file. Unlike a regular file system with zoned block device support (e.g.
+f2fs), zonefs does not hide the sequential write constraint of zoned block
+devices to the user. Files representing sequential write zones of the device
+must be written sequentially starting from the end of the file (append only
+writes).
+
+As such, zonefs is in essence closer to a raw block device access interface
+than to a full featured POSIX file system. The goal of zonefs is to simplify
+the implementation of zoned block devices support in applications by replacing
+raw block device file accesses with a richer file API, avoiding relying on
+direct block device file ioctls which may be more obscure to developers. One
+example of this approach is the implementation of LSM (log-structured merge)
+tree structures (such as used in RocksDB and LevelDB) on zoned block devices by
+allowing SSTables to be stored in a zone file similarly to a regular file system
+rather than as a range of sectors of the entire disk. The introduction of the
+higher level construct "one file is one zone" can help reducing the amount of
+changes needed in the application as well as introducing support for different
+application programming languages.
+
+zonefs on-disk metadata is reduced to a super block which persistently stores a
+magic number and optional features flags and values. On mount, zonefs uses
+blkdev_report_zones() to obtain the device zone configuration and populates
+the mount point with a static file tree solely based on this information.
+E.g. file sizes come from the device zone type and write pointer offset managed
+by the device itself.
+
+The zone files created on mount have the following characteristics.
+1) Files representing zones of the same type are grouped together
+   under the same sub-directory:
+  * For conventional zones, the sub-directory "cnv" is used.
+  * For sequential write zones, the sub-directory "seq" is used.
+  These two directories are the only directories that exist in zonefs. Users
+  cannot create other directories and cannot rename nor delete the "cnv" and
+  "seq" sub-directories.
+2) The name of zone files is the number of the file within the zone type
+   sub-directory, in order of increasing zone start sector.
+3) The size of conventional zone files is fixed to the device zone size.
+   Conventional zone files cannot be truncated.
+4) The size of sequential zone files represent the file's zone write pointer
+   position relative to the zone start sector. Truncating these files is
+   allowed only down to 0, in wich case, the zone is reset to rewind the file
+   zone write pointer position to the start of the zone, or up to the zone size,
+   in which case the file's zone is transitioned to the FULL state (finish zone
+   operation).
+5) All read and write operations to files are not allowed beyond the file zone
+   size. Any access exceeding the zone size is failed with the -EFBIG error.
+6) Creating, deleting, renaming or modifying any attribute of files and
+   sub-directories is not allowed.
+
+Several optional features of zonefs can be enabled at format time.
+* Conventional zone aggregation: ranges of contiguous conventional zones can be
+  agregated into a single larger file instead of the default one file per zone.
+* File ownership: The owner UID and GID of zone files is by default 0 (root)
+  but can be changed to any valid UID/GID.
+* File access permissions: the default 640 access permissions can be changed.
+
+User Space Tools
+================
+
+The mkzonefs tool is used to format zoned block devices for use with zonefs.
+This tool is available on Github at:
+
+git@github.com:damien-lemoal/zonefs-tools.git.
+
+zonefs-tools also includes a test suite which can be run against any zoned
+block device, including null_blk block device created with zoned mode.
+
+Example: the following formats a 15TB host-managed SMR HDD with 256 MB zones
+with the conventional zones aggregation feature enabled.
+
+# mkzonefs -o aggr_cnv /dev/sdX
+# mount -t zonefs /dev/sdX /mnt
+# ls -l /mnt/
+total 0
+dr-xr-xr-x 2 root root     1 Nov 25 13:23 cnv
+dr-xr-xr-x 2 root root 55356 Nov 25 13:23 seq
+
+The size of the zone files sub-directories indicate the number of files existing
+for each type of zones. In this example, there is only one conventional zone
+file (all conventional zones are agreggated under a single file).
+
+# ls -l /mnt/cnv
+total 137101312
+-rw-r----- 1 root root 140391743488 Nov 25 13:23 0
+
+This aggregated conventional zone file can be used as a regular file.
+
+# mkfs.ext4 /mnt/cnv/0
+# mount -o loop /mnt/cnv/0 /data
+
+The "seq" sub-directory grouping files for sequential write zones has in this
+example 55356 zones.
+
+# ls -lv /mnt/seq
+total 14511243264
+-rw-r----- 1 root root 0 Nov 25 13:23 0
+-rw-r----- 1 root root 0 Nov 25 13:23 1
+-rw-r----- 1 root root 0 Nov 25 13:23 2
+...
+-rw-r----- 1 root root 0 Nov 25 13:23 55354
+-rw-r----- 1 root root 0 Nov 25 13:23 55355
+
+For sequential write zone files, the file size changes as data is appended at
+the end of the file, similarly to any regular file system.
+
+# dd if=/dev/zero of=/mnt/seq/0 bs=4096 count=1 conv=notrunc oflag=direct
+1+0 records in
+1+0 records out
+4096 bytes (4.1 kB, 4.0 KiB) copied, 1.05112 s, 3.9 kB/s
+
+# ls -l /mnt/seq/0
+-rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/sdh/seq/0
+
+The written file can be truncated to the zone size, prventing any further write
+operation.
+
+# truncate -s 268435456 /mnt/seq/0
+# ls -l /mnt/seq/0
+-rw-r----- 1 root root 268435456 Nov 25 13:49 /mnt/seq/0
+
+Truncation to 0 size allows freeing the file zone storage space and restart
+append-writes to the file.
+
+# truncate -s 0 /mnt/seq/0
+# ls -l /mnt/seq/0
+-rw-r----- 1 root root 0 Nov 25 13:49 /mnt/seq/0
+
+Since files are statically mapped to zones on the disk, the number of blocks of
+a file as reported by stat() and fstat() indicates the size of the file zone.
+
+# stat /mnt/seq/0
+  File: /mnt/seq/0
+  Size: 0         	Blocks: 524288     IO Block: 4096   regular empty file
+Device: 870h/2160d	Inode: 50431       Links: 1
+Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)
+Access: 2019-11-25 13:23:57.048971997 +0900
+Modify: 2019-11-25 13:52:25.553805765 +0900
+Change: 2019-11-25 13:52:25.553805765 +0900
+ Birth: -
+
+The number of blocks of the file ("Blocks") in units of 512B blocks gives the
+maximum file size of 524288 * 512 B = 256 MB, corresponding to the device zone
+size in this example. Of note is that the "IO block" field always indicates the
+minimum IO size for writes and corresponds to the device physical sector size.
diff --git a/MAINTAINERS b/MAINTAINERS
index 0641167ed2ea..1c760735e906 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18290,6 +18290,7 @@ L:	linux-fsdevel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
 S:	Maintained
 F:	fs/zonefs/
+F:	Documentation/filesystems/zonefs.txt
 
 ZPOOL COMPRESSED PAGE STORAGE API
 M:	Dan Streetman <ddstreet@ieee.org>
-- 
2.23.0

