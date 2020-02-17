Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBB0161749
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgBQQM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:59 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47244 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hyKXSXNiYvlW+ifKDgwyMt87FRJRqPTrasipgk9/uCM=; b=cZ/CG8tosvGYPGXqpwJmi8xtKK
        8udDVg+XbeXBpkwSqLFAKmMEiaj33SRk8FZEJU8i26DasTh95zCP2SmZAKns++TnAXUpUmexVBoPq
        3ulboojjZEnAfDkrG4E6M0TfLPKVnvLMEoU8enlYjeN0HUJAQ9FRww+iaZAmZhtnP8D0wjTPJ4nkc
        4uMDy05cXYOSXAsS0+Aq4sY9q1RWXnhatPLoAN85QsXZTOH4pGprk8BrS2iE/1gOb14w0703S0WQR
        Vjy2SiTljmSGzv6kuxpJdwbj22iyI0tsHFDdgosr92kExstZwP88xDbuKgNw+rLRReCVoL0HKN/Ng
        H/TTCK2A==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0d-0006uw-3d; Mon, 17 Feb 2020 16:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fbf-5X; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 34/44] docs: filesystems: convert ramfs-rootfs-initramfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:20 +0100
Message-Id: <89cbcc99a6371f3bff3ea1668fe497e8a15c226b.1581955849.git.mchehab+huawei@kernel.org>
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
- Use notes markups;
- Add lists markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 ...itramfs.txt => ramfs-rootfs-initramfs.rst} | 54 +++++++++++--------
 2 files changed, 33 insertions(+), 22 deletions(-)
 rename Documentation/filesystems/{ramfs-rootfs-initramfs.txt => ramfs-rootfs-initramfs.rst} (91%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 08883a481a76..b8689d082911 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -83,5 +83,6 @@ Documentation for filesystem implementations.
    overlayfs
    proc
    qnx6
+   ramfs-rootfs-initramfs
    virtiofs
    vfat
diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.txt b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
similarity index 91%
rename from Documentation/filesystems/ramfs-rootfs-initramfs.txt
rename to Documentation/filesystems/ramfs-rootfs-initramfs.rst
index 97d42ccaa92d..6c576e241d86 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.txt
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -1,5 +1,11 @@
-ramfs, rootfs and initramfs
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================
+Ramfs, rootfs and initramfs
+===========================
+
 October 17, 2005
+
 Rob Landley <rob@landley.net>
 =============================
 
@@ -99,14 +105,14 @@ out of that.
 All this differs from the old initrd in several ways:
 
   - The old initrd was always a separate file, while the initramfs archive is
-    linked into the linux kernel image.  (The directory linux-*/usr is devoted
-    to generating this archive during the build.)
+    linked into the linux kernel image.  (The directory ``linux-*/usr`` is
+    devoted to generating this archive during the build.)
 
   - The old initrd file was a gzipped filesystem image (in some file format,
     such as ext2, that needed a driver built into the kernel), while the new
     initramfs archive is a gzipped cpio archive (like tar only simpler,
-    see cpio(1) and Documentation/driver-api/early-userspace/buffer-format.rst).  The
-    kernel's cpio extraction code is not only extremely small, it's also
+    see cpio(1) and Documentation/driver-api/early-userspace/buffer-format.rst).
+    The kernel's cpio extraction code is not only extremely small, it's also
     __init text and data that can be discarded during the boot process.
 
   - The program run by the old initrd (which was called /initrd, not /init) did
@@ -139,7 +145,7 @@ and living in usr/Kconfig) can be used to specify a source for the
 initramfs archive, which will automatically be incorporated into the
 resulting binary.  This option can point to an existing gzipped cpio
 archive, a directory containing files to be archived, or a text file
-specification such as the following example:
+specification such as the following example::
 
   dir /dev 755 0 0
   nod /dev/console 644 0 0 c 5 1
@@ -175,12 +181,12 @@ or extracting your own preprepared cpio files to feed to the kernel build
 (instead of a config file or directory).
 
 The following command line can extract a cpio image (either by the above script
-or by the kernel build) back into its component files:
+or by the kernel build) back into its component files::
 
   cpio -i -d -H newc -F initramfs_data.cpio --no-absolute-filenames
 
 The following shell script can create a prebuilt cpio archive you can
-use in place of the above config file:
+use in place of the above config file::
 
   #!/bin/sh
 
@@ -202,14 +208,17 @@ use in place of the above config file:
     exit 1
   fi
 
-Note: The cpio man page contains some bad advice that will break your initramfs
-archive if you follow it.  It says "A typical way to generate the list
-of filenames is with the find command; you should give find the -depth option
-to minimize problems with permissions on directories that are unwritable or not
-searchable."  Don't do this when creating initramfs.cpio.gz images, it won't
-work.  The Linux kernel cpio extractor won't create files in a directory that
-doesn't exist, so the directory entries must go before the files that go in
-those directories.  The above script gets them in the right order.
+.. Note::
+
+   The cpio man page contains some bad advice that will break your initramfs
+   archive if you follow it.  It says "A typical way to generate the list
+   of filenames is with the find command; you should give find the -depth
+   option to minimize problems with permissions on directories that are
+   unwritable or not searchable."  Don't do this when creating
+   initramfs.cpio.gz images, it won't work.  The Linux kernel cpio extractor
+   won't create files in a directory that doesn't exist, so the directory
+   entries must go before the files that go in those directories.
+   The above script gets them in the right order.
 
 External initramfs images:
 --------------------------
@@ -236,9 +245,10 @@ An initramfs archive is a complete self-contained root filesystem for Linux.
 If you don't already understand what shared libraries, devices, and paths
 you need to get a minimal root filesystem up and running, here are some
 references:
-http://www.tldp.org/HOWTO/Bootdisk-HOWTO/
-http://www.tldp.org/HOWTO/From-PowerUp-To-Bash-Prompt-HOWTO.html
-http://www.linuxfromscratch.org/lfs/view/stable/
+
+- http://www.tldp.org/HOWTO/Bootdisk-HOWTO/
+- http://www.tldp.org/HOWTO/From-PowerUp-To-Bash-Prompt-HOWTO.html
+- http://www.linuxfromscratch.org/lfs/view/stable/
 
 The "klibc" package (http://www.kernel.org/pub/linux/libs/klibc) is
 designed to be a tiny C library to statically link early userspace
@@ -255,7 +265,7 @@ name lookups, even when otherwise statically linked.)
 
 A good first step is to get initramfs to run a statically linked "hello world"
 program as init, and test it under an emulator like qemu (www.qemu.org) or
-User Mode Linux, like so:
+User Mode Linux, like so::
 
   cat > hello.c << EOF
   #include <stdio.h>
@@ -326,8 +336,8 @@ the above threads) is:
 
    explained his reasoning:
 
-      http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1550.html
-      http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1638.html
+     - http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1550.html
+     - http://www.uwsg.iu.edu/hypermail/linux/kernel/0112.2/1638.html
 
    and, most importantly, designed and implemented the initramfs code.
 
-- 
2.24.1

