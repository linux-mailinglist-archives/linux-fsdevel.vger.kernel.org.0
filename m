Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C45A9ACB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2019 12:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404365AbfHWKLg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Aug 2019 06:11:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:47768 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404360AbfHWKLf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Aug 2019 06:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566555094; x=1598091094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=InzjgJc/CYOES7JhwRz7akPBQj1xH3+trygavvD0iao=;
  b=D/OtmKSu/uJ5PIH28BjUWaxSDvOIhKBpLOG6qfzMXvCgnrvZS2jeqJmC
   /DgTtKAj+0Pt0lYd5Lpr3mig7JYKPegReqhHI+E7qqfX7lhZQH6TaEMiZ
   t4wHZUq0MQIeWFfvg9bDAXu81F5xIUVLUHbyTNOqN1rgy0/xCWFM7OpHm
   GMfV+VnJeOmBV21F+Glt2bd5CXxSJKPwOKzc4qimaSet1K6yVi98oKinW
   IMZt3QoeEvFIgJlVekYcG5BEweGWv77HK2nccz4F2Uu4C2ZU88TE90QGC
   wsVJ6NEMNmxwIt2bmQMG9VArJ3Syr+2tWb8qP6IUKJMaGHIm4uMEp6qbw
   Q==;
IronPort-SDR: nKZxRsKENlSWvLastHfdB8ik39XNrTq9/bmEKCdVWcV9P84rQhWzXYXPAZRhGL9OwLObSTUuuH
 A77oOiduI6je/mDH1EL/fg7nxkQ2/r+wfNfvdbqdtc2B/D2x22cfUa9fBf/mizQEzGwDgWe+bj
 gOKkc5/onmgUE12rj2cRrKH16C4x74otF93FR04wzYEWlJNebyiBXsxnU5xdArfQrMEqoWtECl
 au6d7c36+0a9p3BmeZJNm+isO+97+WuNDAWd0DZNHcltuBencBJPoM/1crGWPEzP9aILA6yXqL
 wtA=
X-IronPort-AV: E=Sophos;i="5.64,420,1559491200"; 
   d="scan'208";a="121096248"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Aug 2019 18:11:34 +0800
IronPort-SDR: Gw7pjyuJpRJjEb6XZZZpFLwqHa+RyIH5O8aFcM5t39SNQHSlbi583xjUWUPO7kutaU87EaV+8V
 CqRG8gbxWquoVcoBHVGPLwk4bLOPMmosgw4oh7yGJwjg9EMXnTATjOyJfSxVIeBMXwLoxPCbyz
 AFe6YYXvPwZyBV3WHzlvs0epcnj1SRAjr5F+RIlPJEdyIRwoPdz9EaYB141JX7Up9faGrXFIH8
 eaUyF5SsMPcpC6as29b/G7Yj4TnikaHXl0ifqegZ7vwVBPRxGcaUEIYZx1xWB3oR4TepJdLe9F
 6luYVG4gnxxYbvAH0t1O3LSB
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 03:08:52 -0700
IronPort-SDR: qhAy7dXUmqUytCo39hN29LNefa/+FPrEabEVN4CK1oyQXzlocvKcc7RmF3YVIaBwTlFhpAwvDa
 FJRxc1WEEsPbrtKH9aJS35nLTkGup0IWatxQTmy5RPt1tS9SmpVMdKT0QYGo6AEOHqK2Gim2g+
 jAIpZSQIZbo0LDEoAWViLhOyuqHHUvvHoyEG6axx4zpKUVttyS4ErEXqX4fpBNCddsriaB7l65
 sBcWAaMVY4Y8b7zv3HxVbvp3p+ZvXcfOMvtVBkDHMTpSWrUmBirbn5XZrKfsGFvaSdSFwq+uLt
 9f8=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 23 Aug 2019 03:11:33 -0700
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
Subject: [PATCH v4 12/27] btrfs: ensure metadata space available on/after degraded mount in HMZONED
Date:   Fri, 23 Aug 2019 19:10:21 +0900
Message-Id: <20190823101036.796932-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190823101036.796932-1-naohiro.aota@wdc.com>
References: <20190823101036.796932-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On/After degraded mount, we might have no writable metadata block group due
to broken write pointers. If you e.g. balance the FS before writing any
data, alloc_tree_block_no_bg_flush() (called from insert_balance_item())
fails to allocate a tree block for it, due to global reservation failure.
We can reproduce this situation with xfstests btrfs/124.

