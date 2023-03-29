Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4150B6CF097
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjC2RIn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjC2RHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:38 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F7A5BBD;
        Wed, 29 Mar 2023 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109639; x=1711645639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=25kvrOzZLFw61mLSH/q2oY93aAmAj3Hgw8SlB4MjMEs=;
  b=KtWRbJOI6acy0rRbjOMmAEumX87EAm5nvS0s5ieO72HRXyDXCv4RwM9y
   uqpaAaB28976A2hQrJup9huzbnD6439GTusyrm0nWb94tI9aft713+1cb
   DYTH6Gjt4+heF3vY4DSK16QfNas5swpluiXlAfuhuBbsZtvcslzJ66UkG
   Y0f8wOxuzBk5wn9e3C2otG9xtq15/tK+7TdJIYmDdr+5NfjBaVsQoXrMg
   jO3N4mYym9aKVYGBhHloxkMXtopeUjWr4ADQcjfZuMM0o97rOeEO3ktkg
   7n0W5EWRc2Dfs7GePTq02T+EHbL1LMoSbTPMZBXqitOHyQ+exPaWFwrnW
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092909"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:07:15 +0800
IronPort-SDR: G86viiiPcZ6sUazbtrf+tmhlfR7Bdj12A4QMg2YaspEl4AbaCzMeNRR/b8OuD2AESRNP6P927H
 LVwlibawS76WxvCIvzZaRTYLEfYev/C0UbIIFh/IlOIT2RSab7ZNGDlppsfHEmU5ug2QCLupRG
 XsFmEOzndy13LhzXXJavgqFUAlCRh0Y5ATuJQPXfs4AyFfNKGNLODimtHSct968kpXdHlzFHWg
 8bY9a15kRzS6iHmygUlaSjpXuF3U5DmyjtAAvk1sFGw6X/gvk1fACMtB9eSHy7cCvDqWygE/Kl
 UIU=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:23:24 -0700
IronPort-SDR: 8RmI6zmAOTXFtW/2/SG8J8KNZRYzrAFRJ4uNnILqTeeXG066nahjBZoS9n+NN5J3vTZ6r4tTp4
 tgf7Xeh71IvP+ShrkeXh87FE6UCEB3t5gJLO+7c48mDUod+PtEXFK6+gNDb9SNHaMZjGaFFZq5
 oSS15Elmdtz3zYQl0pCPbsA+5iw4KtmRTEhmlTSesmM+hPv3lcg9UKEZ8wbUNW7w/THKtkgzir
 PeuIpe63rdIdw98aKHJN1lP5OhNWW5Tro+ygbZuffnM7QyFj0xiIF2ZERO387ULFLAsv0/t4Fc
 XtI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:07:14 -0700
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
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 19/19] block: mark bio_add_page as __must_check
Date:   Wed, 29 Mar 2023 10:06:05 -0700
Message-Id: <350bd9c62ce575267a2b38625ab767c332429bc1.1680108414.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680108414.git.johannes.thumshirn@wdc.com>
References: <cover.1680108414.git.johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that all users of bio_add_page check for the return value, mark
bio_add_page as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index d766be7152e1..0f8a8d7a6384 100644
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
2.39.2

