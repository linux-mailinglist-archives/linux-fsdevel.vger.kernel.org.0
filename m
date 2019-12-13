Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84BFB11DD08
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbfLMEQS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:16:18 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25895 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfLMEQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210578; x=1607746578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8Lp5dCgUSk7AwNm6cXZeMqUWWTjDfu0w6Dau/EL4VQQ=;
  b=Co8qsP4GX0cZL7iz9mWTuZlBVzxR0oETXx3qg7vbWoTDm6IoPtmxeog3
   FsG4YJ4wzNTOVTEXfqDtanNHEtspa+NYkdOzGq6okYxhe3PUtCMOMTZ6u
   252l+smjLhlnygITI3x3CclIDVJZOBHjIPksfBPu+6zCmVq00x76Ozwyj
   8t6mcpn2t4M0r/E/1NiaqPebLG+9zegdZmwof6zOHKMvMfydEwNl3jUOj
   0EYVl1O/PMQaUyv6jcbX+iM/0twmcNAHJOu4SEJx+smtlLDmhqbaKoRFh
   4Zxc20qTIOoWjEk0N29DVF77DWfPMw2uJLV28KKS94E8/0iFwX4C0U59U
   w==;
IronPort-SDR: Pg3kk6DopBem4/8aBVxDYG8ts9IBM7aDfP/qChlSIkLymNJRa45lEUN+x10NeA1AFXoT7/mzQG
 lyXPi4FP7ODJzXvs00ABbw8XBwpuYDSoOcGVfqtymdwOxtgZEb3xJr22hcRER+Mqbzy5qDcNJ7
 2XyxE64t3ypekZWNaUhhkpZAZVrmHQ1R79VG6lpc2bW/qs+kDBu2+t86cDlHakXF4a0OfGDObZ
 xjjiSUR2DH+OfkM6ckxqmh4dNxQcodhygpKO+9Vnu4DvpKxjXu4xYQpV2L9cc1FDcwv1wJKpnY
 cfo=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126021089"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:16:17 +0800
IronPort-SDR: nTzjt+sM7JxNrNqjUnb67kqfGZZYDPDG6LKqx5dnaMUitCAG6uZ3CMDghqqHgfJ102MQMMMzbs
 SuprVgoAe5Jc3CFHM0vTSfhV6YRrtNK6ZEBIFjWTYKhv7jVMCQ96YtiJMTcVQZy3yhTS27StNc
 KkGVDQtgpAhl0oQIYs7fh2analmCIVEvT/W/s03EICZ9nRTUr7V/Np97o6JaSLKN8sDq7WKlSO
 UYu68AxoXCp2Du3cBvKF5InpPjcPtBBb+tq518ds2Kr4UTkvCnqZLhEScndah7gVHhhdyA40T+
 KgzoCYY76Xuh4xM68N1OJZD1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:10:49 -0800
IronPort-SDR: /oSRuKqcInu4zckFjtt+jGyghXUPCVRvYSjdbKNqV/2GAau2Kr8v0MPoEFm9VY6t6c18FkvDtb
 EZaNGuUjmdJP/Avi8m1g8qSCHq0GaEWMBxqVjeuLYulXbsprjQtpwT4G0Ywl0cyGh5o5d6t3LG
 ugOp+soz61HfQUnhfzEPa5hVYt2QoNUC3khg2yTwEtHNOue3z7Gu5+qWH7n5/8tU33hbfAsdwW
 VQIWLxZ9ezOfacQjEAWKNGdwRCqhHZbo83aENaycJeoQZiteLkH1/+Q6nql8C3XrtYCUlBrm95
 /y8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2019 20:16:15 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        kzak@redhat.com
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH RFC v2] libblkid: implement zone-aware probing for HMZONED btrfs
Date:   Fri, 13 Dec 2019 13:15:40 +0900
Message-Id: <20191213041540.3509855-1-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a work-in-progress and proof-of-concept patch to make libblkid
zone-aware. It can probe the magic located at some offset from the
beginning of some specific zone of a device.

This patch will be split in two patches in the future:
- patch to introduce zone aware probing
- patch to user it in btrfs probing

