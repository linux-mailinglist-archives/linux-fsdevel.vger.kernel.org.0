Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82266C2687
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 01:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjCUAtD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 20:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCUAs4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 20:48:56 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80DA19C42;
        Mon, 20 Mar 2023 17:48:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 454555C005B;
        Mon, 20 Mar 2023 20:48:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 20 Mar 2023 20:48:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sent.com; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1679359732; x=1679446132; bh=n0I3rKbVmW11Ko5MdyrWnLEXy5CTcBBnWUT
        tQZPt4TU=; b=TGOw0K2al2eY7sLD74hzDSD2ANtWUXGox+zhPeiE6P/ZNRvUeRK
        4Q0E1OSDty/ycWijhLtITpkdOGOarjXiu5fjbrQ3nWDAN+QJGLTONr+uF1Q2Uc3l
        Q48w6zo1cQIsT1e/iFjfwnL9rPqppkTFZZ8DR7FAaqythtnQqFWf28twSJ818+pW
        MxoA8/Q1YQGKfE+sRpYG00S3FtH6s2dn1TImcA2bdwUMcy6TSJlcyjawq5pX/rXG
        byesOejoHcwfGEod9ItRRpSOFSr+WvxW7oMQjUxOh8TFlU0NGfbDID/+AwGhAJyS
        kP7Shwv+niUFBCz3C7lngIgEvcg9nOfO/FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1679359732; x=1679446132; bh=n0I3rKbVmW11Ko5MdyrWnLEXy5CTcBBnWUT
        tQZPt4TU=; b=VLrp8OERc6ago/IJ0cIfqE5ueb4bd17BUSOXX+/PiCWaLJcJjyd
        Su89Z+er3PRdhytvTZUnnTTXLq2pxmHZaKWGlhXwDW/j8avGXV1RqvqPsCbJA5LR
        XaSrQJ/kltnPp88OMBoTfnEq4ZIDTD4Uk3aHbzEs18a8DGB4ky8tc5tH+QiWV8ks
        fUSY5GIBk0XfQhIXNIqUOfjkUN+uNz58xYJ4r/9dJha7JCRfeHJ4UP1FQnRI4U86
        Tq+yJY7w7c05XSu+4+cpgPEXo9L9Kn2oCE15QcC/RtukdTvDwenI6RmJuxwC80/c
        zrT0gjqbKoA6/aoyfrG4NIkliT0oM4AxUgQ==
X-ME-Sender: <xms:9P4YZDel7Pu7l617YnAoVHw7lk_oy7bJRYPXifDQNWbEEYRYgcDNYA>
    <xme:9P4YZJPe2yizAJykW197iZZBm5cIau4e5BF9WV796oeYbZGG34ZHiPLZJDZDjkeJA
    W7PF1TUrHD5xT1pKw>
X-ME-Received: <xmr:9P4YZMguepDVytKskDXE9qKMGdG0zINzMQhTKRRo-3T4gnCS1UrD-8RRNfSdr00N_EnlHLm3kjJZFxycLHLjl2_UO_PZTjXbE_jwDjlUoDXs3ThdTXHi31cYrYDd7aY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhhrggfgsedtqhertdertddtnecuhfhrohhmpegkihcu
    jggrnhcuoeiiihdrhigrnhesshgvnhhtrdgtohhmqeenucggtffrrghtthgvrhhnpeegge
    ehudfgudduvdelheehteegledtteeiveeuhfffveekhfevueefieeijeegvdenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiiihdrhigrnhessh
    gvnhhtrdgtohhm
X-ME-Proxy: <xmx:9P4YZE8HUR-F3-Whq6w2fTN5caKk36riB409MWKxA9X681z_Wpu3VQ>
    <xmx:9P4YZPvaKJ3UX3WoVXCf6u_6_mNnPKA7BTHW3J4Vg-z_--Wx3RBb3g>
    <xmx:9P4YZDFbbanB3ZMTxepc9WbhUDyvoWB4SO08AO9rzUmgWx7aEnHThA>
    <xmx:9P4YZFBZsg165cnXvjc9i42J7HDk-6kK35wzA4abcTH_B31gU9qfeQ>
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
Subject: [PATCH 4/5] mm: truncate: split huge page cache page to a non-zero order if possible.
Date:   Mon, 20 Mar 2023 20:48:28 -0400
Message-Id: <20230321004829.2012847-5-zi.yan@sent.com>
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

