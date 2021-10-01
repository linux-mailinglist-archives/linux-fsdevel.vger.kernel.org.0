Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2741F1B6
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Oct 2021 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355192AbhJAQEi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 12:04:38 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:34426 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355184AbhJAQEh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:04:37 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id BEA9ED4;
        Fri,  1 Oct 2021 19:02:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1633104171;
        bh=3UJJxzDx9Q74zdwKz0wK73cjUkXg6LJ1o+BeyMURVzo=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=cl1Y/+kgYNJlFm1MnY4synOR1k+ggyomol0JmgcHRJV1AjOdCBXiiQVvB8aCRG02/
         8bPi003fatCpkO8dNgF/N3NAHPEi32G/TDzulFqNWaJ2JTmIejSp64Fn1F6ULvnpSG
         U8FnnD5XTKLzXxYa8HdGWXQJIh+D4Aio14Ppvths=
Received: from [192.168.211.98] (192.168.211.98) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 1 Oct 2021 19:02:51 +0300
Message-ID: <43e50860-3708-2887-86f7-e201782a2001@paragon-software.com>
Date:   Fri, 1 Oct 2021 19:02:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: [PATCH 2/2] fs/ntfs3: Remove unnecessary includes
Content-Language: en-US
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <ntfs3@lists.linux.dev>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
References: <992eee8f-bed8-4019-a966-1988bd4dd5de@paragon-software.com>
In-Reply-To: <992eee8f-bed8-4019-a966-1988bd4dd5de@paragon-software.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.211.98]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All removed includes already included from other headers.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/attrib.c   | 2 --
 fs/ntfs3/attrlist.c | 2 --
 fs/ntfs3/dir.c      | 2 --
 fs/ntfs3/file.c     | 2 --
 fs/ntfs3/frecord.c  | 2 --
 fs/ntfs3/fslog.c    | 2 --
 fs/ntfs3/fsntfs.c   | 2 --
 fs/ntfs3/index.c    | 3 ---
 fs/ntfs3/inode.c    | 2 --
 fs/ntfs3/lznt.c     | 1 -
 fs/ntfs3/namei.c    | 2 --
 fs/ntfs3/ntfs_fs.h  | 1 -
 fs/ntfs3/record.c   | 2 --
 fs/ntfs3/run.c      | 2 --
 fs/ntfs3/super.c    | 4 +---
 fs/ntfs3/xattr.c    | 2 --
 16 files changed, 1 insertion(+), 32 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 8a00fa978f5f..dd4f1613081d 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -10,8 +10,6 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 /*
diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index bad6d8a849a2..c3934a2a28a9 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -7,8 +7,6 @@
 
 #include <linux/fs.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 /*
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 785e72d4392e..293303f00b66 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -10,8 +10,6 @@
 #include <linux/fs.h>
 #include <linux/nls.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 /* Convert little endian UTF-16 to NLS string. */
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 5fb3508e5422..13789543a0fb 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -13,8 +13,6 @@
 #include <linux/falloc.h>
 #include <linux/fiemap.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 static int ntfs_ioctl_fitrim(struct ntfs_sb_info *sbi, unsigned long arg)
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 007602badd90..b27f3ca2704b 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -9,8 +9,6 @@
 #include <linux/fs.h>
 #include <linux/vmalloc.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 #include "lib/lib.h"
diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 06492f088d60..4bf340babb32 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -10,8 +10,6 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 /*
diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index 4de9acb16968..85cbbb8f41ea 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -10,8 +10,6 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 // clang-format off
diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 6f81e3a49abf..a25f04dcb85b 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -8,10 +8,7 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/fs.h>
-#include <linux/kernel.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 static const struct INDEX_NAMES {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 7dd162f6a7e2..06113610c529 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -13,8 +13,6 @@
 #include <linux/uio.h>
 #include <linux/writeback.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 /*
diff --git a/fs/ntfs3/lznt.c b/fs/ntfs3/lznt.c
index 28f654561f27..d9614b8e1b4e 100644
--- a/fs/ntfs3/lznt.c
+++ b/fs/ntfs3/lznt.c
@@ -11,7 +11,6 @@
 #include <linux/string.h>
 #include <linux/types.h>
 
-#include "debug.h"
 #include "ntfs_fs.h"
 
 // clang-format off
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index bc741213ad84..ed29cd3e98f4 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -8,8 +8,6 @@
 #include <linux/fs.h>
 #include <linux/nls.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 /*
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 38b7c1a9dc52..e6f37f9993a0 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -29,7 +29,6 @@
 #include <asm/div64.h>
 #include <asm/page.h>
 
-#include "debug.h"
 #include "ntfs.h"
 
 struct dentry;
diff --git a/fs/ntfs3/record.c b/fs/ntfs3/record.c
index 861e35791506..3dd7b960ac8d 100644
--- a/fs/ntfs3/record.c
+++ b/fs/ntfs3/record.c
@@ -7,8 +7,6 @@
 
 #include <linux/fs.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 static inline int compare_attr(const struct ATTRIB *left, enum ATTR_TYPE type,
diff --git a/fs/ntfs3/run.c b/fs/ntfs3/run.c
index a8fec651f973..f5a5ce7aa206 100644
--- a/fs/ntfs3/run.c
+++ b/fs/ntfs3/run.c
@@ -10,8 +10,6 @@
 #include <linux/fs.h>
 #include <linux/log2.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 /* runs_tree is a continues memory. Try to avoid big size. */
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 705d8b4f4894..bd8d39992b35 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -35,8 +35,6 @@
 #include <linux/seq_file.h>
 #include <linux/statfs.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 #ifdef CONFIG_NTFS3_LZX_XPRESS
 #include "lib/lib.h"
@@ -772,7 +770,7 @@ static int ntfs_init_from_boot(struct super_block *sb, u32 sector_size,
 		/* No way to use ntfs_get_block in this case. */
 		ntfs_err(
 			sb,
-			"Failed to mount 'cause NTFS's cluster size (%u) is less than media sector size (%u)",
+			"Failed to mount 'cause NTFS's cluster size (%u) is less than media's sector size (%u)",
 			sbi->cluster_size, sector_size);
 		goto out;
 	}
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 111355692163..0673ba5e8c43 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -10,8 +10,6 @@
 #include <linux/posix_acl_xattr.h>
 #include <linux/xattr.h>
 
-#include "debug.h"
-#include "ntfs.h"
 #include "ntfs_fs.h"
 
 // clang-format off
-- 
2.33.0

