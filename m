Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4C13107DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 10:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhBEJaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 04:30:12 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4008 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhBEJ15 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:27:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612517276; x=1644053276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XB98zZQ4xlGspCrelVu2sxwba448ajtO9H0TUF+r09o=;
  b=h97ebBkUaByLFxexmxJoek7nxsasOBGZ4Cj+o9kGqJJjC8wGWErZbgY8
   qAKl3aDF4S1vV4f+DWwW4wmrG8rZ9rRWcZIdf3C3it3TdghLvNBFVSNOH
   x9wDvibpu5Di1XphKofd7QyYneBh8eaU7oNBjklGAzJAH3nZA19DEIjDe
   NgP8lgCc4rMH5E+wgQslZF36RCungu1xDMzGxLY4bcHD+z3rz3nAeMpQY
   T0C2oPTcKqjJ4ytVHIsSZo1AIoK/Z81zKbZZLFsKc0egFKO71nvtM7LM9
   Vaercz3Tiwahv8xQViAMBXYlUqu1nGt/gmYw3rcwCpvAxnVxtzNMbAxxC
   Q==;
IronPort-SDR: TepCF29coyLikXLA7yB9kTrqZlP0kySANJsi77w/SX8SdwOCoZybVp9apAszWo+CkTnBrOXshD
 v0dgGgxC5KkWq9q+AXvRhymhU6b0mCwktC+uXHIpmbbvhJIciIIRrwY+DnKj2UMH73pFk0If6Z
 r92L/nBd2gvrQIaz4el1Q/OdmvzcTozH3SiANlTlodP9o4mjpI7w+HH0cGjD4pd1KUDYZVpjjZ
 GvtH8pPY3ioEG2tCtmpKwgqHIAQNKfYOLCgVOwazRM9S3XCWkG24xMYKZDn0ltav9Pr0WHdk9X
 bk8=
X-IronPort-AV: E=Sophos;i="5.81,154,1610380800"; 
   d="scan'208";a="160410287"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Feb 2021 17:26:38 +0800
IronPort-SDR: X+GDFTwY9urYwFvdQunIevvDtOpmQaA5Zv87CVY7tW0xJ4gaGbv0/+Xckrdv9+3zZcRZq76ydH
 nbQzgNBVFpYO5cNuypNPS/6AcX+M0iDcqs+Zp1v6zJTprBmhTVMXt0KE6inex1BwtA3eNLm4py
 F5gSqdVnQc11tGDmIypuLheiwthDON7gqNRYqCxniKwcCmm2i1ewXjxI8cscqG+NQ3rYtS3iUl
 ojaOPO3n2I2zKW1KO/94khb5DUdW3y7RBWzJZAmjt/955JKdUH8sf6Pnx1ImQIvn0xXvA0QhRo
 t8LruV/V9H616sh4Jv6ffyP6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 01:10:35 -0800
IronPort-SDR: CkFZSti/6Chni8JfWyBj238UQ0+HJfFsIWux/shvqMqbt7CQbyW62YkH8fV6S96G8OzBivXK0r
 KFp5Ue2par5vI3QvXYLxuV9ogAv0fAGF1jLJhpZFdjE5iFVOxzLz98IXglWvH97tYYKuszx/ZB
 H235kntISgdi6Ry9qpw5Mnd57z9Hb7VCynljXaEU6rW1DPOF2dXS2TyqUFB3gzZUBpW5Oov2rD
 0hXn42lBsnb8Rp8jfCUNsHurCLmkUQQsUhdHsMhui3FKpnl84b8hmXI6HfvTdR7RmHjQB021TZ
 88U=
WDCIronportException: Internal
Received: from jfklab-fym3sg2.ad.shared (HELO naota-xeon) ([10.84.71.79])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 01:26:38 -0800
Date:   Fri, 5 Feb 2021 18:26:35 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Filipe Manana <fdmanana@gmail.com>
Subject: [PATCH v15 43/43] btrfs: zoned: deal with holes writing out tree-log
 pages
Message-ID: <20210205092635.i6w3c7brawlv6pgs@naota-xeon>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b36444df121d46c6d9638a8ae8eacecaa845fbe4.1612434091.git.naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since the zoned filesystem requires sequential write out of metadata, we
cannot proceed with a hole in tree-log pages. When such a hole exists,
btree_write_cache_pages() will return -EAGAIN. We cannot wait for the range
to be written, because it will cause a deadlock. So, let's bail out to a
full commit in this case.

Cc: Filipe Manana <fdmanana@gmail.com>
Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
---
 fs/btrfs/tree-log.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

This patch solves a regression introduced by fixing patch 40. I'm
sorry for the confusing patch numbering.

diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 4e72794342c0..629e605cd62d 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -3120,6 +3120,14 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 	 */
 	blk_start_plug(&plug);
 	ret = btrfs_write_marked_extents(fs_info, &log->dirty_log_pages, mark);
+	/*
+	 * There is a hole writing out the extents and cannot proceed it on
+	 * zoned filesystem, which require sequential writing. We can
+	 * ignore the error for now, since we don't wait for completion for
+	 * now.
+	 */
+	if (ret == -EAGAIN)
+		ret = 0;
 	if (ret) {
 		blk_finish_plug(&plug);
 		btrfs_abort_transaction(trans, ret);
@@ -3229,7 +3237,16 @@ int btrfs_sync_log(struct btrfs_trans_handle *trans,
 					 &log_root_tree->dirty_log_pages,
 					 EXTENT_DIRTY | EXTENT_NEW);
 	blk_finish_plug(&plug);
-	if (ret) {
+	/*
+	 * There is a hole in the extents, and failed to sequential write
+	 * on zoned filesystem. We cannot wait for this write outs, sinc it
+	 * cause a deadlock. Bail out to the full commit, instead.
+	 */
+	if (ret == -EAGAIN) {
+		btrfs_wait_tree_log_extents(log, mark);
+		mutex_unlock(&log_root_tree->log_mutex);
+		goto out_wake_log_root;
+	} else if (ret) {
 		btrfs_set_log_full_commit(trans);
 		btrfs_abort_transaction(trans, ret);
 		mutex_unlock(&log_root_tree->log_mutex);
-- 
2.30.0

