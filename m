Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACAA86D0209
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjC3KrP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjC3Kp7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:59 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CCC9EF5;
        Thu, 30 Mar 2023 03:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173121; x=1711709121;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9YnFTpWsIBbNef/OiYe0uKZ66yfnQqenOqdfFhTWuvw=;
  b=iGMu/L9fgOtfibbb1VDb+c5bVNJyPDUAIlLuCPl/SAuPEttkaJpYKSCW
   VEIoIlmbgtDpIBh0IejCgxxQY0knILwStNSiwoLXwlFFWtwzwds36sJkv
   bUaCyXaUOrdcoaTaHfOMkYAjGWPQzIeoSgMnzhx5vicbeEysGyhx1xdT5
   YUaOq7f9MqkZJbzU5BDBo1DH8EDRqTAQHpp9MJ/MDVcSjQkv1SlR4gelU
   m/fxwrs/zWQweACbzMxZOnlqsTgsgzPYAdpnDdBtLSBgY1+z7tvkUJs5P
   E3og1lcio7n/1xq/AewEdPRvNkjNBZKqGpHWFHldu1W2U2ZIY8zdkydm5
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317939"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:45:02 +0800
IronPort-SDR: Oj3XXvuBoG4EbDpmh92r68PyzslfXegh6DwzwZj4SRi1waK/UBUGnoEEyc/9qwgY4UqCrH8tm1
 kxn9WTp8ndvKgRkRtHPJNqUnubk3ATXb9bcK6TgUVBNLr/OUEVq5K8vTvsKpIpn1IN80DpZA1J
 xNPa926zmR1wVfbGX8EZeFMx7nGXBdOosBUcC0PvUN2+mxdgHImS57At5QgxiApRYSiF4R3EcI
 7s9cKHx55R1R/vmrAi9FHsJYeJVxddBfjY1GypsFHXCPd0T2s9EAARIaTqF3y3IDG/bs+bghQL
 W+g=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:01:10 -0700
IronPort-SDR: 9/iVByN1BTBiF+2N/dyRq0R7dQSPqShiTdspahbVYlwZj+qd277O1HWwqfoLFDxzoWSe+cmGNO
 qkqMCZzgrdZnDhpQxYdEe8150myn5LsK8KEx5pL72+ObD0hqMaaHSizvdtrMKOqlTNP+VQELhc
 NlTnbrlHYwL6lfM55WWo+X+nqbpVvrNh8MXJJfN+oROGcrGXbtZ95QXnOLEHZI8U/WSie1EYFD
 ciM8A+htMWi8T8Q2A6kN9QQtMNJHy+EVASUqPt+O4sCYrrpZ40AnMpPDuYxlZJyUb2MJgf0HsW
 yDM=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:45:00 -0700
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
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH v2 19/19] block: mark bio_add_page as __must_check
Date:   Thu, 30 Mar 2023 03:44:01 -0700
Message-Id: <981a2b8809dedbd6dd756d7af1df4251944f42b0.1680172791.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680172791.git.johannes.thumshirn@wdc.com>
References: <cover.1680172791.git.johannes.thumshirn@wdc.com>
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
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

