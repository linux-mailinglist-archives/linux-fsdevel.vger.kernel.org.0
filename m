Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9D816174B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729790AbgBQQNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47248 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729710AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=+1yQ7KOHidOa8+tAwdCUbwM8F6pK6BZLo+Kzg80+9w8=; b=aaS8lGonuXWnXLB5FER8Tk9luD
        pHGBZY4LiwH46nAColHq8ilgpSpkY5qVYPG0iG9Ki69SePWzjD739TwUMd+eZNI2XO4+DUTOhTGyo
        NBzXZdyP9GG281uaRNEo2XQdzXjJnCBwau2XsCc14kur4LfZQpxrOTw0vIHFKAZ2P4g9UVi3/i/pg
        YB89fIsGKuBBFhYwdeouuARENiMvlNUqpGdrMgWK6MeRmZzllE98iR3TTU0RxPObysVvwR+a4xb+b
        lYoTW4NemP/+St5uA+pzXRFmtutKH9cKlWywfJK+yQsENfpuNAtDft5MBm/S7QaTjSwsjC7usdvWp
        0BiXk8hA==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0d-0006uy-4W; Mon, 17 Feb 2020 16:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fbp-7d; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 36/44] docs: filesystems: convert romfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:22 +0100
Message-Id: <d2cc83e7cd6de63c793ccd3f2588ea40f7f1e764.1581955849.git.mchehab+huawei@kernel.org>
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
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../filesystems/{romfs.txt => romfs.rst}      | 42 +++++++++++--------
 2 files changed, 26 insertions(+), 17 deletions(-)
 rename Documentation/filesystems/{romfs.txt => romfs.rst} (86%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 0aade8146d4d..3b26639517af 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -85,5 +85,6 @@ Documentation for filesystem implementations.
    qnx6
    ramfs-rootfs-initramfs
    relay
+   romfs
    virtiofs
    vfat
diff --git a/Documentation/filesystems/romfs.txt b/Documentation/filesystems/romfs.rst
similarity index 86%
rename from Documentation/filesystems/romfs.txt
rename to Documentation/filesystems/romfs.rst
index e2b07cc9120a..465b11efa9be 100644
--- a/Documentation/filesystems/romfs.txt
+++ b/Documentation/filesystems/romfs.rst
@@ -1,4 +1,8 @@
-ROMFS - ROM FILE SYSTEM
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+ROMFS - ROM File System
+=======================
 
 This is a quite dumb, read only filesystem, mainly for initial RAM
 disks of installation disks.  It has grown up by the need of having
@@ -51,9 +55,9 @@ the 16 byte padding for the name and the contents, also 16+14+15 = 45
 bytes.  This is quite rare however, since most file names are longer
 than 3 bytes, and shorter than 15 bytes.
 
-The layout of the filesystem is the following:
+The layout of the filesystem is the following::
 
-offset	    content
+ offset	    content
 
 	+---+---+---+---+
   0	| - | r | o | m |  \
@@ -84,9 +88,9 @@ the source.  This algorithm was chosen because although it's not quite
 reliable, it does not require any tables, and it is very simple.
 
 The following bytes are now part of the file system; each file header
-must begin on a 16 byte boundary.
+must begin on a 16 byte boundary::
 
-offset	    content
+ offset	    content
 
      	+---+---+---+---+
   0	| next filehdr|X|	The offset of the next file header
@@ -114,7 +118,9 @@ file is user and group 0, this should never be a problem for the
 intended use.  The mapping of the 8 possible values to file types is
 the following:
 
+==	=============== ============================================
 	  mapping		spec.info means
+==	=============== ============================================
  0	hard link	link destination [file header]
  1	directory	first file's header
  2	regular file	unused, must be zero [MBZ]
@@ -123,6 +129,7 @@ the following:
  5	char device		    - " -
  6	socket		unused, MBZ
  7	fifo		unused, MBZ
+==	=============== ============================================
 
 Note that hard links are specifically marked in this filesystem, but
 they will behave as you can expect (i.e. share the inode number).
@@ -158,24 +165,24 @@ to romfs-subscribe@shadow.banki.hu, the content is irrelevant.
 Pending issues:
 
 - Permissions and owner information are pretty essential features of a
-Un*x like system, but romfs does not provide the full possibilities.
-I have never found this limiting, but others might.
+  Un*x like system, but romfs does not provide the full possibilities.
+  I have never found this limiting, but others might.
 
 - The file system is read only, so it can be very small, but in case
-one would want to write _anything_ to a file system, he still needs
-a writable file system, thus negating the size advantages.  Possible
-solutions: implement write access as a compile-time option, or a new,
-similarly small writable filesystem for RAM disks.
+  one would want to write _anything_ to a file system, he still needs
+  a writable file system, thus negating the size advantages.  Possible
+  solutions: implement write access as a compile-time option, or a new,
+  similarly small writable filesystem for RAM disks.
 
 - Since the files are only required to have alignment on a 16 byte
-boundary, it is currently possibly suboptimal to read or execute files
-from the filesystem.  It might be resolved by reordering file data to
-have most of it (i.e. except the start and the end) laying at "natural"
-boundaries, thus it would be possible to directly map a big portion of
-the file contents to the mm subsystem.
+  boundary, it is currently possibly suboptimal to read or execute files
+  from the filesystem.  It might be resolved by reordering file data to
+  have most of it (i.e. except the start and the end) laying at "natural"
+  boundaries, thus it would be possible to directly map a big portion of
+  the file contents to the mm subsystem.
 
 - Compression might be an useful feature, but memory is quite a
-limiting factor in my eyes.
+  limiting factor in my eyes.
 
 - Where it is used?
 
@@ -183,4 +190,5 @@ limiting factor in my eyes.
 
 
 Have fun,
+
 Janos Farkas <chexum@shadow.banki.hu>
-- 
2.24.1

