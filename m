Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AEA39D39F
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 05:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhFGDrj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 23:47:39 -0400
Received: from m12-16.163.com ([220.181.12.16]:52819 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230228AbhFGDrh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=luXwd
        fnA94cwGbWujJAKerm1WdPCuBryL5iyyEdSyw4=; b=It02vOeWy3Ptl4WK9c60r
        rpeZkc3JoUN3kO+ZB4Bp80zLYKW/iF9eXApGFDrzIcwWl/YaZCN6SjineXtECtet
        QKKjyLrb1dw1wICfS6K8MFMncjk8pNSbXvi+xe9IzJHPDQQMLiFahxYu1ZktREAA
        rGdk0KAYU8n/gxmUjApk4Q=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowAB3O2lnlr1gI9ffvg--.485S2;
        Mon, 07 Jun 2021 11:45:44 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: namespace: Fix a typo
Date:   Mon,  7 Jun 2021 11:44:47 +0800
Message-Id: <20210607034447.142843-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAB3O2lnlr1gI9ffvg--.485S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrJF45tr4kuFyUtryrGFy5twb_yoWxXFX_Xr
        s7Za10kF4DJr4Uury5Ca4IqF10qr15Cw4IkF43Kry3KFy5XFWruFWvk3yxKr1UuF4Yqa47
        ua9rKr1Yyr1rujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUn9NVDUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiqwiqUFUMZuZ6kgAAso
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'overriden' to 'overridden'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f63337828e1c..d6bd5aa6433a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3182,7 +3182,7 @@ int path_mount(const char *dev_name, struct path *path,
 	if ((flags & SB_MANDLOCK) && !may_mandlock())
 		return -EPERM;
 
-	/* Default to relatime unless overriden */
+	/* Default to relatime unless overridden */
 	if (!(flags & MS_NOATIME))
 		mnt_flags |= MNT_RELATIME;
 
-- 
2.25.1


