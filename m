Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3B80324ACC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbhBYHG0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:06:26 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61594 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBYHFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236735; x=1645772735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jJS33jTeS4XOBYxJhHFf4LP5tOs+0XruCJUSjMPRWFQ=;
  b=VBquBQsLeNhwCzvHAGchjVn5OhOmxonchIor33W9BnOOpeTPUYUmkr7H
   8FQrX8BngwpSrBeX7XS1YXV+saPG5sQQy/MPlrE7ukRI6Zp1C4o80NqzO
   cmGYJPqkxZx3SQIEu0Ry6wYxToUfPNU38pb2JJOutTy9yVswgqBut0/oe
   5fhD2VA0Ed0P1NEeb0mwYWbKe9qpUuZANFbzDjHOacl7pHLPb8Nrmu0rW
   nRZNQiqyrFdVwwL89pX7jBJqYT6P4id/hH7GjJQvByrVUWdytzcjFivcg
   O85qXHALe8NH91R3eQtSdHdl9QxSmEEESrbxd4U6zCkjAOeixgOYqy8lb
   g==;
IronPort-SDR: W+1+t3b5Dml6Vz/GRuNdBsgYUEIxpiWYy28A9fy8+elhhIgRET4laNiVRapcVw/SXIu7sQ0mHf
 rTEYAG/xg3xInr7Z4t7QIDhoYWjMYy8q65WsC/bk7sa52pGS9w6GHRAZA1shgClOAJQ6nMdjfL
 7moUdVV1if+RvPM7LMokANKZc0s1GPsULgV6qVj3Y4+iMCRaVpR8jenE6lIk7uHZNBdHUl3glS
 GaCWnDkKoK1qAU8x6C0EXbDy/t8/OzAKzPC0vTwcgUoe3ZcFaNRQRq1PhHkRBQDnsqea354fif
 Ab8=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="161931415"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:04:41 +0800
IronPort-SDR: 5ecHJDcH030FWYLkstVEL2M6nZYHDgLO1y47JVVgsWu0B39a4PsHVm92JbAncjwkGUf6v/NCg7
 qn3D8c0O1kZqqZpK5euNs20yssg3VTEZ4Yd3SP+Ur1BKpq4XFcDJMedZy4o8/YleQDQVPDDWrB
 bgo15juSh8NqB7qbCB8lgEU2xwGapoSLHTANqm7Z9Y6hKoQtr4n0lWAiosczOXUQadhFYPl98k
 3q86NT+dRTPf+H/LSNp07ag4JkAgnCGg6wR1BdM4Z+yeLdLrhbsNzKn7avAmc2PoNrtZN5LBGm
 4CZprC9AvMG38iVt1Gryh2cU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:46:02 -0800
IronPort-SDR: 88N634aVstBuqVOxPofvX7qZC4KLKjL5g9B29uWfgYJRqBpZOUUdcWNVsdaqbYfeOIvnZHzUDS
 U25Ij7rei2zcHXrWF1SsqzUnBD2fOi00T4FyplhfecBoxZamE6CkRCKWomrjCBPZfyc2XnMTWW
 Yqi22ei+izyD+nBM2YzymQ+MW1rQoOxKkFwecELtf5t9AWYYYFWhoYGF6NxpaH88/0qPy4R+G9
 URwILbAyFv3GDsO4uHFtuSiktTwc5j4fxIocSjhnQ4Li/JnasWMXgOv/RIn5JSAdKLUaxqg/DC
 JJA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:04:40 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 13/39] blktrace: update blk_add_trace_bio()
Date:   Wed, 24 Feb 2021 23:02:05 -0800
Message-Id: <20210225070231.21136-14-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 07f71a052a0d..14658b2a3fc8 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1247,20 +1247,31 @@ static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
  *
  **/
 static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
-			      u32 what, int error)
+			      u64 what, int error)
 {
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
-	if (likely(!bt)) {
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
 		rcu_read_unlock();
 		return;
 	}
 
-	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, what, error, 0, NULL,
-			blk_trace_bio_get_cgid(q, bio));
+	if (bt) {
+		__blk_add_trace(bt, bio->bi_iter.bi_sector,
+				bio->bi_iter.bi_size, bio_op(bio),
+				bio->bi_opf, (u32)what, error, 0, NULL,
+				blk_trace_bio_get_cgid(q, bio));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, bio->bi_iter.bi_sector,
+				    bio->bi_iter.bi_size, bio_op(bio),
+				    bio->bi_opf, what, error, 0, NULL,
+				    blk_trace_bio_get_cgid(q, bio),
+				    bio_prio(bio));
+	}
 	rcu_read_unlock();
 }
 
-- 
2.22.1

