Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3FD2E0524
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgLVDzf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:55:35 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46382 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgLVDze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609333; x=1640145333;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B9RJMyibyj8R0wRfKwUPRXyHha2r089U6e0S6zma2Ts=;
  b=UY269y2CbfolmMWcELrTWBwuXsK78frDTc3Wz8YMbn50Qm8e82XviJbv
   8qfNCGma9vk/6iQeapi9a6oHNTO18baO1Ja7apZnm27G+XQy9+urLlZ0X
   r9Isn+Wkfulkvb4ojrCo9aIYIk1lZDYwYb6iComSzltgS91v1vRdkMAPP
   E+1A186iCYWI5DndbqQ1F4BPIzsTo6+npOepRmj1lfKO19jGiXrFGEvSF
   XMZ5F0JWSDbpcgTBzd60TNm4d/Q4tWXoImkgsJLrZUXYe3wv7rPiv3roh
   UFqPUwNvU2ht+5z7TVNCGS+n8M9FBlWXJvySKFNi4V124n0QjfKrO1Y9T
   Q==;
IronPort-SDR: cCWNYADhiv16AcnNBvrHb0gVMQln0utqV9HkFOvL/BCsxB4pP1b85Qaf1OXj8I/WRwpqBaGso5
 V2v5vCVWhDBOpV0iG0ql4oQUMN565scxoJqaucEjsqOguQRPMlI/J8SsBJdnh2NbJSOXZ7SvH5
 un4Xz7rpo55wuHD4qoI+uBca35D9jP4mzEm/9r4j3Eyv9mafLdqtpm7CpFdN3aOh64lqTd2bcD
 WmoHEJSIrdgfCbRMjGvI9n8fkkk7ipIeM0rxsvIH2qa3TPOZNs1wPWuac2kkdWrkeRoFMGLhSa
 UMs=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193859"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:19 +0800
IronPort-SDR: SDlzpTFnPl5/LGiqsNGn+Q22c+WU0RTm0eMJFZ5XB6zMpwJoXVcIUiYOZTPg9TRbVmYxmsWy1+
 mZ5K4iSQBADuPgmUCSPNFVxfnV+H3P3JFUk9lbOqTzqAc3ANq437/IaSsmp3Uy8L6GVQKF6HpA
 KxDM8rH8Vi8WuJhUCH/qXNlnRE2mgXiLp9jAjKO81eWz7VbQ3+SgEoSjN/YEczpPFApTB/I6Jc
 mo4dq6zO9wlyAcMAR5erYMFnx8yFem1PiUwc0kG4k0fWwouFSifuAGUCSlLQP0OmbQPEZO9Ssf
 zTiS5iuQ57DDBRrfG2nlt1fk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:30 -0800
IronPort-SDR: ZeVfZIFjAo5jJXgIRvx66g60gh4O6nTs3sC8GXD1lQbiTQ1vBPN8/RdR+6EXsHwIxQqELQZCNv
 XwLfJ4VRUx0CeryFfrSdjsPNXpQCvaiinfUDcwKn1sorvoxDwxRW5pj4tBZl2NFClIKYYfubPj
 0DCZwii24xL3yC4TsSgiO5DDWoazQBEy2w+LiKsV2+RNwNloj02mIa8ihtX25ymHAild2SWzMh
 9m/9wBKCs6n7STya58mC7On/wUl3bSerLKu4HvZhP+5e1KsjEVxfnn3N47YjdO1A/pOR6Vjbtu
 Z6c=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:18 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 34/40] btrfs: support dev-replace in ZONED mode
Date:   Tue, 22 Dec 2020 12:49:27 +0900
Message-Id: <019923ef8aca1d3d8ccddb439e397df35cfe02a7.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is 4/4 patch to implement device-replace on ZONED mode.

Even after the copying is done, the write pointers of the source device and
the destination device may not be synchronized. For example, when the last
allocated extent is freed before device-replace process, the extent is not
copied, leaving a hole there.

This patch synchronize the write pointers by writing zeros to the
destination device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 39 +++++++++++++++++++++++++++
 fs/btrfs/zoned.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  9 +++++++
 3 files changed, 117 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index b03c3629fb12..2f577f3b1c31 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -1628,6 +1628,9 @@ static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
 	if (!btrfs_is_zoned(sctx->fs_info))
 		return 0;
 
