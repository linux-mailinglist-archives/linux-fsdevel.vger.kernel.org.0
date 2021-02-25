Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F1A324AE7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhBYHIa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:08:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13049 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhBYHHB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:07:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237384; x=1645773384;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rOGHu10pEh6J1YM+7k5+Aia6scmIzlsX4emCrLh9cE4=;
  b=m1w15HANV/mBcDKJsq9E51NWNlZ6Azn/n5zO2xfHELSvAn19Zqvyiac0
   WBmMZvTajTMMpPPaPMIOCJRHEdLoNA5gzUMzy2SyVyp/9NtZEkrr/3JzT
   4Ud+t45EuXAlWPeBNfuvCbsq5uYzpAf/l3MIcuHcVGoAsntk+T6zN5QvN
   r5jz3Nq4C7q9CSL2QFceXeK02/QxxyZ08YgHHK0QWzduan9/CFFnvE8Yg
   T1HvBkotpe0n+YTiiCu6/Lll5dP+5IwsFzZbz2ewFMbBBi2tI5FOaYZC7
   eZjrc6flKwCFwmy2sHUQM1eratWwClaj4MsqIBFRK8/l3pVp3MIac59rk
   w==;
IronPort-SDR: gca+nFfErfewQLRr4qANXrhyHR9lDRo3njQ+pFze0aC2VBfBFhmdaBBLQzoYDmYLGpXQxfhKyl
 zp1NCMi2l0seFfID4xXBBcqlxCNHOSFYM0CFCeCK4eWeKpGJ45EKwJaMIe5VjVLzTMMsXgHYzq
 FCKPugF9vlmuYLkszEuHIkY48EfvgaLmGkfpGEIqC+dkZ9KcrPvPfeIe6B4Q432oIBpm8woyHy
 5FoyqsyAq6qYNFh1jpQgqzFP+ELzDRjFml6r0vAWxRSihl0lCayuHoseznDgVlDY3FKO/2N8kv
 kxw=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264978904"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:13:54 +0800
IronPort-SDR: 1wap3JaV1i6RZIw9qBSRt6Rv2imlgzOCbQ0Qvt93crihFZPFFG8gKr8mT2o3ddt83Fpw9BLzmz
 kmxwg558nCiBW5gACUj/7oGSsR5kBR5DPRk752HWgFGSeRk5aN4EzLkTi9k8Vv5MTLn9xshiSs
 LCVnsZUvJhIesMdUZ7lHVzL7oSPSlqTlqJ6qjzJAa64Wyg0+WF/MVwel2tfG8E58HDe+rg86bR
 sZRJRhMhZ0QCrXe2MoGAXQAYfvnEEAx2KUkdXd6Nao6IQVjorLUZAd4t+HUCLIPrHwqBlT0z49
 szsOH7xQV56IKHnPrHu2bBOz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:48:36 -0800
IronPort-SDR: r56t6IHNG9si8K91SdegoAe1Goq1+NHNTq3tq+mvGcRfOPMjmM/L44/Spc+ZZ2iv6FhhHlzlQ1
 aTn1A7ebQCeptw7pGTJz+pqmy4LAeVJk/n4zGV+SIYrxDOswzSOLiAjQCOjkpQ1OUL0P9TV/AM
 l1bYyzk6QzaUpzgz+S4OYWwW0/73eU1BYCc9SzBUDTnc7nS1kcObFu6fJ9nBTKDJCnEpaZXg53
 t9GTKzmA4vtk72g8gZRPRyNk6exhgtQMzJwWM503uRd62nsUy4VBYTmwpZJbdk5a55SYWygIpE
 DQ0=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:05:21 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 18/39] blktrace: update blk_add_trace_bio_queue()
Date:   Wed, 24 Feb 2021 23:02:10 -0800
Message-Id: <20210225070231.21136-19-chaitanya.kulkarni@wdc.com>
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
index 92c4e5eb8948..45327201ebf6 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1371,7 +1371,25 @@ static void blk_add_trace_bio_frontmerge(void *ignore, struct bio *bio)
 
 static void blk_add_trace_bio_queue(void *ignore, struct bio *bio)
 {
-	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, BLK_TA_QUEUE, 0);
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
+		ta = BLK_TA_QUEUE;
+	} else if (bte) {
+		ta = BLK_TA_QUEUE_EXT;
+	}
+	rcu_read_unlock();
+	blk_add_trace_bio(bio->bi_bdev->bd_disk->queue, bio, ta, 0);
 }
 
 static void blk_add_trace_getrq(void *ignore, struct bio *bio)
-- 
2.22.1

