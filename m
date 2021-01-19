Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AD2FB060
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 06:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389734AbhASFZR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:25:17 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:40896 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727135AbhASFJH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:09:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032947; x=1642568947;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ak2/nt3tgSZKwQ0NZJ3HfvxP0O9v+7+P6nv4xqLM7/Q=;
  b=m1s2gbIBknhTnGkaE/56PR9D4Ueu6bh+cdd8C71X7PcP1zR7ry/pR6Aw
   4JmbBYWl1CkwrYAcqPlbcVyArUlx6WE9xCPfN/wq6/2MGlPj2RoNjg+jC
   rH1UFrkE+yP9SeAVN5M/C+iEqsL7uV8JlYQ9y7tEkw0/w94D+hE1KIeI2
   BeP3ff3HMI4vwaQXovDSEQXFjNYcETt4ce0EMr4R6zpxxD74eJT8ueGTi
   JhzdvyWm/HfsXvZvmRD89XIyiry3MRvQ1OVt+IR5CGbCZFKuPuNm8Q79Z
   dCOPw+YmOnK1cJbxoqbubRJqMI0uwLWcPP2HUGD8xTECjSsWDQDCH4nV7
   g==;
IronPort-SDR: M8kRcD/fKx3rNiqO0AV6vGDoOJtpjG3xS9HlXBnJgIfRMHql7z8jhkDCfavj3LTOSD8x86sL1x
 9S0JQNXFuRalH9zdG5vjum8iNADei6mSQn69Qx6QG+YBI1CnROct/tRRPKXeaq+Zr4ecvZfMN1
 UvV0Z+zi2VL70WuNiXl8zlSAb+jFfSZ/hvSglYsWv+y7rhryu2bV6cj5AYMoupB8wwe14LT66G
 B5DDH+xupkJrsIe9y8NZfNJ6q36bCXmndb/gZo9PE5nKRmuUcNHASzgEXjQJB4TtSkA+vbkndv
 oy4=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157758537"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:07:33 +0800
IronPort-SDR: nyhI/E0a40IiHA6onYCxqfhyOCTJDUiGVTvKSuYFMyylKcAAe+2Aqh5Hs5SZWx2QhoZMsC54A7
 tyn/kTLWd9TwwAlAvABtueqw4KdaycVrYj4BEKvDxl9xV1VjwiH3yAeSLb0YLX9myks0wd2UpN
 g6eXu1X5+gA+PWKxPaeQVObSct7IPdu5thFLzBFhA+oqSSg5LvrDLXU1lwsMjWDiRuCep9BMi5
 H+URObaogQoQ8Fv6El/hR6cDid51O3sIrhBzK73t1dKYXeCyWkX6hppG0/6LxU0WqUcSvE/Xso
 Y20B4SGJHdNvgnJWxT98aiFp
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:50:08 -0800
IronPort-SDR: XuHiYNQi6H/F+p2JRpeqvKepY/gWFggYc3PK+RX4NWnH2J++ktvqaZn+XFm15C5dMKrEJfHz0B
 tcx/8H8EcZQjAkvVLLfd960MjBgFb7S9i+JAaGulJ1Ed6y5pQvCWzQsDBAb4mxWFQRcOQm2sQh
 InLeUCQ8BhpQ0hg7T5JV8TxNze71LOROzEztByIwFHi0muZ5jMuDAa0BYs0z85+J0ujkGowHhy
 B7cEPZDWrY2+Vnoe2urCnxNw5+yxuKbmlE5yr1VYKmzFzJMkDPxkr8LEyEvcKah9eb96VGIlX+
 j4Y=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:07:33 -0800
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
Subject: [RFC PATCH 08/37] gfs2: use bio_init_fields in ops_fstype
Date:   Mon, 18 Jan 2021 21:06:02 -0800
Message-Id: <20210119050631.57073-9-chaitanya.kulkarni@wdc.com>
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
 fs/gfs2/ops_fstype.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 61fce59cb4d3..32506d5615f4 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -255,12 +255,9 @@ static int gfs2_read_super(struct gfs2_sbd *sdp, sector_t sector, int silent)
 	lock_page(page);
 
 	bio = bio_alloc(GFP_NOFS, 1);
-	bio->bi_iter.bi_sector = sector * (sb->s_blocksize >> 9);
-	bio_set_dev(bio, sb->s_bdev);
+	bio_init_fields(bio, sb->s_bdev, sector * (sb->s_blocksize >> 9), page,
+			end_bio_io_page, 0, 0);
 	bio_add_page(bio, page, PAGE_SIZE, 0);
-
-	bio->bi_end_io = end_bio_io_page;
-	bio->bi_private = page;
 	bio_set_op_attrs(bio, REQ_OP_READ, REQ_META);
 	submit_bio(bio);
 	wait_on_page_locked(page);
-- 
2.22.1

