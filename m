Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD61630F0E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbhBDKb5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:31:57 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54215 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbhBDKah (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:30:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434637; x=1643970637;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XczuzOxoCXSAbWlu/tErAsKsvdd0x/RAHCQ7sfTQFPU=;
  b=j6FmDvXqVaBrrnHcSdLqGmITvQuHoN0+3cD6GCmWhhptqydFEddD2+XW
   YMBSiy4VBQXmp/pQHtGEnwoZAClcUHa0oFdeYDEX1USCa8DA0eL+T8V3r
   b5OSg4pPUBV5uJE21qkgaIcCrmsyIpFC/tIuUyemwZYY16wt+PNMCc9DB
   B9gNRAdRMHS6/EOFvLVHd//ncWbVT0HFEiVTf3wxP9uGvoG7wKkQUWsQ5
   rRTt05RWYnLg+cnKSnjdtbkqMWIW7t6ZD1wYr7YUkhd3UK24tPmKA5lQ/
   ppdotZBopDAz/gHeTSB0ZBsXmO3vD79qjXBeal7i0NoKWxZDicWS1BaQb
   A==;
IronPort-SDR: Epv+nKBisAt9cWxob1ZaZ8jePZNTRpXMmQT+zvHWvmuVkssu1g6n4KQyqeNg/Lgn6n+mv/jgGy
 l+K3t0eJA6fGOf1IWfRv90TuAQPHU/N+IudalWvOoXEYM/QXA5EZFCjThWohFYlYU9ZUqwzk47
 /w9lBOphTC2N0mvRqcRJWZEf+14bJl4R6akDt9CVubiMWYA0QaCHc0hWJ3Sl0gzVgRAdGL7Bca
 vn831f49glSAT7vtJHXPqlXlAlSnyAZ7C0svUMFpRepjkV9fQ3A7Pvg+AG67ihPPW77NS1Thee
 NtM=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108060"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:43 +0800
IronPort-SDR: 4j3Ocn9cTCeTrn7HUGOKW7dcizR0t2r83E2V6JFxd2rppfOuy+qPfmGCu6HeztwFRK1uH0G0zO
 cNCsF7Hyhw7LJoLOJF83DKBYUbawq/bpZFjGhSwFukyZ4af2fk16EzGyGoMLKN2F4CoywaBlCW
 qCGYJUgz/0pJnNqnNNspQ6zBmZr/PdmXeFK5Z27q6MiP/KEonxOE1+I60DtJQofZoSQRkWcNgG
 BmxhmqfoOfsDG+q66Fn5CsGA50n5dmBciNdbTxWuyEv2CHAEKonpuz4aspqME4StyOQvhQscYK
 8cHbWuvk1Q6L+FXaUCqTwxpD
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:47 -0800
IronPort-SDR: 2Nsm3vVQZnmfRYWJ00VpqZI+CoGK//IBJl8Ry3HU/COWErotXyV6TyQcjorf/WMhMwrw+PEjq1
 0+TmXEczX0iSt2mL5BQuAadhL24Kk/w5fP75YoR6DaK+o9Q4bbZJEGt7Z3oY97EHjU304kNWeJ
 B4n7R3whFYhR/WfGuReF4wEp+Kd+90Y8zCkpC3yWG57LH0HdiKtUaPdrjSwnBmWdXLmR8W3me5
 fj/QUT4ugcBQunnXH9OcZDC3KfrpmdVdP14oiTbZMAfmM6IKACHTGVW4d1iyL7UepGU1ofBtYC
 3Z0=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:42 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 35/42] btrfs: zoned: support dev-replace in zoned filesystems
Date:   Thu,  4 Feb 2021 19:22:14 +0900
Message-Id: <e3399ef301e11f73fadeb6c5219270b96fc77a9c.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is 4/4 patch to implement device-replace on zoned filesystems.

Even after the copying is done, the write pointers of the source device and
the destination device may not be synchronized. For example, when the last
allocated extent is freed before device-replace process, the extent is not
copied, leaving a hole there.

Synchronize the write pointers by writing zeroes to the destination device.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/scrub.c | 40 ++++++++++++++++++++++++++
 fs/btrfs/zoned.c | 74 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/zoned.h |  9 ++++++
 3 files changed, 123 insertions(+)

diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 92904902d160..e0c3ec01e324 100644
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
 
@@ -3069,6 +3072,32 @@ static void sync_replace_for_zoned(struct scrub_ctx *sctx)
 	wait_event(sctx->list_wait, atomic_read(&sctx->bios_in_flight) == 0);
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
+			btrfs_err(fs_info,
+				  "zoned: failed to recover write pointer");
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
@@ -3475,6 +3504,17 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
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
index 396723947934..148cbfc7f988 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -12,6 +12,7 @@
 #include "block-group.h"
 #include "transaction.h"
 #include "dev-replace.h"
+#include "space-info.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1388,3 +1389,76 @@ int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 len
 	return blkdev_issue_zeroout(device->bdev, physical >> SECTOR_SHIFT,
 				    length >> SECTOR_SHIFT, GFP_NOFS, 0);
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
index 5ed1ea2009ea..932ad9bc0de6 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -56,6 +56,8 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
 int btrfs_zoned_issue_zeroout(struct btrfs_device *device, u64 physical, u64 length);
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				  u64 physical_start, u64 physical_pos);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -176,6 +178,13 @@ static inline int btrfs_zoned_issue_zeroout(struct btrfs_device *device,
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
2.30.0

