Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B747E6F4181
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 May 2023 12:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjEBKY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 06:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjEBKXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 06:23:52 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C9A59C0;
        Tue,  2 May 2023 03:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1683022928; x=1714558928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Td/xHpC7+cd6575Kox8h68Aq0j3mdhGpI0NO3tgGxpE=;
  b=aBuGBjXDWBektK/SwrB86ZIE+DSOBcllX370cM+wAbrWUJg8zUYQKy0Y
   hI2wC+BN/p3+vwhKsX9jE2+qsqyUPDN54ERGKwNnvdOAiz0evjWwru/B3
   kCvVjKqNI3545QBZczdC1WGr/FLY7o6+3VpWEv8Um8KF5HQ+nHwrcIe46
   rgqxFfkFvUuUTnhkluJB6dcq+vUn8fdaPacjvz/aTdzmBzuEe6lO5+l8y
   z2IVYrp+e/J0T2B/meBmEtM1gu0GWTTCw0cY3mCaMAhjtUGxnZKVNrhZ1
   tv5ip+jnifnfU+UpWB9uyRhg5FxA5ngjiBavgLVBEKnyzBvlhXJMbQ31f
   g==;
X-IronPort-AV: E=Sophos;i="5.99,243,1677513600"; 
   d="scan'208";a="227916349"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2023 18:22:08 +0800
IronPort-SDR: uASepkeirDzYMScGcNcoGP1Z0CQqKHWJMMdo8xgUV+f4hK1zGOR/OQu76HxsOPMkWgCCw2CFn8
 5Kd3n4hcCnanxZIQ4H6jKa9tpv2ZgUi6GJm+E9/62EOc19rzggkG2+WqQfNNHbmnKMd5z5D45D
 h/IuDL9e9nhiQ/aVZs8FJ7cT+q0PvvmIrstvGb7Zuz0YsnEQ9DWcxzcv+SuiSl+Fn259cVnuQE
 Wb60HlmxurcKnGsN0L9fpeRTdTuAIn7fxaUwmelJLSQWq74iawlYEVCyeg9VGjzEWK4FJu6H94
 KbA=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 May 2023 02:31:55 -0700
IronPort-SDR: Vcxt7Z41NExxCvUESz1tELNOOoVAmCt8KMe9S2wfxXY5MtctxeNwByBgzDDJWsrhCsj1BHWV0Q
 ZGiNQRrLC1GqKKuIRpNOC2Vb5K9nW2DMjlmAKUuOtSKbHa7NR7aAFqUudcN/yAoLh311Vt4cBL
 y00A/34+CNpVnLGm46O2cceVC9lFxIP0NOPuIkoffYDZmLB2WN+NgV+aYC3+VTf4qWL5CbSVPK
 XjePJIBx125icTf/AqdLDhEFFImtpkj2dXIQOUMatT77zeeqXyuVF+60VJakWBDYsxQwY/CpIf
 OkY=
WDCIronportException: Internal
Received: from myd008205.ad.shared (HELO localhost.localdomain) ([10.225.1.100])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 May 2023 03:22:04 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     "axboe @ kernel . dk" <axboe@kernel.dk>
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        damien.lemoal@wdc.com, dm-devel@redhat.com, hare@suse.de,
        hch@lst.de, jfs-discussion@lists.sourceforge.net, kch@nvidia.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-raid@vger.kernel.org,
        ming.lei@redhat.com, rpeterso@redhat.com, shaggy@kernel.org,
        snitzer@kernel.org, song@kernel.org, willy@infradead.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v5 20/20] block: mark bio_add_folio as __must_check
Date:   Tue,  2 May 2023 12:19:34 +0200
Message-Id: <20230502101934.24901-21-johannes.thumshirn@wdc.com>
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

Now that all callers of bio_add_folio() check the return value, mark it as
__must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4232a17e6b10..fef9f3085a02 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -466,7 +466,7 @@ void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf);
 void bio_chain(struct bio *, struct bio *);
 
 int __must_check bio_add_page(struct bio *, struct page *, unsigned len, unsigned off);
-bool bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
+bool __must_check bio_add_folio(struct bio *, struct folio *, size_t len, size_t off);
 extern int bio_add_pc_page(struct request_queue *, struct bio *, struct page *,
 			   unsigned int, unsigned int);
 int bio_add_zone_append_page(struct bio *bio, struct page *page,
-- 
2.40.0

