Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91369AE58
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 15:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBQOtN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 09:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBQOtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:49:11 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DAB6E667;
        Fri, 17 Feb 2023 06:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1676645347; i=@fujitsu.com;
        bh=INlLG2eFV3uujOkd6ZNxPXwHuXCi55rS88mcPFlZilQ=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=WfrfGMfot7nIs64TT9/DTrQXXNG7NiPQ8B14HONhxnom8dbZi0xxQRaWavm3VAnwQ
         xCU++A5+IIETgEteq8KcfIEWrZ4l2JWMbbtoR1a8hetJAw2aWvQSF4zovhGl53RaCz
         CoFMGRmRck7fW2IBq+P2OUiQD3ZGRZ/6YOxYQsrTi8TPjQXQc2vemzsyVeNj6DBtmd
         zFRIE29MJI3aBBTV7ptls/eKGV2AnXBUlXbfA3q2O1/aPzcTutS6N3b0WJ0i7DTZ2C
         ZeiPWXOQM+fPrULcqj1mBT/1PbXSxop/s0V4zlocoFIkchttfAlCjsXNf/q0NpzLFZ
         VPq9auGUGvxiA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRWlGSWpSXmKPExsViZ8MxSffm5Pf
  JBps2GFnMWb+GzWL61AuMFluO3WO0uPyEz+L0hEVMFrtf32Sz2LP3JIvFvTX/WS12/dnBbrHy
  xx9Wi98/5rA5cHucWiThsXmFlsfiPS+ZPDat6mTz2PRpErvHiRm/WTxebJ7J6PHx6S0Wj8+b5
  AI4o1gz85LyKxJYMx6e3clSsNm44krDHZYGxkfaXYxcHEICWxglLkw6wwzhrGCSeLSrjQnC2c
  coMeFkF2MXIycHm4COxIUFf1lBbBGBQokVp46ygBQxCxxnlNiyfBNQOweHsICtxOQv1SA1LAK
  qEqefNoPV8wq4SKw80MUOYksIKEhMefieGcTmFHCVWDr5JBuILQRUc6DtBCNEvaDEyZlPWEBs
  ZgEJiYMvXoCNlxBQkpjZHQ8xplKi9cMvFghbTeLquU3MExgFZyHpnoWkewEj0ypGs+LUorLUI
  l1DvaSizPSMktzEzBy9xCrdRL3UUt28/KKSDKBUYnmxXmpxsV5xZW5yTopeXmrJJkZgpKUUJ9
  7ewbi896/eIUZJDiYlUV7DhPfJQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4T/cD5QSLUtNTK9I
  yc4BRD5OW4OBREuGdnA+U5i0uSMwtzkyHSJ1iVJQS550xCSghAJLIKM2Da4MlmkuMslLCvIwM
  DAxCPAWpRbmZJajyrxjFORiVhHmfTwSawpOZVwI3/RXQYiagxQuY34IsLklESEk1MPFsULF/n
  J+c28drqJinKzvRY+FSa8fVPVEeN+xWOUS1eyyLbDviKDPFek2Lucl1k+NvPviuque+ECvy5+
  N6++udviy1WT/W/3rAztHP3CTU93HHkX2/f8w0ya9tf7zPVPPHPtUZ0w7UXA2dkrc4dtb+k6c
  kNWoUje7ZCx9o8VA223g1sOV+Rhnzs933nk3yeTp11YlVi9I88vROrClnTTq7KrN1nfUd+7Iz
  zy8Fvdlkkrx0ewu32dw1f3P/23ceFDnqZPtgQd2OZ+1y+9x/cMzIDrxes0VDYMbOySmLEgLP6
  5Qm3Fn9/L/pxGseSjqJu0IYJ2d+Xd2ZwCzk9M1oqfKE+sVzCp+9qd2orfr02Q0lluKMREMt5q
  LiRABaE7XprwMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-15.tower-732.messagelabs.com!1676645337!10103!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24964 invoked from network); 17 Feb 2023 14:48:57 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-15.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Feb 2023 14:48:57 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 2DB181000DB;
        Fri, 17 Feb 2023 14:48:57 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 210781000C1;
        Fri, 17 Feb 2023 14:48:57 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 17 Feb 2023 14:48:52 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <hch@infradead.org>,
        <jane.chu@oracle.com>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <ruansy.fnst@fujitsu.com>
Subject: [PATCH v10 2/3] fs: introduce super_drop_pagecache()
Date:   Fri, 17 Feb 2023 14:48:31 +0000
Message-ID: <1676645312-13-3-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1676645312-13-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xfs_notify_failure.c requires a method to invalidate all dax mappings.
drop_pagecache_sb() can do this but it is a static function and only
build with CONFIG_SYSCTL.  Now, move its implementation into super.c and
call it super_drop_pagecache().  Use its second argument as invalidator
so that we can choose which invalidate method to use.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/drop_caches.c        | 29 +--------------------------
 fs/super.c              | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h      |  2 ++
 include/linux/pagemap.h |  1 +
 mm/truncate.c           | 20 +++++++++++++++++--
 5 files changed, 65 insertions(+), 30 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index e619c31b6bd9..f88ce339b635 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -17,34 +17,7 @@ int sysctl_drop_caches;
 
 static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
