Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B5963F3DB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Dec 2022 16:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiLAP3f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 10:29:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiLAP3b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 10:29:31 -0500
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8575AAA8EE;
        Thu,  1 Dec 2022 07:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669908566; i=@fujitsu.com;
        bh=VAWKmEy62InpmeBtKPSmv+Xw3NA5QI6vwuyFpplRjqk=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=DsC2GpwQm5wa98lPuyqdM4AC65/eDdzTKWnns5zNber7NrfsO6g+fwK1vgZq2cr16
         8BQCF9Il1mlaTQMZ9saWkfxeaATdfvt5CwBy2oeZa13wEdFJNAUxQYqH5fpasTim2A
         4YLYU0siS3y2PNRPyKAlvqBkF+BGKlWAYQlkNbtn83lZpW3jl/xl3152ks17JOrHq6
         ojkUc2BQ8BXP45PytLDs+UJ+bLuKZaYWLYBrEDoXWFjYHNjIJI3FQbknfbIg46HBfI
         n0gbFwPrSlwMFztdeG+uVPiY13+fbo9NOeKf2ePF1II8kC2s90/kBw/Ej2ld409kx0
         ahbl8p9ESKgXg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRWlGSWpSXmKPExsViZ8ORqBt2oiP
  Z4PNaTos569ewWUyfeoHRYsuxe4wWl5/wWezZe5LF4vKuOWwWu/7sYLdY+eMPqwOHx6lFEh6L
  97xk8ti0qpPN48SM3yweLzbPZPT4vEkugC2KNTMvKb8igTWjcVcra8Fs7Yp/bVOZGhhfKHUxc
  nEICWxhlDjX2sLaxcgJ5Cxnkjj90hEisYdR4u6nNWAJNgEdiQsL/gLZHBwiAtUSt5aygYSZBT
  Ikjl/5wwxiCwv4SDx+OAusnEVAReL0shVMIDavgIvEk2kTweISAgoSUx6+B6vnFHCVePl3Izv
  EXheJ680HmSHqBSVOznzCAjFfQuLgixfMIGslBJQkZnbHQ4ypkJg1q40JwlaTuHpuE/MERsFZ
  SLpnIelewMi0itGsOLWoLLVI11gvqSgzPaMkNzEzRy+xSjdRL7VUNy+/qCRD11AvsbxYL7W4W
  K+4Mjc5J0UvL7VkEyMwVlKK09fvYHy39I/eIUZJDiYlUV7tfR3JQnxJ+SmVGYnFGfFFpTmpxY
  cYZTg4lCR4U/YA5QSLUtNTK9Iyc4BxC5OW4OBREuHlOwaU5i0uSMwtzkyHSJ1iVJQS570IkhA
  ASWSU5sG1wVLFJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvNu2AU3hycwrgZv+CmgxE9Di
  SLE2kMUliQgpqQamdZOehtgfNfukyHzSdmaP2BLDZ+KqEU3r5uzeab4yLM/vc81/F4vsXSuaj
  sjEm6TtjZmxePr2K+uyWPfucp2XtLTwm0iPzAuZtzcPden9XeSqlHBQTMCuVrel8QCnzj3V9/
  OCsi01M7SOlzHnvnXfEGDyNqEzL7fYX+DqlDnzQ+dz6PTXd2huv2WSpfqrfn2kpHhk9f0nibL
  XjWdO4jO63ffh3Qlx0YRknkneDCqb/wv4H3/QbBF9/qgPx9Q96x3320rf23/4z7ZQHe+O3Bmh
  cySX3BOqqbsf36ymYOFZX/rqy5m1Asb8j9jn5ZmWthpuYpzveDr9bvxZwUD1RP/qikjBSynGt
  cu79okaGCixFGckGmoxFxUnAgChjXzJkAMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-4.tower-728.messagelabs.com!1669908565!130706!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23126 invoked from network); 1 Dec 2022 15:29:26 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-4.tower-728.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Dec 2022 15:29:26 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 898641001A4;
        Thu,  1 Dec 2022 15:29:25 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 7DA1810019E;
        Thu,  1 Dec 2022 15:29:25 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Thu, 1 Dec 2022 15:29:22 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: [PATCH v2 3/8] fsdax: zero the edges if source is HOLE or UNWRITTEN
Date:   Thu, 1 Dec 2022 15:28:53 +0000
Message-ID: <1669908538-55-4-git-send-email-ruansy.fnst@fujitsu.com>
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

If srcmap contains invalid data, such as HOLE and UNWRITTEN, the dest
page should be zeroed.  Otherwise, since it's a pmem, old data may
remains on the dest page, the result of CoW will be incorrect.