While we can workaround the failure if we write some data and, as a result
of writing, let a new metadata block group allocated, it's a bad practice
to apply.

This commit avoids such failures by ensuring that read-write mounted volume
has non-zero metadata space. If metadata space is empty, it forces new
metadata block group allocation.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/disk-io.c |  9 +++++++++
 fs/btrfs/hmzoned.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 fs/btrfs/hmzoned.h |  1 +
 3 files changed, 55 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3f5ea92f546c..b25cff8af3b7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3285,6 +3285,15 @@ int open_ctree(struct super_block *sb,
 		}
 	}
 
+	ret = btrfs_hmzoned_check_metadata_space(fs_info);
+	if (ret) {
+		btrfs_warn(fs_info, "failed to allocate metadata space: %d",
+			   ret);
+		btrfs_warn(fs_info, "try remount with readonly");
+		close_ctree(fs_info);
+		return ret;
+	}
+
 	down_read(&fs_info->cleanup_work_sem);
 	if ((ret = btrfs_orphan_cleanup(fs_info->fs_root)) ||
 	    (ret = btrfs_orphan_cleanup(fs_info->tree_root))) {
diff --git a/fs/btrfs/hmzoned.c b/fs/btrfs/hmzoned.c
index 55c00410e2f1..b5fd3e280b65 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -13,6 +13,8 @@
 #include "hmzoned.h"
 #include "rcu-string.h"
 #include "disk-io.h"
+#include "space-info.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -548,3 +550,46 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group_cache *cache)
 
 	return ret;
 }
+
+/*
+ * On/After degraded mount, we might have no writable metadata block
+ * group due to broken write pointers. If you e.g. balance the FS
+ * before writing any data, alloc_tree_block_no_bg_flush() (called
+ * from insert_balance_item())fails to allocate a tree block for
+ * it. To avoid such situations, ensure we have some metadata BG here.
+ */
+int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info)
+{
+	struct btrfs_root *root = fs_info->extent_root;
+	struct btrfs_trans_handle *trans;
+	struct btrfs_space_info *info;
+	u64 left;
+	int ret;
+
+	if (!btrfs_fs_incompat(fs_info, HMZONED))
+		return 0;
+
+	info = btrfs_find_space_info(fs_info, BTRFS_BLOCK_GROUP_METADATA);
+	spin_lock(&info->lock);
+	left = info->total_bytes - btrfs_space_info_used(info, true);
+	spin_unlock(&info->lock);
+
+	if (left)
+		return 0;
+
+	trans = btrfs_start_transaction(root, 0);
+	if (IS_ERR(trans))
+		return PTR_ERR(trans);
+
+	mutex_lock(&fs_info->chunk_mutex);
+	ret = btrfs_alloc_chunk(trans, btrfs_metadata_alloc_profile(fs_info));
+	if (ret) {
+		mutex_unlock(&fs_info->chunk_mutex);
+		btrfs_abort_transaction(trans, ret);
+		btrfs_end_transaction(trans);
+		return ret;
+	}
+	mutex_unlock(&fs_info->chunk_mutex);
+
+	return btrfs_commit_transaction(trans);
+}
diff --git a/fs/btrfs/hmzoned.h b/fs/btrfs/hmzoned.h
index 399d9e9543aa..e95139d4c072 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -32,6 +32,7 @@ int btrfs_check_mountopts_hmzoned(struct btrfs_fs_info *info);
 bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 				   u64 num_bytes);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group_cache *cache);
+int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info);
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
 {
-- 
2.23.0

