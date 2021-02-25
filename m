Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C12C324B0E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbhBYHML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:12:11 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26799 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhBYHKA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237000; x=1645773000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zF7/doyKoEogbpCRXSeDJCnl1y9SdsmStX/bXUCeES0=;
  b=gz3+qrV5aoo6tX5TzvEO1Jb7dasqKV6nYigJoUEVP9+8Yc4BemhkUICL
   UEZQeFxFNtQMvh3g2FwADaGPOw/bXT47Gn6iFCYqB5H9aPU7bY0Agrtln
   2pt0/ntO/v8FeoqgRI81uFqRceX05D2eeKRhRdnblHgAKvNP+KBjg0QQj
   PLaLhZk2sGlzk8YTEeZUVeAWtQO+nrgqdq8tgIVCikw5cER9zTy6uPh4y
   OGoJAa8+MoMD/EH1uYWut9vpd0nYQ/vgwuhoJ/8zaYSwGZemUjI5iH2xY
   vgd1C4atiVAHAm4PN28C4wtIGg7gM983aQ70w18Ib34A+0O1IhpeHoI0X
   g==;
IronPort-SDR: hTwAjRhBAyD/iYPX+dBdAddXOS2C6wnnsz9YNZWr7Y3JDu9AJP2xEfrAr2LrpXIxXL7+Q7sJiG
 haX8OJ6Qn48sOQGVa9L1l1np8Q7e/HOKdihBlBdCUDJxQqg60EwygWG9mBpZ+orIn9ZWpunDqY
 UCVr2PQyWuZN10FhxT7/hm3KY5DR8w8a3gvRriwNzSUfiRtUcDPo8KDXtw5pUMI4v2RxD+eJR6
 41PRp8+/eWpWyCq2QKVcIuUjZqy7mk8axJ/SBiev6nh9nWf7wQSrfJi/WX7k7WhA3Q4bHRP60n
 ZQg=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160778125"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:07:54 +0800
IronPort-SDR: AB5TIZt57zuC793FNzMHCokdEQuLFMA8wUOz77XSN45IestPNUolCrEQXGZKEk6NnEkRw9BNZW
 ADfwzwtxRhH+6kCrYztlxBGCvuNwrgEBdEiLJvW4a8MD3p3vFQDM17FbcSRXIakh53W8RdVZRS
 r/BtVN0mGEI9JrBERrebh7GZcDSTXO+dqcWP2WLh9gwwtGv+2avwNUE2U/K1Iqdm0jTHniuhbS
 CaO0gC1GO8mG8TISGJs2K4RZEuMqj/HYLgKnkXpoAklXiYnUoLqM+7uqQyHw45iAiZ24rIXp/g
 M/ZQc18XobLskU/N2l6MbF6K
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:49:16 -0800
IronPort-SDR: ryJ6gXargtDm0+QkHLSc5S5vTvL835ijcFWtYSf9MpFOuw/C+fmXqevnuJWRq5QddwxEL6EXFo
 KtCZZS00JTeUfDVPUO3nyiaMDOhk9TBGJ//aQaXviKDmuZpBhV+44WPckprZQWheCKX/Lom1gV
 pFgn41H4ryr2A55MmgY5NFrDCzSe6tOhWSx1xY3vwx9svTqZ6ZqLTsMjwnPiGmLTCkr46LAm5G
 VgzTMDJaj6Rwxx68vz6FnuXlHQX4/f3g1CYh8js4h8qzbiqquxOsu+Xllu4z3twJROEamjKox9
 EY0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:07:54 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 38/39] blktrace: track zone appaend completion sector
Date:   Wed, 24 Feb 2021 23:02:30 -0800
Message-Id: <20210225070231.21136-39-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The request type REQ_OP_ZONE_APPENDT needs zone start the when issued
not the actual sector where this I/O lands and returns completion sector
in for trace complete event 'C'. Right now we cannot track submission &
completion sector for this special request with existing format.

Add a new completion sector field in the blk_io_trace_ext structure,
when generating the trace when req_op is REQ_OP_ZONE_APPEND update
the completion sector from the I/O and store the zone start (where
actual I/O was issued) in the secor field of the trace.

With this new format we can track completion sector. (* is not a part
real trace it is here as a place holder so that it is easy to read for
reviewers) :-

252,0 15  1 92.785481956  6139  Q ZAS N 262144 + 8 [dd]
252,0 15  2 92.785490381  6139  G ZAS N 262144 + 8 [dd]
252,0 15  3 92.785498517  6139  I ZAS N 262144 + 8 [dd]
252,0 15  4 92.785519065   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15  5 92.785541527    86  C ZAS N 262144 + 8 [0] <262144>

