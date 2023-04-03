Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7A46D521C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 22:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbjDCUTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 16:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjDCUTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:19:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EA230F2;
        Mon,  3 Apr 2023 13:19:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3D5C55C0077;
        Mon,  3 Apr 2023 16:19:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Apr 2023 16:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680553144; x=1680639544; bh=Yr+uFjBJL/0qCDkJMJuMYA8+4U49oyS8kQR
        IZ4QnQ48=; b=T1hetx0z1aJK2O8iBf1XvbqRSf2LI5NbMRJIZbD7uStCjfYTwWu
        LJGnCoWYcbaqpoiUrntElnYceDUE5dsSh5Ku+hBbgvndzIdg1RoPOlpMQblhIZEj
        Gj9N8O5K106uCqM170WRD7HzCaPjrz+LrVUSe85Y2mDdavpdEAQwrn4H17Ft3gZV
        4i1+Y9GQdBSJAMy41kpcfLa/idIEkFFLl3C4BwKjk/9zNnr+jhhFMl8lURKOJePr
        WUFqi+HV8uSXTAynXN9pclE+IFtgQQ5tFcHeF3Hdw+WTPtgbvTJf/fpYERORW3zX
        w9l3SsHoMN9zpXheXCSyiSDa8U3ezvl9WFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680553144; x=1680639544; bh=Yr+uFjBJL/0qCDkJMJuMYA8+4U49oyS8kQR
        IZ4QnQ48=; b=sXEJDM7KET2Hz2FHW38uAUF1gFqDFEOhVRtiWCqszLoqwd1QDsa
        XpDhu5g5zULZEpHyMzC0XVamd3bmgfGCMbzr8ic5lVeNWN+70QI+kqdzTDEJVJlQ
        lF5zFAKYBWZxkHlKZ/5jObCMfNlOGCacD3+oDf582G15K8Un92Y2c5oKigRFMxqa
        ZXeJYHTlEteuxWOv4laEB07bJgRtG5KeX65vfCX09baLQsAuneHGOMJxAm6qe1z0
        +eOvk/9J9zol6wjU0NxawPfRaYWPNDFUvbyjqYXN0nwNts9yMrGDgrS/wuklV3dq
        WcJctYgIhA+94PoWt+7EwS1GfgHOq/BOyvA==
X-ME-Sender: <xms:tzQrZCo8uqTjGYKs33o2fe68V-IaGHJQvBT47Oz_S4JWxdDXuttsFw>
    <xme:tzQrZAp2B6AGEdHFH6vnh0r3Dz_vwMVlYrnp9j3ZN-RVGkLWaozkrUk4yN4KHpkrF
    ilzuHrfAX94AYprzg>
X-ME-Received: <xmr:tzQrZHOW0kuRr4_Mgqdv8trGM0HrW7t8mAtuyBcuWFjL2xbzs_pu5ShyGshxCRXpc9lshuN0GjK6qjCQ4mD2TrU9V_UwXQ5PRVVOGP7RqS1_O0eKWnnEHviZru7znEM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepge
    eghedugfduuddvleehheetgeeltdetieevuefhffevkefhveeufeeiieejgedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:tzQrZB7NvCwLJaVVuGeQ7ICln7Vbf-jexOeXRI9dL6Tknchu4RQWCg>
    <xmx:tzQrZB4OmAROOKvAsPh3i2Xad-xNrA1GubfZp0yk4AYM6syc21-MOw>
    <xmx:tzQrZBiT-xkdVUMOk28zzM8luszZdlp1TUn6xGCAl9963HjM4ybxcQ>
    <xmx:uDQrZAI8Q20lCXxBZ7EtnQtvMMLu-TD_FgYotLViP9diC9dtoOnc_A>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 16:19:03 -0400 (EDT)
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
Subject: [PATCH v3 1/7] mm/memcg: use order instead of nr in split_page_memcg()
Date:   Mon,  3 Apr 2023 16:18:33 -0400
Message-Id: <20230403201839.4097845-2-zi.yan@sent.com>
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

We do not have non power of two pages, using nr is error prone if nr
is not power-of-two. Use page order instead.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/memcontrol.h | 4 ++--
 mm/huge_memory.c           | 3 ++-
 mm/memcontrol.c            | 3 ++-
 mm/page_alloc.c            | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index aa69ea98e2d8..e06a61ea4fc1 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1151,7 +1151,7 @@ static inline void memcg_memory_event_mm(struct mm_st=
ruct *mm,
 	rcu_read_unlock();
 }
=20
-void split_page_memcg(struct page *head, unsigned int nr);
+void split_page_memcg(struct page *head, int order);
=20
 unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
@@ -1588,7 +1588,7 @@ void count_memcg_event_mm(struct mm_struct *mm, enum =
vm_event_item idx)
 {
 }
=20
-static inline void split_page_memcg(struct page *head, unsigned int nr)
+static inline void split_page_memcg(struct page *head, int order)
 {
 }
=20
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 81a5689806af..3bb003eb80a3 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2512,10 +2512,11 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
 	struct address_space *swap_cache =3D NULL;
 	unsigned long offset =3D 0;
 	unsigned int nr =3D thp_nr_pages(head);
+	int order =3D folio_order(folio);
 	int i;
=20
 	/* complete memcg works before add pages to LRU */
-	split_page_memcg(head, nr);
+	split_page_memcg(head, order);
=20
 	if (PageAnon(head) && PageSwapCache(head)) {
 		swp_entry_t entry =3D { .val =3D page_private(head) };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 681e7528a714..cab2828e188d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3414,11 +3414,12 @@ void obj_cgroup_uncharge(struct obj_cgroup *objcg, =
size_t size)
 /*
  * Because page_memcg(head) is not set on tails, set it now.
  */
-void split_page_memcg(struct page *head, unsigned int nr)
+void split_page_memcg(struct page *head, int order)
 {
 	struct folio *folio =3D page_folio(head);
 	struct mem_cgroup *memcg =3D folio_memcg(folio);
 	int i;
+	unsigned int nr =3D 1 << order;
=20
 	if (mem_cgroup_disabled() || !memcg)
 		return;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0767dd6bc5ba..d84b121d1e03 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2781,7 +2781,7 @@ void split_page(struct page *page, unsigned int order)
 	for (i =3D 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
 	split_page_owner(page, 1 << order);
-	split_page_memcg(page, 1 << order);
+	split_page_memcg(page, order);
 }
 EXPORT_SYMBOL_GPL(split_page);
=20
@@ -4997,7 +4997,7 @@ static void *make_alloc_exact(unsigned long addr, uns=
igned int order,
 		struct page *last =3D page + nr;
=20
 		split_page_owner(page, 1 << order);
-		split_page_memcg(page, 1 << order);
+		split_page_memcg(page, order);
 		while (page < --last)
 			set_page_refcounted(last);
=20
--=20
2.39.2

