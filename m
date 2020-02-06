Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D460015422C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 11:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728584AbgBFKoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 05:44:44 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:50006 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728556AbgBFKon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:44:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580985882; x=1612521882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wZhhXGMKeReJGrz0aGQnZVe+maRMLAzreVSLwo1NJ6w=;
  b=N2eDPBd42emJveZZ7Mdw2F7+xtvg3H2ek7Xvj9i0dFWNanIPZFtvLGrE
   o3rM/e3Y4GZA52KdoAz7M+/IAtw5OmCPaDaxVYevc5auhi4UxuX6vMY6i
   K5UcbjsE8jGcTbsEQEjA5BOJokHhDXdV8+ZTkrIcmCGa0ADEKrjxao4M4
   y4N/6Dywxiod5UDuKM2YdL8BDcnrVjfej5FxuNxhwGS/Ed3MTUYCmValX
   NQMJRNbLZopbISGgc7KTEppgZUsKmEujq0xl98kIksPhc2sfv57A5lJxS
   QyzgCFgarcS+YSTwQXP3KdqQc28v9q98hbnIAWQFLckCGz72kJWtOcl7a
   w==;
IronPort-SDR: c4YthHZ2nQuvUlHSxo4MiQ8Da6hZMD5FDuI/sDCM3Gbqx1JjT00O283nCxpPrtURiZp0EtanGa
 4/+kqoODRV61qJ7/jPctfpwUoyeLJe9QfLbnE7WDZwjZ8Axb3HP1p4oHBqzAOPmnZQysd3U92K
 UM+9imFeaIexBPrRKY9HAicz4wbpi4zximrfNxlEXHpv4zo3YZw37qU9D594/9v7JQaf2m1/Dk
 6QMaoFKcO/0S3QJren10hjJ7sJ9gXyUDLyTdPu/aeWwp8tuXgMSnz2gPExB3DIRKZNnU1Smbtm
 gsI=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="237209542"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 18:44:42 +0800
IronPort-SDR: I2VorJhqdIi4O5fUw4Z/Ng5yTb6Pq8Ab7zjuUt2/icWqcPNwZbOLT5A5Xu7Wa1Svrks7RX7JHB
 MNeflpcj0ijn5JW2Vn5GTTmcOecm7XlScFgNaBp6ghoG3RKmHkBlr9oJ1jLFakIJDktOCixVnV
 AU+4oD0c9vaEgcIDuLmvg1A7AwZ79ep0YXHKPwt3Zefu/OU2v7xG060usAmqXVWzGatlGhQFnn
 f5JNPcv7HGWAm6NA/wxkY/2sSjMtvluzzlkBgc2Ietc9jiL0/WpSJPec24SrzCc2tRJpPPXLMe
 dYO09kAcSdCb91RuAUvqtjgW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 02:37:42 -0800
IronPort-SDR: rxp3a4TiOlwOnEksuD/ShZxmoTgaR7Q8ozOqFfv9wZQ5JiwnSVVxTzJEczZequ+dr6VJVHBeB+
 oLTcyefCvmChmMSDNwq5UB6DuqJtYMJaXwMMOR0CLRVNKY3ktpRZu5qJRxMzyVewFpynF+mCDa
 YE76iZqQZo/qRSEpEDU+JfWhGw0FPodTVQnuxqgmiUOlxPz/+1HXThJB8OwA4En3mzosgPj/l7
 U0BWQxrcIPPyeOHo5qRHk/1LfWqcKW9UXjYPXXlH5SLAccCH5CjgDEGY+Gw/emYiQfysKYcxhW
 xxQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 06 Feb 2020 02:44:41 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 13/20] btrfs: factor out do_allocation()
Date:   Thu,  6 Feb 2020 19:42:07 +0900
Message-Id: <20200206104214.400857-14-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200206104214.400857-1-naohiro.aota@wdc.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
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
 fs/btrfs/extent-tree.c | 81 +++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 32 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 8124a6461043..d033d537a31d 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3680,6 +3680,41 @@ static int find_free_extent_unclustered(struct btrfs_block_group *bg,
 	return 0;
 }
 
+static int do_allocation_clustered(struct btrfs_block_group *block_group,
+				   struct find_free_extent_ctl *ffe_ctl,
+				   struct btrfs_block_group **bg_ret)
+{
+	struct clustered_alloc_info *clustered = ffe_ctl->alloc_info;
+	int ret;
+
+	/*
+	 * Ok we want to try and use the cluster allocator, so lets look there
+	 */
+	if (clustered->last_ptr && clustered->use_cluster) {
+		ret = find_free_extent_clustered(block_group,
+						 clustered->last_ptr, ffe_ctl,
+						 bg_ret);
+		if (ret >= 0 || ret == -EAGAIN)
+			return ret;
+		/* ret == -ENOENT case falls through */
+	}
+
+	return find_free_extent_unclustered(block_group, clustered->last_ptr,
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
@@ -3952,6 +3987,8 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 	down_read(&space_info->groups_sem);
 	list_for_each_entry(block_group,
 			    &space_info->block_groups[ffe_ctl.index], list) {
+		struct btrfs_block_group *bg_ret;
+
 		/* If the block group is read-only, we can skip it entirely. */
 		if (unlikely(block_group->ro))
 			continue;
@@ -4012,41 +4049,21 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		if (unlikely(block_group->cached == BTRFS_CACHE_ERROR))
 			goto loop;
 
-		/*
-		 * Ok we want to try and use the cluster allocator, so
-		 * lets look there
-		 */
-		if (clustered->last_ptr && clustered->use_cluster) {
-			struct btrfs_block_group *cluster_bg = NULL;
-
-			ret = find_free_extent_clustered(block_group,
-							 clustered->last_ptr,
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
-						   clustered->last_ptr,
-						   &ffe_ctl);
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

