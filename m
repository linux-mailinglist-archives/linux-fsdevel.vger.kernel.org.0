Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278B941A8CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 08:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbhI1GZV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 02:25:21 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6261 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239035AbhI1GZU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:25:20 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AS+uVnK0lcU2MakKAQPbD5f5wkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ0mgihGFWzWoaUW7UM/mPZDDxKdAgaI+w8xgPupDXnIc2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM+39BDpC79SMljfDSFuKlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoeKfcCbu7pH7I0ruNiGEL+9VJE0/I4wU0uhtBmR?=
 =?us-ascii?q?J7/YZNHYGaRXrr/23xLaqYuhqiN4qIMTiMMUYoH4I5T3QC7AkB4/CR6HL7NpD9?=
 =?us-ascii?q?DY2ms1KW/3ZYqIxZThwaxLPSx5CIFEaDNQ5hujArmP+bzBDqFK9oasx/niVzQZ?=
 =?us-ascii?q?0lrPqNbL9fMKGRMBQtkKZvX7duWD4BAwKctCS11Kt8nmsruvUgWX3Veo6DrK/8?=
 =?us-ascii?q?vJ1kVu73XEIBVsdUl7TieO2jUqyRMNZA1cJ4SdooaVa3EiqSMTtGhOjrHOasxo?=
 =?us-ascii?q?0RdVdCas55RuLx66S5ByWbkAATzhceJkludUwSDgCyFCEhZXqCCZpvbnTTmiSn?=
 =?us-ascii?q?p+QrDWvKW0FI3QqeyAJV00G7sPlrYV1iQjAJv59EbSyps/4HzDuhTSLqjUuwbI?=
 =?us-ascii?q?JgogW1M2GEfrv6963jsGRCFdruUOMBST4hj6VrbWNP+SAgWU3J94eRGpBcmS8g?=
 =?us-ascii?q?Q=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A7je93qi5y8ga9r9qgFALJh4RcXBQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.85,328,1624291200"; 
   d="scan'208";a="115096975"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Sep 2021 14:23:39 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 224794D0DC7E;
        Tue, 28 Sep 2021 14:23:37 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Sep 2021 14:23:26 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Sep 2021 14:23:24 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <dan.j.williams@intel.com>, <djwong@kernel.org>, <hch@lst.de>,
        <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v10 3/8] fsdax: Replace mmap entry in case of CoW
Date:   Tue, 28 Sep 2021 14:23:06 +0800
Message-ID: <20210928062311.4012070-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
References: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 224794D0DC7E.AFAC5
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace the existing entry to the newly allocated one in case of CoW.
Also, we mark the entry as PAGECACHE_TAG_TOWRITE so writeback marks this
entry as writeprotected.  This helps us snapshots so new write
pagefaults after snapshots trigger a CoW.

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c | 75 +++++++++++++++++++++++++++++++-------------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index dded08be54dc..b437badfe0dd 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -734,6 +734,23 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
 	return 0;
 }
 
+/*
+ * MAP_SYNC on a dax mapping guarantees dirty metadata is
+ * flushed on write-faults (non-cow), but not read-faults.
+ */
+static bool dax_fault_is_synchronous(const struct iomap_iter *iter,
+		struct vm_area_struct *vma)
+{
+	return (iter->flags & IOMAP_WRITE) && (vma->vm_flags & VM_SYNC) &&
+		(iter->iomap.flags & IOMAP_F_DIRTY);
+}
+
+static bool dax_fault_is_cow(const struct iomap_iter *iter)
+{
+	return (iter->flags & IOMAP_WRITE) &&
+		(iter->iomap.flags & IOMAP_F_SHARED);
+}
+
 /*
  * By this point grab_mapping_entry() has ensured that we have a locked entry
  * of the appropriate size so we don't have to worry about downgrading PMDs to
@@ -741,16 +758,19 @@ static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_d
  * already in the tree, we will skip the insertion and just dirty the PMD as
  * appropriate.
  */
