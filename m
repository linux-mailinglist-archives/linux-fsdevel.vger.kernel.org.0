Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DC3637C1B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 15:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiKXOz1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 09:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiKXOzY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 09:55:24 -0500
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6858C4FF90;
        Thu, 24 Nov 2022 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1669301714; i=@fujitsu.com;
        bh=3T9uGpsASmdBkY7W42A/ghwEUFf5vfjUCyinuqSM0lU=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=RAnuRMFldieYzxpDCXKS/MqeM0w99C4XPz54PaCCYPZEVNZwj8tSwSLu/UJdllhC1
         moKLwduqza8/rzHO2UkVcI7LVoHD1rUpXUEuu+pNIpwusk/KyeDCprQ+0NMSI0mUGi
         A6EXSfpG1axCswTjkzZUcCmi2CENRewS5k898RWQfj6IKtLcwp+aWHBax72b05N8gJ
         E7Cbpuswa/TbrjLtmlC1vApbEoZpD7Znq2MlfYzShKYkoo8KD3XPgsjpCI68iHGp6H
         hLO6mpkuIc0CTwwOgdnPzLvE/t5YQx1Kw35nEobFAM4HE0nCFHmrHCSRe0oqgAWmQT
         H9jOXRNV8HHDQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphleJIrShJLcpLzFFi42Kxs+GYpHuptT7
  ZYEOXsMX0qRcYLbYcu8docfkJn8WevSdZLC7vmsNmsevPDnaLlT/+sDqwe5xaJOGxeM9LJo9N
  qzrZPF5snsno8XmTXABrFGtmXlJ+RQJrxr3jp9gL5vpV/P7xhLGBcYd9FyMXh5DAFkaJSU0T2
  SGc5UwSsz6sZoFw9jJKHHn3jqmLkZODTUBH4sKCv6xdjBwcIgLVEreWsoGEmQW8JNa+3sAMYg
  sLBEn8aF3NBlLCIqAqsWmFL0iYV8BF4k7PLbByCQEFiSkP34OVcwq4Suxues4MUi4EVNP3yxa
  iXFDi5MwnLBDTJSQOvngBViIhoCQxszseYkqFxKxZbUwQtprE1XObmCcwCs5C0j0LSfcCRqZV
  jGbFqUVlqUW6hkZ6SUWZ6RkluYmZOXqJVbqJeqmluuWpxSW6RnqJ5cV6qcXFesWVuck5KXp5q
  SWbGIFRkVKs1LyD8e+yP3qHGCU5mJREeW/l1CcL8SXlp1RmJBZnxBeV5qQWH2KU4eBQkuD1qA
  fKCRalpqdWpGXmACMUJi3BwaMkwuteDpTmLS5IzC3OTIdInWI05ljbcGAvM8ekP9f2Mgux5OX
  npUqJ8wa1AJUKgJRmlObBDYIljkuMslLCvIwMDAxCPAWpRbmZJajyrxjFORiVhHklgGlIiCcz
  rwRu3yugU5iATnmqUwdySkkiQkqqgclO92AvZyO3lMMqhW8FLQycn20e3Wm8e5dl8V2DCYFmU
  cwaDJwephekY0TP+Xz5VrAj7dkV7btTuUWP1wdIOc2Z1rfJ5dKPwA/c8vdbJRR93H6d+MEUYu
  NV9uhlYVCkyq/bXqXxX+5vkLMPdZ/Dam6qvKfijvqU4qoJySeem19RaxWMZT3KGmNpyy62tvH
  8GibBlSlTZ1oWP7rb8uTrTeHH5TriWw7d8px107fXZ/XUhW8/vy1a0TZX3W+K5vtcJd/9VxKb
  Fx7MY/IXPRGaa3M4Mnjvjyd71qx8wpXId/xoqDKjkutka+nL3dXiISpvN/39OnnKbpmyrSfCn
  8rfatt+tk1OY/OKrRVcsoc425VYijMSDbWYi4oTAQlCEb2XAwAA
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-11.tower-565.messagelabs.com!1669301714!78710!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.101.1; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30195 invoked from network); 24 Nov 2022 14:55:14 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-11.tower-565.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 24 Nov 2022 14:55:14 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id F3EFC1000D2;
        Thu, 24 Nov 2022 14:55:13 +0000 (GMT)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id E677B1000D5;
        Thu, 24 Nov 2022 14:55:13 +0000 (GMT)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 24 Nov 2022 14:55:10 +0000
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <david@fromorbit.com>,
        <dan.j.williams@intel.com>
Subject: [PATCH 1/2] fsdax,xfs: fix warning messages at dax_[dis]associate_entry()
Date:   Thu, 24 Nov 2022 14:54:53 +0000
Message-ID: <1669301694-16-2-git-send-email-ruansy.fnst@fujitsu.com>
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

This patch fixes the warning message reported in dax_associate_entry()
and dax_disassociate_entry().
1. reset page->mapping and ->index when refcount counting down to 0.
2. set IOMAP_F_SHARED flag when iomap read to allow one dax page to be
associated more than once for not only write but also read.
3. should zero the edge (when not aligned) if srcmap is HOLE or
UNWRITTEN.
4. iterator of two files in dedupe should be executed side by side, not
nested.
5. use xfs_dax_write_iomap_ops for xfs zero and truncate. 

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 fs/dax.c           | 114 ++++++++++++++++++++++++++-------------------
 fs/xfs/xfs_iomap.c |   6 +--
 2 files changed, 69 insertions(+), 51 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 1c6867810cbd..5ea7c0926b7f 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -398,7 +398,7 @@ static void dax_disassociate_entry(void *entry, struct address_space *mapping,
 		WARN_ON_ONCE(trunc && page_ref_count(page) > 1);
 		if (dax_mapping_is_cow(page->mapping)) {
 			/* keep the CoW flag if this page is still shared */
-			if (page->index-- > 0)
+			if (page->index-- > 1)
 				continue;
 		} else
 			WARN_ON_ONCE(page->mapping && page->mapping != mapping);
@@ -840,12 +840,6 @@ static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
 		(iter->iomap.flags & IOMAP_F_DIRTY);
 }
 
