Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C811F324ACA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232237AbhBYHGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:06:21 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14053 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232196AbhBYHFe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:05:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236733; x=1645772733;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eg2fGoq9LGHNhr856Wi8sTcdeuBXuyQcrnLuJl0Hsuw=;
  b=aByuaKw0XAPRKMbZ/8Wtvuq4EznNFcW1HCTWXe1uosi6OTm2gB76ZERM
   QDnLuvLEGXlDorRVCgSuwyUhrqjDPS8haPQjASm7lIOzIzO9VXs6jy72u
   wBrD5xaPOSgmC/6Wfkm0PrUve06SPTJeu0+FHS2svQn02M3EyOFNk8333
   m/iOXcYUeXyrPDcZFIRZ1HLGuAG9j/MxargJ/V7A7eM0nIXeba4gHQ3u8
   /tiiG+vOGghEoWaek4cRaZR0liprAR/+oIBeFyNhhRoWSAFP/37ZAB2H7
   xC9jTNt/cY5NeCwnfzAfVPe4gPnfMCyG9GjbxvO/leaNiCh+dxHtC8Ffp
   Q==;
IronPort-SDR: OfTcfNGgK8bgJvQl6FjSl6/aZhKGeNllMPvF4NUDO478l+E/NiFlq/G1VjUY/t/6UupCCMObRo
 RVUCA0Ptb0jIR7ywljOEezSHfY8hy1itu3m6MRVoyLAvhwyuJt21lxDRR9pRR8OWxyU28sH57J
 4GzeAQMbT70hPV2C9Aiqk9efEJGVq1HXhiGtuNpXLC3zlUtnA0NCMSVqxKmdeNMQ8Ef4CTQyWP
 tly/Vznu7VeN+iVQ63T/iZnWVi66B3GBINF9OXbpat8m3I6sbdEs2abHhwTTIGcyh/CzAL/8xb
 iDo=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160751685"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:04:04 +0800
IronPort-SDR: Y4xQ6bMoIXmw8tIhb3BqsKrywbE/mzNfI0T+H5y+nKcGZjoFa1FdTIdM9KnqNOPMxljk2Y6mVI
 O2rE0Jj0nW7WQb1/SxyzZCkjRyLrd/bPyein0K907Zdv/gXDwWWKhB9Wp/yoT+10ZmPYDG13jd
 TCcEbJgb7KcONhDTCL93gDMbMGFzXs41a1R8g6Ee4OjkgvZgm8BskCaIjr3YzLkw4DoW/ZryVK
 KMES+vvvQmXNRK9dFjg34os+chmz1Jl2cRES9Wew3qVzLm4oUFM/YFyHB5bbFbDtdPrClFkHb8
 KnzJa55t4Z5eZR1jZriMT5xV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:47:20 -0800
IronPort-SDR: oFAB9j2Iw25emAnehabNGsmkCSyWETo8/m45CNp6X8Lse0u4pJh4os7tWT5Oph4QDkKlYYYNDS
 39g+agCKH2+H36ZhjWnkN7BPSJ2AND31f205r/40ps5BiZlJzrNPtN+qTF1jF5cQRpEKUEhv2x
 DNxV9+74lrnlc8V+61CaxbcXcTqp0HJZHbvhFvJd74ls/k0Pm/9lL3xCO00p4jGTrx/k7LEsJK
 WNxVh7DKcrfuKKQuw68lGpyoH5WJy8CCRGwj89gSp4hE77EhVpzpVuk1zRe+cgMl9BTqxZxRfN
 BpA=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:04:04 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 09/39] blktrace: update blk_add_trace_rq_insert()
Date:   Wed, 24 Feb 2021 23:02:01 -0800
Message-Id: <20210225070231.21136-10-chaitanya.kulkarni@wdc.com>
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
index 280ad94f99b6..906afa0982c2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1134,7 +1134,25 @@ static void blk_add_trace_rq(struct request *rq, int error,
 
 static void blk_add_trace_rq_insert(void *ignore, struct request *rq)
 {
-	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_INSERT,
+	u64 ta = 0;
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
+		ta = BLK_TA_INSERT;
+	} else if (bte) {
+		ta = BLK_TA_INSERT_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), ta,
 			 blk_trace_request_get_cgid(rq));
 }
 
-- 
2.22.1

