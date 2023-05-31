Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF96717F38
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 May 2023 13:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjEaLyH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 May 2023 07:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235668AbjEaLxj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 May 2023 07:53:39 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1566910B;
        Wed, 31 May 2023 04:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685533968; x=1717069968;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cYPPoEv62NQazrvih94Ycv2rGmT7BOuXvS8lrmnDxSU=;
  b=G1Dea5mHvQYO9y1oBmLBaf6NgJk+hS5jN8tGvJ031jjct6JHJKma2g3b
   arShaYJF/5bGBzI/A2VRV6GDt41sd1ZgF4/ZYtsZqVHc4Yb+V8P9vWIqf
   XFl/mq4aRKZlnFzRpb28y9WuqogTkbpiF0Hm+s/62Ftp8KXqxMOWmuaeC
   3B5bdBdQj6nLsMAguIiD2FmUinVgg8bu2/JxXb5YR6aDpaxh+U0O/KTtN
   tRMxK/NcZKv8WBOo0QQt8GS8Tja0ejOfvqMPdMYc8KQGgvOMIsX2y66up
   J16A2Hess5gDnKrlWB7ZpbENVhl6cyVVJGJ85rKLxed8WhXrqGyCuxpGS
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,207,1681142400"; 
   d="scan'208";a="230207496"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 31 May 2023 19:51:46 +0800
IronPort-SDR: DfeNEk5iIUlk2HD/pWF+HCjMVHQAbbJXRmgWpDIW8j4rL0giL4xbNZDDUk5LUQYsgX70nGdBj+
 VL2UQ8dtgLXJ4W+Qal/R45QEc/8NL56MRW32GGP4vemAkPqWnNCuH1MG6H1fWTJ21FBLMGjvvr
 6u/A1ZDScPhnhLxbqA3yLck2kRudxTc2SWAUX0zetjR570mFMTNY/R14a6i72myRQMzJiks1gh
 MMcAh/9ksbRT0wXO8ybdbaq4cYGw60LOzGKp89xq3oTwl51S7SfmiuePduaCtZfanTM5F3Z4Dc
 kBg=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 31 May 2023 04:06:39 -0700
IronPort-SDR: QS61h54T8yZW50RLo6/tAmhIU9dZKUSaD+j7SLLE6DJcuENXB0nA81DplHQBb61D4xQN5z6YYg
 lyD4dagzoF40PNFlLjzTZJ0Zg7tFZiGl11uz4H1TbZVmBSoN2y+wo62ttaYHvL6KiHjLe0+6zm
 FGyHqtygisbhzUI8rq/fYFXGU3w82UmCTVNSYk+2JCVsdH8VqjYSAJfn3rSnoQGKjalA3DHPXh
 ec/1PSkgm/XAUuzf+dnf+/NfDPsket5c3ZH5oLqRyfJ8DIpHZ5kI0+L0iQDvqE4e97x4r0cURX
 AEA=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.6])
  by uls-op-cesaip02.wdc.com with ESMTP; 31 May 2023 04:51:44 -0700
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
Subject: [PATCH v7 18/20] block: add bio_add_folio_nofail
Date:   Wed, 31 May 2023 04:50:41 -0700
Message-Id: <924dff4077812804398ef84128fb920507fa4be1.1685532726.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685532726.git.johannes.thumshirn@wdc.com>
References: <cover.1685532726.git.johannes.thumshirn@wdc.com>
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

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/bio.c         | 8 ++++++++
 include/linux/bio.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index 043944fd46eb..07bc5139f9db 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1138,6 +1138,14 @@ int bio_add_page(struct bio *bio, struct page *page,
 }
 EXPORT_SYMBOL(bio_add_page);
 
+void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
+			  size_t off)
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
index ea2d937d3cba..f907d75af205 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -474,6 +474,8 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
+void bio_add_folio_nofail(struct bio *bio, struct folio *folio, size_t len,
+			  size_t off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
-- 
2.40.1

