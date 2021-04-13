Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD8EC35E8DC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 00:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348612AbhDMWLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 18:11:46 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:61121 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348606AbhDMWLo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618351884; x=1649887884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hyNh92FJwTcN5aIA5q6FBjo9XhWtYtRSocxvel7oIGw=;
  b=kZkgW42AVbvRIadmIPt0T/KfzgohBQ5HLTT5x46oGcp1ctlsUseb1svZ
   dqrTHaiwdqxIaMurliIqmAypRW7MNcHdMjYAzO2AVQ2x6vcHYHYeu2sgt
   pVBXefDe4dk0m0COfQPZeRXFs6oxPEYOVw9Wy7jFSW91L7IvFsZEdo1WZ
   LrmfATjgHevxXbmPje6Zg/rQOm5OIc+Yw9gDSVs7SllVKdAqO0zaM5CYb
   MG5xHnFJGG5Jkfns4tO8yNxfpH2gRd4Onlgfvzk/IkZb7dl2Ar9TnAY4P
   oyurRoTvdbvrHd4l4RqiMQwCRJy7j966VOV8lDokxq4/k37fY5GRyMohr
   A==;
IronPort-SDR: NqHbA5X8NkwsTo1LnXMhL1jrAWD/Gkwfsbz9kjBKFglkcxbPvrMrKHID4Y5CqxFMpBkjzXluHR
 GYtnz/T1+klbX/GSWb050GDFkYtHRJbtdhmbLAKf5DkDo6255IQFK/JLyDz18P5rWKZ7KfOcvr
 avdpDvCO2rWuTHrJfDSQPfo0zawVi0jA+F8pF227tfl4M19uTt8EKkPQPcyQ0JP5tEExnBubp8
 yplyfmlq8zt3VtBy2EbXbT1vGnP/dgoKwB8Rj3PyQHllkxDE3mfmJTmMRkoj9J+51HvpQx4joW
 teQ=
X-IronPort-AV: E=Sophos;i="5.82,220,1613404800"; 
   d="scan'208";a="164254961"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 06:11:05 +0800
IronPort-SDR: VRIi9vUNPdXo1h6Zl6+3fHQdYGA7DNgOF97UhIdVH6wNMYjU6BvjIIgAlvjpMD9wc1ljh/Nz+n
 Y9vNP4sK24WAjrLh+5sh/Axdt+gYGrJQJvzL9iWS7/0q7KUAow87K+22tcnOZxpuqbqhTAJ+19
 5q428jgXoLy33XOHZQR1xq8YuxNr7mWIsy1e7dxNiqF3HI/8GywkkVypFhpCMnoDBuAQEp85QL
 6yOkUggz8kSJYFAHIY8elhmKUV+qIXT5oLho2vyh8XxaunyT03NjdZnafv/UlEgKVtHHsFy2r5
 Vb3davD8Sm2KRfc2HSmL9dkO
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 14:52:02 -0700
IronPort-SDR: qbzNBobj0RVXkg61fKOBDz3CU+zXJNsdqzbp5KzwPqMwlqgJLaK65uNR0uaCSVtpS0wE5iljFq
 +49IWlwwTSu0zAF0N8vtYPiPfyzJ2GnOIyZJC1u0BG46kVKP8q6qJGF5J+nVtAWFlM/DR/JbMZ
 gD6BIoI8Zh/Q++NX8Jmsu+mreEjWOCYKiQ7vaWTRR/5q1Yw74rnwYGPi2E7Aq6yqWcp2/YEBsi
 XBrs7ogFqyGutGeRzaqBADlAuo7NNezkcA7DqvaDDM9osDrLljaql4z21BypVFSuj1LY8hoy7M
 LgY=
WDCIronportException: Internal
Received: from 39xlxy2.ad.shared (HELO naota-xeon.wdc.com) ([10.225.53.108])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Apr 2021 15:10:58 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/3] blkid: add magic and probing for zoned btrfs
Date:   Wed, 14 Apr 2021 07:10:50 +0900
Message-Id: <20210413221051.2600455-3-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210413221051.2600455-1-naohiro.aota@wdc.com>
References: <20210413221051.2600455-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This commit adds zone-aware magics and probing functions for zoned btrfs.

Superblock (and its copies) is the only data structure in btrfs with a
fixed location on a device. Since we cannot overwrite in a sequential write
required zone, we cannot place superblock in the zone.

Thus, zoned btrfs use superblock log writing to update superblock on
sequential write required zones. It uses two zones as a circular buffer to
write updated superblocks. Once the first zone is filled up, start writing
into the second buffer. When both zones are filled up and before start
writing to the first zone again, it reset the first zone.

We can determine the position of the latest superblock by reading write
pointer information from a device. One corner case is when both zones are
full. For this situation, we read out the last superblock of each zone and
compare them to determine which zone is older.

