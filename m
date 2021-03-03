Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9887932C525
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbhCDATX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:19:23 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53246 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357249AbhCCKtH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614768546; x=1646304546;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+kQZIq5ZqHuqmSavJsQFkjIM7cuk0e5XBPEli2rM270=;
  b=DENB2iFwvZ5uYo5w9VtNNfHIwiM7gB1Oul6l9uyo/cdqS/RO9laE5YFC
   LqFoD9DyMREAkPSefSUSQfgul+ftil8UvR3wdl1ZoJkeKOrU9JJJrD1rZ
   JTidiU3slSV9H7WNF3s3Wa2yQDr7rpaypsgVXOAOxLJbYplNaAKjHPH6M
   oN2IYYjo/HFchuDF1evpfiHB4yZn4BNy2AH8AR1t1YQDHUFKMOvdCqsqf
   +a+FWxA4iX5a88tjlhpd9brIPXOIVHpi4P/Fy+IMxN+ENJMcyYKz8L6we
   Y0eesacCZLFenhNgXae+P1hLVCqSgTDPdhcAn93cmWoryhMoDqiveEcGn
   w==;
IronPort-SDR: AfjUnC2Y6vPF79yP5+prj1jY0AsoJsdfGqHNwjU+iHilDxR443bzxbqxyMs2RA8IB99mb9HOIL
 8K40X64UlLrJp+Edgm6/QlmHoe0qB0rjLmcgjtEmCBS6h1nvhQYN0fRIGDdSW/RBtwwF2jbj/1
 pAkk0SQngacuuhAYktKbnX+/o9Q749kqwfuQL3gQi16FnO6p3d4JQ5Tj7AIJaBpbJP/nLaGQ8k
 Ll+0HMPOHntTUQrw+KjU+Pb84JTVhhdtfB08wtgwhDDR48EG/iDQ56GgK4hajHg3H0fAPmMQgQ
 uPg=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; 
   d="scan'208";a="271857769"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 16:55:55 +0800
IronPort-SDR: OmRSHPYdWcWcaoxxA5bueIc9HI8oMsuC0PeMv3GsVfmvdq08U4ZyFSM0DrAHwxHS1XddQ3f/wv
 sT8RMR0IlMsNhby84FXK/H9rFQPpKUyP9stokOu+YM98k7KKITdUZ88SNciVWFcQ1VN727aoXP
 AshFuyu2+WwazbCXvGXWUSxXWLw8WcEfM57lhdUipZ4n3vsZjIYWzBjbI6NLsSNki6K+m/VLk6
 29K6bHDTcdd97f9WIGbV8OmnAJAlL2WgQUUepWmavAJCo8g/6N6wgu6DIwqEeERBjYyiWrB6zn
 enxixgweC8yL4YKeA92DSBuB
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 00:37:10 -0800
IronPort-SDR: C4fwHlnctbeatCivshzcw6hXw2Dz0oQ7CaXb41YHdxgsVaOX4jnH7WYqvvyg6M5zpZ9Opu76k4
 ExcFE3smyrL+WS2EsCVB+MLqVo/j4P+ppWpQ3UJpPXCfC/9jl7DXUPEd6lnt9mqTEr/Kr9vER7
 bCngdSrKUEA4kta3WRmzlQIzaePqNU2BCONC9/Z/p7rN/fNDCtx8XfaHpLIUhQA42w6RPP/T2H
 TOh3EBwnOLJF3uUd3PnueZenRsBgm5tDDCK+CmBZ1SLwW69s6MeJLEnUI62+LdWihoktvN+gwI
 8Tk=
WDCIronportException: Internal
Received: from jpf010014.ad.shared (HELO naota-xeon.wdc.com) ([10.225.49.91])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2021 00:55:54 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 2/3] btrfs: zoned: move superblock logging zone location
Date:   Wed,  3 Mar 2021 17:55:47 +0900
Message-Id: <fe07f3ca7b17b6739cff8ab228d57bdbea0c447b.1614760899.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1614760899.git.naohiro.aota@wdc.com>
References: <cover.1614760899.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit moves the location of superblock logging zones basing on the
fixed address instead of the fixed zone number.

By locating the superblock zones using fixed addresses, we can scan a
dumped file system image without the zone information. And, no drawbacks
exist.

The following zones are reserved as the circular buffer on zoned btrfs.
  - The primary superblock: zone at LBA 0 and the next zone
  - The first copy: zone at LBA 16G and the next zone
  - The second copy: zone at LBA 256G and the next zone

If the location of the zones are outside of disk, we don't record the
superblock copy.

The addresses are much larger than the usual superblock copies locations.
The copies' locations are decided to support possible future larger zone
size, not to overlap the log zones. We support zone size up to 8GB.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/zoned.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 1324bb6c3946..b8f50dc9fbb0 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -24,6 +24,15 @@
 /* Number of superblock log zones */
 #define BTRFS_NR_SB_LOG_ZONES 2
 
+/* Location of superblock log zones */
+#define BTRFS_FIRST_SB_LOG_ZONE SZ_16G
+#define BTRFS_SECOND_SB_LOG_ZONE (256ULL * SZ_1G)
+#define BTRFS_FIRST_SB_LOG_ZONE_SHIFT const_ilog2(BTRFS_FIRST_SB_LOG_ZONE)
+#define BTRFS_SECOND_SB_LOG_ZONE_SHIFT const_ilog2(BTRFS_SECOND_SB_LOG_ZONE)
+
+/* Max size of supported zone size */
+#define BTRFS_MAX_ZONE_SIZE SZ_8G
+
 static int copy_zone_info_cb(struct blk_zone *zone, unsigned int idx, void *data)
 {
 	struct blk_zone *zones = data;
@@ -112,10 +121,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
 
 /*
  * The following zones are reserved as the circular buffer on ZONED btrfs.
- *  - The primary superblock: zones 0 and 1
- *  - The first copy: zones 16 and 17
- *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
- *                     the following one
+ *  - The primary superblock: zone at LBA 0 and the next zone
+ *  - The first copy: zone at LBA 16G and the next zone
+ *  - The second copy: zone at LBA 256G and the next zone
  */
 static inline u32 sb_zone_number(int shift, int mirror)
 {
@@ -123,8 +131,8 @@ static inline u32 sb_zone_number(int shift, int mirror)
 
 	switch (mirror) {
 	case 0: return 0;
-	case 1: return 16;
-	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
+	case 1: return 1 << (BTRFS_FIRST_SB_LOG_ZONE_SHIFT - shift);
+	case 2: return 1 << (BTRFS_SECOND_SB_LOG_ZONE_SHIFT - shift);
 	}
 
 	return 0;
@@ -300,10 +308,25 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
 		zone_sectors = bdev_zone_sectors(bdev);
 	}
 
-	nr_sectors = bdev_nr_sectors(bdev);
 	/* Check if it's power of 2 (see is_power_of_2) */
 	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
 	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
+
+	/*
+	 * We must reject devices with a zone size larger than 8GB to avoid
+	 * overlap between the super block primary and first copy fixed log
+	 * locations.
+	 */
+	if (zone_info->zone_size > BTRFS_MAX_ZONE_SIZE) {
+		btrfs_err_in_rcu(fs_info,
+				 "zoned: %s: zone size %llu is too large",
+				 rcu_str_deref(device->name),
+				 zone_info->zone_size);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	nr_sectors = bdev_nr_sectors(bdev);
 	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
 	zone_info->max_zone_append_size =
 		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;
-- 
2.30.1

