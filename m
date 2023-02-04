Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1FB68AAC7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 15:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbjBDO7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 09:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjBDO7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:59:21 -0500
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3626826CC0;
        Sat,  4 Feb 2023 06:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1675522749; i=@fujitsu.com;
        bh=SXHgAvHOxwfPzF/KQUQcvGQnbZfjSKT6gb8R3kyvGBo=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=jBfkAGCZ9FZPqdZWz2HTq8cVeMpHR/5NhpdLBp9z2vtboyH0nYXNch+Hwjvf+S5mu
         aQddaqcph5sqd6ShKSc4MvkILFKQZwMxdfAzDeJC14Inj+/VuC8bnR+KRbXW9bcchB
         G25sjKf3v/ppkuwu7EO9vD7bA2sIpkzCBw3NPm2//zO7GRc8BNBbltlOCuE7PME1QA
         3PLH9D96TNKzO9BV7IHSuvY0gtPjqKbsXdeH0KdlUJm5Y8dDAIR67POmAGHUnCdBUP
         mhzoOpWkEThDufra2wZKNUdV/Gq8AHulIirue5Xaiy1Ua2B7cVew7LmchUZS2WGXoL
         348+pp+tzvO0A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRWlGSWpSXmKPExsViZ8MxSXdX0b1
  kgzcXxSymT73AaLHl2D1Gi8tP+CxOT1jEZLH79U02iz17T7JYXN41h83i3pr/rBa7/uxgt1j5
  4w+rA5fHqUUSHptXaHks3vOSyWPTqk42j02fJrF7vNg8k9Hj49NbLB6fN8kFcESxZuYl5Vcks
  GZ8OnmHuaDPrKL7FHsD4zvdLkYuDiGBLYwSvWs2MkI4K5gk5m3cwwzh7GWU6Nm9DijDycEmoC
  NxYcFfVpCEiMAkRoljN24ygySYBcol9m+8wQZiCwu4Saw/8AKsgUVARaLh6zKwOK+Ai8TlCZP
  B4hICChJTHr4H6+UUcJV4+/4sWI0QUE3znd9MEPWCEidnPmGBmC8hcfDFC6B6DqBeJYmZ3fEQ
  YyolWj/8YoGw1SSuntvEPIFRcBaS7llIuhcwMq1iNC1OLSpLLdK11EsqykzPKMlNzMzRS6zST
  dRLLdUtTy0u0TXUSywv1kstLtYrrsxNzknRy0st2cQIjKmUYlanHYzH+/7qHWKU5GBSEuXt97
  +bLMSXlJ9SmZFYnBFfVJqTWnyIUYaDQ0mC93rBvWQhwaLU9NSKtMwcYHzDpCU4eJREeH+DpHm
  LCxJzizPTIVKnGBWlxHlbC4ESAiCJjNI8uDZYSrnEKCslzMvIwMAgxFOQWpSbWYIq/4pRnINR
  SZj3Fsh4nsy8Erjpr4AWMwEt7ja4C7K4JBEhJdXAlP5ch2P1L+Pea6sq/POVlkr5WJ+pz+p9k
  mG44HL0pEer525879q3T26bHqPdiRjTlwWtgYU3WvYuPBDia1719YLgZB/mp0vdGV+eZbSc8X
  XB71fS/Vs4T+fcXbj5zdq5yUIpLrftbmycNa3980eN/PD25Nvrw5eKme2UtgnavE8lK8zpv4z
  mpO3q8/2c+Cq+M5Zy5HEHbZThjy5Ym9q/a3Wh47u33vdsEr3OKQvEHz17bM3E+awCXnKqnebh
  L75OLFlv9uJHNkvsnTTdN3VZxetmMf77KJWkbVCWeNjrWsuGfJnvQXsDl57/8fI+49QTT9WWF
  D5qOHTradjr2zvPhMz/IHoqeWaV/TJDKymmWiWW4oxEQy3mouJEANvGXT6kAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-5.tower-585.messagelabs.com!1675522746!176086!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24341 invoked from network); 4 Feb 2023 14:59:06 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-5.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Feb 2023 14:59:06 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id E702A1000F5;
        Sat,  4 Feb 2023 14:59:05 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id DA65B1000E7;
        Sat,  4 Feb 2023 14:59:05 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sat, 4 Feb 2023 14:59:01 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v9 2/3] fs: move drop_pagecache_sb() for others to use
Date:   Sat, 4 Feb 2023 14:58:37 +0000
Message-ID: <1675522718-88-3-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675522718-88-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1675522718-88-1-git-send-email-ruansy.fnst@fujitsu.com>
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
index 12c08cb20405..d788b73f93f0 100644
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
index c1769a2c5d70..b853632e76cd 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3308,6 +3308,7 @@ extern struct super_block *get_super(struct block_device *);
 extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
+void super_drop_pagecache(struct super_block *sb, void *unused);
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

