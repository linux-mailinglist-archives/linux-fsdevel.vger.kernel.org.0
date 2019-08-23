Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCFD39ACB7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404336AbfHWKLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47768 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfHWKLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555092; x=1598091092;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FsE4gqf95mAO+bFZo5M2DPXEATDME6q89JF3cIOcjzg=;
  b=G3xbyuqoBdgVy5Th2iehySTz3zVTawqvQqWGEf/9t96yWYRx0uFWR6MN
   rIYzswVvtr2KBkuQihkMuXtuvq4orwkQosVxBohudh2xgPUUwcHG3saYk
   UH5q95SUwttYH5Ys7cvUqIUqi3eBYL/IKpIKtzvby8mVB5j1p7k5lgtOW
   Ig9mcrKbJMw3ry7Lm4sSgp4UvwgIKgp27GoaFoo12sc97+KUBhobnZ03Y
   Mnm6xGPoN3E/EFPKygOjVw420ERAy1nS02tN3y+BjnxGdT2xSPib1gl/4
   bTxG9+bYWf3JNHXfHW6Pi3uuO4dXa1Ix/+gumbG+15D/GS+TzrjbwOPod
   g==;
IronPort-SDR: govh+MOgX2RfwmIipjjnlnapfIoZzwqA2a9UuNx08HVu6LfcMHEilMxO9DpUyE+zb1yQOVQIo3
 bVC5AE+I8FBckOEh89uo3vqH1vbEkqvpGQe6Cvj8ubWBnHXgDmfjfK6tPNPcOsQ885vqbP06we
 +XfHs9Cf1CSSV6suYvur9NjhMTvmeZydCqIkvcX7lq7H1ICLbbxHVteQ9XTcQ+Inlf6y4jqGWA
 KwvftVirjsNgIwRrUlimpbgX3sbcWvOBaLe7hoczwjvRTi6etkpu5t2OQ3NuxhV76hiwuFAWVu
 D0Y=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096247"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:32 +0800
IronPort-SDR: VvR/eEliK1r3wUuswzmX9KV6taNQJuSC3aiHYvz7wbv57RumRqEl0rUMyLPDpc5NnTAhqmrbUC
 viwqHGTBtWKR3i7abMO9Hyqd9Jknyg832LlrGGyUcPsaDeraEdRx0XTJ1emqPbcqsocWJznqHk
 0HO7nqanafZ953G1e4C9kyylXobk/fryphB9P6GVKAt6x/NeUgu2wQXMAOuetL6no8KFmA+fPD
 HA6eWSWAJuq1WDsFgAm76xs9ZljYURHl+ensaBjkUPVTXiMEdgQl/GuMeNY0xzoOAqQupd5dCp
 532aueDQ9/b/taNHvpb2PvW3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:50 -0700
IronPort-SDR: mPQ7Py/iXRg5sKVYvP0dKd4n5vggF1h370Bvrblq0kPaCtuw4ByCq2ROIPhKkyTwMKYkR8xI4c
 RbrqNaOg7Ymp98FosLuT1LxO4vAGXHCym4GmJrDvtwWcac8T8i23Tw0SzXLPePUPqDXeM76mpl
 EVFK/RVeaPCT3Hl/Xc7aOYy19wvt1078jgwwFN0Ws7ubEV/9Qy4n2oZxCg88bZRbzWDcfEWO+x
 iIyGi2PHtHIrY57imMGw4oMZUV3nYPuXh0rkWWZz3ibTezkCopfTyhaS+NGBOVTaB6TgBykwzW
 Q8Y=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:31 -0700
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
Subject: [PATCH v4 11/27] btrfs: make unmirroed BGs readonly only if we have at least one writable BG
Date:   Fri, 23 Aug 2019 19:10:20 +0900
Message-Id: <20190823101036.796932-12-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

If the btrfs volume has mirrored block groups, it unconditionally makes
un-mirrored block groups read only. When we have mirrored block groups, but
don't have writable block groups, this will drop all writable block groups.
So, check if we have at least one writable mirrored block group before
setting un-mirrored block groups read only.

This change is necessary to handle e.g. xfstests btrfs/124 case.

When we mount degraded RAID1 FS and write to it, and then re-mount with
full device, the write pointers of corresponding zones of written BG
differ. We mark such block group as "wp_broken" and make it read only. In
this situation, we only have read only RAID1 BGs because of "wp_broken" and
un-mirrored BGs are also marked read only, because we have RAID1 BGs. As a
result, all the BGs are now read only, so that we cannot even start the
rebalance to fix the situation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 922592e82fb9..0f845cfb2442 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -8134,6 +8134,27 @@ static int check_chunk_block_group_mappings(struct btrfs_fs_info *fs_info)
 	return ret;
 }
 
+/*
+ * have_mirrored_block_group - check if we have at least one writable
+ *                             mirrored Block Group
+ */
+static bool have_mirrored_block_group(struct btrfs_space_info *space_info)
+{
+	struct btrfs_block_group_cache *cache;
+	int i;
+
+	for (i = 0; i < BTRFS_NR_RAID_TYPES; i++) {
+		if (i == BTRFS_RAID_RAID0 || i == BTRFS_RAID_SINGLE)
+			continue;
+		list_for_each_entry(cache, &space_info->block_groups[i],
+				    list) {
+			if (!cache->ro)
+				return true;
+		}
+	}
+	return false;
+}
+
 int btrfs_read_block_groups(struct btrfs_fs_info *info)
 {
 	struct btrfs_path *path;
@@ -8321,6 +8342,10 @@ int btrfs_read_block_groups(struct btrfs_fs_info *info)
 		       BTRFS_BLOCK_GROUP_RAID56_MASK |
 		       BTRFS_BLOCK_GROUP_DUP)))
 			continue;
+
+		if (!have_mirrored_block_group(space_info))
+			continue;
+
 		/*
 		 * avoid allocating from un-mirrored block group if there are
 		 * mirrored block groups.
-- 
2.23.0

