Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D582C11DCF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732035AbfLMELb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:31 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfLMELa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210290; x=1607746290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JzZdo6ep90wuQBOi8mJFFf1oBDvhMdFRRAtT38kYaWs=;
  b=O97K0foJy1Ht1F02GPXkxtKSEhkPFrSHTyaOCaniIFbyxk6ZxtXYWbRR
   K2cjF/ZnCZvqTZKPermSeT/LxSn2uLGS+pAeUFze0viR2Wni6wHbbxIih
   vZTt47/NPiwcaHHqWymY+GlzZe0c3KqFut4z8qmPjiWVyOCz3BeMZ76jW
   GLgVIl6dHJBMAP0KDxZDxFgSpNKPn05Y4YRfDaXAvIFzvgARBsM3Lh11F
   cOrcij2OrwSFsC/2nbHHtqYH1rUBCMTzcA90fXd4COxrHJqiP/PRwyFpV
   G9sAtd2r0zFvZvArZ97nL7EH36C+Fa7MG6IBJN42WKhWjcW2kHwPnFEzt
   g==;
IronPort-SDR: l9Yz1KPgtcT0sxfw6YYhG4odVxh/9ULKG2W59iE1B6KeV+bF5dQ5xMq326EkiKKL7Z1/9cCVyD
 jBexsMOX/PtgN6SQRVmSjiaHzzaqeviBeDqwzhhOyK1w0a5HQlaJCjW3Sgd3WXfFj3BypiIabK
 LTGHwVk3O+ECcXXIZLJtke3Xtqxwy8unhugEzBrr8uWkqZhn0udFeKKffkkJ5nOYForIXbRI4c
 jv9ZFr9e5YtjRL+yZbVQE2HMkuUqgUrS2qvYBI23i23dYN9ZvEXLqm3OHAsmV7ogbY7fFeFTrM
 PE0=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860164"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:30 +0800
IronPort-SDR: otRenyXyEa6oc68rdLUb7ctyCeKa4VN1TDtbpoveZA1/CawDt+sEFsNRTRRisq8KDKaaZW8aAd
 yxdno4detuv+k7EL9xRhxpx2piyim9GqlPwJl2ZQk00nNGMgMoMsuNkHwspxDE9/8n239oV9L1
 wvjYVHTh/wuaFJq/xbc1AlhbKhDKmJQ3DyI3oPahhxKyEBS1bzyYNHvtDObLSE6cnl42PUrzA/
 dAop0MIR1cbTSphx3WprwVBL+SNNrPoSh74Yi9sjsHlgxARsl/DINpUTA6i1QFY+/ze2AnLhi3
 siqpa/CrWGHgOAp63KuBQyRS
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:06:02 -0800
IronPort-SDR: TqPamKSeV0E6VbVB5O4+nYh9CeUR60du+RakR4MEM2gq2AawP8hzuSLovqefK9CNmpjg8Hf++L
 xUXwlZUbc4VQeR1NyMOOTxapGj6ZnyGLpE8ntoZsMvjNU812KPuerqjvk4nAgvQW2XYoMb+4Yc
 KQQRPapXRfsBosYHqI0bYwjbMCaoUsv0qDjVH7TYtZm8OuPYymR0D7Alfs246ySz8CTgVIvdPU
 f15urrwwJt6zQkfEaWgtJPflIdqclUeVE1pQxm4IFgjOTy2Oug1fhcVK9yeQ8d4hodoqtyZWky
 KIA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:28 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 23/28] btrfs: support dev-replace in HMZONED mode
Date:   Fri, 13 Dec 2019 13:09:10 +0900
Message-Id: <20191213040915.3502922-24-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have two type of I/Os during the device-replace process. One is a I/O to
"copy" (by the scrub functions) all the device extents on the source device
to the destination device.  The other one is a I/O to "clone" (by
handle_ops_on_dev_replace()) new incoming write I/Os from users to the
source device into the target device.

Cloning incoming I/Os can break the sequential write rule in the target
device. When write is mapped in the middle of a block group, that I/O is
directed in the middle of a zone of target device, which breaks the
sequential write rule.

However, the cloning function cannot be simply disabled since incoming I/Os
targeting already copied device extents must be cloned so that the I/O is
executed on the target device.

