Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96EEF1124D5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfLDI1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:45 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLDI1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448066; x=1606984066;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G4NpQ2JyYnw5D/LgV6JIxZP9vvkUA4GtujvP4ktMxWo=;
  b=Pn5LAFgKZZHCMEcheOWe4KwU7E6FD0O4+0O93Z6iYGYfd+kPXzqtJxJk
   as2OXq8jY+tv5GeUcVHbythhn6KpR0Y3J9jI9qv1GYS5Um+aX9fHjQZGJ
   +E2hNVoalMOKhhW1knJfXu1j6PCOSW63ppP1VBSlv95N+aLDM27Kko3i5
   y2CSlI18cUEnryZV2GKUNbq/DB9XwtqKbF5MZBMWAuN98bq3oJjc7EG5g
   wSII4mSPApusWwlhqfbDx9ApEZN9ZzX+F4vb+zpClqDEsqyqemfgXJR3h
   elbHeqApv5jzsjOqmVBOFTEZGUxQoR9QGB+AVO6cqDUIMzSDql5SWyV9A
   w==;
IronPort-SDR: LwZp0I7m1Uzk74Pmqr45pkeoa+V4quP//SwIakFrYR1c2EfFoQlyFvZCqeSxWdaECLI/OijoY/
 5MSfj1el3y+S9SWr/NrWxMiFJvKwjUoiWoj++v/HGjnXAcURjMqgZdBhA+xtrcWezEVVVBJ4ju
 jWUgjLYsGSH/zFb6fQionConr3GVDbwmfO7q3yJYmOGaajTXjxcXkJPm40sZxAEJ4SxVPzOX6u
 avjGz89hZHf8hdV+c1auTsnswVd2uFSX8on2028vjCHWxwKzKPVrvEU3QRreUuwEeEhJP7iEiV
 dHY=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031745"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:27:46 +0800
IronPort-SDR: bA9O/UAHB9YEaUXHhh8FuJTzgxtnQwv7sKvdT32e74Cl6G5yCeKYb+y41qTpqWiPR/iyJYqG5Z
 CxEuTzUY769GqE+3BDkmmX9k6p60plPw1eopjJtffyIPnzFG8Br/oPYVhQZIf4tsC126LXMjCN
 KHYezjgVrWzIXD6UZT/+75OXAqECcTLnT8wktkq0vuGBp87pkFrkqa/EdD22H4p5tx8JKhNSh5
 DFt82zm86Jzs5vnlEGfIvDktJy7d+CpmKaJcMRn0PUU0V/VxF8rKPkPfISDC83Udk4+lQ2soeX
 9I1uObbE9dhpvXNndGMjxhB4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:31 -0800
IronPort-SDR: q9vZ9QIF3fcyKL17H7ImZOzp/G5J8ItwSmbBGj6Baq2cp2idWCPr7RlB5GdHzt7wkjzhXl7mtn
 k4qBEdKsMqxY5DScXpOswZiToafwRiFQXF00HclbNNJD2C+ajC/v92Aau316U/HrLdOr61LJht
 SOxIhbXTBfY1wQzkV2AXsq7jcG/eiMGK/C0RpxvO8Qmm92o6EP/NqVxF4UgtpYYGwofQakcKNT
 2JhwNv//URK5wVtrAI37PrjRtDKt8UdaYAJpm/Tq/7hJFtNxgmI/8UY2SXOUKBFlDBmVgK2XsJ
 gc0=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:42 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 07/15] btrfs-progs: support discarding zoned device
Date:   Wed,  4 Dec 2019 17:25:05 +0900
Message-Id: <20191204082513.857320-8-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
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
 common/device-utils.c | 32 ++++++++++++++++++++++++++++++--
 common/device-utils.h |  2 ++
 common/hmzoned.c      | 29 +++++++++++++++++++++++++++++
 common/hmzoned.h      |  6 ++++++
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/common/device-utils.c b/common/device-utils.c
index 7fa9386f4677..2689f157aeea 100644
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
+	struct btrfs_zoned_device_info *zinfo = NULL;
 	u64 block_count;
 	struct stat st;
 	int i, ret;
@@ -173,7 +175,30 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 	if (max_block_count)
 		block_count = min(block_count, max_block_count);
 
-	if (opflags & PREP_DEVICE_DISCARD) {
+	ret = btrfs_get_zone_info(fd, file, opflags & PREP_DEVICE_HMZONED,
+				  &zinfo);
+	if (ret < 0)
+		return 1;
+
+	if (opflags & PREP_DEVICE_HMZONED) {
+		if (!zinfo) {
+			error("unable to load zone information of %s", file);
+			return 1;
+		}
+		if (opflags & PREP_DEVICE_VERBOSE)
+			printf("Resetting device zones %s (%u zones) ...\n",
+			       file, zinfo->nr_zones);
+		/*
+		 * We cannot ignore zone discard (reset) errors for a zoned
+		 * block device as this could result in the inability to
+		 * write to non-empty sequential zones of the device.
+		 */
+		if (btrfs_discard_all_zones(fd, zinfo)) {
+			error("failed to reset device '%s' zones", file);
+			kfree(zinfo);
+			return 1;
+		}
+	} else if (opflags & PREP_DEVICE_DISCARD) {
 		/*
 		 * We intentionally ignore errors from the discard ioctl.  It
 		 * is not necessary for the mkfs functionality but just an
@@ -198,6 +223,7 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 	if (ret < 0) {
 		errno = -ret;
 		error("failed to zero device '%s': %m", file);
+		kfree(zinfo);
 		return 1;
 	}
 
@@ -207,6 +233,8 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		return 1;
 	}
 
+	kfree(zinfo);
+
 	*block_count_ret = block_count;
 	return 0;
 }
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
index e11e56210709..5803b2c17a2b 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -16,6 +16,7 @@
  */
 
 #include <sys/ioctl.h>
+#include <unistd.h>
 
 #include "common/utils.h"
 #include "common/device-utils.h"
@@ -151,6 +152,34 @@ static int report_zones(int fd, const char *file, u64 block_count,
 	return 0;
 }
 
+/*
+ * Discard blocks in the zones of a zoned block device. Process this
+ * with zone size granularity so that blocks in conventional zones are
+ * discarded using discard_range and blocks in sequential zones are
+ * discarded though a zone reset.
+ */
+int btrfs_discard_all_zones(int fd, struct btrfs_zoned_device_info *zinfo)
+{
+	unsigned int i;
+
+	ASSERT(zinfo);
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
+	return fsync(fd);
+}
+
 #endif
 
 int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
diff --git a/common/hmzoned.h b/common/hmzoned.h
index d229b946e5ed..631780537a77 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -54,12 +54,18 @@ int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
 
 #ifdef BTRFS_ZONED
 bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo, u64 bytenr);
+int btrfs_discard_all_zones(int fd, struct btrfs_zoned_device_info *zinfo);
 #else
 static inline bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo,
 				      u64 bytenr)
 {
 	return true;
 }
+static inline int btrfs_discard_all_zones(int fd,
+					  struct btrfs_zoned_device_info *zinfo)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* BTRFS_ZONED */
 
 #endif /* __BTRFS_HMZONED_H__ */
-- 
2.24.0

