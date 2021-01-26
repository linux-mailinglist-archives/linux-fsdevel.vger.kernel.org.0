Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39BE73034EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 06:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbhAZFaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 00:30:24 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:38256 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbhAZCoV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 21:44:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611629061; x=1643165061;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GgKvwZ3/MumYs8snuRzyykc3kM4rM9mgurEtkGpvjZY=;
  b=ZSdujKgLi9QxZJRk/utl90HZQVvqlmUEZwTP6X0U/KSF0LN+I69+bjRZ
   /ZH/GYm2qRhVX5XrNlgL17uUKQkMWdGRF/YU2H+EVu4dHWcvmXq81NTY6
   HuS0XQgUQrHBbj54lofRp8ZFSMUDmRVcySSAbaf7hklXZWfA7tgUhqzHn
   TrrI2GKHzp39Hf6i9XscI4O+Ad7n0ji78pV/bP7S3ZcBOQB6iAcd/1iv0
   rznx0nE0KNpi41aM/4QBJ3MLBC6jRSeDYhtQvZvuVYkL6JxHkzx0J+/wC
   hx5r/j91e3fy43saaTTvlE5/YYQPngYgGwIN3VhmaALMD2GfYeyTW9TA8
   Q==;
IronPort-SDR: gLfLHo7z6Hrz//BrwtRI52pYSXoxGtyfE3O1piYDSiveRt6V5v12XdaIGgD4u6qSit4IGyQ55/
 LKI1fG7M9JlaZTuqfi865xLOBZOsE3c/IYqE8HmgAuA1XuBq3LM0iY6uFoCn7mytRLpF9+1fHy
 uUGairxEHNdD2X/+3TPA9lkOQnKib+HHCFUEVMwY08pilIwJqTbfQAsx5wosfdpHCPN/PpbbgZ
 tFsFgMIhZeFvJEknsvCIKEfmDA+4Eev3JrG8TP1JcPoJl7v8TDz5yGRGTFn0XbX7ZPSL2WEGIt
 Yf0=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="159483587"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 10:27:09 +0800
IronPort-SDR: uBqffQ1uoGVq5KIlDChCt/0vjm0Y5YHe+BZPsBjb9x6q2VH0YD4XF4vaEWv+QTAsHn2xNZkPQS
 5sIPWyXFHYYfCu9094CJf+AajvtHI6OYyt1Ngk9f4K41D8qf5YZGR+FHP++EirL31wanmW3Bg1
 sNC7aJO688rSBnqtyrZz5maCSqUtXJccrYjuwOEj7oUBrny9fOkuzLJkT/eRqVw8m87SWNcook
 2cEobKEN9XEn3TYjk+AD40BABJ3l5LSALcEf+wFW9ocWmpiZV6Nk5CnR0GYbXpUwOjNhuM/Meu
 MyAQEexY3mjhhI/csujViegu
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2021 18:11:36 -0800
IronPort-SDR: HlmVOMwwXwOSRzNiPL6El0wEBh3oA9FEgFwnRsi2FgjLfYeiUWCFz+k/Weo+pB4twpWISy1aTl
 hxix33yX51PebZqdYoD3pEME50gP+bzm7gK1BDPEGT7hzx7oUWHPTFlBgBSfP3uPVI1n5nUGuh
 AgrCs8yHO6emP2HDXVhdSrcrLFwK2H/8UA8kYPZYMAOfxtK5jMETnJK/bbat2fPddUN26kmDob
 kKzKOgqwIXcLUn3AuHlsWsW6ELklKsAbLbyamTDt6CULJy9X6NTE8WXud55sjb43omZOAteB++
 vLU=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with ESMTP; 25 Jan 2021 18:27:08 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v14 41/42] btrfs: serialize log transaction on ZONED mode
Date:   Tue, 26 Jan 2021 11:25:19 +0900
Message-Id: <cf8cd6170bd2283524a89a8192eeaba769a98fd6.1611627788.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1611627788.git.naohiro.aota@wdc.com>
References: <cover.1611627788.git.naohiro.aota@wdc.com>
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

