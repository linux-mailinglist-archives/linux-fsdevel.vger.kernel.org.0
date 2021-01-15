Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F72F735F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Jan 2021 08:00:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbhAOHAp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Jan 2021 02:00:45 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:41681 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbhAOHAo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Jan 2021 02:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610694044; x=1642230044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lx27rK6uZJJJhyjkN5LEz7I+gLUjp/lTLA/Uc8ByMQA=;
  b=cUX3xy+KJ5Y9Iu1fqUN3+hUpkgTbj1YZw7gBSwiCA9yUv76Mb0Zamniv
   ifzk6DhOenI4S2GXzftsmvEcADLQhEVLg5yqT8z8n77/OBDSbXF+z+NWX
   LKlOgngav2Vxz4L4kZa/5mVIxGV0NiGTsI0jNOsq/M+oK4EzNM8Uiqivm
   5Y4/0L0vSAUdK7ud+1XR6/ETGYhb5yxhvisahYCLeZxK8Pfc9VrKP/m04
   kxiHRe4jx6WANwtNDZoMEEvGLdVsWMyrlGUK05hXL9T0rJJGZZ6H7vQXj
   owxOukMNAFQfktd6Giry30SdIGh5hXUb/tVC1B6IoBhguVao2zG8si/ST
   A==;
IronPort-SDR: u4UgBoN++j7eOqam9czqkVi9lqom8zXtx2C3qC4AkNdiyS9UvH4EROs3C66+6hP6kapa+ArKbW
 0mfVwa2LMlqnLcdXr6Cv2eTZk+IQ+FIfhuG0q6lNwKbWcHiBtfCHqUd5oIiAx3cMh1RDew1qWJ
 +dwXofXwie+ixMvn5diCgEmm6bYAbux8EL9QGnC1HbJIJshgZgP4qRhTZfGpEhZe6rNjeYRR8n
 UhIhAtyxJs/es2Wbx70K4cBrypTI1tRAXqHpoT+IYPcJSHHodFZUfbyMCmlBDBN0vM1mPtE40S
 D0A=
X-IronPort-AV: E=Sophos;i="5.79,348,1602518400"; 
   d="scan'208";a="161928313"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 15 Jan 2021 14:56:17 +0800
IronPort-SDR: MaZl+v4ra79rRnsrjGlMMCJ6WszbFGw4UoYE2jh0+a9sjttkKMF0YxhT+NEkYLZbETytVO6Hba
 p5vje25H/H0JTM6DaJi7IsGA0MvRBZYPYaZhvQ/+MoKCNXocT2yEZ77be+s3TBhLcnX0xMZnbC
 NQupCaj2Cs7B23JDlw8io/KAWxJvcwiPWKX+ijZ/x1m+988a2UCmDJ6rj4YrbN1XZdWw0cAZhS
 jtvDn4i6+l1Mx/DNQtT6q1QIYoSGW3Xaw7mRwM+I0830QjwW1HNs6em9gtTRyeAcj1HIj2m1j3
 6fKjqpMOa6FwdtYbvYRn6xvq
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 22:40:59 -0800
IronPort-SDR: 03lSu83ohZX9kXGWS09CEiSB0CjezRIoYgza/x1oGTRjVwwoem2FB8UHmq6htYiG1gP3zqTBlq
 kkVv7ZZ7YQtmR+n5yl26pUU/uA8NZktg9Aogd/0nTyrmlUHxFJizXpe0Z4+0QqeO5vp4DlXvvp
 1XD+zioeSffKaTS2M7cCepOyInKx1SI53ZANIxLfPnIMiP3GV4ZyCGvMnbf4M+KAIcVvdWxsli
 A7kHAgF34r1EgEXKrM+Xh3AMqyqV0Kt+Cs2cWglpbgLx7MiCxYBOte4GucFZy0z55Ih7E4kKPM
 zvY=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 22:56:16 -0800
Received: (nullmailer pid 1916492 invoked by uid 1000);
        Fri, 15 Jan 2021 06:55:02 -0000
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: [PATCH v12 36/41] btrfs: enable relocation in ZONED mode
Date:   Fri, 15 Jan 2021 15:53:40 +0900
Message-Id: <6bda928563e2db015bdee6cd277ac83852bc6054.1610693037.git.naohiro.aota@wdc.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1610693036.git.naohiro.aota@wdc.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To serialize allocation and submit_bio, we introduced mutex around them. As
a result, preallocation must be completely disabled to avoid a deadlock.

Since current relocation process relies on preallocation to move file data
extents, it must be handled in another way. In ZONED mode, we just truncate
the inode to the size that we wanted to pre-allocate. Then, we flush dirty
pages on the file before finishing relocation process.
run_delalloc_zoned() will handle all the allocation and submit IOs to the
underlying layers.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/relocation.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 30a80669647f..ee10cfd590ea 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2553,6 +2553,31 @@ static noinline_for_stack int prealloc_file_extent_cluster(
 	if (ret)
 		return ret;
 
+	/*
+	 * In ZONED mode, we cannot preallocate the file region. Instead, we
+	 * dirty and fiemap_write the region.
+	 */
+	if (btrfs_is_zoned(inode->root->fs_info)) {
+		struct btrfs_root *root = inode->root;
+		struct btrfs_trans_handle *trans;
+
+		end = cluster->end - offset + 1;
+		trans = btrfs_start_transaction(root, 1);
+		if (IS_ERR(trans))
+			return PTR_ERR(trans);
+
+		inode->vfs_inode.i_ctime = current_time(&inode->vfs_inode);
+		i_size_write(&inode->vfs_inode, end);
+		ret = btrfs_update_inode(trans, root, inode);
+		if (ret) {
+			btrfs_abort_transaction(trans, ret);
+			btrfs_end_transaction(trans);
+			return ret;
+		}
+
+		return btrfs_end_transaction(trans);
+	}
+
 	inode_lock(&inode->vfs_inode);
 	for (nr = 0; nr < cluster->nr; nr++) {
 		start = cluster->boundary[nr] - offset;
@@ -2749,6 +2774,8 @@ static int relocate_file_extent_cluster(struct inode *inode,
 		}
 	}
 	WARN_ON(nr != cluster->nr);
+	if (btrfs_is_zoned(fs_info) && !ret)
+		ret = btrfs_wait_ordered_range(inode, 0, (u64)-1);
 out:
 	kfree(ra);
 	return ret;
@@ -3384,8 +3411,12 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	struct btrfs_path *path;
 	struct btrfs_inode_item *item;
 	struct extent_buffer *leaf;
+	u64 flags = BTRFS_INODE_NOCOMPRESS | BTRFS_INODE_PREALLOC;
 	int ret;
 
+	if (btrfs_is_zoned(trans->fs_info))
+		flags &= ~BTRFS_INODE_PREALLOC;
+
 	path = btrfs_alloc_path();
 	if (!path)
 		return -ENOMEM;
@@ -3400,8 +3431,7 @@ static int __insert_orphan_inode(struct btrfs_trans_handle *trans,
 	btrfs_set_inode_generation(leaf, item, 1);
 	btrfs_set_inode_size(leaf, item, 0);
 	btrfs_set_inode_mode(leaf, item, S_IFREG | 0600);
-	btrfs_set_inode_flags(leaf, item, BTRFS_INODE_NOCOMPRESS |
-					  BTRFS_INODE_PREALLOC);
+	btrfs_set_inode_flags(leaf, item, flags);
 	btrfs_mark_buffer_dirty(leaf);
 out:
 	btrfs_free_path(path);
-- 
2.27.0

