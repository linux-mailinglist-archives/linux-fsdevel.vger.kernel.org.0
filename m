Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 814531124FF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfLDIad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:30:33 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59348 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfLDIad (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:30:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448232; x=1606984232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZfdxsNd0/+78y+27cY8xpkjlYT7GUCO6R2s7Fwtjxf8=;
  b=Ek2SetMyUFH4DPGbNuQVhegicAZW6DKWeHvFhz4Xay6Sz7d1PzjgylDb
   SVWCBkIzHaVQ15gFgdIqJaEhS54L4ZYuHfJX5B3NbfLhgRtxRjbjf1YZl
   TuWyZYqtDbjzxHB+pAg9hlOg0Vw7TBazWkRuMuxv8yNjltXN2RTpeGf/4
   bEkLJyK/m0mtU2VR94Jm10l0OUgbgXLU4MZVDVHjpRjUQLIk7AiwbbCYW
   1myh8G6TjzIi+xi+fT/0je227s/XVGhscKVILmcAbaZQhgiVKqtyrET7S
   UeIHykzuFbymc3OOYVV2rkz+CleQc1umCkwLVYWRzKp1TuaxmDglxI8ry
   A==;
IronPort-SDR: 8Tr3XXxoZGakMIuxrPhvCNX0Zt0z5DJpBuYTcxYODBmP5nQmyc3ert4sCOtHAu1K699NS6ac5h
 OLr0QiEvGnI3MUks9FdkrFC9hjxhSt5H6hED9X1gwAh4VhqB+bhMjf7+3pw5RzL4FFZ6LaX2AW
 EBwezX2bxif93WMYctLQNMjLSQX0UAKB0AqIPWmhW1/e7h6Gt/lCLm+IaW8aj9ztDN6YbApRTO
 TkKJrP0ZtjR3LAMMNp2qopg9c90YyYL0XfX99wNWe54FdTYzlSUg1a/aRcpjr6hhkOYXpQWbxx
 LaU=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="124574769"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:30:32 +0800
IronPort-SDR: GgH0wEdn2NBbdnU5wGDgYcw1WfNXwnrDIecRLnUxydjJXym+zx4dAYLTw39KdvcAnREqRf8uwk
 o4y+mN8tNMOqy1VZgaEUyYKluYAmeawFxldX7k+X/TU6AMB6MVK384lhrBkxfYQKcKqHUnhz/t
 mVCJ78WYKbUhV5tsTgXsJxLC7lXYLwnO8W92lpcQdefC9ua5C/4wWqBpPWvGg9Z43KUjnVaKdm
 xv1SQKLnuIUhb50jJvSBoFZ0dBYYI5D+E/06W8YrLeNu7F66Go3PkqskNgWiVSWG5RNGswopKW
 ZLQzsXY+jjch6Cm7n3O8kO9v
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:25:19 -0800
IronPort-SDR: zv68q4ZRJaQuSKa6G7bnEruP0RvtFwQbm9HhvFsn/3D3WobCsMULoEheRiP+6JCZBzPfdNkZ2x
 eI3Pf/U9bBDKCv6pn/EOx5drXjJIqmYklPvgX6OkHFQTSiDHIx218txXBBFrcjmDadoBtblCTG
 4nMcZbuyQ/XF2JaB6sJpHU3+cVYo+aDcdkh0x6Kdn+qJqFSKiQGfBhgjrWO1OtE0cdcfiNrCWs
 3nS8jVPDNEdvPcMnao5QMXpWFugFqjNZABiN7o13jsJ9L2Un7Pey5+wfKnEkaed1EuP43Vvg0X
 W7c=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:30:29 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH] libblkid: implement zone-aware probing for HMZONED btrfs
Date:   Wed,  4 Dec 2019 17:30:23 +0900
Message-Id: <20191204083023.861495-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a proof-of-concept patch to make libblkid zone-aware. It can
probe the magic located at some offset from the beginning of some
specific zone of a device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 libblkid/src/blkidP.h            |   4 +
 libblkid/src/probe.c             |  25 +++++-
 libblkid/src/superblocks/btrfs.c | 132 ++++++++++++++++++++++++++++++-
 3 files changed, 157 insertions(+), 4 deletions(-)

diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
index f9bbe008406f..5bb6771ee9c6 100644
--- a/libblkid/src/blkidP.h
+++ b/libblkid/src/blkidP.h
@@ -148,6 +148,10 @@ struct blkid_idmag
 
 	long		kboff;		/* kilobyte offset of superblock */
 	unsigned int	sboff;		/* byte offset within superblock */
+
+	int		is_zone;
+	long		zonenum;
+	long		kboff_inzone;
 };
 
 /*
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index f6dd5573d5dd..56e42ac28559 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -94,6 +94,7 @@
 #ifdef HAVE_LINUX_CDROM_H
 #include <linux/cdrom.h>
 #endif
+#include <linux/blkzoned.h>
 #ifdef HAVE_SYS_STAT_H
 #include <sys/stat.h>
 #endif
@@ -1009,8 +1010,25 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 	/* try to detect by magic string */
 	while(mag && mag->magic) {
 		unsigned char *buf;
-
-		off = (mag->kboff + (mag->sboff >> 10)) << 10;
+		uint64_t kboff;
+
+		if (!mag->is_zone)
+			kboff = mag->kboff;
+		else {
+			uint32_t zone_size_sector;
+			int ret;
+
+			ret = ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector);
+			if (ret == EOPNOTSUPP)
+				goto next;
+			if (ret)
+				return -errno;
+			if (zone_size_sector == 0)
+				goto next;
+			kboff = (mag->zonenum * (zone_size_sector << 9)) >> 10;
+			kboff += mag->kboff_inzone;
+		}
+		off = (kboff + (mag->sboff >> 10)) << 10;
 		buf = blkid_probe_get_buffer(pr, off, 1024);
 
 		if (!buf && errno)
@@ -1020,13 +1038,14 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 				buf + (mag->sboff & 0x3ff), mag->len)) {
 
 			DBG(LOWPROBE, ul_debug("\tmagic sboff=%u, kboff=%ld",
-				mag->sboff, mag->kboff));
+				mag->sboff, kboff));
 			if (offset)
 				*offset = off + (mag->sboff & 0x3ff);
 			if (res)
 				*res = mag;
 			return BLKID_PROBE_OK;
 		}
+next:
 		mag++;
 	}
 
diff --git a/libblkid/src/superblocks/btrfs.c b/libblkid/src/superblocks/btrfs.c
index f0fde700d896..4254220ef423 100644
--- a/libblkid/src/superblocks/btrfs.c
+++ b/libblkid/src/superblocks/btrfs.c
@@ -9,6 +9,9 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdint.h>
+#include <stdbool.h>
+
+#include <linux/blkzoned.h>
 
 #include "superblocks.h"
 
@@ -59,11 +62,131 @@ struct btrfs_super_block {
 	uint8_t label[256];
 } __attribute__ ((__packed__));
 
