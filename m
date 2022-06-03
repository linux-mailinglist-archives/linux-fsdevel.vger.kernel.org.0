Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD4E53C46E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 07:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241117AbiFCFiS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 01:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241010AbiFCFiB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:38:01 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A58139147;
        Thu,  2 Jun 2022 22:37:56 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AXmwI2a8LauXx4momrUoVDrUDK3+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUom1DMOmmQeWTuBaaqKYTagLtkgPNizox8CvJWDn9ViG1dlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OadfSbv75zLniUqdFOpmZ2CFnoeMYQG++pfD3t?=
 =?us-ascii?q?J8PsCIjERKBuEgoqexLO9T+hlgcQuBMn2NZwSuzdryjSxJfYtQbjCRavQ7NNV1?=
 =?us-ascii?q?Tt2gdpBdd7BZs4deBJuahraahFCM1tRD4gx9M+kj3+5cXtHqVaRpKMy+EDSyhB?=
 =?us-ascii?q?81P7mN9+9UtCIWsJTkW6bq3jA8mC/BQsVXPSbyDyY4jepg8fMgyrwW8QVDrLQ3?=
 =?us-ascii?q?vdpmFi7wm0VFQ1TW1ymp/Wwlk+5XZRYMUN80jAvsaUp9EyDStj7Qg3+oXSB+BU?=
 =?us-ascii?q?bXrJ4FfM26QSI4q7V+BqCQGwFSCNRLtArqqceRTcq/luSg5XlCFRHtrSSWHvb9?=
 =?us-ascii?q?rCOrDyvMigUBWkPbmkPSg5ty9vqpox1hRLSZtF5GaWxg5v+HjSY6yqFqywymKQ?=
 =?us-ascii?q?VpdUWzKj99lfC6xq2qZ/NQhEk4C3MQ3moqA90DKahZoq1+R3V9vpNMoudZkeOs?=
 =?us-ascii?q?WJCmMWE6u0KS5aXm0SlROQLAaHs5PufNjDYqUBgEoNn9Dm3/XOnO4dK71lWIEZ?=
 =?us-ascii?q?vL9ZBaTHySFHctBkX55JJOnauK6htbOqZFcUwyoDyGNLkSLbQb9xTct52bgDB4?=
 =?us-ascii?q?SIGWKI69wgBi2B1yedmZ8jdKp3qUB4n5W1c5GLeb48gPXUDm0jSHV/ueK0=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AjvaPkqsJm0PfogiERfIxmcwe7skDktV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxra6TdZMgpHnJYVcqKQgdcL+7WJVoLUmxyXcx2/h1AV7AZniAhI?=
 =?us-ascii?q?LLFvAA0WKK+VSJcEeSygce79YFT0EUMrzN5DZB4voSmDPIcerI3uP3jZyAtKPP?=
 =?us-ascii?q?yWt3VwF2Z+VF5wd9MAySFUp7X2B9dOEEPavZ9sxavCChZHhSSsy6A0MOV+/Fq8?=
 =?us-ascii?q?aOu4nhZXc9dmQawTjLnTW186T7DhTd+h8fVglEybAk/XOAsyGR3NTaj82G?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124686809"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2022 13:37:51 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8F22C4D1719E;
        Fri,  3 Jun 2022 13:37:49 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:50 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Jun 2022 13:37:49 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <akpm@linux-foundation.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v2 10/14] fsdax: Replace mmap entry in case of CoW
Date:   Fri, 3 Jun 2022 13:37:34 +0800
Message-ID: <20220603053738.1218681-11-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8F22C4D1719E.A405C
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
 fs/dax.c | 77 ++++++++++++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 35 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 3fe8e3714327..f69e937f6496 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -829,6 +829,23 @@ static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter
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
@@ -836,16 +853,19 @@ static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter
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
@@ -857,12 +877,12 @@ static void *dax_insert_entry(struct xa_state *xas,
 
 	xas_reset(xas);
 	xas_lock_irq(xas);
-	if (dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
+	if (cow || dax_is_zero_entry(entry) || dax_is_empty_entry(entry)) {
 		void *old;
 
 		dax_disassociate_entry(entry, mapping, false);
 		dax_associate_entry(new_entry, mapping, vmf->vma, vmf->address,
-				false);
+				cow);
 		/*
 		 * Only swap our new entry into the page cache if the current
 		 * entry is a zero page or an empty entry.  If a normal PTE or
@@ -882,6 +902,9 @@ static void *dax_insert_entry(struct xa_state *xas,
 	if (dirty)
 		xas_set_mark(xas, PAGECACHE_TAG_DIRTY);
 
+	if (cow)
+		xas_set_mark(xas, PAGECACHE_TAG_TOWRITE);
+
 	xas_unlock_irq(xas);
 	return entry;
 }
@@ -1123,17 +1146,15 @@ static int dax_iomap_cow_copy(loff_t pos, uint64_t length, size_t align_size,
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
@@ -1142,7 +1163,7 @@ static vm_fault_t dax_load_hole(struct xa_state *xas,
 
 #ifdef CONFIG_FS_DAX_PMD
 static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap *iomap, void **entry)
+		const struct iomap_iter *iter, void **entry)
 {
 	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
 	unsigned long pmd_addr = vmf->address & PMD_MASK;
@@ -1160,8 +1181,8 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 		goto fallback;
 
 	pfn = page_to_pfn_t(zero_page);
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn,
-			DAX_PMD | DAX_ZERO_PAGE, false);
+	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn,
+				  DAX_PMD | DAX_ZERO_PAGE);
 
 	if (arch_needs_pgtable_deposit()) {
 		pgtable = pte_alloc_one(vma->vm_mm);
@@ -1194,7 +1215,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #else
 static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
-		const struct iomap *iomap, void **entry)
+		const struct iomap_iter *iter, void **entry)
 {
 	return VM_FAULT_FALLBACK;
 }
@@ -1439,17 +1460,6 @@ static vm_fault_t dax_fault_return(int error)
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
@@ -1507,13 +1517,11 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
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
@@ -1526,8 +1534,8 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (!write &&
 	    (iomap->type == IOMAP_UNWRITTEN || iomap->type == IOMAP_HOLE)) {
 		if (!pmd)
-			return dax_load_hole(xas, mapping, entry, vmf);
-		return dax_pmd_load_hole(xas, vmf, iomap, entry);
+			return dax_load_hole(xas, vmf, iter, entry);
+		return dax_pmd_load_hole(xas, vmf, iter, entry);
 	}
 
 	if (iomap->type != IOMAP_MAPPED && !(iomap->flags & IOMAP_F_SHARED)) {
@@ -1539,8 +1547,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 	if (err)
 		return pmd ? VM_FAULT_FALLBACK : dax_fault_return(err);
 
-	*entry = dax_insert_entry(xas, mapping, vmf, *entry, pfn, entry_flags,
-				  write && !sync);
+	*entry = dax_insert_entry(xas, vmf, iter, *entry, pfn, entry_flags);
 
 	if (write &&
 	    srcmap->type != IOMAP_HOLE && srcmap->addr != iomap->addr) {
@@ -1549,7 +1556,7 @@ static vm_fault_t dax_fault_iter(struct vm_fault *vmf,
 			return dax_fault_return(err);
 	}
 
-	if (sync)
+	if (dax_fault_is_synchronous(iter, vmf->vma))
 		return dax_fault_synchronous_pfnp(pfnp, pfn);
 
 	/* insert PMD pfn */
-- 
2.36.1



