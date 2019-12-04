Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28070112484
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727507AbfLDIUV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:20:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32819 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbfLDIUU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:20:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447621; x=1606983621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7YDA5C6hW2cNPHhVKgDju1HaRknXX7UTMxkQL5jLeSg=;
  b=rv22i6kvHgr28yaLowkqj4U0m+00WwzyYk8kVfI0vA5bJ2CKe7GoXqkK
   g/zTSVuYBo6iGqvc0CLkbhJOuMvLChai1vUNLVf76n93RDC3j6C4+nRyl
   jPfw3PAYLESMAuHJubn0tTd/oLUErShXKVJSzEKbydx58NmgFe0lb4pfK
   dgI1BO2+KAQyz23RVY8dKLOEn7Bh53dKKDXNaBqpqrY3fUvXHPxEaWwnR
   oBisZZjQqTEACakQahBL6kPf7FbR1eBVCUm0UoRmTd4M79V6tih939YOj
   Nb8fQrpt9yDa/el9H/NZIbrPODG0O0M0IoJdgtCwEqMOxhRHE1YOQMSGA
   w==;
IronPort-SDR: wTTlt6anIRNwldZry4RDNq6pngbYxE5cdDZ/39cAvgxZSiidoHOTWzniGebz5l4vHXLzdFQQ/7
 y0oAurrUYm4k4Py9BE+raAB0dZpZ7vlPeRP5+IBdswJ7Ozj3wM7KJaXk5UzeCCzbz3TZB/9FV0
 7zkuMFh/Cc1FHdTtN5MYBJxEdUQeeDXcmvPrzbWhhM7llYiCwLaZbrj0ydjndFLqttFB9Jcs8W
 8RsOvyeYKJKOczJu7MliXlAw7gisoPNLGxiVTpbN50B2ZNuddQsfjk0JZpXqyqqUyBhcewfP9p
 6nk=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355123"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:20:20 +0800
IronPort-SDR: 3+/9/xHHk8xBPEQHW/1vMBvAwYMdxJ0bEh5hsz+42QHzAwpWi69y+sb1oGYoCB71XlmvwU82BP
 JJnvYKZEcx5gmwFdssaY+gZ5uA/Xw1tJmdiBnxvHtBZuKVntCjbJrAVa1C1gdaHpBbhmOt1bwK
 TUp0gJmBSp0EWGNCSU6JqiGR2DakWnIQGbYzz6dGSm4WrqTiPyEs8KN1QJo4KBrC4fuBjvaUgo
 v2gv+r4AchbW4OoLSgRCEsOCedCb4jUKUPRvmVkCUSGyHzmqNXZh9UhJyIVE9uwPoZDIU5h/sl
 uQ77xvnPJY+GBRPTULbhH1/v
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:45 -0800
IronPort-SDR: 6NhCKxt5syV7geitOtlukXLPHUHC4spSPt1XgDCbEphnvQ4b3GgPQKg93GopoCG0b7cmu5lkHB
 7LKdSfmGyZ3DgvOQ4+/PvbkcVQcHuY9K7d35IT+AWIUvQn4V2Ney/awKDafOAnBmN+RRLSGrQW
 kS2lPljbg4y36gmXcy+iNnhJo5fZzdkeBMegmlGq3p3lQxKyXc9HRrBSTN4xIn2jtTJwE0SuAa
 Lf1MdWC0YnibcSANZxfj43ZjI6VOTMhZnjzO7Kbe7VGe1VBOXC1GqNIyxPFozn7JcGYQB/Qk5A
 6Hc=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:20:17 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 25/28] btrfs: relocate block group to repair IO failure in HMZONED
Date:   Wed,  4 Dec 2019 17:17:32 +0900
Message-Id: <20191204081735.852438-26-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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
 fs/btrfs/block-group.h |  1 +
 fs/btrfs/extent_io.c   |  3 ++
 fs/btrfs/scrub.c       |  3 ++
 fs/btrfs/volumes.c     | 71 ++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/volumes.h     |  1 +
 5 files changed, 79 insertions(+)

diff --git a/fs/btrfs/block-group.h b/fs/btrfs/block-group.h
index 323ba01ad8a9..4a5bd87345a1 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -84,6 +84,7 @@ struct btrfs_block_group {
 	unsigned int removed:1;
 	unsigned int wp_broken:1;
 	unsigned int to_copy:1;
+	unsigned int relocating_repair:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 24f7b05e1f4c..83f5e5883723 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2197,6 +2197,9 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
 	ASSERT(!(fs_info->sb->s_flags & SB_RDONLY));
 	BUG_ON(!mirror_num);
 
+	if (btrfs_fs_incompat(fs_info, HMZONED))
+		return btrfs_repair_one_hmzone(fs_info, logical);
+
 	bio = btrfs_io_bio_alloc(1);
 	bio->bi_iter.bi_size = 0;
 	map_length = length;
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index e88f32256ccc..5ed54523f036 100644
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
index c4061b65a38b..f023eb559b89 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7793,3 +7793,74 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
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
+	struct btrfs_block_group *cache;
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
index 70cabe65f72a..e5a2e7fc3a08 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -576,5 +576,6 @@ bool btrfs_check_rw_degradable(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_repair_one_hmzone(struct btrfs_fs_info *fs_info, u64 logical);
 
 #endif
-- 
2.24.0

