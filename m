Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7D0324B14
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhBYHNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:13:17 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:5434 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233938AbhBYHKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:10:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237703; x=1645773703;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qELsFddYf/fZidR2F4nWrGgbbzisn0TnUODqE1wzd5c=;
  b=KK3+F1DVazhWSCN8fEN4KeAc2nNxhw4NaCh+AA7qxdfDOVFxdwVptBr2
   o1A3Vi9gBIdPtMp6hb7D9qu38Wg7t1+S+MhBLoz0l3GECzldpcGlAinu5
   wBWVBWvhtIh7GuGnTSQhFucvtvKwJ6X85hAV9CdfgtQmD0Mw+tICC5lhY
   0FPncYhXL0vyJ+R8/YKPoOcckSdc/tIjPyS1QBl/EEXGAF4Kl4+a/oJuA
   gxwC2vR6W7U/cg1910idH2masHAHiZjRoe6VNjT5IeKWxp7Lk6Ne0uG1N
   INxdkNVQU7Gippn+Gf3BNIlTet6RiusJquj2MYxIpi/MIz3vHNJAhNraz
   w==;
IronPort-SDR: +jLz/R4w7Sq0TKfJTcjsqN5sLuk4VjYt79Y1Qxifn/oaIYUMIT4mE7PVwYEtFGy/4XMRrQvooi
 ylo58BrhhgYeayFaq1TKbwcfSNDUprmK9BmhUwGbODdSg8Rp4sJsVtLQZFnqj+dj5d/oR3lRmB
 hlghH6OJ4HJuTCGRFmRCSpF4LXykvc7Z1Pj/cSUINzZ5/MYTCaXJPmxu6gOJ/0meYHrzkIbtVD
 zAz8pvFLAR/7oGX8GBOqCNhy8FgJ2wgpqa0tPCNuiVRihZYqU9aQNFA8CDcuqidHg8nqNALwFI
 9iw=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264979019"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:16:14 +0800
IronPort-SDR: AFsHqhGAozGpbCPqpMs6v1fKIwznRauQ7wfZa1lg3CJvQ5nsWqSW1gLG+qWvnmy/I7ozs+Wnge
 +8A1ZArxZYl3tMX7BwFnykEiiAsoRx1/4DxcpIu6ow0nCGQr+TrVgaSnGip35Oe+C/g/+eS4p1
 tcYO1lDzNqqnWKVL+kAoQbwxFrcRe7YMYGe8JoC1vuEHpdwB3SuGTS396fTjxvZQwojJKvNXk5
 nRQv3vUtzAZ+F0iwINm8M91AJsit4TK56sZa+ZVEtN3oB0lu2h/MfLRj3Q4IqrCN6TErAI6UqX
 cT4mM/afnoIBmLxQ+qCTmGnW
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:50:09 -0800
IronPort-SDR: PQVvuUl0urV+AuHXoztIv2ko4ec5dnFXGMemj8nj98xLSxNSzY+fPjPQsEHPXi+DWIf/mEpthf
 lxggagRReXwz2a3qn1VtF0ulgngisTFgDc8GARpNPqvFCmSjwrqNPYJBYWQmXJuwJW1I+jcOfi
 mBefp/964dE3h3HgCffZkJDMNQ+Y2CTcG3X9wPYJRI/aNXIxvpkFSZCvBPjh/0AQZ9CcjAywMA
 VsiZcNWe2+YTYB+oTNZV9z4YznZH7rcm2BK8z8DwmhzxhVgCmg+FR6smll6MEDUYZv4HormmV6
 /k8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:06:53 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 30/39] blktrace: add trace event print helper
Date:   Wed, 24 Feb 2021 23:02:22 -0800
Message-Id: <20210225070231.21136-31-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 4a4ba1d45cb9..75b2ec88d8c4 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2356,12 +2356,51 @@ static enum print_line_t print_one_line(struct trace_iterator *iter,
 	return trace_handle_return(s);
 }
 
+static enum print_line_t print_one_line_ext(struct trace_iterator *iter,
+					bool classic)
+{
+	struct trace_array *tr = iter->tr;
+	struct trace_seq *s = &iter->seq;
+	const struct blk_io_trace_ext *t;
+	u32 what;
+	bool long_act;
+	blk_log_action_t *log_action;
+	bool has_cg;
+
+	t	   = te_blk_io_trace_ext(iter->ent);
+	what	   = (t->action & ((1ULL << BLK_TC_SHIFT_EXT) - 1)) & ~__BLK_TA_CGROUP;
+	long_act   = !!(tr->trace_flags & TRACE_ITER_VERBOSE);
+	log_action = classic ? &blk_log_action_classic_ext : &blk_log_action_ext;
+	has_cg	   = t->action & __BLK_TA_CGROUP;
+
+	if ((t->action & ~__BLK_TN_CGROUP) == BLK_TN_MESSAGE_EXT) {
+		log_action(iter, long_act ? "message" : "m", has_cg);
+		blk_log_msg_ext(s, iter->ent, has_cg);
+		return trace_handle_return(s);
+	}
+
+	if (unlikely(what == 0 || what >= ARRAY_SIZE(what2act_ext)))
+		trace_seq_printf(s, "Unknown action %x\n", what);
+	else {
+		log_action(iter, what2act_ext[what].act[long_act], has_cg);
+		what2act_ext[what].print(s, iter->ent, has_cg);
+	}
+
+	return trace_handle_return(s);
+}
+
 static enum print_line_t blk_trace_event_print(struct trace_iterator *iter,
 					       int flags, struct trace_event *event)
 {
 	return print_one_line(iter, false);
 }
 
+static enum print_line_t blk_trace_event_print_ext(struct trace_iterator *iter,
+					       int flags, struct trace_event *event)
+{
+	return print_one_line_ext(iter, false);
+}
+
 static void blk_trace_synthesize_old_trace(struct trace_iterator *iter)
 {
 	struct trace_seq *s = &iter->seq;
-- 
2.22.1

