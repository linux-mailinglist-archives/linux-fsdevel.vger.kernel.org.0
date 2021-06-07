Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147EE39D337
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 04:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbhFGDBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 23:01:35 -0400
Received: from m12-12.163.com ([220.181.12.12]:45644 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230127AbhFGDBf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 23:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=SyLog
        QgsUFlwI3keA+SvLLHXphH+aEl3tcIoGEni7WA=; b=cFUClBN6heqfy3G8NX78M
        d6CbI51blUJz61Tpp6cBvsCRMf+29Ri5iYYbGQUY41f4ybeEfFs7XEabt4Zk5myh
        8TM0ax24Cvp7y+zqVyP06PM3w8olEEekDrB9xiVmD/53GkA9ByTSeKrKd8jG6VYD
        GsRzsRjfaGowWZRT7kO5wk=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowAA3P7eci71gf+YCIg--.644S2;
        Mon, 07 Jun 2021 10:59:41 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH v2] fs: pnode: Fix a typo
Date:   Mon,  7 Jun 2021 10:58:38 +0800
Message-Id: <20210607025838.96841-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAA3P7eci71gf+YCIg--.644S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry3WF4xWFyUtF17WrW3ZFb_yoWxuFc_Xa
        1xuw1ru395t397Zrs3Z3yvvF9Fq39rur1Fkwn7tF9xJa4UJrs0grZrua4kZr1DAFsrXas8
        Wa1xCrnakF12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnpc_7UUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiSh2qUFPAOmRIhAAAss
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'accross' to 'across'.

Signed-off-by: lijian <lijian@yulong.com>
---
v2: Fix the an/a mismatch too, change 'an' to 'a'.
 fs/pnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index f05f28632f5d..4d40f5a4ef7b 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -573,7 +573,7 @@ int propagate_umount(struct list_head *list)
 				continue;
 			} else if (child->mnt.mnt_flags & MNT_UMOUNT) {
 				/*
-				 * We have come across an partially unmounted
+				 * We have come across a partially unmounted
 				 * mount in list that has not been visited yet.
 				 * Remember it has been visited and continue
 				 * about our merry way.
-- 
2.25.1


