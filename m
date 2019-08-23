Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9601F9ACD7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404859AbfHWKMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:12:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47806 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404700AbfHWKME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555123; x=1598091123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AUq1nsN94aM5HzeiKOtIYNHIT4ew+qqqiWNTTx8Fu/U=;
  b=n5fYqk4qtcMt+2zx3Cwv0JGq78NzcACuCtueAUXWhMOKHVM5vmM0gzV4
   SJErvmfu1LjeT0HpcPO2kJxCcyYmZbK8qvcIWURzwh7haFM1LoxPzBAJf
   KCrIJcGANdu+hVZ+AAkNUnFG/lKH7PQe5oK3KeWkaqbVl2l13nHfiV2bG
   H2d9d5byKJ3MuAkV+20X/+7PDwBebr4mnBWkOJQVt4QNEzC/xJTME5rL1
   b7n/mjKmSMDwpDnE/mu91sZ1OQf7gtQ3Xswj4dKxXl/b+6jbqaaJnG5Pr
   gjsTKqdzX07SkCYLQiha9/RAoDCEocYp38JzMnNygsyLJIO5fMqzCXXHS
   Q==;
IronPort-SDR: APdAvTVxQjKH+QstQyhtPzogmclpk5Cb7KlYuGbDP9izXTZtqvsEtnVvoBVQy6z4DhuUugJYaA
 ibYjhZ5APg8A7/1ZsYpkYrb7I1vp2cS6LIbmsNR4KL0J1COrGMgG90nxUvo/5k2AQQm6OlbYes
 vHihGhPbYnsQIOD4nx2G/7+wCJWM90vq+Uv0b5DB2szxA+pia2Az3h9O3tsTW7r3UKjmPSt6oo
 0+IzjO/wkNWnVFy++lsx3amXTQcTX3AZHO4QCMHnsF5PwqG4zksXI90SzKK9KXpmVnOdENGBgv
 W5Y=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096283"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:12:03 +0800
IronPort-SDR: gC4Y1jVIVOZDH2sPbGdvv6mZJQnwZckgSvNcBJH5YX8U1EvXmeBOm1O4skE5F6ui2AC1QSt49F
 4p5m2S6cUrW1/abtdAwW24Ka/rebMKhPe5PffhidbgyyyaxBV5qFwbMQecNRejFlCj/pVy5wuX
 4yScShzLd0cqw6mzLvowDh49NkpVwDGeGb7VJ0SPgDsJy4Ij1ciEWuwpWpX666jtlqWlQlXzmQ
 FrCZEiOkLJwItrgIWjM9TPW4N4RGcwnjOWWwaGuUb4fVW3TagT0UBvBwZfZ5bJ1Z5CVdcQ5kRr
 14/C6YVsaE0emRvvEclhVVfL
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:09:21 -0700
IronPort-SDR: DunF0mBUER9MkDFEjWDQ7a4/6cusPx9arHNQ0ARU12mOkVE36bTc2WJgFiMGYW8vjMKv95P32P
 nSL08eC46W9IJp70fIlxFp1xTlKRQ5XsCEEkwwOZT1UNFx6YFkcxty0XmssWa2N8UDyWoDGXso
 1I47wLBBXM/4/GAyjvIbXasuFN3sBoQa9R6xpXl9cDjP6+A9rnMfSHsgIrp2ZDxwQAEY1aGRzO
 ZGVqlY3UPPjl49RZJhCw3Hcu8UK29h8YXF0THSGPeLHXxFmVxyiwbfc42tU+bxJrW2dKw1XAKF
 +Jw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:12:02 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v4 26/27] btrfs: relocate block group to repair IO failure in HMZONED
Date:   Fri, 23 Aug 2019 19:10:35 +0900
Message-Id: <20190823101036.796932-27-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
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
index a353d5901558..8b00798ca3a1 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -536,6 +536,7 @@ struct btrfs_block_group_cache {
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
index 632001aea19e..e34032a438db 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7998,3 +7998,75 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
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
2.23.0

