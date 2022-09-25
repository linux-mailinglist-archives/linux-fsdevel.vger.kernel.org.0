Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC15E9369
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 15:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiIYNdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 09:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiIYNdw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 09:33:52 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1214011450;
        Sun, 25 Sep 2022 06:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1664112828; i=@fujitsu.com;
        bh=SZUJGTcMKpqGq9npE5T8kI7qy3nqdqQWNC5ACNp0d8I=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=xOqdKexDDYdt+OsxJXVNnXnmbEowAzlmUEQpayA/fr5pvMMsqnP3W8yI7JyrvS8IL
         ma616tT4/ggyw7jjcDn9O24XXc71uWFrWgy7dgdoFbBqHeZ7kkQUE61faaCgzTejRC
         ijt8c4pTVMGliK6jYi7wkFaGPAp4d4+qt4J6IWii6C4QKfxZqqxIt2zt4zlq2ngcD6
         6RxG+rpZl04Axcuw43fLngtc+uPQ4PXIM/AljXljZQmnfNpHOjSQvEw4VWk5KXlKtr
         dxdP0bsb5IwYag2MYxphFi2dafsK/4AUhiausemXjiEluXmysM6ZqCCQaKM4uRLo8O
         B1AqDppntcb2w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRWlGSWpSXmKPExsViZ8OxWXdXhEG
  ywdEvUhbTp15gtNhy7B6jxeUnfBanJyxistiz9ySLxeVdc9gs7q35z2qx688OdouVP/6wOnB6
  nFok4bF5hZbH4j0vmTw2repk89j0aRK7x4vNMxk9Pm+SC2CPYs3MS8qvSGDN2LrhP1tBn1nFl
  mV3GRsY3+l2MXJxCAlsZJTofLeCBcJZzCSx9O4UdghnL6NEQ/9R1i5GTg42AR2JCwv+soIkRA
  QmMUocu3GTGSTBLJAg0f7lGhOILSzgLHFzWyM7iM0ioCpx//wTFhCbV8BFYtXPHrB6CQEFiSk
  P34PZnAKuEkunrALrFQKq6dl7lgmiXlDi5EyIXmYBCYmDL14A1XMA9SpJzOyOhxhTIdE4/RAT
  hK0mcfXcJuYJjIKzkHTPQtK9gJFpFaN1UlFmekZJbmJmjq6hgYGuoaGprrEFkDLUS6zSTdRLL
  dUtTy0u0TXSSywv1kstLtYrrsxNzknRy0st2cQIjKaUYrX8HYx/V/7UO8QoycGkJMp71M8gWY
  gvKT+lMiOxOCO+qDQntfgQowwHh5IE7wE3oJxgUWp6akVaZg4wsmHSEhw8SiK8hSCtvMUFibn
  FmekQqVOMuhxTZ//bzyzEkpeflyolzrsyHKhIAKQoozQPbgQsyVxilJUS5mVkYGAQ4ilILcrN
  LEGVf8UozsGoJMzrFgw0hSczrwRu0yugI5iAjrDj0wc5oiQRISXVwMQZpPrfif9d2q6ry6dVB
  XLslgvPnn75a+OvzNzaG0cCj7//Vs2h/9f52OV7LHFdu5/FHa49OEUi1zr2Ue0/H5kjjf+U6v
  9NlVpyZKn0T7YdNnV5q+e+uhOWsnj2rVuxC3y/XI77fiFcxlSiJeCctfAq7X8dbKpcuirdm15
  /ZC8TMp3/Ny5qdeqK6nqNO4EdK1fsrji7bGOu00xh95nbLT5/KV/SyXLo8kO1lvqwKi2td/cL
  V8lbLHioF6qRf6TK9P7sMO8jqxrWKM95y/bzn+r8h7oBh1duXVUn5xt4pU+Zj638Q1Zhn8ND2
  /vdjUvKr9xc9UambLa6wU2TD6KnGtLFd1hYbc7xWO0ff/PQewUlluKMREMt5qLiRAAZS3vxrQ
  MAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-4.tower-548.messagelabs.com!1664112826!147209!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26248 invoked from network); 25 Sep 2022 13:33:46 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-4.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Sep 2022 13:33:46 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 1C837157;
        Sun, 25 Sep 2022 14:33:46 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 0CEE873;
        Sun, 25 Sep 2022 14:33:46 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 25 Sep 2022 14:33:42 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <hch@infradead.org>
Subject: [PATCH 2/3] fs: move drop_pagecache_sb() for others to use
Date:   Sun, 25 Sep 2022 13:33:22 +0000
Message-ID: <1664112803-57-3-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1664112803-57-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1664112803-57-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
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
build with CONFIG_SYSCTL.  Now, move it to super.c and make it available
for others.  And use its second argument to choose which invalidate
method to use.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/drop_caches.c        | 35 ++-------------------------------
 fs/super.c              | 43 +++++++++++++++++++++++++++++++++++++++++
 include/linux/fs.h      |  1 +
 include/linux/pagemap.h |  1 +
 mm/truncate.c           | 20 +++++++++++++++++--
 5 files changed, 65 insertions(+), 35 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index e619c31b6bd9..4c9281885077 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -15,38 +15,6 @@
 /* A global variable is a bit ugly, but it keeps the code simple */
 int sysctl_drop_caches;
 
-static void drop_pagecache_sb(struct super_block *sb, void *unused)
-{
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
-}
-
 int drop_caches_sysctl_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
@@ -59,7 +27,8 @@ int drop_caches_sysctl_handler(struct ctl_table *table, int write,
 		static int stfu;
 
 		if (sysctl_drop_caches & 1) {
-			iterate_supers(drop_pagecache_sb, NULL);
+			iterate_supers(super_drop_pagecache,
+				       invalidate_inode_pages);
 			count_vm_event(DROP_PAGECACHE);
 		}
 		if (sysctl_drop_caches & 2) {
diff --git a/fs/super.c b/fs/super.c
index 734ed584a946..7cdbf146bc31 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
+#include <linux/pagemap.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -677,6 +678,48 @@ void drop_super_exclusive(struct super_block *sb)
 }
 EXPORT_SYMBOL(drop_super_exclusive);
 
+/*
+ *	super_drop_pagecache - drop all page caches of a filesystem
+ *	@sb: superblock to invalidate
+ *	@arg: invalidate method, such as invalidate_inode_pages(),
+ *	        invalidate_inode_pages2()
+ *
+ *	Scans the inodes of a filesystem, drop all page caches.
+ */
+void super_drop_pagecache(struct super_block *sb, void *arg)
+{
+	struct inode *inode, *toput_inode = NULL;
+	int (*invalidator)(struct address_space *) = arg;
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
index 9eced4cc286e..0e60c494688e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3292,6 +3292,7 @@ extern struct super_block *get_super(struct block_device *);
 extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
+void super_drop_pagecache(struct super_block *sb, void *unused);
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 0178b2040ea3..8879c141b117 100644
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
index 0b0708bf935f..3016258d41e7 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -548,12 +548,13 @@ unsigned long invalidate_mapping_pagevec(struct address_space *mapping,
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
@@ -568,6 +569,21 @@ unsigned long invalidate_mapping_pages(struct address_space *mapping,
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
2.37.3

