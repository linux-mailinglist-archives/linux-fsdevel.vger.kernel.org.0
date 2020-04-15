Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187601A97F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Apr 2020 11:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408265AbgDOJHC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Apr 2020 05:07:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:19515 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393851AbgDOJFZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586941525; x=1618477525;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AP8UZmn5ljqVZ4+z4DUJXnQSKmNe/BWD06zNOt2Hu9Q=;
  b=VzG2zTyEH0GwwOBlMjZKkeBHggWi0fNag6mpeDoYL1jni6lvRfhG8/TW
   HfS284lcQUUfFUgdxKudXkndtFBJZUhSYstwfDETMvMHRxYWZ2BkntAG2
   MvSX4+qt+dieyo6W4XgjgGZgzZN7XNOlIJZf19eL/nDjKHvbeh36AFw2C
   T9v/R0prza9EI70l6qVCqWwUaaPQLeFg4aLz3pvajmaNcOhesb/2vbGep
   CeaW1GhNwpzWNSwPyqtqLkt8FEk1WNDCTpLPhpiNlty5CKsoyzm9Off2F
   1xlKJG+xE7N/1HNJdUHbTYcWHwbDRxoM5880ttl4W3tQivgjhkiL01bYT
   Q==;
IronPort-SDR: BoaS3ax6/BkDT9G2wTVXayM6EDiVoqcPXACFJCFmwvsvGI6b553jijofHGfjT/2tdI6A4o/133
 0wO+u/kbc4T0fsk+6UQpD3GLVhWLIkc7LZd21F38R/iYYPmbrbnhzaWUTkoSc0Jn4y0YNlwc2D
 6lviQSrz/2KlAhSflQ3pWbaiYINoC7Mrf2zZGZoQLzmaBWToQ2ynUN3Cj447TuLCuLc6cGu6BL
 tFKSmFj4vU8RSrm9o29qbC2SSNp3I4qSMflWqyDBcw30bJDhfhpnMTVVrrLqqmbSGIqAMRnjzD
 mRU=
X-IronPort-AV: E=Sophos;i="5.72,386,1580745600"; 
   d="scan'208";a="136802968"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Apr 2020 17:05:24 +0800
IronPort-SDR: B0d7AqiFS1GjREfoaSJb+RXjmNj0AWJA1Gy8aev2xHiTtcM722UQhRfBpNAYBXU2Jy2qe2Vl89
 T8S0bG5/TZrORrvMMvRjoRSJDNI2ZBZpCX9QWY70BWkXX7JJcNkHz7mmPhPbp6IJilj3RnghVU
 TljiHPtxmNJm458dxPA0GJGrkGYQpCftHD9H3bycmUUcfNfNFh+JKz2I+e9Uj29U3Na1knqHHw
 WNIrv8se6LYgj1ZifLfocK+wgwOb8PuQGdcNcPSpcXMvYXE+YXpJKyddI80g0woqeJ8bW4sbL2
 MDHDnhSgQF6WJfV06Jdvbmlz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:56:26 -0700
IronPort-SDR: G1Az18EKRNd2RXo6CTVI1cHv05AAeOwFl453t9yBSflSgNJ2NdQ+zDYEfF3dY/55pMrCpQ1uZs
 yKOOGouhzkCtzkficmwp3HTbQ7Q7RavJnD6YchgCuPPV6ZncXuwdI6obYc+BcTjnfWfPlCKifl
 V6lel/CKL4CFt/pcNwf2cyYbkhV8FWZx3tCq5PvaQJnqUNh8oKY8IjpJ8A3WVWHlEX8Wf9XwRp
 MWk5r9Vg2rW6VGDyv6OIPaZm045/i/wYuPgwUrxXhDRWh9qVlTkWvTHtCHPfupF3RzIp08ZPRK
 wjc=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Apr 2020 02:05:23 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v6 01/11] scsi: free sgtables in case command setup fails
Date:   Wed, 15 Apr 2020 18:05:03 +0900
Message-Id: <20200415090513.5133-2-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
References: <20200415090513.5133-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In case scsi_setup_fs_cmnd() fails we're not freeing the sgtables
allocated by scsi_init_io(), thus we leak the allocated memory.

So free the sgtables allocated by scsi_init_io() in case
scsi_setup_fs_cmnd() fails.

Technically scsi_setup_scsi_cmnd() does not suffer from this problem, as
it can only fail if scsi_init_io() fails, so it does not have sgtables
allocated. But to maintain symmetry and as a measure of defensive
programming, free the sgtables on scsi_setup_scsi_cmnd() failure as well.
scsi_mq_free_sgtables() has safeguards against double-freeing of memory so
this is safe to do.

While we're at it, rename scsi_mq_free_sgtables() to scsi_free_sgtables().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/scsi/scsi_lib.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 47835c4b4ee0..ad97369ffabd 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -548,7 +548,7 @@ static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 	}
 }
 
-static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
+static void scsi_free_sgtables(struct scsi_cmnd *cmd)
 {
 	if (cmd->sdb.table.nents)
 		sg_free_table_chained(&cmd->sdb.table,
@@ -560,7 +560,7 @@ static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 
 static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
 {
-	scsi_mq_free_sgtables(cmd);
+	scsi_free_sgtables(cmd);
 	scsi_uninit_cmd(cmd);
 }
 
@@ -1059,7 +1059,7 @@ blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
 
 	return BLK_STS_OK;
 out_free_sgtables:
-	scsi_mq_free_sgtables(cmd);
+	scsi_free_sgtables(cmd);
 	return ret;
 }
 EXPORT_SYMBOL(scsi_init_io);
@@ -1190,6 +1190,7 @@ static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
 		struct request *req)
 {
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
+	blk_status_t ret;
 
 	if (!blk_rq_bytes(req))
 		cmd->sc_data_direction = DMA_NONE;
@@ -1199,9 +1200,14 @@ static blk_status_t scsi_setup_cmnd(struct scsi_device *sdev,
 		cmd->sc_data_direction = DMA_FROM_DEVICE;
 
 	if (blk_rq_is_scsi(req))
-		return scsi_setup_scsi_cmnd(sdev, req);
+		ret = scsi_setup_scsi_cmnd(sdev, req);
 	else
-		return scsi_setup_fs_cmnd(sdev, req);
+		ret = scsi_setup_fs_cmnd(sdev, req);
+
+	if (ret != BLK_STS_OK)
+		scsi_free_sgtables(cmd);
+
+	return ret;
 }
 
 static blk_status_t
-- 
2.24.1

