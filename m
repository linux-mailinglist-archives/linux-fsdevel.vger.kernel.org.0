Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6A82AD516
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbgKJL3c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:32 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12024 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731949AbgKJL3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007751; x=1636543751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F07ZLxCzYtDZmvG+sINVM2GfFwZ1qzZY0JrWGzHgaFo=;
  b=cqFk083NZhCDSpZPaO0ODyXc6XNDaibZJfnCVkv3i3U3v/n5dQ9dnmlF
   0XaO/4/xaCZUSPk5cgoOE8rcw6OlOQMuIQq6vsx63hNMsuKNnQt9/Q+rR
   m0k27UZWbjsKzKBlhtIiBuI6ILBzNrRPQs8wQLtqT5exnve0lBoJB9LMt
   qvmWEk2+U+PA9EYeu4FrS80AdAHONGKg3yRrrMIXHbrsxDsXap9IOwhtd
   wRlLCBkdaQqR+JwMW6JYs+NA3F2GFVY3NS/OPhySSa7h6qUQhSXGHw9cR
   MDI7/H6J5OVSOGhVs6s7Ed0VfFWbhDqX6k+PAPpJt2T/3W5BF7uWes1vw
   A==;
IronPort-SDR: 3C0KhP7CPUhYw59Z1c5pdbHVllbVVhVzZ9GDuCYI/uAWRkHa6dvlTuIZ46wh1nZ5qaidt4tcF8
 hgai6WJarmS9bofyABgMYGuucxYJbxW+yYm4TxzrGZUk/xWNBJLzonog7G+o87s9zJtbhsG46k
 RHhuBkj0pLT3DSyTzaZFZmPv9Kam2FUd7BBi5m0VNqZtw+/KMJ1kmehwnuSqbyevq4bvPm1lrQ
 l7pbHrtV/SW4ly2GKgALyPtpmAFM2NEvaKPaKPW8QWYLR1DM7PFH8FhbpNKmCYjmCWW4PMZeGV
 pZ8=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376650"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:28:55 +0800
IronPort-SDR: yUO7zgR/uY32/J7TzSHz8G66GwE+2nvHg/9g/AKzi6ssZIXJhrrsGRPzS2XUBg8AYMRcCDTzE4
 Eq7yQ9Z6BaAcrq50m33sGEurb9i9cqlRwADSnB8TB3uqc0jeHKLGk1TbM2kccxwIiDCn1zJbkO
 ptY5N7fUztCmiPVxuOTNmKc4RiGNni2CNPWi/z0U7wkoDEYFPdAjDwfgs62z6+OTY4WrBCVcna
 xCYby66P+EOs+OovPKHuvOXA6ldBciC+vSgooUw4fHUu+LsAvGNEh2N3zRXOiidA2SaGK7cyf8
 VviJZOQ9ZkpxHkl5X+DAyC7b
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:14:56 -0800
IronPort-SDR: 3dHRP3yyIYCr6+cjHRcZQRoJhcu3Jan0gkRWHVC+tsQVgzJWZCO3b1uzYQiCroXLsRXmOVm4Ti
 GT79r6l3oZJd4AONaOsZe7jWs0u0L1QJCaHOTctSSRMhwk0G2zkAD8WQj8v6hAd7oUalXdARay
 ZSVZdizd7R2v3LiKb9f5BjzWn+8qnPcTJoccJb6i2L9zC+sTHjw/VuyxqJxJIqVuvdAHty91OM
 lya0d9ASAL1xeSHjQXH1E6FtWKt/SLPvKtx96KE5Ed3g786oeQ+pPMWroaV7MAviYUcgNMBxd4
 jbc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:28:55 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 31/41] btrfs: mark block groups to copy for device-replace
Date:   Tue, 10 Nov 2020 20:26:34 +0900
Message-Id: <b57f5fd21c034e4157295a930913ae2b7db64c5d.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 1/4 patch to support device-replace in ZONED mode.

We have two types of I/Os during the device-replace process. One is an I/O
to "copy" (by the scrub functions) all the device extents on the source
device to the destination device.  The other one is an I/O to "clone" (by
handle_ops_on_dev_replace()) new incoming write I/Os from users to the
source device into the target device.

Cloning incoming I/Os can break the sequential write rule in the target
device. When writing is mapped in the middle of a block group, the I/O is
directed in the middle of a target device zone, which breaks the sequential
write rule.

However, the cloning function cannot be merely disabled since incoming I/Os
targeting already copied device extents must be cloned so that the I/O is
executed on the target device.

