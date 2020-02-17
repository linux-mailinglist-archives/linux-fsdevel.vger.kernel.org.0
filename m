Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C656116174C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgBQQNA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47198 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=N/9Z33HoMcMHaeifzNVULrHTVj9SAYN1jD9RU93RDJo=; b=snP3OGI8Remel3KchHkJrb8b13
        Rci+R4BM9wzkRsCF9Jt2+MbMEV0vN/PuZIg3f2W0h+o0b3t5+cOEeeqoIavDxwbNAkWXJfXdEEan8
        GbLIF1vOtnf3eiGbHFiBsr+NFWahuJ53SjtHjeET4SkVaBOCQnbT36zh2CVUDF0bL5vBcV9W2OXXx
        Ro+GA/SN9zPuRTR5enBIw0f6jsgpbkoL4sjPqHrkW2Wamd4x2jXms0w6g/4wFaz5DPcyUxhIzT/pb
        YopwZUaxdi5wJrnYNWvY+qWUcNjBdsmGidfwQvDE3MNcgIDnh/RFrg9iZ8SZD7b07zTvGwS0gKtTS
        Cjfp1lTw==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006un-K1; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000faw-MG; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 25/44] docs: filesystems: convert isofs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:11 +0100
Message-Id: <ec16dc09d0c23bb0c1af3d3f33a96896083a1d36.1581955849.git.mchehab+huawei@kernel.org>
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
- Add table markups;
- Add lists markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst |  1 +
 Documentation/filesystems/isofs.rst | 64 +++++++++++++++++++++++++++++
 Documentation/filesystems/isofs.txt | 48 ----------------------
 3 files changed, 65 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/filesystems/isofs.rst
 delete mode 100644 Documentation/filesystems/isofs.txt

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 5a737722652c..8c8813ada53f 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -71,6 +71,7 @@ Documentation for filesystem implementations.
    hfsplus
    hpfs
    inotify
+   isofs
    fuse
    overlayfs
    virtiofs
