Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31E9F161745
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbgBQQM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47290 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729716AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=anP3qrpbitwsp10VE1EYmtchGJ29ZlCBfJoECxU4o/0=; b=SXBZ8cPPQCSl9liacuSvwyo3BC
        VksYQmydD4CwRlltbaVIABpjI9FSKI0P66+8PdH7/ZTZXLHRvYKb5eohSrm4lnc6At0tSwFT1BDt7
        FnuvzjSnuwdC0fH1id27X2YN+BqYdtu8JgOfMmmMatWoDUQF/Fx0HL4yPGKB5e9NU3uE1ksvlhme8
        BSIUzj071Q/R2hiYqXaxKeH/GM0SMxd3lQtvH3EHzkPV6YXNB/h3hofGKOFO2NB8YZm7B22iPalew
        jCWz4nVQ6lFfyl/Khu+zgw+xArzQNz+pUxxu0cA6Hpz1z5wliuxwOxCCgNmjsaFM0029XJNmlBeJ/
        8cMTGZeA==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0d-0006uz-6J; Mon, 17 Feb 2020 16:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fbu-8X; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 37/44] docs: filesystems: convert squashfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:23 +0100
Message-Id: <cec30862c7ee7de7f9cd903e35e6c8bf74cc928a.1581955849.git.mchehab+huawei@kernel.org>
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
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../{squashfs.txt => squashfs.rst}            | 60 ++++++++++---------
 2 files changed, 34 insertions(+), 27 deletions(-)
 rename Documentation/filesystems/{squashfs.txt => squashfs.rst} (91%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 3b26639517af..97a5f65ae509 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -86,5 +86,6 @@ Documentation for filesystem implementations.
    ramfs-rootfs-initramfs
    relay
    romfs
+   squashfs
    virtiofs
    vfat
diff --git a/Documentation/filesystems/squashfs.txt b/Documentation/filesystems/squashfs.rst
similarity index 91%
rename from Documentation/filesystems/squashfs.txt
rename to Documentation/filesystems/squashfs.rst
index e5274f84dc56..df42106bae71 100644
--- a/Documentation/filesystems/squashfs.txt
+++ b/Documentation/filesystems/squashfs.rst
@@ -1,7 +1,11 @@
-SQUASHFS 4.0 FILESYSTEM
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+Squashfs 4.0 Filesystem
 =======================
 
 Squashfs is a compressed read-only filesystem for Linux.
+
 It uses zlib, lz4, lzo, or xz compression to compress files, inodes and
 directories.  Inodes in the system are very small and all blocks are packed to
 minimise data overhead. Block sizes greater than 4K are supported up to a
@@ -15,31 +19,33 @@ needed.
 Mailing list: squashfs-devel@lists.sourceforge.net
 Web site: www.squashfs.org
 
-1. FILESYSTEM FEATURES
+1. Filesystem Features
 ----------------------
 
 Squashfs filesystem features versus Cramfs:
 
+============================== 	=========		==========
 				Squashfs		Cramfs
-
-Max filesystem size:		2^64			256 MiB
-Max file size:			~ 2 TiB			16 MiB
-Max files:			unlimited		unlimited
-Max directories:		unlimited		unlimited
-Max entries per directory:	unlimited		unlimited
-Max block size:			1 MiB			4 KiB
-Metadata compression:		yes			no
-Directory indexes:		yes			no
-Sparse file support:		yes			no
-Tail-end packing (fragments):	yes			no
-Exportable (NFS etc.):		yes			no
-Hard link support:		yes			no
-"." and ".." in readdir:	yes			no
-Real inode numbers:		yes			no
-32-bit uids/gids:		yes			no
-File creation time:		yes			no
-Xattr support:			yes			no
-ACL support:			no			no
+============================== 	=========		==========
+Max filesystem size		2^64			256 MiB
+Max file size			~ 2 TiB			16 MiB
+Max files			unlimited		unlimited
+Max directories			unlimited		unlimited
+Max entries per directory	unlimited		unlimited
+Max block size			1 MiB			4 KiB
+Metadata compression		yes			no
+Directory indexes		yes			no
+Sparse file support		yes			no
+Tail-end packing (fragments)	yes			no
+Exportable (NFS etc.)		yes			no
+Hard link support		yes			no
+"." and ".." in readdir		yes			no
+Real inode numbers		yes			no
+32-bit uids/gids		yes			no
+File creation time		yes			no
+Xattr support			yes			no
+ACL support			no			no
+============================== 	=========		==========
 
 Squashfs compresses data, inodes and directories.  In addition, inode and
 directory data are highly compacted, and packed on byte boundaries.  Each
@@ -47,7 +53,7 @@ compressed inode is on average 8 bytes in length (the exact length varies on
 file type, i.e. regular file, directory, symbolic link, and block/char device
 inodes have different sizes).
 
-2. USING SQUASHFS
+2. Using Squashfs
 -----------------
 
 As squashfs is a read-only filesystem, the mksquashfs program must be used to
@@ -58,11 +64,11 @@ obtained from this site also.
 The squashfs-tools development tree is now located on kernel.org
 	git://git.kernel.org/pub/scm/fs/squashfs/squashfs-tools.git
 
-3. SQUASHFS FILESYSTEM DESIGN
+3. Squashfs Filesystem Design
 -----------------------------
 
 A squashfs filesystem consists of a maximum of nine parts, packed together on a
-byte alignment:
+byte alignment::
 
 	 ---------------
 	|  superblock 	|
@@ -229,15 +235,15 @@ location of the xattr list inside each inode, a 32-bit xattr id
 is stored.  This xattr id is mapped into the location of the xattr
 list using a second xattr id lookup table.
 
-4. TODOS AND OUTSTANDING ISSUES
+4. TODOs and Outstanding Issues
 -------------------------------
 
-4.1 Todo list
+4.1 TODO list
 -------------
 
 Implement ACL support.
 
-4.2 Squashfs internal cache
+4.2 Squashfs Internal Cache
 ---------------------------
 
 Blocks in Squashfs are compressed.  To avoid repeatedly decompressing
-- 
2.24.1

