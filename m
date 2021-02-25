Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DA324B0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbhBYHLv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:11:51 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:53171 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbhBYHJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:09:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236983; x=1645772983;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qmVWl/riaxHF0ICKpnD1wtzPBpIFIgQ86tmQdnEqvsU=;
  b=Eh9SOixuIjb2ShKvhsZNlfPfH8RPehhgklKtcIfNDANx50YjNI8NN2J3
   rm/clL4sz/Orjzmi5lix/QqVDZxMSfUGL+zF41ruzVDJiuJ3jTwdbyRmf
   Ie5MBc8gDimMnhl3Y/5U/vVoBYCU7sdlikmxvFXUc6/LGCKQwWrIeaQvc
   xe3RtDl/6ZufHGpgAS8T9J9HY65sPqxL3s6F3PAfWGxHzA02Y5ixQpf+x
   dtziuIFNa5ouan+RGW2njWRsC8EWBGBaDh2bO/Sea8HUm2cLv7n3XYIno
   wYXqzU76NxOHFtAEf/EX0d3yOElyP2nNZj9pcNMnW3bleBuhrJQHph0ZZ
   A==;
IronPort-SDR: Hz/7lBWcrSh/O/IPMUY7MZ7CVsIUd0SskKckgbYbQOpV/7hpxlCiorJL1TTBxEBg5hvQGZED2J
 g+FhCwZu2N8XGZu886wh/IRgBvtgSaAA85k7gJvK6oKuqbhNzzB78WkLr6ROpK1S2+CETw6qaN
 7/dSWIbtTACo7Z72eU80Vfv7jJ2kH8BG87msLk7dWIjMlIMmMKbz85pmC4TqqohOzu0qo1Og9Z
 3bI9Csp+6GjBRKw+96/Unfmh2P8kWgxrhBx3SlyEuRvAjL5lBQMAR15nWgm+gth8uFBWA+yfQ/
 wYs=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160778112"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:07:39 +0800
IronPort-SDR: ZDCsaWGF+XlFuK+RkQU/OIvjvmm++99RFL+Aa0iki5rikYrrN9u58NaYm+tZUQ0Wf1B4Wr25n4
 Y4UrGapiRZiTVk9JaVwRN8SpZaGseFyPPMeQgkH5bgL8gPVh1PNzfSRb5jAYTB/KjdMDf50a20
 5xWXTcx5J2tNA7SMWYFgvW9ldeEUrn1vw9yKjz3OOmcZ4uRYrUPCzMtF6tTMg+1IxWEaf3j47D
 co3IpTKGiq2zjY43I8PiXe1V+LNvQo8cQNFahN7kaNh75BQBHdNItNPWFYmNWDX4iB9zlOtokR
 IUzb+Rei7kq3GMb/rabteyc3
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:49:00 -0800
IronPort-SDR: 8ncxIOdAJ5I7FAzqO4m2G3XBPtBwH3hoZa4YW6kLoVPEaz6aZ0oPiKkgwStOsUhAzcorO8Jk6Q
 YXVH2s7DO44Fzh2tGbonkVgBXgA4lskbeduavKIoUjtfAb4SC5p9DJhzQpQBfpIovhNR34PY54
 2Tuu2wUMyJ6G/XpLAPLCe+znRo7uZaMPdI7QxpHkBDE+9ghtbZQ7S5Rb/sjAZgxU6cCVH/0BS8
 yib2lb5d/ZCv8dFYJTnJplFw75jEJTbu3rGiKtpGAS6TGehUDPnoZY7Wuj+uXvKR1zqJi9GQbQ
 1jA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:07:38 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 36/39] blktrace: add integrity tracking support
