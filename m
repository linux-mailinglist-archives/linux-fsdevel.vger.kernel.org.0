Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE6A161725
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729770AbgBQQMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48226 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729758AbgBQQMq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=sCEdXKX/OnbnlqCeyDnNw1soXSc6Zm8CxThqV0PKMgo=; b=FzBT7RrO0el3zbdX91nH3iSZgv
        7Mf9mxrvWCUvCFVwa+4I1gwkTazc39gJtY4P+MvkFMaY5IE/Qsygd+7JUolHs0S6Apz30on0Kotti
        7McBy9/vfny4ld+zQXgRnyBSq8tVkTxz004N5gB+FEAOBLQKssFzWGu7dRpkL25s7lcSS+zf6kE6R
        D9tGj8Xiu51BgBHsAhqm+zEHx0GdiI7tNnxZgXvBNGgpYwRKAquRCcuIB0z21Vwp3yJSDd5vNeyco
        NNYAl7GRCUCVmMNLmhuRQXUlKt5UQS3o2jQmz46QzVcL4LcMYMMSFsVBYbe0sFVvweBBkyrCqW94T
        nREqj7kQ==;
Received: from x2f7f83d.dyn.telefonica.de ([2.247.248.61] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0f-0006uc-Vf; Mon, 17 Feb 2020 16:12:45 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000fa8-3o; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-erofs@lists.ozlabs.org
Subject: [PATCH 15/44] docs: filesystems: convert erofs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:01 +0100
Message-Id: <402d1d2f7252b8a683f7a9c6867bc5428da64026.1581955849.git.mchehab+huawei@kernel.org>
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
- Add a document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add lists markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{erofs.txt => erofs.rst}      | 175 ++++++++++--------
 Documentation/filesystems/index.rst           |   1 +
 2 files changed, 103 insertions(+), 73 deletions(-)
 rename Documentation/filesystems/{erofs.txt => erofs.rst} (54%)

diff --git a/Documentation/filesystems/erofs.txt b/Documentation/filesystems/erofs.rst
similarity index 54%
rename from Documentation/filesystems/erofs.txt
rename to Documentation/filesystems/erofs.rst
index db6d39c3ae71..bf145171c2bf 100644
--- a/Documentation/filesystems/erofs.txt
+++ b/Documentation/filesystems/erofs.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+Enhanced Read-Only File System - EROFS
+======================================
+
 Overview
 ========
 
@@ -6,6 +12,7 @@ from other read-only file systems, it aims to be designed for flexibility,
 scalability, but be kept simple and high performance.
 
 It is designed as a better filesystem solution for the following scenarios:
+
  - read-only storage media or
 
  - part of a fully trusted read-only solution, which means it needs to be
@@ -17,6 +24,7 @@ It is designed as a better filesystem solution for the following scenarios:
    for those embedded devices with limited memory (ex, smartphone);
 
 Here is the main features of EROFS:
+
  - Little endian on-disk design;
 
  - Currently 4KB block size (nobh) and therefore maximum 16TB address space;
@@ -24,13 +32,17 @@ Here is the main features of EROFS:
  - Metadata & data could be mixed by design;
 
  - 2 inode versions for different requirements:
+
+   =====================  ============  =====================================
                           compact (v1)  extended (v2)
-   Inode metadata size:   32 bytes      64 bytes
-   Max file size:         4 GB          16 EB (also limited by max. vol size)
-   Max uids/gids:         65536         4294967296
-   File change time:      no            yes (64 + 32-bit timestamp)
-   Max hardlinks:         65536         4294967296
-   Metadata reserved:     4 bytes       14 bytes
+   =====================  ============  =====================================
+   Inode metadata size    32 bytes      64 bytes
+   Max file size          4 GB          16 EB (also limited by max. vol size)
+   Max uids/gids          65536         4294967296
+   File change time       no            yes (64 + 32-bit timestamp)
+   Max hardlinks          65536         4294967296
+   Metadata reserved      4 bytes       14 bytes
+   =====================  ============  =====================================
 
  - Support extended attributes (xattrs) as an option;
 
@@ -43,29 +55,36 @@ Here is the main features of EROFS:
 
 The following git tree provides the file system user-space tools under
 development (ex, formatting tool mkfs.erofs):
->> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
+
+- git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
 
 Bugs and patches are welcome, please kindly help us and send to the following
 linux-erofs mailing list:
->> linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
+
+- linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
 
 Mount options
 =============
 
+===================    =========================================================
 (no)user_xattr         Setup Extended User Attributes. Note: xattr is enabled
                        by default if CONFIG_EROFS_FS_XATTR is selected.
 (no)acl                Setup POSIX Access Control List. Note: acl is enabled
                        by default if CONFIG_EROFS_FS_POSIX_ACL is selected.
 cache_strategy=%s      Select a strategy for cached decompression from now on:
-                         disabled: In-place I/O decompression only;
-                        readahead: Cache the last incomplete compressed physical
+
+		       ==========  =============================================
+                         disabled  In-place I/O decompression only;
+                        readahead  Cache the last incomplete compressed physical
                                    cluster for further reading. It still does
                                    in-place I/O decompression for the rest
                                    compressed physical clusters;
-                       readaround: Cache the both ends of incomplete compressed
+                       readaround  Cache the both ends of incomplete compressed
                                    physical clusters for further reading.
                                    It still does in-place I/O decompression
                                    for the rest compressed physical clusters.
+		       ==========  =============================================
+===================    =========================================================
 
 On-disk details
 ===============
@@ -73,7 +92,7 @@ On-disk details
 Summary
 -------
 Different from other read-only file systems, an EROFS volume is designed
-to be as simple as possible:
+to be as simple as possible::
 
                                 |-> aligned with the block size
    ____________________________________________________________
@@ -83,41 +102,45 @@ to be as simple as possible:
 
 All data areas should be aligned with the block size, but metadata areas
 may not. All metadatas can be now observed in two different spaces (views):
+
  1. Inode metadata space
+
     Each valid inode should be aligned with an inode slot, which is a fixed
     value (32 bytes) and designed to be kept in line with compact inode size.
 
     Each inode can be directly found with the following formula:
          inode offset = meta_blkaddr * block_size + 32 * nid
 
-                                |-> aligned with 8B
-                                           |-> followed closely
-    + meta_blkaddr blocks                                      |-> another slot
-     _____________________________________________________________________
-    |  ...   | inode |  xattrs  | extents  | data inline | ... | inode ...
-    |________|_______|(optional)|(optional)|__(optional)_|_____|__________
-             |-> aligned with the inode slot size
-                  .                   .
-                .                         .
-              .                              .
-            .                                    .
-          .                                         .
-        .                                              .
-      .____________________________________________________|-> aligned with 4B
-      | xattr_ibody_header | shared xattrs | inline xattrs |
-      |____________________|_______________|_______________|
-      |->    12 bytes    <-|->x * 4 bytes<-|               .
-                          .                .                 .
-                    .                      .                   .
-               .                           .                     .
-           ._______________________________.______________________.
-           | id | id | id | id |  ... | id | ent | ... | ent| ... |
-           |____|____|____|____|______|____|_____|_____|____|_____|
-                                           |-> aligned with 4B
-                                                       |-> aligned with 4B
+    ::
+
+				    |-> aligned with 8B
+					    |-> followed closely
+	+ meta_blkaddr blocks                                      |-> another slot
+	_____________________________________________________________________
+	|  ...   | inode |  xattrs  | extents  | data inline | ... | inode ...
+	|________|_______|(optional)|(optional)|__(optional)_|_____|__________
+		|-> aligned with the inode slot size
+		    .                   .
+		    .                         .
+		.                              .
+		.                                    .
+	    .                                         .
+	    .                                              .
+	.____________________________________________________|-> aligned with 4B
+	| xattr_ibody_header | shared xattrs | inline xattrs |
+	|____________________|_______________|_______________|
+	|->    12 bytes    <-|->x * 4 bytes<-|               .
+			    .                .                 .
+			.                      .                   .
+		.                           .                     .
+	    ._______________________________.______________________.
+	    | id | id | id | id |  ... | id | ent | ... | ent| ... |
+	    |____|____|____|____|______|____|_____|_____|____|_____|
+					    |-> aligned with 4B
+							|-> aligned with 4B
 
     Inode could be 32 or 64 bytes, which can be distinguished from a common
-    field which all inode versions have -- i_format:
+    field which all inode versions have -- i_format::
 
         __________________               __________________
        |     i_format     |             |     i_format     |
@@ -132,16 +155,19 @@ may not. All metadatas can be now observed in two different spaces (views):
     proper alignment, and they could be optional for different data mappings.
     _currently_ total 4 valid data mappings are supported:
 
+    ==  ====================================================================
      0  flat file data without data inline (no extent);
      1  fixed-sized output data compression (with non-compacted indexes);
      2  flat file data with tail packing data inline (no extent);
      3  fixed-sized output data compression (with compacted indexes, v5.3+).
+    ==  ====================================================================
 
     The size of the optional xattrs is indicated by i_xattr_count in inode
     header. Large xattrs or xattrs shared by many different files can be
     stored in shared xattrs metadata rather than inlined right after inode.
 
  2. Shared xattrs metadata space
+
     Shared xattrs space is similar to the above inode space, started with
     a specific block indicated by xattr_blkaddr, organized one by one with
     proper align.
@@ -149,11 +175,13 @@ may not. All metadatas can be now observed in two different spaces (views):
     Each share xattr can also be directly found by the following formula:
          xattr offset = xattr_blkaddr * block_size + 4 * xattr_id
 
-                           |-> aligned by  4 bytes
-    + xattr_blkaddr blocks                     |-> aligned with 4 bytes
-     _________________________________________________________________________
-    |  ...   | xattr_entry |  xattr data | ... |  xattr_entry | xattr data  ...
-    |________|_____________|_____________|_____|______________|_______________
+    ::
+
+			    |-> aligned by  4 bytes
+	+ xattr_blkaddr blocks                     |-> aligned with 4 bytes
+	_________________________________________________________________________
+	|  ...   | xattr_entry |  xattr data | ... |  xattr_entry | xattr data  ...
+	|________|_____________|_____________|_____|______________|_______________
 
 Directories
 -----------
@@ -163,19 +191,21 @@ random file lookup, and all directory entries are _strictly_ recorded in
 alphabetical order in order to support improved prefix binary search
 algorithm (could refer to the related source code).
 
-                 ___________________________
-                /                           |
-               /              ______________|________________
-              /              /              | nameoff1       | nameoffN-1
- ____________.______________._______________v________________v__________
-| dirent | dirent | ... | dirent | filename | filename | ... | filename |
-|___.0___|____1___|_____|___N-1__|____0_____|____1_____|_____|___N-1____|
-     \                           ^
-      \                          |                           * could have
-       \                         |                             trailing '\0'
-        \________________________| nameoff0
+::
 
-                             Directory block
+		    ___________________________
+		    /                           |
+		/              ______________|________________
+		/              /              | nameoff1       | nameoffN-1
+    ____________.______________._______________v________________v__________
+    | dirent | dirent | ... | dirent | filename | filename | ... | filename |
+    |___.0___|____1___|_____|___N-1__|____0_____|____1_____|_____|___N-1____|
+	\                           ^
+	\                          |                           * could have
+	\                         |                             trailing '\0'
+	    \________________________| nameoff0
+
+				Directory block
 
 Note that apart from the offset of the first filename, nameoff0 also indicates
 the total number of directory entries in this block since it is no need to
@@ -184,28 +214,27 @@ introduce another on-disk field at all.
 Compression
 -----------
 Currently, EROFS supports 4KB fixed-sized output transparent file compression,
-as illustrated below:
+as illustrated below::
 
-         |---- Variant-Length Extent ----|-------- VLE --------|----- VLE -----
-         clusterofs                      clusterofs            clusterofs
-         |                               |                     |   logical data
-_________v_______________________________v_____________________v_______________
-... |    .        |             |        .    |             |  .          | ...
-____|____.________|_____________|________.____|_____________|__.__________|____
-    |-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|
-         size          size          size          size          size
-          .                             .                .                   .
-           .                       .               .                  .
-            .                  .              .                .
-      _______._____________._____________._____________._____________________
-         ... |             |             |             | ... physical data
-      _______|_____________|_____________|_____________|_____________________
-             |-> cluster <-|-> cluster <-|-> cluster <-|
-                  size          size          size
+	    |---- Variant-Length Extent ----|-------- VLE --------|----- VLE -----
+	    clusterofs                      clusterofs            clusterofs
+	    |                               |                     |   logical data
+    _________v_______________________________v_____________________v_______________
+    ... |    .        |             |        .    |             |  .          | ...
+    ____|____.________|_____________|________.____|_____________|__.__________|____
+	|-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|-> cluster <-|
+	    size          size          size          size          size
+	    .                             .                .                   .
+	    .                       .               .                  .
+		.                  .              .                .
+	_______._____________._____________._____________._____________________
+	    ... |             |             |             | ... physical data
+	_______|_____________|_____________|_____________|_____________________
+		|-> cluster <-|-> cluster <-|-> cluster <-|
+		    size          size          size
 
 Currently each on-disk physical cluster can contain 4KB (un)compressed data
 at most. For each logical cluster, there is a corresponding on-disk index to
 describe its cluster type, physical cluster address, etc.
 
 See "struct z_erofs_vle_decompressed_index" in erofs_fs.h for more details.
-
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 4230f49d2732..03a493b27920 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -61,6 +61,7 @@ Documentation for filesystem implementations.
    dlmfs
    ecryptfs
    efivarfs
+   erofs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

