Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB55D2427CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgHLJnT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 05:43:19 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:37356 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgHLJnT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 05:43:19 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 68D2CE2067FFFE97BEB1;
        Wed, 12 Aug 2020 17:43:16 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 07C9h3tN084104;
        Wed, 12 Aug 2020 17:43:03 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020081217432418-4584713 ;
          Wed, 12 Aug 2020 17:43:24 +0800 
From:   Yi Wang <wang.yi59@zte.com.cn>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn, Liao Pingfang <liao.pingfang@zte.com.cn>
Subject: [PATCH] fs: Fix some comments in open.c and read_write.c
Date:   Wed, 12 Aug 2020 17:46:28 +0800
Message-Id: <1597225588-7737-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-08-12 17:43:24,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-08-12 17:43:06,
        Serialize complete at 2020-08-12 17:43:06
X-MAIL: mse-fl1.zte.com.cn 07C9h3tN084104
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Liao Pingfang <liao.pingfang@zte.com.cn>

Correct comments in open.c, since the parameter(opened/cred)
is not used anymore. Also correct size to maxsize in
read_write.c.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
Signed-off-by: Yi Wang <wang.yi59@zte.com.cn>
---
 fs/open.c       | 2 --
 fs/read_write.c | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index c80e9f497e9b..fa54a7d313e9 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -875,7 +875,6 @@ static int do_dentry_open(struct file *f,
  * @file: file pointer
  * @dentry: pointer to dentry
  * @open: open callback
- * @opened: state of open
  *
  * This can be used to finish opening a file passed to i_op->atomic_open().
  *
@@ -929,7 +928,6 @@ EXPORT_SYMBOL(file_path);
  * vfs_open - open the file at the given path
  * @path: path to open
  * @file: newly allocated file with f_flag initialized
- * @cred: credentials to use
  */
 int vfs_open(const struct path *path, struct file *file)
 {
diff --git a/fs/read_write.c b/fs/read_write.c
index 5db58b8c78d0..058563ee26fd 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -71,7 +71,7 @@ EXPORT_SYMBOL(vfs_setpos);
  * @file:	file structure to seek on
  * @offset:	file offset to seek to
  * @whence:	type of seek
- * @size:	max size of this file in file system
+ * @maxsize:	max size of this file in file system
  * @eof:	offset used for SEEK_END position
  *
  * This is a variant of generic_file_llseek that allows passing in a custom
-- 
2.26.1

