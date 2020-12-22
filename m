Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CB12E0528
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgLVDzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:55:54 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46487 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgLVDzx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609352; x=1640145352;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uWYmLnWOdamxjID5lydHll2E47QqruR/bMtIS6iAJPM=;
  b=LWFjTOq8AMJG5yIFvWgo0gWm37emZtedQsqmEweOh1VzfrefKbzn1lr+
   OrpepwMEaMZeAxMW+l5+qLRCkiPAphNt/Sut9ImTFfbALygpgFQpWsXfo
   ihQUvWXmCV/8JW7kQyo272shUdvD5dYZBXR9OlP6m/8EU6B0uoN54ZBDW
   b4sD4d9LAyJBlEkTV0VoAXrm1mgW0HzrF7L43QrxTcV6D9TyevcZThcs1
   z+QIfSJSnrNiLtoeWos4JbJWNIz1d212N1Jvswi5QftIhLwyz3WcZ4zag
   jirzPWdOAgFNeSjcmPqc89QnFuG4JoWi8MeOKeC4rpPItbbjC9Ddq8b9C
   g==;
IronPort-SDR: 7dxtt7GPhz+js+HNN6FOffZFoiCVFjtqv3tf+MI10aoZ13YYUi29EUEC2G6NJzZw2yX1H7057f
 KNFAWHGiwhlZPP7FJtFw5bZDVK0afTzcBR+XgRVCdyv7CJick+ZB1rkzSGpOSh86ay6c9pEKR1
 E6XR9LU5n61PhRgUMgJmBqf1S1V8+P7AqYcpUXcyo2rVvwXwgXIPtdzI87k3SGxDgnmYyL2Q60
 aS16pjP5jUgZlt33jMLu2zA9PslcsY1m0fcDT4adXKS8Xwww3+b0Gdp6OFf3jmN+756Jw7K2BS
 vmk=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193869"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:22 +0800
IronPort-SDR: EE2Susc09gcnVFy2okL/0RpyLV//L2M12RD5btap8GDPXlyl8Wzyfg0wRRtsfUWjOwWA86UsD/
 2SFbFrENjZ9ElXTmJUh+pC1xErfrwoytvDf0s3wrMqvNDaVAJ1ruVjSp7oUcj//XrFQ7VDZ/6N
 QmWhZdXPL67+l8J2XpCDDJbFhNTRIQQt+H7cLiXokfrF2AjBhDLsgGUJSSOYWrvdi2iuhkYxpe
 XXv0ZqN4nEDqnGuZGXYxo7L9oYoTEIoYZIqSRRKB7Vd0RuSfkEEGeWWZGmAWiWlDt9BoswDGnP
 6Bt2gNv2etKc1igwlsK89j5T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:33 -0800
IronPort-SDR: 1LD8xsfpfUIqQlJEUq6f03jeWEWtfiV1nBlZD929juICfOzFDVaNNYVLK5uyVMfGD3LZLdGrYG
 lscTupRuEcQd9Snx5zdJ0zynw7YK1JbBbgC1hHZZ/Nb3WWAdLGl/3ycjb4MNQv7+yS/VgxIcRF
 3mbSOInb53nekBL7XeCowpqqUNC/tPMBiwzJanAt8lih0A+j5lK/v8KE0ss7NaBMlIj1jQbI3+
 QxbolQxU3tfY/2Ys4ttRhdyOlxBV1Cpx51uzqzrJgNj8B41cN3ayTb5E2PtH9A8v6nHqR4mz5H
 nwA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:21 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v11 36/40] btrfs: relocate block group to repair IO failure in ZONED
Date:   Tue, 22 Dec 2020 12:49:29 +0900
Message-Id: <94f8a1c18dea94ae9e1231d7e0e078a0d6546a6e.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
index 3dec66ed36cb..36654bcd2a83 100644
--- a/fs/btrfs/block-group.h
+++ b/fs/btrfs/block-group.h
@@ -96,6 +96,7 @@ struct btrfs_block_group {
 	unsigned int has_caching_ctl:1;
 	unsigned int removed:1;
 	unsigned int to_copy:1;
+	unsigned int relocating_repair:1;
 
 	int disk_cache_state;
 
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 80e5352d8d2c..202f4c3196ed 100644
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
index 2f577f3b1c31..d0c47ef72d46 100644
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
index f1cc8a421580..46be2a3e616c 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -8004,3 +8004,74 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
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
index 4e34830f3e78..9a8ee1a850c8 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -600,5 +600,6 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 #endif
-- 
2.27.0

