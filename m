Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88DC115423B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgBFKo7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:59 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgBFKo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985896; x=1612521896;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lhtv6ihGzfX/7/zntEdWvO6w4G5PXA356u1a0XhvbjA=;
  b=WINl4W26NjXT867SyVblsZfiuAHCMgc/F3D/GNeQKE3cqAwo73qLMt+5
   B5CgXyhVOh13pgxYkCe+adSwqa82AgyeXY3MMyc1KV3gRzxO/CO5KoIYB
   RG8P5afoX763JOHgzbcK8O+aJpsclLoJDJYtlaX353KR1O0NUxExpMIOd
   dwGQ9YFFnk9f6zbVS8ZP69215qQ+wuxULkcXOSboZN3KyKlBkY8SehzcL
   vKTlfh6qebmdwQI/77WGaFSUteXPv3aissyJ7Y48VppP1ef4N0w0Hgc9a
   As6F1fV27khV4/IIYtyaSMELRxA+D6xVbvIeGjbrEYoAnWIv0628zCcL0
   A==;
IronPort-SDR: Y4Nvp4oBIZnafcrBK7Wue5k6cr+H2BZAXKJMPQkrbX91EikZI2gPT7XJ0o5QhjCfsONB0b8q1j
 +HZl1aJWSxH86F5MrqZudZA1EFXa1wE9zd9qW9WZCfRAG780FICbaeUN9hsntEOjZ3LwKKmUhQ
 kMvxISg9OXhfMhLi4AadfTAxLB4bGkxioW71aqZlVzm1Z4KFU+V5CSVKdjkkefNmU7uR1wHhjv
 ZQuR//MQzFgTCfi1zdrwcF6Ai85qy6/fqiMwYIM2XNKuNKDvHv0A7HdPykp2DhgA9/HwM11RxL
 Y0E=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209577"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:56 +0800
IronPort-SDR: joVIkn3iOjnzKLxDBG6W0N1k7/0zsgf6c9sfrG5jbE/3rkscqFK4V1DZmTp94Mp8PhVL0+LuxC
 48gnsW5dXC63qKzSk3pf10N1e643nAMSwYe0bIAGHd7qEDGDC/Glh168SS8hqctmVvO5OWBAT5
 /CRGhxNobDbw6lrsjT2xAauGo9SO+s98nAhLDEKZqvvq4Bq+aX2ZvKfgktZWwbFpaYI410VHI7
 C8rrKO/e9SlUjrKkOtK9zNCaphCoIXeLz+6ELwkdUJcJ9YzzmVLiFdobZqszNLRi6QB7+jdXvF
 ZTbPYqmmmsfJ+NT0OZtdNC6T
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:56 -0800
IronPort-SDR: Y7R1UO7fYKDK4Pk8Sgk0yMQnt8qVK97JEduly6Rv8Oti7ndZnVeY+XRglCXNXJfKkthsnZe2Lj
 q01x7bX5y5O54DggMAoi5h9+n9FpWNRdmcIgeHKYi12g0ZhH0qhA/X1csqB6k5XR8E4Tw+iDMh
 kWwEE2gEVZBUrnq79j1RaXtKFQuInRAsfAsOLuYs9rZx/9wYADHRsOiCfVl/K+vubL3f0LW7St
 BNv5ZCMO++GZeVep3nobR0HOJ4tyTaSDKj1cOkPi7xlq2vIvEQdwZiMwXRcQcbcaQqxKr2KWs7
 XnE=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:54 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 20/20] btrfs: factor out prepare_allocation()
Date:   Thu,  6 Feb 2020 19:42:14 +0900
Message-Id: <20200206104214.400857-21-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This function finally factor out prepare_allocation() form
find_free_extent(). This function is called before the allocation loop and
a specific allocator function like prepare_allocation_clustered() should
initialize their private information and can set proper hint_byte to
indicate where to start the allocation with.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 131 +++++++++++++++++++++++++----------------
 1 file changed, 79 insertions(+), 52 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 2631ce2e123c..7742786b4675 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3886,6 +3886,82 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	return -ENOSPC;
 }
 
