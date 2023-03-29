Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0900E6CCF64
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 03:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjC2BRo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 21:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjC2BRj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:17:39 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28546D3;
        Tue, 28 Mar 2023 18:17:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8B7F55C0045;
        Tue, 28 Mar 2023 21:17:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 28 Mar 2023 21:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680052657; x=1680139057; bh=aUMOD1VSwlpi8SU9QPM0FjnDI83YsOvX8fZ
        YLAjytoI=; b=iU4MYKvhUukywGLlEKLDX1/HMUmgD5WUDx2430lFmQsZIhey7CK
        7JjS1kU6XkWTAoOQySY0cHobbSepGAIj7sJqRg0shuxUR+44r6AfYijMOePSVmDu
        DQqtqV9U1nPHSYreR1ohCXfx08+8zUUk4VkO1guvg3/16I712KrD7IxqENlmJuVB
        3Pw+iNLUhjVEidWtwAgnY+6k+6wY64IS5cwhi2KETMbEoNs+LqE/YC61mXtbosuX
        mQbcG4K6YMloRXpM7MhLr2L6Nrnv6Zw4H9P3zuS9xfKFh4NA0gFxIozLf4/Q0LM8
        anDlvpywXGYBrDSdsc7hdaMA9hqFSWYEG6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680052657; x=1680139057; bh=aUMOD1VSwlpi8SU9QPM0FjnDI83YsOvX8fZ
        YLAjytoI=; b=Hg04jMI5y3sqbJL6KV0puzCcXMJARxNuBYPS6DXyJRqHRSi38BA
        RIQXYJy5djVGBfx+pbu9ZoFt0zLAoA9tr2R8JLVaa6ByVUbM/0MxNAIvTNTopG4U
        IqpDwFiiNQ5HcqX4arm4qukeaMS0uz8t8qgz7+eoyz2hBNELSlD3LZTsLBD1/y9O
        P/86PYDBX42C6WQrws1vMnWuHR9JLtUqpmQbLw162AINMkLSCCk2fCzAqV0L6m8u
        5SBW+pJxXniU5RcZzhgXL0DvAv8g4gQ946LkSzyZXUx+fDXd9CwKHpFPqnw7WsM9
        fC2COPUF0IOLnOu/YPq9aI6zMJ6JNNsuRMw==
X-ME-Sender: <xms:sZEjZOZkWw_LJihxVyIoSX70kxEFSmnTGc9gY4LpXI-vV82CExrD_w>
    <xme:sZEjZBa2jmYl8-FoXQtQ-j190vg9lmMmghft9uMfa0miPA4uCFCiK2nLal9vCwG2R
    PGYQGUPAD9-1dcLNA>
X-ME-Received: <xmr:sZEjZI-jA8rT76we75EcGsbnHOxIDE7hoyjP-KRxdIe5zc6GVB2HqxbjDcmK3zFlUxYONfXXo7qTtQX8rXcIyRka6-Ds-jYw9EqcBGaz31PJFNlt0q7dG1UVuHbNXC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehhedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:sZEjZAqKNlfFxrtgkmTRIdQEtsN2YN1Qc_0pcRldBrlQKFxphL0KmQ>
    <xmx:sZEjZJqGuUvbx7hGVbSfJEY1A5PDM_zOtORAl5P99fRSUK_xM3Dr9A>
    <xmx:sZEjZORHyw-OI2PxuZ-Nc9gTREU6u_4xANwCwOAGnmH7tcrJFs1nEA>
    <xmx:sZEjZK6ee-XhjOn6_HLs25arF2OvW_HP6kf_w_QkzqVfs-nMFFBD_A>
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
Subject: [PATCH v2 4/7] mm: page_owner: add support for splitting to any order in split page_owner.
Date:   Tue, 28 Mar 2023 21:17:09 -0400
Message-Id: <20230329011712.3242298-5-zi.yan@sent.com>
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

It adds a new_order parameter to set new page order in page owner.
It prepares for upcoming changes to support split huge page to any
lower order.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page_owner.h | 10 +++++-----
 mm/huge_memory.c           |  2 +-
 mm/page_alloc.c            |  4 ++--
 mm/page_owner.c            | 11 ++++++-----
 4 files changed, 14 insertions(+), 13 deletions(-)

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
index 64233b5b09d5..347861fe9c50 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -211,20 +211,21 @@ void __set_page_owner_migrate_reason(struct page *pag=
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

