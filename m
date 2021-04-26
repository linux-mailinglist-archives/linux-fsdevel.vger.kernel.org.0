Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E090A36ABE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 07:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbhDZFvs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 01:51:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39184 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhDZFvr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 01:51:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1619416265; x=1650952265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OeG+WPcgiLjU9ScmqANGfIulOZyZikpy94bi8LQszSU=;
  b=bU5Jx19RFMVXkw5aiqkXz+8LoIZ04p2Ba/KI0sR+nIaOuxbRE8S+nNRj
   0XC13qgaiQF2FaNAkKtvfkyii27vLiB5sKOgCka/pKHzOjB2AlZBDEDe3
   fuYbWCa2GOYQ6gLUg91f+b0Go29/pTsX9e2wMp6RpEluv5fqWCzI0eZqd
   YudCMar3X/xwlgWRvPOJkE01LlnwSZuLEK0L5zoYNIkzqSthxcqlRf2eG
   JPSPcsOHy03uWoybqVXp7tns01wJmoiA/Tus+wHLsz6IQ9QveLNlYngE/
   G8zWFdSNdC/9Vs47Hv+6B1xLxif/sP5PmC0BSf7+rv7BEKQWxKdHM2Eho
   w==;
IronPort-SDR: YogGOC4ORyGar6AoEiwzS0W8p7aANwnXWiZ+Iezy5FDEy1VT7NaCyFP8q2JUaZYEuW5OsqCeKz
 uo6GbDF3JlIBtwpdtMX50bG3+ZQ346Hrwi0eNeTlciCl27W+Yx9i6KypmVPFK/z/lUpmcpknfh
 gltczc4onncCsmn1+58o5X+9fpk26Fgn2pMiPkt281WOpsygY/8WGUTDyfc5dMqSVGh2b0XxXj
 dSCPkinHe+VlF6qNjJVT7vpL9q1UQekHetRlQhTP5oPeb1Cf0RUTD9NMRUv7msvY+CyMXRBZ+T
 3Ks=
X-IronPort-AV: E=Sophos;i="5.82,251,1613404800"; 
   d="scan'208";a="170785781"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 26 Apr 2021 13:51:05 +0800
IronPort-SDR: LOMmLgRwRmS6bK4FXzGQimmh5KixnWbnRt/L8MFc2S3e1gRrJIwaQs5f+7UfnOPwhjdOnOeI60
 4Q/Sj2IhD0GPAHdptdxr8ySAgGERqbHsaasztP/CI8T17kOOlgGMaGr5OYA0ACcth3VnfUOVbh
 Gib3dwEBofD6//cT3TpZ0MdtC6u+cWO/aKTa4H3aXt+5zrGhh5Tv7cEgnxPbngPg5QNHy4KBxU
 Rsq+0C7EmXNxFXM3dFbCYQjSsLJQhQzb1gtNbfxEZjI4/XwL5sGRMxeBsHu0/eWxre7cgVpeRJ
 lEKmiAfy+ctnai43CjTBHccj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2021 22:30:02 -0700
IronPort-SDR: 8NBcfvFNgCtzrVyjWfsWd7N1Dq54Rkxnb+vIuSxXqZlFteR1t/lm3RiG8CNwRJCJDugSJdbisg
 /RELxye9+g4wZhYtamId9fWU1kRRbz2Z1/Jf7+Cea2xT6zVm1N3bEC0GAOt/6FLhOYfx6ShtFg
 TjAYx3elZ30zMZUEzpRGN+FaEM73wgqrKgCZobA6iKiDoEQNen60hcOLmJ2r6HH1+QyLM6umh9
 whWiJOfo66kfhHs0W+174UxhDQnV/WTUEj3dQRBZWCfAQVaQK+CfF/o0GGKLTqCcstdZ7k10mT
 HP0=
WDCIronportException: Internal
Received: from bgy2573.ad.shared (HELO naota-xeon.wdc.com) ([10.225.48.58])
  by uls-op-cesaip01.wdc.com with ESMTP; 25 Apr 2021 22:51:06 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 2/3] blkid: add magic and probing for zoned btrfs
Date:   Mon, 26 Apr 2021 14:50:35 +0900
Message-Id: <20210426055036.2103620-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426055036.2103620-1-naohiro.aota@wdc.com>
References: <20210426055036.2103620-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit adds zone-aware magics and probing functions for zoned btrfs.

The superblock (and its copies) are the only data structure in btrfs with a
fixed location on a device. Since we cannot do overwrites in a sequential
write required zone, we cannot place the superblock in the zone.

Thus, zoned btrfs uses superblock log writing to update superblocks on
sequential write required zones. It uses two zones as a circular buffer to
write updated superblocks. Once the first zone is filled up, start writing
into the second buffer. When both zones are filled up, and before starting
to write to the first zone again, it reset the first zone.

