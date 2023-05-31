Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FB7717E89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbjEaLjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235569AbjEaLjQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:39:16 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED7A198;
        Wed, 31 May 2023 04:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533143; x=1717069143;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Wr+M2zDQXb1A/M8JUY7t1USwG0IIo/LDQXKOrkxoR08=;
  b=QPSmGLj14Umt+3nJXZ8456BAQSiUgrlm8nWj6qq9dHF5Bd+4aYhKCs5u
   3trWUTFr9pwl2mnC+U3ORNhBjUFq8rzboGQ27HwHP/9p3wkvL8iam9/x+
   2vbMiAQVvqii+grusEgoU5lYTJa9Oz/7LyuSCBWUpOYuVxzEYd962Lf0w
   o290jgX+EJq7ZFVlzaz7H1gsfK2MrYqWChB9iAjLpvfszphah1AWKmQia
   1ZbRXYU9zpYRCvkKRbD07Vvd75oIZiZ71owHam3cs9FkG61NkKIjeLpJb
   cYDXz9Aw241zlS/aU4kOryvanb2BUi+ozyGYNBlUcACy3M46a0oa8rCRL
   w==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="232064329"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:39:02 +0800
IronPort-SDR: 2eJrV5mqzoxJMjSVUU9gMuleq8O1HZFJnN6rKJsm2cd+phhu70UETGzROceOkWQ7S32+nWndZg
 MOBGXCfzJChUyaINunJPtABkscba3W3vUP/2may26XyqROMbTl98+PGi7uN0Oh1u/TdM8Bri9+
 RaFmU0KNVlDKn6oxOpqa0lWVn8SCBjm2sT2O5HvIlKBGCmvEO4K4el1dzLKpWTu/lLlzZHoIg/
 OMpaEcmlMAlIfV317H9+HUEHjOfhbUkd0Up9nwPzhGgSTMJI5qS3wPHb5Zn6XbEiaGqnoUVwaw
 upE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 03:53:55 -0700
IronPort-SDR: VJ08qUvBBlm2uu9hs/cZuyamvbvzMbT3A3EHWmIRgbc+cJHBrAIYMTdlEWrKhyoITK08FhTkyQ
 l+iw050glHjEt2egUvw3bNuMSsPCNurUyjLrjBgEWsu+M6I+o9MK1gWM8ilhkO5AvnSeE3xR72
 xFoYuRpaKdWSngwzTEoeeTBGfU2C9PVmbG/EA1GYXlSvIw8fo4g1tgqEU2Pl/u9NhKGabl04AM
 c8/JZSOIv+RYUb8wzoM9BYqu5e+KHgwvBnkDL5H+YNbNM1/fbNxj7oHPYXhOpaD+L4rKX6AA1n
 VeY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:38:59 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, Song Liu <song@kernel.org>,
        linux-raid@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        jfs-discussion@lists.sourceforge.net, cluster-devel@redhat.com,
        Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>, gouha7@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 18/20] block: add __bio_add_folio
Date:   Wed, 31 May 2023 04:38:00 -0700
Message-Id: <5a142a7663a4beb2966d82f25708a9f22316117c.1685461490.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685461490.git.johannes.thumshirn@wdc.com>
References: <cover.1685461490.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just like for bio_add_pages() add a no-fail variant for bio_add_folio().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 8 ++++++++
 include/linux/bio.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 043944fd46eb..350c653d4a57 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1138,6 +1138,14 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+void __bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
+		     size_t off)
+{
+	WARN_ON_ONCE(len > UINT_MAX);
+	WARN_ON_ONCE(off > UINT_MAX);
+	__bio_add_page(bio, &folio->page, len, off);
+}
+
 /**
  * bio_add_folio - Attempt to add part of a folio to a bio.
  * @bio: BIO to add to.
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 5d5b081ee062..4232a17e6b10 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -473,6 +473,7 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
+void __bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
-- 
2.40.1

