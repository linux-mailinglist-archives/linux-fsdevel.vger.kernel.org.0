Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC26CCF6B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 03:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjC2BRq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 21:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjC2BRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:17:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8DF269A;
        Tue, 28 Mar 2023 18:17:38 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A4385C004E;
        Tue, 28 Mar 2023 21:17:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 Mar 2023 21:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680052658; x=1680139058; bh=aksTP0wsXOFiVzEDaAS1LD1g3uMK0049FZH
        tL5zgUuw=; b=Dcx3mJCj4o/cBPXDOYcGgRdRyQ22nxQrHFPcYotx3tHmmsZNLsv
        pc0x43YARWo7R8Tqa3EaIKAbKNE+0dRgqNWVcRVoy+0PxoLEQQaiOB/l5qyeDT9J
        3PLItl508JNOwnt22szn4kU16TwEaDvKiGzEZOoMmHoaRFAXcwzDPdE5PvI/I4c7
        lFh6WtsgPKLc0qmP5EvR/8VAwNrseIoXBxH4mctVa/vYd+N8MdVV8dqdCag8THBV
        ambmpdoNRVsvS5ewLMZefNnrjQfD4U4bA6yt7Kj8na9oZv2T+TnlIQHFp532+HK8
        JK/6U/GLNSaKw114/Wktuy06Ml4goA2jpUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680052658; x=1680139058; bh=aksTP0wsXOFiVzEDaAS1LD1g3uMK0049FZH
        tL5zgUuw=; b=FQWPDPtJoRCHisa6cyVyXovcOgzDabdSzVHuAQpVaoZ8GhDerNv
        WaAwl7o6sgJXyQt4BquNq3jju6RIzlxOaS5CpNynUu53oH1/HCDhKQtsa48WmSv9
        N1QKxGvk4JX0DQzrYbQ8+kLu/rp7kpH+JBuA9kcdZIqeD61GN5NplJbRcuRDib8R
        Y1KpgpsJ4mRy7T8NkvgtT+pFOgnYsK6Gh6l19k5Nfx1jbVt5BVOi/IkcPMuszTeD
        xeHGZ/TuxVdVK8thoUEV/hdIPJ/cwTnMeuILSYET0xmwXEBq31CJP23zYEZJlYN5
        ZbG+sRbM4hJetbu2u+ebpQkqGYdib4LM8mQ==
X-ME-Sender: <xms:spEjZJv9spavZQ8U9dTWragTyXgmF0vBHYk4i3kNyNnzTQkXOBCL5g>
    <xme:spEjZCdZ6Xa74DZKKqO7bBkTf-fT2XYmLKS8lXmEUi81IppsocgRkeQVqUbA0TPvL
    9HOj_fO_ZWYLgEAWA>
X-ME-Received: <xmr:spEjZMxXyED1Dq-eX5tyV-ZCtlvenxBCN2hRNdVSl3STDfgZorBQa6YXj1eO8WagpEZ5rSnOYRdaeZmPO-DPQx2djCQinx8h-wZoMe18JSyk6sA4f7YaC-k-Z7mcgoc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehhedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:spEjZAMWIrH3TGKJjVnaOK9nC9mWbJxM-K6KfgS3vTDokickBSPTuQ>
    <xmx:spEjZJ_VUSzsMRziK5tbL-HzYgNEofeNQ01eUfdM1zLSTSmOEoKRWg>
    <xmx:spEjZAVrP7ZgTxKWFFTQLnJ_LUwMFZ_NiFgN2MId0ejBktOuutwl6g>
    <xmx:spEjZHcFw_Ztv-qHD_S1fycRx60WfzyTLGSv1ZuQYRo8gL0HWCZzjw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Mar 2023 21:17:37 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Zach O'Keefe" <zokeefe@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 5/7] mm: thp: split huge page to any lower order pages.
