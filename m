Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE23A2AD521
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 12:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbgKJL3t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 06:29:49 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12022 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731969AbgKJL3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 06:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605007781; x=1636543781;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SYSIJjfqADPp8c18wBFU2La2NMbjrakFsPN2JUf/boM=;
  b=CocTDqSzPwpxJKkfAcpw/9/QGHHfpT6fcK3xBW/CADAN2iIYIZDpQMkh
   9LBRPGaUbCI14W9JK4oaSw39Cer93Z6gOB3Hpui70MCIOyd38/laPM0mL
   zPM6UhqWqvosR/UGmBN+cetSHun6iuuN2L7PiAurZ8O0O6HrJwlN88wW4
   A6Um06lK/hyjvE3unsvqSUpxVgBlQJB1OLqCZhHFXONUbV1SQRpFxYtYd
   M1pfz9Qu0I82DZ6qcY0QLkdOGUtRMdU2f+6+W4MsiPJg5vr4MBO5wrLNG
   QUTtNoP9stFn4lSmUYEZyvw6GNLAO0PK895JuDSJ2fElQFXVH9kIpapLG
   Q==;
IronPort-SDR: Ds3XnWIpzCQFvi2Dy47OMMflIHxHqg1TqqoIf5LriW48V/IdUSNdoHJxyNRDpwuTEKAabw3pW8
 EgQP/vmAXvUYry8oq3nCSuaikS8tpMxKPcJk3OttJcQTcVb2t8WfnwbRbxNx7bJvrLxtSWnDt8
 SYR74eCR+Imaj2RPFVlTBOock9p6gbBFtqf0e8LRT9VYn4YnOEjarMeIVBsFyxtOG4LOvHoeJP
 Qs4SZLVErLpAYe14nmsHe0QIalExjyXs/5ezmzR6uaqrTqoyt1ut1nk8Sln0DWbDXCJUWNbdb2
 cFU=
X-IronPort-AV: E=Sophos;i="5.77,466,1596470400"; 
   d="scan'208";a="152376730"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 19:29:08 +0800
IronPort-SDR: WKLTEvH5jjN6K/98T/LDfE0lU5IMTUeO/4BO+UGmyW5JvYIAx6hkrudk6aHWnM8NzFwYuxLZ1q
 f1Hf0DC2zPAgCHiaTiV45qRr1K+Hsce6hjRS6EG3NtGTiYKXY5kRuvGIDMdkgusl9zYiqETLvd
 lM0XEObU6SJe8+QqWseyhhm3kygcPcjZsyw3pkX+tejK1b/XOgmVWjrEb4oThRLZmfqQMXNle4
 S/NPF13Mrsn3C/O+p9Tp05EkDzSMjyAOpKUlHGbrCe2C5I+uWVW9LZWKMui92cHzx5sVmKDOfM
 ORrmdg7cNfo1iWX0jnqdbYoh
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 03:15:09 -0800
IronPort-SDR: uqQvsKFcoC6kGT/12347WRjw1GUJSUwSxKtzuq9yUJ0l85EMFWCuAyf5Ps56W8Gsa9ueM+UJ6X
 hnpxjkwi5hV9B6qyTGqgWmVJV5NZZ9A/u9Hqs9x4Da809uM3BKUlmmpSP8268b7f/jNeg8fBr7
 RU2n3+6DOCnf/aei5ClT+g05hXOl/WAu6/DmL4EuvI9SEFPthdNGAWmzb8exyFoE3OHKndpx1K
 R/1DVCHPwB61yix2GWRFAduYigKuqIUXFvw27OtP7oFhi1F5k6VMJI8i4ifxmMNs6ZjyqSDkjz
 T/Y=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with ESMTP; 10 Nov 2020 03:29:08 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH v10 39/41] btrfs: serialize log transaction on ZONED mode
Date:   Tue, 10 Nov 2020 20:26:42 +0900
Message-Id: <b3d2ff3ba42db182334e687b4aa114b32ca71d57.1605007037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1605007036.git.naohiro.aota@wdc.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
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
index 5f585cf57383..505de1cc1394 100644
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
+	const bool zoned = btrfs_is_zoned(fs_info);
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

