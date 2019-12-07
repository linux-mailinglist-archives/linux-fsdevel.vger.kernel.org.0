Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21AF0115B87
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 08:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLGHpu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 02:45:50 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7648 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbfLGHpu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 02:45:50 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6C4C66C66C80F74A0E71;
        Sat,  7 Dec 2019 15:45:47 +0800 (CST)
Received: from huawei.com (10.175.105.18) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sat, 7 Dec 2019
 15:45:40 +0800
From:   linmiaohe <linmiaohe@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linmiaohe@huawei.com>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] fs: eventfd: fix obsolete comment
Date:   Sat, 7 Dec 2019 15:45:33 +0800
Message-ID: <1575704733-11573-1-git-send-email-linmiaohe@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.105.18]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>

since commit 36a7411724b1 ("eventfd_ctx_fdget(): use fdget() instead of
fget()"), this comment become outdated and looks confusing. Fix it with
the correct function name.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/eventfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/eventfd.c b/fs/eventfd.c
index 8aa0ea8c55e8..0b8466b12932 100644
--- a/fs/eventfd.c
+++ b/fs/eventfd.c
@@ -352,7 +352,7 @@ EXPORT_SYMBOL_GPL(eventfd_fget);
  * Returns a pointer to the internal eventfd context, otherwise the error
  * pointers returned by the following functions:
  *
- * eventfd_fget
+ * fdget
  */
 struct eventfd_ctx *eventfd_ctx_fdget(int fd)
 {
-- 
2.19.1

