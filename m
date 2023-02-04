Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1932068AAC9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Feb 2023 15:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjBDO7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Feb 2023 09:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbjBDO7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:59:21 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B109936098;
        Sat,  4 Feb 2023 06:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1675522752; i=@fujitsu.com;
        bh=iZXWDU8e1IDq/UlXTzSKcomjkFKqhLWmrwUndstFZbY=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Y3EvQ3MX1dUVylN/yQ8OGaXHEumBT6+fn+8Ln7a8/pWTcxYfrNQXWFWPTEWYyW2lz
         4P14dnakHApQCS5+ZJRwlsN2LaFXnFGrKNjtgvTaOObd4agLZsZokSnkrtzbBme2J2
         SjCM0MOtozK0sU5nJVtnL+N/csvzfqIbW0UXl0fLA5bvKrTJViTwxgV1U4F0NRgqD3
         sUSfr2PGs3CT9JJY+hAjEuO8ZB19cYwrXJh58fMRQ7glVi5GeAGm4agSkY2AzkvF4q
         yjE8zgj50K0t1o5B0GGZbsknVdgU23cJmFgdIcawwcpS9QY8J335OYz69KQacG0CFM
         jbqJ7jshZeQTA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRWlGSWpSXmKPExsViZ8ORqLuv6F6
  ywYvPohbTp15gtNhy7B6jxeUnfBanJyxistj9+iabxZ69J1ksLu+aw2Zxb81/Votdf3awW6z8
  8YfVgcvj1CIJj80rtDwW73nJ5LFpVSebx6ZPk9g9Xmyeyejx8ektFo/Pm+QCOKJYM/OS8isSW
  DM2rqsv2KtcsbNtG0sD4yPZLkYuDiGBLYwSOxrOsUM4K5gkLt0+zgjh7GWUmDJxH5DDycEmoC
  NxYcFfVpCEiMAkRoljN24ygySYBcol9m+8wQZiCwt4StyYuJEFxGYRUJH4sqUVLM4r4CLxr+8
  lO4gtIaAgMeXhe7BeTgFXibfvz4LVCAHVNN/5zQRRLyhxcuYTFoj5EhIHX7wAqucA6lWSmNkd
  DzGmUqL1wy8WCFtN4uq5TcwTGAVnIemehaR7ASPTKkbT4tSistQiXRO9pKLM9IyS3MTMHL3EK
  t1EvdRS3fLU4hJdI73E8mK91OJiveLK3OScFL281JJNjMCYSilWPLaD8V/vX71DjJIcTEqivP
  3+d5OF+JLyUyozEosz4otKc1KLDzHKcHAoSfBeL7iXLCRYlJqeWpGWmQOMb5i0BAePkgjvb5A
  0b3FBYm5xZjpE6hSjLsfahgN7mYVY8vLzUqXEeVsLgYoEQIoySvPgRsBSzSVGWSlhXkYGBgYh
  noLUotzMElT5V4ziHIxKwry3QFbxZOaVwG16BXQEE9AR3QZ3QY4oSURISTUwzTyQtXpv5pF3W
  +Jr5zIb8+xfUVp4emrIwQlWS7gb/BZLZB+uCuiu3F2Xum7jssxl+7zsO77sjlaav+pIl/uNVA
  HJRfnOTQ9YesITLXbP5jwleLjt5cKYJt8vbzjEbK9usTc9W/P797HoCZ8ynN5xpTnODXfNZEm
  p0gk90H59tfOszWlvq06tevLLdSsH/0+v/jKpjSkVBc9MnSWFftQmrJ+Y4l14rtnCJP71gyO9
  E39qb834I6u6zL/ZsuTl95Ijuxf+abh97u8+R24O14gD6x44/DOZwfaTf0Kt5bGsHy8Eb+WvF
  n2aKmEyI6ZMOqR4huK6p3PZ5zIwp/02v9dSaMR6uv9GhcTX69+NOA5fVmIpzkg01GIuKk4EAD
  YN41ywAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-6.tower-571.messagelabs.com!1675522750!174342!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.102.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30248 invoked from network); 4 Feb 2023 14:59:10 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-6.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 4 Feb 2023 14:59:10 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id F423E100195;
        Sat,  4 Feb 2023 14:59:09 +0000 (GMT)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id E6BC3100188;
        Sat,  4 Feb 2023 14:59:09 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Sat, 4 Feb 2023 14:59:06 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v9 3/3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Sat, 4 Feb 2023 14:58:38 +0000
Message-ID: <1675522718-88-4-git-send-email-ruansy.fnst@fujitsu.com>
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
index da4438f3188c..40274d19f4f9 100644
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

