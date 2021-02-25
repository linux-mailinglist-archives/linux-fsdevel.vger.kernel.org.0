Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34EBE324AE8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhBYHIo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:08:44 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13098 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhBYHHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237392; x=1645773392;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qml1l8JUcbImsAtiKdYsTQYk5qDMEZ+xBH4KgzU1AVc=;
  b=Qexq6d6KItg+OsB4XhEDxrtapD5JjCkUugfK/ur+reIs0terETHFTMm5
   3p83Z6Vwiw1bDGKAeO2QXhZ848kca5iDK0vdVexkhsQosh2mCLJJQlDzI
   0Q/O5WJvBMRCpdjWXzpuUfjzVzepYZMeJv7xvsep53Ea6yGO+iFJEmDCc
   9uKNPJw/P3jYheuXTBcJaMDj4kmVIVXvcs7B9l6UOjXgcfBgPrSuurI3B
   eD770RCYewnNi+TJcLF2dV36/pRNhx6lgFCwygtUOglSXL+VxdcIOhSU3
   teUNOz7dnGxTwgdGGIeI11U0mg9EOaqtCdViT2mm8WJBb9qqefHsooy5L
   w==;
IronPort-SDR: KVbemPO4I6gQ551sgKz5/LMB19ePbfO5Jg0pCOdzdnMZjrPY6SLj5SKYhWM1xnE9t/z5EpvN1f
 IdsJZWNU5Yh4dJtP+15/Xo5JvoHX2yHf/mC9w6+O7PGLU5tEGe89pOOdJVs9AadQnOz6H5fOPY
 7eXWAT+6dkw5aiEuIRajHBk+5cSjgC/VrOUdLLDcOqQWc4UNda8af3kcfS9/AL5adv5B7ToKOZ
 hZeiixl74Vi0fgC+sOttidjO/NevUEYLyEYldWwle2lGy158nH5Q6ASdp9y1h7mLBuVLkhWRKK
 FFo=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264978957"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:14:54 +0800
IronPort-SDR: aFQldnvsCanRdBYcb05TwFOmZnOhBGerNziXMisxUnzNsN803YIFg0hSYAm9Uk6E5Pn1hmgZbh
 EWf/eOXQ0ulojQr4jR3ZBmmuq8XPEFsaIq6pA5W0rxedd4DDp/gATxaz467wqdG0Pz+cQtW6EE
 wyqqH4iQbFKN6yB/4P9NJgzAbFgjqwZO4NDjkXRCsil5qKxk8/+pn4iU8Yh7WYWQ89eQnADx97
 tvsVJ94uB1TzDndAQEQA+73oFlrQ4B60CEnTRTr+aSJmIWwR0ObeJRAwNckWV3YzzN5Ybgrs1Y
 8tPoE7qRc8ueCELWHDrL7o0t
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:49:15 -0800
IronPort-SDR: sPzIe7Ww++prZTg0HIhk/S/Rh9lTYpxV9Br8zmffDd2JxpJIhBkLxWAgEXjGbSnDc3Cqv1gQKR
 BSXpcap1nBYL9pnf/Z9e1dNVmjUVGT/s25SIyTMEaUUd4nIPQKOEbGxFGWsj5ZQ+n302kbMNin
 rG8bDwuo3oLn4IPhU8yLrqTODM8Vxu7qnm2DJxiOR7f2/4io9cAlXsT6pWWifOjfK8aDWrUaMu
 r1Ps8VxcVD7mk2CL2VwOS2HQ7FZYSyy8etnqLUpL3zO32EH1B090eaaAqPLW8Miz/AkD3mEM2L
 KUY=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:06:00 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 23/39] blktrace: update blk_add_trace_bio_remap()
Date:   Wed, 24 Feb 2021 23:02:15 -0800
Message-Id: <20210225070231.21136-24-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 35a01cf956a5..e12317f48795 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1512,11 +1512,13 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 {
 	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 	struct blk_io_trace_remap r;
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
-	if (likely(!bt)) {
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -1525,10 +1527,18 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 	r.device_to   = cpu_to_be32(bio_dev(bio));
 	r.sector_from = cpu_to_be64(from);
 
-	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, BLK_TA_REMAP,
-			blk_status_to_errno(bio->bi_status),
-			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio));
+	if (bt) {
+		__blk_add_trace(bt, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
+				BLK_TA_REMAP, bio->bi_status, sizeof(r), &r,
+				blk_trace_bio_get_cgid(q, bio));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,
+				    bio->bi_iter.bi_size, bio_op(bio),
+				    bio->bi_opf, BLK_TA_REMAP_EXT, bio->bi_status,
+				    sizeof(r), &r,
+				    blk_trace_bio_get_cgid(q, bio), 0);
+	}
 	rcu_read_unlock();
 }
 
-- 
2.22.1

