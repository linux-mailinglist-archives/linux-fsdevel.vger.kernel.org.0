Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87ADF324AFB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhBYHK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:10:28 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13049 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbhBYHIh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237528; x=1645773528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nW/cmAEGEcgZbRtFTdFsCAsbqIyXkGA21B4Ruo36fus=;
  b=Gi3HpZ6mXi9915ZLw8kmJgStq6icuEc3qdP+wovMKmTff41OSrTvdMJw
   0zLSAVueX6m4e+LYE+mc/PFHx+3Y3SNVi/AMJ1n5PB/hK3hgbnlGXqAyW
   x6JWOGFgve4FKab1bvVEe5VjaczZsngnqe1k7PWS+Ln8luWH6PzXLmdS3
   WMQM47bt+sh4er5xiCsy5ZKr1qD0FHHeBnPZ1ijCfGhahmEqCJApRpWdj
   dfRZBmuYkPg0HN9qcmLjgTGA8nGq5wkYJ5V47zMvDXr4CDS1hDKcG0Q/P
   WdrNa1PgN0vgNZL1DG5gAejyR7CNS9V5fJr64DB3PxyXLCtczsGHYXZA5
   A==;
IronPort-SDR: Ps7tSymEFWZXg/dsOF3ActnBlDiYZ7bKeWt+LQcTCg3NJNGuuWwq8ktDg1UsoFiYf5ygIVb0+X
 Xmg+3jsvePIm4J5zivAb7i9vWD0J6DyeP0I8o6o1uFjbpNNPl/4sv0MSSTz8ftNLAhBtTgZ6az
 pjhWZAUimxILCeTRs+Tu+VB801ujehehLCZfTKgbg5ZTSCmsvYpxZd0BligcNUj+poCPSv6j1q
 8OtaNPuxBu46hv7P04pblg7ayke41eaa2ANpZ1YN3uFxnhKKJmbMyEiUdXp3ffiBhmZt4VFhPA
 AoY=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264978997"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:15:51 +0800
IronPort-SDR: zSQb9hDUteibx8kGfmRUCA+Uh6GurbINI6LD4OP/b0rOKJHH1ewn7fCk7NlgDGaf953LmibmbV
 Wp8dx3EUUt3xY64PqUo3q9vkHBSrEjN2fTI+LJWtSy13MfdTFIt0O+Fhv2IuRYP29IPTT6U9k9
 sfK7yAw2cZuKFR4BZqeyIrIasW8Qm/CSMO14xcAr2ShkbbN6y5TRl/ti9nc9tb6xdeR0xHoEE+
 Gu2ARb0LRp4Xai40p7t1PzG6RcUL39YjGHWHS3Zf3TgWgZRfezgeCgFYjz5VXpiwtOCNcq2YYT
 8VV31c+TlNIEDTsifj5Wy4hZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:48:00 -0800
IronPort-SDR: p54ivtLl1cUh8l/ibC2RBUdDuD+07LGlub+OkBDVVPqkg4UvXDGJ5dPlQflaC7lm6SYs+12QPk
 neKJpiZbmcBzEoFnaVfq9jr8hbcV8wD9JVlKXxoK28kcq/3+PvtytA+RSAxlhND1zNaSfD5QWY
 wGp/fZ8qqiFIIShgxWuxddqGwwMTJS6WPr3YtDvmc9tOcvc06OIu+AgnjPIfERxsCAK1AxaVPX
 So9RQb40cXTqprfWeByBqaeWsc/kzhhucyEoV8yFpeQHOqunrE7qsSCbRsnw6kTtC3An4pNSjH
 fSA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:06:38 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 28/39] blktrace: add blk_log_xxx helpers()
Date:   Wed, 24 Feb 2021 23:02:20 -0800
Message-Id: <20210225070231.21136-29-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 175 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 2241c7304749..425756a62457 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1905,6 +1905,23 @@ static void blk_log_action_classic(struct trace_iterator *iter, const char *act,
 			 secs, nsec_rem, iter->ent->pid, act, rwbs);
 }
 
