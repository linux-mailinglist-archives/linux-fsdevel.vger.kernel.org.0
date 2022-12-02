Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C952C64034D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 10:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbiLBJ00 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Dec 2022 04:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbiLBJ0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Dec 2022 04:26:04 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B76DB43C3;
        Fri,  2 Dec 2022 01:26:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669973161; i=@fujitsu.com;
        bh=7Gh67qKW0EaWHKgn5AoVn9psrj7yKSlvOKC1gXmit9M=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=Qmosm8omzUsPVuQCzidCKcRa1vj79KIdvtncPuVfSzeuswDyAZVAFeDr/ngYEZDXM
         okkQDpjpswGK7+FQEmbkQeN/E5sgSHPBYwUKN1V2Hhp6fE/z4S+KEwwnxuV8H1zyMg
         im0gMBXDqJSHGYt/co6N2TrC3CQBzfyVXgq5+w0SN9LMonyPVfOGCDoFX9+2EJBe6b
         0ad7azCsjQX5lGzPWK+50ZnsfCfq5ux9jzkTfP/QUDynz68GzSUuhH3cdZ9BtrIoaz
         5+5kbgCx2kXsebs/CH4yxEe14du+FRFTSdlsxPAuyTi2tEFD3JSlCW7ktB9TJEXLxs
         qWmBqE93vJbRw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRWlGSWpSXmKPExsViZ8MxSXfFkc5
  kg46dUhZz1q9hs5g+9QKjxZZj9xgtLj/hs9iz9ySLxeVdc9gsdv3ZwW6x8scfVgcOj1OLJDwW
  73nJ5LFpVSebx4kZv1k8XmyeyejxeZNcAFsUa2ZeUn5FAmvGhVVn2At6dCp2zP7J3MB4TLmLk
  YtDSGALo8TOQ6dYIJzlTBInO06wQTh7GCWar9wEynBysAnoSFxY8Je1i5GDQ0SgWuLWUjaQML
  NAhsTxK3+YQWxhAT+Jzb/XgMVZBFQk1j85xgRi8wq4Ssz8fw7MlhBQkJjy8D1YPSdQfNv8t4w
  gtpCAi8Sej0eZIeoFJU7OfMICMV9C4uCLF8wgayUElCRmdsdDjKmQmDWrDWqkmsTVc5uYJzAK
  zkLSPQtJ9wJGplWMZsWpRWWpRbqGlnpJRZnpGSW5iZk5eolVuol6qaW65anFJbpGeonlxXqpx
  cV6xZW5yTkpenmpJZsYgdGSUqy4bgfj9GV/9A4xSnIwKYnyvlrWmSzEl5SfUpmRWJwRX1Sak1
  p8iFGGg0NJgpf1AFBOsCg1PbUiLTMHGLkwaQkOHiUR3vd7gdK8xQWJucWZ6RCpU4yKUuK8uw4
  BJQRAEhmleXBtsGRxiVFWSpiXkYGBQYinILUoN7MEVf4VozgHo5Iwb/U+oCk8mXklcNNfAS1m
  AlocKdYGsrgkESEl1cBU8f26R3/gQ42ZcpdeOc3wZHx78PmmVZ4yxwJy1TyvvZyms/V/6v06v
  fNnd8wLPn1o1dbXbJxXrj2+yc7AceBnIdPp53tsFp3mNLxwwO2U5pujko9b5rxmmX7+RVnkjH
  8zBWp1chM7ig+nMXEdeXiqTO64n+KxfcpzFhUnNUvXeWrWVf+4YS7n2Xjop6Fpdoh7ff5ni4D
  ff279P6y1XXKWaOCkDZ5/nrhcj9/UoMp5quiGlYmbwJKuK/1fZ0rcffAgoFs/PvKs2+932ZfX
  KEqyS/rcWvozkHENp4q+ds3+nNSF0Vc+2ff6J80TP3xj7o+tnA13/7qEXZ7Ufiro9OQs81OzT
  l3y/uDJXnnA1O+jsBJLcUaioRZzUXEiAFCjZoWRAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-9.tower-571.messagelabs.com!1669973160!153515!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 7087 invoked from network); 2 Dec 2022 09:26:00 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-9.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 2 Dec 2022 09:26:00 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 1B5471000D7;
        Fri,  2 Dec 2022 09:26:00 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 0E01B1000D5;
        Fri,  2 Dec 2022 09:26:00 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.42; Fri, 2 Dec 2022 09:25:56 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>, <akpm@linux-foundation.org>
Subject: [PATCH v2.1 3/8] fsdax: zero the edges if source is HOLE or UNWRITTEN
Date:   Fri, 2 Dec 2022 09:25:45 +0000
Message-ID: <1669973145-318-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1669908538-55-4-git-send-email-ruansy.fnst@fujitsu.com>
References: <1669908538-55-4-git-send-email-ruansy.fnst@fujitsu.com>
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
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c | 79 +++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index a77739f2abe7..f12645d6f3c8 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1092,7 +1092,8 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 }
 
 /**
- * dax_iomap_cow_copy - Copy the data from source to destination before write
+ * dax_iomap_copy_around - Prepare for an unaligned write to a shared/cow page
+ * by copying the data before and after the range to be written.
  * @pos:	address to do copy from.
  * @length:	size of copy operation.
  * @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
@@ -1101,35 +1102,50 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
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
@@ -1137,12 +1153,19 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
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
@@ -1241,13 +1264,10 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
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
@@ -1401,8 +1421,8 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		}
 
 		if (cow) {
-			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
-						 kaddr);
+			ret = dax_iomap_copy_around(pos, length, PAGE_SIZE,
+						    srcmap, kaddr);
 			if (ret)
 				break;
 		}
@@ -1547,7 +1567,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		struct xa_state *xas, void **entry, bool pmd)
 {
 	const struct iomap *iomap = &iter->iomap;
-	const struct iomap *srcmap = &iter->srcmap;
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
@@ -1578,9 +1598,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 
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