The magics can detect a superblock magic ("_BHRfs_M") at the beginning of
zone #0 or zone #1 to see if it is zoned btrfs. When both zones are filled
up, zoned btrfs reset the first zone to write a new superblock. If btrfs
crash at the moment, we do not see a superblock at zone #0. Thus, we need
to check not only zone #0 but also zone #1.

It also supports temporary magic ("!BHRfS_M") in zone #0. The mkfs.btrfs
first writes the temporary superblock to the zone during the mkfs process.
It will survive there until the zones are filled up and reset. So, we also
need to detect this temporary magic.

Finally, this commit extends probe_btrfs() to load the latest superblock
determined by the write pointers.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 libblkid/src/superblocks/btrfs.c | 178 ++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 1 deletion(-)

diff --git a/libblkid/src/superblocks/btrfs.c b/libblkid/src/superblocks/btrfs.c
index f0fde700d896..bce4055054fb 100644
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
 
@@ -59,11 +65,169 @@ struct btrfs_super_block {
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
+#define ASSERT(x) assert(x)
+
+typedef uint64_t u64;
+typedef uint64_t sector_t;
+typedef uint8_t u8;
+
+static int sb_write_pointer(int fd, struct blk_zone *zones, u64 *wp_ret)
+{
+	bool empty[BTRFS_NR_SB_LOG_ZONES];
+	bool full[BTRFS_NR_SB_LOG_ZONES];
+	sector_t sector;
+
+	ASSERT(zones[0].type != BLK_ZONE_TYPE_CONVENTIONAL &&
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
+		u8 buf[BTRFS_NR_SB_LOG_ZONES][BTRFS_SUPER_INFO_SIZE];
+		struct btrfs_super_block *super[BTRFS_NR_SB_LOG_ZONES];
+		int i;
+		int ret;
+
+		for (i = 0; i < BTRFS_NR_SB_LOG_ZONES; i++) {
+			u64 bytenr;
+
+			bytenr = ((zones[i].start + zones[i].len)
+				   << SECTOR_SHIFT) - BTRFS_SUPER_INFO_SIZE;
+
+			ret = pread64(fd, buf[i], BTRFS_SUPER_INFO_SIZE,
+				      bytenr);
+			if (ret != BTRFS_SUPER_INFO_SIZE)
+				return -EIO;
+			super[i] = (struct btrfs_super_block *)&buf[i];
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
+	size_t rep_size;
+	int ret;
+	uint64_t wp;
+
+	zone_size_sector = pr->zone_size >> SECTOR_SHIFT;
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
+	if (ret) {
+		ret = -errno;
+		goto out;
+	}
+	if (rep->nr_zones != 2) {
+		ret = 1;
+		goto out;
+	}
+
+	zones = (struct blk_zone *)(rep + 1);
+
+	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
+		ret = 0;
+		goto out;
+	} else if (zones[1].type == BLK_ZONE_TYPE_CONVENTIONAL) {
+		*bytenr_ret = zones[1].start << SECTOR_SHIFT;
+		ret = 0;
+		goto out;
+	}
+
+	ret = sb_write_pointer(pr->fd, zones, &wp);
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
+
 static int probe_btrfs(blkid_probe pr, const struct blkid_idmag *mag)
 {
 	struct btrfs_super_block *bfs;
+	int ret;
 
-	bfs = blkid_probe_get_sb(pr, mag, struct btrfs_super_block);
+	if (pr->zone_size) {
+		uint64_t offset = 0;
+
+		ret = sb_log_offset(pr, &offset);
+		if (ret)
+			return ret;
+		bfs = (struct btrfs_super_block *)
+			blkid_probe_get_buffer(pr, offset,
+					       sizeof(struct btrfs_super_block));
+	} else {
+		bfs = blkid_probe_get_sb(pr, mag, struct btrfs_super_block);
+	}
 	if (!bfs)
 		return errno ? -errno : 1;
 
@@ -88,6 +252,18 @@ const struct blkid_idinfo btrfs_idinfo =
 	.magics		=
 	{
 	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40, .kboff = 64 },
+	  /* For zoned btrfs */
+	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40,
+	    .is_zoned = 1, .zonenum = 0, .kboff_inzone = 0 },
+	  { .magic = "_BHRfS_M", .len = 8, .sboff = 0x40,
+	    .is_zoned = 1, .zonenum = 1, .kboff_inzone = 0 },
+	  /*
+	   * For zoned btrfs, we also need to detect a temporary superblock
+	   * at zone #0. Mkfs.btrfs creates it in the initialize process.
+	   * It persits until both zones are filled up then reset.
+	   */
+	  { .magic = "!BHRfS_M", .len = 8, .sboff = 0x40,
+	    .is_zoned = 1, .zonenum = 0, .kboff_inzone = 0 },
 	  { NULL }
 	}
 };
-- 
2.31.1

