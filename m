Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D216E15A1D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 08:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgBLHVa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 02:21:30 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:31635 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbgBLHV2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:21:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581492097; x=1613028097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ab5eMBEpbu7bGdHKONG6/oUFBqo8yqc01K4cqzOTxQI=;
  b=Upyi4n1eQ4sfTnpx0hJIwwYEtRsjEDBiXlIBzJ3+Unt87cj3XT+W7Sh2
   W0FdDAYubT+gZq72B0Z7wniBz0dfgC9FpIdT9F67iiAf5RX0YTNvBP3Gu
   xIF4/H/JNmlbqIocXiYTyVGjH7B7eVFmABYxkJ6sJ8eyGIUv/CnFHxC59
   J1Q0xtGcQieIinGIIkzftavAs0H2p9B43HVdkl292BHxzPOmFU7+jyHTt
   BP3SYi+CbyIV4KJj0VhItGjwrXZNpXfTuX1UZjxDnM4JAIHkCYPvoXkfk
   RSA2k8sE9z3LfQYoyoNwn7q4xQx2y6RvIokquHPUayT5wbvFECf8O2s+U
   A==;
IronPort-SDR: zdEUoMI1kJaR4kDDK3mOW4T8/yHKkUpkz/dFHOyW7OG+PcJJiCOcUrX9bY+eg7i4ztVsWWRcVb
 m3gIFfvGepVU3bMj2rHwR/S3tzAmPGDgUJfirnzjBIj9X+ygVzYyxzRy+uAjyeg20L0LZts37M
 /0GFctAzAAWbaUe5GyFfR9RrC4uyIqG8THnAkbayc72FI65xDDAwzq5PWFDqUr6h9Qu5GSUaTO
 v+7EKS9+ZVt6SyOSl07Q50wCMz7dnX+JQG28CVmvh+jYDyILKn0PzxlJ3vgw1eJ2Ok26Gi2Pt2
 uSM=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="231448940"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 15:21:37 +0800
IronPort-SDR: qScDbLueH7K/K41pJb4kNAe+hUUqEx6a1QiHk+PUhpcNNBcO5N1xvYw/LIc4KBhAuw/Lop6CM+
 T+AScgNvfMFYoLsh1b25xLAP+uAgWX+WG5+6YcYmOnNGekLH0TchWeOXeQT1gr9swmkMUGbcUQ
 EHgoFgHdHyNggvobSYtMsz4WYJOZvWI/b7FkHNbL9ExnJw2GfQOIXwZoFI2ftQ516SnXgZDjif
 APJ0BEM8iiiMlLSx23sh7jdtLcrxSyduQvaSOlJty0rUN1I4zBTREAMrQ8e6DYKmY7sw0B1oBG
 4XuT/PPTz4g3o9HP9hSUnCHu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2020 23:14:17 -0800
IronPort-SDR: 7Oiczw4ygFeEckWSbfLSu2n+WjTqp69FXJ7A/uoWD6j1L/0QzxIPYH397uvq7dUQI2EirV1gFe
 nSHmb1YWtxzHM6cXTOEovCbuqLl/CBnsld2YRpQjYAx4Hx1dSCsp+LZSdOTxAVBX786wA9gbYl
 ZPrzulPB0mUUpBfwaPfDO9icak5HHhEe5o8sVl4dOVmT279C2X2cQKh7Of08w5gcne58QDfMTc
 KRBqdzby+adKpoT714c9bedcXumddV7iy1y4mZoxcolbPXzOxd+tiWGHhyS6Mlw+vyMvafmacr
 ovM=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 11 Feb 2020 23:21:26 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v2 16/21] btrfs: factor out release_block_group()
Date:   Wed, 12 Feb 2020 16:20:43 +0900
Message-Id: <20200212072048.629856-17-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200212072048.629856-1-naohiro.aota@wdc.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out release_block_group() from find_free_extent(). This function is
called when it gives up an allocation from a block group. Each allocation
policy should reset their information for an allocation in the next block
group.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/extent-tree.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/extent-tree.c b/fs/btrfs/extent-tree.c
index 3dee6a385137..276c12392a85 100644
--- a/fs/btrfs/extent-tree.c
+++ b/fs/btrfs/extent-tree.c
@@ -3706,6 +3706,24 @@ static int do_allocation(struct btrfs_block_group *block_group,
 	}
 }
 
+static void release_block_group(struct btrfs_block_group *block_group,
+				struct find_free_extent_ctl *ffe_ctl,
+				int delalloc)
+{
+	switch (ffe_ctl->policy) {
+	case BTRFS_EXTENT_ALLOC_CLUSTERED:
+		ffe_ctl->retry_clustered = false;
+		ffe_ctl->retry_unclustered = false;
+		break;
+	default:
+		BUG();
+	}
+
+	BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
+		ffe_ctl->index);
+	btrfs_release_block_group(block_group, delalloc);
+}
+
 /*
  * Return >0 means caller needs to re-search for free extent
  * Return 0 means we have the needed free extent.
@@ -4083,11 +4101,7 @@ static noinline int find_free_extent(struct btrfs_fs_info *fs_info,
 		btrfs_release_block_group(block_group, delalloc);
 		break;
 loop:
-		ffe_ctl.retry_clustered = false;
-		ffe_ctl.retry_unclustered = false;
-		BUG_ON(btrfs_bg_flags_to_raid_index(block_group->flags) !=
-		       ffe_ctl.index);
-		btrfs_release_block_group(block_group, delalloc);
+		release_block_group(block_group, &ffe_ctl, delalloc);
 		cond_resched();
 	}
 	up_read(&space_info->groups_sem);
-- 
2.25.0

