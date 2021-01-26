Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F89304927
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 20:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbhAZFaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:12 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33033 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732327AbhAZCnq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611629026; x=1643165026;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hGinAuqqruk5A3jSuyaeVywo7gMtxrv8chVgsYCpY/M=;
  b=qyVpRu/NMrO0PQKvsooFi9++zaLCYTZH2KUgmtrpabomHRENRnUzutvg
   dDJwEUjnHvbPxIthilZgT2T0JXVrg2Cu9CgJ6cgNyMgiSnUE4URQp3u2n
   oIIma90rPy35FP16gEwwdKEdIguqQfwDip2wtIFKPgJql67iFMjnHoyeC
   r7k9yKS059Lj6krKwt8AdKGTLkxhkbWzivVYUVuie0PiJfVR8SbMe1pDd
   sSErjZC8eXSq+BsqezFFqaKLub6qojuxpqTVSStdDqjzYN4RnsEZmz5pF
   rPQS/JGo5Wao0AIoLxHnwQ2YFKtovYFj/lsDpqGzVMQXGnEXPO2j0K8dh
   g==;
IronPort-SDR: Eh3aFY2jK0SlFQM3kyZMtsNZ55iPyz7nT/0gdPFKiaa0OK29Dby8dH3C0indgPgGMJnmNF1rxx
 LFvNo8e1QwMJOIqSmjlHyeFhv+VznlxRr8rLjkJA4s0lxvlkSPzC1ZLlDHur5j5jg2iTjo9TWF
 +E5Bege+Oc9bShjmV2ZhA7xMdERpNiPAA9Q1M4CLMUlK72tD2IJH/8BB39jkXdvZmUO8vy4oEQ
 VMD4g9XwdXGm0ZSLsEwy7QDSG+oQBmYhr8M1IlGMN6KmPx/zUXstIpvWBtPQtirnE/0mSWR2QC
 eWs=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483580"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:27:04 +0800
IronPort-SDR: dAlVDl5FLs5dGJe/kAk+FLO4y1+9hbLm5pEig2h4mFzYKQ6NswYORNIq16IRcdAaChrIdNnMR3
 s1KOTjgC3SQsbuXbheo39NcCVvMTmJHsJ2KkG7bynRLRBhlKIIQ/d33XrikdpgyMW//qVq/eeU
 4qU41jOuSm2hoQFw4K0mmzakOcNI7BRqMoZkxjV2XKa3r9ug9raXlgFgOufEjCvVk2tN+wePJX
 9Ye1S8FoC+GuoYo+20THM+BTJXdQLNpW4dR+/mwfIVWI/hwWS+9Nc7mk0le9Io/dCVbAsENm20
 +ct7JLs91sga1FF06sSNSUb/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:31 -0800
IronPort-SDR: IDtNcALwWGUvLFa+j9c7T4VHgPXBkiTNHiGDsNswUcEFw4+fsVxgDGXXyL7kVUZCi8HhPoky96
 dcFRz201jR/R3GpraqNBLwWB6DGQvU26Peo18TRkAeQ1GcOnALCYDYYF/F647GBywq9tPfjrF3
 XBgIL6u9xS4KINIWqJVPgRu1DbJBuASMn1PWh0IylJ0+gOPRAYGAAZsrQlW9KUOt7ny7N/aeZ2
 B8upc1RYXli9zt7kpMDZdVPgLE5E0sGUg/e5NUbVAEpeRoLpbj+aSWsrjOXs9bsG4ZTZnxjADO
 atU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:27:02 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v14 38/42] btrfs: relocate block group to repair IO failure in ZONED
Date:   Tue, 26 Jan 2021 11:25:16 +0900
Message-Id: <09a953f3fc7f068588250ecee58a529f04279df7.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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
index 8de609d1897a..49c7bf78c82e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2259,6 +2259,9 @@ int repair_io_failure(struct btrfs_fs_info *fs_info, u64 ino, u64 start,
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
index a99735dda515..0f6a79e67666 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7990,3 +7990,74 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
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
index 0bcf87a9e594..54f475e0c702 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -597,5 +597,6 @@ void btrfs_scratch_superblocks(struct btrfs_fs_info *fs_info,
 int btrfs_bg_type_to_factor(u64 flags);
 const char *btrfs_bg_type_to_raid_name(u64 flags);
 int btrfs_verify_dev_extents(struct btrfs_fs_info *fs_info);
+int btrfs_repair_one_zone(struct btrfs_fs_info *fs_info, u64 logical);
 
 #endif
-- 
2.27.0

