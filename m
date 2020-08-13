Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B102439C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 14:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHMM0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Aug 2020 08:26:48 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9281 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726100AbgHMM0r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:26:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C55BAA31E75189DA6DF9;
        Thu, 13 Aug 2020 20:26:45 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Thu, 13 Aug 2020
 20:26:39 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <jlayton@kernel.org>, <bfields@fieldses.org>,
        <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] locks: Convert to use the preferred fallthrough macro
Date:   Thu, 13 Aug 2020 08:25:37 -0400
Message-ID: <20200813122537.4223-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/locks.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 938fe325bc54..32c948fe2944 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1499,7 +1499,7 @@ static void lease_clear_pending(struct file_lock *fl, int arg)
 	switch (arg) {
 	case F_UNLCK:
 		fl->fl_flags &= ~FL_UNLOCK_PENDING;
-		/* fall through */
+		fallthrough;
 	case F_RDLCK:
 		fl->fl_flags &= ~FL_DOWNGRADE_PENDING;
 	}
@@ -2522,7 +2522,7 @@ int fcntl_setlk(unsigned int fd, struct file *filp, unsigned int cmd,
 		cmd = F_SETLKW;
 		file_lock->fl_flags |= FL_OFDLCK;
 		file_lock->fl_owner = filp;
-		/* Fallthrough */
+		fallthrough;
 	case F_SETLKW:
 		file_lock->fl_flags |= FL_SLEEP;
 	}
@@ -2653,7 +2653,7 @@ int fcntl_setlk64(unsigned int fd, struct file *filp, unsigned int cmd,
 		cmd = F_SETLKW64;
 		file_lock->fl_flags |= FL_OFDLCK;
 		file_lock->fl_owner = filp;
-		/* Fallthrough */
+		fallthrough;
 	case F_SETLKW64:
 		file_lock->fl_flags |= FL_SLEEP;
 	}
-- 
2.19.1

