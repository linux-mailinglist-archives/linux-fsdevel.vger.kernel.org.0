Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B209330F0A0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235464AbhBDKZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:25:53 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54218 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbhBDKZf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:25:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434334; x=1643970334;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k89HllQgQhDV9Goh6+4HF/2BCilNlOqC3R0cz3qYdpQ=;
  b=oKf/g6pRFuwNEB3Xo88HDQiQvn+M824yQHp43FS4fMw7ZONJ1kQXPqLH
   +rPQHzTJ8ohiHbt9paKzWfDeTMIB5ZE+TF6nc7/MWMvIK2BspyCOcLO77
   rujND2wnZey4fyyWdOKlLd4p+kYsktfFfP4I5k5yUmsxrnsfSooFWomxs
   /TLHLrtQqGTtRaWf5gUG+kjwVlseYGtwBIszMduPx6xYBs1yKTC2Hk7uy
   Dyi71QTsEJ0nw3C5RlamorT9L5+r2K61bEgSTMPPG+D2fsu5csL1Jgo6h
   Aab8fi1pavtTy/R7HjhessTn3s0NehfXz6W2UCPEGrQMhwGeGf2ZDtoji
   g==;
IronPort-SDR: wP+qsawWUx76MeH2ClvmK+VaH5x/yWXs8yXmyfS/6LulKHEo6yGygeufhN4rzRD3NOkzRA8FMg
 MLhI9d32my0uUHyWxFkd5MPWykxZz3p9uv4SwQ+1Tc1JeGbFIG6s8J9COFJ1BQAFoOm3JrJQO3
 BH702kADVwW2b+3qK1OApbuRbM7auSqdkM3lus+jW8U05BXO+gT8BeaHkOCmrQwcA+n7dC23Ff
 MJyxsnTj9jtozO1JRYNLk/HF7ujTr7SWFV1PFmG4XQGdIry8qmQH+Dre09t01qUo2aq73bnZYt
 5HQ=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159107988"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:12 +0800
IronPort-SDR: X0aLQ7GZVEAY6cOBR0+p4+nxECNvJdA44xf8AVbl0b33nIbUmJqEbpJo1HtYdHlgon3xUIUwcN
 VlextXNuBh5WnmY/A8+iWy8f6DTZzEGpIsKeXJG+JWXMoFTZ8YokcM3uhZ3A8rrN42uAuzvfL8
 Pc1WLLH7nSDjccgFAzpIGp5Dka6fzkcWbBvxYAP804C4yKSU+dnp0ZBFkH1lZrdGOx+4DihNG4
 HH13VBaZ1GOvcOPSM42bhYGewqQD+5A1iJcMxejRiqtNd97SHheCaSmtdYOox/RvgVcGaq22Lm
 a+P4bVRbkUotcGG7k0aY9wNt
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:15 -0800
IronPort-SDR: hcU2WxSWHITiNaxQ8kuyfDFAcJ75xgkLuyR2bg2/h7ZZmP3/9o9C5zUw8I/jwe3+kpEOytshbw
 iKR/02D0PPuyqMhaOCTp15QnCRidwYhbq1PcXDfKps1yZzCVSmCDVAZhD5BeoeRCJ3G/SuW/ZC
 QxB6x1nhUzyZI+CNd2ZYxYlF609zevM/VtAKHqdC5l5sIkE/rwIS0ZGWmWBuFtkqRjoceO4G0n
 7x/sN1bW4quaGzT5+fSqKhq6yJgZr2oHNb4Nbyffc6BCi+Ayi+oJvtkEPWNy290DVJPIslUAlF
 aHs=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:11 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Anand Jain <anand.jain@oracle.com>
Subject: [PATCH v15 12/42] btrfs: zoned: calculate allocation offset for conventional zones
Date:   Thu,  4 Feb 2021 19:21:51 +0900
Message-Id: <7761072d41cc3be28575721df50647fb265a871f.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Conventional zones do not have a write pointer, so we cannot use it to
determine the allocation offset for sequential allocation if a block
group contains a conventional zone.

But instead, we can consider the end of the highest addressed extent in the
block group for the allocation offset.

For new block group, we cannot calculate the allocation offset by
consulting the extent tree, because it can cause deadlock by taking extent
buffer lock after chunk mutex, which is already taken in
btrfs_make_block_group(). Since it is a new block group anyways, we can
simply set the allocation offset to 0.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Anand Jain <anand.jain@oracle.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/block-group.c |  4 +-
 fs/btrfs/zoned.c       | 99 +++++++++++++++++++++++++++++++++++++++---
 fs/btrfs/zoned.h       |  4 +-
 3 files changed, 98 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index e6bf728496eb..6d10874189df 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1856,7 +1856,7 @@ static int read_one_block_group(struct btrfs_fs_info *info,
 			goto error;
 	}
 
