Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA426324AF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbhBYHKE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:10:04 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5434 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhBYHIQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:08:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237498; x=1645773498;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YIrjN8J8y0s9FmEZoq8v2vDrrP7j1iwQGvx1511RvM8=;
  b=MiQjW7HrPlWMsC2TtRmm7Kk52bybTugl9IdVDCWlWBOimCfWog81btCS
   bwNHELFUG0PybaRyWgR1ME1MTPeLlto5yajyBVg37FLBBeVXb89ZkN2H/
   0vju4/3qIQZINvA71DfxhSNUxKhV41IVcvGNJoN66cPTaVq362CJMwH19
   +o11TPz6mkjGfLbOx3dgM2QslhIHsaOS+CJdw7SS7YJVer9WfC879BPJB
   GKrDwyt3n5NaJXQm4RMlzudgoSMQAgcPToVhWatkeOPNXCLW7AkNKFnaY
   bGPEo7B9A/9jTugMBPlx6TYgqGvOK135gkaHZo4eDi8IBbfAWVDpAFZ9W
   w==;
IronPort-SDR: +1h4R6smeg+45su5EgT+5LpN/tx8RcACASjTK+7uTN3Eq/WCEiS1e+AEPKTmhoJ2AfP/Izx7i5
 ZRXNr0wro/EGtnClTz99I9TtXg+4ErO92mshNqRGLdl4aovYi+ahlQNTxeYp2voQMtDg78J1gK
 XpGappSvzU5HF3QkPFuK7U74a3C5OJ/BYQizr2iqjQUtk4sbHi/Ov1ekVcgHgU9nkkyQf+jidZ
 clCge735Igtza8PsUQ/blapcxnHmXOfSuafujOn8iy5IrmusC5rSnKdJmOPRKsLl5yKyRfnwSh
 mNU=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264978989"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:15:28 +0800
IronPort-SDR: VrXXPoZ0VK1+WM50WzFRfyWMp2fT1hrjepAOm2JxRphdwh8LW+C5uTm5ijPRKv+tmm9dqDQ4yj
 ICTHTW05Ago1uYemcPrv0T785EIxJTiIFMRTnQBUi3zdpy4X6Oo2E2HbfLzZlggBAB2cMH9S3Y
 G0BF5LcWbAr4jNS9XcG/fejoa+IsQ7itBEmXUw8RUa7xrIKQuu/H7bEV5BnvfkwbPlDZl47FsA
 IHgM8fN9Hl93wg4PiwIupdKqGsbETvnRLOyvWZi1wUccmI2zbVNh86HppUNvh8Noq3357sZYt1
 /i8Rf8wK+MJ+bz0COlGFvD4A
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:47:44 -0800
IronPort-SDR: Snxudnct31WEUyWcEiTZX+P6QojNkpwGT+jQAojQqESUryUG5GpUnkVB9ppN/nGdzexmeRFF2m
 cGymp1c/Pijje14xIa4B6T5W89XjAfpk0KKPe3zY4/iAsWwdcIyYnnL3ESfOUMJRXDniuPA37R
 W74KpFbSiE4/s6fCcTJ+UNdNZ6A/AHxodIpRG2KekabU1hWc9qCACB10Y+lxrDP6eN+znsZBs/
 eKkXyhyl7u6KTmIh/TXpHsgPQXJ8DcIyTU/ct67pU0UmoAJLnym/jcI+XwIayYlrT3ZIuK0tBz
 Cuk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:06:23 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 26/39] blktrace: add trace entry & pdu helpers
Date:   Wed, 24 Feb 2021 23:02:18 -0800
Message-Id: <20210225070231.21136-27-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1f9bc2eb31da..84bee8677162 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1728,52 +1728,107 @@ const struct blk_io_trace *te_blk_io_trace(const struct trace_entry *ent)
 	return (const struct blk_io_trace *)ent;
 }
 
+static inline
+const struct blk_io_trace_ext *te_blk_io_trace_ext(const struct trace_entry *ent)
+{
+	return (const struct blk_io_trace_ext *)ent;
+}
+
 static inline const void *pdu_start(const struct trace_entry *ent, bool has_cg)
 {
 	return (void *)(te_blk_io_trace(ent) + 1) + (has_cg ? sizeof(u64) : 0);
 }
 
+static inline const void *pdu_start_ext(const struct trace_entry *ent, bool has_cg)
+{
+	return (void *)(te_blk_io_trace_ext(ent) + 1) +
+		(has_cg ? sizeof(u64) : 0);
+
+}
+
 static inline u64 t_cgid(const struct trace_entry *ent)
 {
 	return *(u64 *)(te_blk_io_trace(ent) + 1);
 }
 
+static inline const void *cgid_start_ext(const struct trace_entry *ent)
+{
+	return (void *)(te_blk_io_trace_ext(ent) + 1);
+}
+
 static inline int pdu_real_len(const struct trace_entry *ent, bool has_cg)
 {
 	return te_blk_io_trace(ent)->pdu_len - (has_cg ? sizeof(u64) : 0);
 }
 
+static inline int pdu_real_len_ext(const struct trace_entry *ent, bool has_cg)
+{
+	return te_blk_io_trace_ext(ent)->pdu_len -
+			(has_cg ? sizeof(u64) : 0);
+}
+
 static inline u32 t_action(const struct trace_entry *ent)
 {
 	return te_blk_io_trace(ent)->action;
 }
 
+static inline u64 t_action_ext(const struct trace_entry *ent)
+{
+	return te_blk_io_trace_ext(ent)->action;
+}
+
 static inline u32 t_bytes(const struct trace_entry *ent)
 {
 	return te_blk_io_trace(ent)->bytes;
 }
 
+static inline u32 t_bytes_ext(const struct trace_entry *ent)
+{
+	return te_blk_io_trace_ext(ent)->bytes;
+}
+
 static inline u32 t_sec(const struct trace_entry *ent)
 {
 	return te_blk_io_trace(ent)->bytes >> 9;
 }
 
+static inline u32 t_sec_ext(const struct trace_entry *ent)
+{
+	return te_blk_io_trace_ext(ent)->bytes >> 9;
+}
+
 static inline unsigned long long t_sector(const struct trace_entry *ent)
 {
 	return te_blk_io_trace(ent)->sector;
 }
 
+static inline unsigned long long t_sector_ext(const struct trace_entry *ent)
+{
+	return te_blk_io_trace_ext(ent)->sector;
+}
+
 static inline __u16 t_error(const struct trace_entry *ent)
 {
 	return te_blk_io_trace(ent)->error;
 }
 
+static inline __u16 t_error_ext(const struct trace_entry *ent)
+{
+	return te_blk_io_trace_ext(ent)->error;
+}
+
 static __u64 get_pdu_int(const struct trace_entry *ent, bool has_cg)
 {
 	const __be64 *val = pdu_start(ent, has_cg);
 	return be64_to_cpu(*val);
 }
 
+static __u64 get_pdu_int_ext(const struct trace_entry *ent, bool has_cg)
+{
+	const __u64 *val = pdu_start_ext(ent, has_cg);
+	return be64_to_cpu(*val);
+}
+
 typedef void (blk_log_action_t) (struct trace_iterator *iter, const char *act,
 	bool has_cg);
 
-- 
2.22.1