Date:   Wed, 24 Feb 2021 23:02:28 -0800
Message-Id: <20210225070231.21136-37-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds support to track the integrity related information.
We update struct blk_io_trace_ext with two new members :-
1. seed :- to track the integrity seed.
2. integrity :- to store the integrity related flags and integrity
   size buffer.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Suggested-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 include/uapi/linux/blktrace_api.h |  2 ++
 kernel/trace/blktrace.c           | 60 ++++++++++++++++++++++---------
 2 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index fdb3a5cdfa22..ac533a0b0928 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -158,6 +158,8 @@ struct blk_io_trace_ext {
 	__u32 bytes;		/* transfer length */
 	__u64 action;		/* what happened */
 	__u32 ioprio;		/* I/O priority */
+	__u64 seed;		/* integrity seed */
+	__u64 integrity;	/* store integrity flags */
 	__u32 pid;		/* who did it */
 	__u32 device;		/* device number */
 	__u32 cpu;		/* on what cpu did it happen */
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 3bd56b741379..6759ac7bc6c7 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -66,6 +66,26 @@ static int blk_probes_ref;
 static void blk_register_tracepoints(void);
 static void blk_unregister_tracepoints(void);
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static void set_integrity(struct blk_io_trace_ext *t,
+			  struct bio_integrity_payload *bip)
+{
+	t->seed = (u64)bip_get_seed(bip);
+	/*
+	 * We store integrity buffer size and flags as :-
+	 *
+	 * 63            48          32            16     5           0
+	 * |          reserved       | buffer size | rsvd | bip flags |
+	 */
+	t->integrity = (bip->bip_iter.bi_size << 16) | bip->bip_flags;
+}
+#else
+static void set_integrity(struct blk_io_trace_ext *t, void *bip)
+{
+
+}
+#endif
+
 /*
  * Send out a notify message.
  */
@@ -115,7 +135,8 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 }
 
 static void trace_note_ext(struct blk_trace_ext *bt, pid_t pid, u64 action,
-			   const void *data, size_t len, u64 cgid, u32 ioprio)
+			   const void *data, size_t len, u64 cgid, u32 ioprio,
+			   struct bio_integrity_payload *bip)
 {
 	struct blk_io_trace_ext *t;
 	struct ring_buffer_event *event = NULL;
@@ -148,6 +169,8 @@ static void trace_note_ext(struct blk_trace_ext *bt, pid_t pid, u64 action,
 		t->device = bt->dev;
 		t->action = action | (cgid ? __BLK_TN_CGROUP : 0);
 		t->ioprio = ioprio;
+		if (bip)
+			set_integrity(t, bip);
 		t->pid = pid;
 		t->cpu = cpu;
 		t->pdu_len = len + cgid_len;
@@ -178,7 +201,8 @@ static void trace_note_tsk(struct task_struct *tsk)
 	spin_unlock_irqrestore(&running_trace_lock, flags);
 }
 
-static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio)
+static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio,
+			       struct bio_integrity_payload *bip)
 {
 	unsigned long flags;
 	struct blk_trace_ext *bt;
@@ -187,7 +211,7 @@ static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio)
 	spin_lock_irqsave(&running_trace_ext_lock, flags);
 	list_for_each_entry(bt, &running_trace_ext_list, running_ext_list) {
 		trace_note_ext(bt, tsk->pid, BLK_TN_PROCESS_EXT, tsk->comm,
-			   sizeof(tsk->comm), 0, ioprio);
+			       sizeof(tsk->comm), 0, ioprio, bip);
 	}
 	spin_unlock_irqrestore(&running_trace_ext_lock, flags);
 }
@@ -220,7 +244,7 @@ static void trace_note_time_ext(struct blk_trace_ext *bt)
 	words[1] = now.tv_nsec;
 
 	local_irq_save(flags);
-	trace_note_ext(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), 0, 0);
+	trace_note_ext(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), 0, 0, NULL);
 	local_irq_restore(flags);
 }
 
@@ -290,9 +314,9 @@ void __trace_note_message_ext(struct blk_trace_ext *bt, struct blkcg *blkcg,
 		blkcg = NULL;
 #ifdef CONFIG_BLK_CGROUP
 	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n,
-		blkcg ? cgroup_id(blkcg->css.cgroup) : 1, 0);
+		blkcg ? cgroup_id(blkcg->css.cgroup) : 1, 0, NULL);
 #else
-	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n, 0, 0);
+	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n, 0, 0, NULL);
 #endif
 	local_irq_restore(flags);
 }
