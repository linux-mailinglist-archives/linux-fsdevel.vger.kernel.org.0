Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501E06C2683
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 01:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCUAtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 20:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCUAs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:48:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E3615CBE;
        Mon, 20 Mar 2023 17:48:52 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AD2385C019E;
        Mon, 20 Mar 2023 20:48:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 20 Mar 2023 20:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1679359731; x=1679446131; bh=FDz7l3LvqZq3Jky3lnWwH8yTFnKX+aXCW8S
        XEMr4gJE=; b=5niVmPz2aeZ0HtCKbiQvOyB0pMpJh8W6P4WiO3IJI0e7KXhbDWv
        f1jLRmSoY+37hjllFrfS5QGKQPlPk9Y6xWYj9Zuc889dppITzZZVZGGdN7jaKM83
        nyKcrvS2uG+BB9+IjKGwaEBAzHXapjFg+Tr5sO4yfJTp5+QwXAgT/t6/3RN2I1zh
        cAHJ0pecw3okshNGhxFe8k2sl5xA5iXZ8tUkXUagvEBmke+KYlkuL6Qsgi5UglAY
        sULcpxzyyQ5xtAR8tviFv0T06NL7mCBb6B1bkF7iAeo5xCPPu1Wkc8z/fJ5xBQA6
        oiqdCT6+nIYM8UUH29HW1rcn31IYO7pOsTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679359731; x=1679446131; bh=FDz7l3LvqZq3Jky3lnWwH8yTFnKX+aXCW8S
        XEMr4gJE=; b=VgRaX4zOQO6ozdqdwOOQI8XAyWweKsJaRQgDpZk857Tlat5uQXz
        Y5jWN5MThbJgZw78hkbT9B0fmobRSFP4TDPOsQE2fvCcQJOi4csAfFI6j9DFHl1Y
        WxdnJUWShxOZK29RcmlOBI9wm6oQ91tMrHVlWz7vtcSHhONFSwP7bqBK3Hzn1tNJ
        9XiMtjsADoGBAkRkcChzkNq7rxSUsKXQ6tMF5tP//svI1RpyfygxjB+3BLEmb4n6
        tl/L4c3W7jH86BAhT66nwJyn05GlmsL3ZKc6L/Xnm1cluhFVg1S/274La4dhs5w6
        48f2FbVvor7EJHRnmcLDxIU95KvQvopVmCA==
X-ME-Sender: <xms:8_4YZKmc72i3dAcWDirRuXPntKOeoyH4_mVjUdPnnEZbQiETxYQvww>
    <xme:8_4YZB2mhzYH0X78EtvM1YHa8CuHB30MeRUFBjdrVVv5yh4NGstB6is03cHdAX4W1
    7JKKbCQFMLgtVE0Ow>
X-ME-Received: <xmr:8_4YZIogHFdheBO5Os4P7c-m38-fVtiEHhXt746eIJmCQge848iSG5iHbc5lv4rgpVrff-ZAEDvjXUlXShf9s0mIsvSmljcj4Z75O7WQ1xrkUsv3kABNVxKGlf4T1Uo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:8_4YZOlCUUwsLDp-4rCWupLtRT-eFxGfNQYhi8hQUD4GtmibLwrijA>
    <xmx:8_4YZI2Xxnn6EawBL3GbjmBBK6bsdOAOSODK999-uflxmPVkFQwTYQ>
    <xmx:8_4YZFvRmcK_usytmHVr2E093fPwoJPRRyvlD-1bPkDuGJl8_IpntQ>
    <xmx:8_4YZJI_nAwKXmXn5SfX0NgjgvAhJ-YeZlj6UN7tsxxzk1hwVHbDpw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 20:48:51 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 3/5] mm: thp: split huge page to any lower order pages.
Date:   Mon, 20 Mar 2023 20:48:27 -0400
Message-Id: <20230321004829.2012847-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230321004829.2012847-1-zi.yan@sent.com>
References: <20230321004829.2012847-1-zi.yan@sent.com>
Reply-To: Zi Yan <ziy@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 mm/huge_memory.c        | 103 +++++++++++++++++++++++++++++-----------
 2 files changed, 82 insertions(+), 31 deletions(-)

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
index 710189885402..f119b9be33f2 100644
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
+	if (folio_order(folio) >=3D HPAGE_PMD_ORDER)
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
@@ -2416,9 +2417,10 @@ static void lru_add_page_tail(struct page *head, str=
uct page *tail,
 }
=20
 static void __split_huge_page_tail(struct page *head, int tail,
-		struct lruvec *lruvec, struct list_head *list)
+		struct lruvec *lruvec, struct list_head *list, unsigned int new_order)
 {
 	struct page *page_tail =3D head + tail;
+	unsigned long compound_head_flag =3D new_order ? (1L << PG_head) : 0;
=20
 	VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) !=3D -1, page_tail);
=20
@@ -2451,6 +2453,7 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 			 (1L << PG_arch_3) |
 #endif
 			 (1L << PG_dirty) |
+			 compound_head_flag |
 			 LRU_GEN_MASK | LRU_REFS_MASK));
=20
 	/* ->mapping in first and second tail page is replaced by other uses */
@@ -2483,10 +2486,15 @@ static void __split_huge_page_tail(struct page *hea=
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
@@ -2504,7 +2512,7 @@ static void __split_huge_page_tail(struct page *head,=
 int tail,
 }
=20
 static void __split_huge_page(struct page *page, struct list_head *list,
-		pgoff_t end)
+		pgoff_t end, unsigned int new_order)
 {
 	struct folio *folio =3D page_folio(page);
 	struct page *head =3D &folio->page;
@@ -2513,10 +2521,11 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
 	unsigned long offset =3D 0;
 	unsigned int order =3D thp_order(head);
 	unsigned int nr =3D thp_nr_pages(head);
+	unsigned int new_nr =3D 1 << new_order;
 	int i;
=20
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, nr, 1);
+	split_page_memcg(head, nr, new_nr);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
@@ -2531,14 +2540,14 @@ static void __split_huge_page(struct page *page, st=
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
@@ -2548,29 +2557,38 @@ static void __split_huge_page(struct page *page, st=
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
@@ -2583,7 +2601,14 @@ static void __split_huge_page(struct page *page, str=
uct list_head *list,
 		split_swap_cluster(entry);
 	}
=20
-	for (i =3D 0; i < nr; i++) {
+	/*
+	 * set page to its compound_head when split to THPs, so that GUP pin and
+	 * PG_locked are transferred to the right after-split page
+	 */
+	if (new_order)
+		page =3D compound_head(page);
+
+	for (i =3D 0; i < nr; i +=3D new_nr) {
 		struct page *subpage =3D head + i;
 		if (subpage =3D=3D page)
 			continue;
@@ -2617,29 +2642,31 @@ bool can_split_folio(struct folio *folio, int *pext=
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
@@ -2649,6 +2676,18 @@ int split_huge_page_to_list(struct page *page, struc=
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
@@ -2744,7 +2783,13 @@ int split_huge_page_to_list(struct page *page, struc=
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
@@ -2754,14 +2799,18 @@ int split_huge_page_to_list(struct page *page, stru=
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