252,0 15  6 92.785561936  6139  Q ZAS N 262144 + 8 [dd]
252,0 15  7 92.785568368  6139  G ZAS N 262144 + 8 [dd]
252,0 15  8 92.785574820  6139  I ZAS N 262144 + 8 [dd]
252,0 15  9 92.785587754   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 10 92.785602802    86  C ZAS N 262144 + 8 [0] <262152>

252,0 15 11 92.785619704  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 12 92.785626076  6139  G ZAS N 262144 + 8 [dd]
252,0 15 13 92.785632438  6139  I ZAS N 262144 + 8 [dd]
252,0 15 14 92.785644801   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 15 92.785659939    86  C ZAS N 262144 + 8 [0] <262160>

252,0 15 16 92.785676460  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 17 92.785682872  6139  G ZAS N 262144 + 8 [dd]
252,0 15 18 92.785689294  6139  I ZAS N 262144 + 8 [dd]
252,0 15 19 92.785701487   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 20 92.785716024    86  C ZAS N 262144 + 8 [0] <262168>

252,0 15 21 92.785732335  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 22 92.785738687  6139  G ZAS N 262144 + 8 [dd]
252,0 15 23 92.785745019  6139  I ZAS N 262144 + 8 [dd]
252,0 15 24 92.785757843   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 25 92.785772020    86  C ZAS N 262144 + 8 [0] <262176>

252,0 15 26 92.785788180  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 27 92.785794492  6139  G ZAS N 262144 + 8 [dd]
252,0 15 28 92.785800763  6139  I ZAS N 262144 + 8 [dd]
252,0 15 29 92.785812696   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 30 92.785826762    86  C ZAS N 262144 + 8 [0] <262184>

252,0 15 31 92.785842852  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 32 92.785849104  6139  G ZAS N 262144 + 8 [dd]
252,0 15 33 92.785855346  6139  I ZAS N 262144 + 8 [dd]
252,0 15 34 92.785867599   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 35 92.785881835    86  C ZAS N 262144 + 8 [0] <262192>

252,0 15 36 92.785897845  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 37 92.785904107  6139  G ZAS N 262144 + 8 [dd]
252,0 15 38 92.785910329  6139  I ZAS N 262144 + 8 [dd]
252,0 15 39 92.785922181   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 40 92.785936237    86  C ZAS N 262144 + 8 [0] <262200>

252,0 15 41 92.785952037  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 42 92.785958289  6139  G ZAS N 262144 + 8 [dd]
252,0 15 43 92.785964651  6139  I ZAS N 262144 + 8 [dd]
252,0 15 44 92.785976373   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 45 92.785990419    86  C ZAS N 262144 + 8 [0] <262208>

252,0 15 46 92.786006339  6139  Q ZAS N 262144 + 8 [dd]
252,0 15 47 92.786025204  6139  G ZAS N 262144 + 8 [dd]
252,0 15 48 92.786031566  6139  I ZAS N 262144 + 8 [dd]
252,0 15 49 92.786043869   804  D ZAS N 262144 + 8 [kworker/15:1H]
252,0 15 50 92.786058216    86  C ZAS N 262144 + 8 [0] <262216>

252,0 10  1 92.783369654  6138  Q ZRS N 262144 + 0 [truncate]
252,0 10  2 92.783384813  6138  G ZRS N 262144 + 0 [truncate]
252,0 10  3 92.783395182  6138  I ZRS N 262144 + 0 [truncate]
252,0 10  4 92.783419628   782  D ZRS N 262144 + 0 [kworker/10:1H]
252,0 10  5 92.783460895    61  C ZRS N 262144 + 0 [0]
252,0  8  1 92.788546342  6140  Q ZRAS N 0 + 0 [blkzone]
252,0  8  2 92.788554628  6140  G ZRAS N 0 + 0 [blkzone]
252,0  8  3 92.788562232  6140  I ZRAS N 0 + 0 [blkzone]
252,0  8  4 92.788580977   934  D ZRAS N 0 + 0 [kworker/8:1H]
252,0  8  5 92.788597268    51  C ZRAS N 0 + 0 [0]

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/uapi/linux/blktrace_api.h |  1 +
 kernel/trace/blktrace.c           | 31 ++++++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index ac533a0b0928..ebfe3029cd10 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -155,6 +155,7 @@ struct blk_io_trace_ext {
 	__u32 sequence;		/* event number */
 	__u64 time;		/* in nanoseconds */
 	__u64 sector;		/* disk offset */
+	__u64 completion_sector;/* zone append completion sector */
 	__u32 bytes;		/* transfer length */
 	__u64 action;		/* what happened */
 	__u32 ioprio;		/* I/O priority */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 32100c5db7a6..59bf99b4106a 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -502,7 +502,8 @@ static const u64 ddir_act_ext[2] = { BLK_TC_ACT_EXT(BLK_TC_READ),
  */
 static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int bytes,
 		     int op, int op_flags, u64 what, int error, int pdu_len,
-		     void *pdu_data, u64 cgid, u32 ioprio, void *bip)
+		     void *pdu_data, u64 cgid, u32 ioprio, void *bip,
+		     sector_t blk_queue_zone_sectors)
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -595,6 +596,16 @@ static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int b
 		t->pid = pid;
 
 		t->sector = sector;
