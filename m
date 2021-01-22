Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A162FFCD5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 07:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbhAVGbh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 01:31:37 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:51117 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbhAVGaW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 01:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611297021; x=1642833021;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GgKvwZ3/MumYs8snuRzyykc3kM4rM9mgurEtkGpvjZY=;
  b=Px0s+AC+7qv+SD2kzBQwyoK77zzqRNiT7nPGDAmaF5vIUfc4nS/x7df+
   aN7HE4UPTfkYUJmYm1mV5NDKkESv2Mg41iQBZfjuTuuJrAqBh+uniP35Q
   aQ0uJPguqOY87iGPIysHxDyH7U/aW2+8YXvATnxKegWvnCHwuBxH/RxYV
   1R78iMGrvOmYVhe5SxBGmTAkTrknKNlNe/UkxOWvxWMPjPW3QiUlFZM8C
   Ddab5y7UJUwtsSG/JiTmYd7EdT4GaNi7zwREK1fHKguVEwg9qkOs0OQlX
   K6+vaO3rUHPKh3zFHrdfjLpRfgNUyBcjifkVTo83QewuLxvY9LdEg2ahO
   A==;
IronPort-SDR: PDLIPAnrlO/8gJaN0rn67QGF9ssOboKqTLYF/EaM5jRtCk/Xlp6rjlOrC7F7TcwP/ZIDk4zeai
 +43yOA0ShVWUxn954+Y9ZBTXtOZ7W4nS0ly3+5BaN1e0fBp/gmcLDBcQi5+pMMaXm0MIeFxgAP
 38tKuwlL2MECUy9jw3UvyYJbeNDYIA1e5jejK8DLcgPpo8zH3qHn+hTLCg4sl443hEdLppKyC+
 l3pzh7wEJIwjZb2vHuTaq0PhKDkakySg2s34L+nDUMeMDV8mkH61WT5FUEFdOu9ZennSE71oiF
 mYk=
X-IronPort-AV: E=Sophos;i="5.79,365,1602518400"; 
   d="scan'208";a="268392102"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jan 2021 14:23:29 +0800
IronPort-SDR: coYYqKq0hGNbfFikCF461wBHhQgzb5Fy7hcR9JA1kRd+P1XzddIZU2OezZRIxdL0slSN3X9mSP
 VbgAxPoDt1n4goSc8oDErNo/TOwPekIr97YoNeolggWc1gcWNnfb9LUn9tSSth9H1StN/Cs0sC
 Jr2rkTzW5+4VxBpJeREXLUQKzJe0v5ogcgIhTjRCp6tGUyovqpZPEk/xXhLwE4X5W26OrgC/b1
 u6jlpiGrEA9UBgVrs+gIXmPWzvdCodz32Zevb3tlPKbe49rB6lploF+H/tyQpIWBLBWRnoIAfL
 Cu4a/kx5fMX994AJXUmkvm7F
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 22:06:01 -0800
IronPort-SDR: Q+TS4J5vqpWVc1i7bymdkhRBPCpnKJjnFkR7k0OxocJx8uqeNdiSfgPie2bJGWEEWNUUJHL+S8
 18pYNfBrILX2lt7QVX5xlcFmwGYLBL5Wd4w0/NI06pRyc6ceF3WxN1X8kdQomIdSYWRI8LGjza
 Mn+kqJfvAXrDRBnpfi5t2gGmfKskkFrUvITSq88Nca+AqguouiouetYAGiXi4GrzExHgZKanZi
 zye3hcwhHT/Zsgc08E9LEx5ukrCprdMlD7Dx03rzqZZXzuC7Tng/3rMu63uSpLTe9vmlbO9C81
 6lY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Jan 2021 22:23:28 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v13 41/42] btrfs: serialize log transaction on ZONED mode
Date:   Fri, 22 Jan 2021 15:21:41 +0900
Message-Id: <dd4d4c4d8678b11c7b7b7529fb9a10c66a92c6f5.1611295439.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611295439.git.naohiro.aota@wdc.com>
References: <cover.1611295439.git.naohiro.aota@wdc.com>
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
 fs/btrfs/tree-log.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 930e752686b4..71a1c0b5bc26 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -105,6 +105,7 @@ static noinline int replay_dir_deletes(struct btrfs_trans_handle *trans,
 				       struct btrfs_root *log,
 				       struct btrfs_path *path,
 				       u64 dirid, int del_all);
+static void wait_log_commit(struct btrfs_root *root, int transid);
 
 /*
  * tree logging is a special write ahead log used to make sure that
@@ -140,6 +141,7 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	struct btrfs_root *tree_root = fs_info->tree_root;
+	const bool zoned = btrfs_is_zoned(fs_info);
 	int ret = 0;
 
 	/*
@@ -160,12 +162,20 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 
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
@@ -173,6 +183,17 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 			set_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
 		}
 	} else {
+		if (zoned) {
+			mutex_lock(&fs_info->tree_log_mutex);
+			if (fs_info->log_root_tree)
+				ret = -EAGAIN;
+			else
+				ret = btrfs_init_log_root_tree(trans, fs_info);
+			mutex_unlock(&fs_info->tree_log_mutex);
+		}
+		if (ret)
+			goto out;
+
 		ret = btrfs_add_log_tree(trans, root);
 		if (ret)
 			goto out;
@@ -201,14 +222,22 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
  */
 static int join_running_log_trans(struct btrfs_root *root)
 {
+	const bool zoned = btrfs_is_zoned(root->fs_info);
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

