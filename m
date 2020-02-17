Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C36B16174F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgBQQNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47216 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729702AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KSxB+t1J6pAt1YUMmfwIBlCvZLRwWTHsFEXXGPYwZ8Y=; b=I7OhnJpc4UkchnK7IJVo9APiIc
        DrtQiXqBYv5E2UC36ZDz7YgVG+VLkwYHw5E3XEPQTwRjBz0UJzhyK7gyYpqzjc0mkgjDLp1AWbehf
        jwOVlITW1XKbH8XO8S7B5aGYKCU9CNX/omS5lEdGf/Tv4tzlHukuhyJH4SZL1FAvhHXC7RBmhRpOm
        ZvaYxn2+7/PNCiv9kAgumaYFIRZszibdq/QhvNi2UsjHcZCBqFgmuvcP8KeGfXRLMTiB6B/IbzigU
        IVzEP+R3uKNnjpxShE8EZ/Z1yfl/LhjLT51viqaWf85e0UTl9kjHsWjwOyUaN3w9Y4E8OG2v68j3w
        arsgaEzA==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006ug-B3; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000faO-Af; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH 18/44] docs: filesystems: convert f2fs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:04 +0100
Message-Id: <8dd156320b0c015dec6d3f848d03ea057042a15b.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Adjust document and section titles;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{f2fs.txt => f2fs.rst}        | 252 ++++++++++--------
 Documentation/filesystems/index.rst           |   1 +
 2 files changed, 143 insertions(+), 110 deletions(-)
 rename Documentation/filesystems/{f2fs.txt => f2fs.rst} (84%)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.rst
similarity index 84%
rename from Documentation/filesystems/f2fs.txt
rename to Documentation/filesystems/f2fs.rst
index 4eb3e2ddd00e..d681203728d7 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.rst
@@ -1,6 +1,8 @@
-================================================================================
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================================
 WHAT IS Flash-Friendly File System (F2FS)?
-================================================================================
+==========================================
 
 NAND flash memory-based storage devices, such as SSD, eMMC, and SD cards, have
 been equipped on a variety systems ranging from mobile to server systems. Since
@@ -20,14 +22,15 @@ layout, but also for selecting allocation and cleaning algorithms.
 
 The following git tree provides the file system formatting tool (mkfs.f2fs),
 a consistency checking tool (fsck.f2fs), and a debugging tool (dump.f2fs).
->> git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git
+
+- git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git
 
 For reporting bugs and sending patches, please use the following mailing list:
->> linux-f2fs-devel@lists.sourceforge.net
 
-================================================================================
-BACKGROUND AND DESIGN ISSUES
-================================================================================
+- linux-f2fs-devel@lists.sourceforge.net
+
+Background and Design issues
+============================
 
 Log-structured File System (LFS)
 --------------------------------
@@ -61,6 +64,7 @@ needs to reclaim these obsolete blocks seamlessly to users. This job is called
 as a cleaning process.
 
 The process consists of three operations as follows.
+
 1. A victim segment is selected through referencing segment usage table.
 2. It loads parent index structures of all the data in the victim identified by
    segment summary blocks.
@@ -71,9 +75,8 @@ This cleaning job may cause unexpected long delays, so the most important goal
 is to hide the latencies to users. And also definitely, it should reduce the
 amount of valid data to be moved, and move them quickly as well.
 
-================================================================================
-KEY FEATURES
-================================================================================
+Key Features
+============
 
 Flash Awareness
 ---------------
@@ -94,10 +97,11 @@ Cleaning Overhead
 - Support multi-head logs for static/dynamic hot and cold data separation
 - Introduce adaptive logging for efficient block allocation
 
-================================================================================
-MOUNT OPTIONS
-================================================================================
+Mount Options
+=============
 
+
+====================== ============================================================
 background_gc=%s       Turn on/off cleaning operations, namely garbage
                        collection, triggered in background when I/O subsystem is
                        idle. If background_gc=on, it will turn on the garbage
@@ -167,7 +171,10 @@ fault_injection=%d     Enable fault injection in all supported types with
 fault_type=%d          Support configuring fault injection type, should be
                        enabled with fault_injection option, fault type value
                        is shown below, it supports single or combined type.
+
+                       ===================	===========
                        Type_Name		Type_Value
