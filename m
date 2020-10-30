Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D112A0702
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Oct 2020 14:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgJ3Nxa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Oct 2020 09:53:30 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22001 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726917AbgJ3NxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Oct 2020 09:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604066001; x=1635602001;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kR7xRia34JO6vWeAs3GOC4bVK+bGtTOBrgjYr2Od+bk=;
  b=EcC0KBNbDy+yJ9pAFIDjHbUmkkDf12EAppvhkckmxUp/iJZBWZmzvHgu
   8Ri0wwnDVcKCQVdMISuUwvagFbjPA0wlU2jQIM3Afn3stbpyMUOcluCtN
   A3ltYDGtj+gmxIBLsd4xr+TZPtH67FrwmcKQP0C2LGetBOAFMvgT1fDOa
   cW14mRyIBFs9IinQMULDmXVhjKStyhsk49OcTyggpQ4VuNT8+1ukEM2KG
   HIkQVUv78wfxGEMMQ65mheCMAKAvVdhqOcMlOiZkxMqSxsEKaFjeSK5+8
   2laZlYPmMXKxdivahmxLN30HTJ3WdWriwhvxfM/WMMopCiDpdBN0DldGh
   w==;
IronPort-SDR: 0Vft13uaUxpuZOJiYxESJ/frjiyXXtu4IOubIcVw/44PkqrjUo/KCAGfdKGaQVPov8UxVFz5OG
 GE9l7hCK4TmzwtJjxLTBICX5nQvqrAPfbpRlbwgMePds67QFfx1nJJm+c9leVsKNpzXR2nq514
 NUKQNkbrIqqTMsSv3WT3q6D4MdYeoD1GPNDJR0xfGr4LADBfjOC22AkM6IIxQHA7qVXDQb808+
 QIxQoXnjt81iNunxlfBDRHCo3chCtr7rQakJKuTzFLYu0UEyrfqxEo/4bVwx0p52kW3G7KdthB
 eeo=
X-IronPort-AV: E=Sophos;i="5.77,433,1596470400"; 
   d="scan'208";a="155806647"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 30 Oct 2020 21:53:09 +0800
IronPort-SDR: 2RHclDxX4pBTjJmTFNiW0w84bM5pQGucmjyesUoB+WMtW8FWCDRt9FpXjPwBimzDudf1a3fcNk
 87oQQRUkzqLDvsEt+voFRvvBLbn/h0pM1MA/QXbtup3j1KqrajDNqM6fZJGxueQRppAVH+HRKB
 aGU0zz6cQvNn/gFmSda50mK2d2isSwH4jr5/1urZjtV7CbpkvPHKydtHP7F3f6NrrMYxUtxG5x
 Ozspafa42JMMY857QMZwb9xS9yPDOeUa4LqSxKQ5alw/VvqzCwyOnYZ0QNn9M8Xust/unmxqig
 V8H6FdReMq2WSyUsqkxqulFF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2020 06:39:23 -0700
IronPort-SDR: t4Oh7m6BQu0oULl8NoPG4nzbPZaAkt3q2DU8vKIgV7xm0WtNHY1tXtk0vo6CiKQnLswgNyT69z
 1uaQNZkKQ0iq+hSycyzk2LPbXdd0hyGIdQF9/LidfJAGYGSEC0nkbnFjgSxVspVXRN/LTz4fFB
 6i//0tSnAFnd9EUNZnsi9UgzjTSYoqQsc7iyJPSb+k7K/ahFQhoZYRypMVRNWtcfFDl4td6GUj
 2PXvkP+8EjVbjMphI/4D9KDCmREQK46OqQ3wNCGyTCGF7DA65vuS/AFaDLF1UombH7yM6iLuqj
 y9E=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Oct 2020 06:53:08 -0700
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v9 39/41] btrfs: serialize log transaction on ZONED mode
Date:   Fri, 30 Oct 2020 22:51:46 +0900
Message-Id: <e4622b1b8b94de9b4fe379c694f11524c4341bf6.1604065695.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 2/3 patch to enable tree-log on ZONED mode.

Since we can start more than one log transactions per subvolume
simultaneously, nodes from multiple transactions can be allocated
interleaved. Such mixed allocation results in non-sequential writes at the
time of log transaction commit. The nodes of the global log root tree
(fs_info->log_root_tree), also have the same mixed allocation problem.

This patch serializes log transactions by waiting for a committing
transaction when someone tries to start a new transaction, to avoid the
mixed allocation problem. We must also wait for running log transactions
from another subvolume, but there is no easy way to detect which subvolume
root is running a log transaction. So, this patch forbids starting a new
log transaction when other subvolumes already allocated the global log root
tree.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tree-log.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 5f585cf57383..826af2ff4740 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -106,6 +106,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 				       struct btrfs_root *log,
 				       struct btrfs_path *path,
 				       u64 dirid, int del_all);
+static void wait_log_commit(struct btrfs_root *root, int transid);
 
 /*
  * tree logging is a special write ahead log used to make sure that
@@ -140,16 +141,25 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 			   struct btrfs_log_ctx *ctx)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	bool zoned = btrfs_is_zoned(fs_info);
 	int ret = 0;
 
 	mutex_lock(&root->log_mutex);
 
+again:
 	if (root->log_root) {
+		int index = (root->log_transid + 1) % 2;
+
 		if (btrfs_need_log_full_commit(trans)) {
 			ret = -EAGAIN;
 			goto out;
 		}
 
+		if (zoned && atomic_read(&root->log_commit[index])) {
+			wait_log_commit(root, root->log_transid - 1);
+			goto again;
+		}
+
 		if (!root->log_start_pid) {
 			clear_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
 			root->log_start_pid = current->pid;
@@ -158,7 +168,9 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 		}
 	} else {
 		mutex_lock(&fs_info->tree_log_mutex);
-		if (!fs_info->log_root_tree)
+		if (zoned && fs_info->log_root_tree)
+			ret = -EAGAIN;
+		else if (!fs_info->log_root_tree)
 			ret = btrfs_init_log_root_tree(trans, fs_info);
 		mutex_unlock(&fs_info->tree_log_mutex);
 		if (ret)
@@ -193,14 +205,22 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
  */
 static int join_running_log_trans(struct btrfs_root *root)
 {
+	bool zoned = btrfs_is_zoned(root->fs_info);
 	int ret = -ENOENT;
 
 	if (!test_bit(BTRFS_ROOT_HAS_LOG_TREE, &root->state))
 		return ret;
 
 	mutex_lock(&root->log_mutex);
+again:
 	if (root->log_root) {
+		int index = (root->log_transid + 1) % 2;
+
 		ret = 0;
+		if (zoned && atomic_read(&root->log_commit[index])) {
+			wait_log_commit(root, root->log_transid - 1);
+			goto again;
+		}
 		atomic_inc(&root->log_writers);
 	}
 	mutex_unlock(&root->log_mutex);
-- 
2.27.0

