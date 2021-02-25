Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484E6324AC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhBYHFi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:05:38 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13993 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBYHEy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236694; x=1645772694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=prMu5VWVvyH6quJgJm9/+dMQtJ1jV2ZlJRv9h09QmW8=;
  b=JbfEFrZCDD1dPKqdFCjirh/JRNhTqzojV5QWsfEcbMvc2fZbjQP2w+eD
   DN87AW47faFovH8GgOXSW/pea6o+QyK9pdg92p2imf8tKUs8vI9VCQDDR
   Vlp1LQtQI/OedSQ5xmO3gCsmnvUIb3NndZHcEiC22U4YmtmrMrmB92uPp
   osh3SCKZ6lELX6EDLgayzryOR+ol8V3TMgpSyvAZSLxL9gYxZnj3+CXHo
   s9GYkuq4VooEawzTpt+FWlTTaqY7JzPpJ0g9ydoD8PPbJm9xB90Qjds1t
   t3kqYpwq4sY8rHx2dqquDLlZwcoIGOUd+dU5fstUsQVPi4BjI0D06SM5h
   w==;
IronPort-SDR: yXNNbuaEpqNx5wIPJFCBcONoTPBVI7JrQ6arrUbj7MyoryMLDTkqDbdEw3wn2dBReIlOwg+zZ6
 3JkQ4UF+TKimeLeMIRr7s3AgWQUWxP236mukidnkR7yVruJQVtVzyAEihdmq8w6b0qqL31R/dT
 YdVUgCKp/nuXlR0tdQo4DHNkzIAdP/s4VOQ6a1diiKMms80vRhTHiBc32PU1Dh+IcayuWX0V7P
 HnCjI0wfpK4EEaeEXI0GnF/ONcWymi6JH6qTsRQjnCpTUFQBOAsLYR+/KM0J9fL5VJL6BUr037
 SZk=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160751667"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:03:47 +0800
IronPort-SDR: VVZManM2tYw3yRwKoRxVVLjBXgFbGRcSRMCq1J7EVgzn+Vx1NkbO22QbVl1Qlb7XnHerb3B5XW
 TDUnmbmZuJOv2cYXXO31VuqoCe/RpWaq6M21RQXY7HXQJlwnbYoTX68YiRR16U7q9T1GvHd8e7
 ClqNjOwWmfmIIRFcTnCdloMFh+G3O723cmv0OabBq+Q/i7WdGoHls3d5OaHkWBKQgjH3/ZKAoN
 qPu4aaz0ESwg7q0kcnQzu6GB1iHiod23cLb34TFCGHgVKb40BHMD0aDLh/J035FlBXwzTQHScn
 wQwzA31EaqSCb+JZjsVArbDs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:47:02 -0800
IronPort-SDR: TVONRZDXjB9/ityTS4FG+vryTqDrcEn/RclLb7OnqTPjX2WsFUC3jHGsRxTbAf+OkCdYk+IpPQ
 ptOKSzCTlBTyL+ah2P9C7fFc0K3Tyk2Z3N1jLcLKzN4HRSc3y8k7oYdUeb52IBGxkz9YSmsmPO
 Zhogoib04S5BOtWHtzS9blIGAn6vG+o+F+YMC5Zy2jE59e1vTTJORXDC50nTwti6+U5Q/MS79O
 K9fy+pdEEDiXKcNoBKrqAi6Tk/LAVBV4UH4ODmPMr4CcjUoBCDJm4uo6+bNCgy9BW5f8OLxNHI
 2Qc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:03:47 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 07/39] blktrace: add core trace API
Date:   Wed, 24 Feb 2021 23:01:59 -0800
Message-Id: <20210225070231.21136-8-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 130 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index feb823b917ec..1aef55fdefa9 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -462,6 +462,136 @@ static void __blk_add_trace(struct blk_trace *bt, sector_t sector, int bytes,
 	local_irq_restore(flags);
 }
 
