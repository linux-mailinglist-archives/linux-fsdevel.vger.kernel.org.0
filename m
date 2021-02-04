Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2754D30F0CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhBDKbC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:31:02 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54296 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbhBDK35 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434596; x=1643970596;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kLRdm4FooKiko2saNwTcBYh7S9db83ek0H2mkQ0dkLI=;
  b=Ehupwyqr3CH2N588hvcW5TxGzBGIKBz7brmPdxbmAlOF+0rDeBKruo4l
   S1OqxLTV56H5jxLMsb8/8X57OXXrX+69lgspueNb0gsxEO71GpDP8ctAv
   GXRE91/lF9Aq6oTSmy9djENL3z3D387u41MhwTqDlyldLZADurykKQq3z
   vPYhi/JZ4oMiQzYIeLdPMUPR1QOCplVnb7jBFRSKrG+nSRvJyv5SPx5Tl
   gyMsvbAob7AsGjU5It3V6Jv6obbRNMeijoC1QPEePkMcsPNX6I7hLa65z
   sEmkroRSklJfrGkKkXoHYYzUrsgggAkewC+nSXlVqldaearxTmH28up4o
   g==;
IronPort-SDR: 4XS+aJym46yTUdqLmhylRAQNvf4+NKi/GUnZZs2IjiVDHl0weYdmK3LqdMNo0XIToM2WTaUpzp
 IuxFNm9bl/m3+ylqAxQV8loadyle9GiyYY5ACMZ0cFmZht2Ge1jARBfGAZTanLzjJ4Z+VI2szH
 sapFgZ8qVWA6xuIT3OH7Jubkvk0awZrlDNir+HIjeZR5qEYhOjaNkma+aykUAw/pNZrfq6GIUk
 NUftJJeddklspoV74fmtvqd2LkP6EDTeDmEzvtQMkpMX21YGIXzOR/SpgfFsgDfhrfuwuQFQVQ
 4X8=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108049"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:39 +0800
IronPort-SDR: ogUpfNyXFHFGMh8V7O0/DTWiTXV3U/CAJgSvLZO7GBjIy8ult0Lat9UVLX5qeq77XZAXyrR0L6
 v9XgWLddl4Kei8q5uW1UsOC/yDfawqjx2SSzkoBof23eWR52evl8iJ4HIdo5y/JIspE97UnME6
 tOeRR1nGSRaGEX8rPsn31zR3+3RwHXBiocGS9f++sJglyxfHVgLzuqbMtfqDSPikPEA58Tqa3x
 m02AIkAG7gIwLwInDUtj3tkBAUHX1/TqNYvBAvsTor4/MTZyzEZqrJMvQZ1dos92YbYy9FEkvq
 pxSTe4N32BRvKFZcM7PDSlwx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:43 -0800
IronPort-SDR: F3PmISOwBChD8jZ0QE4dV8xSE0yGjs0JqTbnWy/KyLrKUdGeWFz2+9vO0vjxaypvcs9WVOu+5t
 MMtdJRM05m+fGzz9tUrcEo/9KIO6CAr7gKhpDgxybW4EWT5HrjFmqCASGiiouPfOmHACKyUOXR
 qu4TJLyPk1oft7jQl5cRBnDZG/F5/m5OevCYfb7R6fc3dQmyq6Srt7kL1WpB1I1eC5FeBcOOAp
 KztSonY8fcj1nDSOmVbyiENAj3rtC38HhWwQ52KRIBr7ZP83sOlksn64HqbjKoq5QiuNZLt0Gb
 m5E=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:38 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 32/42] btrfs: zoned: mark block groups to copy for device-replace
Date:   Thu,  4 Feb 2021 19:22:11 +0900
Message-Id: <a8afbd3f9cc9a892c5d4f810d29ca9faf6f807f0.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 1/4 patch to support device-replace on zoned filesystems.

We have two types of I/Os during the device-replace process. One is an I/O
to "copy" (by the scrub functions) all the device extents from the source
device to the destination device. The other one is an I/O to "clone" (by
handle_ops_on_dev_replace()) new incoming write I/Os from users to the
source device into the target device.

Cloning incoming I/Os can break the sequential write rule in on target
device. When a write is mapped in the middle of a block group, the I/O is
directed to the middle of a target device zone, which breaks the
sequential write requirement.

However, the cloning function cannot be disabled since incoming I/Os
targeting already copied device extents must be cloned so that the I/O is
executed on the target device.

We cannot use dev_replace->cursor_{left,right} to determine whether a bio
is going to a not yet copied region. Since we have a time gap between
finishing btrfs_scrub_dev() and rewriting the mapping tree in
btrfs_dev_replace_finishing(), we can have a newly allocated device extent
which is never cloned nor copied.

So the point is to copy only already existing device extents. This patch
introduces mark_block_group_to_copy() to mark existing block groups as a
target of copying. Then, handle_ops_on_dev_replace() and dev-replace can
check the flag to do their job.

Also, btrfs_finish_block_group_to_copy() will check if the copied stripe
is the last stripe in the block group. With the last stripe copied,
the to_copy flag is finally disabled. Afterwards we can safely clone
incoming IOs on this block group.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/dev-replace.c | 184 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/dev-replace.h |   3 +
 fs/btrfs/scrub.c       |  16 ++++
 4 files changed, 204 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index a07108d65c44..d37ee576ac6e 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -95,6 +95,7 @@ struct btrfs_block_group {
 	unsigned int iref:1;
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
+	unsigned int to_copy:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index bc73f798ce3a..3a9c1e046ebe 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -22,6 +22,7 @@
 #include "dev-replace.h"
 #include "sysfs.h"
 #include "zoned.h"
+#include "block-group.h"
 
 /*
  * Device replace overview
@@ -459,6 +460,185 @@ static char* btrfs_dev_name(struct btrfs_device *device)
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
+	u64 chunk_offset;
+
+	/* Do not use "to_copy" on non zoned filesystem for now */
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
+			if (ret == -ENOENT) {
+				spin_lock(&fs_info->trans_lock);
+				continue;
+			} else {
+				goto unlock;
+			}
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
+	key.type = BTRFS_DEV_EXTENT_KEY;
+	key.offset = 0;
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
+		struct extent_buffer *leaf = path->nodes[0];
+		int slot = path->slots[0];
+
+		btrfs_item_key_to_cpu(leaf, &found_key, slot);
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
+		dev_extent = btrfs_item_ptr(leaf, slot, struct btrfs_dev_extent);
+
+		chunk_offset = btrfs_dev_extent_chunk_offset(leaf, dev_extent);
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
+	/* Do not use "to_copy" on non zoned filesystem for now */
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
+		 * Has more stripes on this device. Keep this block group
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
@@ -500,6 +680,10 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
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
index 5f4f88a4d2c8..da4f9c24e42d 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3561,6 +3561,16 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache)
 			goto skip;
 
+		if (sctx->is_dev_replace && btrfs_is_zoned(fs_info)) {
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
@@ -3692,6 +3702,12 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
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
2.30.0

