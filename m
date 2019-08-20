Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AC895645
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2019 06:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfHTExP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 00:53:15 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11098 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729159AbfHTExO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 00:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566276793; x=1597812793;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ye/0Ll1y3LvM9rwKSs/3RvcW7W0urkL6yR9I1InYY8k=;
  b=cdh6KlSsAn9y0PFrFy3CK6YGNB0fDkqDAD/FsIpUBAlqhnk0+LDZ6/zx
   dvizhLF55NX4WUFREPMdriyVPT+Q17ZRo7GZe1HqTr88tPPxSt30+gTYI
   HA73rF27KlxkKVQzKDa1xkfeExMtoc3Q9FoTqVb9k3vNpbCm+Di+F1ue+
   bkmGFiS2PX3CZx1aLBTQhH9KMGi4pBAnPPMPnN1dt8hsAgFOsXnxbX5nS
   1zno0IhldeZvdRR6iudX+Ng4N9lq4BO1xjvSOJ1eWu+jAeRP/OPWN5ffD
   pyl6pVtV0bxze1W+V7TF6zkp0jKG5WNidkQ8WmUEw9d1qtaz6qwH20P5q
   w==;
IronPort-SDR: 0VetXvcrUV41McEMiWQMcf7xVxMhP2Ra7q2/gLUIBHpVLCMyFO0REfzA/PJ7q7ANr8i9hub9Rx
 O2uMLBNbUv2kUW9uU0TD+M5DhaDcGqWI2thvM6a/LYPeazrFWirq6kiWTWlkhM7STOAvoaAfEb
 oZtLZ0IaQ5A+oVS1h6HolHliUdsvIEFrP4pkI2TRbsu9SKki3vqdMdFrSxcT+xUoFsX+/ibluZ
 HEvil8SYzFytA/MZ21hLGGOejXviN//1EOY2NmX43AoVLOF5+NBP22Uu5hGWNHYoMKytGANwzH
 x0E=
X-IronPort-AV: E=Sophos;i="5.64,407,1559491200"; 
   d="scan'208";a="117136292"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2019 12:53:13 +0800
IronPort-SDR: 5YbtxIAPwLfyqVC1vxYoN0sRQUyIlnUtV8r5y3MsXv+mElcePhw13XXZ7uuFB3ox2aCeuRcogi
 6zcSI6J89rgg0Gu9yID4ZhsDF14W41IWWMSTeEw1ajHc0027PkoJeF6ou6m+TXT6AOhdVKsN9f
 K+Ty4yUWnX4OsSqvWmiJuOSGLZZRZuxtGNIgWEZedH5GzPoI/TCjCWtv0eIc+J/UAyqn7hIBjM
 5hbFJhEgKMfGjTRb+hq3jpGA8exTqQcIPhmoeJR4tJU3e8JBCsf+565sHc5BPJp3C+wVzGNnQT
 X11qos447oXTE2+4Na3x8+fY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 21:50:37 -0700
IronPort-SDR: GJC69ZjcVhr/cWtvXF/DWaeCUovbRHyrC65vKt1UxSg+9WiuUwN0gRGbzxvnaGh5mTgc807SHO
 XOJ2JQGusuA3Sa6VcLOVQt2c6Pt2dijgjJypGkuslR+ZFDmX8iCRicGURUAc0I+mV249q4V46e
 i3sw7+nBL6jmrYyqQTF/CEGWw69NZ312f8819EkFCzcCepv+1LLlg5jFpaQUPvXybnQh5mDwWE
 WKD/M7BO++zpaX5d8HCiJCJ0A7ImeFtqH2CNZ9cUfKo7RRCSNuGblta+z+98yhgTiKu6XE7KbB
 YS8=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 19 Aug 2019 21:53:10 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 05/15] btrfs-progs: Introduce zone block device helper functions
Date:   Tue, 20 Aug 2019 13:52:48 +0900
Message-Id: <20190820045258.1571640-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190820045258.1571640-1-naohiro.aota@wdc.com>
References: <20190820045258.1571640-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch introduce several zone related functions: btrfs_get_zone_info()
to get zone information from the specified device and put the information
in zinfo, and zone_is_sequential() to check if a zone is a sequential
required zone.

btrfs_get_zone_info() is intentionaly works with "struct btrfs_zone_info"
instead of "struct btrfs_device". We need to load zone information at
btrfs_prepare_device(), but there are no "struct btrfs_device" at that
time.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 Makefile         |   2 +-
 common/hmzoned.c | 218 +++++++++++++++++++++++++++++++++++++++++++++++
 common/hmzoned.h |  67 +++++++++++++++
 3 files changed, 286 insertions(+), 1 deletion(-)
 create mode 100644 common/hmzoned.c
 create mode 100644 common/hmzoned.h

