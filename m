Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF0B216175C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbgBQQNK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:10 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47134 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729681AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Q9SZPxTbPLz6j6tK62QfIeWLVlpiA+w6l/NB+3pECmg=; b=EdRsb1AXRcVTMlidBO9tNFHUAT
        y+S36HIr5DlaBFKno/0X/MiguCK5iMugYoSULHvOCu8pnva6s7hBQA0mdGxH2Zf+YXLAKYbkCH2rf
        DWtFE/htZRMWukINsF2K9/2AZA3y+euBPKRq+AxshpGNN9Wn1Er2N2egwSP5yx+PM7wwmXkhrWz+X
        u/dgKg9lgLLUYr22mRsTkueuhb6lDZLP58sN4zBdTZj3t4FfEXCW8PaXqHl9X1aDnE5SIjfU+4wid
        LWdNP1WJ5unK/LrlEpGKPtq7kXGXa1tYX+Kz3ej8da5+YEvfBYmXjBIQww8s1ls1kLyPm9WjIFY3d
        TRiwehvg==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006ue-6n; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000faC-7A; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org
Subject: [PATCH 16/44] docs: filesystems: convert ext2.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:02 +0100
Message-Id: <fde6721f0303259d830391e351dbde48f67f3ec7.1581955849.git.mchehab+huawei@kernel.org>
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
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Use footnoote markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{ext2.txt => ext2.rst}        | 41 ++++++++++++-------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 27 insertions(+), 15 deletions(-)
 rename Documentation/filesystems/{ext2.txt => ext2.rst} (91%)

diff --git a/Documentation/filesystems/ext2.txt b/Documentation/filesystems/ext2.rst
similarity index 91%
rename from Documentation/filesystems/ext2.txt
rename to Documentation/filesystems/ext2.rst
index 94c2cf0292f5..d83dbbb162e2 100644
--- a/Documentation/filesystems/ext2.txt
+++ b/Documentation/filesystems/ext2.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 
 The Second Extended Filesystem
 ==============================
@@ -14,8 +16,9 @@ Options
 Most defaults are determined by the filesystem superblock, and can be
 set using tune2fs(8). Kernel-determined defaults are indicated by (*).
 
-bsddf			(*)	Makes `df' act like BSD.
-minixdf				Makes `df' act like Minix.
+====================    ===     ================================================
+bsddf			(*)	Makes ``df`` act like BSD.
+minixdf				Makes ``df`` act like Minix.
 
 check=none, nocheck	(*)	Don't do extra checking of bitmaps on mount
 				(check=normal and check=strict options removed)
@@ -62,6 +65,7 @@ quota, usrquota			Enable user disk quota support
 
 grpquota			Enable group disk quota support
 				(requires CONFIG_QUOTA).
+====================    ===     ================================================
 
 noquota option ls silently ignored by ext2.
 
@@ -294,9 +298,9 @@ respective fsck programs.
 If you're exceptionally paranoid, there are 3 ways of making metadata
 writes synchronous on ext2:
 
-per-file if you have the program source: use the O_SYNC flag to open()
-per-file if you don't have the source: use "chattr +S" on the file
-per-filesystem: add the "sync" option to mount (or in /etc/fstab)
+- per-file if you have the program source: use the O_SYNC flag to open()
+- per-file if you don't have the source: use "chattr +S" on the file
+- per-filesystem: add the "sync" option to mount (or in /etc/fstab)
 
 the first and last are not ext2 specific but do force the metadata to
 be written synchronously.  See also Journaling below.
@@ -316,10 +320,12 @@ Most of these limits could be overcome with slight changes in the on-disk
 format and using a compatibility flag to signal the format change (at
 the expense of some compatibility).
 
-Filesystem block size:     1kB        2kB        4kB        8kB
-
-File size limit:          16GB      256GB     2048GB     2048GB
-Filesystem size limit:  2047GB     8192GB    16384GB    32768GB
+=====================  =======    =======    =======   ========
+Filesystem block size      1kB        2kB        4kB        8kB
+=====================  =======    =======    =======   ========
+File size limit           16GB      256GB     2048GB     2048GB
+Filesystem size limit   2047GB     8192GB    16384GB    32768GB
+=====================  =======    =======    =======   ========
 
 There is a 2.4 kernel limit of 2048GB for a single block device, so no
 filesystem larger than that can be created at this time.  There is also
@@ -370,19 +376,24 @@ ext4 and journaling.
 References
 ==========
 
+=======================	===============================================
 The kernel source	file:/usr/src/linux/fs/ext2/
 e2fsprogs (e2fsck)	http://e2fsprogs.sourceforge.net/
 Design & Implementation	http://e2fsprogs.sourceforge.net/ext2intro.html
 Journaling (ext3)	ftp://ftp.uk.linux.org/pub/linux/sct/fs/jfs/
 Filesystem Resizing	http://ext2resize.sourceforge.net/
-Compression (*)		http://e2compr.sourceforge.net/
+Compression [1]_	http://e2compr.sourceforge.net/
+=======================	===============================================
 
 Implementations for:
+
+=======================	===========================================================
 Windows 95/98/NT/2000	http://www.chrysocome.net/explore2fs
-Windows 95 (*)		http://www.yipton.net/content.html#FSDEXT2
-DOS client (*)		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
-OS/2 (+)		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
+Windows 95 [1]_		http://www.yipton.net/content.html#FSDEXT2
+DOS client [1]_		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
+OS/2 [2]_		ftp://metalab.unc.edu/pub/Linux/system/filesystems/ext2/
 RISC OS client		http://www.esw-heim.tu-clausthal.de/~marco/smorbrod/IscaFS/
+=======================	===========================================================
 
-(*) no longer actively developed/supported (as of Apr 2001)
-(+) no longer actively developed/supported (as of Mar 2009)
+.. [1] no longer actively developed/supported (as of Apr 2001)
+.. [2] no longer actively developed/supported (as of Mar 2009)
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 03a493b27920..102b3b65486a 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -62,6 +62,7 @@ Documentation for filesystem implementations.
    ecryptfs
    efivarfs
    erofs
+   ext2
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

