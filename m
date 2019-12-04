Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D91711124D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfLDI1k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:40 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfLDI1j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448082; x=1606984082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=shwU0eOErzELxY3Vssd0HO8E4D5mNPTri6RDogBiwyM=;
  b=Dx9sAF+Eldi7E/YvnRaY0eatJDfvCUWipZhcr+JqzZmBoNpcfvMMneHt
   hlvT16XpMhgXVsjp/fV90cwtzyxQEtISXfBT7i/3niC0tUJsZFLwV8AQt
   6YhLMl/Fnm0WjJ+360Z+eNa25YCVJZBhMAVq9SXFgjyr92gMGLGu7DUZ4
   kT2k/Lqgf4p3DNUEncp29XKpnxDiNyCksiAagAz6R0iHQonZYInBeGiCv
   pkJVw2tXs2tafa5RBbdiuMS/eb5DoIlBR51QoOhdY5w+WdNevSopAG/Xe
   6jM7QnRolp2OQ3+a8eISIesWurrULH8ZoE7BH5t+ehUflPZM33FrPHreX
   A==;
IronPort-SDR: Edg1iI0vvvvbyOMCWTGOn7ux711gI76HXICvSdaE/ROzSR8/rkeecxJUL+YOOlbtnVk1FoFj7t
 4SvrInpACHKSrP0qat/OzCjTOvi1T7p5QPn68pQDjgzGaBew0elkNzSjo7GkdW6qMvAGY2S85Q
 FjnV4VQdEC8SndQ2dXJNjmSGfPFcjgMiM2YLMOSmL8w8ndDzbebjpb4AdzV0PdE7OLm7yniAFL
 tMV0F/NptFlT95ytURlHy8GIq6MJBlIIOjAFkQMv2w5WgJXGoE/cOLJBz0Y5tMlhdz1trCyPY5
 Zq4=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031737"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:28:02 +0800
IronPort-SDR: R6Msb7wrLhxR7hIFJiRRwhm8ug58oXc2BpjOG7f4BNuo4k08E2SQyIrBrAdnInJ3oeCHJt/7fl
 YxLwUY8/NmPz+SKYX4KyIgNuw2fKAEXF+1VcNU/sm2cIDj2KxkFA60HusOdg56n3phJsDE0ba5
 kUCu3fWtLiQtJ8i7QElvMiJlq2N82Z23sFrW9MsA068N8p57e45SmrY5gBys4rR7/Lty7xEonx
 EzzSSwKBuGzNx+czTx1BbKPem4UR3nd4LYh3M9k2a3N4Go1/d4ekXq6Rx/S93WNr4ViSWOdLjr
 Qelp4hgW/mf4IqkbARMB8ev2
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:26 -0800
IronPort-SDR: h8Y/MQISQCkfMnut+57IK01GBFSRJE3MbxHAsrhLIfD0W3HGw+WK/XGi9OpSzOwcUmhZHEiazx
 l/v+KO8ogu9cne/GtVhSVsdAC0lsSCb3qi4PGlFSYB+FGJegByKcUHxXV82Jmof8zSsGq/Yiz/
 PIeiMpPx9UnT3K2ljZBdVxRPVKJYHQXx8c5rbg2jp50OxcO2BQKcHtxq2mB14RR/XnPBKCoaZ8
 eWni/MDZa7ghTYpRu+/FIRE+XLBQw1p2z5JY5/ejPbo7mW2ONmRUwCNWoDDDEKAcxS8vS6GMXH
 SUU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:38 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 05/15] btrfs-progs: Introduce zone block device helper functions
Date:   Wed,  4 Dec 2019 17:25:03 +0900
Message-Id: <20191204082513.857320-6-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
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
 Makefile         |   3 +-
 common/hmzoned.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++
 common/hmzoned.h |  63 ++++++++++++++
 3 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 common/hmzoned.c
 create mode 100644 common/hmzoned.h

