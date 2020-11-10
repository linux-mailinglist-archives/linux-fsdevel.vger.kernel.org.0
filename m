Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 140372AD519
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732072AbgKJL3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:36 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12024 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731886AbgKJL3X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007763; x=1636543763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1Zf+mTBpk3dXiZYpxrZ6btL7+6AutqeowtwPs4bCEd0=;
  b=goTWo7yE9rvyzx4iTgA9nYwN+3lHYZr1jftkskF83Jekj/xakmx9Ghg3
   bAXSNdlA1Iu7fc8ldIeCNUc09b+AKC0tncjWoBo7+EALj3rStrqkpuk0N
   9SMwv8EHLjKNL8nF9bwvxApMAmd/p5ILr7W/M0w/KTd+fxQIru7ru56Lf
   JY5RVkUFK+VQyaUKbJQQqcApCNjjwKt8+CY4j2EaW5VenT/Q5UT08NqOP
   PE83j3zNJI8chPCKclFDNJo3/YcwfAUKGhopWL+HsVkE9Lj6l/Zh3DZc0
   amB6h6Why6TNZYJKwnl0CEBP/qkBkTAwrltQP7ECv3tyXLi3efwO3O0iL
   w==;
IronPort-SDR: 8ZHbDDjOjI5X+9tJo96PJ+AwunEwmEDj+VLhNhY46L4VonTmj/lhglKV/Dsft06TK2u69QiAKs
 gmTp1xSpc04arqtC9tmPHylsf8Hp8lvrCfDE2GTUyC683khqKOl1OA/PDmv1yy0llJu8vWm5hk
 KB1q+70NENkfdbhEtf1Ew6tg5KYgauFfd4dDSfPnSKN06zEd48tJLVVJPm6yp0qdGbWERQLsRw
 xBUa6y7Rv1wdGXpWxrr0PS3dmyhOmmWaqhC5Z4ejtIFbUzQCynTIxbHzc5RdlBN1ny/Pl3FRZn
 XUo=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376690"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:29:00 +0800
IronPort-SDR: id31yvqYPzJkSTBZEftEm62+bP2d9OLjbuZ9YUkjvK41HO4G//X4wFXYiQfvHu61OKHU4JTWpj
 nuvCQPyXgOKoQc9kuTP38u5xsgfIE8bak5G4LLKtNjTBprbP9U/NTOcJL4UGdSmoidnuE/Nzra
 IsSnfizLUL4Mp8m8vnRUdvlynh4m+CyrYHeK9AzSLOkVnb3ynotxS/RkOSaDOK++ULcGlUeCPE
 4qxulm8nMKdYFuBztAuMVj/HikYGFF6diaRx7UygiaEWn0GlIi3g1bEMWuUiGnOs01DN4Me5RX
 nkTB1aGxXFZZah8cb6jlQmSt
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:15:01 -0800
IronPort-SDR: eCENEISv/Ch39BzqsWzoTPhuf4kZhGOFGWm6S67F1qndx2ciagewcQ12+8X3b6xEIq+PexFvkC
 Bcss73j2LCNnrJI9WqGD2fGqdR3AP0G6+coBMYY3x90MwssJ1iVLuBVQI3SfKf9okjTAib5Haz
 Bq68oY79n6tZYQcvfgEpuU01y4jtPHocS6zIueam58HPChh1VlME383qvvLXPt2UJq2bs3qNg5
 9xPaIJ8iT+FRBEDb6D0E280Fn8+y+dfg35CTO1lqtw7fl3QreuWINfzeDDRCxMu41JsF0SoXoF
 AkA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:59 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 34/41] btrfs: support dev-replace in ZONED mode
Date:   Tue, 10 Nov 2020 20:26:37 +0900
Message-Id: <25283ad0c9c0206f62ed68f2e7c546bde946fc17.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 36 +++++++++++++++++++++++++
 fs/btrfs/zoned.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  9 +++++++
 3 files changed, 114 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index aaf7882dee06..0e2211b9c810 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3019,6 +3019,31 @@ static void sync_replace_for_zoned(struct scrub_ctx *sctx)
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
@@ -3416,6 +3441,17 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
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
index cce4ddfff5d2..77ca93bda258 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -12,6 +12,7 @@
 #include "block-group.h"
 #include "transaction.h"
 #include "dev-replace.h"
+#include "space-info.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1201,3 +1202,71 @@ int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
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
index 40204f8310ca..5b61500a0aa9 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -55,6 +55,8 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
 			      u64 length);
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				  u64 physical_start, u64 physical_pos);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -166,6 +168,13 @@ static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
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

