Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 038862AD529
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732198AbgKJL36 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:58 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12022 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbgKJL3d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007773; x=1636543773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fO7fczkDPPhLC1awKk+6Qj/uT853qiV2q2oLTyKWl+4=;
  b=DQwkPg4v2droWZuYLGBvgv00iJvEaqYIREBeumutWNi50JJdx5ldHUTq
   1A6DKzGSN0c3KAf0sMY2nXcnIMZZuaCRVKkw3uugL0/wO/hadmOqtYcp6
   7ywFTDzT1XvtoUTzIwLhso5ZN9EnGaqmqExGqY4UWzfQkW4Vqhcx10XjY
   OBSLwC59Z4LUpA7F/cdl46mAYWOrg/1NrGkuzbp1SlFujABGqOrNszIC7
   3ZkOEr5e46D9w6kTxdv8Pq8YwgoBXjB7/pUuB7TXvUqlmJHBKV0+l8/Dj
   +IwAAOqbfWGDHD8E7k9Bi/0EGF8rFsydfd6bdZz8AR2NM8rLpGKAZOhfi
   w==;
IronPort-SDR: ZuINvXsq7EwO57ryz6ozdd4OZ0W/Z5NdvToJZ8KBy2FPHfc8dfHAEoxHMxviXFjuQwRdGKBzTl
 s/yJgYdzHY1cSKiJ0m2XNaIckjqCxN+6OEm0a6PzacYcB6KmmpMOELjd/YF7Wi2/tKHrU3MuiK
 XxTCoQb7bdjShmbndd5xYoo5DBv/fvEvujKfysHTe/ulL7ytYGuh04vBZhHlh8InybIvBEmRav
 0Zr25tgToCNjDYRtqW8p5q2VSS9hKbjRGGIO0FvKExudiM/dbuEAVRvhUTOk7PQLTc/akf73+M
 g2c=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376709"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:29:03 +0800
IronPort-SDR: jXL4LcnxTFV3r23xihNi5qjExcUbUTal+VwAFngswKGd9lOFjtnZmVGOtL42yhXEwZbVkUquyX
 2ok42TnpiBMP4exNlQ8ZJfqbpudS4w0Piu6LSim83AfBfarB5vzGHi5ppusE7CeE90N9vgM0wc
 42aFLhS6RtpsufnyqfgWJ9xPTANk8tWS9gJrovMgEOG+QDBI/dqzUGZwR4hTQfUoCW6C8GvrFH
 z/v6JDpDBrNG4TS8k7rSaaFiaKaqRjSthlZCqt/iOD4MRza1gSOpR/cRAntnbY0agxLMFXVaGd
 0XPkOd3XiCiUSBPk49N59jxk
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:15:05 -0800
IronPort-SDR: W/yRkaKW2PFWeqjqpPqfUtx0LyO7DatzGr0BAyTrcFeDCbtUvOsu0MjFBGOZdF5jINoetzCFMF
 tSa1FHbFGcDX4WEfAgSem57bEF40KLdCbRqwo9HccYHOGQL/yRnoJcKDunYaeKsw3B9VyyCTdY
 LxJidyeErkTvHfqMWAcCCWMhjTE6zPcpqGQ1ZfXfb48ZQHg9aWGR/hKPu+kmRfseMIma8xP28u
 DjJQ/yw0GGNNJ0RceOUA4XLCFNeup6WlfJPfRaq3MDn0v+pkYJWmGoyXZIgwDx66xtMBy8aIkK
 rYc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:29:03 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v10 36/41] btrfs: relocate block group to repair IO failure in ZONED
Date:   Tue, 10 Nov 2020 20:26:39 +0900
Message-Id: <49cb37a5f0c1c1ddfbf9389f8038948aec640c37.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When btrfs find a checksum error and if the file system has a mirror of the
damaged data, btrfs read the correct data from the mirror and write the
data to damaged blocks. This repairing, however, is against the sequential
write required rule.

We can consider three methods to repair an IO failure in ZONED mode:
(1) Reset and rewrite the damaged zone
(2) Allocate new device extent and replace the damaged device extent to the
    new extent
(3) Relocate the corresponding block group

Method (1) is most similar to a behavior done with regular devices.
However, it also wipes non-damaged data in the same device extent, and so
it unnecessary degrades non-damaged data.

