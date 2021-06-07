Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7C339D4F9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jun 2021 08:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbhFGGfQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Jun 2021 02:35:16 -0400
Received: from m12-14.163.com ([220.181.12.14]:52593 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229545AbhFGGfQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Jun 2021 02:35:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=y/X18
        uRpnqtljL+RMDssIh68K1hPqzLYkK1yRT0fxe0=; b=MNmOj8bZHGTAuUb24U3J8
        iDn24Fn9OfpAL5z0gZE6f2++oHAiGZfoawDH+YYfeDys53yZtSauTyB51mVf5l3p
        eBnGq00GSl0fllz+Md4In1bKSZ39/gGPVuIqOIMO5KQUVnmxQ2ryBk1hxDDFOFic
        bF0xqF37oeppYDGGa8H6rg=
Received: from localhost.localdomain (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowAAnGoWzvb1gwCN2NQ--.44785S2;
        Mon, 07 Jun 2021 14:33:23 +0800 (CST)
From:   lijian_8010a29@163.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
Subject: [PATCH] fs: inode: Fix a typo
Date:   Mon,  7 Jun 2021 14:32:26 +0800
Message-Id: <20210607063226.205255-1-lijian_8010a29@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAnGoWzvb1gwCN2NQ--.44785S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWDKry5WF1rZF15tr43Jrb_yoWkCFX_tF
        yxJ34xW34UXwn2va9rC3Z8Jasa9r4kuF15uanYqr98Ga4Uta9rur4DCrZ7ur4UCF47ua90
        vF1kWFyxGr12qjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeb6pJUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5olmxttqbyiikqdsmqqrwthudrp/1tbiqxSqUFUMZuiXVQAAsQ
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: lijian <lijian@yulong.com>

Change 'funtion' to 'function', and
change 'priviledges' to 'privileges'.

Signed-off-by: lijian <lijian@yulong.com>
---
 fs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index c93500d84264..fd00657184f2 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1429,7 +1429,7 @@ EXPORT_SYMBOL(ilookup);
  * function must never block --- find_inode() can block in
  * __wait_on_freeing_inode() --- or when the caller can not increment
  * the reference count because the resulting iput() might cause an
- * inode eviction.  The tradeoff is that the @match funtion must be
+ * inode eviction.  The tradeoff is that the @match function must be
  * very carefully implemented.
  */
 struct inode *find_inode_nowait(struct super_block *sb,
@@ -1926,7 +1926,7 @@ static int __remove_privs(struct user_namespace *mnt_userns,
 }
 
 /*
- * Remove special file priviledges (suid, capabilities) when file is written
+ * Remove special file privileges (suid, capabilities) when file is written
  * to or truncated.
  */
 int file_remove_privs(struct file *file)
-- 
2.25.1

