Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 883C7324AD3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhBYHHI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:07:08 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13993 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBYHFy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236752; x=1645772752;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zX5u0LGVFFUDJJ8B1co7L0h1Qj5Ehc3inMJ8ZLgIl1c=;
  b=jKrwKdzo/7mZ3WtBBYLc2uFJdf+nLFWVASj/yTWpcIboBwad1sDpKalU
   ta6gHZF9b5VKGUxQjKSpojhZ6uBSmFSVbXPXfUZVRHxbZ7IMnQIA0+c5W
   lbi343Ne9ahI9mELky7EZ8M+89BQn5Wjt4v9nWkZxIAyz0OWv15fDe9Y7
   W9YEeKyu0e8UIiJdEOcamY2JrHnufE7Bcv3Jyw75dMBH6TFTDkqxM1Ond
   +dn/zTmwigeoM4QAyXRCI2o67hTaV4Sl6dmZjQZ37ROZqxHXtBQITP+1Y
   iye3IJY2GJKlLbR7uQcTZNNgo4Vlsr2DAihqAkBRo+CTQscxeV8DBfQZb
   Q==;
IronPort-SDR: PrhtrCCNo8yg0EJ610XmTrxf2GB4eDTb/4nS7s9OdyMe+jvPEy/YNkCsWkb0UaU27lpzrKHFw4
 4cR17VgSidUvUrka56IAgxcxNepA7vHQiJdWWVBi7aeQQvNyz6DiGhmnm5Ki28Si3mO2I04Ks7
 YYllqG1mX4C1DhO3NjO9NaKZ8joNT81YJs8LbdDpM9DzEQzokK8x9yK3/lGJvj7wOJZ5wPTsOr
 In3Qt7pntMjWCCHM4aFNv1M6HhoDGX39hygy4M84TZkoTZiGBhlSCfTCfS7TDBDXur7/YFnw09
 p+4=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160751717"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:04:23 +0800
IronPort-SDR: VnFEYYatB/sNso+/0b+MIAtsHbDRFdUwrIDLcWArwtMrNZ3mnu6LdHtfxUftd/WVWW50VjRtxQ
 YHsrRE6hPiB233nLMIb9L+WGPKPI8agG4i1Bw754IK/VTTOd3AVOJ+u01t+xgy/99l0cIhViwS
 UbmeOuToEC55r4DSA2c6WEX8Qq5J11b0iwQQzcATGakUAgixacBfMTXDgQLLBF7ZetWgkyK0wo
 9m3TAFZjBFw6qh091u/ugF72uPH6enLdPWvm6bY7uOWubFvDusUzn8iVBVovJHhLhWOKK8lJoD
 IFQ82npZLI0m4IND4jKLSRn4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:47:38 -0800
IronPort-SDR: b6D3DJ2Y/kk6gNN5eORP+52pxYzmVI5Ds+/VMwpHylQgt3DiU8fh2pQp0DOzzSqO+dceFu6tUX
 aoiAMzk45FSmXILPfpz5jtHZar/G5oTO+GC3MjzgzM9Z16Met/XeFyGmq8SS0sSu1BCy95YgEo
 4kgHSefPuyxvh21KwXoZWwvACWcl2/WTUeSzMslqQF9h8mUjMBjvhWy/f3ZdeAoWMlKNDSiGiY
 w5SwvI4Ma/1icgaGtxLd0sruHWwbainJwlQR4MSDl4wPdVXH2hycAixWsLtQ+m3BjJl+31smQd
 kP8=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:04:22 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 11/39] blktrace: update blk_add_trace_rq_requeue()
Date:   Wed, 24 Feb 2021 23:02:03 -0800
Message-Id: <20210225070231.21136-12-chaitanya.kulkarni@wdc.com>
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
index e1646d74ac9a..8a7fedfac6b3 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1188,7 +1188,25 @@ static void blk_add_trace_rq_merge(void *ignore, struct request *rq)
 
 static void blk_add_trace_rq_requeue(void *ignore, struct request *rq)
 {
-	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), BLK_TA_REQUEUE,
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
+		ta = BLK_TA_REQUEUE;
+	} else if (bte) {
+		ta = BLK_TA_REQUEUE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_rq(rq, 0, blk_rq_bytes(rq), ta,
 			 blk_trace_request_get_cgid(rq));
 }
 
-- 
2.22.1

