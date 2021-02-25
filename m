Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F550324AC0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhBYHFI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:05:08 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20154 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhBYHEg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236676; x=1645772676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2LSH/OjKGCrKXEu0AkHm8m/B3zNNzAdY2JIHZBpPOw=;
  b=MGeU+vPA4ueLuT9sLlEBlh+7OQQWJbSzgi5OSqomagqR7Md89I276f6I
   USI//DQ2vkuJ4qfvsiE+DanB1Y5DVIHQeS0Nw+NlLMVJQWIevGdLwsvZ9
   w83EqZL4oxe0GPBc/ELSGKo3LdGrijqjZecgA/8JC1ZXmusRmg7DgNoYQ
   bMWmJCdzzxndEYLOldoCPcjUS46fR2/JRjT/Ro42wAvRQ0rOIbUFf9uDw
   G38+PizwEvyli9Ok2VVudbuOvm3kBwH1F6+j6EhUzDhVlAvZCFxQDWCnl
   9tqUXRMk+Vb3bHBiAaYn8kYht3VvIq8YkWUoSCh4rpOqN8RpuEeezUI1/
   w==;
IronPort-SDR: 5jY9UCehsWuM01xC71tEcZuJXoajlzkFNv6ymTHWAJKJi9cc8TRqPHOaHOg+XIHYn2T952lz4W
 Gz9qIpCaUp6wNB74KM+4hU211Kzp4i16+bYQDiSW8jGHIfPJgR62GBxHGQKe2FjyqB3HsWiyHE
 6JM1ckZAqxO1enomXbGJF7FoGIKugmgFZuwcr+/yIASxMU5RItbvg6bHVghsF8P2Q67TONs0XR
 kKNTuTtMXCAiVOYUr2x00/XPU2FT/2txVLVImPSYHis0qZCYrn4P72yg9IEpe6JFY07ijXta/j
 7SQ=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="165245657"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:03:56 +0800
IronPort-SDR: 62TsDyzlWVRfJ1kFy8jjqv/Zimj/o959HEp65qiXUztLyPIBijXaugl5mPS1R/4LzPEAUHsXfB
 aN8GmMNPnkhQmJ1klCerIfQ7Wkjn9vUmQysN3oH4YVT7EAPDMhrYZup+dTmj300g2PW6XXAiKc
 uOLxzDYIRKS3rqAk8/uyh5kps3sWhJ9Jx5ynOiionDQYIuSzdE8NQ5kokbrZRW1HJBr9Ag3hsF
 85CzA4oAFbC5AktAlylx6SPvxX1Nap/trKJOl0q6hyMh5AMt5XhGUwxQrusL0N7+6TTCTsaF6I
 m9nVbX8vAoDHxE7WMvnXv3QH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:45:17 -0800
IronPort-SDR: uT1Gbcjh/y/RdWSoB4lyWWBt0RseD4xGuhuvQ+IIsqtAkCaYpfkTyK14dVq1TRLNy0CsyAGosz
 U32AWIJ+L/5mzaGRxpy21ocDv4T+R/EMYLb+GHoerpo6T+JZ2O0VJr9MBNWwAWgQMA5jGvtn3b
 ltJvN757ajKXKudOczOhYSWmIpFMSpx9KBimUZKx8U18Stey2/jqJPZi4dI5I+w+r4SAxkQrZJ
 IkUqtC+PMU6RKra919zmX/za7es4/VdPhzW6Q8X72FZrRzYEIheqYdBC+la9AZNOemtmFmze/P
 c9w=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:03:55 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 08/39] blktrace: update blk_add_trace_rq()
Date:   Wed, 24 Feb 2021 23:02:00 -0800
Message-Id: <20210225070231.21136-9-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 1aef55fdefa9..280ad94f99b6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1099,24 +1099,36 @@ blk_trace_request_get_cgid(struct request *rq)
  *
  **/
 static void blk_add_trace_rq(struct request *rq, int error,
-			     unsigned int nr_bytes, u32 what, u64 cgid)
+			     unsigned int nr_bytes, u64 what, u64 cgid)
 {
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 
 	rcu_read_lock();
 	bt = rcu_dereference(rq->q->blk_trace);
-	if (likely(!bt)) {
+	bte = rcu_dereference(rq->q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
 		rcu_read_unlock();
 		return;
 	}
 
-	if (blk_rq_is_passthrough(rq))
-		what |= BLK_TC_ACT(BLK_TC_PC);
-	else
-		what |= BLK_TC_ACT(BLK_TC_FS);
-
-	__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes, req_op(rq),
-			rq->cmd_flags, what, error, 0, NULL, cgid);
+	if (bt) {
+		if (blk_rq_is_passthrough(rq))
+			what |= BLK_TC_ACT(BLK_TC_PC);
+		else
+			what |= BLK_TC_ACT(BLK_TC_FS);
+		__blk_add_trace(bt, blk_rq_trace_sector(rq), nr_bytes,
+				req_op(rq), rq->cmd_flags, (u32)what, error, 0,
+				NULL, cgid);
+	} else if (bte) {
+		if (blk_rq_is_passthrough(rq))
+			what |= BLK_TC_ACT_EXT(BLK_TC_PC);
+		else
+			what |= BLK_TC_ACT_EXT(BLK_TC_FS);
+		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq), nr_bytes,
+				    req_op(rq), rq->cmd_flags, what, error, 0,
+				    NULL, cgid, req_get_ioprio(rq));
+	}
 	rcu_read_unlock();
 }
 
-- 
2.22.1

