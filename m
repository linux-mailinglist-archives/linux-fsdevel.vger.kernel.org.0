Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11ADD2D0917
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 03:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgLGCGz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 21:06:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8952 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727833AbgLGCGy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 21:06:54 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Cq6994bpQzhnc0;
        Mon,  7 Dec 2020 10:05:49 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Mon, 7 Dec 2020
 10:06:07 +0800
From:   Jack Qiu <jack.qiu@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] direct-io: fix typo
Date:   Mon, 7 Dec 2020 11:06:34 +0800
Message-ID: <20201207030634.23035-1-jack.qiu@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove redundant 'be' in do_blockdev_direct_IO

Signed-off-by: Jack Qiu <jack.qiu@huawei.com>
---
 fs/direct-io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/direct-io.c b/fs/direct-io.c
index d53fa92a1ab6..40c083ae82d0 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1276,7 +1276,7 @@ do_blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,

 	if (retval == -ENOTBLK) {
 		/*
-		 * The remaining part of the request will be
+		 * The remaining part of the request will
 		 * be handled by buffered I/O when we return
 		 */
 		retval = 0;
--
2.17.1

