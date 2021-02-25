Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F194324B06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233443AbhBYHLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:11:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:13993 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhBYHJF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:09:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614236945; x=1645772945;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=meQL1JMpFqt94nC7NLV1ujzWJeKhbSQBgmyhyvdKdTk=;
  b=fNbkqUeuhdm3tjfty6BdKjuHQbUlPJ+GSPxgnkU8iAMZh9z4HNbmyxHF
   klYjtZYgexqivEjcp1rlIUBrO7nz43rOml8e0+Q16p4nl9Kfd+enzl3c1
   CTjwaRCir3tDIEANeH4Ff1P+o18MSkZzU/h1gYiJYjiN3HmOlTwvAtUq6
   X6XpMOOGzmHEWqTsoT0Sy0dBuKymHJkSverIzh894Qg+a49pFi/gjVHgD
   nc67xG1fq/F9Put/VmSboecUrvg+3cIxEB04XJCNIpNVEWG8F91kxh47b
   3TXzmMtIytHkBcwGAQsnl+t4Qql7XUl9aat04Rcwdk5bwvhYpXgRlI6XC
   Q==;
IronPort-SDR: Splu0NwJn2Lc/Eg6O7NTiyyppfPnEghCKG0iVrrVqmoTapokEMSGiFUuD6021FODroz3H3VIH9
 Q4ce6/vG4P8IOq+9txz3X+oi84WbFjdpngFWcGAK4qlVJKzQlxzEyQvlxDeWiBiG9PVChr0nFC
 GwzY5FNDFpKThiFxE7QnA6NnXM9/9DAcqwF2VXkbz31Fhz1ZuEe6qahLLTMHlhGjXMHWbK3LVJ
 7sSPGpbUxaYhRKtsFd5q390syFa8CqV1kXDCZdb7EDhYpV1GFbnJo+b/vkPp1Lw0vfnKt3u7UO
 XB0=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="160751973"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:08:02 +0800
IronPort-SDR: AuTrhQqJhu9M50V0N87awvkORBzl7EqE/Bsom5asYLrpmasLJPLwqOC9ukvOydUq8Y+C/Xab3i
 XjKczvRRrcF9SKLBKjBf85KPW51eN1FM37oLGqB251LfjKamLlGmWxdUsyKM1NYo0PZc+T8TGr
 RpAJOPWesfHxAoNyGJKBdVrKl75ZLQEqoB8IA7GQX7mYwe6D1gWZrIte+lhfIY+n9SxLrkaRCA
 D8SkmrDOFiYwEmIb+yofq8NasWXAh1nqZsm2ccSVLBNiixuyI+D/1J9wjrrliw66+pvh/1WpiU
 xV+gdcwm58GNyJCfpC8TVA2f
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:49:24 -0800
IronPort-SDR: RWgwNxvF+jMxkY5pmDIYl1N9kFSic+cuJLznej9ATn2Ra1ri8n257BI4KQMBtBYiBoVqX4PqA3
 V3efPkeZ7//gvBqehB0pT4d0S0+O3oQPF9RqmXXbkkhh7CS8SHPXAhCU5jK358fIiKi0NA4Bti
 yVA6g1mGdoTrwtPxwgIsbPgjGyqUWLIFCt7iisO8IMgAB3Tfn5mjmYI3K/m8Ot1LJJHtB5G7pb
 Bji8m5Z4tj4sPzsUoVxpqw5mbH1626CSNdyjoVQvlVJ6Q/waivnRmiJOT3rdOCz+1tGMOIHlxg
 pnw=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:08:02 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 39/39] blktrace: debug patch for the demo
Date:   Wed, 24 Feb 2021 23:02:31 -0800
Message-Id: <20210225070231.21136-40-chaitanya.kulkarni@wdc.com>
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
 block/blk-lib.c                   |  4 ++++
 block/blk-zoned.c                 |  1 +
 drivers/block/null_blk/main.c     | 32 ++++++++++++++++++++++++-------
 drivers/block/null_blk/null_blk.h |  1 +
 4 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 752f9c722062..dd8854341bf6 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -98,6 +98,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
 		bio_set_op_attrs(bio, op, 0);
