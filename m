Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8678D16173F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbgBQQMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47350 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbgBQQMg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6VTKyitDm/dBa4zHGp3qXsdh5zEwRB0MexXfVcgXa+c=; b=T8QGLLCWQAAsjnN0SiQWDed7Xd
        cMGrQgKFP9Y3mN3vRF+uTlHhyllorkZIn44jvG68AyxKhgKobr9LUmiHUoPmMJIfNtp56R/NFJooG
        yiNuBp5ZKfZpnbTG1htIud0SQXopDzEhs2i81Su49RrAhiFFbjyaWrcQ1z158oH7+iJ7OZBr60XVv
        S+0rFSzOws5qx6WVM2CEoNWDkOpA4Oe6PdaOYk44hk05suosStkFfGvuajiukXo9Z8kyJJ66sUFnP
        TrLwV5CwmX4m6rNPzhB/4UricVeqzv7JrVnnjvt2D5CB0nI16owyRkf+81aMDZo2xTh0D4caNgz5M
        c5SyK/XA==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0e-0006uW-2u; Mon, 17 Feb 2020 16:12:36 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fcT-GN; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
Subject: [PATCH 44/44] docs: filesystems: convert zonefs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:30 +0100
Message-Id: <42a7cfcd19f6b904a9a3188fd4af71bed5050052.1581955849.git.mchehab+huawei@kernel.org>
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
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |   1 +
 .../filesystems/{zonefs.txt => zonefs.rst}    | 106 ++++++++++--------
 2 files changed, 58 insertions(+), 49 deletions(-)
 rename Documentation/filesystems/{zonefs.txt => zonefs.rst} (90%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index ec03cb4d7353..53f46a88e6ec 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -95,3 +95,4 @@ Documentation for filesystem implementations.
    udf
    virtiofs
    vfat
+   zonefs
diff --git a/Documentation/filesystems/zonefs.txt b/Documentation/filesystems/zonefs.rst
similarity index 90%
rename from Documentation/filesystems/zonefs.txt
rename to Documentation/filesystems/zonefs.rst
index 935bf22031ca..7e733e751e98 100644
--- a/Documentation/filesystems/zonefs.txt
+++ b/Documentation/filesystems/zonefs.rst
@@ -1,4 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================================
 ZoneFS - Zone filesystem for Zoned block devices
+================================================
 
 Introduction
 ============
@@ -29,6 +33,7 @@ Zoned block devices
 Zoned storage devices belong to a class of storage devices with an address
 space that is divided into zones. A zone is a group of consecutive LBAs and all
 zones are contiguous (there are no LBA gaps). Zones may have different types.
+
 * Conventional zones: there are no access constraints to LBAs belonging to
   conventional zones. Any read or write access can be executed, similarly to a
   regular block device.
@@ -158,6 +163,7 @@ Format options
 --------------
 
 Several optional features of zonefs can be enabled at format time.
+
 * Conventional zone aggregation: ranges of contiguous conventional zones can be
   aggregated into a single larger file instead of the default one file per zone.
 * File ownership: The owner UID and GID of zone files is by default 0 (root)
@@ -249,7 +255,7 @@ permissions.
 Further action taken by zonefs I/O error recovery can be controlled by the user
 with the "errors=xxx" mount option. The table below summarizes the result of
 zonefs I/O error processing depending on the mount option and on the zone
-conditions.
+conditions::
 
     +--------------+-----------+-----------------------------------------+
     |              |           |            Post error state             |
@@ -275,6 +281,7 @@ conditions.
     +--------------+-----------+-----------------------------------------+
 
 Further notes:
+
 * The "errors=remount-ro" mount option is the default behavior of zonefs I/O
   error processing if no errors mount option is specified.
 * With the "errors=remount-ro" mount option, the change of the file access
@@ -302,6 +309,7 @@ Mount options
 zonefs define the "errors=<behavior>" mount option to allow the user to specify
 zonefs behavior in response to I/O errors, inode size inconsistencies or zone
 condition chages. The defined behaviors are as follow:
+
 * remount-ro (default)
 * zone-ro
 * zone-offline
@@ -325,78 +333,78 @@ Examples
 --------
 
 The following formats a 15TB host-managed SMR HDD with 256 MB zones
-with the conventional zones aggregation feature enabled.
+with the conventional zones aggregation feature enabled::
 
-# mkzonefs -o aggr_cnv /dev/sdX
-# mount -t zonefs /dev/sdX /mnt
-# ls -l /mnt/
-total 0
-dr-xr-xr-x 2 root root     1 Nov 25 13:23 cnv
-dr-xr-xr-x 2 root root 55356 Nov 25 13:23 seq
+    # mkzonefs -o aggr_cnv /dev/sdX
+    # mount -t zonefs /dev/sdX /mnt
+    # ls -l /mnt/
+    total 0
+    dr-xr-xr-x 2 root root     1 Nov 25 13:23 cnv
+    dr-xr-xr-x 2 root root 55356 Nov 25 13:23 seq
 
 The size of the zone files sub-directories indicate the number of files
 existing for each type of zones. In this example, there is only one
 conventional zone file (all conventional zones are aggregated under a single
-file).
+file)::
 