We can determine the position of the latest superblock by reading the write
pointer information from a device. One corner case is when both zones are
full. For this situation, we read out the last superblock of each zone and
compare them to determine which zone is older.

The magics can detect a superblock magic ("_BHRfs_M") at the beginning of
zone #0 or zone #1 to see if it is zoned btrfs. When both zones are filled
up, zoned btrfs resets the first zone to write a new superblock. If btrfs
crashes at the moment, we do not see a superblock at zone #0. Thus, we need
to check not only zone #0 but also zone #1.

It also supports the temporary magic ("!BHRfS_M") in zone #0. Mkfs.btrfs
first writes the temporary superblock to the zone during the mkfs process.
It will survive there until the zones are filled up and reset. So, we also
need to detect this temporary magic.

Finally, this commit extends probe_btrfs() to load the latest superblock
determined by the write pointers.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 include/blkdev.h                 |   9 ++
 lib/blkdev.c                     |  29 ++++++
 libblkid/src/superblocks/btrfs.c | 159 ++++++++++++++++++++++++++++++-
 3 files changed, 196 insertions(+), 1 deletion(-)

diff --git a/include/blkdev.h b/include/blkdev.h
index 6cbecbb65f82..43a5f5224857 100644
--- a/include/blkdev.h
+++ b/include/blkdev.h
@@ -15,6 +15,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <sys/stat.h>
+#include <stdint.h>
 
 #ifdef HAVE_SYS_MKDEV_H
 # include <sys/mkdev.h>		/* major and minor on Solaris */
@@ -147,5 +148,13 @@ int blkdev_get_geometry(int fd, unsigned int *h, unsigned int *s);
 const char *blkdev_scsi_type_to_name(int type);
 
 int blkdev_lock(int fd, const char *devname, const char *lockmode);
+#ifdef HAVE_LINUX_BLKZONED_H
+struct blk_zone_report *blkdev_get_zonereport(int fd, uint64_t sector, uint32_t nzones);
+#else
+static inline struct blk_zone_report *blkdev_get_zonereport(int fd, uint64_t sector, uint32_t nzones)
+{
+	return NULL;
+}
+#endif
 
 #endif /* BLKDEV_H */
diff --git a/lib/blkdev.c b/lib/blkdev.c
index c22853ddcbb0..9de8512917a9 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -15,6 +15,10 @@
 #include <linux/fd.h>
 #endif
 
+#ifdef HAVE_LINUX_BLKZONED_H
+#include <linux/blkzoned.h>
+#endif
+
 #ifdef HAVE_SYS_DISKLABEL_H
 #include <sys/disklabel.h>
 #endif
@@ -412,6 +416,31 @@ int blkdev_lock(int fd, const char *devname, const char *lockmode)
 	return rc;
 }
 
+#ifdef HAVE_LINUX_BLKZONED_H
+struct blk_zone_report *blkdev_get_zonereport(int fd, uint64_t sector, uint32_t nzones)
+{
+	struct blk_zone_report *rep;
+	size_t rep_size;
+	int ret;
+
+	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone) * 2;
+	rep = calloc(1, rep_size);
+	if (!rep)
+		return NULL;
+
+	rep->sector = sector;
+	rep->nr_zones = nzones;
+
+	ret = ioctl(fd, BLKREPORTZONE, rep);
+	if (ret || rep->nr_zones != nzones) {
+		free(rep);
+		return NULL;
+	}
+
+	return rep;
+}
+#endif
+
 
 #ifdef TEST_PROGRAM_BLKDEV
 #include <stdio.h>
diff --git a/libblkid/src/superblocks/btrfs.c b/libblkid/src/superblocks/btrfs.c
index f0fde700d896..03aa7e979298 100644
--- a/libblkid/src/superblocks/btrfs.c
+++ b/libblkid/src/superblocks/btrfs.c
@@ -9,6 +9,12 @@
 #include <unistd.h>
 #include <string.h>
 #include <stdint.h>
+#include <stdbool.h>
+#include <assert.h>
+
+#ifdef HAVE_LINUX_BLKZONED_H
+#include <linux/blkzoned.h>
+#endif
 
 #include "superblocks.h"
 
@@ -59,11 +65,157 @@ struct btrfs_super_block {
 	uint8_t label[256];
 } __attribute__ ((__packed__));
 
