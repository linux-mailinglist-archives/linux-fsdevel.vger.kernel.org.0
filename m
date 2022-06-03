Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDEE53C485
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 07:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241045AbiFCFiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 01:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240944AbiFCFhy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:37:54 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C84E72873A;
        Thu,  2 Jun 2022 22:37:52 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AxAJAc6qDwCybjpSifeVcI9sSMhxeBmKZZBIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vmQfUDvTPanYYjejKdxxbYXk/B8O7MODn4BgQVBprigxQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SkUOZ2gHOKmUra?=
 =?us-ascii?q?eYnkpHGeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JbPkR2YIyOxqxlpJARsVWECwc57CH9?=
 =?us-ascii?q?P+dQWMjcIaQqJhv7wy7W+IsFoh8ImLcDsPI43umxp0jzYS/0hRPjrQ67Kzd5e0?=
 =?us-ascii?q?i05is1HEbDZfcVxQSVuaBDRSxxJNE0eBJ83kKGvnHaXWzFRrhSX47U252zSxQl?=
 =?us-ascii?q?q+LnrLNfRPNeNQK19kkSHoWTJ12f0GBcXMJqY0zXt2natgPLf2Cb+cIEMHba7s?=
 =?us-ascii?q?PlwjzW7z28LDTUSVF2msby3jVO4V9tDKksSvC00osAa8lKnT9z4dxm5u2Kf+Bo?=
 =?us-ascii?q?dXcdAVeE39mmlyqHUywKCGi4IQ1ZpbtUhpcZwRTsw11CUlNPoLTpiu/ueTnf13?=
 =?us-ascii?q?rWdqz70MigIBWgYbCQAQE0O5NyLiJs8iRbDUcdlOLWoldCzFTyY6zSLqjUuwrs?=
 =?us-ascii?q?IgcMV2qGT41/KmXSvq4LPQwpz4R/YNkqh7wVkdMumapau5Fzz8/lNNsCaQ0OHs?=
 =?us-ascii?q?XxCnNKRhMgKDJeQhGmdTv4lAr6k/bCGPSfajFopGIMunxyz+mSkVZJd5jBgYkN?=
 =?us-ascii?q?oNNsUPzjzbwnOumtsCDV7VJexRfYvJdvvVIJxlu69fekJn8v8NrJmCqWdvifdl?=
 =?us-ascii?q?M22WXOt4g=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A6J/ooq8/ch8crXIl3Jduk+DkI+orL9Y04lQ7?=
 =?us-ascii?q?vn2ZKCYlFvBw8vrCoB1173HJYUkqMk3I9ergBEDiewK4yXcW2/hzAV7KZmCP11?=
 =?us-ascii?q?dAR7sSj7cKrQeBJwTOssZZ1YpFN5N1EcDMCzFB5vrS0U2VFMkBzbC8nJyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124686805"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2022 13:37:51 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 9CB864D1719C;
        Fri,  3 Jun 2022 13:37:48 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:49 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Jun 2022 13:37:48 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <akpm@linux-foundation.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 09/14] fsdax: Introduce dax_iomap_cow_copy()
Date:   Fri, 3 Jun 2022 13:37:33 +0800
Message-ID: <20220603053738.1218681-10-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 9CB864D1719C.A2761
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
index ab659c9f142a..3fe8e3714327 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1062,6 +1062,60 @@ static int dax_iomap_direct_access(const struct iomap *iomap, loff_t pos,
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
@@ -1232,15 +1286,17 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
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
@@ -1249,7 +1305,12 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
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
@@ -1291,6 +1352,14 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
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
@@ -1300,7 +1369,7 @@ static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
 		if (recovery)
 			xfer = dax_recovery_write(dax_dev, pgoff, kaddr,
 					map_len, iter);
-		else if (iov_iter_rw(iter) == WRITE)
+		else if (write)
 			xfer = dax_copy_from_iter(dax_dev, pgoff, kaddr,
 					map_len, iter);
 		else
@@ -1440,6 +1509,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	const struct iomap *iomap = &iter->iomap;
+	const struct iomap *srcmap = &iter->srcmap;
 	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
@@ -1447,6 +1517,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	int err = 0;
 	pfn_t pfn;
+	void *kaddr;
 
 	if (!pmd && vmf->cow_page)
 		return dax_fault_cow_page(vmf, iter);
@@ -1459,18 +1530,25 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
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
2.36.1