-static void *dax_insert_entry(struct xa_state *xas,
-		struct address_space *mapping, struct vm_fault *vmf,
-		void *entry, pfn_t pfn, unsigned long flags, bool dirty)
+static void *dax_insert_entry(struct xa_state *xas, struct vm_fault *vmf,
+		const struct iomap_iter *iter, void *entry, pfn_t pfn,
+		unsigned long flags)
 {
+	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	void *new_entry = dax_make_entry(pfn, flags);
+	bool dirty = !dax_fault_is_synchronous(iter, vmf->vma);
+	bool cow = dax_fault_is_cow(iter);
 
 	if (dirty)
 		__mark_inode_dirty(mapping->host, I_DIRTY_PAGES);
 
-	if (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE)) {
+	if (cow || (dax_is_zero_entry(entry) && !(flags & DAX_ZERO_PAGE))) {
 		unsigned long index = xas->xa_index;
 		/* we are replacing a zero page with block mapping */
 		if (dax_is_pmd_entry(entry))
@@ -762,7 +782,7 @@ static void *dax_insert_entry(struct xa_state *xas,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
@@ -786,6 +806,9 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
 
+	if (cow)
+		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
+
 	xas_unlock_irq(xas);
 	return entry;
 }
@@ -1111,17 +1134,15 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
  * If this page is ever written to we will re-fault and change the mapping to
  * point to real DAX storage instead.
  */
-static vm_fault_t dax_load_hole(struct xa_state *xas,
-		struct address_space *mapping, void **entry,
-		struct vm_fault *vmf)
+static vm_fault_t dax_load_hole(struct xa_state *xas, struct vm_fault *vmf,
+		const struct iomap_iter *iter, void **entry)
 {
-	struct inode *inode = mapping->host;
+	struct inode *inode = iter->inode;
 	unsigned long vaddr = vmf->address;
 	pfn_t pfn = pfn_to_pfn_t(my_zero_pfn(vaddr));
 	vm_fault_t ret;
 
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_ZERO_PAGE, false);
+	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, DAX_ZERO_PAGE);
 
 	ret = vmf_insert_mixed(vmf->vma, vaddr, pfn);
 	trace_dax_load_hole(inode, vmf, ret);
@@ -1130,7 +1151,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 
 #ifdef CONFIG_FS_DAX_PMD
 static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap *iomap, void **entry)
+		const struct iomap_iter *iter, void **entry)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
@@ -1148,8 +1169,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		goto fallback;
 
 	pfn = page_to_pfn_t(zero_page);
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_PMD | DAX_ZERO_PAGE, false);
+	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
+				  DAX_PMD | DAX_ZERO_PAGE);
 
 	if (arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(vma->vm_mm);
@@ -1182,7 +1203,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #else
 static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap *iomap, void **entry)
+		const struct iomap_iter *iter, void **entry)
 {
 	return VM_FAULT_FALLBACK;
 }
@@ -1381,17 +1402,6 @@ static vm_fault_t dax_fault_return(int error)
 	return vmf_error(error);
 }
 
-/*
- * MAP_SYNC on a dax mapping guarantees dirty metadata is
- * flushed on write-faults (non-cow), but not read-faults.
- */
-static bool dax_fault_is_synchronous(unsigned long flags,
-		struct vm_area_struct *vma, const struct iomap *iomap)
-{
-	return (flags & IOMAP_WRITE) && (vma->vm_flags & VM_SYNC)
-		&& (iomap->flags & IOMAP_F_DIRTY);
-}
-
 /*
  * When handling a synchronous page fault and the inode need a fsync, we can
  * insert the PTE/PMD into page tables only after that fsync happened. Skip
@@ -1452,13 +1462,11 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 		const struct iomap_iter *iter, pfn_t *pfnp,
 		struct xa_state *xas, void **entry, bool pmd)
 {
-	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	const struct iomap *iomap = &iter->iomap;
 	const struct iomap *srcmap = &iter->srcmap;
 	size_t size = pmd ? PMD_SIZE : PAGE_SIZE;
 	loff_t pos = (loff_t)xas->xa_index << PAGE_SHIFT;
-	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	bool sync = dax_fault_is_synchronous(iter->flags, vmf->vma, iomap);
+	bool write = iter->flags & IOMAP_WRITE;
 	unsigned long entry_flags = pmd ? DAX_PMD : 0;
 	int err = 0;
 	pfn_t pfn;
@@ -1471,8 +1479,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (!write &&
 	    (iomap->type == IOMAP_UNWRITTEN || iomap->type == IOMAP_HOLE)) {
 		if (!pmd)
-			return dax_load_hole(xas, mapping, entry, vmf);
-		return dax_pmd_load_hole(xas, vmf, iomap, entry);
+			return dax_load_hole(xas, vmf, iter, entry);
+		return dax_pmd_load_hole(xas, vmf, iter, entry);
 	}
 
 	if (iomap->type != IOMAP_MAPPED && !(iomap->flags & IOMAP_F_SHARED)) {
@@ -1484,8 +1492,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
-				  write && !sync);
+	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
 
 	if (write &&
 	    srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
@@ -1494,7 +1501,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 			return dax_fault_return(err);
 	}
 
-	if (sync)
+	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
 	/* insert PMD pfn */
-- 
2.33.0



