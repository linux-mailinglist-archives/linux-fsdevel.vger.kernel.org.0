Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A60D8324AD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbhBYHGx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:06:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54936 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbhBYHFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236738; x=1645772738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bRSf7aRHFZjwKCFxu48NbjjHqZ6tr+RDQGJuYmhf/1w=;
  b=oJ7QiiCn0IwezQVjse7j8NTXId7/nIwwBbGElirTVeYwuDPBjd8WYxMZ
   XunyyV60HLnmdbfNknKN/WjLdHx+VNk1D7wKx9kpGCzRVBpRb4RDPq4AV
   iNbb0XNnhkqTBd55lFVQiNqrDw7+vPvWU4qDkMUWT+hg+x/GoGPokMg4m
   xOEgNZ/v/pkiShhzAExXdm4Hm5U9gIEhhPMkEJ/iM23526kDDe2Zf/yto
   KHG3cib9LpgQixeiATI9hUlnmngpVFvrSNhJhL/2P5hEPzfZnCIlV79gM
   rsRbhOG/aZ7o0SlKb+5gNVDRsVYVgn7z9rM2qQ2Jmkp5HgkVrokt/D8fj
   Q==;
IronPort-SDR: 10RcSK9zhObgF9dGyXzF1QncTT/iFEW/WgghG5A7f0ZQ3tNL2KdKAhipEtB4F7Pb0bJcPpT2lP
 +mI+fw6CbW6kzAAdUFLQFXNjn9keyZ9YVeLrsgqpRt3SxdX2YaEZYcUWokCmfjfSa9osr2Imvz
 kIqMd0mmDz+mGQTO/1onaD83vtVbt1OQEblJDB3XS6maWYpINHH+EtsTehDXDaqxNZ4GXqQ8H9
 Nm57h+8lVQHj4sMwBX1gGxZ4vzx1TcoRfKFlLZ9hzShWI+qcwjpeJ9ar6iJAMJyfGomBRnzhKf
 wCE=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160777912"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:04:32 +0800
IronPort-SDR: 5garp/d4Zg/wHtV8BeW4ZCOg1EBwI+/sLaL8eJXrUc/uBj8kXw84TBjFGNh/FByCwyLE30noXE
 6Yacb0rfI9uu1qORkDMSPWx9GGOdsLa8e8e8EERdTcvlXFvTFcuifVEvQFBrvPzTADZPCPvS77
 8abLuRYvmx7BL0AeuufdCGUfMLCP5higUSfqaEAWy/05uvvdjpJybrYGh5CX5WGrOOMeYpCaw8
 vGdfJzADZUQ+7KzsZ3psRN72K/d/cipeK9dT5pa/9VFAOoX46d64EEixuqdwDxlIUz/cjubSEi
 6t5Srilw7z1UbZE7zWtJmdvv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:47:47 -0800
IronPort-SDR: vKKlsoTwwQ8w99awhN2gezM3J9FdT3hxy1J3T4UVldZCiEolV/GH4GCxrpEuTLS7C9eQzBNrk2
 viZ3D/UHE3RIfltfADz2ukcEdfaegZTSb2XEyWTLY7ASiqBCp+zFJRJJl+T3QpZ7lRuKqNsS5X
 11fcMEOjCk9mahgtW1R2WF8ncOujuLh2GwBR66JEQ0M/hfCy1CG6u7X/hVPbqqmbuwzT+eTWcq
 JC9KfT0o4Qle+pdlslSl+0Un+F2gBVz9vNhxyMZQuOqW3Fig3TJThQB6Xw61DX6Pf3+0m7dUrD
 iDs=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:04:31 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 12/39] blktrace: update blk_add_trace_rq_complete()
Date:   Wed, 24 Feb 2021 23:02:04 -0800
Message-Id: <20210225070231.21136-13-chaitanya.kulkarni@wdc.com>
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
index 8a7fedfac6b3..07f71a052a0d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1213,7 +1213,25 @@ static void blk_add_trace_rq_requeue(void *ignore, struct request *rq)
 static void blk_add_trace_rq_complete(void *ignore, struct request *rq,
 			int error, unsigned int nr_bytes)
 {
-	blk_add_trace_rq(rq, error, nr_bytes, BLK_TA_COMPLETE,
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
+		ta = BLK_TA_COMPLETE;
+	} else if (bte) {
+		ta = BLK_TA_COMPLETE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_rq(rq, error, nr_bytes, ta,
 			 blk_trace_request_get_cgid(rq));
 }
 
-- 
2.22.1

