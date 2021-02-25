Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C39324AEA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhBYHIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:08:53 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:20454 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhBYHHW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:07:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236842; x=1645772842;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJljxv9ZKdV4OMHqPsrhlbSrsGdfHzklEixZScRDCEY=;
  b=SbryPVumkNPvgC52ql0YiHwmKw9O07GKiX5ysEGNF4cOSnOItGv8tckM
   ksFz+QXlqCKoCXG5m3QQk5NGutjxBvrzC2X5iKpj0BWzHid82SEIcsKtp
   /8eZ6r88JMurk7NP9RdRZGdfVd8FZGd0jWHjr+494yS3s9w9SEXKqQEGA
   Pgvwfj9WR4nRHsg8daV/EIKdGIS0xuwpiJMOjb9M6xMVIRDFr7i00711S
   XV1MbB11G63jh+YFJCqPxj0y5gSde9QOk0bLuVz/6goAVFWrf3xpGSH80
   ehnZKQOHFmlOJJnSOzmfQIeuuAvDt1SgcM+bHx4LUlKbQnqguDR3VhK1c
   g==;
IronPort-SDR: BVb2RfEZETTh9RwgCupj7nbSjxEFjOydpLw7FNZMXBaZsYyxE0JSa3Cla1XXdQHHswM3vmxWoR
 3wnOOWLp9vTKOJf+s487WopgizIEew/INo7Py2zQ1IBeFyVrbd/rc+AzS78r9N8aaf3uPb/JD/
 Rnri9tcmQskVPJAdaJ9t73VFA4/pi48dj4rxPx0ostPcap+qUqVgOGPeZfTfdwl8oi1/jeWSeY
 jYLQ3dzXS3A+y8xxLGDWp1JhDqOh/sDuaTxToJ77vYW5C/I+1GBjXywqwlKqmgj6zmx2DoQMgW
 Ghk=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="165245790"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:06:16 +0800
IronPort-SDR: /1KK94gHlDTn14q7Wubc/qLwqbEk2Iu2cjcBgrYM6HilYQ406MQTBiYsaB1TERElnNGb57+IBZ
 NPtWIMdr5EuLU5t2xz1ADO+fA8brPcSHynVwSTd58pdSNk2h0IuW8kJc4zcSVFaePWGs2MDdCm
 9KCuYnumFiIrlQGvG4AAQXG8sj1eo7I+QJycujAHS/p+7yx/cNdu1mUX4PwUbAQ6x+3p9P0Jr9
 AzfpP0Gj42EQf/DkBC4NSAKSALyjKZ48xK/YtNidqTlZ23b8sseb6P72p+D0R1UTe2WaXAUPr7
 Eke1+EpQuaK3CG8V4tJdEDgZ
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:49:31 -0800
IronPort-SDR: urCze7X10jjqtJ+So4HJu3Ac0VQ9NXjnCvbxWxuUADvTBJRYcztZ3bfeaN0hZoMOaf2FyKJmAd
 xKa0WyfE29Rhi2ELfSNUIFYlxoAxGdWD2KWCb4dTyYJIUWbS523itgVrDxzErVlPmhPZohTA4n
 ls0zZA9YNGJatHf0jALJyhatxMJxRCVVdiW0BPfZOneXchxRl5TerrZtVp9Q3nIEietp/LYPQE
 U6zSVsoJPH66vhAoa5mzn2lktP0BVwmjz2yTmt2hMsYpTVq4Yozu8hS7m3bzzpe3Y3euivbdXT
 mnk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:06:15 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 25/39] blktrace: update blk_add_driver_data()
Date:   Wed, 24 Feb 2021 23:02:17 -0800
Message-Id: <20210225070231.21136-26-chaitanya.kulkarni@wdc.com>
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
 kernel/trace/blktrace.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 0710f2e40404..1f9bc2eb31da 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1600,17 +1600,26 @@ static void blk_add_trace_rq_remap(void *ignore, struct request *rq, dev_t dev,
 void blk_add_driver_data(struct request *rq, void *data, size_t len)
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
 
-	__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0, 0,
-				BLK_TA_DRV_DATA, 0, len, data,
+	if (bt) {
+		__blk_add_trace(bt, blk_rq_trace_sector(rq), blk_rq_bytes(rq), 0,
+				0, BLK_TA_DRV_DATA, 0, len, data,
 				blk_trace_request_get_cgid(rq));
+	} else if (bte) {
+		__blk_add_trace_ext(bte, blk_rq_trace_sector(rq),
+				blk_rq_bytes(rq), 0, 0, BLK_TA_DRV_DATA_EXT, 0,
+				len, data, blk_trace_request_get_cgid(rq),
+				req_get_ioprio(rq));
+	}
 	rcu_read_unlock();
 }
 EXPORT_SYMBOL_GPL(blk_add_driver_data);
-- 
2.22.1

