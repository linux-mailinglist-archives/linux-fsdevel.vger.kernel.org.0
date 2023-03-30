Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB736D01D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjC3Kp4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjC3KpQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:16 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E5F9776;
        Thu, 30 Mar 2023 03:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173087; x=1711709087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RpitYrbMFeR5j8yxFMmc3tnhDIhgkd0gY7Yp5w5KjZY=;
  b=pQ9N5ry0xmRuXE+eOsHj0Xf363suLqYlHbt0HrOnE43dGHP0igxYboEu
   skQEF7AWUCJUmuMtLI//TzFpmx8zW1unwZKnhYkpjIN+QBUpHXtYCKw4S
   a2N5XoXJukVe0AXCWeDbm0LIP2BJhoJE7gQczraQM+5AUieyhPHF/wmCT
   pOY8q3WDVO0bc0fVwJ3MPOkpLc6AUI/FEmvhrjRSR50NGhgEWhRAojaIl
   DegqvuatQG1XktKVgAEvl/ag49Zu8pQ0P6jhNVMv5DecpzczahwPGGUEu
   UkNzNMfhMM/gfJ/FwWlHmj/IcpNvcqaB24ZpLT8FI5lWLVqB2nMaPyUEv
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317832"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:20 +0800
IronPort-SDR: jYSMVzLejmvNweOdpUeHA2/RfftxwXH2GraK7eW0xM4nNs0KsiCzk1d3REuwdSkWn+BTRV66p+
 JJr/aUFOUWQbgKkFTNrak1JUIQ+sgrb4n4B58oyxV+S5LL1+BQJpk5c9HFAmTElvrL+XwBg4Ex
 yMH0TuNZ4TDAtzEzyzDa4tUe3PGXwNz6glQpcybfDb1BnxP5kPQHNa0pFlnuP2OAxxo/1Gwu2e
 x/PwSppJ29OV0d18TQ6+XsfjdSYVu+7TUkgy0JAlybPaXmEiBW6hROq3hUy0DIw+5kC0DriAoU
 ViI=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:29 -0700
IronPort-SDR: +ifl+ssGQMJo1793QyummmYdxHd3XzP9XbjKXn6B6L9A/71IfxQfpv8qYdarzpWEctk4Ql3WMW
 tPTK/6UQPkyog3HY7qay4dpVKeTmP5uIdnwjy4w1mx3YP2Y/toi1PbzB3aslZB5M04afc8o1z4
 yZQbo9Y6NFNa+sXQ/Q+D/AMjunNqR24ybNaqHMPMmSEop2iGUVZ7PeH8+3OU/sv+eDng5CjLZz
 ga7rpWvmqRchNNkmOIEQBKIXfa2Mc8UQommU9tZ/kK5i+Hil+N15boStP09k/34t8fBi6p3L0m
 tHI=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:18 -0700
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
Subject: [PATCH v2 05/19] md: use __bio_add_page to add single page
Date:   Thu, 30 Mar 2023 03:43:47 -0700
Message-Id: <359e6d4d77ee175e2ce7c315a3176ca360e10fbc.1680172791.git.johannes.thumshirn@wdc.com>
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

The md-raid superblock writing code uses bio_add_page() to add a page to a
newly created bio. bio_add_page() can fail, but the return value is never
checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-of_-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/md/md.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 39e49e5d7182..e730c3627d00 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -958,7 +958,7 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 	atomic_inc(&rdev->nr_pending);
 
 	bio->bi_iter.bi_sector = sector;
-	bio_add_page(bio, page, size, 0);
+	__bio_add_page(bio, page, size, 0);
 	bio->bi_private = rdev;
 	bio->bi_end_io = super_written;
 
@@ -999,7 +999,7 @@ int sync_page_io(struct md_rdev *rdev, sector_t sector, int size,
 		bio.bi_iter.bi_sector = sector + rdev->new_data_offset;
 	else
 		bio.bi_iter.bi_sector = sector + rdev->data_offset;
-	bio_add_page(&bio, page, size, 0);
+	__bio_add_page(&bio, page, size, 0);
 
 	submit_bio_wait(&bio);
 
-- 
2.39.2

