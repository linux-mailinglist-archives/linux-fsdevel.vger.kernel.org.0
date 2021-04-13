Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E81F935D503
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 03:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240017AbhDMB6f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 21:58:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15669 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238374AbhDMB6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 21:58:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FK7wT6p9TzpXr5;
        Tue, 13 Apr 2021 09:55:21 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Tue, 13 Apr 2021 09:58:02 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        <bfields@fieldses.org>
CC:     <linux-fsdevel@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH] fs/locks: remove useless assignments
Date:   Tue, 13 Apr 2021 09:58:23 +0800
Message-ID: <1618279103-45362-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Function parameter 'cmd' is rewritten with unused value at locks.c

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 fs/locks.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 53cf033..5c42363 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -2369,7 +2369,6 @@ int fcntl_getlk(struct file *filp, unsigned int cmd, struct flock *flock)
 		if (flock->l_pid != 0)
 			goto out;
 
-		cmd = F_GETLK;
 		fl->fl_flags |= FL_OFDLCK;
 		fl->fl_owner = filp;
 	}
-- 
2.7.4