@@ -478,7 +502,7 @@ static const u64 ddir_act_ext[2] = { BLK_TC_ACT_EXT(BLK_TC_READ),
  */
 static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int bytes,
 		     int op, int op_flags, u64 what, int error, int pdu_len,
-		     void *pdu_data, u64 cgid, u32 ioprio)
+		     void *pdu_data, u64 cgid, u32 ioprio, void *bip)
 {
 	struct task_struct *tsk = current;
 	struct ring_buffer_event *event = NULL;
@@ -545,7 +569,7 @@ static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int b
 	}
 
 	if (unlikely(tsk->btrace_seq != blktrace_seq))
-		trace_note_tsk_ext(tsk, ioprio);
+		trace_note_tsk_ext(tsk, ioprio, bip);
 
 	/*
 	 * A word about the locking here - we disable interrupts to reserve
@@ -1421,7 +1445,7 @@ static void blk_add_trace_rq(struct request *rq, int error,
 			what |= BLK_TC_ACT_EXT(BLK_TC_FS);
 		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), nr_bytes,
 				    req_op(rq), rq->cmd_flags, what, error, 0,
-				    NULL, cgid, req_get_ioprio(rq));
+				    NULL, cgid, req_get_ioprio(rq), NULL);
 	}
 	rcu_read_unlock();
 }
@@ -1564,7 +1588,7 @@ static void blk_add_trace_bio(struct request_queue *q, struct bio *bio,
 				    bio->bi_iter.bi_size, bio_op(bio),
 				    bio->bi_opf, what, error, 0, NULL,
 				    blk_trace_bio_get_cgid(q, bio),
-				    bio_prio(bio));
+				    bio_prio(bio), bio_integrity(bio));
 	}
 	rcu_read_unlock();
 }
@@ -1724,7 +1748,7 @@ static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
 	else if (bte)
 		__blk_add_trace_ext(bte, 0, 0, 0, 0, BLK_TA_PLUG_EXT, 0, 0,
-				    NULL, 0, 0);
+				    NULL, 0, 0, NULL);
 	rcu_read_unlock();
 }
 
@@ -1756,7 +1780,7 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 		else
 			what = BLK_TA_UNPLUG_TIMER_EXT;
 		__blk_add_trace_ext(bte, 0, 0, 0, 0, what, 0, sizeof(rpdu),
-				&rpdu, 0, 0);
+				&rpdu, 0, 0, NULL);
 	}
 	rcu_read_unlock();
 }
@@ -1787,7 +1811,9 @@ static void blk_add_trace_split(void *ignore, struct bio *bio, unsigned int pdu)
 				    bio->bi_iter.bi_size, bio_op(bio),
 				    bio->bi_opf, BLK_TA_SPLIT_EXT,
 				    bio->bi_status, sizeof(rpdu), &rpdu,
-				    blk_trace_bio_get_cgid(q, bio), 0);
+				    blk_trace_bio_get_cgid(q, bio),
+				    bio_prio(bio),
+				    bio_integrity(bio));
 	}
 	rcu_read_unlock();
 }
@@ -1831,7 +1857,9 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 				    bio->bi_iter.bi_size, bio_op(bio),
 				    bio->bi_opf, BLK_TA_REMAP_EXT, bio->bi_status,
 				    sizeof(r), &r,
-				    blk_trace_bio_get_cgid(q, bio), 0);
+				    blk_trace_bio_get_cgid(q, bio),
+				    bio_prio(bio),
+				    bio_integrity(bio));
 	}
 	rcu_read_unlock();
 }
@@ -1876,7 +1904,7 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 		__blk_add_trace_ext(bte, blk_rq_pos(rq), blk_rq_bytes(rq),
 				    rq_data_dir(rq), 0, BLK_TA_REMAP_EXT, 0,
 				    sizeof(r), &r,
-				    blk_trace_request_get_cgid(rq), 0);
+				    blk_trace_request_get_cgid(rq), 0, NULL);
 	}
 	rcu_read_unlock();
 }
@@ -1912,7 +1940,7 @@ void blk_add_driver_data(struct request *rq, void *data, size_t len)
 		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq),
 				blk_rq_bytes(rq), 0, 0, BLK_TA_DRV_DATA_EXT, 0,
 				len, data, blk_trace_request_get_cgid(rq),
-				req_get_ioprio(rq));
+				req_get_ioprio(rq), NULL);
 	}
 	rcu_read_unlock();
 }
-- 
2.22.1

