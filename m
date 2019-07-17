Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5717E6B63F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 08:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbfGQGAK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 02:00:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45336 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfGQGAK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 02:00:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H5xBEe117270;
        Wed, 17 Jul 2019 05:59:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=diOcLS7EJRs0sE+WnzGUvJJIi7e/KAF8dFj2ML4ZILs=;
 b=BajAHQHT1aYfL2CaO2+vgnxo9e8R2+pRc5TXoq2gXj05CBWKyV4vV+7YfSrwyIu+8Aj5
 X7b3X7hgrgvlAFQLhNBbGZnsLBIrflCbugHS39eZMkVdWUBeiBwG2zB/Ro0T07/Xvhw3
 IfbylGQaFgKRKH/JtNnDeNy/eS1CEjj9eGw76zGFqDR7GZFeeLczhHC7P+7p52G7G0fU
 FDyS5xdagAmMhPrXTGjDuXLwDxPe4ijapC6B3I67Iegn4GENuvIkb0iM9DvL1Hl2jrAj
 Q1xrgEkD1tBwy1pg1avVbiKPT4Ty+bWnbKnhH2bF6Kz5AgGEDSDJINlDVKOQEPfAZ31Q 9A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2tq78prbk1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:59:55 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H5wQSn014790;
        Wed, 17 Jul 2019 05:59:54 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tsmcc6t7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 05:59:54 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H5xrIX014462;
        Wed, 17 Jul 2019 05:59:53 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 05:59:53 +0000
Subject: [PATCH 8/8] iomap: move internal declarations into fs/iomap/
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        agruenba@redhat.com
Date:   Tue, 16 Jul 2019 22:59:48 -0700
Message-ID: <156334318826.360395.9686513875631453909.stgit@magnolia>
In-Reply-To: <156334313527.360395.511547592522547578.stgit@magnolia>
References: <156334313527.360395.511547592522547578.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170074
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
 fs/iomap/seek.c       |    2 --
 fs/iomap/swapfile.c   |    2 --
 include/linux/iomap.h |   10 ++++++++++
 7 files changed, 10 insertions(+), 19 deletions(-)


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
index 9f956cf23867..54c02aecf3cd 100644
--- a/fs/iomap/apply.c
+++ b/fs/iomap/apply.c
@@ -8,8 +8,6 @@
 #include <linux/fs.h>
 #include <linux/iomap.h>
 
-#include "../internal.h"
-
 /*
  * Execute a iomap write on a segment of the mapping that spans a
  * contiguous range of pages that have identical block mapping state.
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 1fc88ec1584d..f26fdd36e383 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -7,8 +7,6 @@
 #include <linux/fs.h>
 #include <linux/iomap.h>
 
-#include "../internal.h"
-
 struct fiemap_ctx {
 	struct fiemap_extent_info *fi;
 	struct iomap prev;
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 342b6d8ede67..ece71fd3519a 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -10,8 +10,6 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 
-#include "../internal.h"
-
 /*
  * Seek for SEEK_DATA / SEEK_HOLE within @page, starting at @lastoff.
  * Returns true if found and updates @lastoff to the offset in file.
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index b79c33631263..152a230f668d 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -9,8 +9,6 @@
 #include <linux/iomap.h>
 #include <linux/swap.h>
 
-#include "../internal.h"
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

