Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 068C763F404
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiLAPdj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiLAPdU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:33:20 -0500
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88046ABA3F;
        Thu,  1 Dec 2022 07:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669908767; i=@fujitsu.com;
        bh=9IQSXH/mBJ0Rz36RhWdtV/CNJuRmPioRHTD0RIk1xlI=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=R8uXsH9yOqUsRPaoxjUGuV1g3UHH/LUIaiR0k/bP5MjwbiaqqRWA7fljFcQ2YAdQj
         Mq3EHaOLmR3DXasTotl3VZEs08QCdzpAhMPitHVel+EABJeMD8PJYJv39OJMJyKcjM
         kTCFX2YchTMSxYQwO59WfbI4KgfeDUIhXC/H2NaDc3KvIx5LymlVRB0M0La1d3X//w
         NbICES275v2veOWEyySMOXwTyhMn+dfq/wSHUmiUZ7MiW9rEPWXlAEGbRE5LN+5RJ9
         AjhVBR8w5xlNySX0B7ZRK/dVnqXaPJTsdamYbAnTJtGIf7HJIXhKX/87TIS2z9eSc4
         IxL0IzbvIPo3A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleJIrShJLcpLzFFi42Kxs+GYpCt3siP
  Z4HqbkcWc9WvYLKZPvcBoseXYPUaLy0/4LPbsPclicXnXHDaLXX92sFus/PGH1YHD49QiCY/F
  e14yeWxa1cnmcWLGbxaPF5tnMnp83iQXwBbFmpmXlF+RwJrxZtcxpoIdEhXnb3xiaWA8J9LFy
  MUhJLCFUeL22gb2LkZOIGc5k8SkD84QiT2MElte3WEDSbAJ6EhcWPCXtYuRg0NEoFri1lKwML
  NAhsTxK3+YQWxhAQuJtl2bweawCKhI/JixlxXE5hVwlXg86SoTiC0hoCAx5eF7sHpOoPjLvxu
  h9rpIXG8+yAxRLyhxcuYTFoj5EhIHX7xgBlkrIaAkMbM7HmJMhcSsWW1QI9Ukrp7bxDyBUXAW
  ku5ZSLoXMDKtYjQtTi0qSy3SNdFLKspMzyjJTczM0Uus0k3USy3VLU8tLtE11EssL9ZLLS7WK
  67MTc5J0ctLLdnECIyUlGI2nx2M/5b+0TvEKMnBpCTKq72vI1mILyk/pTIjsTgjvqg0J7X4EK
  MMB4eSBG/KHqCcYFFqempFWmYOMGph0hIcPEoivHzHgNK8xQWJucWZ6RCpU4zGHGsbDuxl5pg
  6+99+ZiGWvPy8VClx3sDjQKUCIKUZpXlwg2DJ5BKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYl
  Yd5t24Cm8GTmlcDtewV0ChPQKZFibSCnlCQipKQamIzLMj/o6NwuimRbyrtgc0zLJy5zBaZf+
  tNPyJy1s7CyWPX4ZXFU48mJe2ptS2L5GD+6vJY02RC3J9+KeU0Gd479HR2NP53nJZiFmNg8Lb
  +tfmVvaexgf0JD7YBHv4nvdanFk+bVxP/atu7oRfeupr0/ymcWu8VL3vo9q+Tn5bLQmvOeZ1/
  NVyx+ncPZrc5l0GbRLay/wvOLl6na0x8bJ7FbMJyTsj2ZOK3IzWm5U5fxkZq9Rp+e37P2/J5X
  Gi91Y+u58y+4S9fe7HvyzN7w0yaX6YbuSccuzjqw9+7JpHtCE8Nmn9x69qPAuXXz1yyUZT0S3
  dyo8vuT9Jp3By22O8178iam5SmXJh9ru8Ceg0osxRmJhlrMRcWJAFpNk5yhAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-22.tower-587.messagelabs.com!1669908766!107085!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 27136 invoked from network); 1 Dec 2022 15:32:46 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-22.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 15:32:46 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 5C5231000D5;
        Thu,  1 Dec 2022 15:32:46 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 4F77B1000C1;
        Thu,  1 Dec 2022 15:32:46 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 15:32:42 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: [PATCH v2 7/8] fsdax,xfs: port unshare to fsdax
Date:   Thu, 1 Dec 2022 15:32:33 +0000
Message-ID: <1669908753-169-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1669908538-55-1-git-send-email-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
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

Implement unshare in fsdax mode: copy data from srcmap to iomap.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c             | 52 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.c |  8 +++++--
 include/linux/dax.h  |  2 ++
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 354be56750c2..a57e320e7971 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1244,6 +1244,58 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
+static s64 dax_unshare_iter(struct iomap_iter *iter)
+{
+	struct iomap *iomap = &iter->iomap;
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
+	int id = 0;
+	s64 ret = 0;
+	void *daddr = NULL, *saddr = NULL;
+
+	/* don't bother with blocks that are not shared to start with */
+	if (!(iomap->flags & IOMAP_F_SHARED))
+		return length;
+	/* don't bother with holes or unwritten extents */
+	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
+		return length;
+
+	id = dax_read_lock();
+	ret = dax_iomap_direct_access(iomap, pos, length, &daddr, NULL);
+	if (ret < 0)
+		goto out_unlock;
+
+	ret = dax_iomap_direct_access(srcmap, pos, length, &saddr, NULL);
+	if (ret < 0)
+		goto out_unlock;
+
+	ret = copy_mc_to_kernel(daddr, saddr, length);
+	if (ret)
+		ret = -EIO;
+
+out_unlock:
+	dax_read_unlock(id);
+	return ret;
+}
+
+int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
+		const struct iomap_ops *ops)
+{
+	struct iomap_iter iter = {
+		.inode		= inode,
+		.pos		= pos,
+		.len		= len,
+		.flags		= IOMAP_WRITE | IOMAP_UNSHARE | IOMAP_DAX,
+	};
+	int ret;
+
+	while ((ret = iomap_iter(&iter, ops)) > 0)
+		iter.processed = dax_unshare_iter(&iter);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(dax_file_unshare);
+
 static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
 {
 	const struct iomap *iomap = &iter->iomap;
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 93bdd25680bc..fe46bce8cae6 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -1693,8 +1693,12 @@ xfs_reflink_unshare(
 
 	inode_dio_wait(inode);
 
-	error = iomap_file_unshare(inode, offset, len,
-			&xfs_buffered_write_iomap_ops);
+	if (IS_DAX(inode))
+		error = dax_file_unshare(inode, offset, len,
+				&xfs_dax_write_iomap_ops);
+	else
+		error = iomap_file_unshare(inode, offset, len,
+				&xfs_buffered_write_iomap_ops);
 	if (error)
 		goto out;
 
diff --git a/include/linux/dax.h b/include/linux/dax.h
index ba985333e26b..2b5ecb591059 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -205,6 +205,8 @@ static inline void dax_unlock_mapping_entry(struct address_space *mapping,
 }
 #endif
 
+int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
+		const struct iomap_ops *ops);
 int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		const struct iomap_ops *ops);
 int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-- 
2.38.1

