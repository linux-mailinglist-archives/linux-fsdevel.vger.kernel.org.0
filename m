Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE6830F0EB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 11:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235597AbhBDKdN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 05:33:13 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:54283 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235588AbhBDKcJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612434729; x=1643970729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TYXw8oVffvrRDwV3lkf+WMd8tHTd6h5e+gPXGQFVwFg=;
  b=EuTn4voVQXD42eMMdSm2oa9QkeVEcG7X5YpWe8Ne0BeinvlUASYoQ/bk
   D5Rfos5BtLakOqffI6+KZWsqqlmLHAwsbE6kUs2u5sv0nTKNOwhRyzSrO
   fLnEbI85qwVTykAHxl8UfA+KMcU3uU/R+4MvBElvy03WxrRgDLKc50eHV
   NWQbfj1gge//cWS5/PzDcM552z+QFnkXxNoqSv/h7Lrh0C+hN1HTBoyN7
   9oEY9l2c1dadPV4DLdvyqlm32kyAxsLqyZ6n9nUvmfjcRzqnBDWSDKe6h
   7egA0VCVRPbMpMTClBMKooRgS3j0ZhqQA3xb7God9mJdvuLtOflRpKf65
   Q==;
IronPort-SDR: tbTOFySAsLDbv3d0SxWy8giptYcS4cqsGWIp2Ezo/DwHfuafvYCQLL+Z8HrbJ7hs4U9meGo5NB
 xtQPziwEoCqw72l7zlro4hGGWzLi3RhivUc2usrkmAW6yp4JBxHMJeqrK+ObmYOdTlLcK6LPrQ
 KaEhB6Th2Ohr62xvvhveRjmDICl2qPj3blMHvf7f6d1skeRjtQdJ7uKhxWlVBiXeUK5yv65IKe
 JzjwGqJsKAr5gfwzjbUZQRcSP6w92k2jjr5epzBoGAF112qOkARGUjCNX1WdyfWjez7iR3STaF
 f4k=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="159108078"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 18:23:51 +0800
IronPort-SDR: TmEFt15P3oyjRHX1n7lrNtHsvypvEIe2kKlqMtgU3A/AvT4qI/5FWLtqtWgNuFAeb+3yzuS9L5
 NgFHm+3FcMIazEFiDrTi8CZ5kPEjuFcUHgAdMslBvl5FFArEeQymbFBMYDyzZOGx1xyJwnJTa5
 9Yk9FZwxxvLUNGw4H+pHYz7UMKRHYNF3Fm+g4BUJLhSBhRCHNv4WkQM53nD26AMfDoIcKnbqDw
 N1yjYHQF0ad+eNTPJkiEs8MQ0/OIqNlhxiLvQlYBYLogSxJLjgmFCDwyZ5r4RSlCvGWZdu098E
 M8laXIxXMPlP0rnJgsDKbufN
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2021 02:05:54 -0800
IronPort-SDR: eJuXZtNVhEUSNcV/wlmb0x8oDKUXjm5DeAarNwpLb4sGYhvLvYhyE2TQUbsuqE1oNZTGN+VG1p
 HN6i9Vj6ZG8V3QGSSUGCcKirqWpfs3nfhCoBRVNI8EVx0J8RYEoNkGumBs28bmloYcL68qDtf4
 tTx1CrriXKl5qrdhLU1G6D39Fj+icz5TcEiCkuiSDytZvy3WuEbqQLiJx0qQo93lefWmJxGmVr
 fDHSB91RBZTQC0OKwpGoEQ8X4UDha9nCYB0uIeRowfda3ZKhqybwoRoCrpXj+YPon0KfZ/Tzfy
 VPc=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon.wdc.com) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP; 04 Feb 2021 02:23:50 -0800
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Filipe Manana <fdmanana@gmail.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v15 40/42] btrfs: zoned: serialize log transaction on zoned filesystems
Date:   Thu,  4 Feb 2021 19:22:19 +0900
Message-Id: <5eabc4600691c618f34f8f39c156d9c094f2687b.1612434091.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
References: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the 2/3 patch to enable tree-log on zoned filesystems.

Since we can start more than one log transactions per subvolume
simultaneously, nodes from multiple transactions can be allocated
interleaved. Such mixed allocation results in non-sequential writes at the
time of a log transaction commit. The nodes of the global log root tree
(fs_info->log_root_tree), also have the same problem with mixed
allocation.

Serializes log transactions by waiting for a committing transaction when
someone tries to start a new transaction, to avoid the mixed allocation
problem. We must also wait for running log transactions from another
subvolume, but there is no easy way to detect which subvolume root is
running a log transaction. So, this patch forbids starting a new log
transaction when other subvolumes already allocated the global log root
tree.

Cc: Filipe Manana <fdmanana@gmail.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tree-log.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index c02eeeac439c..8be3164d4c5d 100644
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
2.30.0

