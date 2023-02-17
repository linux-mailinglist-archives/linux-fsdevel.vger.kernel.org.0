Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87C69AE55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Feb 2023 15:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjBQOtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Feb 2023 09:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBQOtG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Feb 2023 09:49:06 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF8B6C029;
        Fri, 17 Feb 2023 06:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1676645343; i=@fujitsu.com;
        bh=A2wAW+QXyIH1Dyff7tecUiExycjpgnQWjt6WHBG3wNQ=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Ji0uCx/Zhz36NWi/Lm2xY2Wrzxh9bC6giHlydN1BJicaEVwD+b6ixwx18s0xHKZh5
         g2tZu78f0j6AojtVlECNTkBLP8jjP1AgyyVPFxLTddQOp6qJSjfXiyV0Cd5bwZPMrz
         +aHQpBcF2fN7iL3SkBDN6+zG68Y4vSiUKAVUrihkFK6nK6vaBQoDwMcHc/3oVOiShA
         xTTA+p+69bfjR9RNY9S52bf3jgvkA0+ynFs7S96HtTXXCeOH1+HjABDydUejLbJI6n
         fYzwWI+XpwFjnoEwbH+XE5c02KJU0S0uLopeKSEdGR9ZxofxTgY/X4nhkrFvAD8T/3
         BWuHfeX6ChZmg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBKsWRWlGSWpSXmKPExsViZ8OxWffe5Pf
  JBpdm8VnMWb+GzWL61AuMFluO3WO0uPyEz+L0hEVMFrtf32Sz2LP3JIvFvTX/WS12/dnBbrHy
  xx9Wi98/5rA5cHucWiThsXmFlsfiPS+ZPDat6mTz2PRpErvHiRm/WTxebJ7J6PHx6S0Wj8+b5
  AI4o1gz85LyKxJYMyY+3cdcsF654t/Hz4wNjGdluxi5OIQENjBKPP7wix3CWcIk8f3bMyCHE8
  jZxygx734RiM0moCNxYcFfVhBbRKBQYsWpoywgDcwCxxkltizfxAySEBbwkmh5tA2siEVAVeL
  sgg1gcV4BF4mnq/4xgtgSAgoSUx6+B4tzCrhKLJ18kg1imYvEgbYTjBD1ghInZz5hAbGZBSQk
  Dr54AVTPAdSrJDGzOx5iTKVE64dfLBC2msTVc5uYJzAKzkLSPQtJ9wJGplWMZsWpRWWpRbqme
  klFmekZJbmJmTl6iVW6iXqppbp5+UUlGbqGeonlxXqpxcV6xZW5yTkpenmpJZsYgZGWUpzMsI
  Oxs++v3iFGSQ4mJVFew4T3yUJ8SfkplRmJxRnxRaU5qcWHGGU4OJQkeE/3A+UEi1LTUyvSMnO
  AUQ+TluDgURLhnZwPlOYtLkjMLc5Mh0idYtTlWNtwYC+zEEtefl6qlDjvjElARQIgRRmleXAj
  YAnoEqOslDAvIwMDgxBPQWpRbmYJqvwrRnEORiVh3ucTgabwZOaVwG16BXQEE9ARC5jfghxRk
  oiQkmpgit5+/KbrI8s/D299WSwXPSfiRz23aYBGsVWqzeHql6GXQ9ZOnLxgw85szvBMx4Uzq+
  z+ivGdme0rt1Vk3v2UWataMlOb2QVz0vKKSyS+NJmvjZWYeuJHzjvmhYaeen95v7/yWt50uKb
  PYi1LV9F+s2OW0Uu/LXD/viHpHNdzs60lljsfxbfdVew8X+V1PNipTFD84budefsfKQh7l5+u
  Zzjwk/unZIG5hNAz1ypOo+U+AZ6SJ9bNuTL/0QOv4ydObnatnvfEqzZOVkArK9Iw8Ow1Jp+JS
  +otf78M4JZ8/zstVfaSobapY/yxqbI55htnxhnyXZvfwMl6OTWocqFO2YMthVt/FfTa11VF5R
  QrsRRnJBpqMRcVJwIAW0qBWbsDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-7.tower-732.messagelabs.com!1676645341!163832!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 14491 invoked from network); 17 Feb 2023 14:49:02 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-7.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 17 Feb 2023 14:49:02 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 880897C;
        Fri, 17 Feb 2023 14:49:01 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 7B7BE7B;
        Fri, 17 Feb 2023 14:49:01 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 17 Feb 2023 14:48:57 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-xfs@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <hch@infradead.org>,
        <jane.chu@oracle.com>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <ruansy.fnst@fujitsu.com>
