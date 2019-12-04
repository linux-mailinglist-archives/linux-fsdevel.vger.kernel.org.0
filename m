Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC84B11246B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2019 09:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfLDITv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Dec 2019 03:19:51 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:32774 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfLDITu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Dec 2019 03:19:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1575447590; x=1606983590;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DnnBFlGOLII8ia0sIKHSj+86HBxr5rZC20HX/a86UVA=;
  b=WqiZPK7ym357GLoi3zIjg3uEcKFKe7kvZCpE97jSXAiFdzx5AAU7P4L7
   KpRyAeZ4YEOaaHAmtcwH70Rxi5NDFG+iCLhkSBQZxz/BGfqchYv/iY6Cr
   qHHOHT+q3ZippixmmoWCevVoL6vN1fRsrRCFD5KNGC7W9fpCTaSYqP0c8
   +SjIyttaulMI+luV+vSJP1nAg9iRD0W1wM1/dVboMogtaKnP0VUdOfqN1
   z85Y4AlcRl5BXKtUZtQBS2m+94Yez+FtJqdfVaIZVCJiJ3yDLtyofsBLz
   7EUJOP+xSNt+5v1Ki0Y/UBv1f7rcpcDT80cvxMKqscJQF76NFnOtqd5CS
   w==;
IronPort-SDR: II1ZZiJd97Fl672vvAlXzWwVfIeLNCHsCbAoyZg82Ctr3eM5eVptxh9Ux4ma9RWLAuK99zUCHM
 bZpMsLUvhlykNN4ZJ+HPqleHbOSdkUAiOKcyA2HA92zX0zfolxX02NQAmihzFSoeO9uQxRcrE7
 0xgFMQIAVJjlco7bRkWJz/B4GiI4CBaZ0uOAnkxQ203TI5uSQaJvzU7NUTE/EpCH04p2QrMmcX
 Sr65YOgaOe1eptlXt6XZvQFDI8E8LipbGQ8gUw2BfsTSxfVLOMsBda1i3OlwzDdz5O9rZoHUC9
 C2U=
X-IronPort-AV: E=Sophos;i="5.69,276,1571673600"; 
   d="scan'208";a="125355073"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Dec 2019 16:19:49 +0800
IronPort-SDR: 1NEQmhe0V10gVym5CZPaA9e8Zp8zohqH/uwALDICAf1GHvV4eospv42lBdjGh+ocWbbUccv4Lf
 +lJykOOFw8ijyBryGw7ez8zMLkT5BJONgFipNCDqzOmA8TSSb9zMvPA2hn9+ItQ3VUYe4Pp952
 xfdyHKuZhLIir2AJ2KvIL2AoFvzffE+pHrsyuuX8K9F/NwVUUBlzkgsXVBp3M0eOP1snHtu7+6
 GljU5wxkfixrbDI6//ImroLERtp73xYaWT9eQy1XJ8S2OohxGpTu48FLsXfaTL7dQKFfR3Qsqa
 QGH55MKgIR3HcP2Q8cAxk1/9
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 00:14:14 -0800
IronPort-SDR: XWBAmn9/zfXHOXJoQpUKPdu9JkRCnQ9rYRHAYM7GWN4HXbfRQCR1cuaf1SvaaD8HENB+sHM+Ey
 2OnmajgDNrQdYgD3RefClBlGrjLsUU87dfORZ6xjoJkD9DY605nG2+wsqZumclxn0cjJRIDWgu
 49HJZrlI3iwkoSEHhazFsi0juVYQ7ypfycrFmlOhKtpt7JKE48MDznMeDoZiOeVOkIrXdza89m
 JUsOgyIOkrXCURNTyAPrX09V315nv8F11C5A9PM2hhOCJntkD2udEa9II5NFay1ia2uJAASCOS
 bxo=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Dec 2019 00:19:46 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v5 12/28] btrfs: ensure metadata space available on/after degraded mount in HMZONED
Date:   Wed,  4 Dec 2019 17:17:19 +0900
Message-Id: <20191204081735.852438-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191204081735.852438-1-naohiro.aota@wdc.com>
References: <20191204081735.852438-1-naohiro.aota@wdc.com>
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
 fs/btrfs/hmzoned.h |  6 ++++++
 3 files changed, 60 insertions(+)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index deca9fd70771..7f4c6a92079a 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3246,6 +3246,15 @@ int __cold open_ctree(struct super_block *sb,
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
index 83dc2dc22323..4fd96fd43897 100644
--- a/fs/btrfs/hmzoned.c
+++ b/fs/btrfs/hmzoned.c
@@ -16,6 +16,8 @@
 #include "disk-io.h"
 #include "block-group.h"
 #include "locking.h"
+#include "space-info.h"
+#include "transaction.h"
 
 /* Maximum number of zones to report per blkdev_report_zones() call */
 #define BTRFS_REPORT_NR_ZONES   4096
@@ -1075,3 +1077,46 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 
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
index 4ed985d027cc..8ac758074afd 100644
--- a/fs/btrfs/hmzoned.h
+++ b/fs/btrfs/hmzoned.h
@@ -42,6 +42,7 @@ bool btrfs_check_allocatable_zones(struct btrfs_device *device, u64 pos,
 				   u64 num_bytes);
 void btrfs_calc_zone_unusable(struct btrfs_block_group *cache);
 int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache);
+int btrfs_hmzoned_check_metadata_space(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 static inline int btrfs_get_dev_zone(struct btrfs_device *device, u64 pos,
 				     struct blk_zone *zone)
@@ -97,6 +98,11 @@ static inline int btrfs_load_block_group_zone_info(
 {
 	return 0;
 }
+static inline int btrfs_hmzoned_check_metadata_space(
+	struct btrfs_fs_info *fs_info)
+{
+	return 0;
+}
 #endif
 
 static inline bool btrfs_dev_is_sequential(struct btrfs_device *device, u64 pos)
-- 
2.24.0

