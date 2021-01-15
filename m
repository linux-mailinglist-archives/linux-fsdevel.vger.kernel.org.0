Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E65622F7368
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730067AbhAOHBO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 02:01:14 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41718 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbhAOHBM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610694072; x=1642230072;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GgKvwZ3/MumYs8snuRzyykc3kM4rM9mgurEtkGpvjZY=;
  b=KrRoby+GkyGSqol746NzESmNbv7NlpLuSzBnWt8TkgmuEPdAMuZ5w3ss
   sLmkoUUojiT9O7YWFg24p2aIHthXQ1xt+CzuJKGlCdMoGNgOPbXPHodUj
   Y1KDU012rOBeBAHQG8W97LrDlqjNZxl7THe+zR4KwezwV5yaE8D2ezIeC
   Btqu0J0a9VzsmALrjrgPZkkJr/hgQRtQlL4xTevzfSMdbFJqLtmd/apv+
   7EhfaXdXBfD1jFNTN8o7S6uqUDlu85Aabno5Zj+bCdP09W7FV/7t0XMA6
   P2LPe01b/v/1lAMzpKiW42yMk1P8/SJ89+bwDvnw1UqWdfM1OXYJXzTpf
   g==;
IronPort-SDR: KA25qDQtqM6zBy7v+0q0x1xDXCXsIAZvLg+WsyM/1R3uJBahLPh1GpFs1AFzuu7ORPeQJUZD0P
 K0g7WJFbEzq5gRoz1gNM9Mkx/cVJZ8+dD1zLbbU66+XZIGe7G/TC1A3WyMy+LWbyqJCdUEw1be
 NwevKDY6vRuZUZwy0wj5PuzSYLGgGbauaz6hXTi/oDK4E6APFaPvlv0ludKcScA9fknBZH4k4q
 b4SopWMG+o3VFtGI4Y+AW7UIkNeYROZ0yUogdqyBBk/LrIpgPdAN4Ql+kCmVck4u8s6/oXkedD
 7X4=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928330"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:56:25 +0800
IronPort-SDR: ZBIHPrhS7tRW0uwsNs7Jmeedl3ZnqfEfw5Gp1QG+xcD032jDInUtKEdX8mYo5v8HYKXJMKt5rd
 rSbd0m//hBlKiF+LdM21rZ6l+syYGUCI6jKcn+Iw8ncdTETNoWbIoRN/ARk6p2MLnn6yMT7qd6
 DpRMS0SsLRFuMpzoVL2h79rH8vGMxzb75OZE/C7A5STP9vsYef4Fd+Od3s5xkpXAWZihYqMAJF
 DJ34Lm9gFfb+NKZPwrWuuED1MyCAdqtqz30tCOVKpEgrziAgB4qLFP7vIuCEn5zBDcN4lG0/06
 DEHVvxdujBudzBqszJpI4VDw
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:41:07 -0800
IronPort-SDR: a/Clb3fmtFWbKaemYVvMsNZWmO4eZx/F4tVCYymQ4PN+tn3KYkNCZ8z4n9XK5IKiRlYv6s4GLX
 X36fGqyjZOsd44Yk+65nL6Z/JIdkRX7sQpWnI8zEwVHYdH9DlcYN43L5jGOwhjyDNqsQqLii5r
 guJaI9CzT8GeBbMHT4bn2MnoWuguP7ZhpygCw5dXkGhIDddxoKe6NPKFbD9ONFAh+jCwMDKXtA
 zklbPf8LsF4KVZBjp87ff4TQ8K+G+r6ud72bX1ALBjiDWvuUOJtru+0zSgoiAJ9yyMZqze/Eoi
 GHY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:56:24 -0800
Received: (nullmailer pid 1916500 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v12 40/41] btrfs: serialize log transaction on ZONED mode
Date:   Fri, 15 Jan 2021 15:53:44 +0900
Message-Id: <2e011d54e1b85437c27b40201fcf2901e073d1ce.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
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

