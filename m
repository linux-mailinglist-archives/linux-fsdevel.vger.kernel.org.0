Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 768DD12A5AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 03:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLYCzX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 21:55:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56964 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbfLYCzV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:55:21 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DC9D9B26B6C76528B75A;
        Wed, 25 Dec 2019 10:55:18 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 10:55:10 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <mszeredi@redhat.com>, <linux-fsdevel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 2/4] fuse: use true,false for bool variable in file.c
Date:   Wed, 25 Dec 2019 11:02:28 +0800
Message-ID: <1577242950-30981-3-git-send-email-zhengbin13@huawei.com>
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

fs/fuse/file.c:1398:2-19: WARNING: Assignment of 0/1 to bool variable
fs/fuse/file.c:1400:2-20: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/fuse/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a63d779..16205a0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1395,9 +1395,9 @@ static int fuse_get_user_pages(struct fuse_args_pages *ap, struct iov_iter *ii,
 	}

 	if (write)
-		ap->args.in_pages = 1;
+		ap->args.in_pages = true;
 	else
-		ap->args.out_pages = 1;
+		ap->args.out_pages = true;

 	*nbytesp = nbytes;

--
2.7.4