-	ret = btrfs_load_block_group_zone_info(cache);
+	ret = btrfs_load_block_group_zone_info(cache, false);
 	if (ret) {
 		btrfs_err(info, "zoned: failed to load zone info of bg %llu",
 			  cache->start);
@@ -2150,7 +2150,7 @@ int btrfs_make_block_group(struct btrfs_trans_handle *trans, u64 bytes_used,
 	if (btrfs_fs_compat_ro(fs_info, FREE_SPACE_TREE))
 		cache->needs_free_space = 1;
 
-	ret = btrfs_load_block_group_zone_info(cache);
+	ret = btrfs_load_block_group_zone_info(cache, true);
 	if (ret) {
 		btrfs_put_block_group(cache);
 		return ret;
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index 0a7cd00f405f..b892566a1c93 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -927,7 +927,68 @@ int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size)
 	return 0;
 }
 
-int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
+/*
+ * Calculate an allocation pointer from the extent allocation information
+ * for a block group consist of conventional zones. It is pointed to the
+ * end of the highest addressed extent in the block group as an allocation
+ * offset.
+ */
+static int calculate_alloc_pointer(struct btrfs_block_group *cache,
+				   u64 *offset_ret)
+{
+	struct btrfs_fs_info *fs_info = cache->fs_info;
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_path *path;
+	struct btrfs_key key;
+	struct btrfs_key found_key;
+	int ret;
+	u64 length;
+
+	path = btrfs_alloc_path();
+	if (!path)
+		return -ENOMEM;
+
+	key.objectid = cache->start + cache->length;
+	key.type = 0;
+	key.offset = 0;
+
+	ret = btrfs_search_slot(NULL, root, &key, path, 0, 0);
+	/* We should not find the exact match */
+	if (!ret)
+		ret = -EUCLEAN;
+	if (ret < 0)
+		goto out;
+
+	ret = btrfs_previous_extent_item(root, path, cache->start);
+	if (ret) {
+		if (ret == 1) {
+			ret = 0;
+			*offset_ret = 0;
+		}
+		goto out;
+	}
+
+	btrfs_item_key_to_cpu(path->nodes[0], &found_key, path->slots[0]);
+
+	if (found_key.type == BTRFS_EXTENT_ITEM_KEY)
+		length = found_key.offset;
+	else
+		length = fs_info->nodesize;
+
+	if (!(found_key.objectid >= cache->start &&
+	       found_key.objectid + length <= cache->start + cache->length)) {
+		ret = -EUCLEAN;
+		goto out;
+	}
+	*offset_ret = found_key.objectid + length - cache->start;
+	ret = 0;
+
+out:
+	btrfs_free_path(path);
+	return ret;
+}
+
+int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new)
 {
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	struct extent_map_tree *em_tree = &fs_info->mapping_tree;
@@ -941,6 +1002,7 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	int i;
 	unsigned int nofs_flag;
 	u64 *alloc_offsets = NULL;
+	u64 last_alloc = 0;
 	u32 num_sequential = 0, num_conventional = 0;
 
 	if (!btrfs_is_zoned(fs_info))
@@ -1040,11 +1102,30 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 
 	if (num_conventional > 0) {
 		/*
-		 * Since conventional zones do not have a write pointer, we
-		 * cannot determine alloc_offset from the pointer
+		 * Avoid calling calculate_alloc_pointer() for new BG. It
+		 * is no use for new BG. It must be always 0.
+		 *
+		 * Also, we have a lock chain of extent buffer lock ->
+		 * chunk mutex.  For new BG, this function is called from
+		 * btrfs_make_block_group() which is already taking the
+		 * chunk mutex. Thus, we cannot call
+		 * calculate_alloc_pointer() which takes extent buffer
+		 * locks to avoid deadlock.
 		 */
-		ret = -EINVAL;
-		goto out;
+		if (new) {
+			cache->alloc_offset = 0;
+			goto out;
+		}
+		ret = calculate_alloc_pointer(cache, &last_alloc);
+		if (ret || map->num_stripes == num_conventional) {
+			if (!ret)
+				cache->alloc_offset = last_alloc;
+			else
+				btrfs_err(fs_info,
+			"zoned: failed to determine allocation offset of bg %llu",
+					  cache->start);
+			goto out;
+		}
 	}
 
 	switch (map->type & BTRFS_BLOCK_GROUP_PROFILE_MASK) {
@@ -1066,6 +1147,14 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 	}
 
 out:
+	/* An extent is allocated after the write pointer */
+	if (!ret && num_conventional && last_alloc > cache->alloc_offset) {
+		btrfs_err(fs_info,
+			  "zoned: got wrong write pointer in BG %llu: %llu > %llu",
+			  logical, last_alloc, cache->alloc_offset);
+		ret = -EIO;
+	}
+
 	kfree(alloc_offsets);
 	free_extent_map(em);
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index 4f3152d7b98f..d27db3993e51 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -41,7 +41,7 @@ u64 btrfs_find_allocatable_zones(struct btrfs_device *device, u64 hole_start,
 int btrfs_reset_device_zone(struct btrfs_device *device, u64 physical,
 			    u64 length, u64 *bytes);
 int btrfs_ensure_empty_zones(struct btrfs_device *device, u64 start, u64 size);
-int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
+int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache, bool new);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -118,7 +118,7 @@ static inline int btrfs_ensure_empty_zones(struct btrfs_device *device,
 }
 
 static inline int btrfs_load_block_group_zone_info(
-		struct btrfs_block_group *cache)
+		struct btrfs_block_group *cache, bool new)
 {
 	return 0;
 }
-- 
2.30.0

