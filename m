Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBCC324AE5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbhBYHIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:08:25 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54936 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbhBYHHE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236823; x=1645772823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ZNSnX34O/Mc5WZvA9o9dHyoDcTUtK8C4J4M5hfGiEo=;
  b=lgBlGxlCVnrxS9aVNxiwUzd2eZZuKXJh7uIJWB8o3TCPQVT6LYWm8P4i
   CNqnvRzgOJRXh10wM7YgLoh+Oq7PUJCqbWjkpDmZ+68+OZ10xuvCrjqzf
   SLdRwM7LcQj395Zp3QBIyNJGvgUZ8+lAFS6uTUG1lEzLEiThGKvg2CA7s
   WlHwWWjO9FL8hevEUV3VtctOkLRdI68lm4hLzyfm4/o/tPyfin+IbtQVo
   BmJMNsGfy5OpjWRt4uwudyLFga/dB3nQQkqXoDlY8BxS4Pv3rIVPGkcbO
   PIc9n9FDGizsdaEpOrFzPgV1M99NZssDseqL72+VP/6m10M1nBiVovhL8
   A==;
IronPort-SDR: tJ+vw+SMKhYLzCAj6bY2OCbXgTjoJF+jPGeOSQ0uNJbU7NbkFAXGBuYPJtJN09ifKkSVNoANvy
 twHc/Ry+/n5dnjaNJxIs/K+gEnxYk5wrB2dXlDhm0RzoxMXGqSH6v0Jjqye/ZWpBEC/l9i7SIK
 5zDS31yqzop/ru4GXUyxB24LzwVqQABT8XboBJG93txioce4bpNHwbwNk0b+6olccFqFpwmf6X
 iqtG9dPujboxgje9H5Iz5o1tgekaxedm0bD83GmM+DAisrehCCntOwJnGdVrb7BsaGh0mUD6rK
 D7I=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160777982"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:05:52 +0800
IronPort-SDR: NoGXjhA85w+FFkBTK+coLSZft+Itvdq/ehOBd6lrv+gWo21XMYEfW3sqZ+TjsB0POArL1L1ULY
 xQ7r7h/mrOos9Mst6ypBH8f6SoFh+wBqYhOAOoBXSjySMgyUMwH0fj0+d0ovz4s1wWvDQY7Ww5
 do85GQP+ZUY8FM3VA+Ew1Wa33s9xG2iCmm8eC3whO/Sb9nbF+AL4Y9EIzyHo4lTYGqpqZz+W4G
 0FOUvPDG9QsFg+d/C5GstOb9gthpPznXoeXrNelqaowHcA5KS647H0QT8GVd1yxD4H/GslWBuM
 8aj6NTIdCtrJxO1t2rrIBFzH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:47:14 -0800
IronPort-SDR: rVpBaMxkvVtFW9lcfZ8I2Jiw21pOxBS4P9vCTczYyypcIkG5CSaYzgDyWtQZymKiYhrgmAabUd
 wYMsQaiL8JtoOgEx4siiaWIfyXB/2JJM5IC8+ZrM38t//eqMYmrOQbHsOrUBRdcOrK79811xxE
 DrJLb1u2lIRapYRvTAGW4C4LbJtmwsHzQ8hmm55U+aQco8wNyYJ1lxD6Mg1yVTyAO2zMDUpXOL
 JfGBP1RVM0ZhbxF8lgLoVOxXxaGz0Wub1lwDT5rd0Ft7J7b5IDrp4e/I+RgiA90LDOvJpkWEF5
 Xu0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:05:52 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 22/39] blktrace: update blk_add_trace_split()
Date:   Wed, 24 Feb 2021 23:02:14 -0800
Message-Id: <20210225070231.21136-23-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 kernel/trace/blktrace.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1f2857cdbcee..35a01cf956a5 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1471,18 +1471,29 @@ static void blk_add_trace_split(void *ignore, struct bio *bio, unsigned int pdu)
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
+	__be64 rpdu = cpu_to_be64(pdu);
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
 	if (bt) {
-		__be64 rpdu = cpu_to_be64(pdu);
-
 		__blk_add_trace(bt, bio->bi_iter.bi_sector,
 				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
 				BLK_TA_SPLIT,
 				blk_status_to_errno(bio->bi_status),
 				sizeof(rpdu), &rpdu,
 				blk_trace_bio_get_cgid(q, bio));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,
+				    bio->bi_iter.bi_size, bio_op(bio),
+				    bio->bi_opf, BLK_TA_SPLIT_EXT,
+				    bio->bi_status, sizeof(rpdu), &rpdu,
+				    blk_trace_bio_get_cgid(q, bio), 0);
 	}
 	rcu_read_unlock();
 }
-- 
2.22.1

