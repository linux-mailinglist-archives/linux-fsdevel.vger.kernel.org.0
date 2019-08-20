Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D029564A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbfHTExV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:21 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbfHTExT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276799; x=1597812799;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s3avTnFnXBTbDCO3GzkRgYC1I46d7Y9pb8l8EceqUII=;
  b=lk5pXW40gCHFq9hTX/FEpPL2ETcoMKaJ/YT/j7eJZUi43hzCGppBzRQ+
   6e+nqSvnWiZXiPvLsAdSJKI6+XcCu2EXPL/y+IYpNdLlsSNbgH3JO+p0T
   yBjH5hHOA/YNMv6RgZnd2wxXGLa5KHsTzJ7sr2nkO08dAblELdkfG+Tz1
   ZNaZs8yPCwcb+g/Tdgd93uW26Wrqk0fK1u1v3yOAEnZavsrtVaPx8V4Zt
   ExSOZx9ufmHM2vT151wGMu1u3vLxsgV1ApU2GpZd0PgzmjD3eFHwkt5Wb
   QZSgG8/L5tCQQ4BLAwxROqcykZoRR4UUgqmpPaztwE0uehFT/CSY6jcGF
   A==;
IronPort-SDR: nyGt6vUBofBKgxyXLZ5OHlbOUMJ36386R7RIXEh2V9J7yCWxDo4fxKTsMK1UPm98jDLOyyS6me
 1ZvEfmnFmp/5slKCBTNdbk11KGDWPXQbhpuzNUlcFyuzUSQEUJdt0SQjJDOFBaQJJgSXSXsNZ9
 WDt3qJrqB7p0LF8NTTkdg2x7N/0xIIpJohPwh6gwNgPSGgdV1wX7WP22GruKHrJhX8KkQQpwAJ
 EAbS+g0++4Ej3IIOW2cZz3453A75+LpU/2B56SIMwmYAH+xcjcNYJI6LSSFMI1JrHGh2890WkL
 NUg=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136304"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:19 +0800
IronPort-SDR: o453GWZAnj6t2w3zcyBiPlBLe+fpWlsbnG8AbpYmxD8wRPzq6h6snn3QDWOvh8U2K0SPNAdeou
 g64wRJeLeAYsOuMqmoLHiOaQ+Xw86gCV17xYAxYaIR3fiYqs4q3tkHzwQTCk/BoWfp4SNYZO4H
 MaAtz8T8dQ62qp7k8MNdqA9BEWw4cDD2HNV2Yz3V3xrnuPN+tWu2wskcmb6igDk5lcnwIpqy5w
 lVZctDGa9lXdPSYEOC4wULD9mewF5/gxMkSS9kQfkqPtejS6jUCQ5LasZPG95TgwKtH0nVVjYw
 zNWgZsdrQSW29M0fEjCHPnni
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:43 -0700
IronPort-SDR: SJFkfG209BS0q3KqKVtzNsynTn+a9a7SfkLJy7Cr9ufA/1Qnhfbfzg4SzX9HVlemagTprrb9dp
 ZS+RcXMVBkbTmw8s6TlsK1i2svtaiZtXdRRPCnGTNGqbmfJ4ouBFw9LaTKCEfi42l2Sanr/3KG
 EvsDulrtS7CfIVWlqQR8acSQGoXcOXKCnaFwLoZQkyvnIghQgGeSxBp6/GTA4hulqehtg0dJkr
 uhi3k5IVDDn1WK50u1DFAQVrSC0bc8Jc7WvVYFAdxRPqmml0jSLtYWGoIT2uL0kpFxazsVwk/b
 n38=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:15 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 08/15] btrfs-progs: support discarding zoned device
Date:   Tue, 20 Aug 2019 13:52:51 +0900
Message-Id: <20190820045258.1571640-9-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All zones of zoned block devices should be reset before writing. Support
this by introducing PREP_DEVICE_HMZONED.

This commit export discard_blocks() and use it from
btrfs_discard_all_zones().

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 common/device-utils.c | 23 +++++++++++++++++++++--
 common/device-utils.h |  2 ++
 common/hmzoned.c      | 27 +++++++++++++++++++++++++++
 common/hmzoned.h      |  5 +++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 7fa9386f4677..c7046c22a9fb 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -29,6 +29,7 @@
 #include "common/internal.h"
 #include "common/messages.h"
 #include "common/utils.h"
