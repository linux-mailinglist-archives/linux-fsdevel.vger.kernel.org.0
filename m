Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 531922FB266
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390278AbhASF3I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:29:08 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34702 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389469AbhASFLq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:11:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033106; x=1642569106;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAA7t74fBBFYvhmmUXL9ltnfWbGOnWjeqm/UNzN2uR4=;
  b=rfxiqHo2Il4cuUpS/2Vwyfwnr+h2EYw5neM0L3rZ4PP/tO6QXAHGinW4
   1E9yyyewXGMZZl6EAFrbEqcI6NYhkMwJ6m6U2O6c15kH4H64IXNnaEp/8
   TcbyqfJOMlBepojasDcmRTA4iwyJKE2fpwK+1iBXJ2q6GDam69Cs/YHTI
   NOYc1/y8RdsF4B4s87AxDNIWQ+UwYqFUpMWpoDrSBdYXRj0QzvR9HmKQq
   TU5or9G3Yq6hki1AIKoaKumEZ7L3b2DKgYGKgXQw63xPXYGkeZMQj45Oy
   wUftI2qwYakzoSliniYS6jGwDniyrty/2S08slSc+dhksvJChbYRGlltF
   w==;
IronPort-SDR: +EeBMaQhit70YY212VnNAf2HBYHVD/39brDoueIcuI2QBCHqQs0R4kZ+c1RaP/Pvk17B3/PZvc
 X1MaIXukuw0WJ9xCVcjAeBJy/HuTrEU7l1NDTzayObdUPMTdIJtjv8KQ5OJ0wQc+qEGO4GU6IT
 /6L43+mXfGICRrxTNk2Z43DHaoTh3rr080ssD4ycVBrxYbD6598TYseg0o6HJ8ihkNcN2gqEEC
 w66YgfM5yotmWp1W+fe8XBwQ/nKfd7wCWe+LH7FeIxx5j33mCNM5SCIZ5iFr5XDSKPFdWUVfY6
 ZB8=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="268081222"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:10:19 +0800
IronPort-SDR: orMjc/tSb01dXK1HklYi66wWdxLkDv9HBfCcvlkdiiN5n+Hbspp8Uz6u0gyZHJVKpvAzzuGLAT
 h6uFmIljQk3kRywCcg4naDEGogW4/pBvZK6xt5QJEC1B0xJJaMqmOb97+vEYD//h6B0DvtiBH6
 npIM52Ogvb0hxlv5aYvM+zdVBbGF68nkvpn5FOP22Faa38lRqd5QC2u0tQNtdiPIcrqOuofOSA
 1u0+jeEinED0lhBmoy87IOkU1XoynSas2lHcuhtYnpoR4dWhrOOVK3sQVyzSo26zr5om9ncTEa
 thxeVRcuOH4WOe0vdQUKcdcS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:54:55 -0800
IronPort-SDR: cPCtUc/IRHJ6v0mRHjS8V8MFIsoN0oL2wMbe6Ozxyn7u6Jlq2FjrgvACBEr/lheyPR/5wD4N+M
 KEDIu5wE7UWz8Cv9qJDWZum4DMbM7mOvzj/7tfqqgYPHbQ1LhSR/PgR8NGyaDkjJQEt2LBkn32
 1OZrCSpTxv+AMTCn8V0WZgKvKOAI/tj1Sffo8uYhn7bxkZYYg0/EqRTNAqMwUOaWkw/9SrZbM5
 n6bVFFI/rd2QJwwAKHXPwXh+bmpzJXrCR4jV/u3YAVKTR0Pw0jMhQst/htFOvMCrlOnknkAxQ9
 MSM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:10:18 -0800
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
Subject: [RFC PATCH 31/37] eros: use bio_init_fields in data
Date:   Mon, 18 Jan 2021 21:06:25 -0800
Message-Id: <20210119050631.57073-32-chaitanya.kulkarni@wdc.com>
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
 fs/erofs/data.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index ea4f693bee22..15f3a3f01fa3 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -220,10 +220,8 @@ static inline struct bio *erofs_read_raw_page(struct bio *bio,
 
 		bio = bio_alloc(GFP_NOIO, nblocks);
 
-		bio->bi_end_io = erofs_readendio;
-		bio_set_dev(bio, sb->s_bdev);
-		bio->bi_iter.bi_sector = (sector_t)blknr <<
-			LOG_SECTORS_PER_BLOCK;
+		bio_init_fields(bio, sb->s_bdev, (sector_t)blknr <<
+			LOG_SECTORS_PER_BLOCK, NULL, erofs_readendio, 0, 0);
 		bio->bi_opf = REQ_OP_READ | (ra ? REQ_RAHEAD : 0);
 	}
 
-- 
2.22.1

