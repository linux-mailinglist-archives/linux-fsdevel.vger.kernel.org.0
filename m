Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A11AC56475B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 15:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbiGCNJI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 09:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGCNJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 09:09:07 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E8EE636D;
        Sun,  3 Jul 2022 06:09:05 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AmaVkHKo8O9LH6a1gAYYd/Wu6t1deBmJzZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmIYUGmBPvbfajOgfowkaIq/pkMB7JHWzIRkS1dsry88QiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JbMlhCfLCqzqxlpJARsVWECwc57CH9?=
 =?us-ascii?q?P+dQWMjcIaQqJhv7wy7W+IsFsjcQLLc/lJooTt3hsizbDAp4OTZnFBaeM+t5c2?=
 =?us-ascii?q?DY5g9tmHPDCas5fYj1qBDzMYQJIPFg/C58kmuqswH7lfFVwrFOTuLpy5m37zxJ?=
 =?us-ascii?q?427urN8DaEvSMW8lUm0OwomPd43+/BhAcKczZxTebmlquj+nC2yj7RaoVDrSz8?=
 =?us-ascii?q?vMsi1qWrkQXCRsLRR61uvW0lEO6c8xQJlZS+Sc0q6U2skuxQbHVWxy+vW7BvRM?=
 =?us-ascii?q?GXddUO/M15RvLyafO5QudQG8eQVZpbN0gqd9zVTIx/kGGksmvBjF1trCRD3WH+?=
 =?us-ascii?q?d+pQZmaUcQOBTZaI3ZaEk1euJ++yLzfRynnFr5LeJNZRPWscd0o/w23kQ=3D?=
 =?us-ascii?q?=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AceH1dqvHtUYqKBlaYcSrjJbQ7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="127151797"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jul 2022 21:09:04 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 6F4B74D17179;
        Sun,  3 Jul 2022 21:09:01 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 3 Jul 2022 21:09:03 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 3 Jul 2022 21:08:42 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [RFC PATCH v4] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Sun, 3 Jul 2022 21:08:38 +0800
Message-ID: <20220703130838.3518127-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 6F4B74D17179.A0B46
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
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
     -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_REMOVE)
      -> xfs_dax_notify_failure()

Introduce MF_MEM_REMOVE to let filesystem know this is a remove event.
So do not shutdown filesystem directly if something not supported, or if
failure range includes metadata area.  Make sure all files and processes
are handled correctly.

==
Changes since v3:
  1. Flush dirty files and logs when pmem is about to be removed.
  2. Rebased on next-20220701

Changes since v2:
  1. Rebased on next-20220615

Changes since v1:
  1. Drop the needless change of moving {kill,put}_dax()
  2. Rebased on '[PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink'[2]

[1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
[2]: https://lore.kernel.org/linux-xfs/20220508143620.1775214-1-ruansy.fnst@fujitsu.com/

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c         |  2 +-
 fs/xfs/xfs_notify_failure.c | 23 ++++++++++++++++++++++-
 include/linux/mm.h          |  1 +
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 9b5e2a5eb0ae..d4bc83159d46 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -323,7 +323,7 @@ void kill_dax(struct dax_device *dax_dev)
 		return;

 	if (dax_dev->holder_data != NULL)
-		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
+		dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_REMOVE);

 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
 	synchronize_srcu(&dax_srcu);
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index aa8dc27c599c..269e21b3341c 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -18,6 +18,7 @@
 #include "xfs_rmap_btree.h"
 #include "xfs_rtalloc.h"
 #include "xfs_trans.h"
+#include "xfs_log.h"

 #include <linux/mm.h>
 #include <linux/dax.h>
@@ -75,6 +76,10 @@ xfs_dax_failure_fn(

 	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
 	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
+		/* Do not shutdown so early when device is to be removed */
+		if (notify->mf_flags & MF_MEM_REMOVE) {
+			return 0;
+		}
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		return -EFSCORRUPTED;
 	}
@@ -168,6 +173,7 @@ xfs_dax_notify_failure(
 	struct xfs_mount	*mp = dax_holder(dax_dev);
 	u64			ddev_start;
 	u64			ddev_end;
+	int			error;

 	if (!(mp->m_sb.sb_flags & SB_BORN)) {
 		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
@@ -182,6 +188,13 @@ xfs_dax_notify_failure(

 	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
 	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		if (mf_flags & MF_MEM_REMOVE) {
+			/* Flush the log since device is about to be removed. */
+			error = xfs_log_force(mp, XFS_LOG_SYNC);
+			if (error)
+				return error;
+			return -EOPNOTSUPP;
+		}
 		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		return -EFSCORRUPTED;
@@ -211,8 +224,16 @@ xfs_dax_notify_failure(
 	if (offset + len > ddev_end)
 		len -= ddev_end - offset;

-	return xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
+	error = xfs_dax_notify_ddev_failure(mp, BTOBB(offset), BTOBB(len),
 			mf_flags);
+	if (error)
+		return error;
+
+	if (mf_flags & MF_MEM_REMOVE) {
+		xfs_flush_inodes(mp);
+		error = xfs_log_force(mp, XFS_LOG_SYNC);
+	}
+	return error;
 }

 const struct dax_holder_operations xfs_dax_holder_operations = {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a2270e35a676..e66d23188323 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3236,6 +3236,7 @@ enum mf_flags {
 	MF_SOFT_OFFLINE = 1 << 3,
 	MF_UNPOISON = 1 << 4,
 	MF_SW_SIMULATED = 1 << 5,
+	MF_MEM_REMOVE = 1 << 6,
 };
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
--
2.36.1



