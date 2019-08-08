Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8991E85E7D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbfHHJcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:32:01 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732459AbfHHJcA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256719; x=1596792719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FpMsOIcUl0QbkS9l++/SpIQW6ZLpofUQQinEIkqlVho=;
  b=J/aqvkvJyesLf1Kc2dN/9tG0lWez90TLCefd9iHrPNU1DgHjou9nIAOD
   cqQZyw6ZFYmmtriQX1u5bXhTMZQM5+sZLXZIX1d/AXJT35JPhF6og2QwB
   KEejbcHJztx9wN4zkFf3apwReElgygj/24bCmKGPkCvWrtoCyKWU3drRV
   ZzemtqRamoiLNABVIkHPvX+BMCpVWhYVi2w+gGQ7WLpqSbAbDIXk16uX5
   EzkV95zg5WEBT18E5OVzT+Dy7oEjiMym90Cy2PpizT09ZiCEgMl7cRZiQ
   O+h7cGWujho9qxtmadPlpFIRj6/PC0Gq5m0nSIC3XPGjX20EJGpyw5AJ7
   w==;
IronPort-SDR: PlhzKi6CfZUQWSgZ36PMeBhLf3WMECiUaFYi60Uia1zv6O9SqHMCK9nHab8giLQb4pLcoLp4pV
 V6BBjzBccHtOBm/qC1FbFgmCI7P70H6tn8+0V1bMF0Y3HipLhmrj3OcxnbEvFc2OemkA3PvGIV
 ZlkpbCdCK8FZ/klgJMlHDVuFPoINA2jkc2vcTjmgm723tY/eEnyopamo0dRc1wAT3J0CiL15CZ
 W9wXdXlxOhcjuUeatBHtICgMBTuZ4JVKeFAQOay88bM+OT/a68NmHjcQoWlaXXySIE/loeNQd/
 6LE=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363417"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:59 +0800
IronPort-SDR: td4BzzrfDNRFGfs9xexMWHs2pUlVGaI7eSuoSIn6jCw6s9BqUpUk9oJukhuZ3MfRIVsjHXoxqo
 VDFxoYjS0FE7pWzR3w0enhxbEU3ow0taaKSiMqYPze1UPeQOTh5qtIA1GlNPR0JztltR61PQ/7
 0RUQ/RZXX2DRxdqczDLpxUmgB6t++ixSfCd5EaRvcFuWyg4mNoZkZfxVh9JtO73OyNjDCY888L
 Hv39G/ePfjynJAePNrtfPPrarZTDxGQTJr0lfRDEG/0maM0iLR9Zvg7bgjo2h4/sSYebDC02ye
 B+d//6AJ3O7AYP30umr70lTX
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:43 -0700
IronPort-SDR: GSxOrhDmLDGdy21ltZHCxOcjpU4hXCzi706+dONrGQTPEyx3JRtYkNfpSD2T4AXS1Y8bc3LiLT
 RorWO/iRyOYLEFp9rdThhpJ7faUuWG5HelQ5usyNAmWDo2/2chkgFNylCNib43XL7HjqeBSMuc
 2cqQY4lQtFDnZSaJp/MiFyRIK3vansVdRsMdwhsJKugrQeqPL0EX9MUWZQq6nAvNv2Zqq5FqYJ
 tO57leCF0HwjjLzkZ8D0dO2n72lG9+EDJzwSn7RY8Z9XrCp5mXqmjTHANH9DnE7387ctZj7x/i
 F1I=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:58 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 24/27] btrfs: support dev-replace in HMZONED mode
Date:   Thu,  8 Aug 2019 18:30:35 +0900
Message-Id: <20190808093038.4163421-25-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, dev-replace copy all the device extents on source device to the
target device, and it also clones new incoming write I/Os from users to the
source device into the target device.

Cloning incoming IOs can break the sequential write rule in the target
device. When write is mapped in the middle of block group, that I/O is
directed in the middle of a zone of target device, which breaks the
sequential write rule.

However, the cloning function cannot be simply disabled since incoming I/Os
targeting already copied device extents must be cloned so that the I/O is
executed on the target device.

We cannot use dev_replace->cursor_{left,right} to determine whether bio
is going to not yet copied region.  Since we have time gap between
finishing btrfs_scrub_dev() and rewriting the mapping tree in
btrfs_dev_replace_finishing(), we can have newly allocated device extent
which is never cloned (by handle_ops_on_dev_replace) nor copied (by the
dev-replace process).

