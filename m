Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C6D51EE2A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 16:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiEHOky (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 10:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiEHOk1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 10:40:27 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BD70E0BB;
        Sun,  8 May 2022 07:36:36 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3ADdf2Ma0SqF7ICATsW/bD5T9wkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ0TMl0DdVz2QZWGqCb/rea2emeo1wPty2/U4F68DRndA2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfvQH+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfouOffiXg7Zf7I0ruNiGEL+9VJE0/I4wU0uhtBmR?=
 =?us-ascii?q?J7/YZNHYGaRXrr+a3xre6Q+5si+wjMcD0MYJZsXZlpRnZBvYOQJbNWazG6NZUm?=
 =?us-ascii?q?jAqiahmAvfaY9sxaDxhdh3MbhRDfFANB/oWkO6uwHu5bDxcrFOcoLEf4m7PwQg?=
 =?us-ascii?q?327/oWPLZeMONQ8p9nUuCoG/CuWPjDXkyMN2Z1CrA93eEhfHGliC9X5gdfJW+6?=
 =?us-ascii?q?PJrhVi7wm0IFAZQUVq9vOn/hkOgM/pfIEw8/jEy66Q/nGStR97sVlu4p2SFsQM?=
 =?us-ascii?q?XW9t4FeAxrgqKz8L84Q+fCy4PTiNpb8Yvv8s7Azct0zehhdzuATBwobu9Um+G+?=
 =?us-ascii?q?/GYoFuaPSkTMH9HazQIQBUI5/H9r4wpyBHCVNBuFOiylNKdMTXxxS2a6SsznbM?=
 =?us-ascii?q?eieYV2Kihu1PKmTShot7OVAFdzgHWWH+1qxN3f6a7aIGyr1vW9/BNKMCeVFbpl?=
 =?us-ascii?q?GYFgc+2/u0IDI/LkC2LXfVLG6umoeuGWAAwK3YH84IJrmzroiD8O9sLpmwWGau?=
 =?us-ascii?q?gCe5cEReBXaMZkV45CEdvAUaX?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3APmWomq6iKxE9SfrpXAPXwC7XdLJyesId70hD?=
 =?us-ascii?q?6qhwISY1TiX+rbHWoB17726NtN9/YgBCpTntAsa9qDbnhPpICOoqTNGftWvdyQ?=
 =?us-ascii?q?mVxehZhOOIqVCNJ8S9zJ876U4KSchD4bPLY2SS9fyKhTVQDexQvOWvweS5g/vE?=
 =?us-ascii?q?1XdxQUVPY6Fk1Q1wDQGWCSRNNXN7LKt8BJyB/dBGujblXXwWa/6wDn4DU/OGiM?=
 =?us-ascii?q?bMkPvdEGM7Li9i+A+Tlimp9bK/NxCZ2y0VWzRJzaxn0UWtqX2D2pme?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124075743"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 May 2022 22:36:31 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id C35ED4D17199;
        Sun,  8 May 2022 22:36:29 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 8 May 2022 22:36:33 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 8 May 2022 22:36:32 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 8 May 2022 22:36:28 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 02/07] fsdax: Introduce dax_iomap_cow_copy()
Date:   Sun, 8 May 2022 22:36:15 +0800
Message-ID: <20220508143620.1775214-10-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: C35ED4D17199.A1367
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

In the case where the iomap is a write operation and iomap is not equal
to srcmap after iomap_begin, we consider it is a CoW operation.

In this case, the destination (iomap->addr) points to a newly allocated
extent.  It is needed to copy the data from srcmap to the extent.  In
theory, it is better to copy the head and tail ranges which is outside
of the non-aligned area instead of copying the whole aligned range. But
in dax page fault, it will always be an aligned range. So copy the whole
range in this case.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index d4f195aeaa12..a4d56cfa33d0 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1061,6 +1061,60 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
 	return rc;
 }
 
