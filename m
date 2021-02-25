Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD38324AE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbhBYHIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:08:21 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14053 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhBYHG6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236818; x=1645772818;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jQtuXx/YWUBZ2KrGbVMjGytKIm6+oeZ85JzwEpRZQ6s=;
  b=RMcC11J4QGiUJjlcSsZWziJiG6br5rc9LFPX1r3HLCdalidwwSjSP0qp
   1FDjDdDuP3fAhTQpRxD8O5x6PXhPGUS73nbzdA3u0T3rAGhuTIIjGX6KV
   0oWqQGYKlRn4Lb0fR3WQKHFkzb3GHCNimiW7hW5B3aUA85iL7gAP1EpHS
   nq/cavgC+Mg7qXMHyl4BQ1Iukt7jWgyPPBL+nIaypijtpQcKtZglnu1gr
   5AWD2lHCYDVN2917l7YTAAcTLmfSpMdymrEZB3BE9xgRn6ZJioZ6DGtxV
   Q6W/MDdovwUSE9XL2KuWDSfndCne5THADPCkWOyObgXe9qvbBG4/YNC2l
   A==;
IronPort-SDR: yGMHvftYHSAzi3aAZrpaFr/jUz5QM/7Xkybeusk8mk6Aw0wV0TaJ8amKvQysOq1s54RIX27nib
 sHYvbDnlowkQnGjuYEeSauvCUyxZfOw8vMcNGW78heOtrjXZt1Ab8nM3ulDXSbN/dnj7pHISoV
 YBsqbe2EOeYJT+smfD99qIm/0wfWxYJ+dof77+/4KgZkozvk0EBnQf1NR/K/bKLsd9xZXK7oot
 0XOI3WRK4x8iWWdrhyDqJC5Q5KZ5byddA9bP/DC6h4nwb67a7V9HbnzlnZNuQYDpMvTYQLZrcS
 13o=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160751810"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:05:28 +0800
IronPort-SDR: Bq2Jvkks4Sj/33ulqaF0JgVNav71DmhsrM+EGw3uTjhFW56diYBv8avafFc606lNQ6vtlnkkgL
 jWTEcXzVGXIZx24UM6Mv4mUHe5iPOLsHXhf7Tx7GpXXpcUz5SaoEe8B+6e/QXSE64Pq+82eGZf
 kuAqdJ9uQp1S7pararmMhyqHZ3djNbv1XiaWgnmZ+Pd038/MIIDqxIjlmAz1OEY49LuwHizUJD
 zmsUzR3aUBJcHe7TA1OEkA7Dsq+ATFb5rg6zEQnu7oIQuQQmSBR+9El7rWymL/Ia03pA9IygPm
 DPGKkK9fjWpZ+eNG0U2C59MJ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:46:50 -0800
IronPort-SDR: u9ljBbQJbMqX/PM1h2Z5iB4zff1WM2NCh77DrvDv5b4cZ6VN35ztajy0/LB+pY7zeBEVxYFUZV
 fT0Mi0wBo8y5nd9g2K2L/XVJUE6K/ScSYqvJq05iAdzzPaeYxyhOIPbcSNxOsWoAoqCqmDnWZd
 xTsjMcBV+xK6Hi0jZXzaqboxPkWWYW80kSMBlOE8giILGcL9b5YjNxjDpDKEU0NxP1uVDBVPs0
 riX90YlDLwjGaQf5hdZEcNhDIjc+x5P2eYMLdwfmLq5SwyK7CH8HGmv/xFHq/2NGdKvAllqtBN
 LEM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:05:28 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 19/39] blktrace: update blk_add_trace_getrq()
Date:   Wed, 24 Feb 2021 23:02:11 -0800
Message-Id: <20210225070231.21136-20-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 45327201ebf6..51c10d86aa92 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1394,7 +1394,24 @@ static void blk_add_trace_bio_queue(void *ignore, struct bio *bio)
 
 static void blk_add_trace_getrq(void *ignore, struct bio *bio)
 {
-	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, BLK_TA_GETRQ, 0);
+	u64 ta = 0;
+	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
+
+	rcu_read_lock();
+	bt = rcu_dereference(bio->bi_bdev->bd_disk->queue->blk_trace);
+	bte = rcu_dereference(bio->bi_bdev->bd_disk->queue->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
+	if (bt) {
+		ta = BLK_TA_GETRQ;
+	} else if (bte) {
+		ta = BLK_TA_GETRQ_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, ta, 0);
 }
 
 static void blk_add_trace_plug(void *ignore, struct request_queue *q)
-- 
2.22.1

