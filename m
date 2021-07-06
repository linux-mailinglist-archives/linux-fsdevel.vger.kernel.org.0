Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFC6D3BC4E5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jul 2021 04:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGFCtZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jul 2021 22:49:25 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:35529 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229781AbhGFCtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jul 2021 22:49:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UetsiYs_1625539605;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0UetsiYs_1625539605)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 06 Jul 2021 10:46:45 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     miklos@szeredi.hu
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH] fuse: fuse_lookup_name() cleanup
Date:   Tue,  6 Jul 2021 10:46:45 +0800
Message-Id: <20210706024645.4404-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove unused logic since it has been checked previously.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/fuse/dir.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 1b6c001a7dd1..fa4d010f877a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -431,8 +431,6 @@ int fuse_lookup_name(struct super_block *sb, u64 nodeid, const struct qstr *name
 		goto out_put_forget;
 
 	err = -EIO;
-	if (!outarg->nodeid)
-		goto out_put_forget;
 	if (fuse_invalid_attr(&outarg->attr))
 		goto out_put_forget;
 
-- 
2.27.0