diff --git a/Makefile b/Makefile
index b00eafe44a8d..a67bf7ce7833 100644
--- a/Makefile
+++ b/Makefile
@@ -146,7 +146,8 @@ objects = dir-item.o inode-map.o \
 	  inode.o file.o find-root.o common/help.o send-dump.o \
 	  common/fsfeatures.o \
 	  common/format-output.o \
-	  common/device-utils.o
+	  common/device-utils.o \
+	  common/hmzoned.o
 cmds_objects = cmds/subvolume.o cmds/filesystem.o cmds/device.o cmds/scrub.o \
 	       cmds/inspect.o cmds/balance.o cmds/send.o cmds/receive.o \
 	       cmds/quota.o cmds/qgroup.o cmds/replace.o check/main.o \
diff --git a/common/hmzoned.c b/common/hmzoned.c
new file mode 100644
index 000000000000..e11e56210709
--- /dev/null
+++ b/common/hmzoned.c
@@ -0,0 +1,219 @@
+// SPDX-License-Identifier: GPL-2.0
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
+bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo, u64 bytenr)
+{
+	unsigned int zno;
+
+	if (!zinfo || zinfo->model == ZONED_NONE)
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
+			struct btrfs_zoned_device_info *zinfo)
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
+	free(rep);
+
+	return 0;
+}
+
+#endif
+
+int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
+			struct btrfs_zoned_device_info **zinfo_ret)
+{
+#ifdef BTRFS_ZONED
+	struct btrfs_zoned_device_info *zinfo;
+#endif
+	struct stat st;
+	enum btrfs_zoned_model model;
+	int ret;
+
+	*zinfo_ret = NULL;
+
+	ret = fstat(fd, &st);
+	if (ret < 0) {
+		error("unable to stat %s", file);
+		return -ENOENT;
+	}
+
+	if (!S_ISBLK(st.st_mode))
+		return 0;
+
+	/* Check zone model */
+	model = zoned_model(file);
+	if (model == ZONED_NONE)
+		return 0;
+
+	if (model == ZONED_HOST_MANAGED && !hmzoned) {
+		error(
+"%s: host-managed zoned block device (enable zone block device support with -O hmzoned)",
+		      file);
+		return -EIO;
+	}
+
+	/* Treat host-aware devices as regular devices */
+	if (!hmzoned)
+		return 0;
+
+#ifdef BTRFS_ZONED
+	zinfo = malloc(sizeof(*zinfo));
+	if (!zinfo) {
+		error("No memory for zone information");
+		exit(1);
+	}
+
+	memset(zinfo, 0, sizeof(struct btrfs_zoned_device_info));
+	zinfo->model = model;
+
+	/* Get zone information */
+	ret = report_zones(fd, file, btrfs_device_size(fd, &st), zinfo);
+	if (ret != 0) {
+		kfree(zinfo);
+		return ret;
+	}
+	*zinfo_ret = zinfo;
+#else
+	error("%s: Unsupported host-%s zoned block device", file,
+	      model == ZONED_HOST_MANAGED ? "managed" : "aware");
+	if (model == ZONED_HOST_MANAGED)
+		return -EOPNOTSUPP;
+
+	error("%s: handling host-aware block device as a regular disk", file);
+#endif
+	return 0;
+}
diff --git a/common/hmzoned.h b/common/hmzoned.h
new file mode 100644
index 000000000000..098952061bfb
--- /dev/null
+++ b/common/hmzoned.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
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
+struct btrfs_zoned_device_info {
+	enum btrfs_zoned_model	model;
+	u64			zone_size;
+	u32			nr_zones;
+	struct blk_zone	*zones;
+};
+
+enum btrfs_zoned_model zoned_model(const char *file);
+size_t zone_size(const char *file);
+int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
+			struct btrfs_zoned_device_info **zinfo);
+
+#ifdef BTRFS_ZONED
+bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo, u64 bytenr);
+#else
+static inline bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo,
+				      u64 bytenr)
+{
+	return true;
+}
+#endif /* BTRFS_ZONED */
+
+#endif /* __BTRFS_HMZONED_H__ */
-- 
2.24.0

