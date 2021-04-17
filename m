Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5494F362CE5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 04:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235466AbhDQCdy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 22:33:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17957 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQCdx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 22:33:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618626807; x=1650162807;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M2olJXYeF+UIjCTOBygvjDqf/S+qS1mKqstmI3YoyAQ=;
  b=ByF7AE8X2OUTum1GxDCtJeo9gtF4F5faJ5lc1PWvJpEiJR1bApk2CX7L
   dbzfxmJE4Zih9mk5TLblOcyWvO/b4H7OSgYYLcXqDEsYpQM99oJReUE7z
   1VcujWWqq4BdfepXmV/1mAwK/YTbMEN6wj2Lf8vqvBw0/Mmsah2TdIO16
   6gjW5+ivHs/8edKR+g/HbwhNh85xDVb0+E2knuUJ06/0hc2k+HIYiiLeT
   uObRBsRyUtVYgJHhycufMjlh79gBkYUb1bEFaI3ynT6U1pVqZZdU6hVvj
   C9UGzxaCz8tm9lt27M9IIZo5IrQv3OGhA8GPXxWNG1OeHFLP/wWwtxIsP
   A==;
IronPort-SDR: vMNKW6kwmjU1AU53BRX582/nsbavO1otvhPVNHLn3T2RnQ3WYOYdNNtTeSu+3uP0+smQthDLpA
 3HQ6/RNLh8fMSiGx8IysBfgnVdhYzikWMD0K26C/vpPj+zLQrVTG9/MD6QJTkx5EtClFbPoklN
 K3ON6oqbyycLsC5DHksd3I8W4wLsMn0KEx8cTGNJ0ZGiaV4R7wr4I3PxXMzLlJM2zwe9zdi7fW
 rWz4L4h5KXnRStUpC5jLirI3UuX7f47GM9tACHkDZVVDiTJzhSBpnrvSCg4cnDG94ZNoYMVOaY
 WZ0=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; 
   d="scan'208";a="165193272"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 10:33:27 +0800
IronPort-SDR: 3B4kx/poib3uHSsSdNpwXxhWtBgki1RcaPN7xUMV2OZkBAMvDf3Qujo6+Ngwb4cIDDVWJiFgs7
 objZ0Cj3q60btnk3CiRZhGc90cQCS0BMsN1S9/01Gx3dhbBEhn0NDSHrD7yQnaLHnLLMCWgby9
 3YZIx2VNjmqr/cibqiddD4CEHlK4LlRwtPQip56oh0MczHOLo6pzBeXBJn2X7crbn1ITu3sfUL
 gKpNmItPyFAlDh+ELS6JuXu/CAh6CRN2VFbfd5jk41P+Q/PTsX69+zhVnIPYNBdRbrq6eAePoN
 DT0rSNhrwss48UVZ2yBUzw4e
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 19:12:41 -0700
IronPort-SDR: UQflehws6aKDT+mFZ2nVQiUGb2lRUwWiMuBTx9jxGjceks+o06GOUReKHZ5fkVXjt7Kj5B/CZy
 Mp0Ws+qZfN+7WYGWYst3lEYumdIWJKlDCPxHvhR3q+AOWEUrWg4EIcgZ9stY6RgD8+AuNB0WNW
 xHduyhNolA7A+ImExw3mcQc08lDB9cUDyKFHP0pqsXMA73uC5RH42QEgfkZ4eBaL6/Q078vJpu
 wh5OcUneAqZuDkBjpm6TDPxIE0bhp4yo+cURINauqGwoe8qeHV11jqbhnar9TCvep01s+iLBkl
 cKw=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2021 19:33:27 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 1/3] dm: Introduce zone append support control
Date:   Sat, 17 Apr 2021 11:33:21 +0900
Message-Id: <20210417023323.852530-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210417023323.852530-1-damien.lemoal@wdc.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
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

Fixes: 8e225f04d2dd ("dm crypt: Enable zoned block device support")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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

