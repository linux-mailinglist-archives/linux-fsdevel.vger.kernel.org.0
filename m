Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC9637C1E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 15:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiKXOz3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 09:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiKXOzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:55:25 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F7E7046B;
        Thu, 24 Nov 2022 06:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669301718; i=@fujitsu.com;
        bh=ol5k0lY8l/ReA1M7nu2Fvofzj3cLcmX+yKyrNJUp2tQ=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=oeyNqrLfBTMCBURHgjslINWpkYSts+y7zERiXyK2KzRxvPpZbsFld52wA8Hb4i1Jg
         lDPNAt+UT3w1M5Q0PypXv2andWmp0H4lf70GY7cs1Fps6L+FiS9M4wg3HI96vu1qDW
         DbZqWrP3ILg01HkhWTnlNZ0YSwTV1XSt0PoSKHS1CKFSNHCf7R2fDfGbEaYXAdKYKZ
         71Yf3Ap5B4SZu1/k51qa632UTnqJKnmIsp5MiRmUIhf151qBL0iCQRSGgEE1+uXk2y
         Gn2n6AM+gNUAzJcd0Wqt3QGu/FbGQTOs8T1P0keYChi5SyD/Z/IxCSR3h3agfbQii4
         2vFauNiAgHxTQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleJIrShJLcpLzFFi42Kxs+HYrHu1tT7
  Z4NIEHYvpUy8wWmw5do/R4vITPos9e0+yWFzeNYfNYtefHewWK3/8YXVg9zi1SMJj8Z6XTB6b
  VnWyebzYPJPR4/MmuQDWKNbMvKT8igTWjNvn7QraJSruzJjF2sC4SKSLkZNDSGAjo8SFtepdj
  FxA9hImiU2vj7JDOHsZJQ4vXMwIUsUmoCNxYcFf1i5GDg4RgWqJW0vZQMLMAl4Sa19vYAYJCw
  uYSmzYqQISZhFQlWie9YsdxOYVcJGYNP8ImC0hoCAx5eF7ZhCbU8BVYnfTc7BWIaCavl+2EOW
  CEidnPmGBmC4hcfDFC7ASCQEliZnd8RBTKiRmzWpjgrDVJK6e28Q8gVFwFpLuWUi6FzAyrWI0
  L04tKkst0jUy0EsqykzPKMlNzMzRS6zSTdRLLdXNyy8qydA11EssL9ZLLS7WK67MTc5J0ctLL
  dnECIyJlOKkxB2Mfcv+6B1ilORgUhLlvZVTnyzEl5SfUpmRWJwRX1Sak1p8iFGGg0NJgtejHi
  gnWJSanlqRlpkDjE+YtAQHj5IIr3s5UJq3uCAxtzgzHSJ1itGYY23Dgb3MHFNn/9vPLMSSl5+
  XKiXOG9QCVCoAUppRmgc3CJY2LjHKSgnzMjIwMAjxFKQW5WaWoMq/YhTnYFQS5pUAJiEhnsy8
  Erh9r4BOYQI65alOHcgpJYkIKakGJrmUtxMYqyVf59tf++StKmbEmBNV5fti/88Du6v6+VNmz
  mHeo+/WV8l/eVWEaLFB6PpEZ/7XX5burBSIVPlakWBw5KXNzzOWhywDlkRF59zRlX57ZJHRQu
  trR/xK0p9f73d4cvD2vQNhN93MH9y5dXRWGdM3yYZvjJM//Y4/cMKdM3RK7j2FD+39y4rOvui
  0lD02aYOiowqzfHButohW7LLd3vY3JrELxvppWH6bconzSlpVU+KTdTH8i3unTnjE/iGweGn8
  8vs3tu3s3s9t92iB05dgflNnVY/MuZIzOLUl/Taf7K98ePrICb5ny+SbOhRnxMwraeUW/5iVn
  JB8u3VZ05v68z9rNSdrB9VdUGIpzkg01GIuKk4EAErFLrCWAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-4.tower-728.messagelabs.com!1669301717!42856!1
X-Originating-IP: [62.60.8.179]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32153 invoked from network); 24 Nov 2022 14:55:17 -0000
Received: from unknown (HELO n03ukasimr04.n03.fujitsu.local) (62.60.8.179)
  by server-4.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Nov 2022 14:55:17 -0000
Received: from n03ukasimr04.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTP id 1D6E0151;
        Thu, 24 Nov 2022 14:55:17 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr04.n03.fujitsu.local (Postfix) with ESMTPS id 10E79150;
        Thu, 24 Nov 2022 14:55:17 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 24 Nov 2022 14:55:14 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>
Subject: [PATCH 2/2] fsdax,xfs: port unshare to fsdax
Date:   Thu, 24 Nov 2022 14:54:54 +0000
Message-ID: <1669301694-16-3-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
References: <1669301694-16-1-git-send-email-ruansy.fnst@fujitsu.com>
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
---
 fs/dax.c             | 52 ++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_reflink.c |  8 +++++--
 include/linux/dax.h  |  2 ++
 3 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 5ea7c0926b7f..3d0bf68ab6b0 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1235,6 +1235,58 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
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