We cannot use dev_replace->cursor_{left,right} to determine whether bio is
going to not yet copied region.  Since we have time gap between finishing
btrfs_scrub_dev() and rewriting the mapping tree in
btrfs_dev_replace_finishing(), we can have newly allocated device extent
which is never cloned nor copied.

So the point is to copy only already existing device extents. This patch
introduces mark_block_group_to_copy() to mark existing block group as a
target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
check the flag to do their job.

Device-replace process in HMZONED mode must copy or clone all the extents
in the source device exctly once.  So, we need to use to ensure allocations
started just before the dev-replace process to have their corresponding
extent information in the B-trees. finish_extent_writes_for_hmzoned()
implements that functionality, which basically is the removed code in the
commit 042528f8d840 ("Btrfs: fix block group remaining RO forever after
error during device replace").

This patch also handles empty region between used extents. Since
dev-replace is smart to copy only used extents on source device, we have to
fill the gap to honor the sequential write rule in the target device.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/dev-replace.c | 178 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/dev-replace.h |   3 +
 fs/btrfs/extent-tree.c |  20 ++++-
 fs/btrfs/hmzoned.c     |  91 +++++++++++++++++++++
 fs/btrfs/hmzoned.h     |  16 ++++
 fs/btrfs/scrub.c       | 142 +++++++++++++++++++++++++++++++-
 fs/btrfs/volumes.c     |  36 ++++++++-
 8 files changed, 481 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 8827869f1744..323ba01ad8a9 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -83,6 +83,7 @@ struct btrfs_block_group {
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
 	unsigned int wp_broken:1;
+	unsigned int to_copy:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index 9286c6e0b636..6ac6aa0eb0b6 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -265,6 +265,10 @@ static int btrfs_init_dev_replace_tgtdev(struct btrfs_fs_info *fs_info,
 	set_blocksize(device->bdev, BTRFS_BDEV_BLOCKSIZE);
 	device->fs_devices = fs_info->fs_devices;
 
+	ret = btrfs_get_dev_zone_info(device);
+	if (ret)
+		goto error;
+
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	list_add(&device->dev_list, &fs_info->fs_devices->devices);
 	fs_info->fs_devices->num_devices++;
@@ -399,6 +403,176 @@ static char* btrfs_dev_name(struct btrfs_device *device)
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
+	struct btrfs_block_group *cache;
+	struct extent_buffer *l;
+	struct btrfs_trans_handle *trans;
+	int slot;
+	int ret = 0;
+	u64 chunk_offset, length;
+
+	/* Do not use "to_copy" on non-HMZONED for now */
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
+
+	mutex_lock(&fs_info->chunk_mutex);
+
+	/* ensulre we don't have pending new block group */
+	while (fs_info->running_transaction &&
+	       !list_empty(&fs_info->running_transaction->dev_update_list)) {
+		mutex_unlock(&fs_info->chunk_mutex);
+		trans = btrfs_attach_transaction(root);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			mutex_lock(&fs_info->chunk_mutex);
+			if (ret == -ENOENT)
+				continue;
+			else
+				goto out;
+		}
+
+		ret = btrfs_commit_transaction(trans);
+		mutex_lock(&fs_info->chunk_mutex);
+		if (ret)
+			goto out;
+	}
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto out;
+	}
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
+out:
+	mutex_unlock(&fs_info->chunk_mutex);
+
+	return ret;
+}
+
+bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
+				      struct btrfs_block_group *cache,
+				      u64 physical)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct extent_map *em;
+	struct map_lookup *map;
+	u64 chunk_offset = cache->start;
+	int num_extents, cur_extent;
+	int i;
+
+	/* Do not use "to_copy" on non-HMZONED for now */
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return true;
+
+	spin_lock(&cache->lock);
+	if (cache->removed) {
+		spin_unlock(&cache->lock);
+		return true;
+	}
+	spin_unlock(&cache->lock);
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
+	if (num_extents > 1 && cur_extent < num_extents - 1) {
+		/*
+		 * Has more stripes on this device. Keep this BG
+		 * readonly until we finish all the stripes.
+		 */
+		return false;
+	}
+
+	/* last stripe on this device */
+	spin_lock(&cache->lock);
+	cache->to_copy = 0;
+	spin_unlock(&cache->lock);
+
+	return true;
+}
+
 static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 		const char *tgtdev_name, u64 srcdevid, const char *srcdev_name,
 		int read_src)