Date:   Tue, 28 Mar 2023 21:17:10 -0400
Message-Id: <20230329011712.3242298-6-zi.yan@sent.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329011712.3242298-1-zi.yan@sent.com>
References: <20230329011712.3242298-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Zi Yan <ziy@nvidia.com>

To split a THP to any lower order pages, we need to reform THPs on
subpages at given order and add page refcount based on the new page
order. Also we need to reinitialize page_deferred_list after removing
the page from the split_queue, otherwise a subsequent split will see
list corruption when checking the page_deferred_list again.

It has many uses, like minimizing the number of pages after
truncating a huge pagecache page. For anonymous THPs, we can only split
them to order-0 like before until we add support for any size anonymous
THPs.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/huge_mm.h |  10 ++--
 mm/huge_memory.c        | 102 +++++++++++++++++++++++++++++-----------
 2 files changed, 81 insertions(+), 31 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 20284387b841..32c91e1b59cd 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -147,10 +147,11 @@ void prep_transhuge_page(struct page *page);
 void free_transhuge_page(struct page *page);
=20
 bool can_split_folio(struct folio *folio, int *pextra_pins);
-int split_huge_page_to_list(struct page *page, struct list_head *list);
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *=
list,
+		unsigned int new_order);
 static inline int split_huge_page(struct page *page)
 {
-	return split_huge_page_to_list(page, NULL);
+	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
 void deferred_split_folio(struct folio *folio);
=20
@@ -297,7 +298,8 @@ can_split_folio(struct folio *folio, int *pextra_pins)
 	return false;
 }
 static inline int
-split_huge_page_to_list(struct page *page, struct list_head *list)
+split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
+		unsigned int new_order)
 {
 	return 0;
 }
@@ -397,7 +399,7 @@ static inline bool thp_migration_supported(void)
 static inline int split_folio_to_list(struct folio *folio,
 		struct list_head *list)
 {
-	return split_huge_page_to_list(&folio->page, list);
+	return split_huge_page_to_list_to_order(&folio->page, list, 0);
 }
=20
 static inline int split_folio(struct folio *folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f8a8a72b207d..619d25278340 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2359,11 +2359,13 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
=20
 static void unmap_folio(struct folio *folio)
 {
-	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD |
-		TTU_SYNC;
+	enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SYNC;
=20
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
=20
+	if (folio_test_pmd_mappable(folio))
+		ttu_flags |=3D TTU_SPLIT_HUGE_PMD;
+
 	/*
 	 * Anon pages need migration entries to preserve them, but file
 	 * pages can simply be left unmapped, then faulted back on demand.
@@ -2395,7 +2397,6 @@ static void lru_add_page_tail(struct page *head, stru=
ct page *tail,
 		struct lruvec *lruvec, struct list_head *list)
 {
 	VM_BUG_ON_PAGE(!PageHead(head), head);
-	VM_BUG_ON_PAGE(PageCompound(tail), head);
 	VM_BUG_ON_PAGE(PageLRU(tail), head);
 	lockdep_assert_held(&lruvec->lru_lock);
=20
@@ -2416,7 +2417,7 @@ static void lru_add_page_tail(struct page *head, stru=
ct page *tail,
 }
=20
 static void __split_huge_page_tail(struct page *head, int tail,
-		struct lruvec *lruvec, struct list_head *list)
+		struct lruvec *lruvec, struct list_head *list, unsigned int new_order)
 {
 	struct page *page_tail =3D head + tail;
=20
@@ -2483,10 +2484,15 @@ static void __split_huge_page_tail(struct page *hea=
d, int tail,
 	 * which needs correct compound_head().
 	 */
 	clear_compound_head(page_tail);
+	if (new_order) {
+		prep_compound_page(page_tail, new_order);
+		prep_transhuge_page(page_tail);
+	}
=20
 	/* Finally unfreeze refcount. Additional reference from page cache. */
-	page_ref_unfreeze(page_tail, 1 + (!PageAnon(head) ||
-					  PageSwapCache(head)));
+	page_ref_unfreeze(page_tail, 1 + ((!PageAnon(head) ||
+					   PageSwapCache(head)) ?
+						thp_nr_pages(page_tail) : 0));
=20
 	if (page_is_young(head))
 		set_page_young(page_tail);
@@ -2504,7 +2510,7 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 }
=20
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end)
+		pgoff_t end, unsigned int new_order)
 {
 	struct folio *folio =3D page_folio(page);
 	struct page *head =3D &folio->page;
@@ -2512,11 +2518,12 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
 	struct address_space *swap_cache =3D NULL;
 	unsigned long offset =3D 0;
 	unsigned int nr =3D thp_nr_pages(head);
+	unsigned int new_nr =3D 1 << new_order;
 	int order =3D folio_order(folio);
 	int i;
=20
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order, 0);
+	split_page_memcg(head, order, new_order);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
@@ -2531,14 +2538,14 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
=20
 	ClearPageHasHWPoisoned(head);