The first part introduces some new fields to struct blkid_idmag. They
indicate the magic location which is placed related to a zone.

Also, the first part introduces `zone_size` to struct
blkid_struct_probe. It stores the size of zones of a device.

The second part use the introduced fields to probe the magic of HMZONED
btrfs. Then, it uses the write pointer position to detect the location
of the last written superblock.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 libblkid/src/blkidP.h            |   5 ++
 libblkid/src/probe.c             |  20 ++++-
 libblkid/src/superblocks/btrfs.c | 129 ++++++++++++++++++++++++++++++-
 3 files changed, 151 insertions(+), 3 deletions(-)

diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
index f9bbe008406f..9cd09520ee32 100644
--- a/libblkid/src/blkidP.h
+++ b/libblkid/src/blkidP.h
@@ -148,6 +148,10 @@ struct blkid_idmag
 
 	long		kboff;		/* kilobyte offset of superblock */
 	unsigned int	sboff;		/* byte offset within superblock */
+
+	int		is_zone;	/* indicate magic location is calcluated based on zone position  */
+	long		zonenum;	/* zone number which has superblock */
+	long		kboff_inzone;	/* kilobyte offset of superblock in a zone */
 };
 
 /*
@@ -195,6 +199,7 @@ struct blkid_struct_probe
 	dev_t			disk_devno;	/* devno of the whole-disk or 0 */
 	unsigned int		blkssz;		/* sector size (BLKSSZGET ioctl) */
 	mode_t			mode;		/* struct stat.sb_mode */
+	uint64_t		zone_size;	/* zone size (BLKGETZONESZ ioctl) */
 
 	int			flags;		/* private library flags */
 	int			prob_flags;	/* always zeroized by blkid_do_*() */
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index f6dd5573d5dd..52220bf6f0f4 100644
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
@@ -861,6 +862,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 	struct stat sb;
 	uint64_t devsiz = 0;
 	char *dm_uuid = NULL;
+	uint32_t zone_size_sector;
 
 	blkid_reset_probe(pr);
 	blkid_probe_reset_buffers(pr);
@@ -887,6 +889,7 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 	pr->wipe_off = 0;
 	pr->wipe_size = 0;
 	pr->wipe_chain = NULL;
+	pr->zone_size = 0;
 
 	if (fd < 0)
 		return 1;
@@ -951,6 +954,9 @@ int blkid_probe_set_device(blkid_probe pr, int fd,
 #endif
 	free(dm_uuid);
 
+	if (S_ISBLK(sb.st_mode) && !ioctl(pr->fd, BLKGETZONESZ, &zone_size_sector))
+		pr->zone_size = zone_size_sector << 9;
+
 	DBG(LOWPROBE, ul_debug("ready for low-probing, offset=%"PRIu64", size=%"PRIu64"",
 				pr->off, pr->size));
 	DBG(LOWPROBE, ul_debug("whole-disk: %s, regfile: %s",
@@ -1009,8 +1015,16 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 	/* try to detect by magic string */
 	while(mag && mag->magic) {
 		unsigned char *buf;
+		uint64_t kboff;
+
+		if (!mag->is_zone)
+			kboff = mag->kboff;
+		else if (pr->zone_size)
+			kboff = ((mag->zonenum * pr->zone_size) >> 10) + mag->kboff_inzone;
+		else
+			goto next;
 
-		off = (mag->kboff + (mag->sboff >> 10)) << 10;
+		off = (kboff + (mag->sboff >> 10)) << 10;
 		buf = blkid_probe_get_buffer(pr, off, 1024);
 
 		if (!buf && errno)
@@ -1020,13 +1034,15 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
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
+
+next:
 		mag++;
 	}
 
diff --git a/libblkid/src/superblocks/btrfs.c b/libblkid/src/superblocks/btrfs.c
index f0fde700d896..10bdf841b6c4 100644
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
 
@@ -59,11 +62,128 @@ struct btrfs_super_block {
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
+	if (pr->zone_size != 0) {
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
 
@@ -88,6 +208,13 @@ const struct blkid_idinfo btrfs_idinfo =
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
2.24.1

