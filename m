Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AAD1A3866
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Apr 2020 18:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgDIQyK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Apr 2020 12:54:10 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:24715 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgDIQyH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Apr 2020 12:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586451247; x=1617987247;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q++7tLiMOyjklktmG5UM9qExxC1QYLaiR3sPHhtXviQ=;
  b=iJLQiagGiYDY5NYzRSfWltaFaj9UmEfVL58I3l2kZ3AKyx+8YTlSGxIh
   jyafYE189o+FhiKjyKPgna8h9dYeVaAltJnSjHD/pDu5AEU8YRrlk9Db3
   A/DiFM3oKmYIgCYCA+0V7g+y1zO2WnUiCAd5DTuEaj/ChKhFBJLZJPLvD
   AqXzXesaARtsaZIGV4u/HQUrVff+D5LmNkZso/1MA6DfrUqh0DpbqP9uD
   b0qdVkQapvyGIaGLAPsRHaEfKgzq82hykmnsAS1FpmBt84tHKFdf0Trx7
   UCn3ylb0f5vmQ4CdXJQ9x+bX4I/VwUTexLII/0fsc+EQMwnheuDqaaoRQ
   Q==;
IronPort-SDR: HXPaPfkK95IBcn6lbT98CIrqVtLGfKXa0/iXI+S08PcfqJ0Dy/n6wOM3GMj4zuD2yKCV9lL0xv
 LzkgN9L4264gZhPF1J73TrUNM+CzZeFVph2hq/QlNYTT6kLp6xTkmySKZfnVeTomxN5aUvGwue
 eN4Y3K0iQZRw62MoZkOw1HNjaktXRiDSB4+qDmlG90fwTDfLliUqvl/9s8qrnrlyLM0lUc7oL6
 AQk1uKRy0/sidFkbUFp2MvKoo4SJlHSaTxEjzJ4ODARiM0UaW8OoMDPlECO4Kp46r3NOr5R5xi
 oK4=
X-IronPort-AV: E=Sophos;i="5.72,363,1580745600"; 
   d="scan'208";a="136423697"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Apr 2020 00:54:07 +0800
IronPort-SDR: Fau621jWYy6tQZ7S25GWwtivGduaB8ZHT3i9AhgIdDOkBVU2emVvyQ+s3wPi/tLYuJaUoEXQEV
 XVhte+26SNYRnwId/HG66MydHFCzEm6ET2zuemrPE9UTkykv63aFjgWmy2aOKIEUlsVyvvIG66
 44YK7Rsq+fiDK8KPqds/hKg0F5Tsgc9U9tFHhcLEl97Ig4HBog7N/SUxTj8pr45Waf8MhAuNaa
 6zkkH0sbZ8WeGC2EmjkZPN8gDDcy/A25SBF7YXI7LoaVHFbJviY2hc8cjtsfgSvuGxPjvWTaIH
 HS1KDqSxEUImH20I5QXdrbxn
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 09:44:46 -0700
IronPort-SDR: oeDJliF9+Gc5BrpOJzUUaj+cFpnU6A2fmoukfsV4u746HazOKY4LIbyIk6CW4GEAV0Irfz9M9c
 Eche1Dn4C4/sBkgNa9sYfR77o403hL9EfEcEyQnhlwoxompSuMI6OLUgdmmKJXkSm5Df0aIgKV
 uC8pL6ubm7PnEySMqdITeKxiAUSObR5EWJbKpaKeFNpI8OHnhoYUfp9BJU0bXHHhitvYFmfAHH
 FU7UyRV38Wwcdxie5LACm7TW5dgFYu/xWIGbsXRk+6xvNX0xKnRAIgGjSe6Ca8PgHVBTMB/zUW
 d8I=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 09 Apr 2020 09:54:06 -0700
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
Subject: [PATCH v5 06/10] scsi: export scsi_mq_free_sgtables
Date:   Fri, 10 Apr 2020 01:53:48 +0900
Message-Id: <20200409165352.2126-7-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

scsi_mq_free_sgtables is used to free the sg_tables, uninitialize the
command and delete it from the command list.

Export this function so it can be used from modular code to free the
memory allocated by scsi_init_io() if the caller of scsi_init_io() needs
to do error recovery.

While we're at it, rename scsi_mq_free_sgtables() to scsi_free_sgtables().

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

---
Changes to v4:
- Export scsi_mq_free_sgtables() instead of scsi_mq_uninit_cmnd()
---
 drivers/scsi/scsi_lib.c  | 7 ++++---
 include/scsi/scsi_cmnd.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index ea327f320b7f..b6b3ccd366da 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -548,7 +548,7 @@ static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
 	}
 }
 
-static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
+void scsi_free_sgtables(struct scsi_cmnd *cmd)
 {
 	if (cmd->sdb.table.nents)
 		sg_free_table_chained(&cmd->sdb.table,
@@ -557,10 +557,11 @@ static void scsi_mq_free_sgtables(struct scsi_cmnd *cmd)
 		sg_free_table_chained(&cmd->prot_sdb->table,
 				SCSI_INLINE_PROT_SG_CNT);
 }
+EXPORT_SYMBOL_GPL(scsi_free_sgtables);
 
 static void scsi_mq_uninit_cmd(struct scsi_cmnd *cmd)
 {
-	scsi_mq_free_sgtables(cmd);
+	scsi_free_sgtables(cmd);
 	scsi_uninit_cmd(cmd);
 	scsi_del_cmd_from_list(cmd);
 }
@@ -1060,7 +1061,7 @@ blk_status_t scsi_init_io(struct scsi_cmnd *cmd)
 
 	return BLK_STS_OK;
 out_free_sgtables:
-	scsi_mq_free_sgtables(cmd);
+	scsi_free_sgtables(cmd);
 	return ret;
 }
 EXPORT_SYMBOL(scsi_init_io);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index a2849bb9cd19..a6383ced6156 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -167,6 +167,7 @@ extern void *scsi_kmap_atomic_sg(struct scatterlist *sg, int sg_count,
 extern void scsi_kunmap_atomic_sg(void *virt);
 
 extern blk_status_t scsi_init_io(struct scsi_cmnd *cmd);
+extern void scsi_free_sgtables(struct scsi_cmnd *cmd);
 
 #ifdef CONFIG_SCSI_DMA
 extern int scsi_dma_map(struct scsi_cmnd *cmd);
-- 
2.24.1

