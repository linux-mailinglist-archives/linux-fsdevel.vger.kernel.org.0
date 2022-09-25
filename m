Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE5B5E936F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Sep 2022 15:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbiIYNeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 25 Sep 2022 09:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiIYNdy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 25 Sep 2022 09:33:54 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B0630F46;
        Sun, 25 Sep 2022 06:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1664112831; i=@fujitsu.com;
        bh=rWTztagXd3ebhKKtakvx6uZbv7eYUy2//ebuLJtL8JA=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Lt7Piz77zrIHn3rVDAmF3B3G0FOeODoqbIlHD28UEvd+29YWSJqpUg+03a4asbXw+
         /d7eA16vNiYO3mJTph8f7f8QIafRDPFFROTa4fI712OUb/fq2waP2JjdrhTumUZzlF
         55sBCYZuizYesn7bCbXonmL8Got4dT8Gcsga2Cs3q0F2KzNgEB27A8OGwkORpzeSSy
         YRbKgRc8f9znc2KFmd88MS0xq96F5wxWU0foiNcxX0krTrwThqNJ7nOmEn8j04xcE8
         2DX3R/gHfXTM3sXqPb4T03hsC4X5rnnO4s9mI/rCfQ1KjQe2vetPygaRY6nU0613tE
         s7s4o8UeuOllQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRWlGSWpSXmKPExsViZ8ORpLsvwiD
  ZYNN8EYvpUy8wWmw5do/R4vITPovTExYxWezZe5LF4vKuOWwW99b8Z7XY9WcHu8XKH39YHTg9
  Ti2S8Ni8Qstj8Z6XTB6bVnWyeWz6NInd48XmmYwenzfJBbBHsWbmJeVXJLBmrPr0jb1gr3LF6
  oMT2BoYH8l2MXJxCAlsZJRYvOQsE4SzhEnizMObUM5eRomzC5aydDFycrAJ6EhcWPCXFSQhIj
  CJUeLYjZvMIAlmgQSJ9i/XmEBsYQE3idOb17CC2CwCqhKTXv9lBLF5BVwkrq3sYgOxJQQUJKY
  8fA/WyyngKrF0yiqwXiGgmp69Z5kg6gUlTs58wgIxX0Li4IsXQPUcQL1KEjO74yHGVEg0Tj/E
  BGGrSVw9t4l5AqPgLCTds5B0L2BkWsVolVSUmZ5RkpuYmaNraGCga2hoqmuoa2RorpdYpZuol
  1qqW55aXKJrqJdYXqyXWlysV1yZm5yTopeXWrKJERhLKcWMN3cwtvb91DvEKMnBpCTKe9TPIF
  mILyk/pTIjsTgjvqg0J7X4EKMMB4eSBO8BN6CcYFFqempFWmYOMK5h0hIcPEoivIUgrbzFBYm
  5xZnpEKlTjMYcaxsO7GXmmDr7335mIZa8/LxUKXHeleFApQIgpRmleXCDYOnmEqOslDAvIwMD
  gxBPQWpRbmYJqvwrRnEORiVhXrdgoCk8mXklcPteAZ3CBHSKHZ8+yCkliQgpqQYm5YlNp2asv
  KSt9EDwypwXSSIbT05hbnCw8z3+8YX/sWaR6UVB+RcYMmc84HN1uhl90c/uda/uHa3jHe93dv
  Y1SQZfl/HL2a8b7tbV52jY8cVA1TnZweWWw62r/m7/5W41i+/1/3aaU8HsW3XsrJOiU81ZrKQ
  dL29r0vPS93E/kaM79Qa3lHu+u4Hn1pBZlwKOn/7HalFz7qmLWNEcr5L3uuzfT9ilClw3aXm0
  6tnTS858RgpeaaoRimssb7aWrGqZbczCWm/Oo56nW7z1YId7z249iSdr1J9a9sV+4qz7VldYt
  baLVWLTatmJJmlf/UwktT3/mMkej/loZyIadPmBjPTuljjL/ATVBWxWSizFGYmGWsxFxYkAAW
  T7+7IDAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-4.tower-591.messagelabs.com!1664112830!124372!1
X-Originating-IP: [62.60.8.98]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27799 invoked from network); 25 Sep 2022 13:33:50 -0000
Received: from unknown (HELO n03ukasimr03.n03.fujitsu.local) (62.60.8.98)
  by server-4.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Sep 2022 13:33:50 -0000
Received: from n03ukasimr03.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTP id DAE041AD;
        Sun, 25 Sep 2022 14:33:49 +0100 (BST)
Received: from R01UKEXCASM121.r01.fujitsu.local (R01UKEXCASM121 [10.183.43.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr03.n03.fujitsu.local (Postfix) with ESMTPS id CEF3D1AC;
        Sun, 25 Sep 2022 14:33:49 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM121.r01.fujitsu.local (10.183.43.173) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sun, 25 Sep 2022 14:33:46 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <hch@infradead.org>
Subject: [PATCH 3/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Sun, 25 Sep 2022 13:33:23 +0000
Message-ID: <1664112803-57-4-git-send-email-ruansy.fnst@fujitsu.com>
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
 fs/xfs/xfs_notify_failure.c | 28 +++++++++++++++++++++++++++-
 include/linux/mm.h          |  1 +
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 9b5e2a5eb0ae..cf9a64563fbe 100644
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
index 3830f908e215..5c1e678a1285 100644
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
@@ -168,7 +172,9 @@ xfs_dax_notify_ddev_failure(
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		if (!error)
 			error = -EFSCORRUPTED;
-	}
+	} else if (mf_flags & MF_MEM_PRE_REMOVE)
+		xfs_force_shutdown(mp, SHUTDOWN_FORCE_UMOUNT);
+
 	return error;
 }
 
@@ -182,12 +188,24 @@ xfs_dax_notify_failure(
 	struct xfs_mount	*mp = dax_holder(dax_dev);
 	u64			ddev_start;
 	u64			ddev_end;
+	int			error;
 
 	if (!(mp->m_super->s_flags & SB_BORN)) {
 		xfs_warn(mp, "filesystem is not ready for notify_failure()!");
 		return -EIO;
 	}
 
+	if (mf_flags & MF_MEM_PRE_REMOVE) {
+		xfs_info(mp, "device is about to be removed!");
+		down_write(&mp->m_super->s_umount);
+		error = sync_filesystem(mp->m_super);
+		/* invalidate_inode_pages2() invalidates dax mapping */
+		super_drop_pagecache(mp->m_super, invalidate_inode_pages2);
+		up_write(&mp->m_super->s_umount);
+		if (error)
+			return error;
+	}
+
 	if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_daxdev == dax_dev) {
 		xfs_debug(mp,
 			 "notify_failure() not supported on realtime device!");
@@ -196,6 +214,8 @@ xfs_dax_notify_failure(
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
 	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		if (mf_flags & MF_MEM_PRE_REMOVE)
+			return 0;
 		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		return -EFSCORRUPTED;
@@ -209,6 +229,12 @@ xfs_dax_notify_failure(
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
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 21f8b27bd9fd..9122a1c57dd2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3183,6 +3183,7 @@ enum mf_flags {
 	MF_UNPOISON = 1 << 4,
 	MF_SW_SIMULATED = 1 << 5,
 	MF_NO_RETRY = 1 << 6,
+	MF_MEM_PRE_REMOVE = 1 << 7,
 };
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
-- 
2.37.3

