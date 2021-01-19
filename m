Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9A22FB417
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 09:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbhASFYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:24:15 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51850 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbhASFJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032947; x=1642568947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tRNHR3soK1Jmg8jV6+zLlFyC0jOJz82j7hH7LUdTG30=;
  b=SUBxOUzRpN/eWA9GuUXm5TAlquAPo4chsvDVjkHZkJUI5YdBrNeez6+5
   T3y0IfC1Mze90ctzZLxnkMAjP63bw7Msc8WZI8kIlQmLpRkCo61i8B5gT
   FCPY7vgiZCZfNym7Kbq2k1lxNlaqX2zBjUrEQUh8JxHUaMo6dkVEwHg9C
   /yGF3TdwSzLxhj+Le26smHah8onyqO+AnrDeSFhetbfS53fbsk0D77rus
   RImcLa1MQRxAuuwnEbniCkIf4Nj3orDihEfXA2y3LW+GtA9KntTBejT25
   NgOZahLptLTxAHBkhg+YOtosIBrSBiNygz16NEmX0zEl7oTlygskNNhhO
   A==;
IronPort-SDR: t19E8mQNDzsUI98N9lnM7JqK5MAKku1NGflhk2vP1M4F2gYttuENMakfCeVDIq6bK/5jUoubrz
 +hRi6aVBzsgSVR5fqU45+I+ZoWcCk2Yij9XKPIKFXtni1g1f8EKpO2jwQpTcleczd1Hx4y/VVX
 SNtP1S3vbKo38vlFCx33y7Yl78ZMS9yuCWLaUA1QyrloaUlMbu+KzDebFea7WycWRvOeDlCGrJ
 2noNcs+wJs7ruzoA4sSgI1BRJI+Xz6yTMaZvqlX/IipRbHXIaBn1kH0qVJI7+xpcNnnuvhHreD
 YdA=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157763798"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:07:11 +0800
IronPort-SDR: 0cZ7aUTvZSBIQOWf7btJOokufcDV6Aw2fe6qt8TEh5bo0HI4AnmqS5FHqVW4Q/ODe7cZi5a8kW
 kWSrySg92vx2U3rmWxgmk421gL7RyNyHLrp/dm0P8edhq2fhxJutmdHPfpOYI5GTdXXbY8EC33
 V3M0SXa/9jxII7uv9E8iftF6WdDLbQpWOxmq5JZ2hIcfsBRZH+bxdBTnmoc+lD/xpVdTZV0YLI
 sLee17NOB/8xBXLv6UnbOyymsQTsCbDUOjwnF1MthWYEur4s06NCgmhBGBUMVHCw2bK1qiaXFP
 yV3gPVM2JagTkdGYbv11BFRx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:51:49 -0800
IronPort-SDR: GDd4J6YTFP8HhrZnL/kPcBPBHOjVMkqjgTSYePXIN1p6VjbBUOlt/t7knTI78j01lupweBVXBE
 Qrf/3CuakDKuhfZFB9YorM1NE5OYf/fNye+BAXuLpvEgn+mQDBn/ePyPBWiXAz5XnISDPfEpam
 WLSsiz8QPhiv+mHlZ3XmyQpDw+MKe+Vz4c2sB+5IGEUQ1QQKIMcPMlMUElLMqb4wubx9smdtxD
 /qANSSO3eFYpLv+9iWpFZEjNiZX8CfoH3PB920NT0je34xsn6+9qoX8nDurumB5w1MB8IpLJkr
 gR8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:07:12 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        cluster-devel@redhat.com
Cc:     jfs-discussion@lists.sourceforge.net, dm-devel@redhat.com,
        axboe@kernel.dk, philipp.reisner@linbit.com,
        lars.ellenberg@linbit.com, efremov@linux.com, colyli@suse.de,
        kent.overstreet@gmail.com, agk@redhat.com, snitzer@redhat.com,
        song@kernel.org, hch@lst.de, sagi@grimberg.me,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, clm@fb.com,
        josef@toxicpanda.com, dsterba@suse.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, rpeterso@redhat.com, agruenba@redhat.com,
        darrick.wong@oracle.com, shaggy@kernel.org, damien.lemoal@wdc.com,
        naohiro.aota@wdc.com, jth@kernel.org, tj@kernel.org,
        osandov@fb.com, bvanassche@acm.org, gustavo@embeddedor.com,
        asml.silence@gmail.com, jefflexu@linux.alibaba.com,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 05/37] ext4: use bio_init_fields in page_io
Date:   Mon, 18 Jan 2021 21:05:59 -0800
Message-Id: <20210119050631.57073-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
References: <20210119050631.57073-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 fs/ext4/page-io.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 03a44a0de86a..53a79a7aac15 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -400,10 +400,8 @@ static void io_submit_init_bio(struct ext4_io_submit *io,
 	 */
 	bio = bio_alloc(GFP_NOIO, BIO_MAX_PAGES);
 	fscrypt_set_bio_crypt_ctx_bh(bio, bh, GFP_NOIO);
-	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
-	bio_set_dev(bio, bh->b_bdev);
-	bio->bi_end_io = ext4_end_bio;
-	bio->bi_private = ext4_get_io_end(io->io_end);
+	bio_init_fields(bio, bh->b_bdev, bh->b_blocknr * (bh->b_size >> 9),
+			ext4_get_io_end(io->io_end), ext4_end_bio, 0, 0);
 	io->io_bio = bio;
 	io->io_next_block = bh->b_blocknr;
 	wbc_init_bio(io->io_wbc, bio);
-- 
2.22.1

