Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 189194FAF3F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Apr 2022 19:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239532AbiDJRSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 Apr 2022 13:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbiDJRSl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:18:41 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA12D583B0;
        Sun, 10 Apr 2022 10:16:29 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AVvyYO6uaBqbAJzGM+x5z/Iq0BOfnVD1fMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3ymIYDD+DaKnbYWejeNB1PI+y/EoHucLXx4BrTgJo+H1gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm65fPkhGaKCKEL/JGSRte0Zcj0up+H2B?=
 =?us-ascii?q?C3fICLzUKdBqCm6S9x7fTYulnhuwiKsfxNY8Ss30myivWZd4qSJaFQePV5Ntc3?=
 =?us-ascii?q?T41nehPG+rTY4wSbj8HRBjCfBpJNX8UBYg4kePugWPwGxVcqVSIte8y5kDQ0gV?=
 =?us-ascii?q?60/7qKtW9UtqUScRQm26cp3na5CL9AxcHJJqTxCTt2nClgOKJliPmcIUIHba8+?=
 =?us-ascii?q?7hhh1j77mgSDgAGEFWgrfSnh0qWRd1SMQoX9zAooKx081akJvH5XhulsDuHswQ?=
 =?us-ascii?q?aVt54DeI38keOx7DS7gLfAXILJhZFado7pIomSycCyFCEhZXqCCZpvbnTTmiSn?=
 =?us-ascii?q?op4Bxva1TM9dDdEPHFbC1BepYSLnW36tTqXJv4LLUJ/poSd9enM/g23?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A6G4Bcap521rlgzzkrg4nTksaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123454431"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Apr 2022 01:16:28 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 7BE8A4D16FF4;
        Mon, 11 Apr 2022 01:16:24 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 11 Apr 2022 01:16:27 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 11 Apr 2022 01:16:23 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [RFC PATCH] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Mon, 11 Apr 2022 01:16:23 +0800
Message-ID: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 7BE8A4D16FF4.A3A26
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
   -> pmem driver ->remove()
    -> kill_dax()
     -> dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_REMOVE)
      -> xfs_dax_notify_failure()

Introduce MF_MEM_REMOVE to let filesystem know this is a remove event.
So do not shutdown filesystem directly if something not supported, or if
failure range includes metadata area.  Make sure all files and processes
are handled correctly.

Based on "[PATCH v12] fsdax: introduce fs query to support reflink"[2]

[1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/
[2]: https://lore.kernel.org/linux-xfs/20220410160904.3758789-1-ruansy.fnst@fujitsu.com/T/#t

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c         | 2 +-
 drivers/nvdimm/pmem.c       | 3 ++-
 fs/xfs/xfs_notify_failure.c | 6 +++++-
 include/linux/mm.h          | 1 +
 4 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 619a05615497..52f820fdd8ff 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -312,7 +312,7 @@ void kill_dax(struct dax_device *dax_dev)
 		return;
 
 	if (dax_dev->holder_data != NULL)
-		dax_holder_notify_failure(dax_dev, 0, U64_MAX, 0);
+		dax_holder_notify_failure(dax_dev, 0, U64_MAX, MF_MEM_REMOVE);
 
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
 	synchronize_srcu(&dax_srcu);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index bd502957cfdf..72d9e69aea98 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -359,7 +359,6 @@ static void pmem_release_disk(void *__pmem)
 	struct pmem_device *pmem = __pmem;
 
 	dax_remove_host(pmem->disk);
-	kill_dax(pmem->dax_dev);
 	put_dax(pmem->dax_dev);
 	del_gendisk(pmem->disk);
 
@@ -597,6 +596,8 @@ static void nd_pmem_remove(struct device *dev)
 		pmem->bb_state = NULL;
 	}
 	nvdimm_flush(to_nd_region(dev->parent), NULL);
+
+	kill_dax(pmem->dax_dev);
 }
 
 static void nd_pmem_shutdown(struct device *dev)
diff --git a/fs/xfs/xfs_notify_failure.c b/fs/xfs/xfs_notify_failure.c
index aac44f54feb4..f8b41085218b 100644
--- a/fs/xfs/xfs_notify_failure.c
+++ b/fs/xfs/xfs_notify_failure.c
@@ -73,7 +73,9 @@ xfs_dax_failure_fn(
 	struct failure_info		*notify = data;
 	int				error = 0;
 
-	if (XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
+	/* Do not shutdown so early when device is to be removed */
+	if (!(notify->mf_flags & MF_MEM_REMOVE) ||
+	    XFS_RMAP_NON_INODE_OWNER(rec->rm_owner) ||
 	    (rec->rm_flags & (XFS_RMAP_ATTR_FORK | XFS_RMAP_BMBT_BLOCK))) {
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		return -EFSCORRUPTED;
@@ -181,6 +183,8 @@ xfs_dax_notify_failure(
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
 	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		if (mf_flags & MF_MEM_REMOVE)
+			return -EOPNOTSUPP;
 		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		return -EFSCORRUPTED;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 742604feef28..b47c3745782d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3225,6 +3225,7 @@ enum mf_flags {
 	MF_MUST_KILL = 1 << 2,
 	MF_SOFT_OFFLINE = 1 << 3,
 	MF_UNPOISON = 1 << 4,
+	MF_MEM_REMOVE = 1 << 5,
 };
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
-- 
2.35.1



