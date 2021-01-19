Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF42FB271
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Jan 2021 08:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390209AbhASF2c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jan 2021 00:28:32 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:51835 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389314AbhASFLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jan 2021 00:11:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611033069; x=1642569069;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wDWv58LHKZByyePyDiVmBTfQ0E5jsIWpV0zm9LPXpkA=;
  b=qBiZpaumSDTpkYLLaDKrdIIaENH9awMoOcNQx+qV+IZi39jSFwlBFMKj
   SBL0Wb/8Cd8eo49GUXs0DGvClJMryB1586Xl9Yaf+xbTyhScxNgLVkQfH
   pQaJJgYm1APfbJzqOoqKJuNzm1Ji882ET4/Xg2buLtUnHoj1XfdDpF3LE
   BEipdHIgzYFlU6Kb5gwil/n/bTPl/Z/hsdduUo0z8Fva7F8iyCksWnfGk
   CCtfiHUQu1KsgWOsqZTA5x0xcMiVNiAkfe4cH2kCmnwf7nPrUsuqA+4Ay
   eQw0NjHtdvekK6nF4RXcGLFmkaDAvj5t+52fez2LXfkYG+oTlkxNOwfuL
   w==;
IronPort-SDR: yOKOfYWsY5pvhNiovVDC3nHUDdP46u6zCAoVRLAtMPAlBKuoy6uT5mkhlPsWV2sJJLGcudIsAM
 QlzSHVHQLlyhYL+akfnQ/cyCU6IfTpsMt3+5bcI6d+44dxN1tF0lX6qxGxIPT4WP+HQPkKcgde
 AY4YUAYNfcUU7qJFeTw6bU3pwH2oIIIPpoF2B4Cz+A7gKsAMohlMgMQIWM5TXaJiXEgwPckDoe
 nFi8SqSIwKD3fTv5A2SgPwNFDuLkGvJzm21CPRn5R6l1614RyMrc+Tp/A+cMiVWfL0Xfw9Lfcn
 F2A=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157763947"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 13:08:51 +0800
IronPort-SDR: bQvCPuZFI+aaY4xhcSrkTYVAP+H+T/nZnmXJ0IEqYDNSJ4rjFZLxr0B/CjtmBmF35t5xDh8hZ4
 fW0T4jFym2ovFkxiaBoEjggq43wN03Tx3A5wehqF7pdpRHHIqlDZeOuoWEGtydIg08AuyagMqi
 vJrHcbx+1E0QvxtTky5RRLSrtOaBDf4BwCmv71hlnGg0KLMnFgD+PS141W8c4ATBVYk+qNS/Jy
 hN7ZphN8cRo/dU0Zah+XDotNjI33TlkN8fOGxLttYxnuHdKaInLpZbZ4ZtUD7YUf5wIBNb8+3U
 tgEvN2TKuKmZBSxUcdua5vJl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 20:53:29 -0800
IronPort-SDR: zqmdr8uNSGUFgZ7LrU0GCeEBE+HwqEp3d6yRCc4vmJxwtA/Yo4CFOUY62UCXmXuPUcpvGTrzPZ
 ZvCO6cAymIpMTiIbl4e2oge4VHFzjo0lUvlL/UEVWaUmjNMbvFL6pQOn3IbgBdVAxsKv/xFkfH
 Muc3sg0LIgVa0PCQf7zl6WshjAalrUxlLiYGPDB48hNEN7m0zho6fJXM/WqCYq7SGSNzGvX8Gl
 6TzvHwI3LTXrv+sfDj/IEWvxKvmwhi3VABVseKTOUqh9RvyxCMjwM25iJM4iyI7r5ezZ5UcdOF
 Ldg=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip02.wdc.com with ESMTP; 18 Jan 2021 21:08:51 -0800
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
Subject: [RFC PATCH 19/37] bcache: use bio_init_fields in super
Date:   Mon, 18 Jan 2021 21:06:13 -0800
Message-Id: <20210119050631.57073-20-chaitanya.kulkarni@wdc.com>
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
 drivers/md/bcache/super.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a4752ac410dc..b4ced138a0c0 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -312,9 +312,7 @@ void bch_write_bdev_super(struct cached_dev *dc, struct closure *parent)
 	closure_init(cl, parent);
 
 	bio_init(bio, dc->sb_bv, 1);
-	bio_set_dev(bio, dc->bdev);
-	bio->bi_end_io	= write_bdev_super_endio;
-	bio->bi_private = dc;
+	bio_init_fields(bio, dc->bdev, 0, dc, write_bdev_super_endio, 0, 0);
 
 	closure_get(cl);
 	/* I/O request sent to backing device */
@@ -356,9 +354,7 @@ void bcache_write_super(struct cache_set *c)
 		ca->sb.version = version;
 
 	bio_init(bio, ca->sb_bv, 1);
-	bio_set_dev(bio, ca->bdev);
-	bio->bi_end_io	= write_super_endio;
-	bio->bi_private = ca;
+	bio_init_fields(bio, ca->bdev, 0, ca, write_super_endio, 0, 0);
 
 	closure_get(cl);
 	__write_super(&ca->sb, ca->sb_disk, bio);
@@ -402,9 +398,7 @@ static void uuid_io(struct cache_set *c, int op, unsigned long op_flags,
 
 		bio->bi_opf = REQ_SYNC | REQ_META | op_flags;
 		bio->bi_iter.bi_size = KEY_SIZE(k) << 9;
-
-		bio->bi_end_io	= uuid_endio;
-		bio->bi_private = cl;
+		bio_init_fields(bio, NULL, 0, cl, uuid_endio, 0, 0);
 		bio_set_op_attrs(bio, op, REQ_SYNC|REQ_META|op_flags);
 		bch_bio_map(bio, c->uuids);
 
@@ -566,12 +560,9 @@ static void prio_io(struct cache *ca, uint64_t bucket, int op,
 
 	closure_init_stack(cl);
 
-	bio->bi_iter.bi_sector	= bucket * ca->sb.bucket_size;
-	bio_set_dev(bio, ca->bdev);
 	bio->bi_iter.bi_size	= meta_bucket_bytes(&ca->sb);
-
-	bio->bi_end_io	= prio_endio;
-	bio->bi_private = ca;
+	bio_init_fields(bio, ca->bdev, bucket * ca->sb.bucket_size, ca,
+			prio_endio, 0, 0);
 	bio_set_op_attrs(bio, op, REQ_SYNC|REQ_META|op_flags);
 	bch_bio_map(bio, ca->disk_buckets);
 
-- 
2.22.1