+                       ===================	===========
                        FAULT_KMALLOC		0x000000001
                        FAULT_KVMALLOC		0x000000002
                        FAULT_PAGE_ALLOC		0x000000004
@@ -183,6 +190,7 @@ fault_type=%d          Support configuring fault injection type, should be
                        FAULT_CHECKPOINT		0x000001000
                        FAULT_DISCARD		0x000002000
                        FAULT_WRITE_IO		0x000004000
+                       ===================	===========
 mode=%s                Control block allocation mode which supports "adaptive"
                        and "lfs". In "lfs" mode, there should be no random
                        writes towards main area.
@@ -219,7 +227,7 @@ fsync_mode=%s          Control the policy of fsync. Currently supports "posix",
                        non-atomic files likewise "nobarrier" mount option.
 test_dummy_encryption  Enable dummy encryption, which provides a fake fscrypt
                        context. The fake fscrypt context is used by xfstests.
-checkpoint=%s[:%u[%]]     Set to "disable" to turn off checkpointing. Set to "enable"
+checkpoint=%s[:%u[%]]  Set to "disable" to turn off checkpointing. Set to "enable"
                        to reenable checkpointing. Is enabled by default. While
                        disabled, any unmounting or unexpected shutdowns will cause
                        the filesystem contents to appear as they did when the
@@ -246,22 +254,22 @@ compress_extension=%s  Support adding specified extension, so that f2fs can enab
                        on compression extension list and enable compression on
                        these file by default rather than to enable it via ioctl.
                        For other files, we can still enable compression via ioctl.
+====================== ============================================================
 
-================================================================================
-DEBUGFS ENTRIES
-================================================================================
+Debugfs Entries
+===============
 
 /sys/kernel/debug/f2fs/ contains information about all the partitions mounted as
 f2fs. Each file shows the whole f2fs information.
 
 /sys/kernel/debug/f2fs/status includes:
+
  - major file system information managed by f2fs currently
  - average SIT information about whole segments
  - current memory footprint consumed by f2fs.
 
-================================================================================
-SYSFS ENTRIES
-================================================================================
+Sysfs Entries
+=============
 
 Information about mounted f2fs file systems can be found in
 /sys/fs/f2fs.  Each mounted filesystem will have a directory in
@@ -271,22 +279,24 @@ The files in each per-device directory are shown in table below.
 Files in /sys/fs/f2fs/<devname>
 (see also Documentation/ABI/testing/sysfs-fs-f2fs)
 
-================================================================================
-USAGE
-================================================================================
+Usage
+=====
 
 1. Download userland tools and compile them.
 
 2. Skip, if f2fs was compiled statically inside kernel.
-   Otherwise, insert the f2fs.ko module.
- # insmod f2fs.ko
+   Otherwise, insert the f2fs.ko module::
 
-3. Create a directory trying to mount
- # mkdir /mnt/f2fs
+	# insmod f2fs.ko
 
-4. Format the block device, and then mount as f2fs
- # mkfs.f2fs -l label /dev/block_device
- # mount -t f2fs /dev/block_device /mnt/f2fs
+3. Create a directory trying to mount::
+
+	# mkdir /mnt/f2fs
+
+4. Format the block device, and then mount as f2fs::
+
+	# mkfs.f2fs -l label /dev/block_device
+	# mount -t f2fs /dev/block_device /mnt/f2fs
 
 mkfs.f2fs
 ---------
@@ -294,18 +304,26 @@ The mkfs.f2fs is for the use of formatting a partition as the f2fs filesystem,
 which builds a basic on-disk layout.
 
 The options consist of:
