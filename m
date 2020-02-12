Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E3F15A1CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbgBLHVZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:25 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728393AbgBLHVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492091; x=1613028091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ALKdw1g0vnyk1KH6I6bsOgsw3Sz+oAVi8OEJeF7h2UE=;
  b=gfw3QVe9HG3+ljBhX7ir/OcFpNBTFTWm57Po6+sywKQ28Bv669hRv6Fn
   xOKwp1bILDRreA6AexOVQC4kLKqcey3Ilgs6szOqEzs7Bx3Ry2DIAGWUk
   23YLwtQCkCaSnQSyItEoN8Me56dJuyBkZQ4FxyD/IAfqD+4mZ5ktcRSNp
   ZDPvtyD/79XIW77aRKBj0NcCwQddbSiy1S8h7/jCqibmXILj0Livg/fAn
   euV0yXjCqSbZXRHde1RJyZpJLnrnuOaP18/cs4C/HOi+WwPUuWDVaNzSB
   zCmCneHeUZqV/Wiz/GmxYI5iMPo6ZNXT4TKfKB52iLkcXo25sRHxEaJN6
   Q==;
IronPort-SDR: At7pz/q56MQhNU+qAcXZvaAiwUOyE56dEXvK9wLtIX4iFafANndBw66IngBfx+nRJMusDBpeZG
 vhRzaOy3Xb3BmvaKuz7vCN+/I+GvNdOOU1fisck7EtybbSN5PgpCvNXksEvI8OcHS2oTKRRyuu
 M2xXbqu+rwoQFa+0qVazUvhe/BbdO9p2VfUwDIEZ4OK8btKT1I7xKzTtpCVYx1Z32E7G3vnFlD
 kM/jVdz2lbNgKt8S93Y2cXXDQ96nLU671HgQwdyH6IioL2EO6d/l/cB07RNPtRjf99npl4qv28
 SEQ=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448936"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:31 +0800
IronPort-SDR: nelb7CqGRRPkL4+ly6ippWJ8+J39rs3Bni1qF36nBBxX6X4rFS++lS7l/uw6UXZVSgWaJwlqmZ
 an/y9Aj4QTqpF6dY8ua1hUjssGBE0y0FAgNfksPn3zioCzJd3v7+v8dVzNQWqwzDwvGrAghJtO
 p8dqTU57HRLBEhA4Q1iTEsktJZ+uWivDXPJkdMd5xrplalHmaYyVdKGMCymtCdpVWF7gBJqyqg
 Fn3ElfagURqweuFOgWsUSHGHujqwgOGygMCFlktePI46cLocve/HWPi+loJr9IhCfKD3cb3++/
 tuRHtQt/jkPXLakuYtT+wtaY
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:13 -0800
IronPort-SDR: Lzj6CFUih6WJHH/hxrjY0HUKtcQa+0DdNBidVr6+tgyuaTloLKYkkZSDwl5YR1bzZiPE5DNMRT
 5sDZFaBfMa4uTeKhs9G0GT4PJ1L5V3wb+rqgHb4nZ1IDuCD4fN97bu3erqPeB+Z6kOKUR5tqgs
 kIYkvMo5LK2ekHqckhEybRmLItS22sg/sI/Wdw+5lS05XipdO4iH3EqAQNZOuuc+M5eD9ZZzrc
 88JhXKxmIZY/FXEQyOpzhtELSH8hTgctHiqiDIbQTZHcF4jpWEPseSjVeslP/vG3TR4gSVCGfV
 LdM=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:22 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 14/21] btrfs: factor out do_allocation()
Date:   Wed, 12 Feb 2020 16:20:41 +0900
Message-Id: <20200212072048.629856-15-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out do_allocation() from find_free_extent(). This function do an
actual allocation in a given block group. The ffe_ctl->policy is used to
determine the actual allocator function to use.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 78 +++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 31 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index fb62842ff3e6..f9fadddf0144 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3675,6 +3675,39 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
 	return 0;
 }
 
+static int do_allocation_clustered(struct btrfs_block_group *block_group,
+				   struct find_free_extent_ctl *ffe_ctl,
+				   struct btrfs_block_group **bg_ret)
+{
+	int ret;
+
+	/*
+	 * Ok we want to try and use the cluster allocator, so lets look there
+	 */
+	if (ffe_ctl->last_ptr && ffe_ctl->use_cluster) {
+		ret = find_free_extent_clustered(block_group, ffe_ctl->last_ptr,
+						 ffe_ctl, bg_ret);
+		if (ret >= 0 || ret == -EAGAIN)
+			return ret;
+		/* ret == -ENOENT case falls through */
+	}
+
+	return find_free_extent_unclustered(block_group, ffe_ctl->last_ptr,
+					    ffe_ctl);
+}
+
+static int do_allocation(struct btrfs_block_group *block_group,
+			 struct find_free_extent_ctl *ffe_ctl,
+			 struct btrfs_block_group **bg_ret)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		return do_allocation_clustered(block_group, ffe_ctl, bg_ret);
+	default:
+		BUG();
+	}
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -3942,6 +3975,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	down_read(&space_info->groups_sem);
 	list_for_each_entry(block_group,
 			    &space_info->block_groups[ffe_ctl.index], list) {
+		struct btrfs_block_group *bg_ret;
+
 		/* If the block group is read-only, we can skip it entirely. */
 		if (unlikely(block_group->ro))
 			continue;
@@ -4002,40 +4037,21 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
 			goto loop;
 
-		/*
-		 * Ok we want to try and use the cluster allocator, so
-		 * lets look there
-		 */
-		if (ffe_ctl.last_ptr && ffe_ctl.use_cluster) {
-			struct btrfs_block_group *cluster_bg = NULL;
-
-			ret = find_free_extent_clustered(block_group,
-							 ffe_ctl.last_ptr,
-							 &ffe_ctl, &cluster_bg);
-
-			if (ret == 0) {
-				if (cluster_bg && cluster_bg != block_group) {
-					btrfs_release_block_group(block_group,
-								  delalloc);
-					block_group = cluster_bg;
-				}
-				goto checks;
-			} else if (ret == -EAGAIN) {
-				goto have_block_group;
-			} else if (ret > 0) {
-				goto loop;
+		bg_ret = NULL;
+		ret = do_allocation(block_group, &ffe_ctl, &bg_ret);
+		if (ret == 0) {
+			if (bg_ret && bg_ret != block_group) {
+				btrfs_release_block_group(block_group,
+							  delalloc);
+				block_group = bg_ret;
 			}
-			/* ret == -ENOENT case falls through */
-		}
-
-		ret = find_free_extent_unclustered(block_group,
-						   ffe_ctl.last_ptr, &ffe_ctl);
-		if (ret == -EAGAIN)
+		} else if (ret == -EAGAIN) {
 			goto have_block_group;
-		else if (ret > 0)
+		} else if (ret > 0) {
 			goto loop;
-		/* ret == 0 case falls through */
-checks:
+		}
+
+		/* checks */
 		ffe_ctl.search_start = round_up(ffe_ctl.found_offset,
 					     fs_info->stripesize);
 
-- 
2.25.0

