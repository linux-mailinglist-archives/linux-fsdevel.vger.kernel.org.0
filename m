Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33D8744BBAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Nov 2021 07:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbhKJGcN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Nov 2021 01:32:13 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:45772 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229765AbhKJGcM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Nov 2021 01:32:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R221e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0Uvrwkfz_1636525756;
Received: from e02h04404.eu6sqa(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0Uvrwkfz_1636525756)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 10 Nov 2021 14:29:24 +0800
From:   Wen Gu <guwen@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk, jlayton@kernel.org, bfields@fieldses.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        dust.li@linux.alibaba.com, tonylu@linux.alibaba.com,
        xuanzhuo@linux.alibaba.com, guwen@linux.alibaba.com
Subject: [PATCH] fasync: Use tabs instead of spaces in code indent
Date:   Wed, 10 Nov 2021 14:29:16 +0800
Message-Id: <1636525756-68970-1-git-send-email-guwen@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When I investigated about fasync_list in SMC network subsystem,
I happened to find that here uses spaces instead of tabs in code
indent and fix this by the way.

Fixes: f7347ce4ee7c ("fasync: re-organize fasync entry insertion to
allow it under a spinlock")
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
---
 fs/fcntl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9c6c6a3..36ba188 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -927,7 +927,7 @@ void fasync_free(struct fasync_struct *new)
  */
 struct fasync_struct *fasync_insert_entry(int fd, struct file *filp, struct fasync_struct **fapp, struct fasync_struct *new)
 {
-        struct fasync_struct *fa, **fp;
+	struct fasync_struct *fa, **fp;
 
 	spin_lock(&filp->f_lock);
 	spin_lock(&fasync_lock);
-- 
1.8.3.1

