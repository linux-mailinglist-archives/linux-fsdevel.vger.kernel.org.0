Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B7D54C93A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 14:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351137AbiFOMyL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 08:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349376AbiFOMyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:54:07 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD04C2DD5F;
        Wed, 15 Jun 2022 05:54:04 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A7AsUtKId1AvLrT49FE+RupQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDo0Dkr02BTnWVNUWrQaPqNYWqjKNoib4u3pE4Gv8fVmoNqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkj/nRHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToy+UltZq2ZNDs4esY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQcpO6YcCnl4KR/yGWDKRMA2c5GAEgoPIEw9PxwBGZ?=
 =?us-ascii?q?U//0EbjsKa3irh+m26LO9RPNliskqII/sJox3kn1py3fbS+knRZTCSqDRzd5ew?=
 =?us-ascii?q?Do0wMtJGJ72a8gGbjxgRBfNeRtCPhEQEp1WtOOpgGTvNjhdgFGLrKE0pW/Jw2R?=
 =?us-ascii?q?Z1qbhMd/QUtiLXtlO2EKZoH/WuWj0HHkyNtWZxHyO8m+EgfXGlif2HokVEdWQ8?=
 =?us-ascii?q?v9snU3WyHcfBQMbUXOlrvSjzE2zQdRSLwoT4CVGhawz8lG7C9rwRRu1pFaasRM?=
 =?us-ascii?q?GHdldCes37EeK0KW8ywKYAHUUCy5Pc/Q4u8IsAz8nzFmEm5XuHzMHjVE/YRpx7?=
 =?us-ascii?q?Z/N9XXrZ3dTdjREOEc5ocI+y4GLiOkOYtjnFL6PyJKIs+A=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AMlXlkql4KcWskQNZcoFR3X7Hn73pDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124979929"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Jun 2022 20:54:03 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id D8E334D1719F;
        Wed, 15 Jun 2022 20:54:02 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 15 Jun 2022 20:54:04 +0800
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 15 Jun 2022 20:54:02 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 15 Jun 2022 20:54:02 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [RFC PATCH v3] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Date:   Wed, 15 Jun 2022 20:54:00 +0800
Message-ID: <20220615125400.880067-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D8E334D1719F.A2FA5
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

[1]: https://lore.kernel.org/linux-mm/161604050314.1463742.14151665140035795571.stgit@dwillia2-desk3.amr.corp.intel.com/

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>

==
Changes since v2:
  1. Rebased on next-20220615

Changes since v1:
  1. Drop the needless change of moving {kill,put}_dax()
  2. Rebased on '[PATCHSETS] v14 fsdax-rmap + v11 fsdax-reflink'[2]

---
 drivers/dax/super.c         | 2 +-
 fs/xfs/xfs_notify_failure.c | 6 +++++-
 include/linux/mm.h          | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

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
index aa8dc27c599c..91d3f05d4241 100644
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
@@ -182,6 +184,8 @@ xfs_dax_notify_failure(
 
 	if (mp->m_logdev_targp && mp->m_logdev_targp->bt_daxdev == dax_dev &&
 	    mp->m_logdev_targp != mp->m_ddev_targp) {
+		if (mf_flags & MF_MEM_REMOVE)
+			return -EOPNOTSUPP;
 		xfs_err(mp, "ondisk log corrupt, shutting down fs!");
 		xfs_force_shutdown(mp, SHUTDOWN_CORRUPT_ONDISK);
 		return -EFSCORRUPTED;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 623c2ee8330a..bbeb31883362 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3249,6 +3249,7 @@ enum mf_flags {
 	MF_SOFT_OFFLINE = 1 << 3,
 	MF_UNPOISON = 1 << 4,
 	MF_NO_RETRY = 1 << 5,
+	MF_MEM_REMOVE = 1 << 6,
 };
 int mf_dax_kill_procs(struct address_space *mapping, pgoff_t index,
 		      unsigned long count, int mf_flags);
-- 
2.36.1



