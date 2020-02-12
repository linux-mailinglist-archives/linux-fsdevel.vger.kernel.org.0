Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C337F15A1DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbgBLHVj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:39 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbgBLHVi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492112; x=1613028112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NA5Q16mOvtOGxB6peLdverAtcv+FJWEIIZtEwFXx7RI=;
  b=O+JOdcOWK6adUNYgL1Svac5LRURaxml76MyARcOMHR3kJEfaa/32LyRt
   Z4qqjqv2LyiDMvtkKp/xEzt37JRcIWsUCJIC5U4tsNSiv1fn0NS0Ub796
   zoTr6ALeFdaIEJ16/dmdyFRZgJ+T1/ESr4GeS6Hm11XWOE0s9ImxCPef+
   qm0YZkHh9/rLxp+kvNqNK2W7wttxZt8CmZR9jJbBtnQnsQOLpwX3hBRVG
   Q+PneOCPTyVRMgr8gypS6KXt30GdJ+S01dYkDe0eodZ0cmmtwXrBN1PcG
   5htOElfqlG+8WFs6dTezmYM/deJPqs6UntU4O1FMxFA+ljDTEJPCRZ6GR
   Q==;
IronPort-SDR: FX3NRdjAj30K4c8wpJElQjOAom7it4iyARCh7mLfR6/O80yTOtdjEv0eNo/WvXyYKWK0zr3cRU
 JoSmL9SNzhR28skW7Wowm9QDDKXRpn7u3L7kCujtc0LQmRvsNiPaIkNCldGBBsmxhExnRyOdft
 sfncBE4Grbo0xr/BFMMTLWoK0TZoA4EpvW2KKs29JpAijc2hii8YGRINqJi5XrHXHnhtdZsD6m
 bDnGUXXMXlzKYu7ZXTICCYxlFqverx+x9BGWbgxRYjU4cNulIgj1cQAkEDi+tA1blHt5MZ6pMO
 JnI=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448953"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:52 +0800
IronPort-SDR: LuLSIsX3TlJhErSK2gB99RGINiMu2UOnTCcjFzQYJT0ynCYvKQjcoLKq2uIGcAsZtaBqN6aIGt
 BP+OH9qZXhQfYk19BW0cvOXP06vk9sxZMg2vw9v8jIWEAWZ6FXWYzpivjLcjMfhqHenkeQcXxK
 /MAKnvAA+7YzfIWC2HBh28A06CuMNTpwpcB3SSVxXURippqqSi1jKn+5rL5I4N3o6wekzAzYp+
 13BL9j2q7pMK3gpuOPVgZcmIWq22aIhR5y/f1aSS7VZ2c8NM0TEX+F0sxcSvNiGIiphiwtG/Ea
 dgGLI//A1LQhR0Am54fwOcU6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:27 -0800
IronPort-SDR: zTTgfgLwTL7PYR5oXOQCa+XPzHRLNj/E/f6JWvsXcbKTcsrpjPVa5Mtscsx1+xh+LfBnpIDo6y
 UiDR+qLn5r1Aj86XS2ElbnoKx6dm2HhEIIPzbiAiu7B4Ii7B3XNImMPnFvVxPAuyt86StwZ0S5
 cyBnqkKrR4ee4mimBSxrWSfp2N+Uhe0r+29y2vyBIsW1CPUw7k7+atl5pl0s8RNsYmQ0gnrllx
 t+Y35MnTfJm9KxFawWXT6HtuQcGaZX5DF6ovMok27gWkFBGBQ3oXbIgt0f4hF4XTQv70jQSTqi
 ACA=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:36 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 21/21] btrfs: factor out prepare_allocation()
Date:   Wed, 12 Feb 2020 16:20:48 +0900
Message-Id: <20200212072048.629856-22-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
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
 fs/btrfs/extent-tree.c | 110 +++++++++++++++++++++++++----------------
 1 file changed, 68 insertions(+), 42 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3ab0d2f5d718..6da7f6e03767 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3868,6 +3868,71 @@ static int find_free_extent_update_loop(struct btrfs_fs_info *fs_info,
 	return -ENOSPC;
 }
 
+static int prepare_allocation_clustered(struct btrfs_fs_info *fs_info,
+					struct find_free_extent_ctl *ffe_ctl,
+					struct btrfs_space_info *space_info,
+					struct btrfs_key *ins)
+{
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
+			ffe_ctl->use_cluster = false;
+		}
+		spin_unlock(&space_info->lock);
+	}
+
+	ffe_ctl->last_ptr = fetch_cluster_info(fs_info, space_info,
+					       &ffe_ctl->empty_cluster);
+	if (ffe_ctl->last_ptr) {
+		struct btrfs_free_cluster *last_ptr = ffe_ctl->last_ptr;
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
+			ffe_ctl->use_cluster = false;
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
@@ -3937,48 +4002,9 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		return -ENOSPC;
 	}
 
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
-			ffe_ctl.use_cluster = false;
-		}
-		spin_unlock(&space_info->lock);
-	}
-
-	ffe_ctl.last_ptr = fetch_cluster_info(fs_info, space_info,
-					      &ffe_ctl.empty_cluster);
-	if (ffe_ctl.last_ptr) {
-		struct btrfs_free_cluster *last_ptr = ffe_ctl.last_ptr;
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
-			ffe_ctl.use_cluster = false;
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

