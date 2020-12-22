Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3092E052E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Dec 2020 04:57:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgLVD4G (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Dec 2020 22:56:06 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:46443 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgLVD4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Dec 2020 22:56:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1608609365; x=1640145365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FoJH1O+Cnxcff/7nmcL2tOpoaJhBp0OwvJmRlFfChiw=;
  b=IHj6mqtVw1nSdFn1sClSl5gY4F3yYt94gTsO6+hWzL5DuXBF73jvNF6u
   VgT8snicpG8wcAz43cAJ1Od81Wrl1pPwITvYWAVsA9G3HadNhdgbFDGTI
   BZaYxF1n63m9YNr6EwZBTDNGpfP6uLowEfRJQNrSHiSrs5BRAp9/NkJs7
   TSrzPoKmCfRJ/bkodZYgwV4rCElKd/d7fcngLP+hbgErRWCeB8kzBM9BN
   V/SnxCRapoc+x88Op8s/J0OQ/v6VZ3DqQryvBo3Q3FO0QJ6LGJBbdiOKb
   NGzN0Hu4rAa/HQv/3pqutQHT5sa0tzH87lTexwZDmuiZipea8jlZ/GImu
   A==;
IronPort-SDR: kgPkdyswlQ36hLn1z6Hu6krO9PKBpSfuJwg3+rL1jl/y008Kq8YGKQQkRJC1q/vKKDelPq68cX
 zj0Mq9jM6i9u8yvegt4+ZYxSHMl9PdjnowN2azhn4gPpjm9boivGumNWrYKiUMo5orHX1hv0EI
 Tpk92dfDiIroupn4lpo+ZMQOhINLgo3DT4dWHTxXwo2BU0tHtTgXau+GjYDKfymN/fIXHzaClc
 LGoZZ657yE8Ncnxv8Is3LUxtsOCRF0Z+NECs7i90sfXxB/uw1At7pw4TA9dWH+X59t4EL4jAfu
 YVg=
X-IronPort-AV: E=Sophos;i="5.78,438,1599494400"; 
   d="scan'208";a="160193887"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Dec 2020 11:51:27 +0800
IronPort-SDR: lxkCZ6bRvNab6cOvb0+ZpSOUTJpYq3asXLLiN00X0um6o5HRRkamBvmTe692Hjb9cBTRbZobJ1
 XDpYX8CplHJQFdX/Uxlax7S1YF2LMZXyarT8Irz3X796jCSO+HB0XblVbr8hpBk2YR6e05xhxC
 tSH3DpRZ0SHo9Y/5yOeZo08s5YQwqkKeRJy0OnQ4c/VEsyZwNYdSQqdtMQa9Pquj8ROoIxWP+C
 v86BmM7tVXkG655DBUwQIVQQuF/fMXBo9kDuPNYIh42ol1Vz5n0Tr6CtVh2eiJUwi3I8oC0iMg
 kUYL5EwTtn73NnYrkd0WqgFs
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2020 19:36:38 -0800
IronPort-SDR: NhhCrds9VJk8snZ0gnUS4LUS3gmf7mR170+dx7RFLfKZqOVKnHpwXNkMVrzjFfMkHRbHBJMvAl
 Ur6pcbxSjbPFyXlPcAP6AbboB2RWkMXx17aQ28EsR4z4xJRZdvHxGsnz2LhPLskmUHZ9hQwoIZ
 Q33821fdPbUExsCIyW76oCGjcS82NHiJ5lqKQKRC/VCfDsWxYbYJDNC+NIknw1U7r7/CkM/i87
 XSqA/7KGdaak5f9HlRrmkdubldakRcbf4lah8yuWqEyOvrxWdOEXEE+G69BYYehnbXFoXE7mpp
 7/Q=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 21 Dec 2020 19:51:26 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v11 39/40] btrfs: serialize log transaction on ZONED mode
Date:   Tue, 22 Dec 2020 12:49:32 +0900
Message-Id: <39b1c016d74422b9dcac01ba6e33d3ccd8000889.1608608848.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
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
 fs/btrfs/tree-log.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 930e752686b4..d269c9ea8706 100644
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
@@ -173,6 +183,15 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
 			set_bit(BTRFS_ROOT_MULTI_LOG_TASKS, &root->state);
 		}
 	} else {
+		mutex_lock(&fs_info->tree_log_mutex);
+		if (zoned && fs_info->log_root_tree)
+			ret = -EAGAIN;
+		else if (!fs_info->log_root_tree)
+			ret = btrfs_init_log_root_tree(trans, fs_info);
+		mutex_unlock(&fs_info->tree_log_mutex);
+		if (ret)
+			goto out;
+
 		ret = btrfs_add_log_tree(trans, root);
 		if (ret)
 			goto out;
@@ -201,14 +220,22 @@ static int start_log_trans(struct btrfs_trans_handle *trans,
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

