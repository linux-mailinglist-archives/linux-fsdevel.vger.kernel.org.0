Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845506CCF65
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 03:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjC2BRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 21:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjC2BRl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 21:17:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A653130E4;
        Tue, 28 Mar 2023 18:17:39 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D3FC5C00F0;
        Tue, 28 Mar 2023 21:17:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 28 Mar 2023 21:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680052659; x=1680139059; bh=n0I3rKbVmW11Ko5MdyrWnLEXy5CTcBBnWUT
        tQZPt4TU=; b=AgPcQhKTNgGR+bE1G8EVwVYSsvXI5KtJXlVvtOKa5ATqXXwCf/6
        lZnsdHkTe/6rQFW7Orubpm/Guh937SkdusjMAmB6zRyoOKVx45v5/LbONp3y30w5
        ACTlWT/JBCu0JoviU/XMSw2gDSJdrc+LCx0AHUFu8XI1JL+7qnT5ZZ1a138JeE3G
        UVuEV5KecJKpzdcyiolNkSaQbkeOxomRSmgEgrOdguQaHmQb/8LXsyXlJNbvpqw+
        tL35C/RdeaPwMIf+hvzaOe1V8EpqdEmYe5Lqov0PZU26M6evaXf7ITBm6LA/K0aS
        WaPN5GGsrzi2rjGf/FG6mATsBsO9d52JvBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680052659; x=1680139059; bh=n0I3rKbVmW11Ko5MdyrWnLEXy5CTcBBnWUT
        tQZPt4TU=; b=Cux0JaYsiE0eu7v9sa4P9tATX0d1RQyZLsw9Wh2WDAUsJtPiv++
        PAVUrKEsXvGON4AD2CEzWW4TGEVMWe3ZUHhG12Z5Kk9TCjUGuPBSFQy1GErCQar1
        oios7zs7juHKmcrWxX2VRwwAT0gv4jzvtEUDi3qNpw2ToejR8e/gU+SVl0ubX91I
        oplO9UOuXcEtu+hR4ynW3B/ecxkKD7myJRBAYAPhPUHwNWxObAF6ueubUcUk4MJg
        R0WcAyp5UHI4076+A6bZLGsA7VBwZN34/DmRBzeYE2wl+rY4hhrveFTmXuU+5nD7
        XBbnJ7s2rT0P1HE54qJ7WScWfZGcrNq9I+A==
X-ME-Sender: <xms:spEjZON228OM9aL17ztjPq0Ss5Pqm6VWNLayOYDzvNjyE8LWCLc98w>
    <xme:spEjZM-se0y3TfQZ9W3xFNViC1KDXZsz73pyTWUoW78mXTbWVunZg-Agk-b4CjBrw
    vjzeH6KM-SCZzh0ow>
X-ME-Received: <xmr:spEjZFTmHnYMHH9c8FONFDAyTGHXnW9sHqjODkGnRej94wFCjktn5fR2mjgUwS24IuUwI5QPE6JB36JkRG9Ct-OaAQZ-iQw8G3XXbKz7-TbaKlaxso2t9sYRA7EAnH8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehhedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:spEjZOv1aoCR3TKJwOLsAszZrHNp11L7EFO0LPpOnr2m80BPgE7mxQ>
    <xmx:spEjZGebY4ELgVUs-2T3T4EWp_4lAgSKmEM0Cq5jkT-0DGsbONXVLw>
    <xmx:spEjZC1R4qqGE-Mqzm_gPgLUgjqn_kzGdAezcQrS7ocl5_DI17-CZw>
    <xmx:s5EjZN9lGxAW8_mkFkwhbSuAVW0bSc6skgEg4osbSGzpWySwQPfNiQ>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Mar 2023 21:17:38 -0400 (EDT)
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
Subject: [PATCH v2 6/7] mm: truncate: split huge page cache page to a non-zero order if possible.
Date:   Tue, 28 Mar 2023 21:17:11 -0400
Message-Id: <20230329011712.3242298-7-zi.yan@sent.com>
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

To minimize the number of pages after a huge page truncation, we do not
need to split it all the way down to order-0. The huge page has at most
three parts, the part before offset, the part to be truncated, the part
remaining at the end. Find the greatest common divisor of them to
calculate the new page order from it, so we can split the huge
page to this order and keep the remaining pages as large and as few as
possible.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 mm/truncate.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/mm/truncate.c b/mm/truncate.c
index 86de31ed4d32..817efd5e94b4 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -22,6 +22,7 @@
 #include <linux/buffer_head.h>	/* grr. try_to_release_page */
 #include <linux/shmem_fs.h>
 #include <linux/rmap.h>
+#include <linux/gcd.h>
 #include "internal.h"
=20
 /*
@@ -211,7 +212,8 @@ int truncate_inode_folio(struct address_space *mapping,=
 struct folio *folio)
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start, loff_=
t end)
 {
 	loff_t pos =3D folio_pos(folio);
-	unsigned int offset, length;
+	unsigned int offset, length, remaining;
+	unsigned int new_order =3D folio_order(folio);
=20
 	if (pos < start)
 		offset =3D start - pos;
@@ -222,6 +224,7 @@ bool truncate_inode_partial_folio(struct folio *folio, =
loff_t start, loff_t end)
 		length =3D length - offset;
 	else
 		length =3D end + 1 - pos - offset;
+	remaining =3D folio_size(folio) - offset - length;
=20
 	folio_wait_writeback(folio);
 	if (length =3D=3D folio_size(folio)) {
@@ -236,11 +239,25 @@ bool truncate_inode_partial_folio(struct folio *folio=
, loff_t start, loff_t end)
 	 */
 	folio_zero_range(folio, offset, length);
=20
+	/*
+	 * Use the greatest common divisor of offset, length, and remaining
+	 * as the smallest page size and compute the new order from it. So we
+	 * can truncate a subpage as large as possible. Round up gcd to
+	 * PAGE_SIZE, otherwise ilog2 can give -1 when gcd/PAGE_SIZE is 0.
+	 */
+	new_order =3D ilog2(round_up(gcd(gcd(offset, length), remaining),
+				   PAGE_SIZE) / PAGE_SIZE);
+
+	/* order-1 THP not supported, downgrade to order-0 */
+	if (new_order =3D=3D 1)
+		new_order =3D 0;
+
+
 	if (folio_has_private(folio))
 		folio_invalidate(folio, offset, length);
 	if (!folio_test_large(folio))
 		return true;
-	if (split_folio(folio) =3D=3D 0)
+	if (split_huge_page_to_list_to_order(&folio->page, NULL, new_order) =3D=
=3D 0)
 		return true;
 	if (folio_test_dirty(folio))
 		return false;
--=20
2.39.2

