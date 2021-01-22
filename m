Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FCDB2FFCCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbhAVGak (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:30:40 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51117 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbhAVG3L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:29:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611296951; x=1642832951;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q73EUCkaDpj1g3aIn4kBEYnS1Lu3JYMWfvjL63A8GcI=;
  b=dYtYB7vsaSaKwwvvaCJzNAkJbUanJf9n4kMYG+itSG7JrSxHery3SO6P
   +1EoaycBHRAkcJ0/a0/CYqX+RRUdyjIVlaQo9P5PFIiv9HawkjQKPm5mO
   uUohoMzboI0KAN6fnViP9f8XsGl8v3R3TiN4EuT20kKYClvBGD+wkxpgK
   vJYBtpGmToMX7k7P/BxQWG0P6iBmZMK0fbUCpBY9Zc0DBhPsqR9ENf0M5
   xf9ggNHNnkqBeK4bYYFi4B/vSLDpU55l0MoylzUJYOh2amjl5hlz1OXrQ
   DzTBXhtA9K5dyHViRVjVrZkaHoKxdTw/Zw6OlMhniTdutS051i6lw1FdT
   A==;
IronPort-SDR: b8VJrqLvYAoF84FtNBCVPMXOEd+zAuWZSVXKtrHKweLr/Lh+ac6WiVTkwGIglqfw5MbR/dLQLf
 u9cwFOl16jc/LJY+lwekWIwzDZk15fVg8qxDGLvp4G7k9BgWv0dmTzEHHAan5V3fp3FK5T962K
 ZYeV32edsFYqXvyvdUnOfbofd+NbyQhr04n6ipo++J5sASBO51YAxTNFv7kmluPFqqlG13nec/
 izRxyvQjFxtTYYgXtD2H6zNJr/wyKJptskEE/O5T01pdAGcEuIlrfzVtHvO44HAfhos4lwdFzs
 pQE=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392078"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:20 +0800
IronPort-SDR: y5FvMO9dM/q9m/6Z0KJai7myFf5YuhbEyMcSgvxb29Ow/o9VUFnXsvagWZeXAA/HYOaawK92T/
 5bla1SsGVjNNV47+SUopt1qNMrgTzJQl1U2jd/G6FBe8+9H9KVSEFZplb9JREh5OC2s6AqLR2H
 tn8thMOJF7B+ssnUod2H1tCwMBkZjyts8v/duYdxKrBQh3azf/qhRtYa6RElJZSR2NvE1vDfAy
 ikXOVCQV3d2kc3Bc+wgUSYvf83dpzfwNHiPQm62DmON0YLaagsQyH998FOBjiDjJXalqWW/o3V
 nged45HLGYpuvBq2oBAq11Gk
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:05:52 -0800
IronPort-SDR: 5gispbNdPoAB+BQsB9nKtsNIhUFcUQdB+4JyXraQLjj58Yzovn5AxPfVkFhixYrLUApB6R1fUF
 VcoFCGlfslzj2scv4C8m+8WZ1cVnxHcqsJb6QFBAWIz0bN8T6tsrGc4+cEtR/AbXyyX7eVbYvi
 jsdmQytpKYkU/R1ab971dB5iMZh+UPh8bNyNlez9mFPoQUd1d7WGYa3A2QVRndI+lIGwxX2Pxj
 95SZHYUVzQ29borG8IVeAL1XTa99TlbDz7ru0U/PhykZz3Vz1tfa1M6fgvzwm6CWMqYvTlx3Uq
 gsI=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:19 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v13 36/42] btrfs: support dev-replace in ZONED mode
Date:   Fri, 22 Jan 2021 15:21:36 +0900
Message-Id: <b3576c8fa0873b8024a8fa2733338b5e9f0011a7.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
 fs/btrfs/scrub.c | 39 +++++++++++++++++++++++++
 fs/btrfs/zoned.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  9 ++++++
 3 files changed, 122 insertions(+)

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
index 360165bd0396..6b3750abc22a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -12,6 +12,7 @@
 #include "block-group.h"
 #include "transaction.h"
 #include "dev-replace.h"
+#include "space-info.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1398,3 +1399,76 @@ int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical,
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
+/*
+ * Synchronize write pointer in a zone at @physical_start on @tgt_dev, by
+ * filling zeros between @physical_pos to a write pointer of dev-replace
+ * source device.
+ */
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