=20
-	for (i =3D nr - 1; i >=3D 1; i--) {
-		__split_huge_page_tail(head, i, lruvec, list);
+	for (i =3D nr - new_nr; i >=3D new_nr; i -=3D new_nr) {
+		__split_huge_page_tail(head, i, lruvec, list, new_order);
 		/* Some pages can be beyond EOF: drop them from page cache */
 		if (head[i].index >=3D end) {
 			struct folio *tail =3D page_folio(head + i);
=20
 			if (shmem_mapping(head->mapping))
-				shmem_uncharge(head->mapping->host, 1);
+				shmem_uncharge(head->mapping->host, new_nr);
 			else if (folio_test_clear_dirty(tail))
 				folio_account_cleaned(tail,
 					inode_to_wb(folio->mapping->host));
@@ -2548,29 +2555,38 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
 			__xa_store(&head->mapping->i_pages, head[i].index,
 					head + i, 0);
 		} else if (swap_cache) {
+			/*
+			 * split anonymous THPs (including swapped out ones) to
+			 * non-zero order not supported
+			 */
+			VM_WARN_ONCE(new_order,
+				"Split swap-cached anon folio to non-0 order not supported");
 			__xa_store(&swap_cache->i_pages, offset + i,
 					head + i, 0);
 		}
 	}
=20
-	ClearPageCompound(head);
+	if (!new_order)
+		ClearPageCompound(head);
+	else
+		set_compound_order(head, new_order);
 	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
=20
-	split_page_owner(head, order, 0);
+	split_page_owner(head, order, new_order);
=20
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
 		/* Additional pin to swap cache */
 		if (PageSwapCache(head)) {
-			page_ref_add(head, 2);
+			page_ref_add(head, 1 + new_nr);
 			xa_unlock(&swap_cache->i_pages);
 		} else {
 			page_ref_inc(head);
 		}
 	} else {
 		/* Additional pin to page cache */
-		page_ref_add(head, 2);
+		page_ref_add(head, 1 + new_nr);
 		xa_unlock(&head->mapping->i_pages);
 	}
 	local_irq_enable();
@@ -2583,7 +2599,15 @@ static void __split_huge_page(struct page *page, str=
uct list_head *list,
 		split_swap_cluster(entry);
 	}