diff --git a/Documentation/filesystems/isofs.rst b/Documentation/filesystems/isofs.rst
new file mode 100644
index 000000000000..08fd469091d4
--- /dev/null
+++ b/Documentation/filesystems/isofs.rst
@@ -0,0 +1,64 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
+ISO9660 Filesystem
+==================
+
+Mount options that are the same as for msdos and vfat partitions.
+
+  =========	========================================================
+  gid=nnn	All files in the partition will be in group nnn.
+  uid=nnn	All files in the partition will be owned by user id nnn.
+  umask=nnn	The permission mask (see umask(1)) for the partition.
+  =========	========================================================
+
+Mount options that are the same as vfat partitions. These are only useful
+when using discs encoded using Microsoft's Joliet extensions.
+
+ ==============	=============================================================
+ iocharset=name Character set to use for converting from Unicode to
+		ASCII.  Joliet filenames are stored in Unicode format, but
+		Unix for the most part doesn't know how to deal with Unicode.
+		There is also an option of doing UTF-8 translations with the
+		utf8 option.
+  utf8          Encode Unicode names in UTF-8 format. Default is no.
+ ==============	=============================================================
+
+Mount options unique to the isofs filesystem.
+
+ ================= ============================================================
+  block=512        Set the block size for the disk to 512 bytes
+  block=1024       Set the block size for the disk to 1024 bytes
+  block=2048       Set the block size for the disk to 2048 bytes
+  check=relaxed    Matches filenames with different cases
+  check=strict     Matches only filenames with the exact same case
+  cruft            Try to handle badly formatted CDs.
+  map=off          Do not map non-Rock Ridge filenames to lower case
+  map=normal       Map non-Rock Ridge filenames to lower case
+  map=acorn        As map=normal but also apply Acorn extensions if present
+  mode=xxx         Sets the permissions on files to xxx unless Rock Ridge
+		   extensions set the permissions otherwise
+  dmode=xxx        Sets the permissions on directories to xxx unless Rock Ridge
+		   extensions set the permissions otherwise
+  overriderockperm Set permissions on files and directories according to
+		   'mode' and 'dmode' even though Rock Ridge extensions are
+		   present.
+  nojoliet         Ignore Joliet extensions if they are present.
+  norock           Ignore Rock Ridge extensions if they are present.
+  hide		   Completely strip hidden files from the file system.
+  showassoc	   Show files marked with the 'associated' bit
+  unhide	   Deprecated; showing hidden files is now default;
+		   If given, it is a synonym for 'showassoc' which will
+		   recreate previous unhide behavior
+  session=x        Select number of session on multisession CD
+  sbsector=xxx     Session begins from sector xxx
+ ================= ============================================================
+
+Recommended documents about ISO 9660 standard are located at:
+
+- http://www.y-adagio.com/
+- ftp://ftp.ecma.ch/ecma-st/Ecma-119.pdf
+
+Quoting from the PDF "This 2nd Edition of Standard ECMA-119 is technically
+identical with ISO 9660.", so it is a valid and gratis substitute of the
+official ISO specification.
diff --git a/Documentation/filesystems/isofs.txt b/Documentation/filesystems/isofs.txt
deleted file mode 100644
index ba0a93384de0..000000000000
--- a/Documentation/filesystems/isofs.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-Mount options that are the same as for msdos and vfat partitions.
-
-  gid=nnn	All files in the partition will be in group nnn.
-  uid=nnn	All files in the partition will be owned by user id nnn.
-  umask=nnn	The permission mask (see umask(1)) for the partition.
-
-Mount options that are the same as vfat partitions. These are only useful
-when using discs encoded using Microsoft's Joliet extensions.
-  iocharset=name Character set to use for converting from Unicode to
-		ASCII.  Joliet filenames are stored in Unicode format, but
-		Unix for the most part doesn't know how to deal with Unicode.
-		There is also an option of doing UTF-8 translations with the
-		utf8 option.
-  utf8          Encode Unicode names in UTF-8 format. Default is no.
-
-Mount options unique to the isofs filesystem.
-  block=512     Set the block size for the disk to 512 bytes
-  block=1024    Set the block size for the disk to 1024 bytes
-  block=2048    Set the block size for the disk to 2048 bytes
-  check=relaxed Matches filenames with different cases
-  check=strict  Matches only filenames with the exact same case
-  cruft         Try to handle badly formatted CDs.
-  map=off       Do not map non-Rock Ridge filenames to lower case
-  map=normal    Map non-Rock Ridge filenames to lower case
-  map=acorn     As map=normal but also apply Acorn extensions if present
-  mode=xxx      Sets the permissions on files to xxx unless Rock Ridge
-		extensions set the permissions otherwise
-  dmode=xxx     Sets the permissions on directories to xxx unless Rock Ridge
-		extensions set the permissions otherwise
-  overriderockperm Set permissions on files and directories according to
-		'mode' and 'dmode' even though Rock Ridge extensions are
-		present.
-  nojoliet      Ignore Joliet extensions if they are present.
-  norock        Ignore Rock Ridge extensions if they are present.
-  hide		Completely strip hidden files from the file system.
-  showassoc	Show files marked with the 'associated' bit
-  unhide	Deprecated; showing hidden files is now default;
-		If given, it is a synonym for 'showassoc' which will
-		recreate previous unhide behavior
-  session=x     Select number of session on multisession CD
-  sbsector=xxx  Session begins from sector xxx
-
-Recommended documents about ISO 9660 standard are located at:
-http://www.y-adagio.com/
-ftp://ftp.ecma.ch/ecma-st/Ecma-119.pdf
-Quoting from the PDF "This 2nd Edition of Standard ECMA-119 is technically 
-identical with ISO 9660.", so it is a valid and gratis substitute of the
-official ISO specification.
-- 
2.24.1

