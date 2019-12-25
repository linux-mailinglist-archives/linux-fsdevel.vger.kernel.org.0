Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0396B12A5A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 03:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbfLYCzW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 21:55:22 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56952 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726314AbfLYCzV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:55:21 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D602F925425F2E677471;
        Wed, 25 Dec 2019 10:55:18 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 10:55:09 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <mszeredi@redhat.com>, <linux-fsdevel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 1/4] fuse: use true,false for bool variable in readdir.c
Date:   Wed, 25 Dec 2019 11:02:27 +0800
Message-ID: <1577242950-30981-2-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577242950-30981-1-git-send-email-zhengbin13@huawei.com>
References: <1577242950-30981-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes coccicheck warning:

fs/fuse/readdir.c:335:1-19: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/fuse/readdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index 6a40f75..90e3f01 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -332,7 +332,7 @@ static int fuse_readdir_uncached(struct file *file, struct dir_context *ctx)
 		return -ENOMEM;

 	plus = fuse_use_readdirplus(inode, ctx);
-	ap->args.out_pages = 1;
+	ap->args.out_pages = true;
 	ap->num_pages = 1;
 	ap->pages = &page;
 	ap->descs = &desc;
--
2.7.4

