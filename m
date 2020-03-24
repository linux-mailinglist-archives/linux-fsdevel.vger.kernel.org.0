Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8F8119143A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Mar 2020 16:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgCXPZF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Mar 2020 11:25:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39883 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbgCXPZE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585063504; x=1616599504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OxaX2WPjILu5cNikxQy4zyTjtHkdQ5wmYomIUWBBtD8=;
  b=fwHB/KQHaYEcS8YiLuoj7dMLy0wXfbbxgNoHwImMqQKuUuhtD3yQQy9U
   sjOjqWmXDokcTMREaNigfspWBZ/Rcfvjvx5Ar7MSLnvSK3bQuRTuAYtCk
   yS2EbKO5L7ysEJQWO3HuASZofYvFReo9QXlWWIPWU+gbAWfjuJ+lgtwwY
   k8TZ0NYi0HiQTC0W0vhyyrQHx6rgj3JVE/m4whCScKXV+5Qcofi/JRtIH
   1am/iz3d5GM5p0jeB8SdRAg+5KfSREwQ9vE1sv4ME0NxqfFeMKp7Ln79W
   SLhBwZKKTZ/gAA/K66Vi9abRa+uZlx+aVrMfS9uoa82gjOaCuMR0vBzep
   A==;
IronPort-SDR: dmiChNaLCZvRshMYYunejiixwA4hRgGyugmAu76yXT1ITeHB4TG1Vo+7UI02LYzzflnm1AF4Eu
 OnUyYw5sPvPsGnHdXeQZzGNLPaxc2P39GXcRlzp8IWz9gvVypCJat/l7C6NQfEB9bGZBEO8SIV
 H4NHMF9ryan0zRR3U4KHGNQ/U2XbTcdFrv9DTO5IMvEL45+xfqwJiyqk55m03rCh7P4+dJDWnF
 4WJ2agwLymACdgLhx6gXkvFO+5OGlVLj/kxg29KztDTVvPT+7cIAp39F5vtqONaMlj2JG37S65
 VEw=
X-IronPort-AV: E=Sophos;i="5.72,300,1580745600"; 
   d="scan'208";a="133371552"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2020 23:25:04 +0800
IronPort-SDR: WGhaM/l3nH3pA3tD/6/ClW+n6MiEAVVD0wrGDi4S2dXn6aGgTm3pFLLcOgciyo9dMQ8rZ6lTHE
 mHbnqObH9TED+ZnLh9cWX4YW5SOUquDcifcz4pBSh2peiSRJgClZtfRo8CmDYLtqF4yJ3SZAvs
 TShyZiK6vdSJlrxr2tr9HqsWt4hhquC/7gSe8l/Upjd4beCvjh6Cwnqgj2x/uSxWCKupcMlkka
 yezcQRqiWFl3wOyiqGbfXGmWQLTNLgoPcLTIwE8yWup1bSFdqgdOTV0QWlE8k/3WnmHC5KizaF
 U9bAv7c2Jwx6JayuLCWqUIfe
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 08:16:43 -0700
IronPort-SDR: +0ENfjJZZSNNvGaLVLMolxz1kjH5brJZPx+S7r3UNzeYFU4nlN9KPC5KfDHZnBtatfCiBSF8TP
 UA+Dnk7FrX5bswyT8Vii3rE6B2e4Bl8/OZ9tD2w7XiPNOFcFXhGxt/md8j5Pzc6mn8VUnTyPCp
 dicTM9k/kgTdgz7i2IbPnRLmkhrmbz0L/C3ksuRr/LpakNgrdHWlUHORMiMy7zno5ELGsivf7B
 49B4vZjhFYppfoWps5R/wbTui1D6NFk7A05uCy99ilCeCkCxqM3G0+M5dTfD2W6XSzkLsNdzKW
 z5E=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 24 Mar 2020 08:25:02 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 01/11] block: factor out requeue handling from dispatch code
Date:   Wed, 25 Mar 2020 00:24:44 +0900
Message-Id: <20200324152454.4954-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
References: <20200324152454.4954-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out the requeue handling from the dispatch code, this will make
subsequent addition of different requeueing schemes easier.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5b2e6550e0b6..745ec592a513 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1178,6 +1178,23 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
 
 #define BLK_MQ_RESOURCE_DELAY	3		/* ms units */
 
+static void blk_mq_handle_dev_resource(struct request *rq,
+				       struct list_head *list)
+{
+	struct request *next =
+		list_first_entry_or_null(list, struct request, queuelist);
+
+	/*
+	 * If an I/O scheduler has been configured and we got a driver tag for
+	 * the next request already, free it.
+	 */
+	if (next)
+		blk_mq_put_driver_tag(next);
+
+	list_add(&rq->queuelist, list);
+	__blk_mq_requeue_request(rq);
+}
+
 /*
  * Returns true if we did some work AND can potentially do more.
  */
@@ -1245,17 +1262,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 
 		ret = q->mq_ops->queue_rq(hctx, &bd);
 		if (ret == BLK_STS_RESOURCE || ret == BLK_STS_DEV_RESOURCE) {
-			/*
-			 * If an I/O scheduler has been configured and we got a
-			 * driver tag for the next request already, free it
-			 * again.
-			 */
-			if (!list_empty(list)) {
-				nxt = list_first_entry(list, struct request, queuelist);
-				blk_mq_put_driver_tag(nxt);
-			}
-			list_add(&rq->queuelist, list);
-			__blk_mq_requeue_request(rq);
+			blk_mq_handle_dev_resource(rq, list);
 			break;
 		}
 
-- 
2.24.1

