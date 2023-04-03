Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044996D5218
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 22:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjDCUTJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 16:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjDCUTH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:19:07 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8909630FC;
        Mon,  3 Apr 2023 13:19:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A5D195C00EF;
        Mon,  3 Apr 2023 16:19:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Apr 2023 16:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680553145; x=1680639545; bh=tqMM6rDGpE/k/HR8iQPMcAVX1ewArHJYKHH
        gDopL/rw=; b=wpT7oFFVwFLTvzK53KS7nLSNOrYngSEpjzH/GvK/K+BtVaTnpwt
        5WptsXlmg5k1kHLlbg5xu14eV0qlNbBd8gKVeJQHTdF8nAi5J7qTHAnRPJ8WkyJ5
        IM9PFa3jP7ubn+t+BAIhdOwqHPOlwttbXaVr1p7t6lOj15mPajIvUXCIL2Sio5aJ
        hGikiNIKLcCAViAhW1uJT/yV9qiUES8t+qtBuHOLdB3wGuQXtfJIeNELBUosj/dT
        FndH5PU1wXGL0OImBgdZf7xV+22idrUM35tByYvVKQ+fBvTUbOu4AZSUiwxVN8Fz
        ExcR6OmDo7o0h3U0wdY/tjzRDw/49GTN4wg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680553145; x=1680639545; bh=tqMM6rDGpE/k/HR8iQPMcAVX1ewArHJYKHH
        gDopL/rw=; b=LYskHU926t8XHzszhhYJpGuo0avkqMeVWPCHXgMQ1zrW18Crwes
        /MlQVH3/ujVcFW3iiLUeBHWiio8Bj2I/5qY3hhTyAidX47B+PqaIcC25o+ael2Ka
        HKLuQ1jmke6snUE9DJ+wg7j7nyjeRwyYf8VBURZBHV5eCtEhaEBQhO5Qn+9QCXLB
        +W7XYiey+UO5E7r077araEX7XMF+Y8s82cA06dSNDCrGjO1Mlqlu4plM/xpTW1h9
        jfVnd0SC6mmC1iNWLGfo13aa3SE8Cmd5JjwCCz62OCwWj3dJC/eUqz6y2L1poqdm
        bVgaEEcpq4+70fJp5F5yX6gMtoMRpAVpstA==
X-ME-Sender: <xms:uTQrZH36Q1WiZr_Wl7ITAzLahHHBD905wxKtlHG025xUVlAmj65Fmw>
    <xme:uTQrZGERMPoEPx4oDSU_9OVpgvSDWWweQVIAUXKXkCmSFdeHgzNNmc0e11wIXt9x5
    4llmdPCTTL2Hsb3IQ>
X-ME-Received: <xmr:uTQrZH7k4NCfXzcDC6Vng7tQXqH41EZVH4cLetc53yU-6HuVi_8eFPazQnAFtPdASPKc5MawfFfwbLRYuN3zTzjp8axJsabtLBJxwlc8TpTe8VptkOTIhjWf8SpGMkM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepge
    eghedugfduuddvleehheetgeeltdetieevuefhffevkefhveeufeeiieejgedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:uTQrZM3pFSpfKYgFKf7PhErneCIwQlcq4oTUYfH6iYSR2qVETPFTqg>
    <xmx:uTQrZKF-oiYKPuPF5InmDT22Iy2RFwRbrY3eVYgMdh2Qu5WKaCkEUA>
    <xmx:uTQrZN8sR0xq8GxUYKmub3reDWmYwKniDkkS55g6qjd-WoFmYh-s0g>
    <xmx:uTQrZGF6mpFTYuZJcyH6vBE9tzfg8OIiRDM8OFFtn_VqM2NerG33Hw>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 16:19:04 -0400 (EDT)
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
Subject: [PATCH v3 3/7] mm: memcg: make memcg huge page split support any order split.
Date:   Mon,  3 Apr 2023 16:18:35 -0400
Message-Id: <20230403201839.4097845-4-zi.yan@sent.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403201839.4097845-1-zi.yan@sent.com>
References: <20230403201839.4097845-1-zi.yan@sent.com>
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

