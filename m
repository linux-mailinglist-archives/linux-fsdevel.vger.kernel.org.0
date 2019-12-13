Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCBA811DCFD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbfLMELg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:36 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11924 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbfLMELe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210295; x=1607746295;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2WVE+NOT0Lojntc5rfFT1s+kzoEafV6t/Mrqof4ttQM=;
  b=RLn0UlNqzhmOJi4nmh26BHwXTadUU4/aqF8FzEgK8dFl1feuyuw/VLhQ
   +1C/Bjlh65UXNDfI0yfR+BPDf4YVyIswVvk1WQ904xjXDA8d128E01/iM
   d4e5T7R80BWqyUFQfZ3S3jAy7+SiV9YHBTxd7PX14/4PRQVVNDGp3u0r3
   +kZs+8/+lOjBAGjoOOE0vz9VqFl0/C9G5aCHr/vp0yviIVp1UDzqtRQcP
   5PGzAsfpAgfuwv4pdhTb6VIRsFK8zPsEGmsK1dl+ooCZjWYo+9AJRbZr3
   pXYuzb/z5St/1MetaUlFnj/jpGdx69CfwArhmod65MVuqPS/BR97cnx9W
   g==;
IronPort-SDR: UjVT/+Mec0BKHo7o8TyLXEYFT8JOwqfcVli7rlCz3gcBp9y+RpNNLJVqR+tlCGxQVlufquZpQQ
 Y3zi7gXcuOA1KCuP93CVCz4AQbg1/nikgVFZt6WtnPQoOGD09LayX2+wHtBX+QtQASjVcodff/
 IxFQTzM/wCxP1I5+L/eWZ7XWIufK0dOj+Ye8atB4N4YutmT7VAGbytt1tf3kRfADnrWCYczXPM
 g2BxSC8UBB8f/lWH1wkPKroUx/5EJo0B/CKWnrCOkbYQe9vR6QbYx4oyGu8GZNYnx8cTQrHswM
 BzQ=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860171"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:35 +0800
IronPort-SDR: eeegO+em2mdnHZHb1LLw3mcI0MVhguJf/O9/T2OGNePfbvBC/UZRaBA6x0hf306gL15RfbcgAJ
 wCnP0ZIzo4L1xFdJ4eeEFqrtC2U3fQ8mrmgoOAhJn26VSlFNI3M59M0+oL7nsfKDsaQpxzNg3z
 BIsD/lHYU0U/vQma6nBf0espvyg4/rdlFhONfbGcWD49Ch1p/c6UgA3OF5qFfj2+g4ie8svdcd
 2lFqw37Qbzrtrdr12KLLEhhBv5v+1rRaiwe2Ij0nO3sPchhmQsMzpqimI8OeSJSQ9Qho+fvNhg
 wy1eMDkRK/5h02X3lpk907+2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:06:06 -0800
IronPort-SDR: ia98MyFQWtnW/RKTyqBPlCWhDy3bjVuF59uVe5UsaLgP2kyMvT26hO3GxTF4KxZtnRvEQgtDta
 UjNwVohd1cc54DCQduCw4EShYiRgaw8heXz3nK7plR1WVATudPwS1t0XPXJJJqwO9WG/RLT+Hx
 2ANOclDbs0yD1Ju4QCHbuKhomzxHZHpjv0ULuErr05h8/AGF8fVc3XMcpko3b/ekf2SPBamGf2
 C1w2FwXKFGA/x0oJjaIDA5JMhRf9Wb9k796jl8xjrU3aC19G2B8pVITTFnCuZLe625SYF9mqnc
 9Ik=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:32 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 25/28] btrfs: relocate block group to repair IO failure in HMZONED
Date:   Fri, 13 Dec 2019 13:09:12 +0900
Message-Id: <20191213040915.3502922-26-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
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
index adc9dfd655a6..21801aaa77c2 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7794,3 +7794,74 @@ bool btrfs_pinned_by_swapfile(struct btrfs_fs_info *fs_info, void *ptr)
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

