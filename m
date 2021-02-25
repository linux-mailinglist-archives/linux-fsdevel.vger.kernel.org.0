Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2764E324AF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbhBYHKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:10:08 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:4515 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbhBYHIZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236904; x=1645772904;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1hBv8Gu4qfS+3fsLLBjregm8reryLOBw/ybrB5vLfFM=;
  b=hh5BCxDhIdlQRkZEY1Z9QFxD1q9NNgXT8qPgJrWO/6BvpW9bmgNlFhiB
   MrIo9CiQBLCDHfZ/sD9/pwM5Fr7VKvBc0XNw2XBcq31+Iuv4uoD0TF44i
   9/NlCgjEmN5XD7ugd63gLcNPEeCiguPE4glemmPS7CMBRuv8KtngY+f6h
   GSdaxTfT37Ms3yKHVpnsS8JTH8HEv0/EkXaG6IN0pqtau2wvtxROszRp/
   Of/XsnrdO9lQ5PnwTFq1iBDJK02NRD5+F83U5opVfOj24634+0IUysv55
   59/RjIlVBGB9CgDpHyqa7/GbBIZDYOouJecCKStuX19a9IsAsWrGbDJ3o
   Q==;
IronPort-SDR: zGxBJxxQrDDdC0ucph/RfmrlfTaJvE+vEAn7evILrLtpVlg7CLKRZz/edzmU0NvDAUEb6tNgza
 E+WHAPtGfA2RjAZm6kJrmb1ylw75scoJs52w2Q8UsRiIqfrCSOKBcilpJW7MHg/a+cfY1gpQMH
 3T3kOJ1uv3hsjVnFBnTm9QiO+9qcUEVzKfIGpP5f55Wno3gTeEdPfhYSv/3fWyMQ5ytgIfa0Me
 ImfBWYUzGaCRYRTjfdrTD6aWz44gXJylxAriv3jcc/E0xsvClaF2eAADlnVKpmFBJiVF31eIKT
 +oA=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="271319252"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:07:16 +0800
IronPort-SDR: 0uoramwMAK5nO91+krnq9wy/JMpUFv2o1OEjLhYsBd5x7eVLqwrULfT9e17H8RSvM8uVXIpzjR
 YOVMek6wUTsV1o8bP4ADpc1X8Jliocjjqf7V33QUWHVGME77lW2jXX6zap6le14+b68SuvyfuC
 7gvCorzsUIxhBRB7XSh/3GSoJhlIDFCNQbzjl0Vhn9q0m8yLB5qOjmM1sYcjFm8fpHns+mNQ7U
 Yhvq8/1d0CCZNVyhYHL4EuoEPeTmguALgfKQBYBDmUOqu+F662Lz0ymVvmBdlFog0qYMBapGSh
 jWTuzAZMax5D+/q+jLRVy9TY
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:48:38 -0800
IronPort-SDR: tTkqodW0+y/1iCCApd6wfSVWRetFjKjxI+gnXFyP8IMFdCZjLziwK1eUJixyaalCKBKexVMApX
 LtQx1fqtoA7r9H96areCy7K00hwXk1fvRlf2QB6iNDw8vM+1a+UfN4Gnp2EPhcmr+MILCQgeNq
 +G/bBLGGkQdlkz7o92uszxZY1V+h/BJXGshCY8ykmt6h0+ob0lVROC//GO7OSxzyg+L47/fUS1
 cmHfxubD+Sxz831jFiWZjQgyibvUF9kyZXBG1uBascPLcwKdTN74/jcSo/GQdLYMRfFdiAXtP3
 ZOQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:07:16 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 33/39] blktrace: add blkext tracer
Date:   Wed, 24 Feb 2021 23:02:25 -0800
Message-Id: <20210225070231.21136-34-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 47 ++++++++++++++++++++++++++++++++++++++---
 kernel/trace/trace.h    |  1 +
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 53bba8537294..f707ebde0062 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -2490,18 +2490,42 @@ static struct tracer blk_tracer __read_mostly = {
 	.set_flag	= blk_tracer_set_flag,
 };
 
+static struct tracer blk_tracer_ext __read_mostly = {
+	.name		= "blkext",
+	.init		= blk_tracer_init,
+	.reset		= blk_tracer_reset,
+	.start		= blk_tracer_start,
+	.stop		= blk_tracer_stop,
+	.print_header	= blk_tracer_print_header,
+	.print_line	= blk_tracer_print_line_ext,
+	.flags		= &blk_tracer_flags,
+	.set_flag	= blk_tracer_set_flag,
+};
+
 static struct trace_event_functions trace_blk_event_funcs = {
 	.trace		= blk_trace_event_print,
 	.binary		= blk_trace_event_print_binary,
 };
 
+static struct trace_event_functions trace_blk_event_funcs_ext = {
+	.trace		= blk_trace_event_print_ext,
+	.binary		= blk_trace_event_print_binary_ext,
+};
+
 static struct trace_event trace_blk_event = {
 	.type		= TRACE_BLK,
 	.funcs		= &trace_blk_event_funcs,
 };
 
+static struct trace_event trace_blk_event_ext = {
+	.type		= TRACE_BLK_EXT,
+	.funcs		= &trace_blk_event_funcs_ext,
+};
+
 static int __init init_blk_tracer(void)
 {
+	int ret = 0;
+
 	if (!register_trace_event(&trace_blk_event)) {
 		pr_warn("Warning: could not register block events\n");
 		return 1;
@@ -2509,11 +2533,28 @@ static int __init init_blk_tracer(void)
 
 	if (register_tracer(&blk_tracer) != 0) {
 		pr_warn("Warning: could not register the block tracer\n");
-		unregister_trace_event(&trace_blk_event);
-		return 1;
+		goto unregister_trace_event;
 	}
 
-	return 0;
+	if (!register_trace_event(&trace_blk_event_ext)) {
+		pr_warn("Warning: could not register block events\n");
+		/* unregister blk_tracer */
+		goto unregister_trace_event;
+	}
+
+	if (register_tracer(&blk_tracer_ext) != 0) {
+		pr_warn("Warning: could not register the block tracer\n");
+		goto unregister_trace_event_ext;
+	}
+out:
+	return ret;
+
+unregister_trace_event_ext:
+	unregister_trace_event(&trace_blk_event_ext);
+unregister_trace_event:
+	unregister_trace_event(&trace_blk_event);
+	ret = 1;
+	goto out;
 }
 
 device_initcall(init_blk_tracer);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e448d2da0b99..8bb010753a17 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -42,6 +42,7 @@ enum trace_type {
 	TRACE_GRAPH_ENT,
 	TRACE_USER_STACK,
 	TRACE_BLK,
+	TRACE_BLK_EXT,
 	TRACE_BPUTS,
 	TRACE_HWLAT,
 	TRACE_RAW_DATA,
-- 
2.22.1