--l [label]   : Give a volume label, up to 512 unicode name.
--a [0 or 1]  : Split start location of each area for heap-based allocation.
-               1 is set by default, which performs this.
--o [int]     : Set overprovision ratio in percent over volume size.
-               5 is set by default.
--s [int]     : Set the number of segments per section.
-               1 is set by default.
--z [int]     : Set the number of sections per zone.
-               1 is set by default.
--e [str]     : Set basic extension list. e.g. "mp3,gif,mov"
--t [0 or 1]  : Disable discard command or not.
-               1 is set by default, which conducts discard.
+
+===============    ===========================================================
+``-l [label]``     Give a volume label, up to 512 unicode name.
+``-a [0 or 1]``    Split start location of each area for heap-based allocation.
+
+                   1 is set by default, which performs this.
+``-o [int]``       Set overprovision ratio in percent over volume size.
+
+                   5 is set by default.
+``-s [int]``       Set the number of segments per section.
+
+                   1 is set by default.
+``-z [int]``       Set the number of sections per zone.
+
+                   1 is set by default.
+``-e [str]``       Set basic extension list. e.g. "mp3,gif,mov"
+``-t [0 or 1]``    Disable discard command or not.
+
+                   1 is set by default, which conducts discard.
+===============    ===========================================================
 
 fsck.f2fs
 ---------
@@ -314,7 +332,8 @@ partition, which examines whether the filesystem metadata and user-made data
 are cross-referenced correctly or not.
 Note that, initial version of the tool does not fix any inconsistency.
 
-The options consist of:
+The options consist of::
+
   -d debug level [default:0]
 
 dump.f2fs
@@ -327,20 +346,21 @@ It shows on-disk inode information recognized by a given inode number, and is
 able to dump all the SSA and SIT entries into predefined files, ./dump_ssa and
 ./dump_sit respectively.
 