So the point is to copy only already existing device extents. This patch
introduce mark_block_group_to_copy() to mark existing block group as a
target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
check the flag to do their job.

This patch also handles empty region between used extents. Since
dev-replace is smart to copy only used extents on source device, we have to
fill the gap to honor the sequential write rule in the target device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/ctree.h       |   1 +
 fs/btrfs/dev-replace.c | 147 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/dev-replace.h |   3 +
 fs/btrfs/extent-tree.c |  20 +++++-
 fs/btrfs/hmzoned.c     |  77 +++++++++++++++++++++
 fs/btrfs/hmzoned.h     |   4 ++
 fs/btrfs/scrub.c       |  83 ++++++++++++++++++++++-
 fs/btrfs/volumes.c     |  40 ++++++++++-
 8 files changed, 370 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index a6a03fc5e4c5..1282840a2db8 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -536,6 +536,7 @@ struct btrfs_block_group_cache {
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
 	unsigned int wp_broken:1;
+	unsigned int to_copy:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 2cc3ac4d101d..7ef1654aed9d 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -264,6 +264,10 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_info->fs_devices;
 
+	ret = btrfs_get_dev_zone_info(device);
+	if (ret)
+		goto error;
+
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	list_add(&device->dev_list, &fs_info->fs_devices->devices);
 	fs_info->fs_devices->num_devices++;
@@ -398,6 +402,143 @@ static char* btrfs_dev_name(struct btrfs_device *device)
 		return rcu_str_deref(device->name);
 }
 
+static int mark_block_group_to_copy(struct btrfs_fs_info *fs_info,
+				    struct btrfs_device *src_dev)
+{
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	struct btrfs_root *root = fs_info->dev_root;
+	struct btrfs_dev_extent *dev_extent = NULL;
+	struct btrfs_block_group_cache *cache;
+	struct extent_buffer *l;
+	int slot;
+	int ret;
+	u64 chunk_offset, length;
+
+	/* Do not use "to_copy" on non-HMZONED for now */
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	path->reada = READA_FORWARD;
+	path->search_commit_root = 1;
+	path->skip_locking = 1;
+
+	key.objectid = src_dev->devid;
+	key.offset = 0ull;
+	key.type = BTRFS_DEV_EXTENT_KEY;
+
+	while (1) {
+		ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+		if (ret < 0)
+			break;
+		if (ret > 0) {
+			if (path->slots[0] >=
+			    btrfs_header_nritems(path->nodes[0])) {
+				ret = btrfs_next_leaf(root, path);
+				if (ret < 0)
+					break;
+				if (ret > 0) {
+					ret = 0;
+					break;
+				}
+			} else {
+				ret = 0;
+			}
+		}
+
+		l = path->nodes[0];
+		slot = path->slots[0];
+
+		btrfs_item_key_to_cpu(l, &found_key, slot);
+
+		if (found_key.objectid != src_dev->devid)
+			break;
+
+		if (found_key.type != BTRFS_DEV_EXTENT_KEY)
+			break;
+
+		if (found_key.offset < key.offset)
+			break;
+
+		dev_extent = btrfs_item_ptr(l, slot, struct btrfs_dev_extent);
+		length = btrfs_dev_extent_length(l, dev_extent);
+
+		chunk_offset = btrfs_dev_extent_chunk_offset(l, dev_extent);
+
+		cache = btrfs_lookup_block_group(fs_info, chunk_offset);
+		if (!cache)
+			goto skip;
+
+		spin_lock(&cache->lock);
+		cache->to_copy = 1;
+		spin_unlock(&cache->lock);
+
+		btrfs_put_block_group(cache);
+
+skip:
+		key.offset = found_key.offset + length;
+		btrfs_release_path(path);
+	}
+
+	btrfs_free_path(path);
+
+	return ret;
+}
+
+void btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
+				      struct btrfs_block_group_cache *cache,
+				      u64 physical)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct extent_map *em;
+	struct map_lookup *map;
+	u64 chunk_offset = cache->key.objectid;
+	int num_extents, cur_extent;
+	int i;
+
+	em = btrfs_get_chunk_map(fs_info, chunk_offset, 1);
+	BUG_ON(IS_ERR(em));
+	map = em->map_lookup;
+
+	num_extents = cur_extent = 0;
+	for (i = 0; i < map->num_stripes; i++) {
+		/* we have more device extent to copy */
+		if (srcdev != map->stripes[i].dev)
+			continue;
+
+		num_extents++;
+		if (physical == map->stripes[i].physical)
+			cur_extent = i;
+	}
+
+	free_extent_map(em);
+
+	if (num_extents > 1) {
+		if (cur_extent == 0) {
+			/*
+			 * first stripe on this device. Keep this BG
+			 * readonly until we finish all the stripes.
+			 */
+			btrfs_inc_block_group_ro(cache);
+		} else if (cur_extent == num_extents - 1) {
+			/* last stripe on this device */
+			btrfs_dec_block_group_ro(cache);
+			spin_lock(&cache->lock);
+			cache->to_copy = 0;
+			spin_unlock(&cache->lock);
+		}
+	} else {
+		spin_lock(&cache->lock);
+		cache->to_copy = 0;
+		spin_unlock(&cache->lock);
+	}
+}
+
 static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		const char *tgtdev_name, u64 srcdevid, const char *srcdev_name,
 		int read_src)
