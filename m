Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB112FB291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388298AbhASF1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:27:03 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:33838 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388302AbhASFKo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033755; x=1642569755;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kJ/YPi2iVTGzPyZ1PMFgAIrmJoIDh2BG4oTkefPeBOY=;
  b=T+Q0XAKlrW6E3DMQkBkucDoObvqX08cDZpuDtZeySEC7ToGvEApY7Ev1
   Yueo/z/Ws5844y8uQ1ZoO22u+dmOWQPlk8x63FktAEs+AWasXE8XadDRg
   zb7KR1tH5eJlT+LjKc+HWsxHB0tISYmUc/xASHez6UTmlo6HRcTiURJA8
   PuZa+4Xr0VfMwULEwjsZauwkPOmSF2MP+RKYC8kRaeoJcu1aR3yKSxTv+
   w1bE7tn2GoDrmFCHnlSelLnODokQpLww9jOFtEgfbljVegckIqqrhg9S0
   wNrUwxeZ9y5Utsdqb969Z9v81sqnlzX1D6IKoPOZPKP53spJqNGfOPerM
   Q==;
IronPort-SDR: hE6dv+TONUjJrZ/OU6lATn924bydxu0c3mJtRbz0khTwEPau7P5VmEXr7963HPN7qGH8aJfn68
 kZQ14X4AWJ0qzHoifzrSjb1LC8BsRJ0hCM3S86/LCot9M+hV5oou8lwSxk6YsLs8v3VJzhprkE
 PJm5f9ZevTC88KKc50pux+QrXL0BKI9oAgBpneRP0D1aICW9vw978a0x6f1qfn8Qka8fXoUIlY
 zHoVKccVUjQuemq91Fr86L2MLyEOQ5F4QCRjTO8V2aCG89DoW3zyBhOeOJHp3zg1qmckiqd7LL
 HTc=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="261722387"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:20:52 +0800
IronPort-SDR: SLTYcsUI5EUyExv0w0a3FqUvk1wVJiBPtQ6k17TInrm1aQgwzpA5EBzp2Lame0JEyQS6khpDeC
 CmhUuRtc9fs1nUTFOTOrNXa9JSLZMlhxzyvVTJUeiB9ASl8GEQsRWLM3zkgnelllodw/Xvjrcd
 Gl78RF2ScQEyhhZdSLqMCYlCAx3IdnFDh52KP4JNIjkQIifavctZcn2F36wn2sT7jflBpVTiCB
 YBrlrPUCmd4o8kpvTGxtYOLf5HL5ctSnmJhCp5qkxpK0N3ipXnnHdjJ7z1Tf1OqoyL/vIGyiWP
 H0Lvrvy9Yb6BMwhJPBBj58yJ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:52:11 -0800
IronPort-SDR: 82udVg0tcJR2e9Ov1+A4/XxfwUpr6AnnaaUrqXRQiZStYiKcrlpKU0DkZ5iMbm8iZTvQAtMZG/
 I8wyRE90NxZichs84bJgmmJzLP0cByQHps51BWtoql+dpr7gkHTtxNhSfv63hHFg3HLCAOwaZD
 +dt9xs8jlS8ttjdqGabgZ5alJdiHqr1V7WKaF95Pd/LIfmh9EooiqLrIPLv7qKKLiQaaSOFfaR
 3ilv2AB4rQ3+1E1OdOv6+VBj6UNe20rcRhCRm3hgKs7Kn1zftFTr7vNmUA+PXjeDeKmQalWZYt
 Kyc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:09:36 -0800
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
Subject: [RFC PATCH 25/37] dm-zoned: use bio_init_fields
Date:   Mon, 18 Jan 2021 21:06:19 -0800
Message-Id: <20210119050631.57073-26-chaitanya.kulkarni@wdc.com>
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
 drivers/md/md.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index ca409428b4fc..b331c81f3a12 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1001,11 +1001,9 @@ void md_super_write(struct mddev *mddev, struct md_rdev *rdev,
 
 	atomic_inc(&rdev->nr_pending);
 
-	bio_set_dev(bio, rdev->meta_bdev ? rdev->meta_bdev : rdev->bdev);
-	bio->bi_iter.bi_sector = sector;
 	bio_add_page(bio, page, size, 0);
-	bio->bi_private = rdev;
-	bio->bi_end_io = super_written;
+	bio_init_fields(bio, rdev->meta_bdev ? rdev->meta_bdev : rdev->bdev,
+			sector, rdev, super_written, 0, 0);
 
 	if (test_bit(MD_FAILFAST_SUPPORTED, &mddev->flags) &&
 	    test_bit(FailFast, &rdev->flags) &&
-- 
2.22.1

