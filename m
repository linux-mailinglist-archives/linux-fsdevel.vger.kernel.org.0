Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 740FCA7862
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfIDCK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:10:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59850 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727884AbfIDCK0 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:10:26 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 745837A240A9C64E728E;
        Wed,  4 Sep 2019 10:10:25 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:15 +0800
From:   Gao Xiang <gaoxiang25@huawei.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>, <devel@driverdev.osuosl.org>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-erofs@lists.ozlabs.org>,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v2 10/25] erofs: update erofs_fs.h comments
Date:   Wed, 4 Sep 2019 10:08:57 +0800
Message-ID: <20190904020912.63925-11-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

As Christoph said [1] [2], update it now.

[1] https://lore.kernel.org/r/20190902124521.GA22153@infradead.org/
[2] https://lore.kernel.org/r/20190902120548.GB15931@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/erofs_fs.h | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 18689e916e94..b1ee5654750d 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
 /*
+ * EROFS (Enhanced ROM File System) on-disk format definition
+ *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
@@ -7,7 +9,6 @@
 #ifndef __EROFS_FS_H
 #define __EROFS_FS_H
 
-/* Enhanced(Extended) ROM File System */
 #define EROFS_SUPER_OFFSET      1024
 
 /*
@@ -41,7 +42,7 @@ struct erofs_super_block {
 };
 
 /*
- * erofs inode datalayout:
+ * erofs inode datalayout (i_format in on-disk inode):
  * 0 - inode plain without inline data A:
  * inode, [xattrs], ... | ... | no-holed data
  * 1 - inode VLE compression B (legacy):
@@ -187,7 +188,7 @@ static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
 				 e->e_name_len + le16_to_cpu(e->e_value_size));
 }
 
-/* available compression algorithm types */
+/* available compression algorithm types (for h_algorithmtype) */
 enum {
 	Z_EROFS_COMPRESSION_LZ4	= 0,
 	Z_EROFS_COMPRESSION_MAX
@@ -222,7 +223,7 @@ struct z_erofs_map_header {
 #define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
 
 /*
- * Z_EROFS Variable-sized Logical Extent cluster type:
+ * Fixed-sized output compression ondisk Logical Extent cluster type:
  *    0 - literal (uncompressed) cluster
  *    1 - compressed cluster (for the head logical cluster)
  *    2 - compressed cluster (for the other logical clusters)
-- 
2.17.1

