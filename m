Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA35017A0CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2020 09:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgCEIIG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Mar 2020 03:08:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:11166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725866AbgCEIIG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Mar 2020 03:08:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6DD5911E7967D07B0A0C;
        Thu,  5 Mar 2020 16:08:03 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Mar 2020
 16:08:02 +0800
From:   Yufen Yu <yuyufen@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>
Subject: [PATCH] fs: fix indentation in deactivate_super()
Date:   Thu, 5 Mar 2020 16:06:39 +0800
Message-ID: <20200305080639.3291-1-yuyufen@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix the breaked indent in deactive_super().

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index cd352530eca9..7e3491b96e1d 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -361,7 +361,7 @@ EXPORT_SYMBOL(deactivate_locked_super);
  */
 void deactivate_super(struct super_block *s)
 {
-        if (!atomic_add_unless(&s->s_active, -1, 1)) {
+	if (!atomic_add_unless(&s->s_active, -1, 1)) {
 		down_write(&s->s_umount);
 		deactivate_locked_super(s);
 	}
-- 
2.17.2

