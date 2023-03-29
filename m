Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E2F96CF05D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 19:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjC2RHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjC2RHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:07:04 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C756A6E;
        Wed, 29 Mar 2023 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680109611; x=1711645611;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k8CT487ce4SSO54vpXkhaUXbrl//N6dfoaIHSNrZXSc=;
  b=cvjI9T4NpMyGrsXyMKCF/YTUcRswLSHgmPeiLwnshMRYJYfZRx5wcAzc
   x/xWhlKqmtBvGp6UhJzi+b3xcIqQKfHysRNaYJcp3Iu4C7bMh5y4LLMx1
   FZA46EX4RWvCfQpG4d25/Xxno2Dr5zqsxHnY8ZVy29VqsOP+gQpcRonQ2
   VbUctEpEELzigrf/9mQKsmsyg3fGKgG2wMif2xo3/RGYN+W9NFZHVTgqu
   ZhFVGq9eHmrNh3noqwprIRZGnIisq19CUlxrz00eHhTNismtjvQz3CmWX
   72GmsnUBHs9Qf5iBg1gu+B/3yKGhAmoY1XUgBUcAEd9b11O1LlFTEm1nh
   g==;
X-IronPort-AV: E=Sophos;i="5.98,301,1673884800"; 
   d="scan'208";a="225092863"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 01:06:46 +0800
IronPort-SDR: vcvmRrQ4S2B+63W7V4UqEeL03WkSdRSW3imt7pOzXsyDk3TLjtyfxZCtq2iA+qFGSaweCwvftO
 6+SaNmxB0IBqEWRFrm/gwTTC2++upJajw1BBurT3wVILj5O+voyYQoh+jlu8hKQ2nTSt6q0tUI
 GZZxElfT78NzGiFCDkE4wI9WpijvnaebQSoLLIxd8F2Z2mHVvwfxsDRiDzI88zD0JZMqX7snqv
 MFOQeB68w2ZthG9ajIM+vuOXsPc12vYbDNIHmN+2rIuOnqL7kHx9I3xDTo/HIH+obJ+XYlZP5l
 ows=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 09:22:56 -0700
IronPort-SDR: MOOXixcYEV1/J4lyBRhkoD3BrfkuwpVTjAnSNbGauDrQItggC4QoQ11Hy/5dh8cwJqG4TR0IkO
 Lnow8+4PjvklzXGKvuMnewjdhwfoe2RXCWLLrlvUTUex+DEDozd3vEEbQbLHW3vObVIOGbX5+L
 9twd+og8XKgLZTmhzd7AQK5yODOqOEQMLfsU73Gxn69Zp7ZgBbmVcFqWvAs2LM4xS7ajmwhg/x
 f+DcHorKiciGGPhCff17T/c0ZTt7hWf/JGR8UxngNwnUUQ1TMJefX0ET3IFIG0c8MJgSPEpX7y
 R+E=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 29 Mar 2023 10:06:45 -0700
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
Subject: [PATCH 09/19] btrfs: raid56: use __bio_add_page to add single page
Date:   Wed, 29 Mar 2023 10:05:55 -0700
Message-Id: <5ce38530bc488f9d4f1692d701ca7ad5ea8ca3e9.1680108414.git.johannes.thumshirn@wdc.com>
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

The btrfs raid58 sector submission code uses bio_add_page() to add a page
to a newly created bio. bio_add_page() can fail, but the return value is
never checked.

Use __bio_add_page() as adding a single page to a newly created bio is
guaranteed to succeed.

This brings us a step closer to marking bio_add_page() as __must_check.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/btrfs/raid56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/raid56.c b/fs/btrfs/raid56.c
index 642828c1b299..c8173e003df6 100644
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -1108,7 +1108,7 @@ static int rbio_add_io_sector(struct btrfs_raid_bio *rbio,
 	bio->bi_iter.bi_sector = disk_start >> 9;
 	bio->bi_private = rbio;
 
-	bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
+	__bio_add_page(bio, sector->page, sectorsize, sector->pgoff);
 	bio_list_add(bio_list, bio);
 	return 0;
 }
-- 
2.39.2

