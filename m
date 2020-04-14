Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA31A79A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 13:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439337AbgDNLfr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 07:35:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44274 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439325AbgDNLfn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:35:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 734AF9BF27504F9F8185;
        Tue, 14 Apr 2020 19:35:41 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 14 Apr 2020
 19:35:33 +0800
From:   Jason Yan <yanaijie@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jason Yan <yanaijie@huawei.com>
Subject: [PATCH] ioctl: use true,false for bool variable 'past_eof'
Date:   Tue, 14 Apr 2020 20:02:01 +0800
Message-ID: <20200414120201.35242-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the following coccicheck warning:

fs/ioctl.c:364:4-12: WARNING: Assignment of 0/1 to bool variable

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 fs/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 282d45be6f45..9ee11a2bb807 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -361,7 +361,7 @@ int __generic_block_fiemap(struct inode *inode,
 			 */
 			if (!past_eof &&
 			    blk_to_logical(inode, start_blk) >= isize)
-				past_eof = 1;
+				past_eof = true;
 
 			/*
 			 * First hole after going past the EOF, this is our
-- 
2.21.1