+#define BTRFS_SUPER_INFO_SIZE 4096
+
+/* Number of superblock log zones */
+#define BTRFS_NR_SB_LOG_ZONES 2
+
+/* Introduce some macros and types to unify the code with kernel side */
+#define SECTOR_SHIFT 9
+
+typedef uint64_t sector_t;
+
+#ifdef HAVE_LINUX_BLKZONED_H
+static int sb_write_pointer(blkid_probe pr, struct blk_zone *zones, uint64_t *wp_ret)
+{
+	bool empty[BTRFS_NR_SB_LOG_ZONES];
+	bool full[BTRFS_NR_SB_LOG_ZONES];
+	sector_t sector;
+
+	assert(zones[0].type != BLK_ZONE_TYPE_CONVENTIONAL &&
+	       zones[1].type != BLK_ZONE_TYPE_CONVENTIONAL);
+
+	empty[0] = zones[0].cond == BLK_ZONE_COND_EMPTY;
+	empty[1] = zones[1].cond == BLK_ZONE_COND_EMPTY;
+	full[0] = zones[0].cond == BLK_ZONE_COND_FULL;
+	full[1] = zones[1].cond == BLK_ZONE_COND_FULL;
+
+	/*
+	 * Possible states of log buffer zones
+	 *
+	 *           Empty[0]  In use[0]  Full[0]
+	 * Empty[1]         *          x        0
+	 * In use[1]        0          x        0
+	 * Full[1]          1          1        C
+	 *
+	 * Log position:
+	 *   *: Special case, no superblock is written
+	 *   0: Use write pointer of zones[0]
+	 *   1: Use write pointer of zones[1]
+	 *   C: Compare super blcoks from zones[0] and zones[1], use the latest
+	 *      one determined by generation
+	 *   x: Invalid state
+	 */
+
+	if (empty[0] && empty[1]) {
+		/* Special case to distinguish no superblock to read */
+		*wp_ret = zones[0].start << SECTOR_SHIFT;
+		return -ENOENT;
+	} else if (full[0] && full[1]) {
+		/* Compare two super blocks */
+		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
+		int i;
+
+		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+			uint64_t bytenr;
+
+			bytenr = ((zones[i].start + zones[i].len)
+				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
+
+			super[i] = (struct btrfs_super_block *)
+				blkid_probe_get_buffer(pr, bytenr, BTRFS_SUPER_INFO_SIZE);
+			if (!super[i])
+				return -EIO;
+		}
+
+		if (super[0]->generation > super[1]->generation)
+			sector = zones[1].start;
+		else
+			sector = zones[0].start;
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
+static int sb_log_offset(blkid_probe pr, uint64_t *bytenr_ret)
+{
+	uint32_t zone_num = 0;
+	uint32_t zone_size_sector;
+	struct blk_zone_report *rep;
+	struct blk_zone *zones;
+	int ret;
+	int i;
+	uint64_t wp;
+
+
+	zone_size_sector = pr->zone_size >> SECTOR_SHIFT;
+	rep = blkdev_get_zonereport(pr->fd, zone_num * zone_size_sector, 2);
+	if (!rep) {
+		ret = -errno;
+		goto out;
+	}
+	zones = (struct blk_zone *)(rep + 1);
+
+	/*
+	 * Use the head of the first conventional zone, if the zones
+	 * contain one.
+	 */
+	for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+		if (zones[i].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+			*bytenr_ret = zones[i].start << SECTOR_SHIFT;
+			ret = 0;
+			goto out;
+		}
+	}
+
+	ret = sb_write_pointer(pr, zones, &wp);
+	if (ret != -ENOENT && ret) {
+		ret = 1;
+		goto out;
+	}
+	if (ret != -ENOENT) {
+		if (wp == zones[0].start << SECTOR_SHIFT)
+			wp = (zones[1].start + zones[1].len) << SECTOR_SHIFT;
+		wp -= BTRFS_SUPER_INFO_SIZE;
+	}
+	*bytenr_ret = wp;
+
+	ret = 0;
+out:
+	free(rep);
+
+	return ret;
+}
+#endif
+
 static int probe_btrfs(blkid_probe pr, const struct blkid_idmag *mag)
 {
 	struct btrfs_super_block *bfs;
 
-	bfs = blkid_probe_get_sb(pr, mag, struct btrfs_super_block);
+	if (pr->zone_size) {
+#ifdef HAVE_LINUX_BLKZONED_H
+		uint64_t offset = 0;
+		int ret;
+
+		ret = sb_log_offset(pr, &offset);
+		if (ret)
+			return ret;
+		bfs = (struct btrfs_super_block *)
+			blkid_probe_get_buffer(pr, offset,
+					       sizeof(struct btrfs_super_block));
+#else
+		/* Nothing can be done */
+		return 1;
+#endif
+	} else {
+		bfs = blkid_probe_get_sb(pr, mag, struct btrfs_super_block);
+	}
 	if (!bfs)
 		return errno ? -errno : 1;
 
@@ -88,6 +240,11 @@ const struct blkid_idinfo btrfs_idinfo =
 	.magics		=
 	{
 	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40, .kboff = 64 },
+	  /* For zoned btrfs */
+	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40,
+	    .is_zoned = 1, .zonenum = 0, .kboff_inzone = 0 },
+	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40,
+	    .is_zoned = 1, .zonenum = 1, .kboff_inzone = 0 },
 	  { NULL }
 	}
 };
-- 
2.31.1

