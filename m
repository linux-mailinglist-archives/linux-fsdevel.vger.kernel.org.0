Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B91112A597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbfLYCdZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Dec 2019 21:33:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7751 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726258AbfLYCdY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Dec 2019 21:33:24 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 10606C2B1A6F7377AEBF;
        Wed, 25 Dec 2019 10:33:20 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 10:33:11 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] vfs: use true,false for bool variable
Date:   Wed, 25 Dec 2019 10:40:28 +0800
Message-ID: <1577241628-131521-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes coccicheck warning:

fs/ioctl.c:351:4-12: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 7c9a5df..5121c45 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -348,7 +348,7 @@ int __generic_block_fiemap(struct inode *inode,
 			 */
 			if (!past_eof &&
 			    blk_to_logical(inode, start_blk) >= isize)
-				past_eof = 1;
+				past_eof = true;

 			/*
 			 * First hole after going past the EOF, this is our
--
2.7.4

