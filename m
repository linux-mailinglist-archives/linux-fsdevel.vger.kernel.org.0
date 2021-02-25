Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A87324AC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbhBYHGR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:06:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5434 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbhBYHFU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237232; x=1645773232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cTaFZeshtY/P5AdZC4uOQS6rwB7PeP2EPmugukbwT2M=;
  b=HflIpj/9VF/M6gCmTZ08fAby/adY3ygFvzYz2oVY/88h90p+U8yHoPmo
   uBxzzTWWmCyHjvK5MMkhPkLl5IINlh1Xi5eEzeWiOXZWR0E+YayNE0Pur
   PPAW+PjgFgvKzunU/oe/GU0mF9wNwG5Vh1iGqtSGTrH6DsVZC7vgaGKg9
   58ix8QBHXEScUElRiGBcHmYqBux3PVaoK7OCWgizzODWYcNGh0hmD5B5f
   EF3loA7xL0/15EKgqPH16hMstFaLGoHkJL5U7gyT9YnoNnVk7hwQm6QE0
   3+klABP/H0jQazD0f/K/lr2/cxwB4gWAVdBW/m763AOnu6Luf3vWQMbdb
   A==;
IronPort-SDR: 0sxs0asfCtAMSA5NDBOiDUyJjZVt3LV0+VNL4r7Dmyh0eFIOHV4Y4h1oJyxT06gxEbMZDfZEBs
 bJDFzGa5v+DDMc8Rufro7vvPsuuND/i2kAoUoacGPkneI1F805niK0+LeMjaTpIRxh4e+YAFSL
 XCmnQEzWPWg9ZIHNz7pFX+1IEZooAycun6GFK0R3zoodx82nfLdJlJv6NO6F5Vzy/dV947MyKw
 XYrjMx/vKLkNBf3wBlF88xE/kXDVRR4DnXIbHxBvV/ktNXHr432qiuKcA61Ca35Kn+9JGItvaB
 xSE=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264978784"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:11:06 +0800
IronPort-SDR: 3wLUVf1Qr3EVEWC6rQ9uudwdFY9rKI8Hc30siQpLYOEiF1aqxAkbfzI91EtOF60k942uFID5wu
 7MWufMb+kyJNCItXl6/16Znks4mZG/ny1sa1nwMUcJVPc/zp1ZDOIQgf7IPF2LOXIAXuTPn5GS
 3EevaD9iuuGxdIHIdeapFwuNCxUIdJbiaJQu9TNXFow5zNxk7mp39hrPSuNXm+n2zgrJRJ6FGH
 A8wTKCfx8nEAx1837DQDu4b3Akvyp6bftNqyjXIFPQLCp53I/YXdMlWP4l+NdJaZ60DoWZovCl
 Ziv4rJJKVF4nlCRF8P3bhNdU
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:46:45 -0800
IronPort-SDR: wB6TbvqlNZwKMapdr1mDfmhL3gVaQYcTN9mlB+HAE1E4Pd2OWdlMt6iRkM+jucRume3inI2xMU
 k0b3p1vjpwtmF5jDx3iCrtn3deq9ipwl0hxaEIak+1VfJ65IUdgdp7YzU3WKZIGHiM/L/EMflj
 9hpz70+6wm+ERuCGLQeCmQphuwBqI7XMHvN1n84iLom4CegyYR2onX0qmu2L+ZvvuoAEG3zd2+
 l5eumY9r87dN5BWm0bTWFYDDWi/aAAIsmk+lG7U3Rwcrx2ZANDhmx4+eH9k+0kCN0h+SjlosA4
 jKo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:03:29 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 05/39] blktrace: add trace note APIs
Date:   Wed, 24 Feb 2021 23:01:57 -0800
Message-Id: <20210225070231.21136-6-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 113 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e45bbfcb5daf..4871934b9717 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -114,6 +114,52 @@ static void trace_note(struct blk_trace *bt, pid_t pid, int action,
 	}
 }
 
