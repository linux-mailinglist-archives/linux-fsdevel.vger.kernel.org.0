Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B87FE15422A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgBFKom (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:42 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBFKol (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985880; x=1612521880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AjFIfhr3Yijk4gg0CsrjosAdFdH4aBa0QxyQ8z1GznA=;
  b=qir0KULff0ByulJ0/QxxoPFwnfnHpf3Y+AMVcf6u9tq+PwjSrdvH1hxh
   ZAEBDU5Pl1wnDiv3kmx5QzpGtB1Ub968kum/N9AAyZT0PPe+lJFY/z4xl
   GP0+zjCG1Z2zior9cGV6dqVp25M3XngXvtL6oojGt5ZQz4rdGp5FSHzmB
   sv9HmCx6ivUQFjhdYD4tNZcs5pAw+G7y6FVA/ARPL22msZEZJURuhXO5v
   +PrlcP/xue9AhLwW2nFg5xP1izpYsqoA0kfaIwddotXJLeUj3lXZ0FZB7
   yxHv6nzMzNer9UYtLdgDU+WXWGoI9jGF7rcK7+/CyTxzLQRtdfILVEKhA
   g==;
IronPort-SDR: yhT8uvt0VMeGpA63psYc1g61QzDX/2H9JDuG8D66WCQ2UUf+VtfuNSGsQQyCdrcDuDdzcPV6Gr
 Js+GeGzuaQRGv2Fq3LljRV5rYC6DFHDXEmooYRzEU2sO2GX7geuWJF58bIy/JyP0fwbpdpY2bH
 O7PtG6XcQC10up5cG+W/PArlL950E/I4AhkgRCnILT7WpzsHxhTUsH2UblQ2zuZLGdx8qIpQXc
 25uDVR1YAGK3YDe15NnL4VjuGvN/sohJvGKXhDeT9RtnK+PAPWP2WtPw/EB+jDZNWOh2ptq5mt
 5+8=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209537"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:40 +0800
IronPort-SDR: ZkCrN1sUPqVfQ8qWn0B4nq71GlL9+WQysWxp9oNIkuFWTiGzGhhUE9ueNATQWedNmN0gKq+RHH
 cXSoEGPcZcNBuOnyJPY94KQXRVxbthTkwE48AzhoE2JhM6ZjL13ui1wD2TiTr7usX3y51Dq7uO
 roCvoUf7D8DIgzKYdCOHXIto9WZLd1ibzF061/4YAak85GLrKlF5p0WscYP+cpURZCl0ytfQmd
 iwD7E81UTDC8ux+ySjxFxAD9lwrmh/Rp3AQw9NrnaoL9tfI8HrT3XQ7AePaSAn7eUS17MIDcEW
 aoqDKgOVdcv4F9IcOJcBS3Fo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:40 -0800
IronPort-SDR: M5R9hF5VkgvwhrdFMrPbPfejJ6IzSARkVaXTBbsWRl+b7B7pJQF6KlDMW/E30nnHrzqr+Vp7iI
 YSnApChfZ4QPCo++rpSGO9twLVDdH7qIVH/Sm/JTt2qDwO1tH0K9mDazhthwl3hChzjt8+V2Hj
 4uH3CwfW4fgEjbMupj+vDu9zInUKGwt+3l/mQbI1pP1YvJMFZsXSWJxxkoLb+QZPJJwf3iswo5
 /8ZaOeISHhGSbNsNMYazpQMwXo3U/mFCB3jxQ1+JqDrle16pevhgldLe1ab6zv1hL/IM6nB/lu
 R9M=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:38 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 12/20] btrfs: introduce clustered_alloc_info
Date:   Thu,  6 Feb 2020 19:42:06 +0900
Message-Id: <20200206104214.400857-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Introduce struct clustered_alloc_info to manage parameters related to
clustered allocation. By separating clustered_alloc_info and
find_free_extent_ctl, we can introduce other allocation policy. One can
access per-allocation policy private information from "alloc_info" of
struct find_free_extent_ctl.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 99 +++++++++++++++++++++++++-----------------
 1 file changed, 59 insertions(+), 40 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b1f52eee24fe..8124a6461043 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3456,9 +3456,6 @@ struct find_free_extent_ctl {
 	/* Where to start the search inside the bg */
 	u64 search_start;
 
-	/* For clustered allocation */
-	u64 empty_cluster;
-
 	bool have_caching_bg;
 	bool orig_have_caching_bg;
 
@@ -3470,18 +3467,6 @@ struct find_free_extent_ctl {
 	 */
 	int loop;
 
-	/*
-	 * Whether we're refilling a cluster, if true we need to re-search
-	 * current block group but don't try to refill the cluster again.
-	 */
-	bool retry_clustered;
-
-	/*
-	 * Whether we're updating free space cache, if true we need to re-search
-	 * current block group but don't try updating free space cache again.
-	 */
-	bool retry_unclustered;
-
 	/* If current block group is cached */
 	int cached;
 
@@ -3499,8 +3484,28 @@ struct find_free_extent_ctl {
 
 	/* Allocation policy */
 	enum btrfs_extent_allocation_policy policy;
+	void *alloc_info;
 };
 
+struct clustered_alloc_info {
+	/* For clustered allocation */
+	u64 empty_cluster;
+
+	/*
+	 * Whether we're refilling a cluster, if true we need to re-search
+	 * current block group but don't try to refill the cluster again.
+	 */
+	bool retry_clustered;
+
+	/*
+	 * Whether we're updating free space cache, if true we need to re-search
+	 * current block group but don't try updating free space cache again.
+	 */
+	bool retry_unclustered;
+
+	struct btrfs_free_cluster *last_ptr;
+	bool use_cluster;
+};
 
 /*
  * Helper function for find_free_extent().
@@ -3516,6 +3521,7 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 		struct btrfs_block_group **cluster_bg_ret)
 {
 	struct btrfs_block_group *cluster_bg;
+	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
 	u64 aligned_cluster;
 	u64 offset;
 	int ret;
@@ -3572,7 +3578,7 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 	}
 
 	aligned_cluster = max_t(u64,
-			ffe_ctl->empty_cluster + ffe_ctl->empty_size,
+			clustered->empty_cluster + ffe_ctl->empty_size,
 			bg->full_stripe_len);
 	ret = btrfs_find_space_cluster(bg, last_ptr, ffe_ctl->search_start,
 			ffe_ctl->num_bytes, aligned_cluster);
@@ -3591,12 +3597,12 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
 			return 0;
 		}
 	} else if (!ffe_ctl->cached && ffe_ctl->loop > LOOP_CACHING_NOWAIT &&
-		   !ffe_ctl->retry_clustered) {
+		   !clustered->retry_clustered) {
 		spin_unlock(&last_ptr->refill_lock);
 
-		ffe_ctl->retry_clustered = true;
+		clustered->retry_clustered = true;
 		btrfs_wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
-				ffe_ctl->empty_cluster + ffe_ctl->empty_size);
+				clustered->empty_cluster + ffe_ctl->empty_size);
 		return -EAGAIN;
 	}
 	/*
@@ -3618,6 +3624,7 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
 		struct btrfs_free_cluster *last_ptr,
 		struct find_free_extent_ctl *ffe_ctl)
 {
+	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
 	u64 offset;
 
 	/*
@@ -3636,7 +3643,7 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
 		free_space_ctl = bg->free_space_ctl;
 		spin_lock(&free_space_ctl->tree_lock);
 		if (free_space_ctl->free_space <
-		    ffe_ctl->num_bytes + ffe_ctl->empty_cluster +
+		    ffe_ctl->num_bytes + clustered->empty_cluster +
 		    ffe_ctl->empty_size) {
 			ffe_ctl->total_free_space = max_t(u64,
 					ffe_ctl->total_free_space,
@@ -3660,11 +3667,11 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
 	 * If @retry_unclustered is true then we've already waited on this
 	 * block group once and should move on to the next block group.
 	 */
-	if (!offset && !ffe_ctl->retry_unclustered && !ffe_ctl->cached &&
+	if (!offset && !clustered->retry_unclustered && !ffe_ctl->cached &&
 	    ffe_ctl->loop > LOOP_CACHING_NOWAIT) {
 		btrfs_wait_block_group_cache_progress(bg, ffe_ctl->num_bytes +
 						      ffe_ctl->empty_size);
-		ffe_ctl->retry_unclustered = true;
+		clustered->retry_unclustered = true;
 		return -EAGAIN;
 	} else if (!offset) {
 		return 1;
@@ -3685,6 +3692,7 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 					bool full_search, bool use_cluster)
 {
 	struct btrfs_root *root = fs_info->extent_root;
+	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
 	int ret;
 
 	if ((ffe_ctl->loop == LOOP_CACHING_NOWAIT) &&
@@ -3774,10 +3782,10 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 			 * no empty_cluster.
 			 */
 			if (ffe_ctl->empty_size == 0 &&
-			    ffe_ctl->empty_cluster == 0)
+			    clustered->empty_cluster == 0)
 				return -ENOSPC;
 			ffe_ctl->empty_size = 0;
-			ffe_ctl->empty_cluster = 0;
+			clustered->empty_cluster = 0;
 		}
 		return 1;
 	}
@@ -3816,11 +3824,10 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 {
 	int ret = 0;
 	int cache_block_group_error = 0;
-	struct btrfs_free_cluster *last_ptr = NULL;
 	struct btrfs_block_group *block_group = NULL;
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
-	bool use_cluster = true;
+	struct clustered_alloc_info *clustered = NULL;
 	bool full_search = false;
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
@@ -3829,8 +3836,6 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.empty_size = empty_size;
 	ffe_ctl.flags = flags;
 	ffe_ctl.search_start = 0;
-	ffe_ctl.retry_clustered = false;
-	ffe_ctl.retry_unclustered = false;
 	ffe_ctl.delalloc = delalloc;
 	ffe_ctl.index = btrfs_bg_flags_to_raid_index(flags);
 	ffe_ctl.have_caching_bg = false;
@@ -3851,6 +3856,15 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		return -ENOSPC;
 	}
 
+	clustered = kzalloc(sizeof(*clustered), GFP_NOFS);
+	if (!clustered)
+		return -ENOMEM;
+	clustered->last_ptr = NULL;
+	clustered->use_cluster = true;
+	clustered->retry_clustered = false;
+	clustered->retry_unclustered = false;
+	ffe_ctl.alloc_info = clustered;
+
 	/*
 	 * If our free space is heavily fragmented we may not be able to make
 	 * big contiguous allocations, so instead of doing the expensive search
@@ -3869,14 +3883,16 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			spin_unlock(&space_info->lock);
 			return -ENOSPC;
 		} else if (space_info->max_extent_size) {
-			use_cluster = false;
+			clustered->use_cluster = false;
 		}
 		spin_unlock(&space_info->lock);
 	}
 
-	last_ptr = fetch_cluster_info(fs_info, space_info,
-				      &ffe_ctl.empty_cluster);
-	if (last_ptr) {
+	clustered->last_ptr = fetch_cluster_info(fs_info, space_info,
+						 &clustered->empty_cluster);
+	if (clustered->last_ptr) {
+		struct btrfs_free_cluster *last_ptr = clustered->last_ptr;
+
 		spin_lock(&last_ptr->lock);
 		if (last_ptr->block_group)
 			ffe_ctl.hint_byte = last_ptr->window_start;
@@ -3887,7 +3903,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			 * some time.
 			 */
 			ffe_ctl.hint_byte = last_ptr->window_start;
-			use_cluster = false;
+			clustered->use_cluster = false;
 		}
 		spin_unlock(&last_ptr->lock);
 	}
@@ -4000,10 +4016,11 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		 * Ok we want to try and use the cluster allocator, so
 		 * lets look there
 		 */
-		if (last_ptr && use_cluster) {
+		if (clustered->last_ptr && clustered->use_cluster) {
 			struct btrfs_block_group *cluster_bg = NULL;
 
-			ret = find_free_extent_clustered(block_group, last_ptr,
+			ret = find_free_extent_clustered(block_group,
+							 clustered->last_ptr,
 							 &ffe_ctl, &cluster_bg);
 
 			if (ret == 0) {
@@ -4021,7 +4038,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			/* ret == -ENOENT case falls through */
 		}
 
-		ret = find_free_extent_unclustered(block_group, last_ptr,
+		ret = find_free_extent_unclustered(block_group,
+						   clustered->last_ptr,
 						   &ffe_ctl);
 		if (ret == -EAGAIN)
 			goto have_block_group;
@@ -4062,8 +4080,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		btrfs_release_block_group(block_group, delalloc);
 		break;
 loop:
-		ffe_ctl.retry_clustered = false;
-		ffe_ctl.retry_unclustered = false;
+		clustered->retry_clustered = false;
+		clustered->retry_unclustered = false;
 		BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
 		       ffe_ctl.index);
 		btrfs_release_block_group(block_group, delalloc);
@@ -4071,8 +4089,9 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, last_ptr, ins, &ffe_ctl,
-					   full_search, use_cluster);
+	ret = find_free_extent_update_loop(fs_info, clustered->last_ptr, ins,
+					   &ffe_ctl, full_search,
+					   clustered->use_cluster);
 	if (ret > 0)
 		goto search;
 
-- 
2.25.0

