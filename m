Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62A4033CA8E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 02:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhCPBJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 21:09:03 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30425 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234116AbhCPBJC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 21:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1615856941; x=1647392941;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rfl6dyiSpJwE1a2awsoDalhzG1aD6kkVwSDI/xBAkHQ=;
  b=Zvynq6ZsOtimhxbkhgfMsdIe/EhimXStfghB54ESv6EAK3TALionPvEo
   BizuuEPpiaIBVtSVjIF+JazNGFS3ygOm7p5ZiNd78arT0c0KFGL+3K3vI
   bBP5Bx1O45vDV1BnFD1JpNZfw1qDuASfZvCckTal7R9kZ9XFQGB+jHWaC
   eLUz+aZ+SVulFSS5Zld6k53D8yS8Y+qO1yqyEpkl33deN49kOJ8DN+drd
   wXt447K0024GRQUY+LHlkShKXUklrL9WuAXvXlVoFmZL/VYL4SSlP9F3O
   XEaYmnza+UtwJY5/K0oZkycnjUDl62Lk/TrdczglNvZBLXsxMGsKcHu+t
   Q==;
IronPort-SDR: 8qBYqpVTb5t068VCcvUGBF8S6R4q1ZcxhwMG/+ZLVd/+anF/1gaCos9hQx72ss5ChLZCuWCGa/
 THp+OGLOJjJsnahh/OBey6u0Q+3UtQws6DEOXl54ywb+n7ojkgxm0/y5hsucp431N2hgXL+YKo
 oQ55H1JqLxGbW6PKAESYDwHdB342o7qhIr5vz0ch863mXujkNDJsuXK/tKdolK5VNzdUi6bI8t
 t3Q3UmJ4K0HN7DjYW07pDJEAlIC9RN5iBR4wNWyvBf17otHJi6prSrVIZdZuTiuQxLbFC8S7rY
 VSk=
X-IronPort-AV: E=Sophos;i="5.81,251,1610380800"; 
   d="scan'208";a="272929390"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Mar 2021 09:09:01 +0800
IronPort-SDR: 5PN2Sar54fSn4RVhIoDQ/5C/ZfWEuXI9XcmqwiwWz9s9/cD870R9wUzy1h5yZ6PSSBKJLCd4jG
 D1C8f6IFIPV4mTvFFhzkRNTuXL9vi4CPYvWkR6fFFtuQeF/mw/G88Q91weW8DcgkONzG//TZL9
 UCCie5sCmD0TWFKWeWk4xWZWFpQgaQYK+9ktmLLf+UPF/VX3ehjWbm8XWHe4yI7QJpivz7JUh7
 Rr1ah0g4JBn1bCIeDkjSC95xueRGFZKONCkea/DhxH3kt0C5QIU4ptVWrbr/VhIygbYLV1mSi/
 5ajVts0vHJvx8q5psPs7SY3g
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 17:49:38 -0700
IronPort-SDR: 83ZwDpHNYQeWBBWYM1qUPPw+sPrbN67lTfAbZdBiSiVQfYDIoX3QmXl2K3eUi71ENePTu43gHS
 6O2+q2SMx1eXMDAPpyB8VngiXxDU4NX68JozavugP8BHroCWYWhDBex5RZgt1vcpl4POXk9p/f
 zXr1M4gqYVbKOj+VbUaHS8C8P1nh3Z5gTIcj9s3E7jpKLyMWAnRwBo7oVNIB9bVpYI/cILd0/e
 84bjYBWdnKgwtZDKwBi7Ha2mYtV5axi0xA1HcKLeWzfiF7dhCg9IjTo7v2wK8naGLzT8ctMxk3
 jFs=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Mar 2021 18:09:01 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v2 1/2] zonefs: prevent use of seq files as swap file
Date:   Tue, 16 Mar 2021 10:08:58 +0900
Message-Id: <20210316010859.122006-2-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210316010859.122006-1-damien.lemoal@wdc.com>
References: <20210316010859.122006-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The sequential write constraint of sequential zone file prevent their
use as swap files. Only allow conventional zone files to be used as swap
files.

Fixes: 8dcc1a9d90c1 ("fs: New zonefs file system")
Cc: <stable@vger.kernel.org>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/zonefs/super.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 0fe76f376dee..a3d074f98660 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -165,6 +165,21 @@ static int zonefs_writepages(struct address_space *mapping,
 	return iomap_writepages(mapping, wbc, &wpc, &zonefs_writeback_ops);
 }
 
+static int zonefs_swap_activate(struct swap_info_struct *sis,
+				struct file *swap_file, sector_t *span)
+{
+	struct inode *inode = file_inode(swap_file);
+	struct zonefs_inode_info *zi = ZONEFS_I(inode);
+
+	if (zi->i_ztype != ZONEFS_ZTYPE_CNV) {
+		zonefs_err(inode->i_sb,
+			   "swap file: not a conventional zone file\n");
+		return -EINVAL;
+	}
+
+	return iomap_swapfile_activate(sis, swap_file, span, &zonefs_iomap_ops);
+}
+
 static const struct address_space_operations zonefs_file_aops = {
 	.readpage		= zonefs_readpage,
 	.readahead		= zonefs_readahead,
@@ -177,6 +192,7 @@ static const struct address_space_operations zonefs_file_aops = {
 	.is_partially_uptodate	= iomap_is_partially_uptodate,
 	.error_remove_page	= generic_error_remove_page,
 	.direct_IO		= noop_direct_IO,
+	.swap_activate		= zonefs_swap_activate,
 };
 
 static void zonefs_update_stats(struct inode *inode, loff_t new_isize)
-- 
2.30.2

