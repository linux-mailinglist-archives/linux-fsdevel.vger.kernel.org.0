Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792216D521F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 22:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjDCUTM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 16:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjDCUTI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:19:08 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167053589;
        Mon,  3 Apr 2023 13:19:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7DE075C01D4;
        Mon,  3 Apr 2023 16:19:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 03 Apr 2023 16:19:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680553146; x=1680639546; bh=/Fyda6DdrS5eQAxPutJLWU7rPSEY+1UbDEA
        wHHIWfJU=; b=nz/6OkYjLbCZX+ixfPsX979MsgC+XBBrD4ldyEfa/BZo60sfHsp
        z/ityPXAu8IL/HKTy3HBCG3CJn6kCJWKjTcsf8y3lAiZlzSuMmKnUEhuRZajXGeo
        tm2Kslm94MRfstlsxAeWjXTfyZYyVK9zt9N1AocGdn5hWS/lNGatQfldBWmMfkZS
        dOsE2fMrcgFu2KJ5PFqRylGCWWeHqjxUVlcKN2T2tKEagRTtNo0GpgDrgipRLGEE
        +uADnX0J4NstF3xR7llS00aEZXSLFOK9VLm52ytHn+6BbMXN8Oq61caDfYiAZUSp
        b58E1ySQUSi59D7M3+ZB4fBnCBL1mqAQBgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680553146; x=1680639546; bh=/Fyda6DdrS5eQAxPutJLWU7rPSEY+1UbDEA
        wHHIWfJU=; b=N+H9wuitSDaOyzs7mde+61NwgHhTfzBzdBVkWra5jyk0ReWUrrX
        rpK0QabHxDx8blNWX6nbr262B1krQ92qPL7mwEguLhuNhmPrm/bGm1wjNQXDFWF5
        5+X8ZeX1Y5++dP1TmUj5rMaUdNfk3xLEcfeJo4fK80qP7qBe0RHLPdJw8eWK3Urr
        srsfAYspeZ7kyUHsa48gvNQWMyr8JbcqY474rlV3zpWAxJ078HENXuMZS8oA7+D4
        a7tOAGxMgd5F1W5jZmpCDFo3sqqIIZk+Y+ftLUZ/esjhYpq1Pb18aoXSKFee6O7I
        3U0L7NaJHqMvYxnRnaJoEOMMiF9uRp7atDw==
X-ME-Sender: <xms:ujQrZFMN2O7bmcJC6SP64hwLNrj5ZeGPsj6VcaoSxONf8ZYdqUyZbg>
    <xme:ujQrZH9acFho553pqihXxtpNs6IaTatcAEdg-QBZDtjI-u1j3aN_T6KtaVSHDl66r
    P_R3Rlic1cFFvJyEw>
X-ME-Received: <xmr:ujQrZET6mB_vc_GoFQlR8KfWKL7DbwtJlq3b-gdNxvKyUEfJy3Mp11y6fq1NfJgsiw5c_D73y6TpweQ8Je4o3d90HAEzZAywxNnZgY-aZgdw8BAEVqV0nqozhPHVExY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepge
    eghedugfduuddvleehheetgeeltdetieevuefhffevkefhveeufeeiieejgedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:ujQrZBsTj9hecXi10a51YKtmY4iFgtn6IcV7WYnrUkbnV3Rgce-UXw>
    <xmx:ujQrZNcoPQMoNJ_fuz8M2LZFKu06q_cDeyPrMZ_Yo9Hi0_UHdIPNBQ>
    <xmx:ujQrZN0p1uxDp33xSzoc_owyhwt_bivJeCKt2so7S9O5nXv4qDYmxw>
    <xmx:ujQrZA-Shg8DlbiRTvt2MxdjxQVHCH6gAF7f20wwSXPqQzVvL20boA>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 16:19:05 -0400 (EDT)
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
Subject: [PATCH v3 4/7] mm: page_owner: add support for splitting to any order in split page_owner.
Date:   Mon,  3 Apr 2023 16:18:36 -0400
Message-Id: <20230403201839.4097845-5-zi.yan@sent.com>
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