+/**
+ * dax_iomap_cow_copy - Copy the data from source to destination before write
+ * @pos:	address to do copy from.
+ * @length:	size of copy operation.
+ * @align_size:	aligned w.r.t align_size (either PMD_SIZE or PAGE_SIZE)
+ * @srcmap:	iomap srcmap
+ * @daddr:	destination address to copy to.
+ *
+ * This can be called from two places. Either during DAX write fault (page
+ * aligned), to copy the length size data to daddr. Or, while doing normal DAX
+ * write operation, dax_iomap_actor() might call this to do the copy of either
+ * start or end unaligned address. In the latter case the rest of the copy of
+ * aligned ranges is taken care by dax_iomap_actor() itself.
+ */
+static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
+		const struct iomap *srcmap, void *daddr)
+{
+	loff_t head_off = pos & (align_size - 1);
+	size_t size = ALIGN(head_off + length, align_size);
+	loff_t end = pos + length;
+	loff_t pg_end = round_up(end, align_size);
+	bool copy_all = head_off == 0 && end == pg_end;
+	void *saddr = 0;
+	int ret = 0;
+
+	ret = dax_iomap_direct_access(srcmap, pos, size, &saddr, NULL);
+	if (ret)
+		return ret;
+
+	if (copy_all) {
+		ret = copy_mc_to_kernel(daddr, saddr, length);
+		return ret ? -EIO : 0;
+	}
+
+	/* Copy the head part of the range */
+	if (head_off) {
+		ret = copy_mc_to_kernel(daddr, saddr, head_off);
+		if (ret)
+			return -EIO;
+	}
+
+	/* Copy the tail part of the range */
+	if (end < pg_end) {
+		loff_t tail_off = head_off + length;
+		loff_t tail_len = pg_end - end;
+
+		ret = copy_mc_to_kernel(daddr + tail_off, saddr + tail_off,
+					tail_len);
+		if (ret)
+			return -EIO;
+	}
+	return 0;
+}
+
 /*
  * The user has performed a load from a hole in the file.  Allocating a new
  * page in the file would cause excessive storage usage for workloads with
@@ -1231,15 +1285,17 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		struct iov_iter *iter)
 {
 	const struct iomap *iomap = &iomi->iomap;
+	const struct iomap *srcmap = &iomi->srcmap;
 	loff_t length = iomap_length(iomi);
 	loff_t pos = iomi->pos;
 	struct dax_device *dax_dev = iomap->dax_dev;
 	loff_t end = pos + length, done = 0;
+	bool write = iov_iter_rw(iter) == WRITE;
 	ssize_t ret = 0;
 	size_t xfer;
 	int id;
 
-	if (iov_iter_rw(iter) == READ) {
+	if (!write) {
 		end = min(end, i_size_read(iomi->inode));
 		if (pos >= end)
 			return 0;
@@ -1248,7 +1304,12 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			return iov_iter_zero(min(length, end - pos), iter);
 	}
 
-	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED))
+	/*
+	 * In DAX mode, enforce either pure overwrites of written extents, or
+	 * writes to unwritten extents as part of a copy-on-write operation.
+	 */
+	if (WARN_ON_ONCE(iomap->type != IOMAP_MAPPED &&
+			!(iomap->flags & IOMAP_F_SHARED)))
 		return -EIO;
 
 	/*
@@ -1282,13 +1343,21 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 			break;
 		}
 
+		if (write &&
+		    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
+			ret = dax_iomap_cow_copy(pos, length, PAGE_SIZE, srcmap,
+						 kaddr);
+			if (ret)
+				break;
+		}
+
 		map_len = PFN_PHYS(map_len);
 		kaddr += offset;
 		map_len -= offset;
 		if (map_len > end - pos)
 			map_len = end - pos;
 
-		if (iov_iter_rw(iter) == WRITE)
+		if (write)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
@@ -1428,6 +1497,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	const struct iomap *iomap = &iter->iomap;
+	const struct iomap *srcmap = &iter->srcmap;
 	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
@@ -1435,6 +1505,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	int err = 0;
 	pfn_t pfn;
+	void *kaddr;
 
 	if (!pmd && vmf->cow_page)
 		return dax_fault_cow_page(vmf, iter);
@@ -1447,18 +1518,25 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		return dax_pmd_load_hole(xas, vmf, iomap, entry);
 	}
 
-	if (iomap->type != IOMAP_MAPPED) {
+	if (iomap->type != IOMAP_MAPPED && !(iomap->flags & IOMAP_F_SHARED)) {
 		WARN_ON_ONCE(1);
 		return pmd ? VM_FAULT_FALLBACK : VM_FAULT_SIGBUS;
 	}
 
-	err = dax_iomap_direct_access(&iter->iomap, pos, size, NULL, &pfn);
+	err = dax_iomap_direct_access(iomap, pos, size, &kaddr, &pfn);
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
 	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
 				  write && !sync);
 
+	if (write &&
+	    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
+		err = dax_iomap_cow_copy(pos, size, size, srcmap, kaddr);
+		if (err)
+			return dax_fault_return(err);
+	}
+
 	if (sync)
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
-- 
2.35.1



