Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566DE6C2680
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 01:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjCUAs7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 20:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCUAsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:48:55 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF81F132C8;
        Mon, 20 Mar 2023 17:48:51 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 73B255C0148;
        Mon, 20 Mar 2023 20:48:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 20 Mar 2023 20:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1679359730; x=1679446130; bh=0Tzs8PaBhDS7gnrC9VJc1BLc6ZqSPN615n0
        3F+KtioE=; b=Fq31bFDh7TW17tQxDKm3QuqWpUUozaf6KcCIGz7Z6OjBE/xKfMI
        +YMwa559U7k/zFh9J9lEl7sAjRLg9yKpaXa5QCyo2ORuR+QCNPGQyETnMZdOA/3V
        M8KOVZyGFXkRDZqvKUi/3ZjUedIyo3csEN6BTe4asByFlBlVISekm+uHb7gGHryf
        kJo0fXs32dR6z7XUQ03cvb2rgBwVtxVPl/SSWuaBGrYqpOlNH3nohVUy4HYbzRb6
        +A1CfKMVbX22bdu8mygQ6PLc/g3kSAAij3PxKCSKN/HG4z1GndMIUZ8SqTVKdZC+
        QD+hfXcRKgZLu/LjShA362ay9h+HvzfW7Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679359730; x=1679446130; bh=0Tzs8PaBhDS7gnrC9VJc1BLc6ZqSPN615n0
        3F+KtioE=; b=GuhsskQZstlXVlxY6sW5bBEdR+lJnuzUE2+2GjdthnhLPidQm65
        rnFPK1OQDhX3VlHC9l/Wl/YXeTWQQpvg88tBgccVY7jc0J/oGZWBqDx9hf7UA1Uq
        6WDTqOrmDKyFn9UUEFl8isZS6SaxBUdACAWX69eiaEpNe9TyvwDmAkgIBFod5IAp
        1GBe882iEMuLdC8HeV27NWeoFXCLQnLG+qiqKUhT2FIFS0gciMBkl17OtrgnjauZ
        PCPLE9vkuxOpg1Xn0rjxiyNAR9dA6A9fqLF9uMh2MFbXViUhMW2aNtDi+aTMMz+/
        ApQhl5zkIlRECcS/rJVS2tzmUS/GLwwFUrA==
X-ME-Sender: <xms:8v4YZJokDrXzmxYDdXA9-MDnKGnFH52n2rwG8b43VUM67Hiv-Sn4qQ>
    <xme:8v4YZLoN1l0c1fFRAgXwZrILbM7-_8u7l7rrf1yzMGYS8t544GJ-C1mygFiICm4pA
    lUJzvaoeEMj3jhjfw>
X-ME-Received: <xmr:8v4YZGNMUS-KGJNVBw4SHcHzmoU_NW3KqzKxiBJVIwB8wvB_W8Ql4yK_yAvmWn97xkdLrQLlS821Dmolz299hgRu8coGDfIfx83ajCxbtIOjY-FDFekvA-y4Cf5e7nI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:8v4YZE7kZbqvGiPMshlTOY-jF4hfdyBa0Mv9r8MtXNlzJ8DCPsL_BQ>
    <xmx:8v4YZI4NrECShUuASaKCWTY-OLOYKuC54j7QPi7Ia6OBiOtme6rpmg>
    <xmx:8v4YZMj1PUEHSXzwTSYyM3EofCzWkc2ONVhUJp7er83xzv9pjtr7gg>
    <xmx:8v4YZKsTyJpHmo4xBtnppGHNvfPQ6PBCbys2nAByJ3BDRfDT28Q0_A>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Mar 2023 20:48:49 -0400 (EDT)
From:   Zi Yan <zi.yan@sent.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
        linux-mm@kvack.org
Cc:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 1/5] mm: memcg: make memcg huge page split support any order split.
Date:   Mon, 20 Mar 2023 20:48:25 -0400
Message-Id: <20230321004829.2012847-2-zi.yan@sent.com>
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

It sets memcg information for the pages after the split. A new parameter
new_nr is added to tell the number of subpages in the new page, always 1
for now. It prepares for upcoming changes to support split huge page to
any lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/memcontrol.h | 5 +++--
 mm/huge_memory.c           | 2 +-
 mm/memcontrol.c            | 8 ++++----
 mm/page_alloc.c            | 2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index aa69ea98e2d8..ee1021129142 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1151,7 +1151,7 @@ static inline void memcg_memory_event_mm(struct mm_st=
ruct *mm,
 	rcu_read_unlock();
 }
=20
-void split_page_memcg(struct page *head, unsigned int nr);
+void split_page_memcg(struct page *head, unsigned int nr, unsigned int new=
_nr);
=20
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
@@ -1588,7 +1588,8 @@ void count_memcg_event_mm(struct mm_struct *mm, enum =
vm_event_item idx)
 {
 }
=20
-static inline void split_page_memcg(struct page *head, unsigned int nr)
+static inline void split_page_memcg(struct page *head, unsigned int nr,
+						unsigned int new_nr)
 {
 }
=20
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 81a5689806af..30e3e300c42e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2515,7 +2515,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	int i;
=20
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, nr);
+	split_page_memcg(head, nr, 1);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 681e7528a714..8e505201baf0 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3414,7 +3414,7 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, si=
ze_t size)
 /*
  * Because page_memcg(head) is not set on tails, set it now.
  */
-void split_page_memcg(struct page *head, unsigned int nr)
+void split_page_memcg(struct page *head, unsigned int nr, unsigned int new=
_nr)
 {
 	struct folio *folio =3D page_folio(head);
 	struct mem_cgroup *memcg =3D folio_memcg(folio);
@@ -3423,13 +3423,13 @@ void split_page_memcg(struct page *head, unsigned i=
nt nr)
 	if (mem_cgroup_disabled() || !memcg)
 		return;
=20
-	for (i =3D 1; i < nr; i++)
+	for (i =3D new_nr; i < nr; i +=3D new_nr)
 		folio_page(folio, i)->memcg_data =3D folio->memcg_data;
=20
 	if (folio_memcg_kmem(folio))
-		obj_cgroup_get_many(__folio_objcg(folio), nr - 1);
+		obj_cgroup_get_many(__folio_objcg(folio), nr / new_nr - 1);
 	else
-		css_get_many(&memcg->css, nr - 1);
+		css_get_many(&memcg->css, nr / new_nr - 1);
 }
=20
 #ifdef CONFIG_SWAP
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 2e72fdbdd8db..59c2b6696698 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3531,7 +3531,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i =3D 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, 1 << order);
-	split_page_memcg(page, 1 << order);
+	split_page_memcg(page, 1 << order, 1);
 }
 EXPORT_SYMBOL_GPL(split_page);
=20
--=20
2.39.2