+#include "common/hmzoned.h"
 
 #ifndef BLKDISCARD
 #define BLKDISCARD	_IO(0x12,119)
@@ -49,7 +50,7 @@ static int discard_range(int fd, u64 start, u64 len)
 /*
  * Discard blocks in the given range in 1G chunks, the process is interruptible
  */
-static int discard_blocks(int fd, u64 start, u64 len)
+int discard_blocks(int fd, u64 start, u64 len)
 {
 	while (len > 0) {
 		/* 1G granularity */
@@ -155,6 +156,7 @@ out:
 int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		u64 max_block_count, unsigned opflags)
 {
+	struct btrfs_zone_info zinfo;
 	u64 block_count;
 	struct stat st;
 	int i, ret;
@@ -173,7 +175,24 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 	if (max_block_count)
 		block_count = min(block_count, max_block_count);
 
-	if (opflags & PREP_DEVICE_DISCARD) {
+	ret = btrfs_get_zone_info(fd, file, opflags & PREP_DEVICE_HMZONED,
+				  &zinfo);
+	if (ret < 0)
+		return 1;
+
+	if (opflags & PREP_DEVICE_HMZONED) {
+		printf("Resetting device zones %s (%u zones) ...\n",
+			file, zinfo.nr_zones);
+		/*
+		 * We cannot ignore zone discard (reset) errors for a zoned
+		 * block device as this could result in the inability to
+		 * write to non-empty sequential zones of the device.
+		 */
+		if (btrfs_discard_all_zones(fd, &zinfo)) {
+			error("failed to reset device '%s' zones", file);
+			return 1;
+		}
+	} else if (opflags & PREP_DEVICE_DISCARD) {
 		/*
 		 * We intentionally ignore errors from the discard ioctl.  It
 		 * is not necessary for the mkfs functionality but just an
diff --git a/common/device-utils.h b/common/device-utils.h
index d1799323d002..885a46937e0d 100644
--- a/common/device-utils.h
+++ b/common/device-utils.h
@@ -23,7 +23,9 @@
 #define	PREP_DEVICE_ZERO_END	(1U << 0)
 #define	PREP_DEVICE_DISCARD	(1U << 1)
 #define	PREP_DEVICE_VERBOSE	(1U << 2)
+#define	PREP_DEVICE_HMZONED	(1U << 3)
 
+int discard_blocks(int fd, u64 start, u64 len);
 u64 get_partition_size(const char *dev);
 u64 disk_size(const char *path);
 u64 btrfs_device_size(int fd, struct stat *st);
diff --git a/common/hmzoned.c b/common/hmzoned.c
index 7114943458ef..70de111f22da 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -216,3 +216,30 @@ int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
 #endif
 	return 0;
 }
+
+/*
+ * Discard blocks in the zones of a zoned block device.
+ * Process this with zone size granularity so that blocks in
+ * conventional zones are discarded using discard_range and
+ * blocks in sequential zones are discarded though a zone reset.
+ */
+int btrfs_discard_all_zones(int fd, struct btrfs_zone_info *zinfo)
+{
+	unsigned int i;
+
+	/* Zone size granularity */
+	for (i = 0; i < zinfo->nr_zones; i++) {
+		if (zinfo->zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+			discard_blocks(fd, zinfo->zones[i].start << 9,
+				       zinfo->zone_size);
+		} else if (zinfo->zones[i].cond != BLK_ZONE_COND_EMPTY) {
+			struct blk_zone_range range = {
+				zinfo->zones[i].start,
+				zinfo->zone_size >> 9 };
+			if (ioctl(fd, BLKRESETZONE, &range) < 0)
+				return errno;
+		}
+	}
+
+	return 0;
+}
diff --git a/common/hmzoned.h b/common/hmzoned.h
index fbcaaf2da20e..c4e20ae71d21 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -56,12 +56,17 @@ int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
 
 #ifdef BTRFS_ZONED
 bool zone_is_sequential(struct btrfs_zone_info *zinfo, u64 bytenr);
+int btrfs_discard_all_zones(int fd, struct btrfs_zone_info *zinfo);
 #else
 static inline bool zone_is_sequential(struct btrfs_zone_info *zinfo,
 				      u64 bytenr)
 {
 	return true;
 }
+static inline int btrfs_discard_all_zones(int fd, struct btrfs_zone_info *zinfo)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* BTRFS_ZONED */
 
 #endif /* __BTRFS_HMZONED_H__ */
-- 
2.23.0

