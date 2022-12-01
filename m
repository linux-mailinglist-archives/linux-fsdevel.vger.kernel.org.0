Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB5963F3D9
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiLAP3d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:29:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbiLAP3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:29:25 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87063AA8EB;
        Thu,  1 Dec 2022 07:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669908562; i=@fujitsu.com;
        bh=vBpyht6zBsjBSm3ky1RkPkN8vgWTjrJcf3ER0ebcTM4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Qi3K4Nn2GwqiVoc9sZrDhXcYMFaiZVRWJN+sNxi34ibHfwYNBIAgRpcOb9brLWi4w
         mLThtJ5hx485wqlSNyDUs6Qr1gOvEBZJObrQM6m56uuj8hT1nBxVYaTzLnauzJWl+2
         UKkTIh/rRg1sdnaYaYXFYuWjdaQGUifsKS1zz6o/jLXkdQW1+2Vle2d8FWl8kEI1Yw
         w4R0agFm/4ZLOFlxf1WyCJril8z9EllDIPul0rWW+O8Pj3ye0g6Plt1/hvAT+lnP2j
         RPyUhjJ4VV0yGHG8WZxmhdA+KojPi1LzsnpjPFwRjLz6YijfW8FCQRm7l9NgKUBqO/
         H0HJ5ikyyxnSQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRWlGSWpSXmKPExsViZ8MxSTfoREe
  ywaoLMhZz1q9hs5g+9QKjxZZj9xgtLj/hs9iz9ySLxeVdc9gsdv3ZwW6x8scfVgcOj1OLJDwW
  73nJ5LFpVSebx4kZv1k8XmyeyejxeZNcAFsUa2ZeUn5FAmvGttmnWAvWClV032hjbGC8zdfFy
  MUhJLCFUeL6nCksEM5yJok7szYwQzh7GCXWvb3N1MXIycEmoCNxYcFf1i5GDg4RgWqJW0vZQM
  LMAhkSx6/8YQaxhQUsJFZM7mcFsVkEVCT27bvDAmLzCrhItD5YDVYjIaAgMeXhezCbU8BV4uX
  fjewgthBQzfXmg8wQ9YISJ2c+YYGYLyFx8MULZpC1EgJKEjO74yHGVEjMmtXGBGGrSVw9t4l5
  AqPgLCTds5B0L2BkWsVoWpxaVJZapGupl1SUmZ5RkpuYmaOXWKWbqJdaqlueWlyia6SXWF6sl
  1pcrFdcmZuck6KXl1qyiREYKynF6qo7GM8t+6N3iFGSg0lJlFd7X0eyEF9SfkplRmJxRnxRaU
  5q8SFGGQ4OJQnelD1AOcGi1PTUirTMHGDcwqQlOHiURHj5jgGleYsLEnOLM9MhUqcYFaXEeS+
  CJARAEhmleXBtsFRxiVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iw77ZtQFN4MvNK4Ka/AlrM
  BLQ4UqwNZHFJIkJKqoFp2vyPr7W7A/UXyz6e/bIrJFS+5Npl5k/JnQstSvsqoz59lAq1E27Nj
  jnCE1u05b5g/MtUE7k/bxuKvG+8vFkdGmV0J7W95d5T3y+bjJXWb1ySU7aMx/Uvb3Ds2T+buw
  VaZl8uU97CsKbuwl5Nvp2ZvqzLZ1a98vT/tnmBV1B9vtsPF5EeV+GHBs8sc/QWPHly78D2W/u
  3/5P0W/tvnaZReF++5Sb+wOW+ldMz73d0XJ409fYptQfn3x0T5FqQNDfZ//OVndf3yPOcUJwu
  M0uE0/mj5vbpOhtv+ybePSDuYNb1TeH7Y7W9eSp/e2sY5VK2yfwKXfCMXb7pQv5Hb8mjfdrzp
  UVuBXCtVGx7rTpBiaU4I9FQi7moOBEA4UmsiZADAAA=
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-7.tower-571.messagelabs.com!1669908562!94882!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15045 invoked from network); 1 Dec 2022 15:29:22 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-7.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 15:29:22 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 23ED01000DB;
        Thu,  1 Dec 2022 15:29:22 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 16F0E1000C1;
        Thu,  1 Dec 2022 15:29:22 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 15:29:18 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: [PATCH v2 2/8] fsdax: invalidate pages when CoW
Date:   Thu, 1 Dec 2022 15:28:52 +0000
Message-ID: <1669908538-55-3-git-send-email-ruansy.fnst@fujitsu.com>
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

CoW changes the share state of a dax page, but the share count of the
page isn't updated.  The next time access this page, it should have been
a newly accessed, but old association exists.  So, we need to clear the
share state when CoW happens, in both dax_iomap_rw() and
dax_zero_iter().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 85b81963ea31..482dda85ccaf 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1264,6 +1264,15 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 	if (srcmap->type == IOMAP_HOLE || srcmap->type == IOMAP_UNWRITTEN)
 		return length;
 
+	/*
+	 * invalidate the pages whose sharing state is to be changed
+	 * because of CoW.
+	 */
+	if (iomap->flags & IOMAP_F_SHARED)
+		invalidate_inode_pages2_range(iter->inode->i_mapping,
+					      pos >> PAGE_SHIFT,
+					      (pos + length - 1) >> PAGE_SHIFT);
+
 	do {
 		unsigned offset = offset_in_page(pos);
 		unsigned size = min_t(u64, PAGE_SIZE - offset, length);
@@ -1324,12 +1333,13 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		struct iov_iter *iter)
 {
 	const struct iomap *iomap = &iomi->iomap;
-	const struct iomap *srcmap = &iomi->srcmap;
+	const struct iomap *srcmap = iomap_iter_srcmap(iomi);
 	loff_t length = iomap_length(iomi);
 	loff_t pos = iomi->pos;
 	struct dax_device *dax_dev = iomap->dax_dev;
 	loff_t end = pos + length, done = 0;
 	bool write = iov_iter_rw(iter) == WRITE;
+	bool cow = write && iomap->flags & IOMAP_F_SHARED;
 	ssize_t ret = 0;
 	size_t xfer;
 	int id;
@@ -1356,7 +1366,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	 * into page tables. We have to tear down these mappings so that data
 	 * written by write(2) is visible in mmap.
 	 */
-	if (iomap->flags & IOMAP_F_NEW) {
+	if (iomap->flags & IOMAP_F_NEW || cow) {
 		invalidate_inode_pages2_range(iomi->inode->i_mapping,
 					      pos >> PAGE_SHIFT,
 					      (end - 1) >> PAGE_SHIFT);
@@ -1390,8 +1400,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			break;
 		}
 
-		if (write &&
-		    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
+		if (cow) {
 			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
 						 kaddr);
 			if (ret)
-- 
2.38.1

