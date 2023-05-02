Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396626F4132
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjEBKVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233815AbjEBKVR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:21:17 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3329E5252;
        Tue,  2 May 2023 03:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022863; x=1714558863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rBYMP1Pe8TwSmYGwoyghl6QR/JjrYRcvKJesaYzswP4=;
  b=EkTq4LNV1HxWV8X7LJmw0OFrGtlzIxlMAKAZAZEaHan4cNpLboymLtGV
   9/+QXTZdPhkEyzDseYuEJNv2Htn3pDMei/szv8gatyR70AekjEPKuxQ0x
   54KWTKpFKbzZ+JE3Nu6vwwnTQ0RxIwsBsdYzJN85OLLJQ0bRLxFKUcflf
   1mwp08Tle8ebf+ktbUVc3kJj/8b5Q4WSFLY8U713TdauzoHuDFmG7scCV
   k0cRPbsC+tUIXYmRSg7AV0ZTbwMCCzKKBMRi5PonQxdlOv5LlI8VK4B6u
   REllpqQbOl/l5ScrLsTsmOiZd19jF/2cErtCdZA5IKrA/gtoC87ctshjm
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="341747146"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:21:02 +0800
IronPort-SDR: g8lVVLJBs8uvTYuLAv8YIFoJfXGXbOTEDpwFIhL7vc5bmB/Z06hjYyD+VWYLDA2zF9/Ofj8RxM
 hTksXqV/MNDcbOykE/W1UjaePP8zkwcELbvV6OO1aKWhjTGHizJqVv1iOZjszan7mA+rp/Ptt6
 Kuphivp9v7NWQN5EmJxAbrTGkDLtIoopuxymLWoogh4DXfpnJZ8Jk7r6bgbTXVB2SEbiX31Twe
 8lzcyVVPVMFJbduS9Vg0sLzQW47AlYFScamyvyuA0ptWO9qoQNu7IxFyvHOXP8mI524HuGZscd
 ZDA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:30:50 -0700
IronPort-SDR: SZmZ1SHPv3v95++GFX5GNI6yfBnql83s333Ffj/oLNOQmf9D8iy/39hpJOR20wh2bRQOn2BLgx
 JgK8optZpMM29mBuHDuYbtPMvrfJzCOPOjU1ETAscqM/qXxlIOLWAiI2L9V4G24RfZiHJtRFwb
 nHkwAJfuiGHAeRk1K8JkyFhVzb1twO5S5KKCSXFwkpHiNNZYu9hoApYEuIS5MMXDA41EViqm6d
 CXVhoNk5GYQRyxsfvtCIIoju6VaQTS+kujPXNp1hy/QiGKYe0KkAqZ3LX7HI48Z5fruOSDEpAU
 8cs=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:20:59 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     "axboe @ kernel . dk" <axboe@kernel.dk>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        damien.lemoal@wdc.com, dm-devel@redhat.com, hare@suse.de,
        hch@lst.de, jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-raid@vger.kernel.org,
        ming.lei@redhat.com, rpeterso@redhat.com, shaggy@kernel.org,
        snitzer@kernel.org, song@kernel.org, willy@infradead.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v5 06/20] md: raid5-log: use __bio_add_page to add single page
Date:   Tue,  2 May 2023 12:19:20 +0200
Message-Id: <20230502101934.24901-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
References: <20230502101934.24901-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The raid5 log metadata submission code uses bio_add_page() to add a page
to a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Acked-by: Song Liu <song@kernel.org>
Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/md/raid5-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/raid5-cache.c b/drivers/md/raid5-cache.c
index 46182b955aef..852b265c5db4 100644
--- a/drivers/md/raid5-cache.c
+++ b/drivers/md/raid5-cache.c
@@ -792,7 +792,7 @@ static struct r5l_io_unit *r5l_new_meta(struct r5l_log *log)
 	io->current_bio = r5l_bio_alloc(log);
 	io->current_bio->bi_end_io = r5l_log_endio;
 	io->current_bio->bi_private = io;
-	bio_add_page(io->current_bio, io->meta_page, PAGE_SIZE, 0);
+	__bio_add_page(io->current_bio, io->meta_page, PAGE_SIZE, 0);
 
 	r5_reserve_log_entry(log, io);
 
-- 
2.40.0

