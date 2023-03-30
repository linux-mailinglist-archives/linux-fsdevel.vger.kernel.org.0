Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED02D6D0211
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Mar 2023 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbjC3Kq5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Mar 2023 06:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjC3Kpz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:45:55 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E18A53;
        Thu, 30 Mar 2023 03:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680173118; x=1711709118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WuVso3FIWpTS9t16blIu0lxfhGfBw7QOq0E/ZSZkofY=;
  b=aw0fe3yKjpJQMIjwmMYqwxx2/B+wWSRzySz+rolLQqksQ3wMF8NuLLNp
   WWeNnrYC8UnGuK7s//98156efY5U9oBCX8IbHZs1Q/3xFjKQAhVitBBwe
   EODmfZJbiW5KJx4DJhrSvwnt/VuX9oA6GhxBbB55bjlbzbq1OrfkMsECM
   dD7SfaRb3kcpMC1N+Tq0mhiss/Q9M3NV1vExmit61Ok4uQdWG4e1i1Fj/
   92GYuQdMmtqtNcPbNzW3+l5jc6Iag9Y7C8ICy8EJCsdr97fUKLN8UHPUc
   rGZAYdgL3mjvijv2+KJZuV7oqGyVagMmPEN+ZKm3QlToPjtgglmAH23gt
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673884800"; 
   d="scan'208";a="331317894"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Mar 2023 18:44:50 +0800
IronPort-SDR: txa7F6mHIGLPVhZBTjSCDTv1T7W9r53GQRRCgqs5Fwmm/ErjQ9j5k6xThlRSrFj/6Bh/Zm4zgT
 QPfyrTcP6kQUdgoAECNfMDZTn+NYixNpOyddm67f6HhD6QHrbvaNU4512qYrc3iwSGh6EPqjx3
 zhErg51ChQJXJTDcMLtsCsHaAAQo2TOdP6SzS2EUfmsAoQKPHeTQXboDOrkNQUzvCzHerANlJc
 sd+Ui1okbaorV5F3AGbpufTwTq6o0m3nyuw/HeSPdxC99GpkJw4TlGYNoYrsCw+o4cLJXiBoF2
 T+8=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Mar 2023 03:00:58 -0700
IronPort-SDR: xbv9CWFcSC1Bzpr8BamikP+86dncbp6oACJBXmhmSmN1KLO1tjzjSUny6VIcaXoUQyq5sWcuL0
 lQBuIK9Qs8v6PE4kuNsKWptmdAB94A57UA5HBiwUoF/UZUfY5X3vAWQoHSh0h+S/n670fLweqX
 xwW8OqqSonBv72abzryYNSV2io841vwnNZJ8IY+0p5wqBENYMfSLK+JpFOg4uVtqcWWbcuN9UN
 kEpt44p6/oIeo1ie9PLw+xd46a5i05H2OEhI1oKUgM+t3BiQfepTKLv5GkNzpVe2yAChE6w07e
 +JY=
WDCIronportException: Internal
Received: from unknown (HELO redsun91.ssa.fujisawa.hgst.com) ([10.149.66.72])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Mar 2023 03:44:48 -0700
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
Subject: [PATCH v2 15/19] md: check for failure when adding pages in alloc_behind_master_bio
Date:   Thu, 30 Mar 2023 03:43:57 -0700
Message-Id: <07ae41b981f1b5f8de80a3f0a8ab2f34034077a6.1680172791.git.johannes.thumshirn@wdc.com>
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

alloc_behind_master_bio() can possibly add multiple pages to a bio, but it
is not checking for the return value of bio_add_page() if adding really
succeeded.

Check if the page adding succeeded and if not bail out.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
---
 drivers/md/raid1.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 68a9e2d9985b..bd7c339a84a1 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1147,7 +1147,8 @@ static void alloc_behind_master_bio(struct r1bio *r1_bio,
 		if (unlikely(!page))
 			goto free_pages;
 
-		bio_add_page(behind_bio, page, len, 0);
+		if (!bio_add_page(behind_bio, page, len, 0))
+			goto free_pages;
 
 		size -= len;
 		i++;
-- 
2.39.2

