Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEA3215A1CD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgBLHV1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:27 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbgBLHV0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492094; x=1613028094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cIniir5NeVAmApm64cpfERWg0YOxxnYhokCRgXfvWFQ=;
  b=YS2EDDlu3LiU5327PRFe/hDaRidzaUi5ITEzQd/YV/2v1lzQyJLrUhZF
   YKxsA510obRPnnAlY0uA8wG5RUhjnMmbpFYQvQbS2+JWSh+4hl5YjxHTr
   eaIiZv1cZzJfa2qemcy70DObpGGZrZToP3eYTNpyHJlIRPUQY5N8EnXQ2
   H2YR4oBL6UGIQn2P+Q17elhDW2tQaONL/AoXReBULYxemMGv4Oge7y4di
   RXnkuQOtBxb74KjmdI+H50eS4KLamK2qeSrtLc93KrN31qm9BaDlUf79z
   OPQhU8z1ATFeIFhmruM86M1EGU475ixuWblx3t5JLnnQXUQYXCb9Pxtef
   w==;
IronPort-SDR: zdr0EEBE6ygG9vV+n+CXdZd1EsSqxH0UxFOPEEQA/Fa8kBlFxy4rpeECLq4iiBBoOXaGi5FL1+
 lPwKaUlW4sjtzE2/FpjozOPsoTA9EV0Ev1rUVVn5P8wVd+YkgMomzFEhc6CNo4ctHoahrqo7UT
 Aq7YG7MFRqZskkiWKwKFZsQMEHwUrLfY7NBqoGH6ZlnaurbEQKrhRMHGy2sxJqAmwJEhOWxosi
 O+8NQNhsZkf+ueaTdXYRM41AOb39+SQOSohG9cSJySOCpYYx7SLOVI/4qV1hkHA89HAhT6SLAF
 C9Y=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448937"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:34 +0800
IronPort-SDR: PVQsyjvaj+v69lvOC6yYB6XHLe2HPEl3Cke14ukChngi3v5xypE7tTSasxCPhBxiybVmwoK/Ka
 veRnvhfytK7m9fxGjl3TZYhhi2bZGYWH+Makv532dQ+Snm4mqdTBWj1KG8Zs1en3RcH8jTNN3D
 FmbBsqQRrwMibOAjugOvylb/MTOCEd+OnTegiP+egdyRpPgKdCSRI3vV9fjFQY8uRsg1mEIW2q
 VuchP7KZy22S3XsDtnIRjuBpaETESe4rtvV3yU0mEWtWGC6I3Qk4n/TQg06+LX6VVQmV0Cm6Sb
 paXIffWf9+r4Z3oJbHF2R55V
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:15 -0800
IronPort-SDR: hpjQu7D3QiwrAqhB3iN8bnlk1uaJx25PLwADmKhRQTtoI7MczlUk802Bg4EP1iMn2Zt3JdHCsC
 bCMzT/FMQKlFVykk7rjEx0ww9Ml4W3ss1+ohyey6+hJwUXeBdxJd2NFDneXss+GvNTcM0yP+SF
 /8zLTiUpX/zIfYH26wo7+2/9qnX3TwGE0h8Pu/UhAjaBrz1YSRkpucL24nhQgO5TMdUOwtYjMS
 Y/moHZKucAYcgvwaJvgHLXL/h8nfKhZfKGlL2NOD22lUZMy2PhTNhJQ9SBD1H5xkIgsCFJisPM
 yp4=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:24 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 15/21] btrfs: drop unnecessary arguments from clustered allocation functions
Date:   Wed, 12 Feb 2020 16:20:42 +0900
Message-Id: <20200212072048.629856-16-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that, find_free_extent_clustered() and find_free_extent_unclustered()
can access "last_ptr" from the "clustered" variable. So, we can drop it
from the arguments.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index f9fadddf0144..3dee6a385137 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3513,11 +3513,11 @@ struct find_free_extent_ctl {
  * Return 0 means we have found a location and set ffe_ctl->found_offset.
  */
 static int find_free_extent_clustered(struct btrfs_block_group *bg,
-		struct btrfs_free_cluster *last_ptr,
-		struct find_free_extent_ctl *ffe_ctl,
-		struct btrfs_block_group **cluster_bg_ret)
+				      struct find_free_extent_ctl *ffe_ctl,
+				      struct btrfs_block_group **cluster_bg_ret)
 {
 	struct btrfs_block_group *cluster_bg;
+	struct btrfs_free_cluster *last_ptr = ffe_ctl->last_ptr;
 	u64 aligned_cluster;
 	u64 offset;
 	int ret;
@@ -3617,9 +3617,9 @@ static int find_free_extent_clustered(struct btrfs_block_group *bg,
  * Return -EAGAIN to inform caller that we need to re-search this block group
  */
 static int find_free_extent_unclustered(struct btrfs_block_group *bg,
-		struct btrfs_free_cluster *last_ptr,
-		struct find_free_extent_ctl *ffe_ctl)
+					struct find_free_extent_ctl *ffe_ctl)
 {
+	struct btrfs_free_cluster *last_ptr = ffe_ctl->last_ptr;
 	u64 offset;
 
 	/*
@@ -3685,15 +3685,13 @@ static int do_allocation_clustered(struct btrfs_block_group *block_group,
 	 * Ok we want to try and use the cluster allocator, so lets look there
 	 */
 	if (ffe_ctl->last_ptr && ffe_ctl->use_cluster) {
-		ret = find_free_extent_clustered(block_group, ffe_ctl->last_ptr,
-						 ffe_ctl, bg_ret);
+		ret = find_free_extent_clustered(block_group, ffe_ctl, bg_ret);
 		if (ret >= 0 || ret == -EAGAIN)
 			return ret;
 		/* ret == -ENOENT case falls through */
 	}
 
-	return find_free_extent_unclustered(block_group, ffe_ctl->last_ptr,
-					    ffe_ctl);
+	return find_free_extent_unclustered(block_group, ffe_ctl);
 }
 
 static int do_allocation(struct btrfs_block_group *block_group,
-- 
2.25.0

