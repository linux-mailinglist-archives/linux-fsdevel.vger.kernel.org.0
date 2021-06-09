Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC43A1AD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jun 2021 18:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhFIQ0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Jun 2021 12:26:10 -0400
Received: from m15112.mail.126.com ([220.181.15.112]:56143 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFIQ0K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Jun 2021 12:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ptM90
        HSZ6sdnNK05Wih+YIg7PGWvyECjSDOjnxjxsP4=; b=St5zOQEZ8BrWcoDt5okHk
        kk4ozNqQImiBZppCOcNx9YI8NWk1V6rNjRKbuAsfbPv974/dE2q78aiUSssp4Zml
        rJDMA0LvlObCUan0vDMfgR7TTnJxG4xzKbRJ/lSpICdj/0cGv6OWlPX2qAVX2/Wb
        7AgoGFts2lBGBKpYFSILsg=
Received: from localhost.localdomain (unknown [120.244.62.156])
        by smtp2 (Coremail) with SMTP id DMmowAB3L0Xv48Bg+Ae1CA--.4846S2;
        Wed, 09 Jun 2021 23:53:20 +0800 (CST)
From:   Jiwei Sun <jiweisun126@126.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jiwei.sun.bj@qq.com, Jiwei Sun <jiweisun126@126.com>
Subject: [PATCH] namei: correct obsolete function name in the comment of follow_automount()
Date:   Wed,  9 Jun 2021 23:53:17 +0800
Message-Id: <20210609155317.2831-1-jiweisun126@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMmowAB3L0Xv48Bg+Ae1CA--.4846S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruF4xWFy8XrWUXF47Zw47Arb_yoW3tFb_Wr
        47WFs7Ww4kXr97AFy7C3y7tryUW3Wjyr1UAr1rKFy7uwn5WFZYyr1qkr4kJas0qrWrXFWY
        kryxGrW5Aw1agjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0RbyJUUUUU==
X-Originating-IP: [120.244.62.156]
X-CM-SenderInfo: 5mlzvxpvxqijaw6rjloofrz/1tbicxCsjVpD9vYxTwAAsl
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function follow_managed() has been renamed to __traverse_mounts() since
commit 9deed3ebca24 ("new helper: traverse_mounts()"). So modify the obsolete
function in the comment.

Signed-off-by: Jiwei Sun <jiweisun126@126.com>
---
 fs/namei.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namei.c b/fs/namei.c
index 216f16e74351..e362c274eac6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1251,7 +1251,7 @@ static bool choose_mountpoint(struct mount *m, const struct path *root,
 
 /*
  * Perform an automount
- * - return -EISDIR to tell follow_managed() to stop and return the path we
+ * - return -EISDIR to tell __traverse_mounts() to stop and return the path we
  *   were called with.
  */
 static int follow_automount(struct path *path, int *count, unsigned lookup_flags)
-- 
2.25.1

