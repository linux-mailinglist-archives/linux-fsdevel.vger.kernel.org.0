Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE0E19D4CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Apr 2020 12:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390580AbgDCKNL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:11 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56741 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390520AbgDCKNI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585908789; x=1617444789;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RckJ1sRQ4Jj+9CntP2Tbns2sAuC38WlYy87tzhye2Ow=;
  b=pWmNQycnyagogkNd09q9VBw9IYlV1wBCoW+PEUDH6SD2Eb7qwkzUS311
   bs1yIe9LbcKrALitYNWip07EraAP5HPuaLdSqYK33MDg9bnISEMW7w4z3
   mj5XvGrV1I00sUAueiLn6bASBo80NHz61IJExrPrMupzhs68DKzVWMOzO
   lp3/Ex4qCyk4dzUscz5aXW5LNfMRkhEuxSQdH5pTLELfbqhyGb+PaagNX
   010f8DgmbFxj7USg8KZnGETiztiloaYBHt+/rdm/IWoyDOZROD4cPkDw/
   Vo9ULAk5gsU9483DIobp26pSfOi0ZrTe92fg0mZs/3X6h9pTBSo67xYDe
   A==;
IronPort-SDR: gYsU7QmrXmUw3hH+QiEkiLd+P0zY0s299+MN9udaAHka9+rAFhpiJLUzvdGaJEo48qqUKKiFth
 YSpjHPNgbEswE22eICzjz4jYBp9BiMb6ol3oI4NlrQeKZBa3MONl34FfQz8WP/rBp3ONmBPEef
 lNErwfUnKwTXcFIs0/2HsC0KZyMtEb3eOHNes8lpLwYfREYUEnenJJG/+5DPuPoOhlwxC/RV/W
 V/XUmlHnAwVRGdENLEwKTFAj8O5zgZKVDrrkO0wHe/9sExP1qYFxBwg4heIXWHsH5NF0+ifNE/
 Vys=
X-IronPort-AV: E=Sophos;i="5.72,339,1580745600"; 
   d="scan'208";a="135956026"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Apr 2020 18:13:08 +0800
IronPort-SDR: 9myJisO6mosf6IfHTYB47hWWwsaUeGlvw0St+25JPqG39PFK8BXVqdb7TSShD+iIaI1uhKKlur
 Rx9ymWLfxmAbB2cWD0X8HoSqOpVB/Nh+AppbLhVKYpmg55S2+D26dISTRQdjCON0ITVdPlrqSZ
 KnKYjQHnBk+2Vo3/8Ag8nFG6tDM1RchHJwrd0icqgje2GaoSrKtG6y6eGu8CsnUzm/bhhGr7gB
 o+dTaE/ACku5RmZY+gP7/Q53PesUFW9pUWWcxoF7ynHaLOI6wcka5IbtGNeq7hm/01qUo39VvT
 DEiOJwE/QLAupAUjgmkXD/3T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 03:03:58 -0700
IronPort-SDR: K6D54gYeH8kgtYZEz21xvEkqiwMeWyeW+I2LtzEB8WYp5xmcVQlsw+XUiZl9IiBls0e+bXM4Nf
 iS7FhlfTcbXbOGXH0Pygh5vkr6AWtsFSC7rMIknn+1+CxYqoQtKjlwTMmxOZc3hzJSZR9Kvmbx
 gb+TNpnGu+ikbHp1PVdEfiBnPf5ZfDYBUrQSz7ow/eRjmLE004s9uBrmqUYxbhB/O2CyT1SvFT
 TkcuhR0r4ZLEhlOIYrV8lxk4iHM5KYom2RXOpeiNt/WOFuvDfYYqNPJCkpPpJZr6Vmn3SGuSYG
 Wl8=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 03 Apr 2020 03:13:05 -0700
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
Subject: [PATCH v4 06/10] scsi: export scsi_mq_uninit_cmnd
Date:   Fri,  3 Apr 2020 19:12:46 +0900
Message-Id: <20200403101250.33245-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
References: <20200403101250.33245-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

scsi_mq_uninit_cmnd is used to free the sg_tables, uninitialize the
command and delete it from the command list.

Export this function so it can be used from modular code to free the
memory allocated by scsi_init_io() if the caller of scsi_init_io() needs
to do error recovery.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 drivers/scsi/scsi_lib.c  | 9 ++++++---
 include/scsi/scsi_cmnd.h | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ea327f320b7f..4646575a89d6 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -57,8 +57,6 @@ static struct kmem_cache *scsi_sense_cache;
 static struct kmem_cache *scsi_sense_isadma_cache;
 static DEFINE_MUTEX(scsi_sense_cache_mutex);
 
-static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd);
-
 static inline struct kmem_cache *
 scsi_select_sense_cache(bool unchecked_isa_dma)
 {
@@ -558,12 +556,17 @@ static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 				SCSI_INLINE_PROT_SG_CNT);
 }
 
-static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
+/**
+ * scsi_mq_uninit_cmd - uninitialize a SCSI command
+ * @cmd: the command to free
+ */
+void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
 {
 	scsi_mq_free_sgtables(cmd);
 	scsi_uninit_cmd(cmd);
 	scsi_del_cmd_from_list(cmd);
 }
+EXPORT_SYMBOL_GPL(scsi_mq_uninit_cmd);
 
 /* Returns false when no more bytes to process, true if there are more */
 static bool scsi_end_request(struct request *req, blk_status_t error,
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index a2849bb9cd19..65ff625db38b 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -167,6 +167,7 @@ extern void *scsi_kmap_atomic_sg(struct scatterlist *sg, int sg_count,
 extern void scsi_kunmap_atomic_sg(void *virt);
 
 extern blk_status_t scsi_init_io(struct scsi_cmnd *cmd);
+extern void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd);
 
 #ifdef CONFIG_SCSI_DMA
 extern int scsi_dma_map(struct scsi_cmnd *cmd);
-- 
2.24.1