-The options consist of:
+The options consist of::
+
   -d debug level [default:0]
   -i inode no (hex)
   -s [SIT dump segno from #1~#2 (decimal), for all 0~-1]
   -a [SSA dump segno from #1~#2 (decimal), for all 0~-1]
 
-Examples:
-# dump.f2fs -i [ino] /dev/sdx
-# dump.f2fs -s 0~-1 /dev/sdx (SIT dump)
-# dump.f2fs -a 0~-1 /dev/sdx (SSA dump)
+Examples::
 
-================================================================================
-DESIGN
-================================================================================
+    # dump.f2fs -i [ino] /dev/sdx
+    # dump.f2fs -s 0~-1 /dev/sdx (SIT dump)
+    # dump.f2fs -a 0~-1 /dev/sdx (SSA dump)
+
+Design
+======
 
 On-disk Layout
 --------------
@@ -351,7 +371,7 @@ consists of a set of sections. By default, section and zone sizes are set to one
 segment size identically, but users can easily modify the sizes by mkfs.
 
 F2FS splits the entire volume into six areas, and all the areas except superblock
-consists of multiple segments as described below.
+consists of multiple segments as described below::
 
                                             align with the zone size <-|
                  |-> align with the segment size
@@ -373,28 +393,28 @@ consists of multiple segments as described below.
 	                            |__zone__|
 
 - Superblock (SB)
- : It is located at the beginning of the partition, and there exist two copies
+   It is located at the beginning of the partition, and there exist two copies
    to avoid file system crash. It contains basic partition information and some
    default parameters of f2fs.
 
 - Checkpoint (CP)
- : It contains file system information, bitmaps for valid NAT/SIT sets, orphan
+   It contains file system information, bitmaps for valid NAT/SIT sets, orphan
    inode lists, and summary entries of current active segments.
 
 - Segment Information Table (SIT)
- : It contains segment information such as valid block count and bitmap for the
+   It contains segment information such as valid block count and bitmap for the
    validity of all the blocks.
 
 - Node Address Table (NAT)
- : It is composed of a block address table for all the node blocks stored in
+   It is composed of a block address table for all the node blocks stored in
    Main area.
 
 - Segment Summary Area (SSA)
- : It contains summary entries which contains the owner information of all the
+   It contains summary entries which contains the owner information of all the
    data and node blocks stored in Main area.
 
 - Main Area
- : It contains file and directory data including their indices.
+   It contains file and directory data including their indices.
 
 In order to avoid misalignment between file system and flash-based storage, F2FS
 aligns the start block address of CP with the segment size. Also, it aligns the
@@ -414,7 +434,7 @@ One of them always indicates the last valid data, which is called as shadow copy
 mechanism. In addition to CP, NAT and SIT also adopt the shadow copy mechanism.
 
 For file system consistency, each CP points to which NAT and SIT copies are
-valid, as shown as below.
+valid, as shown as below::
 
   +--------+----------+---------+
   |   CP   |    SIT   |   NAT   |
@@ -438,7 +458,7 @@ indirect node. F2FS assigns 4KB to an inode block which contains 923 data block
 indices, two direct node pointers, two indirect node pointers, and one double
 indirect node pointer as described below. One direct node block contains 1018
 data blocks, and one indirect node block contains also 1018 node blocks. Thus,
-one inode block (i.e., a file) covers:
+one inode block (i.e., a file) covers::
 
   4KB * (923 + 2 * 1018 + 2 * 1018 * 1018 + 1018 * 1018 * 1018) := 3.94TB.
 
@@ -473,6 +493,8 @@ A dentry block consists of 214 dentry slots and file names. Therein a bitmap is
 used to represent whether each dentry is valid or not. A dentry block occupies
 4KB with the following composition.
 
+::
+
   Dentry Block(4 K) = bitmap (27 bytes) + reserved (3 bytes) +
 	              dentries(11 * 214 bytes) + file name (8 * 214 bytes)
 
@@ -498,23 +520,25 @@ F2FS implements multi-level hash tables for directory structure. Each level has
 a hash table with dedicated number of hash buckets as shown below. Note that
 "A(2B)" means a bucket includes 2 data blocks.
 
-----------------------
-A : bucket
-B : block
-N : MAX_DIR_HASH_DEPTH
-----------------------
+::
 
-level #0   | A(2B)
-           |
-level #1   | A(2B) - A(2B)
-           |
-level #2   | A(2B) - A(2B) - A(2B) - A(2B)
-     .     |   .       .       .       .
-level #N/2 | A(2B) - A(2B) - A(2B) - A(2B) - A(2B) - ... - A(2B)
-     .     |   .       .       .       .
-level #N   | A(4B) - A(4B) - A(4B) - A(4B) - A(4B) - ... - A(4B)
+    ----------------------
+    A : bucket
+    B : block
+    N : MAX_DIR_HASH_DEPTH
+    ----------------------
 
-The number of blocks and buckets are determined by,
+    level #0   | A(2B)
+	    |
+    level #1   | A(2B) - A(2B)
+	    |
+    level #2   | A(2B) - A(2B) - A(2B) - A(2B)
+	.     |   .       .       .       .
+    level #N/2 | A(2B) - A(2B) - A(2B) - A(2B) - A(2B) - ... - A(2B)
+	.     |   .       .       .       .
+    level #N   | A(4B) - A(4B) - A(4B) - A(4B) - A(4B) - ... - A(4B)
+
+The number of blocks and buckets are determined by::
 
                             ,- 2, if n < MAX_DIR_HASH_DEPTH / 2,
   # of blocks in level #n = |
@@ -532,7 +556,7 @@ dentry consisting of the file name and its inode number. If not found, F2FS
 scans the next hash table in level #1. In this way, F2FS scans hash tables in
 each levels incrementally from 1 to N. In each levels F2FS needs to scan only
 one bucket determined by the following equation, which shows O(log(# of files))
-complexity.
+complexity::
 
   bucket number to scan in level #n = (hash value) % (# of buckets in level #n)
 
@@ -540,7 +564,8 @@ In the case of file creation, F2FS finds empty consecutive slots that cover the
 file name. F2FS searches the empty slots in the hash tables of whole levels from
 1 to N in the same way as the lookup operation.
 
-The following figure shows an example of two cases holding children.
+The following figure shows an example of two cases holding children::
+
        --------------> Dir <--------------
        |                                 |
     child                             child
@@ -611,14 +636,15 @@ Write-hint Policy
 2) whint_mode=user-based. F2FS tries to pass down hints given by
 users.
 
+===================== ======================== ===================
 User                  F2FS                     Block
-----                  ----                     -----
+===================== ======================== ===================
                       META                     WRITE_LIFE_NOT_SET
                       HOT_NODE                 "
                       WARM_NODE                "
                       COLD_NODE                "
-*ioctl(COLD)          COLD_DATA                WRITE_LIFE_EXTREME
-*extension list       "                        "
+ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
+extension list        "                        "
 
 -- buffered io
 WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
@@ -635,11 +661,13 @@ WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
 WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
 WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
 WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
+===================== ======================== ===================
 
 3) whint_mode=fs-based. F2FS passes down hints with its policy.
 
+===================== ======================== ===================
 User                  F2FS                     Block
-----                  ----                     -----
+===================== ======================== ===================
                       META                     WRITE_LIFE_MEDIUM;
                       HOT_NODE                 WRITE_LIFE_NOT_SET
                       WARM_NODE                "
@@ -662,6 +690,7 @@ WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
 WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
 WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
 WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
+===================== ======================== ===================
 
 Fallocate(2) Policy
 -------------------
@@ -681,6 +710,7 @@ Allocating disk space
 However, once F2FS receives ioctl(fd, F2FS_IOC_SET_PIN_FILE) in prior to
 fallocate(fd, DEFAULT_MODE), it allocates on-disk blocks addressess having
 zero or random data, which is useful to the below scenario where:
+
  1. create(fd)
  2. ioctl(fd, F2FS_IOC_SET_PIN_FILE)
  3. fallocate(fd, 0, 0, size)
@@ -692,39 +722,41 @@ Compression implementation
 --------------------------
 
 - New term named cluster is defined as basic unit of compression, file can
-be divided into multiple clusters logically. One cluster includes 4 << n
-(n >= 0) logical pages, compression size is also cluster size, each of
-cluster can be compressed or not.
+  be divided into multiple clusters logically. One cluster includes 4 << n
+  (n >= 0) logical pages, compression size is also cluster size, each of
+  cluster can be compressed or not.
 
 - In cluster metadata layout, one special block address is used to indicate
-cluster is compressed one or normal one, for compressed cluster, following
-metadata maps cluster to [1, 4 << n - 1] physical blocks, in where f2fs
-stores data including compress header and compressed data.
+  cluster is compressed one or normal one, for compressed cluster, following
+  metadata maps cluster to [1, 4 << n - 1] physical blocks, in where f2fs
+  stores data including compress header and compressed data.
 
 - In order to eliminate write amplification during overwrite, F2FS only
-support compression on write-once file, data can be compressed only when
-all logical blocks in file are valid and cluster compress ratio is lower
-than specified threshold.
+  support compression on write-once file, data can be compressed only when
+  all logical blocks in file are valid and cluster compress ratio is lower
+  than specified threshold.
 
 - To enable compression on regular inode, there are three ways:
-* chattr +c file
-* chattr +c dir; touch dir/file
-* mount w/ -o compress_extension=ext; touch file.ext
 
-Compress metadata layout:
-                             [Dnode Structure]
-             +-----------------------------------------------+
-             | cluster 1 | cluster 2 | ......... | cluster N |
-             +-----------------------------------------------+
-             .           .                       .           .
-       .                       .                .                      .
-  .         Compressed Cluster       .        .        Normal Cluster            .
-+----------+---------+---------+---------+  +---------+---------+---------+---------+
-|compr flag| block 1 | block 2 | block 3 |  | block 1 | block 2 | block 3 | block 4 |
-+----------+---------+---------+---------+  +---------+---------+---------+---------+
-           .                             .
-         .                                           .
-       .                                                           .
-      +-------------+-------------+----------+----------------------------+
-      | data length | data chksum | reserved |      compressed data       |
-      +-------------+-------------+----------+----------------------------+
+  * chattr +c file
+  * chattr +c dir; touch dir/file
+  * mount w/ -o compress_extension=ext; touch file.ext
+
+Compress metadata layout::
+
+				[Dnode Structure]
+		+-----------------------------------------------+
+		| cluster 1 | cluster 2 | ......... | cluster N |
+		+-----------------------------------------------+
+		.           .                       .           .
+	.                       .                .                      .
+    .         Compressed Cluster       .        .        Normal Cluster            .
+    +----------+---------+---------+---------+  +---------+---------+---------+---------+
+    |compr flag| block 1 | block 2 | block 3 |  | block 1 | block 2 | block 3 | block 4 |
+    +----------+---------+---------+---------+  +---------+---------+---------+---------+
+	    .                             .
+	    .                                           .
+	.                                                           .
+	+-------------+-------------+----------+----------------------------+
+	| data length | data chksum | reserved |      compressed data       |
+	+-------------+-------------+----------+----------------------------+
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index aa2c3d1de3de..f69d20406be0 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -64,6 +64,7 @@ Documentation for filesystem implementations.
    erofs
    ext2
    ext3
+   f2fs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