It adds a new_order parameter to set new page order in page owner.
It prepares for upcoming changes to support split huge page to any
lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page_owner.h | 10 +++++-----
 mm/huge_memory.c           |  2 +-
 mm/page_alloc.c            |  4 ++--
 mm/page_owner.c            |  9 +++++----
 4 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index d7878523adfc..a784ba69f67f 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -11,7 +11,7 @@ extern struct page_ext_operations page_owner_ops;
 extern void __reset_page_owner(struct page *page, unsigned short order);
 extern void __set_page_owner(struct page *page,
 			unsigned short order, gfp_t gfp_mask);
-extern void __split_page_owner(struct page *page, int order);
+extern void __split_page_owner(struct page *page, int old_order, int new_o=
rder);
 extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
 extern void __dump_page_owner(const struct page *page);
@@ -31,10 +31,10 @@ static inline void set_page_owner(struct page *page,
 		__set_page_owner(page, order, gfp_mask);
 }
=20
-static inline void split_page_owner(struct page *page, int order)
+static inline void split_page_owner(struct page *page, int old_order, int =
new_order)
 {
 	if (static_branch_unlikely(&page_owner_inited))
-		__split_page_owner(page, order);
+		__split_page_owner(page, old_order, new_order);
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *=
old)
 {
@@ -56,11 +56,11 @@ static inline void reset_page_owner(struct page *page, =
unsigned short order)
 {
 }
 static inline void set_page_owner(struct page *page,
-			unsigned int order, gfp_t gfp_mask)
+			unsigned short order, gfp_t gfp_mask)
 {
 }
 static inline void split_page_owner(struct page *page,
-			int order)
+			int old_order, int new_order)
 {
 }
 static inline void folio_copy_owner(struct folio *newfolio, struct folio *=
folio)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 106cde74d933..f8a8a72b207d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2557,7 +2557,7 @@ static void __split_huge_page(struct page *page, stru=
ct list_head *list,
 	unlock_page_lruvec(lruvec);
 	/* Caller disabled irqs, so they are still disabled here */
=20
-	split_page_owner(head, order);
+	split_page_owner(head, order, 0);
=20
 	/* See comment in __split_huge_page_tail() */
 	if (PageAnon(head)) {
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ef559795525b..4845ff6c4223 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2780,7 +2780,7 @@ void split_page(struct page *page, unsigned int order)
=20
 	for (i =3D 1; i < (1 << order); i++)
 		set_page_refcounted(page + i);
-	split_page_owner(page, order);
+	split_page_owner(page, order, 0);
 	split_page_memcg(page, order, 0);
 }
 EXPORT_SYMBOL_GPL(split_page);
@@ -4996,7 +4996,7 @@ static void *make_alloc_exact(unsigned long addr, uns=
igned int order,
 		struct page *page =3D virt_to_page((void *)addr);
 		struct page *last =3D page + nr;
=20
-		split_page_owner(page, order);
+		split_page_owner(page, order, 0);
 		split_page_memcg(page, order, 0);
 		while (page < --last)
 			set_page_refcounted(last);
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 64233b5b09d5..72244a4f1a31 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -211,19 +211,20 @@ void __set_page_owner_migrate_reason(struct page *pag=
e, int reason)
 	page_ext_put(page_ext);
 }
=20
-void __split_page_owner(struct page *page, int order)
+void __split_page_owner(struct page *page, int old_order, int new_order)
 {
 	int i;
 	struct page_ext *page_ext =3D page_ext_get(page);
 	struct page_owner *page_owner;
-	unsigned int nr =3D 1 << order;
+	unsigned int old_nr =3D 1 << old_order;
+	unsigned int new_nr =3D 1 << new_order;
=20
 	if (unlikely(!page_ext))
 		return;
=20
-	for (i =3D 0; i < nr; i++) {
+	for (i =3D 0; i < old_nr; i +=3D new_nr) {
 		page_owner =3D get_page_owner(page_ext);
-		page_owner->order =3D 0;
+		page_owner->order =3D new_order;
 		page_ext =3D page_ext_next(page_ext);
 	}
 	page_ext_put(page_ext);
--=20
2.39.2