+static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
+					struct find_free_extent_ctl *ffe_ctl,
+					struct btrfs_space_info *space_info,
+					struct btrfs_key *ins)
+{
+	struct clustered_alloc_info *clustered;
+
+	clustered = kzalloc(sizeof(*clustered), GFP_NOFS);
+	if (!clustered)
+		return -ENOMEM;
+	clustered->last_ptr = NULL;
+	clustered->use_cluster = true;
+	clustered->retry_clustered = false;
+	clustered->retry_unclustered = false;
+	ffe_ctl->alloc_info = clustered;
+
+	/*
+	 * If our free space is heavily fragmented we may not be able to make
+	 * big contiguous allocations, so instead of doing the expensive search
+	 * for free space, simply return ENOSPC with our max_extent_size so we
+	 * can go ahead and search for a more manageable chunk.
+	 *
+	 * If our max_extent_size is large enough for our allocation simply
+	 * disable clustering since we will likely not be able to find enough
+	 * space to create a cluster and induce latency trying.
+	 */
+	if (unlikely(space_info->max_extent_size)) {
+		spin_lock(&space_info->lock);
+		if (space_info->max_extent_size &&
+		    ffe_ctl->num_bytes > space_info->max_extent_size) {
+			ins->offset = space_info->max_extent_size;
+			spin_unlock(&space_info->lock);
+			return -ENOSPC;
+		} else if (space_info->max_extent_size) {
+			clustered->use_cluster = false;
+		}
+		spin_unlock(&space_info->lock);
+	}
+
+	clustered->last_ptr = fetch_cluster_info(fs_info, space_info,
+						 &clustered->empty_cluster);
+	if (clustered->last_ptr) {
+		struct btrfs_free_cluster *last_ptr = clustered->last_ptr;
+
+		spin_lock(&last_ptr->lock);
+		if (last_ptr->block_group)
+			ffe_ctl->hint_byte = last_ptr->window_start;
+		if (last_ptr->fragmented) {
+			/*
+			 * We still set window_start so we can keep track of the
+			 * last place we found an allocation to try and save
+			 * some time.
+			 */
+			ffe_ctl->hint_byte = last_ptr->window_start;
+			clustered->use_cluster = false;
+		}
+		spin_unlock(&last_ptr->lock);
+	}
+
+	return 0;
+}
+
+static int prepare_allocation(struct btrfs_fs_info *fs_info,
+			      struct find_free_extent_ctl *ffe_ctl,
+			      struct btrfs_space_info *space_info,
+			      struct btrfs_key *ins)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		return prepare_allocation_clustered(fs_info, ffe_ctl,
+						    space_info, ins);
+	default:
+		BUG();
+	}
+}
+
 /*
  * walks the btree of allocated extents and find a hole of a given size.
  * The key ins is changed to record the hole:
@@ -3921,7 +3997,6 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	struct btrfs_block_group *block_group = NULL;
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
-	struct clustered_alloc_info *clustered = NULL;
 	bool full_search = false;
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
@@ -3950,57 +4025,9 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		return -ENOSPC;
 	}
 
-	clustered = kzalloc(sizeof(*clustered), GFP_NOFS);
-	if (!clustered)
-		return -ENOMEM;
-	clustered->last_ptr = NULL;
-	clustered->use_cluster = true;
-	clustered->retry_clustered = false;
-	clustered->retry_unclustered = false;
-	ffe_ctl.alloc_info = clustered;
-
-	/*
-	 * If our free space is heavily fragmented we may not be able to make
-	 * big contiguous allocations, so instead of doing the expensive search
-	 * for free space, simply return ENOSPC with our max_extent_size so we
-	 * can go ahead and search for a more manageable chunk.
-	 *
-	 * If our max_extent_size is large enough for our allocation simply
-	 * disable clustering since we will likely not be able to find enough
-	 * space to create a cluster and induce latency trying.
-	 */
-	if (unlikely(space_info->max_extent_size)) {
-		spin_lock(&space_info->lock);
-		if (space_info->max_extent_size &&
-		    num_bytes > space_info->max_extent_size) {
-			ins->offset = space_info->max_extent_size;
-			spin_unlock(&space_info->lock);
-			return -ENOSPC;
-		} else if (space_info->max_extent_size) {
-			clustered->use_cluster = false;
-		}
-		spin_unlock(&space_info->lock);
-	}
-
-	clustered->last_ptr = fetch_cluster_info(fs_info, space_info,
-						 &clustered->empty_cluster);
-	if (clustered->last_ptr) {
-		struct btrfs_free_cluster *last_ptr = clustered->last_ptr;
-
-		spin_lock(&last_ptr->lock);
-		if (last_ptr->block_group)
-			ffe_ctl.hint_byte = last_ptr->window_start;
-		if (last_ptr->fragmented) {
-			/*
-			 * We still set window_start so we can keep track of the
-			 * last place we found an allocation to try and save
-			 * some time.
-			 */
-			ffe_ctl.hint_byte = last_ptr->window_start;
-			clustered->use_cluster = false;
-		}
-		spin_unlock(&last_ptr->lock);
-	}
+	ret = prepare_allocation(fs_info, &ffe_ctl, space_info, ins);
+	if (ret < 0)
+		return ret;
 
 	ffe_ctl.search_start = max(ffe_ctl.search_start,
 				   first_logical_byte(fs_info, 0));
-- 
2.25.0

