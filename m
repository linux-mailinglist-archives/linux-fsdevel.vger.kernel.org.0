Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163936D5229
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 22:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjDCUTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 16:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjDCUTJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:19:09 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EDD30F2;
        Mon,  3 Apr 2023 13:19:08 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F34585C012D;
        Mon,  3 Apr 2023 16:19:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Apr 2023 16:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680553147; x=1680639547; bh=n0I3rKbVmW11Ko5MdyrWnLEXy5CTcBBnWUT
        tQZPt4TU=; b=CknXjAfEg+BlpRI36eBMzyBQgGufPONGhPvWy7s+gy/bhNUeDoy
        XrZZS36kGlcl7YvPRJZxh2QYUhLMrXCglMzsbdi6caUVkB32GPU136oGWOw9D7FN
        a8wMhxHbFNmlt1qrJ4P/OxqrHkHDhHurwSRTuukUPsm7F/OfAzu7PwJdwNe7hY1d
        dOGCKNRadN2+ZLi0jXCvtfukxAs0chGy99+JG1ewv3jNM2OLkjwCNlw0I19tiNiQ
        FnGOZayjMtLBHucHfEbFGOi/9g1Wg+PAq0cU0Ne/rfk5Pt2zZn8rEnuff6x7Lwtq
        wL12JuQLFZHNFUdi0ohPgNaCwuQhZRPtcow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680553147; x=1680639547; bh=n0I3rKbVmW11Ko5MdyrWnLEXy5CTcBBnWUT
        tQZPt4TU=; b=hNICcSGN1EXXDV3uYu5QpP5/qwn5lAAgv19FTzFTRbX5N0FlNAD
        +5Ly6h8+eRZyyrSEBPSN01hlDZia4jeE8G0YMvkRUcpZK9YRyKP43ep+HjxUeE20
        azKRsRgrYvZ0GHFOvtBFsAnC1eAK617AZaxsoAL4N0/2EGRvbUPQr0Hgug9brVGx
        wq1vCYXFWpRBjdnVF9SmQ0OIxtvSSxi76UNt/wFGEF57YmmJAUg0kBVUaVJRBARw
        Peey3G6reNzAV18EFN4QhsoRg4Ow1+bNDTN5r17diEi2jc8HfCGGMbSUEL0f0Ikv
        GUwL+HnFRkobihhK9fbtiKJ902159F8YvgA==
X-ME-Sender: <xms:uzQrZB6IJt0E4Vr7WXGEEOtrVSNqZr0oRs82LO0MPz-HoT9ix9hZIQ>
    <xme:uzQrZO4EUY-KmN6UILhtIOt_8x7Ov0dXwU_33A4TVKRm0yI_4gULxoOGGcrBNMYBG
    cDCBkQgxY_y5Sc0Yw>
X-ME-Received: <xmr:uzQrZIdFtbYcVopmKQ27n_ZKtGjULpTfkNbprXMl9jxFx4OX7DigqM5rm16vg_aaTKU_JDAsIcT_lptJWt4sJZnugHE5DQKp192EwTFjIzUgnd-uK3aiy-qxd-KxXLM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfrhgggfestdhqredtredttdenucfhrhhomhepkghi
    ucgjrghnuceoiihirdihrghnsehsvghnthdrtghomheqnecuggftrfgrthhtvghrnhepge
    eghedugfduuddvleehheetgeeltdetieevuefhffevkefhveeufeeiieejgedvnecuvehl
    uhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepiihirdihrghnse
    hsvghnthdrtghomh
X-ME-Proxy: <xmx:uzQrZKJQ_RZ7WBIwcyQsvqV-5WucpCTLug_YI5UCZKnhtrozXo1qXw>
    <xmx:uzQrZFKl6G3Z1OlYdkv7gle-VuRdh66aK_GjPcy6tb_G5GaKm9kJhg>
    <xmx:uzQrZDysFNWsA_zBLmOw_g7mj6g0RwYMp4NYg8VcFUN-w8SIV08Z-w>
    <xmx:uzQrZMZs96aArrHocdWadvKbkOMQXEzr9eTIkcWDRGQQg8vr-qv-vg>
Feedback-ID: iccd040f4:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 16:19:07 -0400 (EDT)
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
Subject: [PATCH v3 6/7] mm: truncate: split huge page cache page to a non-zero order if possible.
Date:   Mon,  3 Apr 2023 16:18:38 -0400
Message-Id: <20230403201839.4097845-7-zi.yan@sent.com>
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

