Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69A7C5C1AE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jul 2019 19:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbfGARDU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jul 2019 13:03:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:41296 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729518AbfGARDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:03:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GnU91192847;
        Mon, 1 Jul 2019 17:03:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=1rk67rXEFq9bSgk9ubwIFuNKM975LjPC9KHj896pjfY=;
 b=icPkhus854WvjZJGIlzEel1WOL+TuevIV1jvNjmamFWbrfmMncWJV68DmmOEzi9TwcNd
 zDb5/9RebQzYoi0YnhVZ7MDYgMH2U49wLa6GVqGvo9ki1b/vqGS9rTCdReFlnuprHQ/r
 mJZWOhlwwqqsqmwAaI9LlOjPMV/qy9DJKm9gFD3Q+WnlJN8r/vkTa6wu/sjob5fv8YYW
 uiknUShHjLXd3Me0I+E9b4FPikjdeXg3Ra1GYDsaB/wPDDrINdZ0WHR7/OUCXZl8yHuQ
 SFiDuq5oxsrM+EdtyM+jcjlcGphKRp8TNw1/lb5IqjboH13iSg5Zub29p0k+UVh4Mr6a jA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2te61ppud7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:03:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x61GmLcs154023;
        Mon, 1 Jul 2019 17:03:14 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tebqg1hb7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jul 2019 17:03:14 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x61H3DDI030697;
        Mon, 1 Jul 2019 17:03:13 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jul 2019 10:03:13 -0700
Subject: [PATCH 11/11] iomap: move internal declarations into fs/iomap/
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     hch@infradead.org, darrick.wong@oracle.com
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Mon, 01 Jul 2019 10:03:12 -0700
Message-ID: <156200059214.1790352.12180565717959385551.stgit@magnolia>
In-Reply-To: <156200051933.1790352.5147420943973755350.stgit@magnolia>
References: <156200051933.1790352.5147420943973755350.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907010201
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9305 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907010201
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Move internal function declarations out of fs/internal.h into
fs/iomap/iomap_internal.h so that our transition is complete.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/dax.c                  |    2 +-
 fs/internal.h             |   10 ----------
 fs/iomap/fiemap.c         |    2 +-
 fs/iomap/iomap.c          |    1 -
 fs/iomap/iomap_internal.h |   10 ++++++++++
 fs/iomap/migrate.c        |    1 -
 fs/iomap/page.c           |    2 +-
 fs/iomap/read.c           |    1 -
 fs/iomap/seek.c           |    2 +-
 fs/iomap/swapfile.c       |    2 +-
 10 files changed, 15 insertions(+), 18 deletions(-)


diff --git a/fs/dax.c b/fs/dax.c
index 2e48c7ebb973..86f4138c5695 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -26,7 +26,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
 #include <asm/pgalloc.h>
-#include "internal.h"
+#include "iomap/iomap_internal.h"
 
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
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index 42ed9ef56699..4616e7fdbf0e 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -8,7 +8,7 @@
 #include <linux/fs.h>
 #include <linux/iomap.h>
 
-#include "internal.h"
+#include "iomap_internal.h"
 
 struct fiemap_ctx {
 	struct fiemap_extent_info *fi;
diff --git a/fs/iomap/iomap.c b/fs/iomap/iomap.c
index bdaa6d07b354..8d31daf7e696 100644
--- a/fs/iomap/iomap.c
+++ b/fs/iomap/iomap.c
@@ -9,7 +9,6 @@
 #include <linux/iomap.h>
 #include <linux/blkdev.h>
 
-#include "internal.h"
 #include "iomap_internal.h"
 
 /*
diff --git a/fs/iomap/iomap_internal.h b/fs/iomap/iomap_internal.h
index defaa4d4b9e6..cee558386955 100644
--- a/fs/iomap/iomap_internal.h
+++ b/fs/iomap/iomap_internal.h
@@ -6,6 +6,16 @@
 #ifndef _IOMAP_INTERNAL_H_
 #define _IOMAP_INTERNAL_H_
 
+/*
+ * iomap support:
+ */
+typedef loff_t (*iomap_actor_t)(struct inode *inode, loff_t pos, loff_t len,
+		void *data, struct iomap *iomap);
+
+loff_t iomap_apply(struct inode *inode, loff_t pos, loff_t length,
+		unsigned flags, const struct iomap_ops *ops, void *data,
+		iomap_actor_t actor);
+
 sector_t iomap_sector(struct iomap *iomap, loff_t pos);
 void iomap_set_range_uptodate(struct page *page, unsigned off, unsigned len);
 struct iomap_page *iomap_page_create(struct inode *inode, struct page *page);
diff --git a/fs/iomap/migrate.c b/fs/iomap/migrate.c
index 5fd58a868c80..a25874700f95 100644
--- a/fs/iomap/migrate.c
+++ b/fs/iomap/migrate.c
@@ -9,7 +9,6 @@
 #include <linux/iomap.h>
 #include <linux/migrate.h>
 
-#include "internal.h"
 #include "iomap_internal.h"
 
 int
diff --git a/fs/iomap/page.c b/fs/iomap/page.c
index 1de513d5b1f7..0c18a88f4366 100644
--- a/fs/iomap/page.c
+++ b/fs/iomap/page.c
@@ -10,7 +10,7 @@
 #include <linux/memcontrol.h>
 #include <linux/blkdev.h>
 
-#include "internal.h"
+#include "iomap_internal.h"
 
 struct iomap_page *
 iomap_page_create(struct inode *inode, struct page *page)
diff --git a/fs/iomap/read.c b/fs/iomap/read.c
index 237516d0af8b..117626cd7ead 100644
--- a/fs/iomap/read.c
+++ b/fs/iomap/read.c
@@ -11,7 +11,6 @@
 #include <linux/pagemap.h>
 #include <linux/blkdev.h>
 
-#include "internal.h"
 #include "iomap_internal.h"
 
 /*
diff --git a/fs/iomap/seek.c b/fs/iomap/seek.c
index 0c36bef46522..4d2e6b668a9a 100644
--- a/fs/iomap/seek.c
+++ b/fs/iomap/seek.c
@@ -10,7 +10,7 @@
 #include <linux/pagemap.h>
 #include <linux/pagevec.h>
 
-#include "internal.h"
+#include "iomap_internal.h"
 
 /*
  * Seek for SEEK_DATA / SEEK_HOLE within @page, starting at @lastoff.
diff --git a/fs/iomap/swapfile.c b/fs/iomap/swapfile.c
index 4ca214d1e88d..543bb6e90a39 100644
--- a/fs/iomap/swapfile.c
+++ b/fs/iomap/swapfile.c
@@ -9,7 +9,7 @@
 #include <linux/iomap.h>
 #include <linux/swap.h>
 
-#include "internal.h"
+#include "iomap_internal.h"
 
 /* Swapfile activation */
 

