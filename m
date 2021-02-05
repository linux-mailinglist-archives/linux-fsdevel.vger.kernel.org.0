Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF566311413
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbhBEV6O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 16:58:14 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:3097 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232994AbhBEO7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612543073; x=1644079073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uPGCPQ8rbQPh3KZmt++4BCxACZmVtWDYOZ9UNDTczLw=;
  b=YF2MYkWey0hairgf0HyhUcdqcbVLm8Eb4cNI6YZpOQoN0J5CLu27RGaN
   zRrOaK2fTs0H8WiBuKgN8PCmnlsLDoaYn7Njc+2U/0PT/s8w0gcIKsRW7
   RxAks6l/yua4S8RuYk/tdLxtRN5LfhmMxJ1tPqt9nWzFhp7yYW5i+fJ+j
   022dNSS5mvc0ce/TYWNx/OZndiLqcuSdXy8fkknfYeo4pXAooSU+WbquV
   wAZ+umVW1sLFUpW+eDJhI0Mv5RS5gYwFbYsFe5hbOE51WKw+d+ZQx2pa2
   QryCx6TmKgnO2zdR2KkqDo/B+qYgTJs+FrtlWjSJ0mK4HoKk+CidnHzcT
   g==;
IronPort-SDR: Tlm7L17u5LrXD+ZWp1wTjlkvtc/cr7CQUWuYHBcVMtte4B1Glj1gH8sEfkhpxVlXabSSz5VHNv
 yqv6RllefVwJ9L1pwABzi9JZtDthDxF2PVtqHvf/+d5oPr3FxqnhzdWXOOerXWgKekFW19wEwv
 1njIsVVmcR3D/pNIxDZCizzyCLMDC/5eSd1HJb5AIA4NZM7HFL7+iSeHIjJFSQDAc+2yy3PMVg
 s9rL4mcc6X1Y/TI4Gyi3I/cjJPHrRlFZjhXe/iNcQZjE4dOI/2f7iQp9Bi+uqJR9zAcObxId4r
 RkA=
X-IronPort-AV: E=Sophos;i="5.81,155,1610380800"; 
   d="scan'208";a="269670158"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 22:58:39 +0800
IronPort-SDR: 60o7G6n6UqRZhGYs9CR02l62E0WiPiO3qYHAhgAIu4mFd8YvhIxmAiazQ5egt0sm0m3eNv5IiO
 GVqGdTzdSWh2eIGv3TcvXxgQBt82LWdSO9vVoaHRKmHGnR35gUwMIa0A+boCrapWAiaI6GjMZl
 W/vlKmKIP+ozIERBny8czrCTI4qAXbjqlmrpXrrtPjxC1nsMPzN2sN0rB6z1BCL/Vg+JxlsyUQ
 qUBstZB7NNhWph47Cl8l323z8lxz/af6+v0hEzMpaNEKi6RmwZHSz3pVRJz/AmT7UlbwYci5Yv
 gAUjDrXb2Odh7KPjY4nLfZBQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:42:37 -0800
IronPort-SDR: syH1DAh5Y/X9LyEHKsmeMY4IwACuXJxguiHrc71a6iYyrIZ1EhECyirasXnrnbDdNgdevFyFPj
 ehN8YbO0UkjZVxi3slGd9CCUyD1Hs/qArQld67jwClbXjpJtCXZFbphCpKOS17elJn+myLRxNQ
 nIPdunQbhKkgBohjN60+d+Tk1jgGgorDSJby6vl/Ictmtnd3kndn4zCdPJ12Gtr1nBjd+hvQbH
 Tf9t07/oFRlYLQ1TO4svJ0c7bt+Q6xXFptpzpqIdTufYDnSUV0nW1mZK0QNjnJp1atJkWYao0J
 oQE=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon) ([10.84.71.79])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:58:38 -0800
Date:   Fri, 5 Feb 2021 23:58:36 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Filipe Manana <fdmanana@gmail.com>
Subject: [PATCH v15.1 43/43] btrfs: zoned: deal with holes writing out
 tree-log pages
Message-ID: <20210205145836.gtty4r6a4ftolehj@naota-xeon>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
 <20210205092635.i6w3c7brawlv6pgs@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205092635.i6w3c7brawlv6pgs@naota-xeon>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the zoned filesystem requires sequential write out of metadata, we
cannot proceed with a hole in tree-log pages. When such a hole exists,
btree_write_cache_pages() will return -EAGAIN. This happens when someone,
e.g., a concurrent transaction commit, writes a dirty extent in this
tree-log commit.

If we are not going to wait for the extents, we can hope the concurrent
writing fills the hole for us. So, we can ignore the error in this case and
hope the next write will succeed.

If we want to wait for them and got the error, we cannot wait for them
because it will cause a deadlock. So, let's bail out to a full commit in
this case.

Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tree-log.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index fc04625cbbd1..d90695c1ab6c 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3120,6 +3120,17 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	 */
 	blk_start_plug(&plug);
 	ret = btrfs_write_marked_extents(fs_info, &log->dirty_log_pages, mark);
+	/*
+	 * -EAGAIN happens when someone, e.g., a concurrent transaction
+	 *  commit, writes a dirty extent in this tree-log commit. This
+	 *  concurrent write will create a hole writing out the extents,
+	 *  and we cannot proceed on a zoned filesystem, requiring
+	 *  sequential writing. While we can bail out to a full commit
+	 *  here, but we can continue hoping the concurrent writing fills
+	 *  the hole.
+	 */
+	if (ret == -EAGAIN && btrfs_is_zoned(fs_info))
+		ret = 0;
 	if (ret) {
 		blk_finish_plug(&plug);
 		btrfs_abort_transaction(trans, ret);
@@ -3242,7 +3253,17 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 					 &log_root_tree->dirty_log_pages,
 					 EXTENT_DIRTY | EXTENT_NEW);
 	blk_finish_plug(&plug);
-	if (ret) {
+	/*
+	 * As described above, -EAGAIN indicates a hole in the extents. We
+	 * cannot wait for these write outs since the waiting cause a
+	 * deadlock. Bail out to the full commit instead.
+	 */
+	if (ret == -EAGAIN && btrfs_is_zoned(fs_info)) {
+		btrfs_set_log_full_commit(trans);
+		btrfs_wait_tree_log_extents(log, mark);
+		mutex_unlock(&log_root_tree->log_mutex);
+		goto out_wake_log_root;
+	} else if (ret) {
 		btrfs_set_log_full_commit(trans);
 		btrfs_abort_transaction(trans, ret);
 		mutex_unlock(&log_root_tree->log_mutex);
-- 
2.30.0

