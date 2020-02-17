Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9D0161733
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgBQQMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:35 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47104 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728558AbgBQQMe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pC2Kdws7/dJrAGMxfHCu3O5kowUF2j4tKeDRoxGmqB4=; b=FNbMJy/q7I/MN8EXdIcAtS+kKV
        ARZCMyVpIrZ1ugf5WbKNEvjDMwUrffTxxFioku0aD08ukEy+GLMD53dyesax/RiXdfNqK39M6WOwo
        qfX8+MOWgtqZmD1QteIKalZnVmo+Xmzf5qsFaz+f8uVRsCc+xaCSKgX5aEIwjSJboxfGxiPMfy0o/
        bvo0+3bOS0TtNvXCBICYpOtCWiivcxdCgYcx3t5FH+GqF/r/B9SUY2Y7L33A1d95kI1yH1LODLiZ/
        IquqaemblntHvL7dCp12vXxgTN1cvBgC5P/H80/29KzOPUk2lfHp+qpEjr2AMmDfjchRKtmLUQJs4
        yDcn3L1w==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0b-0006uV-Q9; Mon, 17 Feb 2020 16:12:33 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZh-TD; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH 10/44] docs: filesystems: convert cramfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:56 +0100
Message-Id: <e87b267e71f99974b7bb3fc0a4a08454ff58165e.1581955849.git.mchehab+huawei@kernel.org>
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
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{cramfs.txt => cramfs.rst}    | 19 ++++++++++++-------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)
 rename Documentation/filesystems/{cramfs.txt => cramfs.rst} (88%)

diff --git a/Documentation/filesystems/cramfs.txt b/Documentation/filesystems/cramfs.rst
similarity index 88%
rename from Documentation/filesystems/cramfs.txt
rename to Documentation/filesystems/cramfs.rst
index 8e19a53d648b..afbdbde98bd2 100644
--- a/Documentation/filesystems/cramfs.txt
+++ b/Documentation/filesystems/cramfs.rst
@@ -1,12 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-	Cramfs - cram a filesystem onto a small ROM
+===========================================
+Cramfs - cram a filesystem onto a small ROM
+===========================================
 
-cramfs is designed to be simple and small, and to compress things well. 
+cramfs is designed to be simple and small, and to compress things well.
 
 It uses the zlib routines to compress a file one page at a time, and
 allows random page access.  The meta-data is not compressed, but is
 expressed in a very terse representation to make it use much less
-diskspace than traditional filesystems. 
+diskspace than traditional filesystems.
 
 You can't write to a cramfs filesystem (making it compressible and
 compact also makes it _very_ hard to update on-the-fly), so you have to
@@ -28,9 +31,9 @@ issue.
 Hard links are supported, but hard linked files
 will still have a link count of 1 in the cramfs image.
 
-Cramfs directories have no `.' or `..' entries.  Directories (like
+Cramfs directories have no ``.`` or ``..`` entries.  Directories (like
 every other file on cramfs) always have a link count of 1.  (There's
-no need to use -noleaf in `find', btw.)
+no need to use -noleaf in ``find``, btw.)
 
 No timestamps are stored in a cramfs, so these default to the epoch
 (1970 GMT).  Recently-accessed files may have updated timestamps, but
@@ -70,9 +73,9 @@ MTD drivers are cfi_cmdset_0001 (Intel/Sharp CFI flash) or physmap
 (Flash device in physical memory map). MTD partitions based on such devices
 are fine too. Then that device should be specified with the "mtd:" prefix
 as the mount device argument. For example, to mount the MTD device named
-"fs_partition" on the /mnt directory:
+"fs_partition" on the /mnt directory::
 
-$ mount -t cramfs mtd:fs_partition /mnt
+    $ mount -t cramfs mtd:fs_partition /mnt
 
 To boot a kernel with this as root filesystem, suffice to specify
 something like "root=mtd:fs_partition" on the kernel command line.
@@ -90,6 +93,7 @@ https://github.com/npitre/cramfs-tools
 For /usr/share/magic
 --------------------
 
+=====	=======================	=======================
 0	ulelong	0x28cd3d45	Linux cramfs offset 0
 >4	ulelong	x		size %d
 >8	ulelong	x		flags 0x%x
@@ -110,6 +114,7 @@ For /usr/share/magic
 >552	ulelong	x		fsid.blocks %d
 >556	ulelong	x		fsid.files %d
 >560	string	>\0		name "%.16s"
+=====	=======================	=======================
 
 
 Hacker Notes
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index ddd8f7b2bb25..8fe848ea04af 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -56,6 +56,7 @@ Documentation for filesystem implementations.
    bfs
    btrfs
    ceph
+   cramfs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

