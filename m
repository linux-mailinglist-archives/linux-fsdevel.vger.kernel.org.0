Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36059324AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhBYHHg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:07:36 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:53171 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhBYHGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236778; x=1645772778;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7d7MNmuGjm/4LXsD5U+vaIc0UhTaJT40eTogubgAbUE=;
  b=S+GBp6bp/rmMlXZU5pnSL59RoNrx6GO5IHRCl9QM6UAopg22O16dqr90
   HEAQIcY0c9mCeVBJTVx8ftT/LReF8YgJFwxnP0DPkPCE4JgwXw4A82UOL
   V0il0c5hObWGfk9pQgabX+bT8zmSOQAJzkIVcGvHZnpW7NaigFTfEkMu1
   Xz9+imCpeuY7hAch7lCWUu4ymHIW+avhDxwNDDi86NHfTictWUCWUGOwi
   nh3CzxdHGXP49rudsUrjYnuBofZXn5G++s011NKzZOG6Wz5Qa1kaj6Ft8
   GXJNwubzJ6/LBQkORwjBQMA3kolcYJJUOYan3rc1Iyvs2TlRSHNntNVV3
   A==;
IronPort-SDR: WZSCtJwueZNz3mHcfB4VC6VZSvtF6sL5WUfFIVfBmFOJXONP7U8eBknWIME/Cjg14qIzRG0s77
 9aTvYv08laMJOBBPh7Nqxzp5xLLcXY32Am3NsJ+9xt1d4BUuUNRdvk1Wie7qPhr1vtGobRbInP
 mBePc3xWBk9PRUAcrYUHlLPeeCBxToYvA/2LhflK+f79wFVt4ThvtmFNoz8Klqio5ngJifeMTl
 UYM/SNCaiB88seRsIDK2sCNluYlpGtVfX6CI1Nkgs6Fz7Aa6Iru11P45rYJiURU8avvdpnZvoO
 UKY=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160777950"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:05:13 +0800
IronPort-SDR: WpXYFcFAlnfHBIUTlase7U7mGiJQtXrhIascKu+Nh0lOp9z9r2h0Xan57g3lr3sg55kJijqkdt
 ev9fh7O80AJS+vT5aXRL+1wPOwMHI0rfzML+PpiaXtBPxqXjqpqD7T2mUmj9543WQA2pmtPabR
 +agaKtMgV3W4fxtvn6m76FfgEAN4/TXtgSX1wcCUutuI4/0WOZCFgo9KjtBacNO4gz5vQbrYU3
 OfkPavwyS3R/xv7WMAda8w1z0O00k0syOG5lzL3Jp4y02tqDJER49eF/krCcBdL5L/wXz9drTL
 RSYPC+zodCeMZ2swSbzZ1Ppo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:46:35 -0800
IronPort-SDR: 13R85S7gLYrIwH7dB4ykXoA9U9qCoqkbh89xBWodtb8/IH9TUCdTqB/6BLn7pPIR3h6okSyquF
 cWosQxhXEvXz3eAEipBeR6Kf+ncZR+j0QHmshscC01QAuNQ1a45eka5MzyeuEQPtzKIGwT+8Ar
 y33QJmpFz0YFvhwoYjSBrY0z1Fx1loEunt/o0rwklUBZeCpTpTgnNEaZip3xZSrHiPwOixCvoq
 x2yPjSPRashiOyzHtTr5OQw0z//+1oo0xztTWLr894lYf64h8l6pOPZOOTX3zE8+BsraFu9TO0
 puk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:05:13 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 17/39] blktrace: update blk_add_trace_bio_frontmerge()
Date:   Wed, 24 Feb 2021 23:02:09 -0800
Message-Id: <20210225070231.21136-18-chaitanya.kulkarni@wdc.com>
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
index 1ebaffb6a3d2..92c4e5eb8948 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1348,8 +1348,25 @@ static void blk_add_trace_bio_backmerge(void *ignore, struct bio *bio)
 
 static void blk_add_trace_bio_frontmerge(void *ignore, struct bio *bio)
 {
-	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, BLK_TA_FRONTMERGE,
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
+		ta = BLK_TA_FRONTMERGE;
+	} else if (bte) {
+		ta = BLK_TA_FRONTMERGE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, ta, 0);
 }
 
 static void blk_add_trace_bio_queue(void *ignore, struct bio *bio)
-- 
2.22.1

