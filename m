Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98695324AEB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbhBYHJB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:09:01 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13993 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbhBYHHm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:07:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236861; x=1645772861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y3T+OzM9qlMoPq5UMX3em21f6JJsyAqATFoHOy5IpcM=;
  b=d5KVFdMcHUtz5tkAmI01Y5k+LCxtMBMqqI9pDySME1IySu6H99Aa6kH1
   baLUAcvbp9lfIjZe4qH7P0s+Aq0cBqOeOKOnY78d7xa0/s2br3tkBjzIY
   ADkpZqC/+9E1l8McTWxIuhGrTvuTq35ISNyE8PS50TqV1mBPwcni38sSl
   Uk0GomUvGxZqtiBM3BHnIlzD399qr37uuPPr9tlbPZvqlKvpW+AurmGxk
   IM6qbfVx4tIcXig1unjBgaH0EdTc2cgSQB9/vfCF1hriDBapHn9OxHMk/
   vwqwQo9OWSqHsDZAq8p0LMJOsEKaWZbBsq82YUneAUBcGdceHX9H6Fh4C
   A==;
IronPort-SDR: 7p9rKASop30Unnk9iE541ygQBDQFzUv1k73VJBHmKcQqJm+WKpB0TIyPOVBS4DVQUSYeGlSokr
 YFPVyo/FiQLXy21+qOpKtzSDZoN+ybVH3BFTVPBiYKqtO/ChgMles3jBXScockiLlzESjFXjFa
 2CowA1+dQ9/1E9E3HLWApJ8Cm8N37v0F5GJClSAZkF+vHeHLOkCJBCy5P4j6Ja6yFAx7ivpoMt
 RkhMC4gWL+88uVWZIPcKSXdg9AQAcAJ8xRhpmWvYEuHeULdbvHbCMcmqmgwJB4j3YRG1wSc652
 45Q=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160751826"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:05:45 +0800
IronPort-SDR: tX5JBq6ano0TMyyOK7dJVj0Hznn1H1AnFhTZWJqLxkVjvMKArzWbN0u+7lsy4MQ0qjNoXIvv++
 cU2MEKDpnytI9KSKRu3uQ7rdJcrsLa7JDyi18e+m2BjhJfKQX7d2JP40YxhQhhVfS9eXXoQt2J
 x+KE/tqleNBAldZs/+2JreF5a/pIX6EMQMytdPonpXhiwCOijJXpcpmzLAgct1jnTEfvRUpGoW
 dwxCSKy1YSeS8sE5NEUlnUSVwdzfzwe90HeS1cueIMZtH4YRUTFpmEsqY7FM6hYDnKyPSjFLeh
 F1ehTpdrD2KcJBua02eX+2/Y
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:47:06 -0800
IronPort-SDR: b7dbboI8h38zwknCrW7l2BOsoIP1NNhTuV/rfLiqRK0NprYGMTn7E3saI1X9ZlHHu+o4w8IZ31
 GBxC5c4Nvd6PRgu0D6anHCo+fGoH49KOzjQsSDHSC2p/SCBKOnRgLD1uo1GnXZSewKvnHt6Uy8
 QNeVt3UzfKahoBq7o+ckdAkUPC0I7G/KLifTklS3JJMWpefuCyc8fgX/ds4ZBxQu2Ius0s/+nP
 oqu3ErG0uHrQMf/dHCLLla+1zKYdt6moVMeT3n6HJpiPAH4+NfLoqS/ORLLrfCuiv7eKQzZW4h
 b9k=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:05:44 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 21/39] blktrace: update blk_add_trace_unplug()
Date:   Wed, 24 Feb 2021 23:02:13 -0800
Message-Id: <20210225070231.21136-22-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 0a9b491bac9e..1f2857cdbcee 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1438,9 +1438,11 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 				    unsigned int depth, bool explicit)
 {
 	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
 
 	rcu_read_lock();
 	bt = rcu_dereference(q->blk_trace);
+	bte = rcu_dereference(q->blk_trace_ext);
 	if (bt) {
 		__be64 rpdu = cpu_to_be64(depth);
 		u32 what;
@@ -1451,6 +1453,16 @@ static void blk_add_trace_unplug(void *ignore, struct request_queue *q,
 			what = BLK_TA_UNPLUG_TIMER;
 
 		__blk_add_trace(bt, 0, 0, 0, 0, what, 0, sizeof(rpdu), &rpdu, 0);
+	} else if (bte) {
+		__be64 rpdu = cpu_to_be64(depth);
+		u64 what;
+
+		if (explicit)
+			what = BLK_TA_UNPLUG_IO_EXT;
+		else
+			what = BLK_TA_UNPLUG_TIMER_EXT;
+		__blk_add_trace_ext(bte, 0, 0, 0, 0, what, 0, sizeof(rpdu),
+				&rpdu, 0, 0);
 	}
 	rcu_read_unlock();
 }
-- 
2.22.1

