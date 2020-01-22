Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 704C6144CAD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jan 2020 08:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgAVH6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jan 2020 02:58:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9233 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726077AbgAVH6Z (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jan 2020 02:58:25 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id B698E36897572CDCEB92;
        Wed, 22 Jan 2020 15:58:23 +0800 (CST)
Received: from huawei.com (10.175.104.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 15:58:13 +0800
From:   Shijie Luo <luoshijie1@huawei.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <luoshijie1@huawei.com>,
        <linmiaohe@huawei.com>
Subject: [PATCH] fs: remove comments about free_more_memory
Date:   Wed, 22 Jan 2020 02:57:39 -0500
Message-ID: <20200122075739.41687-1-luoshijie1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove comments about free_more_memory because this function
no more exists.

Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 18a87ec8a465..3ce22700539a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -973,7 +973,7 @@ grow_dev_page(struct block_device *bdev, sector_t block,
 	struct page *page;
 	struct buffer_head *bh;
 	sector_t end_block;
-	int ret = 0;		/* Will call free_more_memory() */
+	int ret = 0;
 	gfp_t gfp_mask;
 
 	gfp_mask = mapping_gfp_constraint(inode->i_mapping, ~__GFP_FS) | gfp;
-- 
2.19.1

