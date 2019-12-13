Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD0E11DCE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 05:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731949AbfLMELF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 23:11:05 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11904 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731928AbfLMELE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 23:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1576210265; x=1607746265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xv2SsMLe2K0/AdCEEdTMe1viYLi6crAnMKNxS3FDTjM=;
  b=mb5X3w9qkfYJgJtNGTSCEA6q6WIQhe9vnyeBIrW4PuQpcCtYeenBl0Ht
   4ulP8HQ8ZnYpMk0zjO7OwIcOxaNQeIMfDOKj7JsvknE7418IMcUIvJDk7
   JaRq/qgMuNx8zealzzpPNNZEPRK7HZa6l0s3y7A6Opdi1/1aRfovutbRR
   1wvS0pvqajaXf7cTOmc2EZh2DsLiSP8wiwVavWbawWzuL9n+YAXPUg+hr
   yHzGhWKJfVpos7JJqL4u7G/3t+T9ESBpHZvOoCAJDuNseE1EwYdpWyBfN
   I5sw0sXOzt5NLu+hzstes+sD6kNaygDiBOE3Tdvcj4CXJC4mO9MQaT0DM
   g==;
IronPort-SDR: HbivF7wcGbpTZJik02oge+WPME9DsYK8+Va5SmMsp+2G9d/NGpfw+EQ7SvJ1JCkVK8ShTTIINh
 D6H1gbHlHAuIZkUPMMo1GDtLDBf2ck4ucWNkGBHHbuSrzUldYgIA/kGan4DEQuBtmSAVclRGIa
 eq6RG5Li+K9groZBjDnlmt1ARsSqRu/mRbHqz0qLayWlfzhPFXvjET7RN7/x3qAzcH2I8+ZHcj
 lMdJCJx7AV/s6pXk2ydrI8HyrQhqPe6k88jpKIC6Zo/pftMJPXygfxpkjVTqWuWzqNe+DBEv+w
 QH4=
X-IronPort-AV: E=Sophos;i="5.69,308,1571673600"; 
   d="scan'208";a="126860130"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2019 12:11:04 +0800
IronPort-SDR: SHKEx7KWHLgYCeSr5/3RXjTJUHrjuzRmro7wpHBYuydshC9i90OuMQ6c1nWw4zu0Xi3qEjMiE3
 /RGyEQTsjXf92GXf50xZ1BBY8B1gLvQIq4Vl9fta0NZEAqms5nGMZifOHEBcvPUuYTzmcr+nID
 DDqUM/B3meNBdYaaDNm4Xwxv2Ut3g3RbSgeynaTSGjiDN/C0EWlf1KbUEbu1eeEoZBqQRk3ELH
 FzKPTCuUfFMoribYnq3oZNAvBfzDFKMMCy0L59YxLM3qeCMuFkDJ+lRaA4AzIC/9DewJ6VoZGZ
 rVJI6RfSw3B81xSuhguPgB/p
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2019 20:05:36 -0800
IronPort-SDR: G5h1mVBjGadMl1SUULm3W0M2KykB+dXUSiwuBVvqRbUyOwvO/vuqJqjLJOGbX+ouZ47JeH9Uza
 /trh9xQGnWI/tVFhWbmYUbUXslwQRjR/rNXREyLNl0yLuiWMzJbsaIGOr7wn7lc3IzP+ZsQLYO
 Ckts9mRBDi/SbgPWzlGldbFoaqMWxSoZEZWhBoCb6Nh9JHZ5qe1zXf6rnRl6Qqj7FI10CJl196
 VkpRav8fiCTGEvJf3Z91Mkdn+Xz+VKqc5yZGbKFldN18EPOmfoCHdcxvmwExkmtfIEt7cbnobi
 wHQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 12 Dec 2019 20:11:02 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org, Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v6 12/28] btrfs: ensure metadata space available on/after degraded mount in HMZONED
Date:   Fri, 13 Dec 2019 13:08:59 +0900
Message-Id: <20191213040915.3502922-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
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
index b067fa84b9a1..1a2a296e988a 100644
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
@@ -1072,3 +1074,46 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group *cache)
 
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

