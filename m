Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 837F31124DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfLDI1u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:27:50 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:1552 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbfLDI1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575448074; x=1606984074;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3NbJiwu7S9fnW557eUzb1z7V57FTzI46lTPoMii6Ks8=;
  b=lmixI8oUvYHZLA8u/mrJBMXhOgKx2/xNQMOtA2lDsPcYx0exMcZba2zc
   IGEhLYd+iVM75oXn4FcUiQa2ypHKHlkTUsnBmnyhChmfymAwS9LP/GxWi
   QQwLjNsg2CRjL6YudNEsxKPgTutNJ+cOnWXSpdP2fF0ylENLSA3cUvSOl
   aN9PhmtXdNU7VWgzjmnNZq6ptkpIw8q/WrZcb/DteljtXcB5gw9PVxx7w
   49AY1Vh68RyXtZpz+Oqulf8cPiq2K/WhkKMj877nKhI9bHZ+0XMdm0Kik
   bL+ULqtGZpYHU5+YlPHTIanwdqNkdWKW4gYd0PEKioPikxvhDo1faXOos
   Q==;
IronPort-SDR: pP+7mGCQTxEBO80r6N8wSxHQsBZrFCTSFCcXZV1450uRGzbPXkZWjVfa/jrm5JqVHsoyT/zX8E
 4RU3wOhftloK4xXAoiMoFcy6Oky09o1MWLStDR2lt+ay+/+IE4pvd2zQ03YBgpR7CfbwVOlZ3t
 R16+vTjiBh9MFOMQ1T4aTKLXdNyPUancZoX1TIe8DQQelTM8rclFGyhTM1sUlKA7VrrzUx0nEE
 33k+XqyxB892BQyXA+AxGTPr4tI2P3yekQzXf99gVmgKZREh6DbrpJW1OpxTa8aEFQfkVvOM14
 6Yc=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="226031752"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:27:54 +0800
IronPort-SDR: JZQ/zZ97PmUxqi/ajN06wDlavc0Gw7C0v1PpX+IF2XxkU6Clc3XrC9AvHpTAdSGjJdSmni4YXJ
 Z+hQaGTu7/VjlsNBzy5ep3NJ0K7QFcpf16ffN06yFdp1Kg3mSRBcdxRs7NyreJiLtroPvTfwJz
 AREFWykFlBzMU4umUXseZ5FzFqNgCEuZy6HGK2AyRCMu8gUDFFj4/Zq2Zr9cywhg5Ki+MhqTZ9
 5ginpM9MZmw8Wz8TaMMlE4tCzAoXcu0lf6/kR+E2BizDDXGJmMp1zwoV7Zb3CSB1lkN6AwRWaC
 8sjqQ8qOLrmtjJQxddTMZsRV
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:22:36 -0800
IronPort-SDR: IjjmGSbO958Vm9hoAAOc3N78MdjTl0V0DMcVGB1ZtosQN48q0Y5Fzq0rIAK0S/qu+x9vWc4wsn
 8ZlQRjtIIMlHMhcfP2hSVRHVDl1hyVPSNpEBHGz7KaxLOqZZOzbKcKGxHZb4CxB1EbPs8sBZk8
 FT5YQ3PzbxxGJ99CYyY1aay29KYnKvqH1aXVw8LWhgC1Hkfp2keeBLRFtPenVcBEWSdmsZYYal
 bCtVfmOugvy/Ur/7cbQU15x66Xcz3DdV9jnWLd1udR0A6o3GPkGf2cAzFOHQKDFBxccKhTeUsV
 NkI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip01.wdc.com with ESMTP; 04 Dec 2019 00:27:48 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 09/15] btrfs-progs: implement log-structured superblock for HMZONED mode
Date:   Wed,  4 Dec 2019 17:25:07 +0900
Message-Id: <20191204082513.857320-10-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204082513.857320-1-naohiro.aota@wdc.com>
References: <20191204082513.857320-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Superblock (and its copies) is the only data structure in btrfs which has a
fixed location on a device. Since we cannot overwrite in a sequential write
required zone, we cannot place superblock in the zone. One easy solution is
limiting superblock and copies to be placed only in conventional zones.
However, this method has two downsides: one is reduced number of superblock
copies. The location of the second copy of superblock is 256GB, which is in
a sequential write required zone on typical devices in the market today.
So, the number of superblock and copies is limited to be two.  Second
downside is that we cannot support devices which have no conventional zones
at all.