-static bool dax_fault_is_cow(const struct iomap_iter *iter)
-{
-	return (iter->flags & IOMAP_WRITE) &&
-		(iter->iomap.flags & IOMAP_F_SHARED);
-}
-
 /*
  * By this point grab_mapping_entry() has ensured that we have a locked entry
  * of the appropriate size so we don't have to worry about downgrading PMDs to
@@ -859,13 +853,14 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	void *new_entry = dax_make_entry(pfn, flags);
-	bool dirty = !dax_fault_is_synchronous(iter, vmf->vma);
-	bool cow = dax_fault_is_cow(iter);
+	bool write = iter->flags & IOMAP_WRITE;
+	bool dirty = write && !dax_fault_is_synchronous(iter, vmf->vma);
+	bool shared = iter->iomap.flags & IOMAP_F_SHARED;
 
 	if (dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 
-	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
+	if (shared || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
 		unsigned long index = xas->xa_index;
 		/* we are replacing a zero page with block mapping */
 		if (dax_is_pmd_entry(entry))
@@ -877,12 +872,12 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (shared || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
 		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				cow);
+				shared);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -902,7 +897,7 @@ static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
 
-	if (cow)
+	if (write && shared)
 		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
 
 	xas_unlock_irq(xas);
@@ -1107,23 +1102,35 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
 	loff_t end = pos + length;
 	loff_t pg_end = round_up(end, align_size);
 	bool copy_all = head_off == 0 && end == pg_end;
+	/* write zero at edge if srcmap is a HOLE or IOMAP_UNWRITTEN */
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
@@ -1131,12 +1138,19 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
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
@@ -1235,13 +1249,9 @@ static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
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
+		ret = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap, kaddr);
+	else
 		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	return ret;
 }
@@ -1258,6 +1268,15 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
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
@@ -1318,12 +1337,13 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
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
@@ -1350,7 +1370,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 	 * into page tables. We have to tear down these mappings so that data
 	 * written by write(2) is visible in mmap.
 	 */
-	if (iomap->flags & IOMAP_F_NEW) {
+	if (iomap->flags & IOMAP_F_NEW || cow) {
 		invalidate_inode_pages2_range(iomi->inode->i_mapping,
 					      pos >> PAGE_SHIFT,
 					      (end - 1) >> PAGE_SHIFT);
@@ -1384,8 +1404,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			break;
 		}
 
-		if (write &&
-		    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
+		if (cow) {
 			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
 						 kaddr);
 			if (ret)
@@ -1532,7 +1551,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		struct xa_state *xas, void **entry, bool pmd)
 {
 	const struct iomap *iomap = &iter->iomap;
-	const struct iomap *srcmap = &iter->srcmap;
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
 	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = iter->flags & IOMAP_WRITE;
@@ -1563,8 +1582,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 
 	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
 
-	if (write &&
-	    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
+	if (write && iomap->flags & IOMAP_F_SHARED) {
 		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
 		if (err)
 			return dax_fault_return(err);
@@ -1936,15 +1954,15 @@ int dax_dedupe_file_range_compare(struct inode *src, loff_t srcoff,
 		.len		= len,
 		.flags		= IOMAP_DAX,
 	};
-	int ret;
+	int ret, compared = 0;
 
-	while ((ret = iomap_iter(&src_iter, ops)) > 0) {
-		while ((ret = iomap_iter(&dst_iter, ops)) > 0) {
-			dst_iter.processed = dax_range_compare_iter(&src_iter,
-						&dst_iter, len, same);
-		}
-		if (ret <= 0)
-			src_iter.processed = ret;
+	while ((ret = iomap_iter(&src_iter, ops)) > 0 &&
+	       (ret = iomap_iter(&dst_iter, ops)) > 0) {
+		compared = dax_range_compare_iter(&src_iter, &dst_iter, len,
+						  same);
+		if (compared < 0)
+			return ret;
+		src_iter.processed = dst_iter.processed = compared;
 	}
 	return ret;
 }
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 07da03976ec1..d9401d0300ad 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1215,7 +1215,7 @@ xfs_read_iomap_begin(
 		return error;
 	error = xfs_bmapi_read(ip, offset_fsb, end_fsb - offset_fsb, &imap,
 			       &nimaps, 0);
-	if (!error && (flags & IOMAP_REPORT))
+	if (!error && ((flags & IOMAP_REPORT) || IS_DAX(inode)))
 		error = xfs_reflink_trim_around_shared(ip, &imap, &shared);
 	xfs_iunlock(ip, lockmode);
 
@@ -1370,7 +1370,7 @@ xfs_zero_range(
 
 	if (IS_DAX(inode))
 		return dax_zero_range(inode, pos, len, did_zero,
-				      &xfs_direct_write_iomap_ops);
+				      &xfs_dax_write_iomap_ops);
 	return iomap_zero_range(inode, pos, len, did_zero,
 				&xfs_buffered_write_iomap_ops);
 }
@@ -1385,7 +1385,7 @@ xfs_truncate_page(
 
 	if (IS_DAX(inode))
 		return dax_truncate_page(inode, pos, did_zero,
-					&xfs_direct_write_iomap_ops);
+					&xfs_dax_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, did_zero,
 				   &xfs_buffered_write_iomap_ops);
 }
-- 
2.38.1

