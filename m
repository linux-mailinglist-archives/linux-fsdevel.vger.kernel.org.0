Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11AA6D01D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjC3KqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjC3KpT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:19 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC9D86B4;
        Thu, 30 Mar 2023 03:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173096; x=1711709096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kw/gd8mi4cp3C+0+JmkC18fkS8wJMSIrrh7WtKkZNvs=;
  b=ZO7bQcqFZlTxhjHpBb1YdUsdPFShgOLUZfgwMKoWDTAlkJCYtaxHG1cz
   m58HPiprakXtOLt1ncCHcErC24G4+doEwPM/cErLtgiZofryT/Vjibiev
   7IocoC9fFXAFmZj4o8UeCfnSPHMRgx5fG46eJ+J1B8mFB536kdTL3w6go
   YiQOsf18GYn2RbXuPe0Z5SeLlaudHT+5a8t9DaA8yosHwk7SMBpyWo+lZ
   lbqYUWTs6V3Tsw17LGwtffAasBm6+d5le70Mk2BRffyB2tdQnb3FNi8/p
   DgpMKYqixv1rNfFo0SIzn72+0rTjRip8rYmbAZ+4RvWBaKpViFVQ1eP7F
   w==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317836"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:23 +0800
IronPort-SDR: zWrmNslAH9mXoPhIO1nfSD3+TZtK6ONNAgznD4vQvxcbBoSrT958ozDl5DBkXLOlSZlfkM+QWQ
 LpClT/e19GiIuAFN3jGrm8WbKg0srCBIDAotrSZcHJw0xOqQxVMD664iPNnvEfCE/yECHzOs/B
 TWT4j6CYcY3+u3QadLCLF2gIligJS91KoDBO7TSW2w4LY0DzOvTJH6gFgtWDpNkaCJjDP7VlnG
 /DRylOyYWB2s/hzTTNmDHTe1Sn1paZXD6qHPsBu40tqcN5iC5v78pHECWL/B0h7UwsYNDTpD0/
 dAY=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:31 -0700
IronPort-SDR: V9njnv+t+GuKggx1vZa0T1MyyD/4iSSXEJKOary+Bq17fidU3Wq1CXNYZJCw9uLZGgQvn++tes
 OUuz4YBad4EEj5SCwfzseRk61pTGeIXQTJ8sWWZ6C/a6IojWDHpOIMFR1kBlWwqA9+1RZimaU2
 9ugMrtf5vwEtfAfHMV1SAmH0gL4ClOl0L1H4690JPAzrH+EYrtPzKQsIBiaqdN4IhpHVhohUHn
 t7AtVhCoScM7RNoNSFn3XL939XSpDOx7ZCfy1+MZ2oQUID6IQmdyOsZrB+CvmCXJX8/vdquFwu
 xWc=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:21 -0700
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
Subject: [PATCH v2 06/19] md: raid5-log: use __bio_add_page to add single page
Date:   Thu, 30 Mar 2023 03:43:48 -0700
Message-Id: <d406d7e205f7c7e701275674f77c7e21b93ae7a5.1680172791.git.johannes.thumshirn@wdc.com>
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

The raid5 log metadata submission code uses bio_add_page() to add a page
to a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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
2.39.2