diff --git a/Makefile b/Makefile
index 82417d19a9f8..60a9e8992864 100644
--- a/Makefile
+++ b/Makefile
@@ -140,7 +140,7 @@ objects = ctree.o disk-io.o kernel-lib/radix-tree.o extent-tree.o print-tree.o \
 	  inode.o file.o find-root.o free-space-tree.o common/help.o send-dump.o \
 	  common/fsfeatures.o kernel-lib/tables.o kernel-lib/raid56.o transaction.o \
 	  delayed-ref.o common/format-output.o common/path-utils.o \
-	  common/device-utils.o common/device-scan.o
+	  common/device-utils.o common/device-scan.o common/hmzoned.o
 cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
 	       cmds/inspect.o cmds/balance.o cmds/send.o cmds/receive.o \
 	       cmds/quota.o cmds/qgroup.o cmds/replace.o check/main.o \
diff --git a/common/hmzoned.c b/common/hmzoned.c
new file mode 100644
index 000000000000..7114943458ef
--- /dev/null
+++ b/common/hmzoned.c
@@ -0,0 +1,218 @@
+/*
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ * Authors:
+ *      Naohiro Aota    <naohiro.aota@wdc.com>
+ *      Damien Le Moal  <damien.lemoal@wdc.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#include <sys/ioctl.h>
+
+#include "common/utils.h"
+#include "common/device-utils.h"
+#include "common/messages.h"
+#include "mkfs/common.h"
+#include "common/hmzoned.h"
+
+#define BTRFS_REPORT_NR_ZONES	8192
+
+enum btrfs_zoned_model zoned_model(const char *file)
+{
+	char model[32];
+	int ret;
+
+	ret = queue_param(file, "zoned", model, sizeof(model));
+	if (ret <= 0)
+		return ZONED_NONE;
+
+	if (strncmp(model, "host-aware", 10) == 0)
+		return ZONED_HOST_AWARE;
+	if (strncmp(model, "host-managed", 12) == 0)
+		return ZONED_HOST_MANAGED;
+
+	return ZONED_NONE;
+}
+
+size_t zone_size(const char *file)
+{
+	char chunk[32];
+	int ret;
+
+	ret = queue_param(file, "chunk_sectors", chunk, sizeof(chunk));
+	if (ret <= 0)
+		return 0;
+
+	return strtoul((const char *)chunk, NULL, 10) << 9;
+}
+
+#ifdef BTRFS_ZONED
+bool zone_is_sequential(struct btrfs_zone_info *zinfo, u64 bytenr)
+{
+	unsigned int zno;
+
+	if (zinfo->model == ZONED_NONE)
+		return false;
+
+	zno = bytenr / zinfo->zone_size;
+
+	/*
+	 * Only sequential write required zones on host-managed
+	 * devices cannot be written randomly.
+	 */
+	return zinfo->zones[zno].type == BLK_ZONE_TYPE_SEQWRITE_REQ;
+}
+
+static int report_zones(int fd, const char *file, u64 block_count,
+			struct btrfs_zone_info *zinfo)
+{
+	size_t zone_bytes = zone_size(file);
+	size_t rep_size;
+	u64 sector = 0;
+	struct blk_zone_report *rep;
+	struct blk_zone *zone;
+	unsigned int i, n = 0;
+	int ret;
+
+	/*
+	 * Zones are guaranteed (by the kernel) to be a power of 2 number of
+	 * sectors. Check this here and make sure that zones are not too
+	 * small.
+	 */
+	if (!zone_bytes || !is_power_of_2(zone_bytes)) {
+		error("Illegal zone size %zu (not a power of 2)", zone_bytes);
+		exit(1);
+	}
+	if (zone_bytes < BTRFS_MKFS_SYSTEM_GROUP_SIZE) {
+		error("Illegal zone size %zu (smaller than %d)", zone_bytes,
+		      BTRFS_MKFS_SYSTEM_GROUP_SIZE);
+		exit(1);
+	}
+
+	/* Allocate the zone information array */
+	zinfo->zone_size = zone_bytes;
+	zinfo->nr_zones = block_count / zone_bytes;
+	if (block_count & (zone_bytes - 1))
+		zinfo->nr_zones++;
+	zinfo->zones = calloc(zinfo->nr_zones, sizeof(struct blk_zone));
+	if (!zinfo->zones) {
+		error("No memory for zone information");
+		exit(1);
+	}
+
+	/* Allocate a zone report */
+	rep_size = sizeof(struct blk_zone_report) +
+		sizeof(struct blk_zone) * BTRFS_REPORT_NR_ZONES;
+	rep = malloc(rep_size);
+	if (!rep) {
+		error("No memory for zones report");
+		exit(1);
+	}
+
+	/* Get zone information */
+	zone = (struct blk_zone *)(rep + 1);
+	while (n < zinfo->nr_zones) {
+		memset(rep, 0, rep_size);
+		rep->sector = sector;
+		rep->nr_zones = BTRFS_REPORT_NR_ZONES;
+
+		ret = ioctl(fd, BLKREPORTZONE, rep);
+		if (ret != 0) {
+			error("ioctl BLKREPORTZONE failed (%s)",
+			      strerror(errno));
+			exit(1);
+		}
+
+		if (!rep->nr_zones)
+			break;
+
+		for (i = 0; i < rep->nr_zones; i++) {
+			if (n >= zinfo->nr_zones)
+				break;
+			memcpy(&zinfo->zones[n], &zone[i],
+			       sizeof(struct blk_zone));
+			n++;
+		}
+
+		sector = zone[rep->nr_zones - 1].start +
+			zone[rep->nr_zones - 1].len;
+	}
+
+	/*
+	 * We need at least one random write zone (a conventional zone or
+	 * a sequential write preferred zone on a host-aware device).
+	 */
+	if (zone_is_sequential(zinfo, 0)) {
+		error("No conventional zone at block 0");
+		exit(1);
+	}
+
+	free(rep);
+
+	return 0;
+}
+
+#endif
+
+int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
+			struct btrfs_zone_info *zinfo)
+{
+	struct stat st;
+	int ret;
+
+	memset(zinfo, 0, sizeof(struct btrfs_zone_info));
+
+	ret = fstat(fd, &st);
+	if (ret < 0) {
+		error("unable to stat %s", file);
+		return 1;
+	}
+
+	if (!S_ISBLK(st.st_mode))
+		return 0;
+
+	/* Check zone model */
+	zinfo->model = zoned_model(file);
+	if (zinfo->model == ZONED_NONE)
+		return 0;
+
+	if (zinfo->model == ZONED_HOST_MANAGED && !hmzoned) {
+		error(
+"%s: host-managed zoned block device (enable zone block device support with -O hmzoned)",
+		      file);
+		return 1;
+	}
+
+	if (!hmzoned) {
+		/* Treat host-aware devices as regular devices */
+		zinfo->model = ZONED_NONE;
+		return 0;
+	}
+
+#ifdef BTRFS_ZONED
+	/* Get zone information */
+	ret = report_zones(fd, file, btrfs_device_size(fd, &st), zinfo);
+	if (ret != 0)
+		return ret;
+#else
+	error("%s: Unsupported host-%s zoned block device", file,
+	      zinfo->model == ZONED_HOST_MANAGED ? "managed" : "aware");
+	if (zinfo->model == ZONED_HOST_MANAGED)
+		return 1;
+
+	error("%s: handling host-aware block device as a regular disk", file);
+#endif
+	return 0;
+}
diff --git a/common/hmzoned.h b/common/hmzoned.h
new file mode 100644
index 000000000000..fbcaaf2da20e
--- /dev/null
+++ b/common/hmzoned.h
@@ -0,0 +1,67 @@
+/*
+ * Copyright (C) 2019 Western Digital Corporation or its affiliates.
+ * Authors:
+ *      Naohiro Aota    <naohiro.aota@wdc.com>
+ *      Damien Le Moal  <damien.lemoal@wdc.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public
+ * License v2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public
+ * License along with this program; if not, write to the
+ * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
+ * Boston, MA 021110-1307, USA.
+ */
+
+#ifndef __BTRFS_HMZONED_H__
+#define __BTRFS_HMZONED_H__
+
+#ifdef BTRFS_ZONED
+#include <linux/blkzoned.h>
+#else
+struct blk_zone {
+	int dummy;
+};
+#endif /* BTRFS_ZONED */
+
+/*
+ * Zoned block device models.
+ */
+enum btrfs_zoned_model {
+	ZONED_NONE = 0,
+	ZONED_HOST_AWARE,
+	ZONED_HOST_MANAGED,
+};
+
+/*
+ * Zone information for a zoned block device.
+ */
+struct btrfs_zone_info {
+	enum btrfs_zoned_model	model;
+	size_t			zone_size;
+	struct blk_zone	*zones;
+	unsigned int		nr_zones;
+};
+
+enum btrfs_zoned_model zoned_model(const char *file);
+size_t zone_size(const char *file);
+int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
+			struct btrfs_zone_info *zinfo);
+
+#ifdef BTRFS_ZONED
+bool zone_is_sequential(struct btrfs_zone_info *zinfo, u64 bytenr);
+#else
+static inline bool zone_is_sequential(struct btrfs_zone_info *zinfo,
+				      u64 bytenr)
+{
+	return true;
+}
+#endif /* BTRFS_ZONED */
+
+#endif /* __BTRFS_HMZONED_H__ */
-- 
2.23.0

