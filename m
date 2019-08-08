Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88C7B85E64
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 11:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732371AbfHHJbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Aug 2019 05:31:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59650 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732221AbfHHJbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565256696; x=1596792696;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fhlPGqsAtyE6VIkqRIno/wzBJXuUmwFtvXwoT7NL7YM=;
  b=dbmlasohromUUN6Lx+XQgg07dbwUaPz+yVSVR2VeXkOic6qYdKDtAd5l
   J9XJP3NPd4RKO6gtyTPnPu7yTgfvcqA3ZIqOMB/MxrfrElbNTDTFAXsrk
   27v8D+rQooTHoZq+kuzOUPiiWqBg87Tbrp1GnyFeSZRmkgy/4O5kVwmQR
   PwA3r70LoKkCYMUlqcMc5R0nh7ZsQ25RO+Qd5SOYeHJ8ztpObv17Ye1Np
   SsUHQTQsBtaVX6nl+C42RWEnAOnppnO4//wVrroJy3vSXZBG3qaxcWNFB
   QR5mD2VzxXeamVluM6fUQ7n13Sch3WQFo0rlT0/q99Dn9KR2IseqNjKgW
   Q==;
IronPort-SDR: 7XkF2OIZeCtL9sTmOc2cuGQssipZ0H9b1kV1zXf+EN4U8SJjIXfOl63iNX17TUM9zUr2iEjiIF
 KmoWdet8Pg1nTgrmpvN6KEFqISOmriznMm88YWenSshWYd16+JVXzlPr+AlvcpoUyMDmLol7jD
 qNtm5Y1E53usVCHi5f4pimNRzy6s4SfKch1Npzvage+SZA2OLYE/ncm5xkuylEjASnFcsFWtTB
 cF5XkNoLD7sDpj0j2LWlZvgft01DrgrGirHoY6gM/2NseiPyRWCzPapfHO9Ixbyvvk9EHfbyaj
 2Gw=
X-IronPort-AV: E=Sophos;i="5.64,360,1559491200"; 
   d="scan'208";a="115363365"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 08 Aug 2019 17:31:36 +0800
IronPort-SDR: 3Z2i7dstl2d42rPD8blJ+R4Ky9h6jazbfcXeJE9BbIlyZywwhLDND2Zx0aExOxEQmjAd9pGaA4
 IVqaZM7E2yymo6/+TtQkGjQtu9CHK/onJUAZt6mOs8+41wZhgxDryMVKxsl/fsDOVvY0yrkzRx
 M6wgCDNdzyyFxlOZYuAK//M/5UA4HEmvxtDwRk9snf+rMmQJrMjyf3+owVA4BWIPjVC8AaHWty
 xL1lVEErhCRC+GEtA9YLVyIXDsFLoYHvszwJTABV18EDKoBt5h/9k3g9jLb219TrZsyVUFskw2
 xsLdnyodGegUO+L/xgH75FkW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2019 02:29:20 -0700
IronPort-SDR: DFIdTiZWCgwnlQCeP18lJnDT92ZWih7XHyIVIUM+kQxwrX/kBwik9+dmtny0XfG9lTOqnhBarV
 0KNjghfEDuppDfMR0ePGJkZWwGx0wF5/3IC0d96WN90q5PCjlSVLQqLMtjTD4z5PuxLTOQ4w40
 nV5ypx1tJE4TPUfqeLfgpv4BKL0jkZD+w+feyZvIkN9NJN5XB0Cey2txcXRPKWpjFvce+rfjHw
 4JTHLJlyoFwWb85AXQ8Ky3UrSq2PbWu0U6C/ghLABlNrb1EipldLJxawrm9SSY+AYP0Gng5pGQ
 SOg=
Received: from naota.dhcp.fujisawa.hgst.com (HELO naota.fujisawa.hgst.com) ([10.149.53.115])
  by uls-op-cesaip02.wdc.com with ESMTP; 08 Aug 2019 02:31:35 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v3 12/27] btrfs: ensure metadata space available on/after degraded mount in HMZONED
Date:   Thu,  8 Aug 2019 18:30:23 +0900
Message-Id: <20190808093038.4163421-13-naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190808093038.4163421-1-naohiro.aota@wdc.com>
References: <20190808093038.4163421-1-naohiro.aota@wdc.com>
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
index 8854ff2e5fa5..65b3198c6e83 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3287,6 +3287,15 @@ int open_ctree(struct super_block *sb,
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
index 89631f5f01f2..38cc1bbfe118 100644
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
@@ -551,3 +553,46 @@ int btrfs_load_block_group_zone_info(struct btrfs_block_group_cache *cache)
 
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
2.22.0