=20
-	for (i =3D 0; i < nr; i++) {
+	/*
+	 * set page to its compound_head when split to non order-0 pages, so
+	 * we can skip unlocking it below, since PG_locked is transferred to
+	 * the compound_head of the page and the caller will unlock it.
+	 */
+	if (new_order)
+		page =3D compound_head(page);
+
+	for (i =3D 0; i < nr; i +=3D new_nr) {
 		struct page *subpage =3D head + i;
 		if (subpage =3D=3D page)
 			continue;
@@ -2617,29 +2641,31 @@ bool can_split_folio(struct folio *folio, int *pext=
ra_pins)
 }
=20
 /*
- * This function splits huge page into normal pages. @page can point to any
- * subpage of huge page to split. Split doesn't change the position of @pa=
ge.
+ * This function splits huge page into pages in @new_order. @page can poin=
t to
+ * any subpage of huge page to split. Split doesn't change the position of
+ * @page.
  *
  * Only caller must hold pin on the @page, otherwise split fails with -EBU=
SY.
  * The huge page must be locked.
  *
  * If @list is null, tail pages will be added to LRU list, otherwise, to @=
list.
  *
- * Both head page and tail pages will inherit mapping, flags, and so on fr=
om
- * the hugepage.
+ * Pages in new_order will inherit mapping, flags, and so on from the huge=
page.
  *
- * GUP pin and PG_locked transferred to @page. Rest subpages can be freed =
if
- * they are not mapped.
+ * GUP pin and PG_locked transferred to @page or the compound page @page b=
elongs
+ * to. Rest subpages can be freed if they are not mapped.
  *
  * Returns 0 if the hugepage is split successfully.
  * Returns -EBUSY if the page is pinned or if anon_vma disappeared from un=
der
  * us.
  */
-int split_huge_page_to_list(struct page *page, struct list_head *list)
+int split_huge_page_to_list_to_order(struct page *page, struct list_head *=
list,
+				     unsigned int new_order)
 {
 	struct folio *folio =3D page_folio(page);
 	struct deferred_split *ds_queue =3D get_deferred_split_queue(folio);
-	XA_STATE(xas, &folio->mapping->i_pages, folio->index);
+	/* reset xarray order to new order after split */
+	XA_STATE_ORDER(xas, &folio->mapping->i_pages, folio->index, new_order);
 	struct anon_vma *anon_vma =3D NULL;
 	struct address_space *mapping =3D NULL;
 	int extra_pins, ret;
@@ -2649,6 +2675,18 @@ int split_huge_page_to_list(struct page *page, struc=
t list_head *list)
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
=20
+	/* Cannot split THP to order-1 (no order-1 THPs) */
+	if (new_order =3D=3D 1) {
+		VM_WARN_ONCE(1, "Cannot split to order-1 folio");
+		return -EINVAL;
+	}
+
+	/* Split anonymous folio to non-zero order not support */
+	if (folio_test_anon(folio) && new_order) {
+		VM_WARN_ONCE(1, "Split anon folio to non-0 order not support");
+		return -EINVAL;
+	}
+
 	is_hzp =3D is_huge_zero_page(&folio->page);
 	VM_WARN_ON_ONCE_FOLIO(is_hzp, folio);
 	if (is_hzp)
@@ -2744,7 +2782,13 @@ int split_huge_page_to_list(struct page *page, struc=
t list_head *list)
 	if (folio_ref_freeze(folio, 1 + extra_pins)) {
 		if (!list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
-			list_del(&folio->_deferred_list);
+			/*
+			 * Reinitialize page_deferred_list after removing the
+			 * page from the split_queue, otherwise a subsequent
+			 * split will see list corruption when checking the
+			 * page_deferred_list.
+			 */
+			list_del_init(&folio->_deferred_list);
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
@@ -2754,14 +2798,18 @@ int split_huge_page_to_list(struct page *page, stru=
ct list_head *list)
 			if (folio_test_swapbacked(folio)) {
 				__lruvec_stat_mod_folio(folio, NR_SHMEM_THPS,
 							-nr);
-			} else {
+			} else if (!new_order) {
+				/*
+				 * Decrease THP stats only if split to normal
+				 * pages
+				 */
 				__lruvec_stat_mod_folio(folio, NR_FILE_THPS,
 							-nr);
 				filemap_nr_thps_dec(mapping);
 			}
 		}
=20
-		__split_huge_page(page, list, end);
+		__split_huge_page(page, list, end, new_order);
 		ret =3D 0;
 	} else {
 		spin_unlock(&ds_queue->split_queue_lock);
--=20
2.39.2

