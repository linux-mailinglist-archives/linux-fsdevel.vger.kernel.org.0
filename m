Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1339D2E6
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 04:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhFGC1w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Jun 2021 22:27:52 -0400
Received: from m12-12.163.com ([220.181.12.12]:57565 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230133AbhFGC1v (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Jun 2021 22:27:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wkYGf
        G0VOwDbDdWvIeVoQ4i0Kfy46FnrWTIrgD4+t7Y=; b=VM/r1vJATl0ZjxcUqaGTd
        hdDRBZgyeO2U7hVsK6x6WuwfjtoKE7Ye2at6heyH+ppwZoTjt9okAS6AgSzSOI/M
        mt+9P/2ZWWZD+Us9CsQTFp24nYp+fMP1wJ2qU2VYyLl9AFHG1GlQQW7tvbHlaHCa
        ZtUxP44p6g8ihZ5ibn99C4=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowACHe8e1g71gJMT+IQ--.221S2;
        Mon, 07 Jun 2021 10:25:58 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: pnode: Fix a typo
Date:   Mon,  7 Jun 2021 10:24:56 +0800
Message-Id: <20210607022456.66124-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowACHe8e1g71gJMT+IQ--.221S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrJr1DtFWDWFyDXFWDJryDtrb_yoWxWFg_Za
        17Zr4ru3ykt3yxZws3Z3ySyFy0q39rur1FywnrJr9xJ34UA3Z0gr9rua4DZr1UArsrZas8
        Wa1xCrn3CF15WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnMCJDUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiRReqUFl91-FaGQAAsp
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'accross' to 'across'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/pnode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index 1106137c747a..f05f28632f5d 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -573,7 +573,7 @@ int propagate_umount(struct list_head *list)
 				continue;
 			} else if (child->mnt.mnt_flags & MNT_UMOUNT) {
 				/*
-				 * We have come accross an partially unmounted
+				 * We have come across an partially unmounted
 				 * mount in list that has not been visited yet.
 				 * Remember it has been visited and continue
 				 * about our merry way.
-- 
2.25.1