+static void trace_note_ext(struct blk_trace_ext *bt, pid_t pid, u64 action,
+			   const void *data, size_t len, u64 cgid, u32 ioprio)
+{
+	struct blk_io_trace_ext *t;
+	struct ring_buffer_event *event = NULL;
+	struct trace_buffer *buffer = NULL;
+	int pc = 0;
+	int cpu = smp_processor_id();
+	bool blk_tracer = blk_tracer_enabled;
+	ssize_t cgid_len = cgid ? sizeof(cgid) : 0;
+
+	if (blk_tracer) {
+		buffer = blk_tr->array_buffer.buffer;
+		pc = preempt_count();
+		event = trace_buffer_lock_reserve(buffer, TRACE_BLK,
+						  sizeof(*t) + len + cgid_len,
+						  0, pc);
+		if (!event)
+			return;
+		t = ring_buffer_event_data(event);
+		goto record_it;
+	}
+
+	if (!bt->rchan)
+		return;
+
+	t = relay_reserve(bt->rchan, sizeof(*t) + len + cgid_len);
+	if (t) {
+		t->magic = BLK_IO_TRACE_MAGIC | BLK_IO_TRACE_VERSION_EXT;
+		t->time = ktime_to_ns(ktime_get());
+record_it:
+		t->device = bt->dev;
+		t->action = action | (cgid ? __BLK_TN_CGROUP : 0);
+		t->ioprio = ioprio;
+		t->pid = pid;
+		t->cpu = cpu;
+		t->pdu_len = len + cgid_len;
+		if (cgid_len)
+			memcpy((void *)t + sizeof(*t), &cgid, cgid_len);
+		memcpy((void *) t + sizeof(*t) + cgid_len, data, len);
+
+		if (blk_tracer)
+			trace_buffer_unlock_commit(blk_tr, buffer, event, 0, pc);
+	}
+}
+
 /*
  * Send out a notify for this process, if we haven't done so since a trace
  * started
@@ -132,6 +178,20 @@ static void trace_note_tsk(struct task_struct *tsk)
 	spin_unlock_irqrestore(&running_trace_lock, flags);
 }
 
+static void trace_note_tsk_ext(struct task_struct *tsk, u32 ioprio)
+{
+	unsigned long flags;
+	struct blk_trace_ext *bt;
+
+	tsk->btrace_seq = blktrace_seq;
+	spin_lock_irqsave(&running_trace_ext_lock, flags);
+	list_for_each_entry(bt, &running_trace_ext_list, running_ext_list) {
+		trace_note_ext(bt, tsk->pid, BLK_TN_PROCESS_EXT, tsk->comm,
+			   sizeof(tsk->comm), 0, ioprio);
+	}
+	spin_unlock_irqrestore(&running_trace_ext_lock, flags);
+}
+
 static void trace_note_time(struct blk_trace *bt)
 {
 	struct timespec64 now;
@@ -148,6 +208,22 @@ static void trace_note_time(struct blk_trace *bt)
 	local_irq_restore(flags);
 }
 
+static void trace_note_time_ext(struct blk_trace_ext *bt)
+{
+	struct timespec64 now;
+	unsigned long flags;
+	u32 words[2];
+
+	/* need to check user space to see if this breaks in y2038 or y2106 */
+	ktime_get_real_ts64(&now);
+	words[0] = (u32)now.tv_sec;
+	words[1] = now.tv_nsec;
+
+	local_irq_save(flags);
+	trace_note_ext(bt, 0, BLK_TN_TIMESTAMP, words, sizeof(words), 0, 0);
+	local_irq_restore(flags);
+}
+
 void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
 	const char *fmt, ...)
 {
@@ -185,6 +261,43 @@ void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
 }
 EXPORT_SYMBOL_GPL(__trace_note_message);
 
+void __trace_note_message_ext(struct blk_trace_ext *bt, struct blkcg *blkcg,
+	const char *fmt, ...)
+{
+	int n;
+	va_list args;
+	unsigned long flags;
+	char *buf;
+
+	if (unlikely(bt->trace_state != Blktrace_running &&
+		     !blk_tracer_enabled))
+		return;
+
+	/*
+	 * If the BLK_TC_NOTIFY action mask isn't set, don't send any note
+	 * message to the trace.
+	 */
+	if (!(bt->act_mask & BLK_TC_NOTIFY))
+		return;
+
+	local_irq_save(flags);
+	buf = this_cpu_ptr(bt->msg_data);
+	va_start(args, fmt);
+	n = vscnprintf(buf, BLK_TN_MAX_MSG, fmt, args);
+	va_end(args);
+
+	if (!(blk_tracer_flags.val & TRACE_BLK_OPT_CGROUP))
+		blkcg = NULL;
+#ifdef CONFIG_BLK_CGROUP
+	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n,
+		blkcg ? cgroup_id(blkcg->css.cgroup) : 1, 0);
+#else
+	trace_note_ext(bt, 0, BLK_TN_MESSAGE_EXT, buf, n, 0, 0);
+#endif
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL_GPL(__trace_note_message_ext);
+
 static int act_log_check(struct blk_trace *bt, u32 what, sector_t sector,
 			 pid_t pid)
 {
-- 
2.22.1