+	if (!btrfs_dev_is_sequential(sctx->wr_tgtdev, physical))
+		return 0;
+
 	if (sctx->write_pointer < physical) {
 		length = physical - sctx->write_pointer;
 
@@ -3074,6 +3077,31 @@ static void sync_replace_for_zoned(struct scrub_ctx *sctx)
 		   atomic_read(&sctx->bios_in_flight) == 0);
 }
 
+static int sync_write_pointer_for_zoned(struct scrub_ctx *sctx, u64 logical,
+					u64 physical, u64 physical_end)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	int ret = 0;
+
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
+
+	mutex_lock(&sctx->wr_lock);
+	if (sctx->write_pointer < physical_end) {
+		ret = btrfs_sync_zone_write_pointer(sctx->wr_tgtdev, logical,
+						    physical,
+						    sctx->write_pointer);
+		if (ret)
+			btrfs_err(fs_info, "failed to recover write pointer");
+	}
+	mutex_unlock(&sctx->wr_lock);
+	btrfs_dev_clear_zone_empty(sctx->wr_tgtdev, physical);
+
+	return ret;
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3480,6 +3508,17 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	blk_finish_plug(&plug);
 	btrfs_free_path(path);
 	btrfs_free_path(ppath);
+
+	if (sctx->is_dev_replace && ret >= 0) {
+		int ret2;
+
+		ret2 = sync_write_pointer_for_zoned(sctx, base + offset,
+						    map->stripes[num].physical,
+						    physical_end);
+		if (ret2)
+			ret = ret2;
+	}
+
 	return ret < 0 ? ret : 0;
 }
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 2c7adfb43028..9ecd636596aa 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -12,6 +12,7 @@
 #include "block-group.h"
 #include "transaction.h"
 #include "dev-replace.h"
+#include "space-info.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1358,3 +1359,71 @@ int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
 				    length >> SECTOR_SHIFT,
 				    GFP_NOFS, 0);
 }
+
+static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
+			  struct blk_zone *zone)
+{
+	struct btrfs_bio *bbio = NULL;
+	u64 mapped_length = PAGE_SIZE;
+	unsigned int nofs_flag;
+	int nmirrors;
+	int i, ret;
+
+	ret = btrfs_map_sblock(fs_info, BTRFS_MAP_GET_READ_MIRRORS, logical,
+			       &mapped_length, &bbio);
+	if (ret || !bbio || mapped_length < PAGE_SIZE) {
+		btrfs_put_bbio(bbio);
+		return -EIO;
+	}
+
+	if (bbio->map_type & BTRFS_BLOCK_GROUP_RAID56_MASK)
+		return -EINVAL;
+
+	nofs_flag = memalloc_nofs_save();
+	nmirrors = (int)bbio->num_stripes;
+	for (i = 0; i < nmirrors; i++) {
+		u64 physical = bbio->stripes[i].physical;
+		struct btrfs_device *dev = bbio->stripes[i].dev;
+
+		/* Missing device */
+		if (!dev->bdev)
+			continue;
+
+		ret = btrfs_get_dev_zone(dev, physical, zone);
+		/* Failing device */
+		if (ret == -EIO || ret == -EOPNOTSUPP)
+			continue;
+		break;
+	}
+	memalloc_nofs_restore(nofs_flag);
+
+	return ret;
+}
+
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				    u64 physical_start, u64 physical_pos)
+{
+	struct btrfs_fs_info *fs_info = tgt_dev->fs_info;
+	struct blk_zone zone;
+	u64 length;
+	u64 wp;
+	int ret;
+
+	if (!btrfs_dev_is_sequential(tgt_dev, physical_pos))
+		return 0;
+
+	ret = read_zone_info(fs_info, logical, &zone);
+	if (ret)
+		return ret;
+
+	wp = physical_start + ((zone.wp - zone.start) << SECTOR_SHIFT);
+
+	if (physical_pos == wp)
+		return 0;
+
+	if (physical_pos > wp)
+		return -EUCLEAN;
+
+	length = wp - physical_pos;
+	return btrfs_zoned_issue_zeroout(tgt_dev, physical_pos, length);
+}
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index a9698470c08e..8c203c0425e0 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -57,6 +57,8 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
 			      u64 length);
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				  u64 physical_start, u64 physical_pos);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -177,6 +179,13 @@ static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
 	return -EOPNOTSUPP;
 }
 
+static inline int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev,
+						u64 logical, u64 physical_start,
+						u64 physical_pos)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.27.0

