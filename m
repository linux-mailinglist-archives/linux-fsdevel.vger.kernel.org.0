Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187AE324AD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhBYHHR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:07:17 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14102 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhBYHGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:06:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236771; x=1645772771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RliDRw3pUoQbW2z4uvyiA/GGoWrKbwqiRnsu1squGWo=;
  b=ao7vUco5Gl3ndUpJkj1gCo5QkQfcl8kmaPmiZ8kgZvWQ0S3Z4Tlc27aM
   1yif54EUnd8hwQG1DdcuQv9cZ2NjTYkDBqONoqQDjFdonmuroth/hY6Ax
   R0BEmCZ51isfRdpSSsHK8e2LT9DfYwQYCNk+ZlFpdEDSYkZHRNOZUh3jv
   oWtkfFaow/I0kJqSZarFkKt49cTc7k16joYilEOAGlk+jOtcKppqWYcRH
   9z0jCjEhQY7RXrjAJ5XxkBWuPe6C06AV+prf0hQpeMqxPPFkWiTr4P9ZJ
   uRx6Nd3U4KD0271sN2ZZ3s/SFwD1xUEnk2DAqygU+DzFrV/e8xXPmIMpp
   A==;
IronPort-SDR: 8e4DVI3ZsuMKr54iqo7UUBmnD3gRF097IisgvZNtInCrK7Cyw0075tcVm7AkX3jfPKFvf44EyV
 1v8A7kd3HbnDUa9NvKU+CSWR9rogKh7/aV2eP5yk2xoSUNJQMtcrfWGqhVq/FQIDUa8aQGj/+q
 siFP18Ukh2g1rfp4airud27x18MZzzYYuZWvTT/QzyT0ttnIhBi2zp8dTkGO8f5c5yyCDFrn7C
 qKLGyFIEihaKTDo76Xz4KZPjexF7xmk23Of58Dy7fpgPOfxis0CxFCRljPnBceQ5v0XuoNWizk
 oPE=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160751776"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:05:05 +0800
IronPort-SDR: NgENxV4QowIg8d59Ww5ApWv1fQ/EYPjrSbSvIZVhsrc/02LzkM5bx9HMlrT6pw9bOTXiDHfSVz
 sK/t+bHj1TCwqqbojC+H0B1NcIqPJQMqNqLdMyJChm6W7EK+kINKOG/o+oFiPqgbmRpE5YWS75
 7LAlW6F9Efj9tbLXfOx74LPbdHNLpxBhMXWb0bJcZMQWLkJDUTrHE9dPxZ6RCpOvvsmhcvwebv
 etClPYCHuwAu4PHMbZX7j8eyDg2S+/gVrioRocJxmwLF1eTZAVP65x+5SDXT/L0aWh73PJO2U5
 9xtt+LHYG30njdbYoj3pP0ow
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:46:27 -0800
IronPort-SDR: MPBBpIG4htHj0h1ebF0opNZPzbHbBmMU/F1pFTs8FhH/WsMq0lF0wrmgacv/z+lksrtIAmGndL
 lazja2d55S1LQY7D+QzVpbIOxpwh8Ngkricnkj3BCjYGyPCWXtTHENXr0n2yKwmeD4p8H3sTBI
 sGElFuFmmJmnMCcgcaPHgqDrfls807syUHhLyDRriGfXWWrYRaV/zxXvFLiUlBfuq208TpZU/Z
 6jxI7JvoRKeiEDVSC7NQNboG0q60qtdDSA+0t5q4WuBf/FxDPj7sGxKfFJmDssqJ4er5NIFoEY
 duw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:05:05 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 16/39] blktrace: update blk_add_trace_bio_backmerge()
Date:   Wed, 24 Feb 2021 23:02:08 -0800
Message-Id: <20210225070231.21136-17-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e3210951f1f0..1ebaffb6a3d2 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1325,8 +1325,25 @@ static void blk_add_trace_bio_complete(void *ignore,
 
 static void blk_add_trace_bio_backmerge(void *ignore, struct bio *bio)
 {
-	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, BLK_TA_BACKMERGE,
-			0);
+	u64 ta = 0;
+	struct blk_trace *bt;
+	struct blk_trace_ext *bte;
+
+	rcu_read_lock();
+	bt = rcu_dereference(bio->bi_bdev->bd_disk->queue->blk_trace);
+	bte = rcu_dereference(bio->bi_bdev->bd_disk->queue->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
+		rcu_read_unlock();
+		return;
+	}
+
+	if (bt) {
+		ta = BLK_TA_BACKMERGE;
+	} else if (bte) {
+		ta = BLK_TA_BACKMERGE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, ta, 0);
 }
 
 static void blk_add_trace_bio_frontmerge(void *ignore, struct bio *bio)
-- 
2.22.1