-# ls -l /mnt/cnv
-total 137101312
--rw-r----- 1 root root 140391743488 Nov 25 13:23 0
+    # ls -l /mnt/cnv
+    total 137101312
+    -rw-r----- 1 root root 140391743488 Nov 25 13:23 0
 
-This aggregated conventional zone file can be used as a regular file.
+This aggregated conventional zone file can be used as a regular file::
 
-# mkfs.ext4 /mnt/cnv/0
-# mount -o loop /mnt/cnv/0 /data
+    # mkfs.ext4 /mnt/cnv/0
+    # mount -o loop /mnt/cnv/0 /data
 
 The "seq" sub-directory grouping files for sequential write zones has in this
-example 55356 zones.
+example 55356 zones::
 
-# ls -lv /mnt/seq
-total 14511243264
--rw-r----- 1 root root 0 Nov 25 13:23 0
--rw-r----- 1 root root 0 Nov 25 13:23 1
--rw-r----- 1 root root 0 Nov 25 13:23 2
-...
--rw-r----- 1 root root 0 Nov 25 13:23 55354
--rw-r----- 1 root root 0 Nov 25 13:23 55355
+    # ls -lv /mnt/seq
+    total 14511243264
+    -rw-r----- 1 root root 0 Nov 25 13:23 0
+    -rw-r----- 1 root root 0 Nov 25 13:23 1
+    -rw-r----- 1 root root 0 Nov 25 13:23 2
+    ...
+    -rw-r----- 1 root root 0 Nov 25 13:23 55354
+    -rw-r----- 1 root root 0 Nov 25 13:23 55355
 
 For sequential write zone files, the file size changes as data is appended at
-the end of the file, similarly to any regular file system.
+the end of the file, similarly to any regular file system::
 
-# dd if=/dev/zero of=/mnt/seq/0 bs=4096 count=1 conv=notrunc oflag=direct
-1+0 records in
-1+0 records out
-4096 bytes (4.1 kB, 4.0 KiB) copied, 0.00044121 s, 9.3 MB/s
+    # dd if=/dev/zero of=/mnt/seq/0 bs=4096 count=1 conv=notrunc oflag=direct
+    1+0 records in
+    1+0 records out
+    4096 bytes (4.1 kB, 4.0 KiB) copied, 0.00044121 s, 9.3 MB/s
 
-# ls -l /mnt/seq/0
--rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/seq/0
+    # ls -l /mnt/seq/0
+    -rw-r----- 1 root root 4096 Nov 25 13:23 /mnt/seq/0
 
 The written file can be truncated to the zone size, preventing any further
-write operation.
+write operation::
 
-# truncate -s 268435456 /mnt/seq/0
-# ls -l /mnt/seq/0
--rw-r----- 1 root root 268435456 Nov 25 13:49 /mnt/seq/0
+    # truncate -s 268435456 /mnt/seq/0
+    # ls -l /mnt/seq/0
+    -rw-r----- 1 root root 268435456 Nov 25 13:49 /mnt/seq/0
 
 Truncation to 0 size allows freeing the file zone storage space and restart
-append-writes to the file.
+append-writes to the file::
 
-# truncate -s 0 /mnt/seq/0
-# ls -l /mnt/seq/0
--rw-r----- 1 root root 0 Nov 25 13:49 /mnt/seq/0
+    # truncate -s 0 /mnt/seq/0
+    # ls -l /mnt/seq/0
+    -rw-r----- 1 root root 0 Nov 25 13:49 /mnt/seq/0
 
 Since files are statically mapped to zones on the disk, the number of blocks of
-a file as reported by stat() and fstat() indicates the size of the file zone.
+a file as reported by stat() and fstat() indicates the size of the file zone::
 
-# stat /mnt/seq/0
-  File: /mnt/seq/0
-  Size: 0         	Blocks: 524288     IO Block: 4096   regular empty file
-Device: 870h/2160d	Inode: 50431       Links: 1
-Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)
-Access: 2019-11-25 13:23:57.048971997 +0900
-Modify: 2019-11-25 13:52:25.553805765 +0900
-Change: 2019-11-25 13:52:25.553805765 +0900
- Birth: -
+    # stat /mnt/seq/0
+    File: /mnt/seq/0
+    Size: 0         	Blocks: 524288     IO Block: 4096   regular empty file
+    Device: 870h/2160d	Inode: 50431       Links: 1
+    Access: (0640/-rw-r-----)  Uid: (    0/    root)   Gid: (    0/    root)
+    Access: 2019-11-25 13:23:57.048971997 +0900
+    Modify: 2019-11-25 13:52:25.553805765 +0900
+    Change: 2019-11-25 13:52:25.553805765 +0900
+    Birth: -
 
 The number of blocks of the file ("Blocks") in units of 512B blocks gives the
 maximum file size of 524288 * 512 B = 256 MB, corresponding to the device zone
-- 
2.24.1

