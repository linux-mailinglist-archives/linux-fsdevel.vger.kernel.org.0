Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6171916170D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgBQQMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=CXdGuJmKxAd/CW/aZCubCdPQ6ia2Ld7n97c6BPIfAuU=; b=F2z4wUQdR4Xz34FmagsUTbFPAh
        EMDQ6uEceIn1nNb9QtL1+1w67VfQJrJOk54EQ38cHHZ3zSoFN7hfdz2tBB5nXRfy41xORc6MIvNJE
        wL7zyIAVdYZ1X2S+JkiaLOWyWj9ucR4ieavJJ9EsNxoXnrAKgoefBncWB/0sru06U09ST4f2MQIRd
        hWYRqKzHKv4ve2yaD1vV7H3Y57oQJQeT9E0+/iyoQkgdG+HcYXywYwq848AZ0zspkj4FCihiK0i2n
        BBDUE5YkwiMLBf+tpdedF93duQkZHexg75mBgXH2TwymV8jzd49SqGNzDTsU1p/wEghMFVajN8yQp
        2f2QcZNA==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uO-40; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZ8-Kv; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, David Sterba <dsterba@suse.com>
Subject: [PATCH 03/44] docs: filesystems: convert affs.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:49 +0100
Message-Id: <b44c56befe0e28cbc0eb1b3e281ad7d99737ff16.1581955849.git.mchehab+huawei@kernel.org>
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
- Adjust document title;
- Add table markups;
- Mark literal blocks as such;
- Some whitespace fixes and new line breaks;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{affs.txt => affs.rst}        | 62 +++++++++++++------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 44 insertions(+), 19 deletions(-)
 rename Documentation/filesystems/{affs.txt => affs.rst} (86%)

diff --git a/Documentation/filesystems/affs.txt b/Documentation/filesystems/affs.rst
similarity index 86%
rename from Documentation/filesystems/affs.txt
rename to Documentation/filesystems/affs.rst
index 71b63c2b9841..7f1a40dce6d3 100644
--- a/Documentation/filesystems/affs.txt
+++ b/Documentation/filesystems/affs.rst
@@ -1,9 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
 Overview of Amiga Filesystems
 =============================
 
 Not all varieties of the Amiga filesystems are supported for reading and
 writing. The Amiga currently knows six different filesystems:
 
+==============	===============================================================
 DOS\0		The old or original filesystem, not really suited for
 		hard disks and normally not used on them, either.
 		Supported read/write.
@@ -23,6 +27,7 @@ DOS\4		The original filesystem with directory cache. The directory
 		sense on hard disks. Supported read only.
 
 DOS\5		The Fast File System with directory cache. Supported read only.
+==============	===============================================================
 
 All of the above filesystems allow block sizes from 512 to 32K bytes.
 Supported block sizes are: 512, 1024, 2048 and 4096 bytes. Larger blocks
@@ -36,14 +41,18 @@ are supported, too.
 Mount options for the AFFS
 ==========================
 
-protect		If this option is set, the protection bits cannot be altered.
+protect
+		If this option is set, the protection bits cannot be altered.
 
-setuid[=uid]	This sets the owner of all files and directories in the file
+setuid[=uid]
+		This sets the owner of all files and directories in the file
 		system to uid or the uid of the current user, respectively.
 
-setgid[=gid]	Same as above, but for gid.
+setgid[=gid]
+		Same as above, but for gid.
 
-mode=mode	Sets the mode flags to the given (octal) value, regardless
+mode=mode
+		Sets the mode flags to the given (octal) value, regardless
 		of the original permissions. Directories will get an x
 		permission if the corresponding r bit is set.
 		This is useful since most of the plain AmigaOS files
@@ -53,33 +62,41 @@ nofilenametruncate
 		The file system will return an error when filename exceeds
 		standard maximum filename length (30 characters).
 