@@ -440,6 +614,10 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
 	if (ret)
 		return ret;
 
+	ret = mark_block_group_to_copy(fs_info, src_device);
+	if (ret)
+		return ret;
+
 	down_write(&dev_replace->rwsem);
 	switch (dev_replace->replace_state) {
 	case BTRFS_IOCTL_DEV_REPLACE_STATE_NEVER_STARTED:
diff --git a/fs/btrfs/dev-replace.h b/fs/btrfs/dev-replace.h
index 60b70dacc299..3911049a5f23 100644
--- a/fs/btrfs/dev-replace.h
+++ b/fs/btrfs/dev-replace.h
@@ -18,5 +18,8 @@ int btrfs_dev_replace_cancel(struct btrfs_fs_info *fs_info);
 void btrfs_dev_replace_suspend_for_unmount(struct btrfs_fs_info *fs_info);
 int btrfs_resume_dev_replace_async(struct btrfs_fs_info *fs_info);
 int __pure btrfs_dev_replace_is_ongoing(struct btrfs_dev_replace *dev_replace);
+bool btrfs_finish_block_group_to_copy(struct btrfs_device *srcdev,
+				      struct btrfs_block_group *cache,
+				      u64 physical);
 
 #endif
diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index d1f326b6c4d4..69c4ce8ec83e 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -34,6 +34,7 @@
 #include "block-group.h"
 #include "rcu-string.h"
 #include "hmzoned.h"
+#include "dev-replace.h"
 
 #undef SCRAMBLE_DELAYED_REFS
 
@@ -1343,6 +1344,8 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			u64 length = stripe->length;
 			u64 bytes;
 			struct request_queue *req_q;
+			struct btrfs_dev_replace *dev_replace =
+				&fs_info->dev_replace;
 
 			if (!stripe->dev->bdev) {
 				ASSERT(btrfs_test_opt(fs_info, DEGRADED));
@@ -1351,15 +1354,28 @@ int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 
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
 			if (!ret) {
 				discarded_bytes += bytes;
 			} else if (ret != -EOPNOTSUPP) {
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 465db8e6de94..c26a28bd159e 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -18,6 +18,7 @@
 #include "locking.h"
 #include "space-info.h"
 #include "transaction.h"
+#include "dev-replace.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -842,6 +843,8 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	for (i = 0; i < map->num_stripes; i++) {
 		bool is_sequential;
 		struct blk_zone zone;
+		struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+		int dev_replace_is_ongoing = 0;
 
 		device = map->stripes[i].dev;
 		physical = map->stripes[i].physical;
@@ -868,6 +871,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 		 */
 		btrfs_dev_clear_zone_empty(device, physical);
 
+		down_read(&dev_replace->rwsem);
+		dev_replace_is_ongoing =
+			btrfs_dev_replace_is_ongoing(dev_replace);
+		if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL)
+			btrfs_dev_clear_zone_empty(dev_replace->tgtdev,
+						   physical);
+		up_read(&dev_replace->rwsem);
+
 		/*
 		 * The group is mapped to a sequential zone. Get the zone write
 		 * pointer to determine the allocation offset within the zone.
@@ -1236,3 +1247,83 @@ void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 	ASSERT(cache->meta_write_pointer == eb->start + eb->len);
 	cache->meta_write_pointer = eb->start;
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
+		/* missing device */
+		if (!dev->bdev)
+			continue;
+
+		ret = btrfs_get_dev_zone(dev, physical, zone);
+		/* failing device */
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
+	return btrfs_hmzoned_issue_zeroout(tgt_dev, physical_pos, length);
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 54f1affa6919..8558dd692b08 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -55,6 +55,10 @@ bool btrfs_check_meta_write_pointer(struct btrfs_fs_info *fs_info,
 				    struct btrfs_block_group **cache_ret);
 void btrfs_revert_meta_write_pointer(struct btrfs_block_group *cache,
 				     struct extent_buffer *eb);
+int btrfs_hmzoned_issue_zeroout(struct btrfs_device *device, u64 physical,
+				u64 length);
+int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev, u64 logical,
+				    u64 physical_start, u64 physical_pos);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -133,6 +137,18 @@ static inline bool btrfs_check_meta_write_pointer(
 }
 static inline void btrfs_revert_meta_write_pointer(
 	struct btrfs_block_group *cache, struct extent_buffer *eb) { }
+static inline int btrfs_hmzoned_issue_zeroout(struct btrfs_device *device,
+					      u64 physical, u64 length)
+{
+	return -EOPNOTSUPP;
+}
+static inline int btrfs_sync_zone_write_pointer(struct btrfs_device *tgt_dev,
+						u64 logical,
+						u64 physical_start,
+						u64 physical_pos)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index af7cec962619..e88f32256ccc 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -168,6 +168,7 @@ struct scrub_ctx {
 	int			pages_per_rd_bio;
 
 	int			is_dev_replace;
+	u64			write_pointer;
 
 	struct scrub_bio        *wr_curr_bio;
 	struct mutex            wr_lock;
@@ -1627,6 +1628,25 @@ static int scrub_write_page_to_dev_replace(struct scrub_block *sblock,
 	return scrub_add_page_to_wr_bio(sblock->sctx, spage);
 }
 
+static int fill_writer_pointer_gap(struct scrub_ctx *sctx, u64 physical)
+{
+	int ret = 0;
+	u64 length;
+
+	if (!btrfs_fs_incompat(sctx->fs_info, HMZONED))
+		return 0;
+
+	if (sctx->write_pointer < physical) {
+		length = physical - sctx->write_pointer;
+
+		ret = btrfs_hmzoned_issue_zeroout(sctx->wr_tgtdev,
+						  sctx->write_pointer, length);
+		if (!ret)
+			sctx->write_pointer = physical;
+	}
+	return ret;
+}
+
 static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 				    struct scrub_page *spage)
 {
@@ -1649,6 +1669,13 @@ static int scrub_add_page_to_wr_bio(struct scrub_ctx *sctx,
 	if (sbio->page_count == 0) {
 		struct bio *bio;
 
+		ret = fill_writer_pointer_gap(sctx,
+					      spage->physical_for_dev_replace);
+		if (ret) {
+			mutex_unlock(&sctx->wr_lock);
+			return ret;
+		}
+
 		sbio->physical = spage->physical_for_dev_replace;
 		sbio->logical = spage->logical;
 		sbio->dev = sctx->wr_tgtdev;
@@ -1710,6 +1737,10 @@ static void scrub_wr_submit(struct scrub_ctx *sctx)
 	 * doubled the write performance on spinning disks when measured
 	 * with Linux 3.5 */
 	btrfsic_submit_bio(sbio->bio);
+
+	if (btrfs_fs_incompat(sctx->fs_info, HMZONED))
+		sctx->write_pointer = sbio->physical +
+			sbio->page_count * PAGE_SIZE;
 }
 
 static void scrub_wr_bio_end_io(struct bio *bio)
@@ -3040,6 +3071,46 @@ static noinline_for_stack int scrub_raid56_parity(struct scrub_ctx *sctx,
 	return ret < 0 ? ret : 0;
 }
 
+static void sync_replace_for_hmzoned(struct scrub_ctx *sctx)
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
+static int sync_write_pointer_for_hmzoned(struct scrub_ctx *sctx, u64 logical,
+					  u64 physical, u64 physical_end)
+{
+	struct btrfs_fs_info *fs_info = sctx->fs_info;
+	int ret = 0;
+
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
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
@@ -3052,7 +3123,7 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	struct btrfs_extent_item *extent;
 	struct blk_plug plug;
 	u64 flags;
-	int ret;
+	int ret, ret2;
 	int slot;
 	u64 nstripes;
 	struct extent_buffer *l;
@@ -3171,6 +3242,14 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
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
@@ -3343,6 +3422,9 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 			if (ret)
 				goto out;
 
+			if (sctx->is_dev_replace)
+				sync_replace_for_hmzoned(sctx);
+
 			if (extent_logical + extent_len <
 			    key.objectid + bytes) {
 				if (map->type & BTRFS_BLOCK_GROUP_RAID56_MASK) {
@@ -3410,6 +3492,15 @@ static noinline_for_stack int scrub_stripe(struct scrub_ctx *sctx,
 	blk_finish_plug(&plug);
 	btrfs_free_path(path);
 	btrfs_free_path(ppath);
+
+	if (sctx->is_dev_replace && ret >= 0) {
+		ret2 = sync_write_pointer_for_hmzoned(
+			sctx, base + offset,
+			map->stripes[num].physical, physical_end);
+		if (ret2)
+			ret = ret2;
+	}
+
 	return ret < 0 ? ret : 0;
 }
 
@@ -3465,6 +3556,25 @@ static noinline_for_stack int scrub_chunk(struct scrub_ctx *sctx,
 	return ret;
 }
 
+static int finish_extent_writes_for_hmzoned(struct btrfs_root *root,
+					    struct btrfs_block_group *cache)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_trans_handle *trans;
+
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
+
+	btrfs_wait_block_group_reservations(cache);
+	btrfs_wait_nocow_writers(cache);
+	btrfs_wait_ordered_roots(fs_info, U64_MAX, cache->start, cache->length);
+
+	trans = btrfs_join_transaction(root);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+	return btrfs_commit_transaction(trans);
+}
+
 static noinline_for_stack
 int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 			   struct btrfs_device *scrub_dev, u64 start, u64 end)
@@ -3483,6 +3593,7 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 	struct btrfs_key found_key;
 	struct btrfs_block_group *cache;
 	struct btrfs_dev_replace *dev_replace = &fs_info->dev_replace;
+	bool do_chunk_alloc = btrfs_fs_incompat(fs_info, HMZONED);
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3551,6 +3662,18 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache)
 			goto skip;
 
+
+		if (sctx->is_dev_replace &&
+		    btrfs_fs_incompat(fs_info, HMZONED)) {
+			spin_lock(&cache->lock);
+			if (!cache->to_copy) {
+				spin_unlock(&cache->lock);
+				ro_set = 0;
+				goto done;
+			}
+			spin_unlock(&cache->lock);
+		}
+
 		/*
 		 * we need call btrfs_inc_block_group_ro() with scrubs_paused,
 		 * to avoid deadlock caused by:
@@ -3579,7 +3702,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		 * thread can't be triggered fast enough, and use up all space
 		 * of btrfs_super_block::sys_chunk_array
 		 */
-		ret = btrfs_inc_block_group_ro(cache, false);
+		ret = btrfs_inc_block_group_ro(cache, do_chunk_alloc);
+		if (!ret && sctx->is_dev_replace) {
+			ret = finish_extent_writes_for_hmzoned(root, cache);
+			if (ret) {
+				btrfs_dec_block_group_ro(cache);
+				scrub_pause_off(fs_info);
+				btrfs_put_block_group(cache);
+				break;
+			}
+		}
 		scrub_pause_off(fs_info);
 
 		if (ret == 0) {
@@ -3641,6 +3773,12 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
 		scrub_pause_off(fs_info);
 
+		if (sctx->is_dev_replace &&
+		    !btrfs_finish_block_group_to_copy(dev_replace->srcdev,
+						      cache, found_key.offset))
+			ro_set = 0;
+
+done:
 		down_write(&dev_replace->rwsem);
 		dev_replace->cursor_left = dev_replace->cursor_right;
 		dev_replace->item_needs_writeback = 1;
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index d5b280b59733..adc9dfd655a6 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -1414,6 +1414,9 @@ static int find_free_dev_extent_start(struct btrfs_device *device,
 		search_start = btrfs_zone_align(device, search_start);
 	}
 
+	WARN_ON(device->zone_info &&
+		!IS_ALIGNED(num_bytes, device->zone_info->zone_size));
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -5721,9 +5724,29 @@ static int get_extra_mirror_from_replace(struct btrfs_fs_info *fs_info,
 	return ret;
 }
 
+static bool is_block_group_to_copy(struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct btrfs_block_group *cache;
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
@@ -5736,6 +5759,15 @@ static void handle_ops_on_dev_replace(enum btrfs_map_op op,
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
@@ -6146,8 +6178,8 @@ static int __btrfs_map_block(struct btrfs_fs_info *fs_info,
 
 	if (dev_replace_is_ongoing && dev_replace->tgtdev != NULL &&
 	    need_full_stripe(op)) {
-		handle_ops_on_dev_replace(op, &bbio, dev_replace, &num_stripes,
-					  &max_errors);
+		handle_ops_on_dev_replace(op, &bbio, dev_replace, logical,
+					  &num_stripes, &max_errors);
 	}
 
 	*bbio_ret = bbio;
-- 
2.24.0