To solve these two problem, we employ superblock log writing. It uses two
zones as a circular buffer to write updated superblocks. Once the first
zone is filled up, start writing into the second buffer and reset the first
one. We can determine the postion of the latest superblock by reading write
pointer information from a device.

The following zones are reserved as the circular buffer on HMZONED btrfs.

- The primary superblock: zones 0 and 1
- The first copy: zones 16 and 17
- The second copy: zones 1024 or zone at 256GB which is minimum, and next
  to it

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 cmds/inspect-dump-super.c |   3 +-
 common/device-scan.c      |   4 +-
 common/device-utils.c     |  17 ++-
 common/hmzoned.c          | 227 ++++++++++++++++++++++++++++++++++++++
 common/hmzoned.h          |  23 ++++
 disk-io.c                 |  14 +--
 kerncompat.h              |   7 ++
 7 files changed, 281 insertions(+), 14 deletions(-)

diff --git a/cmds/inspect-dump-super.c b/cmds/inspect-dump-super.c
index ddb2120fb397..e49dec560ca7 100644
--- a/cmds/inspect-dump-super.c
+++ b/cmds/inspect-dump-super.c
@@ -34,6 +34,7 @@
 #include "cmds/commands.h"
 #include "crypto/crc32c.h"
 #include "common/help.h"