+static void blk_log_action_classic_ext(struct trace_iterator *iter, const char *act,
+	bool has_cg)
+{
+	char rwbs[RWBS_LEN];
+	unsigned long long ts  = iter->ts;
+	unsigned long nsec_rem = do_div(ts, NSEC_PER_SEC);
+	unsigned secs	       = (unsigned long)ts;
+	const struct blk_io_trace_ext *t = te_blk_io_trace_ext(iter->ent);
+
+	fill_rwbs_ext(rwbs, t);
+
+	trace_seq_printf(&iter->seq,
+			 "%3d,%-3d %2d %5d.%09lu %5u %2s %3s ",
+			 MAJOR(t->device), MINOR(t->device), iter->cpu,
+			 secs, nsec_rem, iter->ent->pid, act, rwbs);
+}
+
 static void blk_log_action(struct trace_iterator *iter, const char *act,
 	bool has_cg)
 {
@@ -1947,6 +1964,35 @@ static void blk_log_action(struct trace_iterator *iter, const char *act,
 				 MAJOR(t->device), MINOR(t->device), act, rwbs);
 }
 
+static void blk_log_action_ext(struct trace_iterator *iter, const char *act,
+	bool has_cg)
+{
+	char rwbs[RWBS_LEN];
+	const struct blk_io_trace_ext *t = te_blk_io_trace_ext(iter->ent);
+
+	fill_rwbs_ext(rwbs, t);
+	if (has_cg) {
+		u64 id = t_cgid(iter->ent);
+
+		if (blk_tracer_flags.val & TRACE_BLK_OPT_CGNAME) {
+			char blkcg_name_buf[NAME_MAX + 1] = "<...>";
+
+			cgroup_path_from_kernfs_id(id, blkcg_name_buf,
+				sizeof(blkcg_name_buf));
+			trace_seq_printf(&iter->seq, "%3d,%-3d %s %2s %3s ",
+				 MAJOR(t->device), MINOR(t->device),
+				 blkcg_name_buf, act, rwbs);
+		} else
+			trace_seq_printf(&iter->seq,
+				 "%3d,%-3d %llx,%-llx %2s %3s ",
+				 MAJOR(t->device), MINOR(t->device),
+				 id & U32_MAX, id >> 32, act, rwbs);
+	} else
+		trace_seq_printf(&iter->seq, "%3d,%-3d %2s %3s ",
+				 MAJOR(t->device), MINOR(t->device), act, rwbs);
+}
+
+
 static void blk_log_dump_pdu(struct trace_seq *s,
 	const struct trace_entry *ent, bool has_cg)
 {
@@ -1986,6 +2032,45 @@ static void blk_log_dump_pdu(struct trace_seq *s,
 	trace_seq_puts(s, ") ");
 }
 
+static void blk_log_dump_pdu_ext(struct trace_seq *s,
+	const struct trace_entry *ent, bool has_cg)
+{
+	const unsigned char *pdu_buf;
+	int pdu_len;
+	int i, end;
+
+	pdu_buf = pdu_start_ext(ent, has_cg);
+	pdu_len = pdu_real_len_ext(ent, has_cg);
+
+	if (!pdu_len)
+		return;
+
+	/* find the last zero that needs to be printed */
+	for (end = pdu_len - 1; end >= 0; end--)
+		if (pdu_buf[end])
+			break;
+	end++;
+
+	trace_seq_putc(s, '(');
+
+	for (i = 0; i < pdu_len; i++) {
+
+		trace_seq_printf(s, "%s%02x",
+				 i == 0 ? "" : " ", pdu_buf[i]);
+
+		/*
+		 * stop when the rest is just zeroes and indicate so
+		 * with a ".." appended
+		 */
+		if (i == end && end != pdu_len - 1) {
+			trace_seq_puts(s, " ..) ");
+			return;
+		}
+	}
+
+	trace_seq_puts(s, ") ");
+}
+
 static void blk_log_generic(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
 	char cmd[TASK_COMM_LEN];
@@ -2005,6 +2090,28 @@ static void blk_log_generic(struct trace_seq *s, const struct trace_entry *ent,
 	}
 }
 
+static void blk_log_generic_ext(struct trace_seq *s,
+				const struct trace_entry *ent,
+				bool has_cg)
+{
+	char cmd[TASK_COMM_LEN];
+
+	trace_find_cmdline(ent->pid, cmd);
+
+	if (t_action(ent) & BLK_TC_ACT_EXT(BLK_TC_PC)) {
+		trace_seq_printf(s, "%u ", t_bytes_ext(ent));
+		blk_log_dump_pdu_ext(s, ent, has_cg);
+		trace_seq_printf(s, "[%s]\n", cmd);
+	} else {
+		if (t_sec_ext(ent))
+			trace_seq_printf(s, "%llu + %u [%s]\n",
+						t_sector_ext(ent),
+						t_sec_ext(ent), cmd);
+		else
+			trace_seq_printf(s, "[%s]\n", cmd);
+	}
+}
+
 static void blk_log_with_error(struct trace_seq *s,
 			      const struct trace_entry *ent, bool has_cg)
 {
@@ -2022,6 +2129,23 @@ static void blk_log_with_error(struct trace_seq *s,
 	}
 }
 
+static void blk_log_with_error_ext(struct trace_seq *s,
+			      const struct trace_entry *ent, bool has_cg)
+{
+	if (t_action_ext(ent) & BLK_TC_ACT_EXT(BLK_TC_PC)) {
+		blk_log_dump_pdu_ext(s, ent, has_cg);
+		trace_seq_printf(s, "[%d]\n", t_error_ext(ent));
+	} else {
+		if (t_sec_ext(ent))
+			trace_seq_printf(s, "%llu + %u [%d]\n",
+					 t_sector_ext(ent),
+					 t_sec_ext(ent), t_error_ext(ent));
+		else
+			trace_seq_printf(s, "%llu [%d]\n",
+					 t_sector_ext(ent), t_error_ext(ent));
+	}
+}
+
 static void blk_log_remap(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
 	const struct blk_io_trace_remap *__r = pdu_start(ent, has_cg);
@@ -2033,6 +2157,18 @@ static void blk_log_remap(struct trace_seq *s, const struct trace_entry *ent, bo
 			 be64_to_cpu(__r->sector_from));
 }
 
+static void blk_log_remap_ext(struct trace_seq *s, const struct trace_entry *ent,
+		bool has_cg)
+{
+	const struct blk_io_trace_remap *__r = pdu_start_ext(ent, has_cg);
+
+	trace_seq_printf(s, "%llu + %u <- (%d,%d) %llu\n",
+			 t_sector_ext(ent), t_sec_ext(ent),
+			 MAJOR(be32_to_cpu(__r->device_from)),
+			 MINOR(be32_to_cpu(__r->device_from)),
+			 be64_to_cpu(__r->sector_from));
+}
+
 static void blk_log_plug(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
 	char cmd[TASK_COMM_LEN];
@@ -2042,6 +2178,16 @@ static void blk_log_plug(struct trace_seq *s, const struct trace_entry *ent, boo
 	trace_seq_printf(s, "[%s]\n", cmd);
 }
 
+static void blk_log_plug_ext(struct trace_seq *s, const struct trace_entry *ent,
+		bool has_cg)
+{
+	char cmd[TASK_COMM_LEN];
+
+	trace_find_cmdline(ent->pid, cmd);
+
+	trace_seq_printf(s, "[%s] %llu\n", cmd, get_pdu_int_ext(ent, has_cg));
+}
+
 static void blk_log_unplug(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
 	char cmd[TASK_COMM_LEN];
@@ -2051,6 +2197,16 @@ static void blk_log_unplug(struct trace_seq *s, const struct trace_entry *ent, b
 	trace_seq_printf(s, "[%s] %llu\n", cmd, get_pdu_int(ent, has_cg));
 }
 
+static void blk_log_unplug_ext(struct trace_seq *s, const struct trace_entry *ent,
+		bool has_cg)
+{
+	char cmd[TASK_COMM_LEN];
+
+	trace_find_cmdline(ent->pid, cmd);
+
+	trace_seq_printf(s, "[%s] %llu\n", cmd, get_pdu_int_ext(ent, has_cg));
+}
+
 static void blk_log_split(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
 {
 	char cmd[TASK_COMM_LEN];
@@ -2061,6 +2217,16 @@ static void blk_log_split(struct trace_seq *s, const struct trace_entry *ent, bo
 			 get_pdu_int(ent, has_cg), cmd);
 }
 
+static void blk_log_split_ext(struct trace_seq *s, const struct trace_entry *ent, bool has_cg)
+{
+	char cmd[TASK_COMM_LEN];
+
+	trace_find_cmdline(ent->pid, cmd);
+
+	trace_seq_printf(s, "%llu / %llu [%s]\n", t_sector_ext(ent),
+			 get_pdu_int_ext(ent, has_cg), cmd);
+}
+
 static void blk_log_msg(struct trace_seq *s, const struct trace_entry *ent,
 			bool has_cg)
 {
@@ -2070,6 +2236,15 @@ static void blk_log_msg(struct trace_seq *s, const struct trace_entry *ent,
 	trace_seq_putc(s, '\n');
 }
 
+static void blk_log_msg_ext(struct trace_seq *s, const struct trace_entry *ent,
+			bool has_cg)
+{
+
+	trace_seq_putmem(s, pdu_start_ext(ent, has_cg),
+		pdu_real_len_ext(ent, has_cg));
+	trace_seq_putc(s, '\n');
+}
+
 /*
  * struct tracer operations
  */
-- 
2.22.1

