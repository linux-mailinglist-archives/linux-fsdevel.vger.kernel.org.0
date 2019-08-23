Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 054609ACD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404772AbfHWKMA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:12:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404700AbfHWKMA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555119; x=1598091119;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qXafMpKw0+kuKPC45Do+6KF/ank9FZH7H2/GFFBNxVI=;
  b=ftmBsz56ahTmbxV+Y9yfEeD9F6qaXjI/IYpATo93DdXunmTyomzC29qM
   uWu8p825dP8qEVPLGgNReHWBMoFUKOGHNNCowH7xwu08GhcjVrsX0CNLJ
   gLZrQhhGjm1Y624hd2xTv8tZF0BJxE6GoXOebRwdjt42mK42hSsr4BcaM
   oBktq1A6buh0fn4oxhVt4R6w0zq0bC0RCL5I3Jo/yBdZ6UTFpx3Vt9h4c
   M8NahgfvRf/TxRRh4Q6FeluCKRU0kEdlMh1CAWQ8EDEbtYnkFL5CfBjkt
   7mHX7NQ+4qyTRYthtrrHFnxBj0C12AdS5fQROQxA34agQQ7q6OpFCFxnx
   Q==;
IronPort-SDR: EMcbv1uwO//NU0aNxy3AsLgntCgA1DW+2hZaC2O8bon/Qrjho74VfWkSXb8p2mIiOYJnc1WUvE
 QuY0qyl+plepEzXvZv0LzB5EOiJC6W0so5JdG280wPBKJs0wb8C/8sWrRpxfQH4OyR+LLE7XCO
 rrYYqkuZRuWfW35DFwYxU+XTancBf4HYTa29XlPcReU7C0rVpJbxK+u9WS4je9K81vUsUqwSB5
 o4M2utPBGehntwravLJoxnU3P34LIVMZE/WYgk6OvJ5mvy1KWfVHl1kaLgZfpSqzAg1+7TyPJA
 s5U=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096274"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:59 +0800
IronPort-SDR: MOxuRID4zuuBv9uNqZfDw/p7abuQ1xl1x5QCfuOR8uZGTgoFQZdREX1Hv2Jpp0PX0Urym8ZhF2
 u8qS60EcKBUJ13hYAyo8EeA6Mx7402w4pqNuZaKZHjTr9mOMGTsnHgVnmin3gtnYFC7d+a22ml
 0EUuj4LTKF/kXdLcmaHYsN5JLNWy82eILxhOW6N4sS8W6SAvwiQyuSvGH0qaQxAYyrRcpHtvkv
 XMAQaO5ib7BJkj4/UpGL1Sgu9iSCLMwproBLi+AQDcNpE+Paj8LtZrQhg6YIWabt49M+qU/Obn
 S0m1qtPPArHxhUg5J8f+y21d
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:17 -0700
IronPort-SDR: XDjz1rNludSycUUIYlxpXlXE8+aJA1IItNsfemCB46V/++YYDncpG8VvIs1pc7StamsRG2hbz5
 y3H8VARuCWDFcX2dh49VF3i+qM/QrNwZRLjN7bmaJzog4Enqi/6coEBMDvMSEvK69W3ah88Nv/
 bkbrVAf3qHpyr6Bo+iiV3F+CBv7UHLC0p9S2CizqqKH1M+ofMZsJa2jWSGkjTCtOXn+1aTgr7S
 evqoXOy2djd6ltfH86uNqssohHsp7pyrfAFfGx8xlNyO/+3KrPe5pz4v9OoO8AKInQ1+4OYZdg
 vEE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:57 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 24/27] btrfs: support dev-replace in HMZONED mode
Date:   Fri, 23 Aug 2019 19:10:33 +0900
Message-Id: <20190823101036.796932-25-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
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
index e974174e12a2..a353d5901558 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -535,6 +535,7 @@ struct btrfs_block_group_cache {
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
index 9f9c09e28b5b..3289d2164860 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -34,6 +34,7 @@
 #include "delalloc-space.h"
 #include "rcu-string.h"
 #include "hmzoned.h"
+#include "dev-replace.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1950,6 +1951,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
+			struct btrfs_dev_replace *dev_replace =
+				&fs_info->dev_replace;
 
 			if (!stripe->dev->bdev) {
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
@@ -1959,15 +1962,28 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
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
index f8f41cb3d22a..1012e1e49645 100644
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
index 16094fc68552..632001aea19e 100644
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
@@ -5886,9 +5889,29 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
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
@@ -5901,6 +5924,15 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
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
@@ -5928,6 +5960,10 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
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
@@ -6313,8 +6349,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
-- 
2.23.0