+#define BTRFS_SUPER_INFO_SIZE 4096
+#define SECTOR_SHIFT 9
+
+#define READ 0
+#define WRITE 1
+
+typedef uint64_t u64;
+typedef uint64_t sector_t;
+
+static int sb_write_pointer(struct blk_zone *zones, u64 *wp_ret)
+{
+	bool empty[2];
+	bool full[2];
+	sector_t sector;
+
+	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		*wp_ret = zones[0].start << SECTOR_SHIFT;
+		return -ENOENT;
+	}
+
+	empty[0] = zones[0].cond == BLK_ZONE_COND_EMPTY;
+	empty[1] = zones[1].cond == BLK_ZONE_COND_EMPTY;
+	full[0] = zones[0].cond == BLK_ZONE_COND_FULL;
+	full[1] = zones[1].cond == BLK_ZONE_COND_FULL;
+
+	/*
+	 * Possible state of log buffer zones
+	 *
+	 *   E I F
+	 * E * x 0
+	 * I 0 x 0
+	 * F 1 1 x
+	 *
+	 * Row: zones[0]
+	 * Col: zones[1]
+	 * State:
+	 *   E: Empty, I: In-Use, F: Full
+	 * Log position:
+	 *   *: Special case, no superblock is written
+	 *   0: Use write pointer of zones[0]
+	 *   1: Use write pointer of zones[1]
+	 *   x: Invalid state
+	 */
+
+	if (empty[0] && empty[1]) {
+		/* special case to distinguish no superblock to read */
+		*wp_ret = zones[0].start << SECTOR_SHIFT;
+		return -ENOENT;
+	} else if (full[0] && full[1]) {
+		/* cannot determine which zone has the newer superblock */
+		return -EUCLEAN;
+	} else if (!full[0] && (empty[1] || full[1])) {
+		sector = zones[0].wp;
+	} else if (full[0]) {
+		sector = zones[1].wp;
+	} else {
+		return -EUCLEAN;
+	}
+	*wp_ret = sector << SECTOR_SHIFT;
+	return 0;
+}
+
+static int sb_log_offset(uint32_t zone_size_sector, blkid_probe pr,
+			 uint64_t *offset_ret)
+{
+	uint32_t zone_num = 0;
+	struct blk_zone_report *rep;
+	struct blk_zone *zones;
+	size_t rep_size;
+	int ret;
+	uint64_t wp;
+
+	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone) * 2;
+	rep = malloc(rep_size);
+	if (!rep)
+		return -errno;
+
+	memset(rep, 0, rep_size);
+	rep->sector = zone_num * zone_size_sector;
+	rep->nr_zones = 2;
+
+	ret = ioctl(pr->fd, BLKREPORTZONE, rep);
+	if (ret)
+		return -errno;
+	if (rep->nr_zones != 2) {
+		free(rep);
+		return 1;
+	}
+
+	zones = (struct blk_zone *)(rep + 1);
+
+	ret = sb_write_pointer(zones, &wp);
+	if (ret != -ENOENT && ret)
+		return -EIO;
+	if (ret != -ENOENT) {
+		if (wp == zones[0].start << SECTOR_SHIFT)
+			wp = (zones[1].start + zones[1].len) << SECTOR_SHIFT;
+		wp -= BTRFS_SUPER_INFO_SIZE;
+	}
+	*offset_ret = wp;
+
+	return 0;
+}
+
 static int probe_btrfs(blkid_probe pr, const struct blkid_idmag *mag)
 {
 	struct btrfs_super_block *bfs;
+	uint32_t zone_size_sector;
+	int ret;
+
+	ret = ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector);
+	if (ret)
+		return errno;
+	if (zone_size_sector != 0) {
+		uint64_t offset = 0;
 
-	bfs = blkid_probe_get_sb(pr, mag, struct btrfs_super_block);
+		ret = sb_log_offset(zone_size_sector, pr, &offset);
+		if (ret)
+			return ret;
+		bfs = (struct btrfs_super_block*)
+			blkid_probe_get_buffer(pr, offset,
+					       sizeof(struct btrfs_super_block));
+	} else {
+		bfs = blkid_probe_get_sb(pr, mag, struct btrfs_super_block);
+	}
 	if (!bfs)
 		return errno ? -errno : 1;
 
@@ -88,6 +211,13 @@ const struct blkid_idinfo btrfs_idinfo =
 	.magics		=
 	{
 	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40, .kboff = 64 },
+	  /* for HMZONED btrfs */
+	  { .magic = "!BHRfS_M", .len = 8, .sboff = 0x40,
+	    .is_zone = 1, .zonenum = 0, .kboff_inzone = 0 },
+	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40,
+	    .is_zone = 1, .zonenum = 0, .kboff_inzone = 0 },
+	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40,
+	    .is_zone = 1, .zonenum = 1, .kboff_inzone = 0 },
 	  { NULL }
 	}
 };
-- 
2.24.0

