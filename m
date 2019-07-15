Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B900069A66
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jul 2019 20:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730428AbfGOSAl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jul 2019 14:00:41 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52384 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfGOSAl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jul 2019 14:00:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHxQRd036514;
        Mon, 15 Jul 2019 18:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=pnh9RIuq/Izo2Nv01iDNAoIOKYMtjpfFdtFpu2NPmWk=;
 b=13YPqZxi++7PemEhuuawPWMSD3osEgftU5ApNjH6UOgYpQvtwFrTAQn0UqUdOo3lx/v2
 p96L3StSK+WAs9X2k1TcCHW3yChnMSyVEnVN1rC/60VxjjQyuvEyN+3X7xCNUtinx/8Z
 iARBwwMU0wPeKBO2stu4cCnVBRUn5j2g2jQbr9nyfKkn/nqQmpy1g+on1mo7MZ7nrC3F
 rNT5g197MUMNLRa1TsKcbr299lsZHD9kxn766E/LUFEKHmL04mWn2zobOEGousg/ghrg
 y3o6RpKYT9Nf1YsJ57eLTukXj0kuIia+gDER60QKfCIx7jm+H5ki02lZN7ITSyOlbjcA kQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2tq78pg1n7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 18:00:22 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6FHwT8l103129;
        Mon, 15 Jul 2019 18:00:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2tq5bbxhus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jul 2019 18:00:21 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6FI0LQs005037;
        Mon, 15 Jul 2019 18:00:21 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 15 Jul 2019 11:00:20 -0700
Subject: [PATCH 9/9] iomap: move internal declarations into fs/iomap/
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        agruenba@redhat.com
Date:   Mon, 15 Jul 2019 11:00:18 -0700
Message-ID: <156321361878.148361.6616574884425585291.stgit@magnolia>
In-Reply-To: <156321356040.148361.7463881761568794395.stgit@magnolia>
References: <156321356040.148361.7463881761568794395.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=822
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907150209
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9319 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=865 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907150209
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Move internal function declarations out of fs/internal.h into
include/linux/iomap.h so that our transition is complete.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/dax.c              |    1 -
 fs/internal.h         |   10 ----------
 fs/iomap/apply.c      |    2 --
 fs/iomap/fiemap.c     |    2 --
 fs/iomap/migrate.c    |    2 --
 fs/iomap/seek.c       |    2 --
 fs/iomap/swapfile.c   |    2 --
 include/linux/iomap.h |   10 ++++++++++
 8 files changed, 10 insertions(+), 21 deletions(-)


diff --git a/fs/dax.c b/fs/dax.c
index fe5e33810cd4..cb53f9bd6fd7 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -26,7 +26,6 @@
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
 #include <asm/pgalloc.h>
-#include "internal.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/fs_dax.h>
diff --git a/fs/internal.h b/fs/internal.h
index 2f3c3de51fad..2b0bebd67904 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -182,15 +182,5 @@ extern const struct dentry_operations ns_dentry_operations;
 extern int do_vfs_ioctl(struct file *file, unsigned int fd, unsigned int cmd,
 		    unsigned long arg);
 
-/*
- * iomap support:
- */
-typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
-		void *data, struct iomap *iomap);
-
-loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
-		unsigned flags, const struct iomap_ops *ops, void *data,
-		iomap_actor_t actor);
-
 /* direct-io.c: */
 int sb_init_dio_done_wq(struct super_block *sb);
diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
index 844e56612dd2..54c02aecf3cd 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -8,8 +8,6 @@
 #include <linux/fs.h>
 #include <linux/iomap.h>
 
-#include "internal.h"
-
 /*
  * Execute a iomap write on a segment of the mapping that spans a
  * contiguous range of pages that have identical block mapping state.
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 1f43315468b7..f26fdd36e383 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -7,8 +7,6 @@
 #include <linux/fs.h>
 #include <linux/iomap.h>
 
-#include "internal.h"
-
 struct fiemap_ctx {
 	struct fiemap_extent_info *fi;
 	struct iomap prev;
diff --git a/fs/iomap/migrate.c b/fs/iomap/migrate.c
index d8116d35f819..12130e3a1825 100644
--- a/fs/iomap/migrate.c
+++ b/fs/iomap/migrate.c
@@ -9,8 +9,6 @@
 #include <linux/iomap.h>
 #include <linux/migrate.h>
 
-#include "internal.h"
-
 int
 iomap_migrate_page(struct address_space *mapping, struct page *newpage,
 		struct page *page, enum migrate_mode mode)
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 0c36bef46522..ece71fd3519a 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -10,8 +10,6 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 
-#include "internal.h"
-
 /*
  * Seek for SEEK_DATA / SEEK_HOLE within @page, starting at @lastoff.
  * Returns true if found and updates @lastoff to the offset in file.
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 0bd578b580bb..152a230f668d 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -9,8 +9,6 @@
 #include <linux/iomap.h>
 #include <linux/swap.h>
 
-#include "internal.h"
-
 /* Swapfile activation */
 
 struct iomap_swapfile_info {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index baa1e2d31f05..bc499ceae392 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -122,6 +122,16 @@ struct iomap_ops {
 			ssize_t written, unsigned flags, struct iomap *iomap);
 };
 
+/*
+ * Main iomap iterator function.
+ */
+typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
+		void *data, struct iomap *iomap);
+
+loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
+		unsigned flags, const struct iomap_ops *ops, void *data,
+		iomap_actor_t actor);
+
 /*
  * Structure allocate for each page when block size < PAGE_SIZE to track
  * sub-page uptodate status and I/O completions.