We cannot use dev_replace->cursor_{left,right} to determine whether bio is
going to not yet copied region.  Since we have a time gap between finishing
btrfs_scrub_dev() and rewriting the mapping tree in
btrfs_dev_replace_finishing(), we can have a newly allocated device extent
which is never cloned nor copied.

So the point is to copy only already existing device extents. This patch
introduces mark_block_group_to_copy() to mark existing block groups as a
target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
check the flag to do their job.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/dev-replace.c | 183 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/dev-replace.h |   3 +
 fs/btrfs/scrub.c       |  17 ++++
 4 files changed, 204 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 44f68e12f863..ccbcf37eae9c 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -95,6 +95,7 @@ struct btrfs_block_group {
 	unsigned int iref:1;
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
+	unsigned int to_copy:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index db87f1aa604b..95e75fc8e266 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -22,6 +22,7 @@
 #include "dev-replace.h"
 #include "sysfs.h"
 #include "zoned.h"
+#include "block-group.h"
 
 /*
  * Device replace overview
@@ -437,6 +438,184 @@ static char* btrfs_dev_name(struct btrfs_device *device)
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
+	struct btrfs_trans_handle *trans;
+	int ret = 0;
+	u64 chunk_offset, length;
+
+	/* Do not use "to_copy" on non-ZONED for now */
+	if (!btrfs_is_zoned(fs_info))
+		return 0;
+
+	mutex_lock(&fs_info->chunk_mutex);
+
+	/* Ensure we don't have pending new block group */
+	spin_lock(&fs_info->trans_lock);
+	while (fs_info->running_transaction &&
+	       !list_empty(&fs_info->running_transaction->dev_update_list)) {
+		spin_unlock(&fs_info->trans_lock);
+		mutex_unlock(&fs_info->chunk_mutex);
+		trans = btrfs_attach_transaction(root);
+		if (IS_ERR(trans)) {
+			ret = PTR_ERR(trans);
+			mutex_lock(&fs_info->chunk_mutex);
+			if (ret == -ENOENT)
+				continue;
+			else
+				goto unlock;
+		}
+
+		ret = btrfs_commit_transaction(trans);
+		mutex_lock(&fs_info->chunk_mutex);
+		if (ret)
+			goto unlock;
+
+		spin_lock(&fs_info->trans_lock);
+	}
+	spin_unlock(&fs_info->trans_lock);
+
+	path = btrfs_alloc_path();
+	if (!path) {
+		ret = -ENOMEM;
+		goto unlock;
+	}
+
+	path->reada = READA_FORWARD;
+	path->search_commit_root = 1;
+	path->skip_locking = 1;
+
+	key.objectid = src_dev->devid;
+	key.offset = 0;
+	key.type = BTRFS_DEV_EXTENT_KEY;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	if (ret < 0)
+		goto free_path;
+	if (ret > 0) {
+		if (path->slots[0] >=
+		    btrfs_header_nritems(path->nodes[0])) {
+			ret = btrfs_next_leaf(root, path);
+			if (ret < 0)
+				goto free_path;
+			if (ret > 0) {
+				ret = 0;
+				goto free_path;
+			}
+		} else {
+			ret = 0;
+		}
+	}
+
+	while (1) {
+		struct extent_buffer *l = path->nodes[0];
+		int slot = path->slots[0];
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
+		ret = btrfs_next_item(root, path);
+		if (ret != 0) {
+			if (ret > 0)
+				ret = 0;
+			break;
+		}
+	}
+
+free_path:
+	btrfs_free_path(path);
+unlock:
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
+	/* Do not use "to_copy" on non-ZONED for now */
+	if (!btrfs_is_zoned(fs_info))
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
+	ASSERT(!IS_ERR(em));
+	map = em->map_lookup;
+
+	num_extents = cur_extent = 0;
+	for (i = 0; i < map->num_stripes; i++) {
+		/* We have more device extent to copy */
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
+	/* Last stripe on this device */
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
@@ -478,6 +657,10 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
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
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index aa1b36cf5c88..d0d7db3c8b0b 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3500,6 +3500,17 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache)
 			goto skip;
 
+
+		if (sctx->is_dev_replace && btrfs_fs_incompat(fs_info, ZONED)) {
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
 		 * Make sure that while we are scrubbing the corresponding block
 		 * group doesn't get its logical address and its device extents
@@ -3631,6 +3642,12 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
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
-- 
2.27.0