@@ -439,6 +580,12 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	if (ret)
 		return ret;
 
+	mutex_lock(&fs_info->chunk_mutex);
+	ret = mark_block_group_to_copy(fs_info, src_device);
+	mutex_unlock(&fs_info->chunk_mutex);
+	if (ret)
+		return ret;
+
 	down_write(&dev_replace->rwsem);
 	switch (dev_replace->replace_state) {
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
index 78c5d8f1adda..5ba60345dbf8 100644
--- a/fs/btrfs/dev-replace.h
+++ b/fs/btrfs/dev-replace.h
@@ -18,5 +18,8 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info);
 void btrfs_dev_replace_suspend_for_unmount(struct btrfs_fs_info *fs_info);
 int btrfs_resume_dev_replace_async(struct btrfs_fs_info *fs_info);
 int btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
+void btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
+				      struct btrfs_block_group_cache *cache,
+				      u64 physical);
 
 #endif
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 5b1a9e607555..e68872571f18 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -33,6 +33,7 @@
 #include "delalloc-space.h"
 #include "rcu-string.h"
 #include "hmzoned.h"
+#include "dev-replace.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1949,6 +1950,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
+			struct btrfs_dev_replace *dev_replace =
+				&fs_info->dev_replace;
 
 			if (!stripe->dev->bdev) {
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
@@ -1958,15 +1961,28 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			req_q = bdev_get_queue(stripe->dev->bdev);
 
 			/* zone reset in HMZONED mode */
-			if (btrfs_can_zone_reset(dev, physical, length))
+			if (btrfs_can_zone_reset(dev, physical, length)) {
 				ret = btrfs_reset_device_zone(dev, physical,
 							      length, &bytes);
-			else if (blk_queue_discard(req_q))
+				if (ret)
+					goto next;
+				if (!btrfs_dev_replace_is_ongoing(
+					    dev_replace) ||
+				    dev != dev_replace->srcdev)
+					goto next;
+
+				discarded_bytes += bytes;
+				/* send to replace target as well */
+				ret = btrfs_reset_device_zone(
+					dev_replace->tgtdev,
+					physical, length, &bytes);
+			} else if (blk_queue_discard(req_q))
 				ret = btrfs_issue_discard(dev->bdev, physical,
 							  length, &bytes);
 			else
 				continue;
 
+next:
 			if (!ret)
 				discarded_bytes += bytes;
 			else if (ret != -EOPNOTSUPP)
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 8529106321ac..76230ad80a68 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -706,3 +706,80 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 
 	return true;
 }
