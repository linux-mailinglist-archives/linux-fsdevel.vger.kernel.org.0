Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23C66324AD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbhBYHG5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:06:57 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13098 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhBYHFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237261; x=1645773261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oCu3+kNWbsW2ZNvShwFNhd9xthlLzpeD0o9Ug702zLA=;
  b=aUYfqxm5ElNMRX9VonJ/8ZJEe0VpHiUw2Ujop9DrX2VlXvJyNuvPQhxP
   UWaseu3wn/i8IdBWLIh/fMnW+2Lo21V+IEVAlWUxM4o+hHqxyK1oU09d9
   RbuIPXp/ABwCTV58qryxg6QkAD4lSPjboinI21sqmiI+lI1c7ydybEZfC
   iTzPksTYArcJ+u/g+PjwsIGGMlzRU+/ckrWpBVIQ2ZdLVNAdJT/qwBvKf
   LBvFFs+gz7SN+PY5B+sEZ1Dh8LjtxQI+EUjVQSoR8xltdGu2hScz7mcfC
   07CCkpVm1EAQIiyz3G+57ab1eE4pbBhoofBQx/SvzpCX5l9x5GzPb7JAd
   A==;
IronPort-SDR: Q+dkk34Zc4w2OV2u3FNywpJsNBcSQ/REtYCu+/negt6RD9DFhsXUxJRJLdV125q+d6FGYHq5nF
 DC0uSjBTuNZfZgEIrfDEBm83zWqSvbS+rVwqPtAl35HUbWbYTS4D0YJLFgF/UWjFYXVXMqLZLo
 zw031ukqsGMPPf5FS1Caot5cSm3CFKqqF+kl0JnPPQKr9nkr+MUD9b1UO/2BYjvcBQuica6I/g
 eXb/SDqqUZLCAR5msVs2pw7M5c5hMPhh+CitstFeN469Ls+z6DhkjgV5lDUeXwePnjT5DrwJnl
 SGg=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264978876"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:13:06 +0800
IronPort-SDR: MFLFIMLo8QsX1IknvU+4uu7t9LH84ls9VuefsK/yL9m6pfTM0KQlYVoaYsIeetmVsz97B0mrM9
 DekNCogVXv6QKo23A/2M7sXaGmaK8ygAiGzbAdV8eZ1hYq+NaxJ2UOpP1iLRcvyqWZRxch1reQ
 Eub7QZDQzhzwYfNVBBfBpyUa2zo3bjMApNny91pv5q83AtwTZRGh11on4KFBI8mux9MNM9dzwZ
 oUhjiejTK0Tq8SenPidcfz/nQNaKVQDZVj8xjV8GYzY79ieDTdio47+HCrkK3m78YxinvCxGY2
 ANZxYsnbyk8VtS3Goq52WkRu
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:48:05 -0800
IronPort-SDR: WcQGSHilogCONek1dvPeaTZ+NSX6ZsQpzH7zXtz4o78vPCAIOvdh9BGJpfmYDZCj3I/HuvZv5l
 j2afCI6Pgo+cysftS/CEWeNDd3kZ4aE3j7wBDRQ/k5RWFp4J/lU41LjcjX2Y8ZLi6d2Fs+4k/u
 Mun8vCjNBzgXaRbugeggqBNZ62Z8Ta4by3ZR3Xkl7hFRjQ6nvcsj2wfjXYBWRii5tIDZR4nHTV
 40PriSHdrHwH08V/GGoOm3cg2t9+ZQObMMeGpO9OLzu1V7SPRNYTNu0xcAJhharAvCiOwSCLnA
 vNI=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:04:49 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 14/39] blktrace: update blk_add_trace_bio_bounce()
Date:   Wed, 24 Feb 2021 23:02:06 -0800
Message-Id: <20210225070231.21136-15-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 14658b2a3fc8..d4c3ae0f419e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1277,7 +1277,25 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 
 static void blk_add_trace_bio_bounce(void *ignore, struct bio *bio)
 {
-	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, BLK_TA_BOUNCE, 0);
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
+
+	if (bt) {
+		ta = BLK_TA_BOUNCE;
+	} else if (bte) {
+		ta = BLK_TA_BOUNCE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, ta, 0);
 }
 
 static void blk_add_trace_bio_complete(void *ignore,
-- 
2.22.1

