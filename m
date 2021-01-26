Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1492304920
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbhAZFaF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:05 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38250 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730911AbhAZClR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:41:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611628876; x=1643164876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u+vkAh1NMFAZIkRuh6fcXsdDpdyPjj3y49UjVClZ7hA=;
  b=lnVtWhvxVhtFtXWAI9RR2TcRa5xheaJ8kODrDR/R75MtHVRPfZl7nx9t
   jYHflTpYpGpj6RILtOhci/vLHgEjMeKQOy/6R8ym/EWCSWsVHNmNI1W/x
   IOa6zUdun8PiTM4S1Bu2PX8o8FYJJvWxFj3GFhd9ls45Khk5LmdG0aWMG
   NYd88DjKLBJB83p1ENMWhDsUnWWk55uEgVdfXhKABt9vaour492QUK1BT
   l3iiHy/EdZWNpFLJ4yOgZ+JfiPOv2XqXyhX9B/vf4BRVQ2/COPxQMBc9o
   N3VZ9XR7EvQ8FlINvfTK2bwv4X5ugQ80SbUACd/sknUdxU/GnvAmo0BVS
   w==;
IronPort-SDR: dkaYWHqxjTEeuWmOc+D2f45NfD69WG+TTKM9mb7W3ymvnkxWUbzqq44OUGmhp4rCE/kvOpMGZe
 ++7qrwR+XRUXbZ97Xpz/JDzEsZvo3Chr7H7G/7lF64vj/zJU3h+RufwZe+orLr65ai340Bj3y/
 ZzzlRcz224Cx3LegvtYDzK/jd+sQgTeGCq49CI8cIowOs8zln09LK/3RYsouPwm8UT4sVy1vfy
 U9GuYCuqbkA4KfLWEJg/+SU375jL6lbGAga74VmUDHhmLIw28bRusprAoKBARQRwSfP+/wi5oF
 EsI=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483574"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:26:55 +0800
IronPort-SDR: TS8XPHoLyLKTrLXaib3jfdvRa0rPkI2EsqO5Vx/lWlgImzkfQHaXnb59lqtDg8U/cvZleaNvpj
 GlvSltXu73dmAYRPfpKn8D86Fi0GmEHANSg81mnrKYvS00WYf5AwG4s3WGpM9/oGEmxjGh1vT7
 GeQBcVDpPd8egu33oNwILvmsfZ0oSi6dAd+BHwKOk1vrrdnTf3rboYe9I9sAbenLlpkFdUR5GM
 E+9Mxj/olUQ422zaNyWJnH/qlCk7xzbpx771+x701b5sIdtTGbnCh5jRAvwCHgCFCx5sfcbg9W
 M+FVFtps/ulMgA875fQmNZ0D
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:22 -0800
IronPort-SDR: epiLyE+NFzQU16hAhRlqRc548VDneOhQpccFiKNZCmiyjyon2QXR90H1xtiWPZFktAO/xwmvJx
 7Onp7+k0iJ09do0PhcfdKZvQXVCT5ZQ885ke0pfosLzjo/gqRUPdXqCjTj3jvBHgF4xdQRsBia
 6y3HK9G0Px+RWDNxtFJEOVvJfOYWJLz8poJ+vg4q/Iwm738KImy1bCbRMWmQcd+XdHjUxOsDo/
 98nn15mUStgOcb+1o3WRa842R6zfBE5WfuyqlLPgVFQRXsy8iG+nj43C3UbCmxqtkgUrxfflDv
 Irg=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:26:53 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 33/42] btrfs: mark block groups to copy for device-replace
Date:   Tue, 26 Jan 2021 11:25:11 +0900
Message-Id: <6ccb85309fdc67f70909546165d960d315db4d4c.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.h |   1 +
 fs/btrfs/dev-replace.c | 182 +++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/dev-replace.h |   3 +
 fs/btrfs/scrub.c       |  17 ++++
 4 files changed, 203 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 19a22bf930c6..3dec66ed36cb 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -95,6 +95,7 @@ struct btrfs_block_group {
 	unsigned int iref:1;
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
+	unsigned int to_copy:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/dev-replace.c b/fs/btrfs/dev-replace.c
index bc73f798ce3a..b7f84fe45368 100644
--- a/fs/btrfs/dev-replace.c
+++ b/fs/btrfs/dev-replace.c
@@ -22,6 +22,7 @@
 #include "dev-replace.h"
 #include "sysfs.h"
 #include "zoned.h"
+#include "block-group.h"
 
 /*
  * Device replace overview
@@ -459,6 +460,183 @@ static char* btrfs_dev_name(struct btrfs_device *device)
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
@@ -500,6 +678,10 @@ static int btrfs_dev_replace_start(struct btrfs_fs_info *fs_info,
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
index 3a0a6b8ed6f2..b57c1184f330 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -3564,6 +3564,17 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 		if (!cache)
 			goto skip;
 
+
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
@@ -3695,6 +3706,12 @@ int scrub_enumerate_chunks(struct scrub_ctx *sctx,
 
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