+
+int btrfs_hmzoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+				u64 length)
+{
+	if (!btrfs_dev_is_sequential(device, physical))
+		return -EOPNOTSUPP;
+
+	return blkdev_issue_zeroout(device->bdev,
+				    physical >> SECTOR_SHIFT,
+				    length >> SECTOR_SHIFT,
+				    GFP_NOFS, 0);
+}
+
+static int read_zone_info(struct btrfs_fs_info *fs_info, u64 logical,
+			  struct blk_zone *zone)
+{
+	struct btrfs_bio *bbio = NULL;
+	u64 mapped_length = PAGE_SIZE;
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
+	nmirrors = (int)bbio->num_stripes;
+	for (i = 0; i < nmirrors; i++) {
+		u64 physical = bbio->stripes[i].physical;
+		struct btrfs_device *dev = bbio->stripes[i].dev;
+
+		/* missing device */
+		if (!dev->bdev)
+			continue;
+
+		ret = btrfs_get_dev_zone(dev, physical, zone, GFP_NOFS);
+		/* failing device */
+		if (ret == -EIO || ret == -EOPNOTSUPP)
+			continue;
+		break;
+	}
+
+	return ret;
+}
+
+int btrfs_sync_hmzone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
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
+	return btrfs_hmzoned_issue_zeroout(tgt_dev, physical_pos, length);
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index c68c4b8056a4..b0bb96404a24 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -43,6 +43,10 @@ void btrfs_hmzoned_data_io_unlock_at(struct inode *inode, u64 start, u64 len);
 bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct extent_buffer *eb,
 				    struct btrfs_block_group_cache **cache_ret);
+int btrfs_hmzoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+				u64 length);
+int btrfs_sync_hmzone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				    u64 physical_start, u64 physical_pos);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e15d846c700a..9f3484597338 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -167,6 +167,7 @@ struct scrub_ctx {
 	int			pages_per_rd_bio;
 
 	int			is_dev_replace;
+	u64			write_pointer;
 
 	struct scrub_bio        *wr_curr_bio;
 	struct mutex            wr_lock;
@@ -1648,6 +1649,23 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 	sbio = sctx->wr_curr_bio;
 	if (sbio->page_count == 0) {
 		struct bio *bio;
+		u64 physical = spage->physical_for_dev_replace;
+
+		if (btrfs_fs_incompat(sctx->fs_info, HMZONED) &&
+		    sctx->write_pointer < physical) {
+			u64 length = physical - sctx->write_pointer;
+
+			ret = btrfs_hmzoned_issue_zeroout(sctx->wr_tgtdev,
+							  sctx->write_pointer,
+							  length);
+			if (ret == -EOPNOTSUPP)
+				ret = 0;
+			if (ret) {
+				mutex_unlock(&sctx->wr_lock);
+				return ret;
+			}
+			sctx->write_pointer = physical;
+		}
 
 		sbio->physical = spage->physical_for_dev_replace;
 		sbio->logical = spage->logical;
@@ -1710,6 +1728,10 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	 * doubled the write performance on spinning disks when measured
 	 * with Linux 3.5 */
 	btrfsic_submit_bio(sbio->bio);
+
+	if (btrfs_fs_incompat(sctx->fs_info, HMZONED))
+		sctx->write_pointer = sbio->physical +
+			sbio->page_count * PAGE_SIZE;
 }
 
 static void scrub_wr_bio_end_io(struct bio *bio)
@@ -3043,6 +3065,21 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	return ret < 0 ? ret : 0;
 }
 
+void sync_replace_for_hmzoned(struct scrub_ctx *sctx)
+{
+	if (!btrfs_fs_incompat(sctx->fs_info, HMZONED))
+		return;
+
+	sctx->flush_all_writes = true;
+	scrub_submit(sctx);
+	mutex_lock(&sctx->wr_lock);
+	scrub_wr_submit(sctx);
+	mutex_unlock(&sctx->wr_lock);
+
+	wait_event(sctx->list_wait,
+		   atomic_read(&sctx->bios_in_flight) == 0);
+}
+
 static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 					   struct map_lookup *map,
 					   struct btrfs_device *scrub_dev,
@@ -3174,6 +3211,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	 */
 	blk_start_plug(&plug);
 
+	if (sctx->is_dev_replace &&
+	    btrfs_dev_is_sequential(sctx->wr_tgtdev, physical)) {
+		mutex_lock(&sctx->wr_lock);
+		sctx->write_pointer = physical;
+		mutex_unlock(&sctx->wr_lock);
+		sctx->flush_all_writes = true;
+	}
+
 	/*
 	 * now find all extents for each stripe and scrub them
 	 */
@@ -3346,6 +3391,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			if (ret)
 				goto out;
 