+/*
+ * Data direction bit lookup
+ */
+static const u64 ddir_act_ext[2] = { BLK_TC_ACT_EXT(BLK_TC_READ),
+				 BLK_TC_ACT_EXT(BLK_TC_WRITE) };
+
+/* The ilog2() calls fall out because they're constant */
+#define MASK_TC_BIT_EXT(rw, __name) ((rw & REQ_ ## __name) << \
+	  (ilog2(BLK_TC_ ## __name) + BLK_TC_SHIFT_EXT - __REQ_ ## __name))
+
+/*
+ * The worker for the various blk_add_trace*() types. Fills out a
+ * blk_io_trace structure and places it in a per-cpu subbuffer.
+ */
+static void __blk_add_trace_ext(struct blk_trace_ext *bt, sector_t sector, int bytes,
+		     int op, int op_flags, u64 what, int error, int pdu_len,
+		     void *pdu_data, u64 cgid, u32 ioprio)
+{
+	struct task_struct *tsk = current;
+	struct ring_buffer_event *event = NULL;
+	struct trace_buffer *buffer = NULL;
+	struct blk_io_trace_ext *t;
+	unsigned long flags = 0;
+	unsigned long *sequence;
+	pid_t pid;
+	int cpu, pc = 0;
+	bool blk_tracer = blk_tracer_enabled;
+	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
+
+	if (unlikely(bt->trace_state != Blktrace_running && !blk_tracer))
+		return;
+
+	what |= ddir_act_ext[op_is_write(op) ? WRITE : READ];
+	what |= MASK_TC_BIT_EXT(op_flags, SYNC);
+	what |= MASK_TC_BIT_EXT(op_flags, RAHEAD);
+	what |= MASK_TC_BIT_EXT(op_flags, META);
+	what |= MASK_TC_BIT_EXT(op_flags, PREFLUSH);
+	what |= MASK_TC_BIT_EXT(op_flags, FUA);
+	if (op == REQ_OP_ZONE_APPEND)
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_APPEND);
+	if (op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE)
+		what |= BLK_TC_ACT_EXT(BLK_TC_DISCARD);
+	if (op == REQ_OP_FLUSH)
+		what |= BLK_TC_ACT_EXT(BLK_TC_FLUSH);
+	if (unlikely(op == REQ_OP_WRITE_ZEROES))
+		what |= BLK_TC_ACT_EXT(BLK_TC_WRITE_ZEROES);
+	if (unlikely(op == REQ_OP_ZONE_RESET))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET);
+	if (unlikely(op == REQ_OP_ZONE_RESET_ALL))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_RESET_ALL);
+	if (unlikely(op == REQ_OP_ZONE_OPEN))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_OPEN);
+	if (unlikely(op == REQ_OP_ZONE_CLOSE))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_CLOSE);
+	if (unlikely(op == REQ_OP_ZONE_FINISH))
+		what |= BLK_TC_ACT_EXT(BLK_TC_ZONE_FINISH);
+
+	if (cgid)
+		what |= __BLK_TA_CGROUP;
+
+	pid = tsk->pid;
+	if (act_log_check_ext(bt, what, sector, pid))
+		return;
+	if (bt->prio_mask && !prio_log_check(bt, ioprio))
+		return;
+
+	cpu = raw_smp_processor_id();
+
+	if (blk_tracer) {
+		tracing_record_cmdline(current);
+
+		buffer = blk_tr->array_buffer.buffer;
+		pc = preempt_count();
+		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
+						  sizeof(*t) + pdu_len + cgid_len,
+						  0, pc);
+		if (!event)
+			return;
+		t = ring_buffer_event_data(event);
+		goto record_it;
+	}
+
+	if (unlikely(tsk->btrace_seq != blktrace_seq))
+		trace_note_tsk_ext(tsk, ioprio);
+
+	/*
+	 * A word about the locking here - we disable interrupts to reserve
+	 * some space in the relay per-cpu buffer, to prevent an irq
+	 * from coming in and stepping on our toes.
+	 */
+	local_irq_save(flags);
+	t = relay_reserve(bt->rchan, sizeof(*t) + pdu_len + cgid_len);
+	if (t) {
+		sequence = per_cpu_ptr(bt->sequence, cpu);
+
+		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION_EXT;
+		t->sequence = ++(*sequence);
+		t->time = ktime_to_ns(ktime_get());
+record_it:
+		/*
+		 * These two are not needed in ftrace as they are in the
+		 * generic trace_entry, filled by tracing_generic_entry_update,
+		 * but for the trace_event->bin() synthesizer benefit we do it
+		 * here too.
+		 */
+		t->cpu = cpu;
+		t->pid = pid;
+
+		t->sector = sector;
+		t->bytes = bytes;
+		t->action = what;
+		t->ioprio = ioprio;
+		t->device = bt->dev;
+		t->error = error;
+		t->pdu_len = pdu_len + cgid_len;
+
+		if (cgid_len)
+			memcpy((void *)t + sizeof(*t), &cgid, cgid_len);
+		if (pdu_len)
+			memcpy((void *)t + sizeof(*t) + cgid_len, pdu_data, pdu_len);
+
+		if (blk_tracer) {
+			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);
+			return;
+		}
+	}
+
+	local_irq_restore(flags);
+}
+
 static void blk_trace_free(struct blk_trace *bt)
 {
 	relay_close(bt->rchan);
-- 
2.22.1

