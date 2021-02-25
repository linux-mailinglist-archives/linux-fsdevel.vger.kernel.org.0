Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF02324AE1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233299AbhBYHIN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:08:13 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5434 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232861AbhBYHGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:06:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237374; x=1645773374;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=42OzqGRcgX68urDOm4p/VfIlMMm4jPAS9tAy3doIZLk=;
  b=GRUW/ivF6+72zNk90C0Notzju5+2SCKl4sH2aUG5TUZyIWdWRF5TONyd
   9ZVGMH9GBK8EGzhKegqfRkrhkCrRwhHrDddAEQfvysd9cjHb0ebhxoClP
   sjrWI8+YDZR/3mjpSEd3FP1ps035EkC6/UW4rBzb+VJqkTFY7Zu4TuqqE
   7/UR4s07LnAiYZnt4OsDUPQ7HDyEU51o5FlJh85dVJcruTm92Tfns3kwa
   iB43DJ3uZWQej8dCUxL7BwXvyhGi9spokl+YvjuHmW9OmssxdDSDCrjxk
   KRP4chzii4DwFHLpS1ZBtGuuqV2PosJuu2gXrrIairCc8E5zQkA9ZquOa
   w==;
IronPort-SDR: nC3+SwKP75iaTCw+daEK17psah9StxSd4I9ZnglzHMThd7ZcjMnPCP3TrmZeNCua14Wwn3dBeT
 sLRD6Fd2rM7q/oASLfNXzZzbKLTWMJ3p5RKnfKJaRGAGaPVzK8YeNkKm8Lj+ES7a7AicEbcyuI
 lsKPiPyKc5cgeYymISoxbnWTTyYFSw34sUo3/xO5xf4x46IQgDeMOQ7zAfWgTXmFNxl96fBw8R
 J+JaJLoCnwwCaYnbDuth2IoidxSvORQJq0JEsW9hGhldTgYGXmRWCA6s+6ls4Xv6qzR4hG0fZj
 TgA=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264978883"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:13:19 +0800
IronPort-SDR: O7TDRm2u5yp/kTgILM8hvwXqnKI2e2Tkw7ILwyFfcJVU+r0ZYG2EKkvxv8XHNrJ53LK0+OTeGZ
 F0yDRDtn5Hl2Fs4oqTRFaS1MJ9mwn9mYjW6VR+BsIkEZLcabbsT/9grIElqaOsR7IA7ikJ4XL2
 AWSlZeCTBFpvUxkrDR4lMhDpQnQvWWXuo0o8Uyupem6rzt1qpoowH7J4yxG/dXmSemJq05MPBD
 uHRl2lnxPkIsy/QS/x5MaAJ+IknXHgb/xtizf5GsshE6xWwsKnfdbCIhJaIoRIOAkvChqCmAmm
 mSiBhczlSi5vKjb6MjNUVdlz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:46:19 -0800
IronPort-SDR: Btwi8E0VZfow8w0HxK2UhZRQiL2RCgR1JsOmX9bXMWXQUq3otnRGBLOSKzRAbAW5wn8aOD7ySE
 x10VhtpFJjg6hzVRrKutYdIUvnlIy4SCR+r8cCHugDlLo2q+NU+YhH/Sca5mRwGV19ESBn5f31
 7UqAkT9skiKuHfizTjBRqPgD+xexZSe5oHeAITT8d3BJsIfwZ/lGjOrNattvrWqFplitzFuxxi
 FXVqvNGA6JL2et+bGuKqze/lMEik3odMYrEA9wzN1r61tTYul8wCe0Ah6N/VT+etpRwWNWRGYK
 dWM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:04:57 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 15/39] blktrace: update blk_add_trace_bio_complete()
Date:   Wed, 24 Feb 2021 23:02:07 -0800
Message-Id: <20210225070231.21136-16-chaitanya.kulkarni@wdc.com>
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
index d4c3ae0f419e..e3210951f1f0 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1301,7 +1301,25 @@ static void blk_add_trace_bio_bounce(void *ignore, struct bio *bio)
 static void blk_add_trace_bio_complete(void *ignore,
 				       struct request_queue *q, struct bio *bio)
 {
-	blk_add_trace_bio(q, bio, BLK_TA_COMPLETE,
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
+		ta = BLK_TA_COMPLETE;
+	} else if (bte) {
+		ta = BLK_TA_COMPLETE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, ta,
 			  blk_status_to_errno(bio->bi_status));
 }
 
-- 
2.22.1