Subject: [PATCH v10 3/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Fri, 17 Feb 2023 14:48:32 +0000
Message-ID: <1676645312-13-4-git-send-email-ruansy.fnst@fujitsu.com>
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

This patch is inspired by Dan's "mm, dax, pmem: Introduce
dev_pagemap_failure()"[1].  With the help of dax_holder and
->notify_failure() mechanism, the pmem driver is able to ask filesystem
(or mapped device) on it to unmap all files in use and notify processes
who are using those files.

Call trace:
trigger unbind
 -> unbind_store()
  -> ... (skip)
   -> devres_release_all()   # was pmem driver ->remove() in v1
    -> kill_dax()
     -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_PRE_REMOVE)
      -> xfs_dax_notify_failure()

Introduce MF_MEM_PRE_REMOVE to let filesystem know this is a remove
event.  So do not shutdown filesystem directly if something not
supported, or if failure range includes metadata area.  Make sure all
files and processes are handled correctly.

[1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c         |  3 ++-
 fs/xfs/xfs_notify_failure.c | 26 ++++++++++++++++++++++++++
 include/linux/mm.h          |  1 +
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index c4c4728a36e4..2e1a35e82fce 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -323,7 +323,8 @@ void kill_dax(struct dax_device *dax_dev)
 		return;
 
 	if (dax_dev->holder_data != NULL)
-		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
+		dax_holder_notify_failure(dax_dev, 0, U64_MAX,
+				MF_MEM_PRE_REMOVE);
 
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
 	synchronize_srcu(&dax_srcu);
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index 7d46a7e4980f..5f915cfc9632 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -22,6 +22,7 @@
 
 #include <linux/mm.h>
 #include <linux/dax.h>
+#include <linux/fs.h>
 
 struct xfs_failure_info {
 	xfs_agblock_t		startblock;
@@ -77,6 +78,9 @@ xfs_dax_failure_fn(
 
 	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
 	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
+		/* The device is about to be removed.  Not a really failure. */
+		if (notify->mf_flags & MF_MEM_PRE_REMOVE)
+			return 0;
 		notify->want_shutdown = true;
 		return 0;
 	}
@@ -168,7 +172,11 @@ xfs_dax_notify_ddev_failure(
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		if (!error)
 			error = -EFSCORRUPTED;
+	} else if (mf_flags & MF_MEM_PRE_REMOVE) {
+		error = thaw_super(mp->m_super);
+		xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
 	}
+
 	return error;
 }
 
@@ -182,6 +190,7 @@ xfs_dax_notify_failure(
 	struct xfs_mount	*mp = dax_holder(dax_dev);
 	u64			ddev_start;
 	u64			ddev_end;
+	int			error;
 
 	if (!(mp->m_super->s_flags & SB_BORN)) {
 		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
@@ -196,6 +205,8 @@ xfs_dax_notify_failure(
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
 	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		if (mf_flags & MF_MEM_PRE_REMOVE)
+			return 0;
 		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		return -EFSCORRUPTED;
@@ -209,6 +220,12 @@ xfs_dax_notify_failure(
 	ddev_start = mp->m_ddev_targp->bt_dax_part_off;
 	ddev_end = ddev_start + bdev_nr_bytes(mp->m_ddev_targp->bt_bdev) - 1;
 
+	/* Notify failure on the whole device */
+	if (offset == 0 && len == U64_MAX) {
+		offset = ddev_start;
+		len = bdev_nr_bytes(mp->m_ddev_targp->bt_bdev);
+	}
+
 	/* Ignore the range out of filesystem area */
 	if (offset + len - 1 < ddev_start)
 		return -ENXIO;
@@ -225,6 +242,15 @@ xfs_dax_notify_failure(
 	if (offset + len - 1 > ddev_end)
 		len = ddev_end - offset + 1;
 
+	if (mf_flags & MF_MEM_PRE_REMOVE) {
+		xfs_info(mp, "device is about to be removed!");
+		error = freeze_super(mp->m_super);
+		if (error)
+			return error;
+		/* invalidate_inode_pages2() invalidates dax mapping */
+		super_drop_pagecache(mp->m_super, invalidate_inode_pages2);
+	}
+
 	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
 			mf_flags);
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8f857163ac89..9711dbc9451f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3424,6 +3424,7 @@ enum mf_flags {
 	MF_UNPOISON = 1 << 4,
 	MF_SW_SIMULATED = 1 << 5,
 	MF_NO_RETRY = 1 << 6,
+	MF_MEM_PRE_REMOVE = 1 << 7,
 };
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
-- 
2.39.1

