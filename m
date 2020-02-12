Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0244A15A1C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728389AbgBLHVX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:23 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgBLHVW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492088; x=1613028088;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5IdcOaURlYsqdA8UKxMqeUbogEQ8ynMq18DJFOr9sXg=;
  b=Ffluu8OKUYsvXwhga9pMbi6YiTVEakqX3JX0L+Nd2dZTfGeYdNJETyqx
   V5MRjNvvKqo1EIUqCMRRaRvCLcn2AhgpUD0tBr11P6syMPM0G6vOPAQj9
   dgytZ1td/sRf/inHIpzEwfgiBMhp1Yewi9xRUG0vD6ebGDjP/lolD+F53
   Z0gb0KZHKvFvbU3UAnTIZwFgSsuD1Jtka6qqs1kMiWdEsqNUr6/FmY+yz
   p2lYQu/BqZpes2T7XG21THKt7lwe3bAkimagdejbN7YyNk5eFMhjjXOke
   L8jq0TtOIaux3GDr9I5BcnV2DHU1xAS4KZi7iuy0k2a7x87niLeuDIXys
   w==;
IronPort-SDR: DRUDxoXvm5KxWxclm1KJybZT2qqh75zRbgVPQCnYH2GBvEDQ0Li5CSviHfjjlvypIqEaZ7KlIf
 RlgC4FiQ47+sJYp0eoKnsTrzYp24JDxSpf2Tc62SLsizJV6o8Mq/6+nXp59Ka4nRyQ5L91Iwuu
 mtA772qYqLDYgMkFcuOkeQ4Aaue9NbS+8OcLtXhhVr9FCvwCIx23mWxBfgtUINBZ6GsqxlUE4q
 8HjHv42gjaDSmOJaSAaEUdIC2YRKW9NFqCw9Ly/DsTJ5bsFa6vnjdMs7jmfPCTr1HZk2i19zuA
 tfY=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448930"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:28 +0800
IronPort-SDR: NfWUvDFLu6qV7FlH9Ycz+sQStrn6FHWQxbnsxkZlXasqFAebXueiIyTaxe17rbU7RHigiUwiq5
 kHcdHyCHHKzLbhzqb6MJkwMwyQx07jeb/xoEN6Mhriqdml9kaZ074hj5cLFYcciW8i2a3to5v6
 aKj6D9XecUpkna0EU6D6e/MvZqFPyTfH7O3cQO/NH9MjcnMgBDpLu6iNEwihO9NVPPg3dpwELN
 QTFXW5DheDLR3YPtLvFrd3KMdSjdL4n6SG4ewFYbjHHDZthE4fic/VeXbxpbL3b6M26Vtzv30J
 xDfYFNvHYtpPslSY7FtyvJjP
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:11 -0800
IronPort-SDR: zpv4Yais84UKgy7C6tKbL4j8z3/A2kKNYaBteQ5iPxPbLSfJKgtfphKUgIpSZ5XNSvb03Osl5G
 Fxn/dOZJ82G8gGKo4Ka/5/RXWuO38cZMtd/1ds7uI7QHOmHNgXRyQWbgbV2J7aQYkyKZePcWwe
 aUqvAViuHffEnGsEW5UoN/pNrQzxv5yGpPvzgLrPDJt9wbx9/C4asEitleRo54yZUlzbT4BMzt
 n9Fq1S7Ipj8uPnTtC1cWOfHEwr5OEUiMyNer4fMlBXr9I2m34B3gzcoZvzUXBmQUsH4P3TOOPf
 rWo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:20 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 13/21] btrfs: move vairalbes for clustered allocation into find_free_extent_ctl
