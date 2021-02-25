Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4067324AED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbhBYHJR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:09:17 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:14102 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbhBYHHu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:07:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236870; x=1645772870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XwcksvYyDSM2HFUMYUU5AAfRMxXp+zPCmZ2/iCbPVy0=;
  b=RiWj6wu+LXnbp6bd8ZZaPGuH68XB4rH4x1w8EtEJI3siQVjc5st3xNFa
   rSegQFTC42ZE15co8gzuchuP9Z4eAC2hTAqtWpNp6SnZin3/6JelgO6Fn
   HRNtusmIKX+K6zV4RcAnRt2rMaUYNEFZGoCxvJcl4Y4AzlO9Za28//m4N
   W5ZFgc8riOl6cvl7Ng6dWSydDS/S755RJbJqGQCAmA75A/j1QzktkDh4f
   Jn3pr/P5w+lPz3XCMFv47RKtYB1DHoQVE/BfiEmPqyf2Dv8rPgmUUeIdi
   IN9BaqvFmPQ+cChuHAN0u+Wf9FoXRp2wjJldgkU5mS2+WBU6tluQZqhnC
   Q==;
IronPort-SDR: zQXp0kYFIWzmerNxrPtGXnp/JiOyNV0GJTeDvQcrZ9s23WNlgPucXJeDrtmjN9b2AXMaBgGg76
 c3pEUKCotv6aQr41DbTEv0DM+X2Q9VjYys3YEiNUQ+LquAP7Amn1CX0de/GjB3Yrn/LRfbRK+6
 3Sp2zbpm6c3S8G9LX5l6mSBLVtsKJnvkd/5C2n4Zj8DsDHYazaoxbk9mN6bExJzeGY6AxmH795
 VnJZxuMgguIEFKKg2+d0n32OZAmFrllWrBnODyCoOJN6cEjh3Heya3Y3ZPPsxM6RPzjy5zzqOT
 UBM=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160751855"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:06:08 +0800
IronPort-SDR: gXY1GiuANDo6CbQUXXWteNO7aLvQ7B7UvL8EOr47OaaRcSBYye7dMZJ21zhrNiWEYPQkjPp2mk
 NRJdjV4ANq2nbNYnkZTw/y0UJSunS6sS+dCy3+ytFa2GVG7LPyJAkS95xuu0862lspjsuL94hT
 k5fCP/fKUVokdeY0uQKZslNWP68q7JLwPTIAD3FFXtV599mqkcUnlcnclkqSczX+K+3zK7ZTcP
 Li01OIENy6Ti21EaNU6WZSwFYU8FfrAt3PSNMXc6ZGoeDu0D55Nq/ZrZ9Xx1p8SAYl0RmH25rA
 aI4+Mlg+u2ZYMd6Tx+obaoko
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:47:29 -0800
IronPort-SDR: r8e2lsnKbLswHVUs16e/podGbXxIsxMCDGTYux+2KdLg4Kn31NTYKPT01lgdPkZA+D7QPnPk9U
 Uf4u5P/efxNDuu1fa+482qdE7FmX3TFhftinzzsA8IO7FKg+PGBrEzxXGwCNFiMDmhlGBV3j7t
 q21tVgoq1py4YBccW8JmlsCDbjpg6JQJ0UY1moEXwkOdFc/8lCorryizKMJunAJeBNY03h45bB
 KJ1WWwAGnkIzaLu08/ltKlvi0fFa8xCS5dF2pcsuWJ4Xy/lPkHipVhFYSNHjA6LXqZDHMNbvwa
 /qw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:06:08 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 24/39] blktrace: update blk_add_trace_rq_remap()
Date:   Wed, 24 Feb 2021 23:02:16 -0800
Message-Id: <20210225070231.21136-25-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e12317f48795..0710f2e40404 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1557,12 +1557,14 @@ static void blk_add_trace_bio_remap(void *ignore, struct bio *bio, dev_t dev,
 static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 				   sector_t from)
 {
+	struct blk_trace_ext *bte;
 	struct blk_trace *bt;
 	struct blk_io_trace_remap r;
 
 	rcu_read_lock();
 	bt = rcu_dereference(rq->q->blk_trace);
-	if (likely(!bt)) {
+	bte = rcu_dereference(rq->q->blk_trace_ext);
+	if (likely(!bt) && likely(!bte)) {
 		rcu_read_unlock();
 		return;
 	}
@@ -1571,9 +1573,17 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 	r.device_to   = cpu_to_be32(disk_devt(rq->rq_disk));
 	r.sector_from = cpu_to_be64(from);
 
-	__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
-			rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
-			sizeof(r), &r, blk_trace_request_get_cgid(rq));
+	if (bt) {
+		__blk_add_trace(bt, blk_rq_pos(rq), blk_rq_bytes(rq),
+				rq_data_dir(rq), 0, BLK_TA_REMAP, 0,
+				sizeof(r), &r,
+				blk_trace_request_get_cgid(rq));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, blk_rq_pos(rq), blk_rq_bytes(rq),
+				    rq_data_dir(rq), 0, BLK_TA_REMAP_EXT, 0,
+				    sizeof(r), &r,
+				    blk_trace_request_get_cgid(rq), 0);
+	}
 	rcu_read_unlock();
 }
 
-- 
2.22.1

