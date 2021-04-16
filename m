Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6836B3617FF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 05:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbhDPDGA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 23:06:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63371 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234806AbhDPDF6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618542333; x=1650078333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NwfKGSQILmjdwgHuwjMoyjbZ2rm26aZiGYIjk3FC6bk=;
  b=ceDB56gK4KXfrgHy7YYq3X4LIc6QxDx3JHFsxrLZ2yGDTrOyRwj+C/Qw
   vWi7Esq1vlc+clFsDC9V8CWz7+7TKuB/0MBL7lIWwB0Sopi65Oaiu1x5y
   NJCDzR/w4YvsnLiP+9QTvj1cV4ucyuPpd3/m7wiq1VZif3ELxAtCPvn7i
   5jKdq1Zp9o4i0Z+P3ZcfuL7yHlWCe+pBBHKVUdwArNzpWJqYlXYG8H0OI
   4F79V692VboVhIPPjcz5YtUBeKcy3PvtHVOB4IxORlmtsyr/31u4HknC9
   tIRvOMEPYuxGjOCtVoKfKBbkhv5a1ZYnGDJ4AvOxtOYHVwq/9qoivMJCD
   g==;
IronPort-SDR: l4EIBOhaJNN1npSAIpEtwxvRKGuHmN0ap7F40LvgLUuun1ShgYqc8Emo4w5uvohNyMmc2MTzWz
 uRpZEGqxOz1VyX4FlpnHN/hUVC/qhYsqE1+vZWzoMhqx8W9cFuRresZboThK0iIZ7XtKSj6Xk3
 wybOlOXCgvNJGuyXPmS9KDFyC+P2N8HJ4J4+KxvF83Y1vzL5hEsxZZwi1KixSaN0lR/zLrHHOd
 VWc8smXWukt5mMTn8THkUeZ+g6Rz0JVzCmSBiQPLMzt9nJweJinlqAmnl118l5Dcwxftxv/72C
 rmQ=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="169567867"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 11:05:32 +0800
IronPort-SDR: f8yokaj9wPSgxAzwUxFLWrg7O4NCsV+GmF/0s6mNkVen2QkCfv6b5TRS/CHyyQa+hcRQhS0KeV
 U2pXKb9eqh8s1E4L/0saGxMVLKz9V4AssBImJnXfkM5TgM0AWMzEHl+xBevsrBF+XgBsVpQqS0
 2fFd0eT13dZk32MJHp30omuGKXb7aQf1rzhk6Hk1vdUmw/h096dJvtvobXX3AUD4Yg7eiWO9dB
 Iq6ZSKdfWBati2bjs4zosLYrGrkh+SKiURGfq7GTYKCqDi/wHLG32CvoJUaeir0W3MZi/A9F5k
 0u+OyhpLJp4/iUNSvCpAC9qA
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 19:44:51 -0700
IronPort-SDR: Uc9KTrW6k6VQOr13ItTIaG8m3FB4YcJF1CzR6j/OxyKZ6But3DAOGBk6j8DkP8U3UokM2KOgF7
 bp6T/GYt4q1nYRIGoeV5RTgAl77CZr4yaRyzL+yL5c7TyFo7XOWZXM7gQgHLK5gymIHR6nlCfR
 iHQyTFiLU5CBMsrjLAlzrcCNPhqBRWgObvhXD4wNc83bClCRUuptsE2Ssn/mOwjvp72nn7sUMn
 0nPclDz8ZKEhM3vTrOVPZRiOZ5yCYZucvpACEdx8vTk9aaFV6EM0QgE7PsLZTC2lmjJAhNKH16
 wXc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 20:05:32 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 1/4] dm: Introduce zone append support control
Date:   Fri, 16 Apr 2021 12:05:25 +0900
Message-Id: <20210416030528.757513-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416030528.757513-1-damien.lemoal@wdc.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the boolean field zone_append_not_supported to the dm_target
structure to allow a target implementing a zoned block device to
explicitly opt out from zone append (REQ_OP_ZONE_APPEND) operations
support. When set to true by the target constructor, the target device
queue limit max_zone_append_sectors is set to 0 in
dm_table_set_restrictions() so that users of the target (e.g. file
systems) can detect that the device cannot process zone append
operations.

Detection for the target support of zone append is done similarly to
the detection for other device features such as secure erase, using a
helper function. For zone append, the function
dm_table_supports_zone_append() is defined if CONFIG_BLK_DEV_ZONED is
enabled.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm-table.c         | 41 +++++++++++++++++++++++++++++++++++
 include/linux/device-mapper.h |  6 +++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
index e5f0f1703c5d..9efd7a0ee27e 100644
--- a/drivers/md/dm-table.c
+++ b/drivers/md/dm-table.c
@@ -1999,6 +1999,37 @@ static int device_requires_stable_pages(struct dm_target *ti,
 	return blk_queue_stable_writes(q);
 }
 
+#ifdef CONFIG_BLK_DEV_ZONED
+static int device_not_zone_append_capable(struct dm_target *ti,
+					  struct dm_dev *dev, sector_t start,
+					  sector_t len, void *data)
+{
+	struct request_queue *q = bdev_get_queue(dev->bdev);
+
+	return !blk_queue_is_zoned(q) ||
+		!q->limits.max_zone_append_sectors;
+}
+
+static bool dm_table_supports_zone_append(struct dm_table *t)
+{
+	struct dm_target *ti;
+	unsigned int i;
+
+	for (i = 0; i < dm_table_get_num_targets(t); i++) {
+		ti = dm_table_get_target(t, i);
+
+		if (ti->zone_append_not_supported)
+			return false;
+
+		if (!ti->type->iterate_devices ||
+		    ti->type->iterate_devices(ti, device_not_zone_append_capable, NULL))
+			return false;
+	}
+
+	return true;
+}
+#endif
+
 void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 			       struct queue_limits *limits)
 {
@@ -2091,6 +2122,16 @@ void dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
 	if (blk_queue_is_zoned(q)) {
 		WARN_ON_ONCE(queue_is_mq(q));
 		q->nr_zones = blkdev_nr_zones(t->md->disk);
+
+		/*
+		 * All zoned devices support zone append by default. However,
+		 * some zoned targets (e.g. dm-crypt) cannot support this
+		 * operation. Check here if the target indicated the lack of
+		 * support for zone append and set max_zone_append_sectors to 0
+		 * in that case so that users (e.g. an FS) can detect this fact.
+		 */
+		if (!dm_table_supports_zone_append(t))
+			q->limits.max_zone_append_sectors = 0;
 	}
 #endif
 
diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
index 5c641f930caf..4da699add262 100644
--- a/include/linux/device-mapper.h
+++ b/include/linux/device-mapper.h
@@ -361,6 +361,12 @@ struct dm_target {
 	 * Set if we need to limit the number of in-flight bios when swapping.
 	 */
 	bool limit_swap_bios:1;
+
+	/*
+	 * Set if this target is a zoned device that cannot accept
+	 * zone append operations.
+	 */
+	bool zone_append_not_supported:1;
 };
 
 void *dm_per_bio_data(struct bio *bio, size_t data_size);
-- 
2.30.2