-	struct inode *inode, *toput_inode = NULL;
-
-	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
-		spin_lock(&inode->i_lock);
-		/*
-		 * We must skip inodes in unusual state. We may also skip
-		 * inodes without pages but we deliberately won't in case
-		 * we need to reschedule to avoid softlockups.
-		 */
-		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
-		    (mapping_empty(inode->i_mapping) && !need_resched())) {
-			spin_unlock(&inode->i_lock);
-			continue;
-		}
-		__iget(inode);
-		spin_unlock(&inode->i_lock);
-		spin_unlock(&sb->s_inode_list_lock);
-
-		invalidate_mapping_pages(inode->i_mapping, 0, -1);
-		iput(toput_inode);
-		toput_inode = inode;
-
-		cond_resched();
-		spin_lock(&sb->s_inode_list_lock);
-	}
-	spin_unlock(&sb->s_inode_list_lock);
-	iput(toput_inode);
+	super_drop_pagecache(sb, invalidate_inode_pages);
 }
 
 int drop_caches_sysctl_handler(struct ctl_table *table, int write,
diff --git a/fs/super.c b/fs/super.c
index 12c08cb20405..a403243b5513 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
+#include <linux/pagemap.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -678,6 +679,48 @@ void drop_super_exclusive(struct super_block *sb)
 }
 EXPORT_SYMBOL(drop_super_exclusive);
 
+/**
+ *	super_drop_pagecache - drop all page caches of a filesystem
+ *	@sb: superblock to invalidate
+ *	@arg: invalidate method, such as invalidate_inode_pages(),
+ *	        invalidate_inode_pages2()
+ *
+ *	Scans the inodes of a filesystem, drop all page caches.
+ */
+void super_drop_pagecache(struct super_block *sb,
+	int (*invalidator)(struct address_space *))
+{
+	struct inode *inode, *toput_inode = NULL;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		spin_lock(&inode->i_lock);
+		/*
+		 * We must skip inodes in unusual state. We may also skip
+		 * inodes without pages but we deliberately won't in case
+		 * we need to reschedule to avoid softlockups.
+		 */
+		if ((inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW)) ||
+		    (mapping_empty(inode->i_mapping) && !need_resched())) {
+			spin_unlock(&inode->i_lock);
+			continue;
+		}
+		__iget(inode);
+		spin_unlock(&inode->i_lock);
+		spin_unlock(&sb->s_inode_list_lock);
+
+		invalidator(inode->i_mapping);
+		iput(toput_inode);
+		toput_inode = inode;
+
+		cond_resched();
+		spin_lock(&sb->s_inode_list_lock);
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+	iput(toput_inode);
+}
+EXPORT_SYMBOL(super_drop_pagecache);
+
 static void __iterate_supers(void (*f)(struct super_block *))
 {
 	struct super_block *sb, *p = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index c1769a2c5d70..fdcaa9bf85dd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3308,6 +3308,8 @@ extern struct super_block *get_super(struct block_device *);
 extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
+void super_drop_pagecache(struct super_block *sb,
+			  int (*invalidator)(struct address_space *));
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 29e1f9e76eb6..d0a180268baa 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -27,6 +27,7 @@ static inline void invalidate_remote_inode(struct inode *inode)
 	    S_ISLNK(inode->i_mode))
 		invalidate_mapping_pages(inode->i_mapping, 0, -1);
 }
+int invalidate_inode_pages(struct address_space *mapping);
 int invalidate_inode_pages2(struct address_space *mapping);
 int invalidate_inode_pages2_range(struct address_space *mapping,
 		pgoff_t start, pgoff_t end);
diff --git a/mm/truncate.c b/mm/truncate.c
index 7b4ea4c4a46b..131f2ab2d566 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -540,12 +540,13 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
 }
 
 /**
- * invalidate_mapping_pages - Invalidate all clean, unlocked cache of one inode
+ * invalidate_mapping_pages - Invalidate range of clean, unlocked cache of one
+ *			      inode
  * @mapping: the address_space which holds the cache to invalidate
  * @start: the offset 'from' which to invalidate
  * @end: the offset 'to' which to invalidate (inclusive)
  *
- * This function removes pages that are clean, unmapped and unlocked,
+ * This function removes range of pages that are clean, unmapped and unlocked,
  * as well as shadow entries. It will not block on IO activity.
  *
  * If you want to remove all the pages of one inode, regardless of
@@ -560,6 +561,21 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
 }
 EXPORT_SYMBOL(invalidate_mapping_pages);
 
+/**
+ * invalidate_inode_pages - Invalidate all clean, unlocked cache of one inode
+ * @mapping: the address_space which holds the cache to invalidate
+ *
+ * This function removes all pages that are clean, unmapped and unlocked,
+ * as well as shadow entries. It will not block on IO activity.
+ */
+int invalidate_inode_pages(struct address_space *mapping)
+{
+	invalidate_mapping_pages(mapping, 0, -1);
+
+	return 0;
+}
+EXPORT_SYMBOL(invalidate_inode_pages);
+
 /*
  * This is like invalidate_inode_page(), except it ignores the page's
  * refcount.  We do this because invalidate_inode_pages2() needs stronger
-- 
2.39.1

