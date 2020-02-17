Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6AFA161765
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgBQQNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47142 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vHNzFRvF7pskLSoBthZ/AINIY4LSd6XD26U4I0If7Qk=; b=GWhNVSCjep+mlWR91cjO3e+qSQ
        zHjWzJBlrnixQ64H4M46th3FjFiHBJQwOxO4DmFOe7QtxZG7RkBaHfAQPMllw4rbu1Q1tz/7rSt+C
        irnUmJVt9OAcUQHDWjq2BeshgfMLR5KskaUhkp4DXhjl74BfTfX6vOvLxu9JJI2tfrx13EoaVPphS
        VF3Rt0EfqYhTxKDcN6R4GV8jp/GZ2IS+Is4JXA5irLlGbL0Lqcy8P3XUvHYMmvsXijYKRvObdoTVB
        xkL03LKgNivkKSBgzv8tntbMr18BDarmwXF8x7xvbOlMYBT00rfYxWp+466e9wKXD0tOfTarLnUN9
        ZJgNFCpA==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uY-5Z; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000fZw-0N; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Tyler Hicks <code@tyhicks.com>,
        ecryptfs@vger.kernel.org
Subject: [PATCH 13/44] docs: filesystems: convert ecryptfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:59 +0100
Message-Id: <6e13841ebd00c8d988027115c75c58821bb41a0c.1581955849.git.mchehab+huawei@kernel.org>
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
- use :field: markup;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{ecryptfs.txt => ecryptfs.rst}            | 44 ++++++++++++-------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 28 insertions(+), 17 deletions(-)
 rename Documentation/filesystems/{ecryptfs.txt => ecryptfs.rst} (70%)

diff --git a/Documentation/filesystems/ecryptfs.txt b/Documentation/filesystems/ecryptfs.rst
similarity index 70%
rename from Documentation/filesystems/ecryptfs.txt
rename to Documentation/filesystems/ecryptfs.rst
index 01d8a08351ac..7236172300ef 100644
--- a/Documentation/filesystems/ecryptfs.txt
+++ b/Documentation/filesystems/ecryptfs.rst
@@ -1,14 +1,18 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================================
 eCryptfs: A stacked cryptographic filesystem for Linux
+======================================================
 
 eCryptfs is free software. Please see the file COPYING for details.
 For documentation, please see the files in the doc/ subdirectory.  For
 building and installation instructions please see the INSTALL file.
 
-Maintainer: Phillip Hellewell
-Lead developer: Michael A. Halcrow <mhalcrow@us.ibm.com>
-Developers: Michael C. Thompson
-            Kent Yoder
-Web Site: http://ecryptfs.sf.net
+:Maintainer: Phillip Hellewell
+:Lead developer: Michael A. Halcrow <mhalcrow@us.ibm.com>
+:Developers: Michael C. Thompson
+             Kent Yoder
+:Web Site: http://ecryptfs.sf.net
 
 This software is currently undergoing development. Make sure to
 maintain a backup copy of any data you write into eCryptfs.
@@ -19,13 +23,15 @@ SourceForge site:
 http://sourceforge.net/projects/ecryptfs/
 
 Userspace requirements include:
- - David Howells' userspace keyring headers and libraries (version
-   1.0 or higher), obtainable from
-   http://people.redhat.com/~dhowells/keyutils/
- - Libgcrypt
 
+- David Howells' userspace keyring headers and libraries (version
+  1.0 or higher), obtainable from
+  http://people.redhat.com/~dhowells/keyutils/
+- Libgcrypt
 
-NOTES
+
+Notes
+=====
 
 In the beta/experimental releases of eCryptfs, when you upgrade
 eCryptfs, you should copy the files to an unencrypted location and
@@ -33,20 +39,21 @@ then copy the files back into the new eCryptfs mount to migrate the
 files.
 
 
-MOUNT-WIDE PASSPHRASE
+Mount-wide Passphrase
+=====================
 
 Create a new directory into which eCryptfs will write its encrypted
 files (i.e., /root/crypt).  Then, create the mount point directory
-(i.e., /mnt/crypt).  Now it's time to mount eCryptfs:
+(i.e., /mnt/crypt).  Now it's time to mount eCryptfs::
 
-mount -t ecryptfs /root/crypt /mnt/crypt
+    mount -t ecryptfs /root/crypt /mnt/crypt
 
 You should be prompted for a passphrase and a salt (the salt may be
 blank).
 
-Try writing a new file:
+Try writing a new file::
 
-echo "Hello, World" > /mnt/crypt/hello.txt
+    echo "Hello, World" > /mnt/crypt/hello.txt
 
 The operation will complete.  Notice that there is a new file in
 /root/crypt that is at least 12288 bytes in size (depending on your
@@ -59,10 +66,13 @@ keyctl clear @u
 Then umount /mnt/crypt and mount again per the instructions given
 above.
 
-cat /mnt/crypt/hello.txt
+::
 
+    cat /mnt/crypt/hello.txt
 
-NOTES
+
+Notes
+=====
 
 eCryptfs version 0.1 should only be mounted on (1) empty directories
 or (2) directories containing files only created by eCryptfs. If you
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index c6885c7ef781..d6d69f1c9287 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -59,6 +59,7 @@ Documentation for filesystem implementations.
    cramfs
    debugfs
    dlmfs
+   ecryptfs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