The function name is also not easy to understand, rename it to
"dax_iomap_copy_around()", which means it copys data around the range.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c | 78 ++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 30 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 482dda85ccaf..6b6e07ad8d80 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1092,7 +1092,7 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 }
 
 /**
- * dax_iomap_cow_copy - Copy the data from source to destination before write
+ * dax_iomap_copy_around - Copy the data from source to destination before write
  * @pos:	address to do copy from.
  * @length:	size of copy operation.
  * @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
@@ -1101,35 +1101,50 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
  *
  * This can be called from two places. Either during DAX write fault (page
  * aligned), to copy the length size data to daddr. Or, while doing normal DAX
- * write operation, dax_iomap_actor() might call this to do the copy of either
+ * write operation, dax_iomap_iter() might call this to do the copy of either
  * start or end unaligned address. In the latter case the rest of the copy of
- * aligned ranges is taken care by dax_iomap_actor() itself.
+ * aligned ranges is taken care by dax_iomap_iter() itself.
+ * If the srcmap contains invalid data, such as HOLE and UNWRITTEN, zero the
+ * area to make sure no old data remains.
  */
-static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
+static int dax_iomap_copy_around(loff_t pos, uint64_t length, size_t align_size,
 		const struct iomap *srcmap, void *daddr)
 {
 	loff_t head_off = pos & (align_size - 1);
 	size_t size = ALIGN(head_off + length, align_size);
 	loff_t end = pos + length;
 	loff_t pg_end = round_up(end, align_size);
+	/* copy_all is usually in page fault case */
 	bool copy_all = head_off == 0 && end == pg_end;
+	/* zero the edges if srcmap is a HOLE or IOMAP_UNWRITTEN */
+	bool zero_edge = srcmap->flags & IOMAP_F_SHARED ||
+			 srcmap->type == IOMAP_UNWRITTEN;
 	void *saddr = 0;
 	int ret = 0;
 
-	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
-	if (ret)
-		return ret;
+	if (!zero_edge) {
+		ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
+		if (ret)
+			return ret;
+	}
 
 	if (copy_all) {
-		ret = copy_mc_to_kernel(daddr, saddr, length);
-		return ret ? -EIO : 0;
+		if (zero_edge)
+			memset(daddr, 0, size);
+		else
+			ret = copy_mc_to_kernel(daddr, saddr, length);
+		goto out;
 	}
 
 	/* Copy the head part of the range */
 	if (head_off) {
-		ret = copy_mc_to_kernel(daddr, saddr, head_off);
-		if (ret)
-			return -EIO;
+		if (zero_edge)
+			memset(daddr, 0, head_off);
+		else {
+			ret = copy_mc_to_kernel(daddr, saddr, head_off);
+			if (ret)
+				return -EIO;
+		}
 	}
 
 	/* Copy the tail part of the range */
@@ -1137,12 +1152,19 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
 		loff_t tail_off = head_off + length;
 		loff_t tail_len = pg_end - end;
 
-		ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
-					tail_len);
-		if (ret)
-			return -EIO;
+		if (zero_edge)
+			memset(daddr + tail_off, 0, tail_len);
+		else {
+			ret = copy_mc_to_kernel(daddr + tail_off,
+						saddr + tail_off, tail_len);
+			if (ret)
+				return -EIO;
+		}
 	}
-	return 0;
+out:
+	if (zero_edge)
+		dax_flush(srcmap->dax_dev, daddr, size);
+	return ret ? -EIO : 0;
 }
 
 /*
@@ -1241,13 +1263,10 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
 	if (ret < 0)
 		return ret;
 	memset(kaddr + offset, 0, size);
-	if (srcmap->addr != iomap->addr) {
-		ret = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap,
-					 kaddr);
-		if (ret < 0)
-			return ret;
-		dax_flush(iomap->dax_dev, kaddr, PAGE_SIZE);
-	} else
+	if (iomap->flags & IOMAP_F_SHARED)
+		ret = dax_iomap_copy_around(pos, size, PAGE_SIZE, srcmap,
+					    kaddr);
+	else
 		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	return ret;
 }
@@ -1401,8 +1420,8 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		}
 
 		if (cow) {
-			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
-						 kaddr);
+			ret = dax_iomap_copy_around(pos, length, PAGE_SIZE,
+						    srcmap, kaddr);
 			if (ret)
 				break;
 		}
@@ -1547,7 +1566,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		struct xa_state *xas, void **entry, bool pmd)
 {
 	const struct iomap *iomap = &iter->iomap;
-	const struct iomap *srcmap = &iter->srcmap;
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
@@ -1578,9 +1597,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
 
-	if (write &&
-	    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
-		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
+	if (write && iomap->flags & IOMAP_F_SHARED) {
+		err = dax_iomap_copy_around(pos, size, size, srcmap, kaddr);
 		if (err)
 			return dax_fault_return(err);
 	}
-- 
2.38.1

