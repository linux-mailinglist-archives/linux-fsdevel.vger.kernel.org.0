Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F935265F4D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 14:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725780AbgIKMM7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 08:12:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725783AbgIKMLc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 08:11:32 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4C6B46DF8163FCC39842;
        Fri, 11 Sep 2020 20:09:48 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 20:09:44 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] fs: Fix 'mnt' kernel-doc warning in namespace.c
Date:   Fri, 11 Sep 2020 20:07:02 +0800
Message-ID: <20200911120702.71509-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

fs/namespace.c:1358: warning: Excess function parameter 'mnt' description in 'may_umount_tree'

Rename mnt to m.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 098f981dce5..9f9a2664dd7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1358,7 +1358,7 @@ void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor)
 
 /**
  * may_umount_tree - check if a mount tree is busy
- * @mnt: root of mount tree
+ * @m: root of mount tree
  *
  * This is called to check if a tree of mounts has any
  * open files, pwds, chroots or sub mounts that are
-- 
2.17.1

