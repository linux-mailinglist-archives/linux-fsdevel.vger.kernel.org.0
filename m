Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A664516174E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgBQQNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:13:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47228 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729705AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gJjvCx5x7Nd0YN16xjNOzO/IL9ZqVuLBb9vGtTtBIok=; b=cKExKLEUMhlc7In7aREdVCc0KQ
        qwC8hId8tewy7fCGJCpR8K+CLFvOMITca/Wd6VHr1Gf+nfwGcL0kjmVlaiM0ChEF4R5LlHV+H9HAm
        oUoUcs01YqzQM8XiZ1iQtZx50k+skqchuascHrI//BFTwCjWhIm0oe/e2MbzlNHulkDTeoiumSHYf
        +wZLgnc6ouMCXT1TwZJmDHA0etis+pGnyXfIE6y1gcrBRYAJrHDsUoLgsAfYSOEvQviJJyel4ARls
        qzpjnl1quNUaMZSOjYpAnmyTIaxNOZn1paW9KDmiX6creMQSnaU4FL1DIlOfVqpYcfp3iDCaNdV4K
        mT+gZD+w==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0d-0006uv-1J; Mon, 17 Feb 2020 16:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fba-48; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 33/44] docs: filesystems: convert qnx6.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:19 +0100
Message-Id: <ccd22c1e1426ce4cb30ece9a71c39ebb41844762.1581955849.git.mchehab+huawei@kernel.org>
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
- Some whitespace fixes and new line breaks;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../filesystems/{qnx6.txt => qnx6.rst}        | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 rename Documentation/filesystems/{qnx6.txt => qnx6.rst} (98%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 671906e2fee6..08883a481a76 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -82,5 +82,6 @@ Documentation for filesystem implementations.
    orangefs
    overlayfs
    proc
+   qnx6
    virtiofs
    vfat
diff --git a/Documentation/filesystems/qnx6.txt b/Documentation/filesystems/qnx6.rst
similarity index 98%
rename from Documentation/filesystems/qnx6.txt
rename to Documentation/filesystems/qnx6.rst
index 48ea68f15845..b71308314070 100644
--- a/Documentation/filesystems/qnx6.txt
+++ b/Documentation/filesystems/qnx6.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================
 The QNX6 Filesystem
 ===================
 
@@ -14,10 +17,12 @@ Specification
 
 qnx6fs shares many properties with traditional Unix filesystems. It has the
 concepts of blocks, inodes and directories.
+
 On QNX it is possible to create little endian and big endian qnx6 filesystems.
 This feature makes it possible to create and use a different endianness fs
 for the target (QNX is used on quite a range of embedded systems) platform
 running on a different endianness.
+
 The Linux driver handles endianness transparently. (LE and BE)
 
 Blocks
@@ -26,6 +31,7 @@ Blocks
 The space in the device or file is split up into blocks. These are a fixed
 size of 512, 1024, 2048 or 4096, which is decided when the filesystem is
 created.
+
 Blockpointers are 32bit, so the maximum space that can be addressed is
 2^32 * 4096 bytes or 16TB
 
@@ -50,6 +56,7 @@ Each of these root nodes holds information like total size of the stored
 data and the addressing levels in that specific tree.
 If the level value is 0, up to 16 direct blocks can be addressed by each
 node.
+
 Level 1 adds an additional indirect addressing level where each indirect
 addressing block holds up to blocksize / 4 bytes pointers to data blocks.
 Level 2 adds an additional indirect addressing block level (so, already up
@@ -57,11 +64,13 @@ to 16 * 256 * 256 = 1048576 blocks that can be addressed by such a tree).
 
 Unused block pointers are always set to ~0 - regardless of root node,
 indirect addressing blocks or inodes.
+
 Data leaves are always on the lowest level. So no data is stored on upper
 tree levels.
 
 The first Superblock is located at 0x2000. (0x2000 is the bootblock size)
 The Audi MMI 3G first superblock directly starts at byte 0.
+
 Second superblock position can either be calculated from the superblock
 information (total number of filesystem blocks) or by taking the highest
 device address, zeroing the last 3 bytes and then subtracting 0x1000 from
@@ -84,6 +93,7 @@ Object mode field is POSIX format. (which makes things easier)
 
 There are also pointers to the first 16 blocks, if the object data can be
 addressed with 16 direct blocks.
+
 For more than 16 blocks an indirect addressing in form of another tree is
 used. (scheme is the same as the one used for the superblock root nodes)
 
@@ -96,13 +106,18 @@ Directories
 A directory is a filesystem object and has an inode just like a file.
 It is a specially formatted file containing records which associate each
 name with an inode number.
+
 '.' inode number points to the directory inode
+
 '..' inode number points to the parent directory inode
+
 Eeach filename record additionally got a filename length field.
 
 One special case are long filenames or subdirectory names.
+
 These got set a filename length field of 0xff in the corresponding directory
 record plus the longfile inode number also stored in that record.
+
 With that longfilename inode number, the longfilename tree can be walked
 starting with the superblock longfilename root node pointers.
 
@@ -111,6 +126,7 @@ Special files
 
 Symbolic links are also filesystem objects with inodes. They got a specific
 bit in the inode mode field identifying them as symbolic link.
+
 The directory entry file inode pointer points to the target file inode.
 
 Hard links got an inode, a directory entry, but a specific mode bit set,
@@ -126,9 +142,11 @@ Long filenames
 
 Long filenames are stored in a separate addressing tree. The staring point
 is the longfilename root node in the active superblock.
+
 Each data block (tree leaves) holds one long filename. That filename is
 limited to 510 bytes. The first two starting bytes are used as length field
 for the actual filename.
+
 If that structure shall fit for all allowed blocksizes, it is clear why there
 is a limit of 510 bytes for the actual filename stored.
 
@@ -138,6 +156,7 @@ Bitmap
 The qnx6fs filesystem allocation bitmap is stored in a tree under bitmap
 root node in the superblock and each bit in the bitmap represents one
 filesystem block.
+
 The first block is block 0, which starts 0x1000 after superblock start.
 So for a normal qnx6fs 0x3000 (bootblock + superblock) is the physical
 address at which block 0 is located.
@@ -149,11 +168,14 @@ Bitmap system area
 ------------------
 
 The bitmap itself is divided into three parts.
+
 First the system area, that is split into two halves.
+
 Then userspace.
 
 The requirement for a static, fixed preallocated system area comes from how
 qnx6fs deals with writes.
+
 Each superblock got it's own half of the system area. So superblock #1
 always uses blocks from the lower half while superblock #2 just writes to
 blocks represented by the upper half bitmap system area bits.
-- 
2.24.1

