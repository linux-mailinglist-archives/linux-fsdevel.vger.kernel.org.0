Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2636085E82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389713AbfHHJcF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:32:05 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59666 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389695AbfHHJcE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256723; x=1596792723;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GkNICqHv3LHdQ3RjvVkkYh7gT17X0jeX8dQZMkj4w0Q=;
  b=Ee+oCqAFgB4BWsFfhs5cDZ5trrBy1fLy9toFvlH6OMKiGgC12akdCc11
   BCoXT3MkuJbFcxy+xauGeU5E6dtdUYzlhW1zyRxVpO3tUx4iCINA70MBr
   axNbB8Pwi00P0YZH82smgyQ2OwMlfvYxhT6Gy5mlO5bF0v4DIZXR1c14O
   V2aophRGhCA67xmQ/0sd4KK673VVoP+S5x0qDeyUcO6Iu0szi0B8b9UAr
   0iLMyiEb8DOS4j9B4R6DcUcSUojRedQTXPe8znvBb1X5LNjac3XvfAoqH
   7hO3LkJFO9DNzSMmKgAMizjEnu2oQgSAchV0P9qZFQ4iG6h6TdlFQjiXv
   Q==;
IronPort-SDR: jGqxPYJAS85KTpvPwcBHZPMoFIEdi14Pa1Xhk//0BCo5H9CKRqN38V4yM54iIVKHTruVcnE5Rm
 4GYpCjKvpRACvoW61mvmp34aC+fogCtEphEVoUaisb2LyfPx+dObTUkMSAMzYwUwMhtZz13s+I
 bVYv+0GV5DKzapQom5TyX9NwcW8fhmxX3cl1EQt3lJblIEhM67UxNQDWzg0X0D8FmY4D0DfZB5
 R6qhB7C0aVNWjGDLFbTmIQKL0lrrddcONipJ3apJ1DCUUCwe5Vy+dQSrqjtabe25xPMJ5vWvYz
 WUE=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363424"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:32:03 +0800
IronPort-SDR: KtTxvZlfBwTq0ciTnNh5HBMx18/8BTkkQTgxEj48PpaaaY6KAKVQ5Ai+ufCVVjbXZwblsZvPN0
 PyJfWvEsVs2KuScYTp2wYctEMOpVbAxQkPBc0uFfDXcG50gvhGE4OqUDZi3NUJgkqtx2UvQ7fg
 uIWs03RANArpJwn2yDwOn6Px827wFT+ZeNDbWPmKlJuDo9rimLabGLp5jPx85xylTmfoGMNAK5
 MKV4USikmE+uKYWP0jmRY+m4pfBiikSPT17yCoysCxHG+X1nJ/DhzaytFFOlcbf+tOtyzlYBoY
 /Em0f9AjrFgzOXQ/UCvOjIyH
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:47 -0700
IronPort-SDR: Bh6p7ibxGijovDG2ZaRxpHOYyzbCO/GbjLLaTbXKMcrgUGmCotY85nV2ZG220M7rTDF+QHA8Sp
 ojnaqjEi4zluY6HuFaCWrkXTrSekemx6/XG9r2HKQktTX9hbqNuLr+hMaNZxwfeVb03W8IVCLD
 IfEuQ/EdUHrMjpJnPurmiv2YQRtUoNTm+dunzs+GVmNGYystmU2L0fn1NN4lILn1XvTftAvnxz
 VCLVgPjq27FVwLVx3lO4XUdNhtgVF1qDoVslcb4DJ8JwInY4WwVDe5MVcZ674OXpiPJqeN1g8T
 QN4=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:32:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 26/27] btrfs: relocate block group to repair IO failure in HMZONED
Date:   Thu,  8 Aug 2019 18:30:37 +0900
Message-Id: <20190808093038.4163421-27-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When btrfs find a checksum error and if the file system has a mirror of the
damaged data, btrfs read the correct data from the mirror and write the
data to damaged blocks. This repairing, however, is against the sequential
write required rule.

We can consider three methods to repair an IO failure in HMZONED mode:
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
"src_dev>physical == dst_dev->physical". Also, the extent mapping replacing
function should be extended to support replacing device extent position in
one device.

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
---
 fs/btrfs/ctree.h     |  1 +
 fs/btrfs/extent_io.c |  3 ++
 fs/btrfs/scrub.c     |  3 ++
 fs/btrfs/volumes.c   | 72 ++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h   |  1 +
 5 files changed, 80 insertions(+)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1282840a2db8..144cf9c13320 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -537,6 +537,7 @@ struct btrfs_block_group_cache {
 	unsigned int removed:1;
 	unsigned int wp_broken:1;
 	unsigned int to_copy:1;
+	unsigned int relocating_repair:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ff963b2214aa..0d3b61606b15 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2187,6 +2187,9 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
+	if (btrfs_fs_incompat(fs_info, HMZONED))
+		return btrfs_repair_one_hmzone(fs_info, logical);
+
 	bio = btrfs_io_bio_alloc(1);
 	bio->bi_iter.bi_size = 0;
 	map_length = length;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 9f3484597338..6dd5fa4ad657 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -861,6 +861,9 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	have_csum = sblock_to_check->pagev[0]->have_csum;
 	dev = sblock_to_check->pagev[0]->dev;
 
+	if (btrfs_fs_incompat(fs_info, HMZONED) && !sctx->is_dev_replace)
+		return btrfs_repair_one_hmzone(fs_info, logical);
+
 	/*
 	 * We must use GFP_NOFS because the scrub task might be waiting for a
 	 * worker task executing this function and in turn a transaction commit
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 07e7528fb23e..20109f20f102 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8006,3 +8006,75 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
 	spin_unlock(&fs_info->swapfile_pins_lock);
 	return node != NULL;
 }
+
+static int relocating_repair_kthread(void *data)
+{
+	struct btrfs_block_group_cache *cache =
+		(struct btrfs_block_group_cache *) data;
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	u64 target;
+	int ret = 0;
+
+	target = cache->key.objectid;
+	btrfs_put_block_group(cache);
+
+	if (test_and_set_bit(BTRFS_FS_EXCL_OP, &fs_info->flags)) {
+		btrfs_info(fs_info,
+			   "skip relocating block group %llu to repair: EBUSY",
+			   target);
+		return -EBUSY;
+	}
+
+	mutex_lock(&fs_info->delete_unused_bgs_mutex);
+
+	/* ensure Block Group still exists */
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
+	btrfs_info(fs_info, "relocating block group %llu to repair IO failure",
+		   target);
+	ret = btrfs_relocate_chunk(fs_info, target);
+
+out:
+	if (cache)
+		btrfs_put_block_group(cache);
+	mutex_unlock(&fs_info->delete_unused_bgs_mutex);
+	clear_bit(BTRFS_FS_EXCL_OP, &fs_info->flags);
+
+	return ret;
+}
+
+int btrfs_repair_one_hmzone(struct btrfs_fs_info *fs_info, u64 logical)
+{
+	struct btrfs_block_group_cache *cache;
+
+	/* do not attempt to repair in degraded state */
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
index 5da1f354db93..ccb139d1f9c4 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -593,5 +593,6 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_repair_one_hmzone(struct btrfs_fs_info *fs_info, u64 logical);
 
 #endif
-- 
2.22.0