+		bio_set_prio(bio, get_current_ioprio());
 
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
@@ -191,6 +192,7 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 		bio = blk_next_bio(bio, 1, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
+		bio_set_prio(bio, get_current_ioprio());
 		bio->bi_vcnt = 1;
 		bio->bi_io_vec->bv_page = page;
 		bio->bi_io_vec->bv_offset = 0;
@@ -267,6 +269,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		bio = blk_next_bio(bio, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
+		bio_set_prio(bio, get_current_ioprio());
 		bio->bi_opf = REQ_OP_WRITE_ZEROES;
 		if (flags & BLKDEV_ZERO_NOUNMAP)
 			bio->bi_opf |= REQ_NOUNMAP;
@@ -319,6 +322,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 				   gfp_mask);
 		bio->bi_iter.bi_sector = sector;
 		bio_set_dev(bio, bdev);
+		bio_set_prio(bio, get_current_ioprio());
 		bio_set_op_attrs(bio, REQ_OP_WRITE, 0);
 
 		while (nr_sects != 0) {
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 833978c02e60..3df0f22cbc54 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -233,6 +233,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	while (sector < end_sector) {
 		bio = blk_next_bio(bio, 0, gfp_mask);
 		bio_set_dev(bio, bdev);
+		bio_set_prio(bio, get_current_ioprio());
 
 		/*
 		 * Special case for the zone reset operation that reset all
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..0c2bc7188d27 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -84,6 +84,10 @@ enum {
 	NULL_Q_MQ		= 2,
 };
 
+static bool g_discard;
+module_param_named(discard, g_discard, bool, 0444);
+MODULE_PARM_DESC(discard, "Enable queue discard (default: false)");
+
 static int g_no_sched;
 module_param_named(no_sched, g_no_sched, int, 0444);
 MODULE_PARM_DESC(no_sched, "No io scheduler");
@@ -156,6 +160,10 @@ static int g_max_sectors;
 module_param_named(max_sectors, g_max_sectors, int, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
+static unsigned int g_bounce_pfn;
+module_param_named(bounce_pfn, g_bounce_pfn, int, 0444);
+MODULE_PARM_DESC(bounce_pfn, "Queue Bounce limit (default: 0)");
+
 static unsigned int nr_devices = 1;
 module_param(nr_devices, uint, 0444);
 MODULE_PARM_DESC(nr_devices, "Number of devices to register");
@@ -350,6 +358,7 @@ NULLB_DEVICE_ATTR(submit_queues, uint, nullb_apply_submit_queues);
 NULLB_DEVICE_ATTR(home_node, uint, NULL);
 NULLB_DEVICE_ATTR(queue_mode, uint, NULL);
 NULLB_DEVICE_ATTR(blocksize, uint, NULL);
+NULLB_DEVICE_ATTR(bounce_pfn, uint, NULL);
 NULLB_DEVICE_ATTR(max_sectors, uint, NULL);
 NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
@@ -468,6 +477,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_home_node,
 	&nullb_device_attr_queue_mode,
 	&nullb_device_attr_blocksize,
+	&nullb_device_attr_bounce_pfn,
 	&nullb_device_attr_max_sectors,
 	&nullb_device_attr_irqmode,
 	&nullb_device_attr_hw_queue_depth,
@@ -539,7 +549,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors\n");
+			"memory_backed,discard,bounce_pfn,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -600,6 +610,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->blocking = g_blocking;
 	dev->use_per_node_hctx = g_use_per_node_hctx;
 	dev->zoned = g_zoned;
+	dev->discard = g_discard;
 	dev->zone_size = g_zone_size;
 	dev->zone_capacity = g_zone_capacity;
 	dev->zone_nr_conv = g_zone_nr_conv;
@@ -1588,15 +1599,10 @@ static void null_del_dev(struct nullb *nullb)
 
 static void null_config_discard(struct nullb *nullb)
 {
+	blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> 9);
 	if (nullb->dev->discard == false)
 		return;
 
-	if (!nullb->dev->memory_backed) {
-		nullb->dev->discard = false;
-		pr_info("discard option is ignored without memory backing\n");
-		return;
-	}
-
 	if (nullb->dev->zoned) {
 		nullb->dev->discard = false;
 		pr_info("discard option is ignored in zoned mode\n");
@@ -1609,6 +1615,17 @@ static void null_config_discard(struct nullb *nullb)
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
 }
 
+static void null_config_bounce_pfn(struct nullb *nullb)
+{
+	if (nullb->dev->memory_backed && nullb->dev->bounce_pfn == false)
+		return;
+
+	if (!nullb->dev->memory_backed && !g_bounce_pfn)
+		return;
+
+	blk_queue_bounce_limit(nullb->q, nullb->dev->bounce_pfn);
+}
+
 static const struct block_device_operations null_bio_ops = {
 	.owner		= THIS_MODULE,
 	.submit_bio	= null_submit_bio,
@@ -1881,6 +1898,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
 
 	null_config_discard(nullb);
+	null_config_bounce_pfn(nullb);
 
 	sprintf(nullb->disk_name, "nullb%d", nullb->index);
 
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 83504f3cc9d6..cd55f99118bf 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -86,6 +86,7 @@ struct nullb_device {
 	unsigned int queue_mode; /* block interface */
 	unsigned int blocksize; /* block size */
 	unsigned int max_sectors; /* Max sectors per command */
+	unsigned int bounce_pfn; /* bounce page frame number */
 	unsigned int irqmode; /* IRQ completion handler */
 	unsigned int hw_queue_depth; /* queue depth */
 	unsigned int index; /* index of the disk, only valid with a disk */
-- 
2.22.1

