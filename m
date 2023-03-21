Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1A96C2677
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 01:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCUAs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 20:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjCUAsy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:48:54 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E3211653;
        Mon, 20 Mar 2023 17:48:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1801D5C019D;
        Mon, 20 Mar 2023 20:48:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 20 Mar 2023 20:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1679359731; x=1679446131; bh=vAnKio6G1pyRKqUfraKaMDB3b315AuN4QEd
        NLYxwdsw=; b=y0X51D+LQ86Kr2xYgtguu+CJsOoj3uGl1Biz+j6wtuucwB8Ul7G
        1WU7SRSXYafwqUPT96W18O3eN0WP6EQ6gZJBfE7X7FtfP2DjlchcHq/YTkuOYxX0
        NzareEUASz6hZ/r+xDoITDNVfwTl1xVKrVc5i9Ssgcr3UH65mCtpXHwuEg36qoNo
        8p5VAs4u3KNLaBS7ErqjpQTq4F/u/FWtG+3b/sSH8E+JHm0AON8fDrdhSX7zSOOb
        pGdaU3jrncLEPT4epAOqz8dVLoWgrIyeU+Cbs2RGABx8EmNtYBCNSC+g+u/r5J46
        wioYomd8A8HnLYPzzvXocT345MYdbUScO6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679359731; x=1679446131; bh=vAnKio6G1pyRKqUfraKaMDB3b315AuN4QEd
        NLYxwdsw=; b=f2iFj0LnxbayE/fbdq57CRZmIzsyJ82mp2azTzaS663PefKwqL+
        E94QFUztNR9qdKpPQi4ujDylfOkDKesls2LeDiVSRazIzMyIqviHl1iwWZafTozc
        0gvkT43UqlIKu9sAcuCWJPBuyQBgyzIuwA0rZhNdXZgYMmqQqWMKYZ/eJLVrIgWB
        UT1OekG3FNdH+NmxwVpnNgX4JYJrbhU8fNNr7lAHSCCYonAArOJalBP8mQQaXJWo
        kj7pNe1mn6Mu8vwuvKgPMhUyNS9iJCAZQDcCyd35kd4WNKm4lWLdHenocZOSV2vG
        +01s43WmMNNACWLTWXTyMemqRH/Jwc/5Cxg==
X-ME-Sender: <xms:8v4YZB6sY8yXiNB48-VeuqxhgUWClhNkoguHMcKu4g5LXkPZjKDH7A>
    <xme:8v4YZO5YsYrhHaV-ydqXvo52m-HCKJU_T0ybhdSSZRmuKVWAOFU2XvOWixjwlWWSb
    GrHr4wu45KtoiGWIw>
X-ME-Received: <xmr:8v4YZIcJMbonm04Ed5Ore97fzE72_Qokfgwmmi9hhrkLWs7PmxwHwcmqb7rtZi7eWHaY62mhSZJz6w_p3ifNWku1hQIr95MO4l2BSjvBLzOF5aYZj-uCq8sEbOilQC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:8v4YZKLEx3Ti_-t9-4NOu6PX-BW1tmWOqqjvkYRLAtHoEje663ydPw>
    <xmx:8v4YZFIJVDGrribfrliMwyGCU8MdMrpLCdTqZ0-o_Zmn4RCYfNP3GQ>
    <xmx:8v4YZDxAprX49fQlD6LUB1OvkMhFxS5mK-UdABgDEIh-DjJGnyd9tQ>
    <xmx:8_4YZM9hYdGoUXn3l65PhKzNFjgzTV9TZgSoe2F8C_Vx3wcmuejVRg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 20:48:50 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/5] mm: page_owner: add support for splitting to any order in split page_owner.
Date:   Mon, 20 Mar 2023 20:48:26 -0400
Message-Id: <20230321004829.2012847-3-zi.yan@sent.com>
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

