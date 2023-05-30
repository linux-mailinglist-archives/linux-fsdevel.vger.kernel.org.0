Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D007167E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 17:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjE3Pvd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 11:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjE3Pua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 11:50:30 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA7711F;
        Tue, 30 May 2023 08:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685461822; x=1716997822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8KwDx4F6OBY0YkNe6TbB7WM/40haMFuwXNEas5IG6CQ=;
  b=KBTUT0PANq+YrqjoDqUZC95OIzP8CRi3cnoctS7GlafUzXOVKDFudvvN
   X23XUpWrSslJs8LK6FiZC70L8FO1eHy76zy2qIdkquBrFPzC2GmELCExb
   h1GHo8Ytbxsdps1kFitUb+glsYcdbM0jRGp+9xw8kE4SnQTUB7oE9XDfN
   0HDyvb2qltjOxcRRqT9e9u4ALaNZop/RqXEH38JbMZg9q3pypsAA7SMyL
   Pb97eoq6Q1+ftnPI1EDO4T4C1gS8KIpYEHvmcSCO39amblxOfD0fgzWqP
   i7tHU6oCXtBERy2OyOBo6Dehhnqyyr7l+9y3C19PuE25Yx5qQYyFZQ8Y6
   A==;
X-IronPort-AV: E=Sophos;i="6.00,204,1681142400"; 
   d="scan'208";a="230129872"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 May 2023 23:50:21 +0800
IronPort-SDR: WW6wP5xZmURpU0Ve0M2YSGnd/fH/LEvsAzSqvIYME+ylsAOqxItHUxQnznkUCgTryHPgxVXtmb
 OrzwjJPEGEMSWKNLOaj0/lKI9y704DvP92vviynQ0l2BekjRXes5Rug0N4G2QrkcZkpur9DZq4
 VRFRNRSe9sz8e4v31K8LMNLh0d8hFsrn8J1FrTfhxE5Ru3oq3ZnJK+jMaz05XdKZaPxVHnENNs
 qJSAKF14L1Pq9mIHW13mN+1jV7dx1A3G658YYnYTgcs4/ObvqbtsO/XTFbPSR20kNE8THvxkm9
 BFc=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 May 2023 08:05:14 -0700
IronPort-SDR: eRxexFOpgVAiI/6qc3M2HlLMqG5hyprbnE2P5xkzi3wCU7bzC6rmbI3U41KClPzQrimk3nomV8
 vOG7AELmgo3HFPJEeyzLWnnwIz34HEVY8liiQQjfWPND8wASjp6PauRIZ4LoQjvCc69Za4Fbl6
 m+vZp4/ReRXC7hP9oNIBNf52TfQ/tdnag2K72W9yus3jFs/hvE58IgRrdFN52PYehAVf60iVrp
 tQueGHSyM+3hE4aPseYmzkNOHWMUssVoGCGrDEwV68pXp9pAvW+foUD6P2gQQwUQv2prEnyRo8
 O5Y=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 May 2023 08:50:18 -0700
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
        Mikulas Patocka <mpatocka@redhat.com>, gouhao@uniontech.com,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v6 17/20] block: mark bio_add_page as __must_check
Date:   Tue, 30 May 2023 08:49:20 -0700
Message-Id: <7b1df30b0db4cd34a3c9d66c9c126dccaf2eb52f.1685461490.git.johannes.thumshirn@wdc.com>
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

Now that all users of bio_add_page check for the return value, mark
bio_add_page as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index b3e7529ff55e..5d5b081ee062 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -465,7 +465,7 @@ extern void bio_uninit(struct bio *);
 void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
 void bio_chain(struct bio *, struct bio *);
 
-int bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
+int __must_check bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
 bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
-- 
2.40.1

