Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD4339AFDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 03:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbhFDBe0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 21:34:26 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:4296 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhFDBe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:34:26 -0400
Received: from dggeme760-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Fx4rp4L0Mz1BHDc;
        Fri,  4 Jun 2021 09:27:54 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 dggeme760-chm.china.huawei.com (10.3.19.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 4 Jun 2021 09:32:38 +0800
From:   Zheng Yongjun <zhengyongjun3@huawei.com>
To:     <miklos@szeredi.hu>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH -next] virtiofs: Fix spelling mistakes
Date:   Fri, 4 Jun 2021 09:46:17 +0800
Message-ID: <20210604014617.2086760-1-zhengyongjun3@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggeme760-chm.china.huawei.com (10.3.19.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix some spelling mistakes in comments:
refernce  ==> reference
happnes  ==> happens
threhold  ==> threshold
splitted  ==> split
mached  ==> matched

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 fs/fuse/dax.c  | 6 +++---
 fs/fuse/dev.c  | 2 +-
 fs/fuse/file.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index ff99ab2a3c43..a005859d1c1c 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -212,7 +212,7 @@ static int fuse_setup_one_mapping(struct inode *inode, unsigned long start_idx,
 	dmap->writable = writable;
 	if (!upgrade) {
 		/*
-		 * We don't take a refernce on inode. inode is valid right now
+		 * We don't take a reference on inode. inode is valid right now
 		 * and when inode is going away, cleanup logic should first
 		 * cleanup dmap entries.
 		 */
@@ -621,7 +621,7 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t length,
 	}
 
 	/*
-	 * If read beyond end of file happnes, fs code seems to return
+	 * If read beyond end of file happens, fs code seems to return
 	 * it as hole
 	 */
 iomap_hole:
@@ -1206,7 +1206,7 @@ static void fuse_dax_free_mem_worker(struct work_struct *work)
 			 ret);
 	}
 
-	/* If number of free ranges are still below threhold, requeue */
+	/* If number of free ranges are still below threshold, requeue */
 	kick_dmap_free_worker(fcd, 1);
 }
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index a5ceccc5ef00..0252933eb905 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -91,7 +91,7 @@ static void fuse_drop_waiting(struct fuse_conn *fc)
 {
 	/*
 	 * lockess check of fc->connected is okay, because atomic_dec_and_test()
-	 * provides a memory barrier mached with the one in fuse_wait_aborted()
+	 * provides a memory barrier matched with the one in fuse_wait_aborted()
 	 * to ensure no wake-up is missed.
 	 */
 	if (atomic_dec_and_test(&fc->num_waiting) &&
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 09ef2a4d25ed..6084552f685f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -645,7 +645,7 @@ static ssize_t fuse_get_res_by_io(struct fuse_io_priv *io)
  * == bytes_transferred or rw == WRITE, the caller sets 'pos' to -1.
  *
  * An example:
- * User requested DIO read of 64K. It was splitted into two 32K fuse requests,
+ * User requested DIO read of 64K. It was split into two 32K fuse requests,
  * both submitted asynchronously. The first of them was ACKed by userspace as
  * fully completed (req->out.args[0].size == 32K) resulting in pos == -1. The
  * second request was ACKed as short, e.g. only 1K was read, resulting in
-- 
2.25.1