It adds a new_order parameter to set new page order in page owner and
uses old_order instead of nr to make the parameters look consistent.
It prepares for upcoming changes to support split huge page to any
lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page_owner.h | 12 +++++++-----
 mm/huge_memory.c           |  3 ++-
 mm/page_alloc.c            |  6 +++---
 mm/page_owner.c            | 11 ++++++-----
 4 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 119a0c9d2a8b..67d98de3d5a8 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -11,7 +11,8 @@ extern struct page_ext_operations page_owner_ops;
 extern void __reset_page_owner(struct page *page, unsigned short order);
 extern void __set_page_owner(struct page *page,
 			unsigned short order, gfp_t gfp_mask);
-extern void __split_page_owner(struct page *page, unsigned int nr);
+extern void __split_page_owner(struct page *page, unsigned short old_order,
+			unsigned short new_order);
 extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
 extern void __dump_page_owner(const struct page *page);
@@ -31,10 +32,11 @@ static inline void set_page_owner(struct page *page,
 		__set_page_owner(page, order, gfp_mask);
 }
=20
-static inline void split_page_owner(struct page *page, unsigned int nr)
+static inline void split_page_owner(struct page *page, unsigned short old_=
order,
+			unsigned short new_order)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__split_page_owner(page, nr);
+		__split_page_owner(page, old_order, new_order);
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *=
old)
 {
@@ -56,11 +58,11 @@ static inline void reset_page_owner(struct page *page, =
unsigned short order)
 {
 }
 static inline void set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask)
+			unsigned short order, gfp_t gfp_mask)
 {
 }
 static inline void split_page_owner(struct page *page,
-			unsigned short order)
+			unsigned short old_order, unsigned short new_order)
 {
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *=
folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 30e3e300c42e..710189885402 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2511,6 +2511,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	struct lruvec *lruvec;
 	struct address_space *swap_cache =3D NULL;
 	unsigned long offset =3D 0;
+	unsigned int order =3D thp_order(head);
 	unsigned int nr =3D thp_nr_pages(head);
 	int i;
=20
@@ -2556,7 +2557,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
=20
-	split_page_owner(head, nr);
+	split_page_owner(head, order, 0);
=20
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 59c2b6696698..ec85562865fb 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3530,7 +3530,7 @@ void split_page(struct page *page, unsigned int order)
=20
 	for (i =3D 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
-	split_page_owner(page, 1 << order);
+	split_page_owner(page, order, 0);
 	split_page_memcg(page, 1 << order, 1);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -5746,8 +5746,8 @@ static void *make_alloc_exact(unsigned long addr, uns=
igned int order,
 		struct page *page =3D virt_to_page((void *)addr);
 		struct page *last =3D page + nr;
=20
-		split_page_owner(page, 1 << order);
-		split_page_memcg(page, 1 << order);
+		split_page_owner(page, 1 << order, 1);
+		split_page_memcg(page, 1 << order, 1);
 		while (page < --last)
 			set_page_refcounted(last);
=20
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 31169b3e7f06..33d1b6efe6a6 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -211,19 +211,20 @@ void __set_page_owner_migrate_reason(struct page *pag=
e, int reason)
 	page_ext_put(page_ext);
 }
=20
-void __split_page_owner(struct page *page, unsigned int nr)
+void __split_page_owner(struct page *page, unsigned short old_order,
+			unsigned short new_order)
 {
-	int i;
+	int i, old_nr =3D 1 << old_order, new_nr =3D 1 << new_order;
 	struct page_ext *page_ext =3D page_ext_get(page);
 	struct page_owner *page_owner;
=20
 	if (unlikely(!page_ext))
 		return;
=20
-	for (i =3D 0; i < nr; i++) {
+	for (i =3D 0; i < old_nr; i +=3D new_nr) {
+		page_ext =3D lookup_page_ext(page + i);
 		page_owner =3D get_page_owner(page_ext);
-		page_owner->order =3D 0;
-		page_ext =3D page_ext_next(page_ext);
+		page_owner->order =3D new_order;
 	}
 	page_ext_put(page_ext);
 }
--=20
2.39.2