Date:   Wed, 12 Feb 2020 16:20:40 +0900
Message-Id: <20200212072048.629856-14-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move "last_ptr" and "use_cluster" into struct find_free_extent_ctl, so that
hook functions for clustered allocator can use these variables.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index b1f52eee24fe..fb62842ff3e6 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3458,6 +3458,8 @@ struct find_free_extent_ctl {
 
 	/* For clustered allocation */
 	u64 empty_cluster;
+	struct btrfs_free_cluster *last_ptr;
+	bool use_cluster;
 
 	bool have_caching_bg;
 	bool orig_have_caching_bg;
@@ -3816,11 +3818,9 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 {
 	int ret = 0;
 	int cache_block_group_error = 0;
-	struct btrfs_free_cluster *last_ptr = NULL;
 	struct btrfs_block_group *block_group = NULL;
 	struct find_free_extent_ctl ffe_ctl = {0};
 	struct btrfs_space_info *space_info;
-	bool use_cluster = true;
 	bool full_search = false;
 
 	WARN_ON(num_bytes < fs_info->sectorsize);
@@ -3829,8 +3829,6 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.empty_size = empty_size;
 	ffe_ctl.flags = flags;
 	ffe_ctl.search_start = 0;
-	ffe_ctl.retry_clustered = false;
-	ffe_ctl.retry_unclustered = false;
 	ffe_ctl.delalloc = delalloc;
 	ffe_ctl.index = btrfs_bg_flags_to_raid_index(flags);
 	ffe_ctl.have_caching_bg = false;
@@ -3839,6 +3837,12 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	ffe_ctl.hint_byte = hint_byte_orig;
 	ffe_ctl.policy = BTRFS_EXTENT_ALLOC_CLUSTERED;
 
+	/* For clustered allocation */
+	ffe_ctl.retry_clustered = false;
+	ffe_ctl.retry_unclustered = false;
+	ffe_ctl.last_ptr = NULL;
+	ffe_ctl.use_cluster = true;
+
 	ins->type = BTRFS_EXTENT_ITEM_KEY;
 	ins->objectid = 0;
 	ins->offset = 0;
@@ -3869,14 +3873,16 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			spin_unlock(&space_info->lock);
 			return -ENOSPC;
 		} else if (space_info->max_extent_size) {
-			use_cluster = false;
+			ffe_ctl.use_cluster = false;
 		}
 		spin_unlock(&space_info->lock);
 	}
 
-	last_ptr = fetch_cluster_info(fs_info, space_info,
-				      &ffe_ctl.empty_cluster);
-	if (last_ptr) {
+	ffe_ctl.last_ptr = fetch_cluster_info(fs_info, space_info,
+					      &ffe_ctl.empty_cluster);
+	if (ffe_ctl.last_ptr) {
+		struct btrfs_free_cluster *last_ptr = ffe_ctl.last_ptr;
+
 		spin_lock(&last_ptr->lock);
 		if (last_ptr->block_group)
 			ffe_ctl.hint_byte = last_ptr->window_start;
@@ -3887,7 +3893,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			 * some time.
 			 */
 			ffe_ctl.hint_byte = last_ptr->window_start;
-			use_cluster = false;
+			ffe_ctl.use_cluster = false;
 		}
 		spin_unlock(&last_ptr->lock);
 	}
@@ -4000,10 +4006,11 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		 * Ok we want to try and use the cluster allocator, so
 		 * lets look there
 		 */
-		if (last_ptr && use_cluster) {
+		if (ffe_ctl.last_ptr && ffe_ctl.use_cluster) {
 			struct btrfs_block_group *cluster_bg = NULL;
 
-			ret = find_free_extent_clustered(block_group, last_ptr,
+			ret = find_free_extent_clustered(block_group,
+							 ffe_ctl.last_ptr,
 							 &ffe_ctl, &cluster_bg);
 
 			if (ret == 0) {
@@ -4021,8 +4028,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 			/* ret == -ENOENT case falls through */
 		}
 
-		ret = find_free_extent_unclustered(block_group, last_ptr,
-						   &ffe_ctl);
+		ret = find_free_extent_unclustered(block_group,
+						   ffe_ctl.last_ptr, &ffe_ctl);
 		if (ret == -EAGAIN)
 			goto have_block_group;
 		else if (ret > 0)
@@ -4071,8 +4078,9 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	}
 	up_read(&space_info->groups_sem);
 
-	ret = find_free_extent_update_loop(fs_info, last_ptr, ins, &ffe_ctl,
-					   full_search, use_cluster);
+	ret = find_free_extent_update_loop(fs_info, ffe_ctl.last_ptr, ins,
+					   &ffe_ctl, full_search,
+					   ffe_ctl.use_cluster);
 	if (ret > 0)
 		goto search;
 
-- 
2.25.0

