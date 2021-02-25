Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3481C324ACF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhBYHGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:06:38 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13049 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhBYHFf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237255; x=1645773255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UrkLJRrs1lnD9LqgYlpTtfqj+52EYKJ9/MSNX1BWZfM=;
  b=lTEuqchBHA7fdPDiumW/1pEMai09Rr6OvTxpbQwhIjUzQ3YcY3IhCYvr
   YKrqJa/XyUizZ04K79qzaZCunxKYciIwdp16vlK46AAqQZebWibEti3x8
   3Ezpbet9B/cEuBVIY8LRaZLm5bWux8YLsYS7Ru0jOHdj9l5EiFrRU8+1f
   sHRXaOGcliWmxfFDDj74RdvqsSuxSehnO0ljVJyiIPX7keXdR8XK1s2G1
   mJWXY1SR495iEJ4erhySvMmDNgll+KooYHBbYGF9IkOP+86lWBkRYG3R/
   xtpUdNDg617RgfVLmMBpBTnYVlIEJPS7FwSirgVg126Dq/xAsSNMPHYOk
   w==;
IronPort-SDR: +SJxXmBxfPRfPpQ7RHbYnEYxZvvSin4IHj7qnS12tOFw343+TwOm3IpiARg7jgMrT4tGc3cqKY
 jTqGJR29nnPsKdeDQFyJTasNcK8U2HAahOa9zGtToO5YX6v+hQswx7cx4fBRBkDf+uCQumWaGL
 Xd2Naw/jMAIebOncclrPJtqxkYlTPVUr8kMo6OlFJ3P86tpwkcVdfFL6Wh2qoL+jm0zs9ZxciU
 dXYXBPxXtfEkhQrWpAQ2iYnLQOWq5SkpVgJzvTFGrRPHeg7AGDSdiq2QwbwyjL7qoIqpalcI8V
 3SY=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264978837"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:12:12 +0800
IronPort-SDR: 4CUeEASSTR4Uss64K5Fq+0Bt+W1LeMpYusHF45L0HJsW7nM7qTnClrVxDrrqKmJ523Sz9eLr4W
 0suqbkX0bDqfTKT6nRwwPwrX5MvvI1CH3QlNDxlAaVS3UgQf6vlo5e5R5Lc433SncazDD5PFCJ
 AzlHGEGU/EEAL3aTOFJfCziQr5xHMGjizjUMvcmIE7wQKVPwo/u/8dWS2fnyxEE3r6zGfSADGi
 MpJyBUBHgHLTKQUIxwPPfhAGP68F1UDb0is+MJ/uCSCVvsI3YT7O7xvIADoyIqFD76xmv7qWkZ
 QVifGWVlF8wGWWCY53M6jrPx
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:47:29 -0800
IronPort-SDR: Zl81cQDbLFnJjbZTlvLnrD6Ew73F5BR/Ye1TJvXMPlaipyAYtm4aYrO7i3KDhn40nvbpbhpocp
 bEiw1n8emCshrkLq2tBK+lO+J1cCsou+EoLL9awDw3ZS+x/lV96F/IiV19lViFY6omqr4+imOE
 R7MAbg2lEHyBSwszt8sG9VVidC3RcL3ZGsCA+Joco2cXzvjryqZJilDb82kR+s7lsTGjkw0f5E
 Iw/IyxPiPeP3OUucRrzdFojQlG7eQv8Ep359GvznxFd/kERMsEnOe8qOULwKiCsv566YgD6Nmf
 pkM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:04:13 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 10/39] blktrace: update blk_add_trace_rq_issue()
Date:   Wed, 24 Feb 2021 23:02:02 -0800
Message-Id: <20210225070231.21136-11-chaitanya.kulkarni@wdc.com>
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
index 906afa0982c2..e1646d74ac9a 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1158,7 +1158,25 @@ static void blk_add_trace_rq_insert(void *ignore, struct request *rq)
 
 static void blk_add_trace_rq_issue(void *ignore, struct request *rq)
 {
-	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_ISSUE,
+	u64 ta;
+	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
+
+	rcu_read_lock();
+	bt = rcu_dereference(rq->q->blk_trace);
+	bte = rcu_dereference(rq->q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	if (bt) {
+		ta = BLK_TA_ISSUE;
+	} else if (bte) {
+		ta = BLK_TA_ISSUE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), ta,
 			 blk_trace_request_get_cgid(rq));
 }
 
-- 
2.22.1

