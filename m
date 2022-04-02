Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412384EFFA9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239203AbiDBIYX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 04:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239213AbiDBIYV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 04:24:21 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F92228C;
        Sat,  2 Apr 2022 01:22:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V8ygiC._1648887744;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V8ygiC._1648887744)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 02 Apr 2022 16:22:25 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] vfs: fs_context: Fix some kernel-doc comments
Date:   Sat,  2 Apr 2022 16:22:22 +0800
Message-Id: <20220402082222.114428-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

fs/fs_context.c:202: warning: Function parameter or member 'fc' not
described in 'generic_parse_monolithic'
fs/fs_context.c:202: warning: Excess function parameter 'ctx'
description in 'generic_parse_monolithic'
fs/fs_context.c:340: warning: expecting prototype for
vfs_dup_fc_config(). Prototype was for vfs_dup_fs_context() instead
fs/fs_context.c:386: warning: Function parameter or member 'log' not
described in 'logfc'
fs/fs_context.c:386: warning: Function parameter or member 'prefix' not
described in 'logfc'
fs/fs_context.c:386: warning: Function parameter or member 'level' not
described in 'logfc'
fs/fs_context.c:386: warning: Excess function parameter 'fc' description
in 'logfc'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/fs_context.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 24ce12f0db32..be2bce5fe66d 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -189,7 +189,8 @@ EXPORT_SYMBOL(vfs_parse_fs_string);
 
 /**
  * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
- * @ctx: The superblock configuration to fill in.
+ * @fc: Filesystem context for holding the parameters used in the creation or
+ *	reconfiguration of a superblock.
  * @data: The data to parse
  *
  * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
@@ -333,7 +334,7 @@ void fc_drop_locked(struct fs_context *fc)
 static void legacy_fs_context_free(struct fs_context *fc);
 
 /**
- * vfs_dup_fc_config: Duplicate a filesystem context.
+ * vfs_dup_fs_context: Duplicate a filesystem context.
  * @src_fc: The context to copy.
  */
 struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
@@ -379,7 +380,9 @@ EXPORT_SYMBOL(vfs_dup_fs_context);
 
 /**
  * logfc - Log a message to a filesystem context
- * @fc: The filesystem context to log to.
+ * @log: The filesystem context to log to.
+ * @prefix: The log prefix.
+ * @level: The log level.
  * @fmt: The format of the buffer.
  */
 void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt, ...)
-- 
2.20.1.7.g153144c