+			if (sctx->is_dev_replace)
+				sync_replace_for_hmzoned(sctx);
+
 			if (extent_logical + extent_len <
 			    key.objectid + bytes) {
 				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -3413,6 +3461,26 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	blk_finish_plug(&plug);
 	btrfs_free_path(path);
 	btrfs_free_path(ppath);
+
+	if (btrfs_fs_incompat(fs_info, HMZONED) && sctx->is_dev_replace &&
+	    ret >= 0) {
+		wait_event(sctx->list_wait,
+			   atomic_read(&sctx->bios_in_flight) == 0);
+
+		mutex_lock(&sctx->wr_lock);
+		if (sctx->write_pointer < physical_end) {
+			ret = btrfs_sync_hmzone_write_pointer(
+				sctx->wr_tgtdev, base + offset,
+				map->stripes[num].physical,
+				sctx->write_pointer);
+			if (ret)
+				btrfs_err(fs_info, "failed to recover write pointer");
+		}
+		mutex_unlock(&sctx->wr_lock);
+		btrfs_dev_clear_zone_empty(sctx->wr_tgtdev,
+					   map->stripes[num].physical);
+	}
+
 	return ret < 0 ? ret : 0;
 }
 
@@ -3554,6 +3622,14 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache)
 			goto skip;
 
+		spin_lock(&cache->lock);
+		if (sctx->is_dev_replace && !cache->to_copy) {
+			spin_unlock(&cache->lock);
+			ro_set = 0;
+			goto done;
+		}
+		spin_unlock(&cache->lock);
+
 		/*
 		 * we need call btrfs_inc_block_group_ro() with scrubs_paused,
 		 * to avoid deadlock caused by:
@@ -3588,7 +3664,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			ret = btrfs_wait_ordered_roots(fs_info, U64_MAX,
 						       cache->key.objectid,
 						       cache->key.offset);
-			if (ret > 0) {
+			if (ret >= 0) {
 				struct btrfs_trans_handle *trans;
 
 				trans = btrfs_join_transaction(root);
@@ -3664,6 +3740,11 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		scrub_pause_off(fs_info);
 
+		if (sctx->is_dev_replace)
+			btrfs_finish_block_group_to_copy(
+				dev_replace->srcdev, cache, found_key.offset);
+
+done:
 		down_write(&fs_info->dev_replace.rwsem);
 		dev_replace->cursor_left = dev_replace->cursor_right;
 		dev_replace->item_needs_writeback = 1;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 265a1496e459..07e7528fb23e 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1592,6 +1592,9 @@ int find_free_dev_extent_start(struct btrfs_device *device, u64 num_bytes,
 	search_start = max_t(u64, search_start, zone_size);
 	search_start = btrfs_zone_align(device, search_start);
 
+	WARN_ON(device->zone_info &&
+		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -5894,9 +5897,29 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct btrfs_block_group_cache *cache;
+	bool ret;
+
+	/* non-HMZONED mode does not use "to_copy" flag */
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return false;
+
+	cache = btrfs_lookup_block_group(fs_info, logical);
+
+	spin_lock(&cache->lock);
+	ret = cache->to_copy;
+	spin_unlock(&cache->lock);
+
+	btrfs_put_block_group(cache);
+	return ret;
+}
+
 static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 				      struct btrfs_bio **bbio_ret,
 				      struct btrfs_dev_replace *dev_replace,
+				      u64 logical,
 				      int *num_stripes_ret, int *max_errors_ret)
 {
 	struct btrfs_bio *bbio = *bbio_ret;
@@ -5909,6 +5932,15 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 	if (op == BTRFS_MAP_WRITE) {
 		int index_where_to_add;
 
+		/*
+		 * a block group which have "to_copy" set will
+		 * eventually copied by dev-replace process. We can
+		 * avoid cloning IO here.
+		 */
+		if (is_block_group_to_copy(dev_replace->srcdev->fs_info,
+					   logical))
+			return;
+
 		/*
 		 * duplicate the write operations while the dev replace
 		 * procedure is running. Since the copying of the old disk to
@@ -5936,6 +5968,10 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
 				index_where_to_add++;
 				max_errors++;
 				tgtdev_indexes++;
+
+				/* mark this zone as non-empty */
+				btrfs_dev_clear_zone_empty(new->dev,
+							   new->physical);
 			}
 		}
 		num_stripes = index_where_to_add;
@@ -6321,8 +6357,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
-- 
2.22.0

