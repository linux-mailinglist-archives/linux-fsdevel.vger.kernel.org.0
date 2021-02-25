Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920A4324ADD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbhBYHIH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:08:07 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26799 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbhBYHGn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:06:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236802; x=1645772802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Py6IWxRz+VdBlW3n5qrf5au53uQwXwAWNr3415byY5c=;
  b=Ntgb5V3SLBPgCR3pYeSZwI+RPCV0V4mXhRs53VJdCSwvsIGIc3HYa2CL
   Ti0HUigFHOUvXIMczrzydsWgcOBozjz8/HbtK7UFFJX2LauE6oYE9/iKs
   lYmf/rcPWW6cPCV0thQjvnB+NMiDNBAEBnQmMdaVxv+/NHgat4IboChPT
   xEHaGtyIvRF5PaL0DKAKF7iVBDM1aPSQkI5kZAj0Eg51VPgCGj2kXDaRT
   AIsXQ+lMmGZz6HaBaseI0acE9BGPZs6ZQ5RylfWyMYV0BZiNzQ+YT6LAr
   DE/zaEodAnE810wYlO74cmhoPZSxaExzpFEerEWzcOIv0PQ614cYGCXVe
   g==;
IronPort-SDR: z+kFKqxokK3HqEo5roDPFrdHfmiyq2CS1H5gRLwypjXaIaPk5BkGLj/1FdDr1aX1TWlV+P2P0P
 umUmkpS+9FpS9E0C3AjOcM9cETx/u1PhROMAKtJ9fwXchBP2z2DJh9+5zxVejXJn/AiJFN0IJO
 dMaAYv9CQVg5M3rZGdYxe6IOiiB7WrVAjpvbsHNrk50vCvhQ0j/Lh6e5EWr4+2GV3xR9ENYrij
 Ov830Jz4elkxp1AAIqYhp0EnxCSK+6uHN7EhNs9VjzkAh2OdKfs8ms7OtOfZZ/HeDKFYEQvy87
 Tfs=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160777971"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:05:37 +0800
IronPort-SDR: W3owdHiFxr1VqaV32kEu2xJ2S4Us2B9aP05qSSdZ8CYw5bH7dsuKGfvyayCHbneLwWNn6cTgNQ
 4eayzsAgIFWpMykhfVHX87iwdQMrxNm4bSP12ThF50jVyyb5hGvh/bGlajYO8CzdgtBj1n3ljh
 chqZ0MW9sldP0Os7m6d6xbVzY5mAP7hixizzP9VOwlT9GAYwuw31TQpZG/dQfsSP1RlIzPUxvZ
 54WXybMvleSaRbOTGciDFRM3cDeH1t75v/UTuZJbnGvWdE5LDRgeSn2ne82HjbY6s66VCHfcr/
 K11rIf+/WbIFxjH5sVWizAYH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:46:58 -0800
IronPort-SDR: ZDf+1Y9VPXY0FIeg4WlyCgPeErXIR2Tk9XrDLppSrAO882b5425LqV1cYPmfU8pKEJ1lG+2xnZ
 LzaidmD3HMdSwuaNVRUOaAR/a50IcbPJukyGeS1YV5W3ENp5d3doDs9dS/B3hP2i5MYBJ6Hql7
 8o4Y63fwqpKaZsQbc+SdYy5PG40pUapFWym3Yf4frIQW4xVYP2CQzevVlUqdELiuP5MTWYDySe
 bJbejXGZB++u57fo0Uo/ErYjtfsLC1bVTHwqds5snazHncIofDYbNVQHJ0rCvVYNybUDu1ad3L
 3U0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:05:36 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 20/39] blktrace: update blk_add_trace_plug()
Date:   Wed, 24 Feb 2021 23:02:12 -0800
Message-Id: <20210225070231.21136-21-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 51c10d86aa92..0a9b491bac9e 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1417,11 +1417,20 @@ static void blk_add_trace_getrq(void *ignore, struct bio *bio)
 static void blk_add_trace_plug(void *ignore, struct request_queue *q)
 {
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
+	bte = rcu_dereference(q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
 	if (bt)
 		__blk_add_trace(bt, 0, 0, 0, 0, BLK_TA_PLUG, 0, 0, NULL, 0);
+	else if (bte)
+		__blk_add_trace_ext(bte, 0, 0, 0, 0, BLK_TA_PLUG_EXT, 0, 0,
+				    NULL, 0, 0);
 	rcu_read_unlock();
 }
 
-- 
2.22.1