+#include "common/hmzoned.h"
 
 static int check_csum_sblock(void *sb, int csum_size, u16 csum_type)
 {
@@ -491,7 +492,7 @@ static int load_and_dump_sb(char *filename, int fd, u64 sb_bytenr, int full,
 
 	sb = (struct btrfs_super_block *)super_block_data;
 
-	ret = pread64(fd, super_block_data, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
+	ret = sbread(fd, super_block_data, sb_bytenr);
 	if (ret != BTRFS_SUPER_INFO_SIZE) {
 		/* check if the disk if too short for further superblock */
 		if (ret == 0 && errno == 0)
diff --git a/common/device-scan.c b/common/device-scan.c
index 548e1322bb70..7760ce50ad72 100644
--- a/common/device-scan.c
+++ b/common/device-scan.c
@@ -202,7 +202,7 @@ int btrfs_add_to_fsid(struct btrfs_trans_handle *trans,
 	btrfs_set_stack_device_bytes_used(dev_item, device->bytes_used);
 	memcpy(&dev_item->uuid, device->uuid, BTRFS_UUID_SIZE);
 
-	ret = pwrite(fd, buf, sectorsize, BTRFS_SUPER_INFO_OFFSET);
+	ret = sbwrite(fd, buf, BTRFS_SUPER_INFO_OFFSET);
 	BUG_ON(ret != sectorsize);
 
 	free(buf);
@@ -279,7 +279,7 @@ int btrfs_device_already_in_root(struct btrfs_root *root, int fd,
 		ret = -ENOMEM;
 		goto out;
 	}
-	ret = pread(fd, buf, BTRFS_SUPER_INFO_SIZE, super_offset);
+	ret = sbread(fd, buf, super_offset);
 	if (ret != BTRFS_SUPER_INFO_SIZE)
 		goto brelse;
 
diff --git a/common/device-utils.c b/common/device-utils.c
index 2ac8e7d9802a..d7bbac0e1730 100644
--- a/common/device-utils.c
+++ b/common/device-utils.c
@@ -231,10 +231,19 @@ int btrfs_prepare_device(int fd, const char *file, u64 *block_count_ret,
 		return 1;
 	}
 
-	ret = btrfs_wipe_existing_sb(fd);
-	if (ret < 0) {
-		error("cannot wipe superblocks on %s", file);
-		return 1;
+	if (!zinfo) {
+		ret = btrfs_wipe_existing_sb(fd);
+		if (ret < 0) {
+			error("cannot wipe superblocks on %s", file);
+			return 1;
+		}
+	} else {
+		ret = btrfs_wipe_sb_zones(fd, zinfo);
+		if (ret < 0) {
+			error("cannot wipe superblock log zones on %s", file);
+			kfree(zinfo);
+			return 1;
+		}
 	}
 
 	kfree(zinfo);
diff --git a/common/hmzoned.c b/common/hmzoned.c
index 484877743948..5080bd7dea5b 100644
--- a/common/hmzoned.c
+++ b/common/hmzoned.c
@@ -18,6 +18,7 @@
 #include <sys/ioctl.h>
 #include <unistd.h>
 
+#include "disk-io.h"
 #include "common/utils.h"
 #include "common/device-utils.h"
 #include "common/messages.h"
@@ -56,6 +57,24 @@ size_t zone_size(const char *file)
 }
 
 #ifdef BTRFS_ZONED
+static u32 sb_zone_number(u64 zone_size, int mirror)
+{
+	ASSERT(mirror < BTRFS_SUPER_MIRROR_MAX);
+
+	switch (mirror) {
+	case 0:
+		return 0;
+	case 1:
+		return 16;
+	case 2:
+		return min(btrfs_sb_offset(mirror) / zone_size, 1024ULL);
+	default:
+		BUG();
+	}
+
+	return 0;
+}
+
 bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo, u64 bytenr)
 {
 	unsigned int zno;
@@ -180,6 +199,39 @@ int btrfs_discard_all_zones(int fd, struct btrfs_zoned_device_info *zinfo)
 	return fsync(fd);
 }
 
+int btrfs_wipe_sb_zones(int fd, struct btrfs_zoned_device_info *zinfo)
+{
+	struct blk_zone_range range;
+	int i;
+
+	if (!zinfo)
+		return 0;
+
+	if (zinfo->model == ZONED_NONE)
+		return 0;
+
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		u32 sb_pos = sb_zone_number(zinfo->zone_size, i);
+
+		if (zinfo->nr_zones >= sb_pos + 1)
+			break;
+
+		range.sector = (sb_pos * zinfo->zone_size) >> SECTOR_SHIFT;
+		range.nr_sectors = (2 * zinfo->zone_size) >> SECTOR_SHIFT;
+
+		if (ioctl(fd, BLKRESETZONE, &range) < 0) {
+			error("failed to reset zone %u: %s",
+			      sb_pos, strerror(errno));
+			return 1;
+		}
+	}
+
+	if (fsync(fd))
+		return 1;
+
+	return 0;
+}
+
 int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
 		     size_t len)
 {
@@ -208,6 +260,181 @@ int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
 	return 0;
 }
 
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
+size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw)
+{
+	size_t count = BTRFS_SUPER_INFO_SIZE;
+	struct blk_zone_report *rep;
+	struct blk_zone *zones;
+	const u64 sb_size_sector = BTRFS_SUPER_INFO_SIZE >> SECTOR_SHIFT;
+	u64 mapped;
+	u32 zone_num;
+	int reset_target;
+	u32 zone_size_sector;
+	size_t rep_size;
+	int mirror = -1;
+	int i;
+	int ret;
+	size_t ret_sz;
+
+	ASSERT(rw == READ || rw == WRITE);
+
+	ret = ioctl(fd, BLKGETZONESZ, &zone_size_sector);
+	if (ret) {
+		error("ioctl BLKGETZONESZ failed (%s)", strerror(errno));
+		exit(1);
+	}
+
+	if (zone_size_sector == 0) {
+		if (rw == READ)
+			return pread64(fd, buf, count, offset);
+		return pwrite64(fd, buf, count, offset);
+	}
+
+	ASSERT(IS_ALIGNED(zone_size_sector, sb_size_sector));
+
+	for (i = 0; i < BTRFS_SUPER_MIRROR_MAX; i++) {
+		if (offset == btrfs_sb_offset(i)) {
+			mirror = i;
+			break;
+		}
+	}
+	ASSERT(mirror != -1);
+
+	zone_num = sb_zone_number(zone_size_sector * 512, mirror);
+
+	rep_size = sizeof(struct blk_zone_report) + sizeof(struct blk_zone) * 2;
+	rep = malloc(rep_size);
+	if (!rep) {
+		error("No memory for zones report");
+		exit(1);
+	}
+
+	memset(rep, 0, rep_size);
+	rep->sector = zone_num * zone_size_sector;
+	rep->nr_zones = 2;
+
+	ret = ioctl(fd, BLKREPORTZONE, rep);
+	if (ret) {
+		error("ioctl BLKREPORTZONE failed (%s)", strerror(errno));
+		exit(1);
+	}
+	if (rep->nr_zones != 2) {
+		if (errno == ENOENT || errno == 0)
+			return (rw == WRITE ? count : 0);
+		error("failed to read zone info of %u and %u: %s", zone_num,
+		      zone_num + 1, strerror(errno));
+		free(rep);
+		return 0;
+	}
+
+	zones = (struct blk_zone *)(rep + 1);
+
+	ret = sb_write_pointer(zones, &mapped);
+	if (ret != -ENOENT && ret)
+		return -EIO;
+	if (rw == READ) {
+		if (ret != -ENOENT) {
+			if (mapped == zones[0].start << SECTOR_SHIFT)
+				mapped = (zones[1].start + zones[1].len)
+					<< SECTOR_SHIFT;
+			mapped -= BTRFS_SUPER_INFO_SIZE;
+		}
+		return pread64(fd, buf, count, mapped);
+	}
+
+	ret_sz = pwrite64(fd, buf, count, mapped);
+	if (zone_size_sector == 0)
+		return ret_sz;
+
+	if (ret_sz != count)
+		return ret_sz;
+	if (fsync(fd)) {
+		error("failed to synchronize superblock: %s", strerror(errno));
+		exit(1);
+	}
+
+	reset_target = -1;
+	mapped += BTRFS_SUPER_INFO_SIZE;
+	if (mapped == (zones[0].start + zones[0].len) << SECTOR_SHIFT &&
+	    zones[1].cond != BLK_ZONE_COND_EMPTY)
+		reset_target = 1;
+	else if (mapped == (zones[1].start + zones[1].len) << SECTOR_SHIFT &&
+		 zones[0].cond != BLK_ZONE_COND_EMPTY)
+		reset_target = 0;
+
+	if (reset_target != -1) {
+		struct blk_zone_range range = {
+			zone_size_sector * (zone_num + reset_target),
+			zone_size_sector,
+		};
+		if (ioctl(fd, BLKRESETZONE, &range) < 0) {
+			error("failed to reset zone %u: %s",
+			      zone_num + reset_target, strerror(errno));
+			exit(1);
+		}
+		if (fsync(fd)) {
+			error("failed to synchronize zone reset: %s",
+			      strerror(errno));
+			exit(1);
+		}
+	}
+
+	return ret_sz;
+}
+
 #endif
 
 int btrfs_get_zone_info(int fd, const char *file, bool hmzoned,
diff --git a/common/hmzoned.h b/common/hmzoned.h
index a902717335b0..920f992dbb93 100644
--- a/common/hmzoned.h
+++ b/common/hmzoned.h
@@ -57,6 +57,16 @@ bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo, u64 bytenr);
 int btrfs_discard_all_zones(int fd, struct btrfs_zoned_device_info *zinfo);
 int zero_zone_blocks(int fd, struct btrfs_zoned_device_info *zinfo, off_t start,
 		     size_t len);
+size_t btrfs_sb_io(int fd, void *buf, off_t offset, int rw);
+static inline size_t sbread(int fd, void *buf, off_t offset)
+{
+	return btrfs_sb_io(fd, buf, offset, READ);
+}
+static inline size_t sbwrite(int fd, void *buf, off_t offset)
+{
+	return btrfs_sb_io(fd, buf, offset, WRITE);
+}
+int btrfs_wipe_sb_zones(int fd, struct btrfs_zoned_device_info *zinfo);
 #else
 static inline bool zone_is_sequential(struct btrfs_zoned_device_info *zinfo,
 				      u64 bytenr)
@@ -74,6 +84,19 @@ static inline int zero_zone_blocks(int fd,
 {
 	return -EOPNOTSUPP;
 }
+static inline u64 btrfs_map_sb_offset_for_zoned(int fd, u64 offset)
+{
+	return offset;
+}
+#define sbread(fd, buf, offset) \
+	pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
+#define sbwrite(fd, buf, offset) \
+	pwrite64(fd, buf, BTRFS_SUPER_INFO_SIZE, offset)
+static inline int btrfs_wipe_sb_zones(int fd,
+				      struct btrfs_zoned_device_info *zinfo)
+{
+	return 0;
+}
 #endif /* BTRFS_ZONED */
 
 #endif /* __BTRFS_HMZONED_H__ */
diff --git a/disk-io.c b/disk-io.c
index 659f8b93a7ca..92f781ce4abe 100644
--- a/disk-io.c
+++ b/disk-io.c
@@ -35,6 +35,7 @@
 #include "common/rbtree-utils.h"
 #include "common/device-scan.h"
 #include "crypto/hash.h"
+#include "common/hmzoned.h"
 
 /* specified errno for check_tree_block */
 #define BTRFS_BAD_BYTENR		(-1)
@@ -1553,7 +1554,7 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 	u64 bytenr;
 
 	if (sb_bytenr != BTRFS_SUPER_INFO_OFFSET) {
-		ret = pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, sb_bytenr);
+		ret = sbread(fd, buf, sb_bytenr);
 		/* real error */
 		if (ret < 0)
 			return -errno;
@@ -1581,7 +1582,8 @@ int btrfs_read_dev_super(int fd, struct btrfs_super_block *sb, u64 sb_bytenr,
 
 	for (i = 0; i < max_super; i++) {
 		bytenr = btrfs_sb_offset(i);
-		ret = pread64(fd, buf, BTRFS_SUPER_INFO_SIZE, bytenr);
+		ret = sbread(fd, buf, bytenr);
+
 		if (ret < BTRFS_SUPER_INFO_SIZE)
 			break;
 
@@ -1653,9 +1655,8 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
 		 * zero filled, we can use it directly
 		 */
-		ret = pwrite64(device->fd, fs_info->super_copy,
-				BTRFS_SUPER_INFO_SIZE,
-				fs_info->super_bytenr);
+		ret = sbwrite(device->fd, fs_info->super_copy,
+			      fs_info->super_bytenr);
 		if (ret != BTRFS_SUPER_INFO_SIZE) {
 			errno = EIO;
 			error(
@@ -1688,8 +1689,7 @@ static int write_dev_supers(struct btrfs_fs_info *fs_info,
 		 * super_copy is BTRFS_SUPER_INFO_SIZE bytes and is
 		 * zero filled, we can use it directly
 		 */
-		ret = pwrite64(device->fd, fs_info->super_copy,
-				BTRFS_SUPER_INFO_SIZE, bytenr);
+		ret = sbwrite(device->fd, fs_info->super_copy, bytenr);
 		if (ret != BTRFS_SUPER_INFO_SIZE) {
 			errno = EIO;
 			error(
diff --git a/kerncompat.h b/kerncompat.h
index 01fd93a7b540..c38643437747 100644
--- a/kerncompat.h
+++ b/kerncompat.h
@@ -76,6 +76,10 @@
 #define ULONG_MAX       (~0UL)
 #endif
 
+#ifndef SECTOR_SHIFT
+#define SECTOR_SHIFT 9
+#endif
+
 #define __token_glue(a,b,c)	___token_glue(a,b,c)
 #define ___token_glue(a,b,c)	a ## b ## c
 #ifdef DEBUG_BUILD_CHECKS
@@ -162,6 +166,7 @@ typedef long long s64;
 typedef int s32;
 #endif
 
+typedef u64 sector_t;
 
 struct vma_shared { int prio_tree_node; };
 struct vm_area_struct {
@@ -362,6 +367,8 @@ typedef u32 __bitwise __be32;
 typedef u64 __bitwise __le64;
 typedef u64 __bitwise __be64;
 
+#define U64_MAX UINT64_MAX
+
 /* Macros to generate set/get funcs for the struct fields
  * assume there is a lefoo_to_cpu for every type, so lets make a simple
  * one for u8:
-- 
2.24.0

