Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5651014CB34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 14:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgA2NLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 08:11:31 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:26879 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgA2NLZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:11:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580303486; x=1611839486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w+XzMm1pEkj2Ta2QLykT0z8qy6FhXZA0BTq1of2kJew=;
  b=DZu00/35rOxYFj29MvE5VRUp+MR1PDr0vV2FsaMIiJmvxZP2fGSKLxcP
   NabB5EF+1IFPdWRSLdwEpbI0xk+r2S1hid0XbTo3YMUs9CMdJUbJL5pG7
   ztow6XEeUxTyQ8+IyoOKr8RboGTA5PlI0gqJNZFe8zmMWX4fDvtf2aqJ8
   PhwrDvHgcDtvfqVqiBjFbCSTvdWYv+IcaVNPHo0WcvsGaVKiopVsEt8p+
   Fm38NoyfZpJjBHLdk39owrt+B2DaVyDlAKjcv412x5RdNFdTwi/LriUWN
   7ZGvHYsG+lr1Z+LS/cpDLLy7cWLlIrhRusgL0FFGf3qT2Li2Z1/XYPWKi
   g==;
IronPort-SDR: gvuIu06k9uHwoncEBSSrbToiTIijNbCAc9b/W9wsC5MhhGY06zBbvqsryh+IRoQDi3Z1+rDVwP
 TYBbuOy7r2llFIPM4+edwTVwR5hc/RsmRpmiOEfNfHuClejQ63lhGFeTlPFS+oUXrF4qmkG3ch
 swohUJ6PmL2V45XqYR++I/C09zPEXWBV929BGWbJ4qObtfzkOzASXFSMr/pr+IEH0SbvoaxF8x
 MNhfxlEMxHqN0kIZQui/0SFfXQ9lKQMI19aXmFw/rdP4wDP3YoINMTCmgf29X+OJaLKxYfb38b
 xPg=
X-IronPort-AV: E=Sophos;i="5.70,378,1574092800"; 
   d="scan'208";a="133015489"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2020 21:11:25 +0800
IronPort-SDR: yfnbRxzLjRTXrqYpx4q1R7gSGoaQtfEBK8wBh9/Yu9DRifLQN/wsgdsNzKKOrMbRC3pG4ApFGp
 +Qnyx11f9hksN8yK2Ke/U3annRxrtAKpFJE0Vqlw1sG3hJ4iB5ZX8FXKenAk9ODBmVw0IW+Wmh
 0jC+scY59qvqJm0BomQqjIeE2xCktgzUy54UQIG3ULVojPUL8LrLIosvmGpPHi+4sYkjTs/t81
 SW6xKJ5WREvxBQA+AFYa/+rcy+vIJc2vv6tN9x5joLAFPtbCZKgF8DhxfUqgNpIUP9ycNeUHEA
 VTq+309iXNX/CXB93hxtSIzC
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2020 05:04:36 -0800
IronPort-SDR: 8d4ftQ5l0iRH7k11LGZVXwTLTRFZLcIC8FhtCf5Ml2nd6YAdK56PtbZkg/1MyfPyxte8tZm6iS
 v/Q+8N8WvV1t47XO+rNnPatCa1Stm9iF9iGJGgn1aVkAW9d5zISC2+1PN1Nt/sP88aRPURuMHD
 CYprE3kQ4JdV85ZgtBAK1h505ohsdd4Cr49EnYrXzdm5SKRhXuubuKWzb6CVwMl1AMD/HcxSaP
 4K5ojDXUSdugs2Ygq+mIGyjwocY+UBebTfM2z7cFks7zpvX6ml1VoHF0gRe/F0Y3zfKAXVZnYo
 4Tc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Jan 2020 05:11:22 -0800
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v10 2/2] zonefs: Add documentation
Date:   Wed, 29 Jan 2020 22:11:18 +0900
Message-Id: <20200129131118.998939-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200129131118.998939-1-damien.lemoal@wdc.com>
References: <20200129131118.998939-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the new file Documentation/filesystems/zonefs.txt to document
zonefs principles and user-space tool usage.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 Documentation/filesystems/zonefs.txt | 301 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 2 files changed, 302 insertions(+)
 create mode 100644 Documentation/filesystems/zonefs.txt

diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesystems/zonefs.txt
new file mode 100644
index 000000000000..3c14de9b70c3
--- /dev/null
+++ b/Documentation/filesystems/zonefs.txt
@@ -0,0 +1,301 @@
+ZoneFS - Zone filesystem for Zoned block devices
+
+Introduction
+============
+
+zonefs is a very simple file system exposing each zone of a zoned block device
+as a file. Unlike a regular POSIX-compliant file system with native zoned block
+device support (e.g. f2fs), zonefs does not hide the sequential write
+constraint of zoned block devices to the user. Files representing sequential
+write zones of the device must be written sequentially starting from the end
+of the file (append only writes).
+
+As such, zonefs is in essence closer to a raw block device access interface
+than to a full-featured POSIX file system. The goal of zonefs is to simplify
+the implementation of zoned block device support in applications by replacing
+raw block device file accesses with a richer file API, avoiding relying on
+direct block device file ioctls which may be more obscure to developers. One
+example of this approach is the implementation of LSM (log-structured merge)
+tree structures (such as used in RocksDB and LevelDB) on zoned block devices
+by allowing SSTables to be stored in a zone file similarly to a regular file
+system rather than as a range of sectors of the entire disk. The introduction
+of the higher level construct "one file is one zone" can help reducing the
+amount of changes needed in the application as well as introducing support for
+different application programming languages.
+
+Zoned block devices
+-------------------
+
+Zoned storage devices belong to a class of storage devices with an address
+space that is divided into zones. A zone is a group of consecutive LBAs and all
+zones are contiguous (there are no LBA gaps). Zones may have different types.
+* Conventional zones: there are no access constraints to LBAs belonging to
+  conventional zones. Any read or write access can be executed, similarly to a
+  regular block device.
+* Sequential zones: these zones accept random reads but must be written
+  sequentially. Each sequential zone has a write pointer maintained by the
+  device that keeps track of the mandatory start LBA position of the next write
+  to the device. As a result of this write constraint, LBAs in a sequential zone
+  cannot be overwritten. Sequential zones must first be erased using a special
+  command (zone reset) before rewriting.
+
+Zoned storage devices can be implemented using various recording and media
+technologies. The most common form of zoned storage today uses the SCSI Zoned
+Block Commands (ZBC) and Zoned ATA Commands (ZAC) interfaces on Shingled
+Magnetic Recording (SMR) HDDs.
+
+Solid State Disks (SSD) storage devices can also implement a zoned interface
+to, for instance, reduce internal write amplification due to garbage collection.
+The NVMe Zoned NameSpace (ZNS) is a technical proposal of the NVMe standard
+committee aiming at adding a zoned storage interface to the NVMe protocol.
+
+Zonefs Overview
+===============
+
+Zonefs exposes the zones of a zoned block device as files. The files
+representing zones are grouped by zone type, which are themselves represented
+by sub-directories. This file structure is built entirely using zone information
+provided by the device and so does not require any complex on-disk metadata
+structure.
+
+zonefs on-disk metadata
+-----------------------
+
+zonefs on-disk metadata is reduced to an immutable super block which
+persistently stores a magic number and optional feature flags and values. On
+mount, zonefs uses blkdev_report_zones() to obtain the device zone configuration
+and populates the mount point with a static file tree solely based on this
+information. File sizes come from the device zone type and write pointer
+position managed by the device itself.
+
+The super block is always written on disk at sector 0. The first zone of the
+device storing the super block is never exposed as a zone file by zonefs. If
+the zone containing the super block is a sequential zone, the mkzonefs format
+tool always "finishes" the zone, that is, it transitions the zone to a full
+state to make it read-only, preventing any data write.
+
+Zone type sub-directories
+-------------------------
+
+Files representing zones of the same type are grouped together under the same
+sub-directory automatically created on mount.
+
+For conventional zones, the sub-directory "cnv" is used. This directory is
+however created if and only if the device has usable conventional zones. If
+the device only has a single conventional zone at sector 0, the zone will not
+be exposed as a file as it will be used to store the zonefs super block. For
+such devices, the "cnv" sub-directory will not be created.
+
+For sequential write zones, the sub-directory "seq" is used.
+
+These two directories are the only directories that exist in zonefs. Users
+cannot create other directories and cannot rename nor delete the "cnv" and
+"seq" sub-directories.
+
+The size of the directories indicated by the st_size field of struct stat,
+obtained with the stat() or fstat() system calls, indicates the number of files
+existing under the directory.
+
+Zone files
+----------
+
+Zone files are named using the number of the zone they represent within the set
+of zones of a particular type. That is, both the "cnv" and "seq" directories
+contain files named "0", "1", "2", ... The file numbers also represent
+increasing zone start sector on the device.
+
+All read and write operations to zone files are not allowed beyond the file
+maximum size, that is, beyond the zone size. Any access exceeding the zone
+size is failed with the -EFBIG error.
+
+Creating, deleting, renaming or modifying any attribute of files and
+sub-directories is not allowed.
+
+The number of blocks of a file as reported by stat() and fstat() indicates the
+size of the file zone, or in other words, the maximum file size.
+
+Conventional zone files
+-----------------------
+
+The size of conventional zone files is fixed to the size of the zone they
+represent. Conventional zone files cannot be truncated.
+
+These files can be randomly read and written using any type of I/O operation:
+buffered I/Os, direct I/Os, memory mapped I/Os (mmap), etc. There are no I/O
+constraint for these files beyond the file size limit mentioned above.
+
+Sequential zone files
+---------------------
+
+The size of sequential zone files grouped in the "seq" sub-directory represents
+the file's zone write pointer position relative to the zone start sector.
+
+Sequential zone files can only be written sequentially, starting from the file
+end, that is, write operations can only be append writes. Zonefs makes no
+attempt at accepting random writes and will fail any write request that has a
+start offset not corresponding to the end of the file, or to the end of the last
+write issued and still in-flight (for asynchrnous I/O operations).
+
+Since dirty page writeback by the page cache does not guarantee a sequential
+write pattern, zonefs prevents buffered writes and writeable shared mappings
+on sequential files. Only direct I/O writes are accepted for these files.
+zonefs relies on the sequential delivery of write I/O requests to the device
+implemented by the block layer elevator. An elevator implementing the sequential
+write feature for zoned block device (ELEVATOR_F_ZBD_SEQ_WRITE elevator feature)
+must be used. This type of elevator (e.g. mq-deadline) is the set by default
+for zoned block devices on device initialization.
+
+There are no restrictions on the type of I/O used for read operations in
+sequential zone files. Buffered I/Os, direct I/Os and shared read mappings are
+all accepted.
+
+Truncating sequential zone files is allowed only down to 0, in which case, the
+zone is reset to rewind the file zone write pointer position to the start of
+the zone, or up to the zone size, in which case the file's zone is transitioned
+to the FULL state (finish zone operation).
+
+zonefs format options
+---------------------
+
+Several optional features of zonefs can be enabled at format time.
+* Conventional zone aggregation: ranges of contiguous conventional zones can be
+  aggregated into a single larger file instead of the default one file per zone.
+* File ownership: The owner UID and GID of zone files is by default 0 (root)
+  but can be changed to any valid UID/GID.
+* File access permissions: the default 640 access permissions can be changed.
+
+zonefs mount options
+--------------------
+
+zonefs defines several mount options allowing the user to define what to do in
+case of I/O errors and when inconsistencies between a file size and its zone
+write pointer position are discovered.
+
+These options are as follows.
+* errors=repair
+  Always adjust the size of a file to reflect the current position of the file
+  zone write pointer. This option will have an effect only on sequential zone
+  files.
+* errors=remount-ro
+  When a corrupted sequential zone is discovered, adjust the file size to the
+  zone write pointer position relative to the zone start sector and remount the
+  file system read-only, preventing any further write to all files.
+* errors=zone-ro
+  When a corrupted sequential zone is discovered, adjust the file size to the
+  zone write pointer offset within the zone and set the zone file as read-only,
+  preventing any further modification to the file.
+* errors=zone-offline
+  When a corrupted sequential zone is discovered, treat the zone as being
+  offline. This implies that the file size is changed to 0 and all read/write
+  accesses to the file disabled.
+
+A corrupted zone here is defined as a zone with a write pointer position
+relative to the zone start sector that is lower than the file size. This
+indicates that either an external action triggered a zone reset (eventually
+followed by write operations to the zone) or that the drive is defective.
+
+The other possible type of inconsistency between a sequential file size and
+its zone write pointer position can be caused by partial write failures (e.g.
+one BIO of a multi-bio large direct write fails). These inconsistencies are
+automatically repaired by zonefs without further action taken, regardless of
+the error processing option specified at mount time.
+
+Finally, defective drives may change the condition of any zone to offline
+(zone dead) or read-only. Such changes, when discovered with the IO errors they
+can cause, are handled automatically regardless of the options specified at
+mount time. For offline zones, the action taken is similar to the action defined
+by the errors=zone-offline mount option. FOr read-only zones, the action used is
+as defined by the errors=zone-ro mount option.
+
+Zonefs User Space Tools
+=======================
+
+The mkzonefs tool is used to format zoned block devices for use with zonefs.
+This tool is available on Github at:
+
+https://github.com/damien-lemoal/zonefs-tools
+
+zonefs-tools also includes a test suite which can be run against any zoned
+block device, including null_blk block device created with zoned mode.
+
+Examples
+--------
+
+The following formats a 15TB host-managed SMR HDD with 256 MB zones
+with the conventional zones aggregation feature enabled.
+
+# mkzonefs -o aggr_cnv /dev/sdX
+# mount -t zonefs /dev/sdX /mnt
+# ls -l /mnt/
+total 0
+dr-xr-xr-x 2 root root     1 Nov 25 13:23 cnv
+dr-xr-xr-x 2 root root 55356 Nov 25 13:23 seq
+
+The size of the zone files sub-directories indicate the number of files
+existing for each type of zones. In this example, there is only one
+conventional zone file (all conventional zones are aggregated under a single
+file).
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
+4096 bytes (4.1 kB, 4.0 KiB) copied, 0.00044121 s, 9.3 MB/s
+
+# ls -l /mnt/seq/0
+-rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/seq/0
+
+The written file can be truncated to the zone size, preventing any further
+write operation.
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
+minimum I/O size for writes and corresponds to the device physical sector size.
diff --git a/MAINTAINERS b/MAINTAINERS
index 089fd879632a..e9dcf8952573 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18311,6 +18311,7 @@ L:	linux-fsdevel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
 S:	Maintained
 F:	fs/zonefs/
+F:	Documentation/filesystems/zonefs.txt
 
 ZPOOL COMPRESSED PAGE STORAGE API
 M:	Dan Streetman <ddstreet@ieee.org>
-- 
2.24.1