Method (2) is much like device replacing but done in the same device. It is
safe because it keeps the device extent until the replacing finish.
However, extending device replacing is non-trivial. It assumes
"src_dev->physical == dst_dev->physical". Also, the extent mapping
replacing function should be extended to support replacing device extent
position in one device.

Method (3) invokes relocation of the damaged block group, so it is
straightforward to implement. It relocates all the mirrored device extents,
so it is, potentially, a more costly operation than method (1) or (2). But
it relocates only using extents which reduce the total IO size.

Let's apply method (3) for now. In the future, we can extend device-replace
and apply method (2).

For protecting a block group gets relocated multiple time with multiple IO
errors, this commit introduces "relocating_repair" bit to show it's now
relocating to repair IO failures. Also it uses a new kthread
"btrfs-relocating-repair", not to block IO path with relocating process.

This commit also supports repairing in the scrub process.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent_io.c   |  3 ++
 fs/btrfs/scrub.c       |  3 ++
 fs/btrfs/volumes.c     | 71 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h     |  1 +
 5 files changed, 79 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index ccbcf37eae9c..25f67fe24746 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -96,6 +96,7 @@ struct btrfs_block_group {
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
 	unsigned int to_copy:1;
+	unsigned int relocating_repair:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index d26c827f39c6..c11cf531ba86 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2268,6 +2268,9 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
+	if (btrfs_is_zoned(fs_info))
+		return btrfs_repair_one_zone(fs_info, logical);
+
 	bio = btrfs_io_bio_alloc(1);
 	bio->bi_iter.bi_size = 0;
 	map_length = length;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 0e2211b9c810..e6a8df8a8f4f 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -861,6 +861,9 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	have_csum = sblock_to_check->pagev[0]->have_csum;
 	dev = sblock_to_check->pagev[0]->dev;
 
+	if (btrfs_is_zoned(fs_info) && !sctx->is_dev_replace)
+		return btrfs_repair_one_zone(fs_info, logical);
+
 	/*
 	 * We must use GFP_NOFS because the scrub task might be waiting for a
 	 * worker task executing this function and in turn a transaction commit
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 434fc6f758cc..8788dc64ba46 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7984,3 +7984,74 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
 	spin_unlock(&fs_info->swapfile_pins_lock);
 	return node != NULL;
 }
+
+static int relocating_repair_kthread(void *data)
+{
+	struct btrfs_block_group *cache = (struct btrfs_block_group *) data;
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	u64 target;
+	int ret = 0;
+
+	target = cache->start;
+	btrfs_put_block_group(cache);
+
+	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
+		btrfs_info(fs_info,
+			   "zoned: skip relocating block group %llu to repair: EBUSY",
+			   target);
+		return -EBUSY;
+	}
+
+	mutex_lock(&fs_info->delete_unused_bgs_mutex);
+
+	/* Ensure Block Group still exists */
+	cache = btrfs_lookup_block_group(fs_info, target);
+	if (!cache)
+		goto out;
+
+	if (!cache->relocating_repair)
+		goto out;
+
+	ret = btrfs_may_alloc_data_chunk(fs_info, target);
+	if (ret < 0)
+		goto out;
+
+	btrfs_info(fs_info, "zoned: relocating block group %llu to repair IO failure",
+		   target);
+	ret = btrfs_relocate_chunk(fs_info, target);
+
+out:
+	if (cache)
+		btrfs_put_block_group(cache);
+	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+	btrfs_exclop_finish(fs_info);
+
+	return ret;
+}
+
+int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct btrfs_block_group *cache;
+
+	/* Do not attempt to repair in degraded state */
+	if (btrfs_test_opt(fs_info, DEGRADED))
+		return 0;
+
+	cache = btrfs_lookup_block_group(fs_info, logical);
+	if (!cache)
+		return 0;
+
+	spin_lock(&cache->lock);
+	if (cache->relocating_repair) {
+		spin_unlock(&cache->lock);
+		btrfs_put_block_group(cache);
+		return 0;
+	}
+	cache->relocating_repair = 1;
+	spin_unlock(&cache->lock);
+
+	kthread_run(relocating_repair_kthread, cache,
+		    "btrfs-relocating-repair");
+
+	return 0;
+}
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index cff1f7689eac..7c1ad6901791 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -584,5 +584,6 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 #endif
-- 
2.27.0