+		if (op == REQ_OP_ZONE_APPEND) {
+			sector_t zno = sector >> ilog2(blk_queue_zone_sectors);
+
+			t->completion_sector = sector;
+			/*
+			*  Start of the zone sector in which this completion
+			*  sector belongs to.
+			*/
+			sector = zno * blk_queue_zone_sectors;
+		}
 		t->bytes = bytes;
 		t->action = what;
 		t->ioprio = ioprio;
@@ -1445,7 +1456,8 @@ static void blk_add_trace_rq(struct request *rq, int error,
 			what |= BLK_TC_ACT_EXT(BLK_TC_FS);
 		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), nr_bytes,
 				    req_op(rq), rq->cmd_flags, what, error, 0,
-				    NULL, cgid, req_get_ioprio(rq), NULL);
+				    NULL, cgid, req_get_ioprio(rq), NULL,
+				    blk_queue_zone_sectors(rq->q));
 	}
 	rcu_read_unlock();
 }
@@ -1588,7 +1600,8 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 				    bio->bi_iter.bi_size, bio_op(bio),
 				    bio->bi_opf, what, error, 0, NULL,
 				    blk_trace_bio_get_cgid(q, bio),
-				    bio_prio(bio), bio_integrity(bio));
+				    bio_prio(bio), bio_integrity(bio),
+				    blk_queue_zone_sectors(q));
 	}
 	rcu_read_unlock();
 }
@@ -1748,7 +1761,7 @@ static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
 	else if (bte)
 		__blk_add_trace_ext(bte, 0, 0, 0, 0, BLK_TA_PLUG_EXT, 0, 0,
-				    NULL, 0, 0, NULL);
+				    NULL, 0, 0, NULL, 0);
 	rcu_read_unlock();
 }
 
@@ -1780,7 +1793,7 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 		else
 			what = BLK_TA_UNPLUG_TIMER_EXT;
 		__blk_add_trace_ext(bte, 0, 0, 0, 0, what, 0, sizeof(rpdu),
-				&rpdu, 0, 0, NULL);
+				&rpdu, 0, 0, NULL, 0);
 	}
 	rcu_read_unlock();
 }
@@ -1813,7 +1826,7 @@ static void blk_add_trace_split(void *ignore, struct bio *bio, unsigned int pdu)
 				    bio->bi_status, sizeof(rpdu), &rpdu,
 				    blk_trace_bio_get_cgid(q, bio),
 				    bio_prio(bio),
-				    bio_integrity(bio));
+				    bio_integrity(bio), 0);
 	}
 	rcu_read_unlock();
 }
@@ -1859,7 +1872,7 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 				    sizeof(r), &r,
 				    blk_trace_bio_get_cgid(q, bio),
 				    bio_prio(bio),
-				    bio_integrity(bio));
+				    bio_integrity(bio), 0);
 	}
 	rcu_read_unlock();
 }
@@ -1904,7 +1917,7 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 		__blk_add_trace_ext(bte, blk_rq_pos(rq), blk_rq_bytes(rq),
 				    rq_data_dir(rq), 0, BLK_TA_REMAP_EXT, 0,
 				    sizeof(r), &r,
-				    blk_trace_request_get_cgid(rq), 0, NULL);
+				    blk_trace_request_get_cgid(rq), 0, NULL, 0);
 	}
 	rcu_read_unlock();
 }
@@ -1940,7 +1953,7 @@ void blk_add_driver_data(struct request *rq, void *data, size_t len)
 		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq),
 				blk_rq_bytes(rq), 0, 0, BLK_TA_DRV_DATA_EXT, 0,
 				len, data, blk_trace_request_get_cgid(rq),
-				req_get_ioprio(rq), NULL);
+				req_get_ioprio(rq), NULL, 0);
 	}
 	rcu_read_unlock();
 }
-- 
2.22.1

