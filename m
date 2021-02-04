Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78DC530F0E8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhBDKc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:32:57 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54222 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235581AbhBDKbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434694; x=1643970694;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cWRqAXnT6xrFDfwZO4TMUDgZFvtDQlnl6iNjK9ZIFOQ=;
  b=qZeDUGVgXSgKIqBTF7RpGfaHv2dpqoEV6ntYw6CKxgZneFrhDWpS7DKL
   uE7RSvxhBCHqztQ+GLj58VAOjnkcYuGReEmjWI1bDT0KQB9/gT53SZshg
   cDXlOZd8Dv4hJmHBh4J0ybPsH6dYqD0XVyX99/jnSnqrPhGnWIIbVeIi3
   FAgdMOx3T9isXvA6G6myBoezFoJ7uJ5wDrqXytwHlAawopTVivTM5f4aH
   qQPTtlvg0Xgq1PYDqwDpQETAK/0lWeRZuSzwV8TUsa/IvKZJN69WCiXdi
   mS6Mbw7ylTF10R+nuSbfrfHAUth3srLyW6Mk0mH0cDQmiKzbdzH1xXPrf
   Q==;
IronPort-SDR: qS4Dl8wP38wGpIL4P9UMGgH448ex+HOcaEEkT9jAwv0OxqZDDDDxxWb3anPqDYAItR9psyJPgP
 TAJMVlfeLbiI+mTQsQXRE+pL1Z1serfggr96A5o02ie+u6YRHQg7Z2W8osnNB/RNS8ZMc1+mj4
 ++FHX0p2p9VPoBlrGwS4jHTIf6s3e0DcQRnNPdO4ShUcmaOhr5ECb7QTCMAjlXQOjJfkRJyxu5
 ahxaOmzcFN82FmxognLbv4khWhDTsVLTEbdVWma3QLwXkzwqfhHJbiCv+vgyZWrfzKXyumTkt8
 VfA=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108065"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:46 +0800
IronPort-SDR: jkuipV+Yj8rn5OPyO/t5q3ScwvMFCGvCjn+KBmzeF8aJVhvUqnCeg+GD5gnxnNb+E09jVadgfD
 ROAwUm1j+Zms9cU93tNPDVA8WyCgcP64BsejbuF/DlIQDDeuE1Hx9RsFdtdrACGUwgverryfzo
 rsFc3mTsKWSbq8/TUBDrnns3Qc+vlOiTzLQ/krA31GYcK8I/xZPF1zOV3R7S12F36XJ197nIPC
 nshhNFW8+KcEeqbloGDhcM60s4kB7u+QeyMQuUkSs9Wscy1ojs6fqFqBLgYLMiYmxTW9ORJ6LZ
 TLGveagb61HrZa0Z4aMFxr2G
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:49 -0800
IronPort-SDR: hTxEFEKP73v0hg6fRf5Rfuimx0X2qgt1XkaiVJI3nwx0X2qwXRhHqavSB/4FgpHfNBKam4LGcH
 Iyj3Tk9uxnKaS78WlPpcD2QQNut1IEhegUvUU9ZH1IqDegDJvABODqggzADuw+RToT2zWCziSr
 MtT8Tse9esYrkoWW9xjV8bqltaDRBKoCzDt09W3YCbjutmOpp89Lx8NThhCXMdF3w2rJqWXky7
 nvXHEOlH7qeAg8xFKpOBYSdyKh9UpU1xo1BRK/S6sdwP+V1bwross4VdgKTL9w18UefMOPuVIq
 ea4=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:45 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 37/42] btrfs: zoned: relocate block group to repair IO failure in zoned filesystems
Date:   Thu,  4 Feb 2021 19:22:16 +0900
Message-Id: <e58fefd24be8f6535eefb2e1585a48e0f3d73835.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When btrfs finds a checksum error and if the file system has a mirror of
the damaged data, btrfs read the correct data from the mirror and writes
it to damaged blocks. This however, violates the sequential write
constraints of a zoned block device.

We can consider three methods to repair an IO failure in zoned filesystems:
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

Method (3) invokes relocation of the damaged block group and is
straightforward to implement. It relocates all the mirrored device extents,
so it potentially is a more costly operation than method (1) or (2). But
it relocates only used extents which reduce the total IO size.

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
 fs/btrfs/volumes.c     | 72 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h     |  1 +
 5 files changed, 80 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index d37ee576ac6e..29678426247d 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -96,6 +96,7 @@ struct btrfs_block_group {
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
 	unsigned int to_copy:1;
+	unsigned int relocating_repair:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index ac210cf0956b..32fb5021f353 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2260,6 +2260,9 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
+	if (btrfs_is_zoned(fs_info))
+		return btrfs_repair_one_zone(fs_info, logical);
+
 	bio = btrfs_io_bio_alloc(1);
 	bio->bi_iter.bi_size = 0;
 	map_length = length;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e0c3ec01e324..310fce00fcda 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -857,6 +857,9 @@ static int scrub_handle_errored_block(struct scrub_block *sblock_to_check)
 	have_csum = sblock_to_check->pagev[0]->have_csum;
 	dev = sblock_to_check->pagev[0]->dev;
 
+	if (btrfs_is_zoned(fs_info) && !sctx->is_dev_replace)
+		return btrfs_repair_one_zone(fs_info, logical);
+
 	/*
 	 * We must use GFP_NOFS because the scrub task might be waiting for a
 	 * worker task executing this function and in turn a transaction commit
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 1312b17a6b49..b8fab44394f5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7980,3 +7980,75 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
 	spin_unlock(&fs_info->swapfile_pins_lock);
 	return node != NULL;
 }
+
+static int relocating_repair_kthread(void *data)
+{
+	struct btrfs_block_group *cache = (struct btrfs_block_group *)data;
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
+	/* Ensure block group still exists */
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
+	btrfs_info(fs_info,
+		   "zoned: relocating block group %llu to repair IO failure",
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
index d3bbdb4175df..d4c3e0dd32b8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -599,5 +599,6 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 #endif
-- 
2.30.0