-reserved=num	Sets the number of reserved blocks at the start of the
+reserved=num
+		Sets the number of reserved blocks at the start of the
 		partition to num. You should never need this option.
 		Default is 2.
 
-root=block	Sets the block number of the root block. This should never
+root=block
+		Sets the block number of the root block. This should never
 		be necessary.
 
-bs=blksize	Sets the blocksize to blksize. Valid block sizes are 512,
+bs=blksize
+		Sets the blocksize to blksize. Valid block sizes are 512,
 		1024, 2048 and 4096. Like the root option, this should
 		never be necessary, as the affs can figure it out itself.
 
-quiet		The file system will not return an error for disallowed
+quiet
+		The file system will not return an error for disallowed
 		mode changes.
 
-verbose		The volume name, file system type and block size will
+verbose
+		The volume name, file system type and block size will
 		be written to the syslog when the filesystem is mounted.
 
-mufs		The filesystem is really a muFS, also it doesn't
+mufs
+		The filesystem is really a muFS, also it doesn't
 		identify itself as one. This option is necessary if
 		the filesystem wasn't formatted as muFS, but is used
 		as one.
 
-prefix=path	Path will be prefixed to every absolute path name of
+prefix=path
+		Path will be prefixed to every absolute path name of
 		symbolic links on an AFFS partition. Default = "/".
 		(See below.)
 
-volume=name	When symbolic links with an absolute path are created
+volume=name
+		When symbolic links with an absolute path are created
 		on an AFFS partition, name will be prepended as the
 		volume name. Default = "" (empty string).
 		(See below.)
@@ -119,7 +136,7 @@ The Linux rwxrwxrwx file mode is handled as follows:
 
   - All other flags (suid, sgid, ...) are ignored and will
     not be retained.
-    
+
 Newly created files and directories will get the user and group ID
 of the current user and a mode according to the umask.
 
@@ -148,11 +165,13 @@ might be "User", "WB" and "Graphics", the mount points /amiga/User,
 Examples
 ========
 
-Command line:
+Command line::
+
     mount  Archive/Amiga/Workbench3.1.adf /mnt -t affs -o loop,verbose
     mount  /dev/sda3 /Amiga -t affs
 
-/etc/fstab entry:
+/etc/fstab entry::
+
     /dev/sdb5	/amiga/Workbench    affs    noauto,user,exec,verbose 0 0
 
 IMPORTANT NOTE
@@ -170,7 +189,8 @@ before booting Windows!
 
 If the damage is already done, the following should fix the RDB
 (where <disk> is the device name).
-DO AT YOUR OWN RISK:
+
+DO AT YOUR OWN RISK::
 
   dd if=/dev/<disk> of=rdb.tmp count=1
   cp rdb.tmp rdb.fixed
@@ -189,10 +209,14 @@ By default, filenames are truncated to 30 characters without warning.
 'nofilenametruncate' mount option can change that behavior.
 
 Case is ignored by the affs in filename matching, but Linux shells
-do care about the case. Example (with /wb being an affs mounted fs):
+do care about the case. Example (with /wb being an affs mounted fs)::
+
     rm /wb/WRONGCASE
-will remove /mnt/wrongcase, but
+
+will remove /mnt/wrongcase, but::
+
     rm /wb/WR*
+
 will not since the names are matched by the shell.
 
 The block allocation is designed for hard disk partitions. If more
@@ -219,4 +243,4 @@ due to an incompatibility with the Amiga floppy controller.
 
 If you are interested in an Amiga Emulator for Linux, look at
 
-http://web.archive.org/web/*/http://www.freiburg.linux.de/~uae/
+http://web.archive.org/web/%2E/http://www.freiburg.linux.de/~uae/
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 14dc89c94822..273d802ad5fb 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -48,6 +48,7 @@ Documentation for filesystem implementations.
 
    9p
    adfs
+   affs
    autofs
    fuse
    overlayfs
-- 
2.24.1

