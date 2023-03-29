Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7066CCF5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 03:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjC2BRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 21:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjC2BRi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:17:38 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4560D171B;
        Tue, 28 Mar 2023 18:17:37 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id AB69D5C00E1;
        Tue, 28 Mar 2023 21:17:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 28 Mar 2023 21:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680052656; x=1680139056; bh=tqMM6rDGpE/k/HR8iQPMcAVX1ewArHJYKHH
        gDopL/rw=; b=hLP7XiSYjLlCRd7lrVm3ZMABglqLVh/uiS4L+T6/ooSIAVoHnop
        dSSVOlJ2QIYAH0C27cKSvqfBGrTbQpFjeMaMREVycqpMmUtVPFxbSs2bCCiBUhQG
        t//bCkzodvujojloLhv74DGmERUsKVCkokoaA63NLw509LEhOAwrJsco7BKgOpt8
        /cEeBZVM8fzDjQOJZoBHjo5bm13JluuuMLODiAaAnvioAcVccMnsGOi5nyiiV73/
        Xijb5DIniR6x306TPsS6SxR8DI/YO5StlWvfhx+xjgSYxzAaQuVH9NPeLxgPBI3S
        sK8k0O6uwfWepbI3SR3I3SLq6CAgHztM6VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680052656; x=1680139056; bh=tqMM6rDGpE/k/HR8iQPMcAVX1ewArHJYKHH
        gDopL/rw=; b=bGvmUg86eQWS7avpajzu2TiXESB+1FnJpYcefpwmrz3WcMqmTWn
        oTqa2z0f/A/JHfgh8lz9y0VDVWpl2zB2mWVxPTBaFlqUQ+3E+FXtc8VGVDXESXCc
        v3GWCECIeaCslCfiVSxZHaG6NeD+lhI30pXXZwuNpgxQzxv9pY7AC035KeoKbgKs
        MQQ4+5CVfWvjsleQNbmsrtS042v/W9ghVHu5X6z7N7tQkEmIJ/zUUM2eWJmkmaxA
        lB3LE7cs8PysAHDmcExUKlK21dIaXdQHb91qwZ9ihCla1Vb2LvAxXQ+EV3bbF94I
        F8Ec2Oa8NUn5ORSAx/G2H5uspktCBkIrIIw==
X-ME-Sender: <xms:sJEjZArNfFTUDSa0ZNasM_Dmma8cLvf8pWMf5IdSrxTSP06OpmcbWQ>
    <xme:sJEjZGpliBL9WMLYVhEbaCv9O1Gbl0NY-2dvsTVIIj9vLoHLsjyf9JlYHtDenT2hg
    _W0RUQ3ghx0crb2Kw>
X-ME-Received: <xmr:sJEjZFPCSNA1sSE8qBqlHfU8H11HAwaCOMxK0Y9lyxXhgTinl8p_BfF3a-s6FXpicZpxVvi4fRiqBO4YvgbkeJdxzpyzZunkKCDKj4sF463f6E4cDFrj5ukglz3D8V8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehhedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:sJEjZH67-HBN14n3_04b8SOONe1oBCkoOz3D7Fx9rg3j2_UFzmlKOg>
    <xmx:sJEjZP7MxuqWYFF6SPRGWWacyo8BINzz61RlAccsBEZ0neZ-5mnRFQ>
    <xmx:sJEjZHgY4FFzd3FDYUpH_jnr6UdwgnKF_1T03HYDQ0T381buLFn3dQ>
    <xmx:sJEjZGKIueMpVCO6usODUWSG29NH1M-J8Gd6Lr0zR2CcjqaLTfJO9A>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Mar 2023 21:17:36 -0400 (EDT)
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
Subject: [PATCH v2 3/7] mm: memcg: make memcg huge page split support any order split.
Date:   Tue, 28 Mar 2023 21:17:08 -0400
Message-Id: <20230329011712.3242298-4-zi.yan@sent.com>
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

It sets memcg information for the pages after the split. A new parameter
new_order is added to tell the order of subpages in the new page, always 0
for now. It prepares for upcoming changes to support split huge page to
any lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/memcontrol.h |  4 ++--
 mm/huge_memory.c           |  2 +-
 mm/memcontrol.c            | 11 ++++++-----
 mm/page_alloc.c            |  4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index e06a61ea4fc1..1633c00fe393 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1151,7 +1151,7 @@ static inline void memcg_memory_event_mm(struct mm_st=
ruct *mm,
 	rcu_read_unlock();
 }
=20
-void split_page_memcg(struct page *head, int order);
+void split_page_memcg(struct page *head, int old_order, int new_order);
=20
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
@@ -1588,7 +1588,7 @@ void count_memcg_event_mm(struct mm_struct *mm, enum =
vm_event_item idx)
 {
 }
=20
-static inline void split_page_memcg(struct page *head, int order)
+static inline void split_page_memcg(struct page *head, int old_order, int =
new_order)
 {
 }
=20
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index a21921c90b21..106cde74d933 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2516,7 +2516,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	int i;
=20
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, order);
+	split_page_memcg(head, order, 0);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index cab2828e188d..93ae37f90c84 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3414,23 +3414,24 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, =
size_t size)
 /*
  * Because page_memcg(head) is not set on tails, set it now.
  */
-void split_page_memcg(struct page *head, int order)
+void split_page_memcg(struct page *head, int old_order, int new_order)
 {
 	struct folio *folio =3D page_folio(head);
 	struct mem_cgroup *memcg =3D folio_memcg(folio);
 	int i;
-	unsigned int nr =3D 1 << order;
+	unsigned int old_nr =3D 1 << old_order;
+	unsigned int new_nr =3D 1 << new_order;
=20
 	if (mem_cgroup_disabled() || !memcg)
 		return;
=20
-	for (i =3D 1; i < nr; i++)
+	for (i =3D new_nr; i < old_nr; i +=3D new_nr)
 		folio_page(folio, i)->memcg_data =3D folio->memcg_data;
=20
 	if (folio_memcg_kmem(folio))
-		obj_cgroup_get_many(__folio_objcg(folio), nr - 1);
+		obj_cgroup_get_many(__folio_objcg(folio), old_nr / new_nr - 1);
 	else
-		css_get_many(&memcg->css, nr - 1);
+		css_get_many(&memcg->css, old_nr / new_nr - 1);
 }
=20
 #ifdef CONFIG_SWAP
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d537828bc4be..ef559795525b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2781,7 +2781,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i =3D 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, order);
-	split_page_memcg(page, order);
+	split_page_memcg(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
=20
@@ -4997,7 +4997,7 @@ static void *make_alloc_exact(unsigned long addr, uns=
igned int order,
 		struct page *last =3D page + nr;
=20
 		split_page_owner(page, order);
-		split_page_memcg(page, order);
+		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);
=20
--=20
2.39.2

