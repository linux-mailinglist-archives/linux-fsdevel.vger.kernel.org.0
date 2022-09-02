Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C58855AAC8E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Sep 2022 12:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiIBKgn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Sep 2022 06:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbiIBKgh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Sep 2022 06:36:37 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32716BC11E;
        Fri,  2 Sep 2022 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1662114994; i=@fujitsu.com;
        bh=DYnY13BY+5LEKC08gd8berTlSyYt18Bk3isUl+jAsE4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=wTun/xZBFA6GX3tQ518gmx/x0AmDK3NHrDbGAqOV6/to33OljX4kP43X+G6jdn+zy
         uokWVpEA35XEdUjqUpakePuNT1gc7mnyX+LwTEfGLKS8rbSsTVtK+PIZt/XotVoxnc
         Qs5To6MxknqZBqfeZ1YY6eoIkHhZIQssFfxtfzAJm2H/R2nMfHQD2FA13BajDSJsj6
         eUr7Q6DnfbjssL85yg8wruhiORbbsxBwW/fIuWtgMg42L/e4cSyawxqsFr9jo00XCB
         tBy7C+FWEFiQLJ4jX+FT+QHrfpbK/i+luiHoC0fR7ATRbCI2NPGniTlHVXZQIZs0Cu
         K/IwzZTzLbYTQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRWlGSWpSXmKPExsViZ8MxSXfjHcF
  kg0VrTS2mT73AaLHl2D1Gi8tP+CxOT1jEZLH79U02iz17T7JYXN41h83i3pr/rBa7/uxgt1j5
  4w+rA5fHqUUSHptXaHks3vOSyWPTqk42j02fJrF7vNg8k9Hj49NbLB6fN8kFcESxZuYl5Vcks
  Gbc7GpkL2hQqLi4ditrA+M26S5GLg4hgS2MEs1X77JDOMuZJE6c2s8I4exhlHhwsZe1i5GTg0
  1AR+LCgr+sIAkRgUmMEsdu3GQGSTALlEvs33iDDcQWFnCWuLmtkR3EZhFQkTi8pJsJxOYVcJG
  Yc2M6mC0hoCAx5eF7sF5OAVeJ7T23geIcQNsqJFZv54AoF5Q4OfMJC8R4CYmDL14wg5RICChJ
  zOyOh5hSIdE4/RDURDWJq+c2MU9gFJyFpHsWku4FjEyrGK2TijLTM0pyEzNzdA0NDHQNDU11j
  S10jQyN9BKrdBP1Ukt1y1OLS3SB3PJivdTiYr3iytzknBS9vNSSTYzA+EopVruyg3HPqp96hx
  glOZiURHkTbwkmC/El5adUZiQWZ8QXleakFh9ilOHgUJLg5QfJCRalpqdWpGXmAGMdJi3BwaM
  kwhsGkuYtLkjMLc5Mh0idYlSUEud9AZIQAElklObBtcHSyyVGWSlhXkYGBgYhnoLUotzMElT5
  V4ziHIxKwrzPQKbwZOaVwE1/BbSYCWjx9Jn8IItLEhFSUg1Mxucie+dwiHxVD28RPr01SfPdp
  Hv3ayo3te5R2p4w6/w6+18ylnO/nU196JL0awZj5dbzaSl80hsObek5I2eXVzOxuXmn/Yn8eo
  2wV499HwlVXNPKZPkx/1Hh5kqNyOfqNzO6/vRIxv56WxNf57X+3flFlw7MmXN2cknW6o6Vras
  eKagbPnsYynBWeK2yx9a1zW9PP/c4lZxy605fJNcFU8GEcqc51hvUanbx5VfMOyV68zyv6ymx
  YL8c1tgavkO1gRJC962180ImPpgykSdKpPjyZ7XTe8u0ni3+ul3TSeXOCqUe5g9/Zp8U+y/2s
  cbY58HF848rU6X2VvosW/xuDv/dubcZL9Yr2l1axrvbU4mlOCPRUIu5qDgRAHNmFQaqAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-12.tower-548.messagelabs.com!1662114993!2182!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 17723 invoked from network); 2 Sep 2022 10:36:33 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-12.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Sep 2022 10:36:33 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 8153D1000CD;
        Fri,  2 Sep 2022 11:36:33 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 6EE351000CC;
        Fri,  2 Sep 2022 11:36:33 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 2 Sep 2022 11:36:29 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH 2/3] fs: move drop_pagecache_sb() for others to use
Date:   Fri, 2 Sep 2022 10:36:00 +0000
Message-ID: <1662114961-66-3-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <9e9521a4-6e07-e226-2814-b78a2451656b@fujitsu.com>
 <1662114961-66-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xfs_notify_failure requires a method to invalidate all mappings.
drop_pagecache_sb() can do this but it is a static function and only
build with CONFIG_SYSCTL.  Now, move it to super.c and make it available
for others.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/drop_caches.c   | 33 ---------------------------------
 fs/super.c         | 34 ++++++++++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index e619c31b6bd9..5c8406076f9b 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -3,7 +3,6 @@
  * Implement the manual drop-all-pagecache function
  */
 
-#include <linux/pagemap.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
@@ -15,38 +14,6 @@
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
diff --git a/fs/super.c b/fs/super.c
index 734ed584a946..bdf53dbe834c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -36,6 +36,7 @@
 #include <linux/lockdep.h>
 #include <linux/user_namespace.h>
 #include <linux/fs_context.h>
+#include <linux/pagemap.h>
 #include <uapi/linux/mount.h>
 #include "internal.h"
 
@@ -677,6 +678,39 @@ void drop_super_exclusive(struct super_block *sb)
 }
 EXPORT_SYMBOL(drop_super_exclusive);
 
+void drop_pagecache_sb(struct super_block *sb, void *unused)
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
+		invalidate_mapping_pages(inode->i_mapping, 0, -1);
+		iput(toput_inode);
+		toput_inode = inode;
+
+		cond_resched();
+		spin_lock(&sb->s_inode_list_lock);
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+	iput(toput_inode);
+}
+EXPORT_SYMBOL(drop_pagecache_sb);
+
 static void __iterate_supers(void (*f)(struct super_block *))
 {
 	struct super_block *sb, *p = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9eced4cc286e..5ded28c0d2c9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3292,6 +3292,7 @@ extern struct super_block *get_super(struct block_device *);
 extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
+void drop_pagecache_sb(struct super_block *sb, void *unused);
 extern void iterate_supers(void (*)(struct super_block *, void *), void *);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
-- 
2.37.2

