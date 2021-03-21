Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3130C343182
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Mar 2021 07:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbhCUGQy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Mar 2021 02:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhCUGQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Mar 2021 02:16:26 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5107BC061574;
        Sat, 20 Mar 2021 23:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
        :Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Br1uGt6D1+jXGWTW1CUN2cJ2ukPw7FkusMkCoPTdIg0=; b=RfQCFWS3NRK2z1CuuDGmTLaTN+
        V6ms5ObqVZn4RUgEnNxoZ2ab8grkXebFWDsSR/9u2SycKLXDuCNMIJksR4twPZUkqav0vGyspiHz/
        ZzeaLe9Z4Xf05M2vNq4DDl4+2ezjpb3qY0Q+RxpQW1w2hrirSOYVMr8aAZqBdGAqbRnsmMz8yNvF3
        /Z4CuQV0yhBX+C3UkyTrY0FR4UU7qqBu3d+BuipklNJIoCMnYOB7PMqhZZ9Pf2OBDH+lbFuMxlLQ0
        bIGTOdHDAFmGkTAUOgjqWmXanJr057RIfy9tcXrkpgWftGWpVrOwUb/boXaNagJ2J6U/oLfgYfgK1
        zGe2yrvA==;
Received: from [2601:1c0:6280:3f0::3ba4] (helo=smtpauth.infradead.org)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lNrNu-009emY-Q0; Sun, 21 Mar 2021 06:16:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: fs_context: make it be kernel-doc clean
Date:   Sat, 20 Mar 2021 23:16:18 -0700
Message-Id: <20210321061618.17754-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Modify fs/fs_context.c to be kernel-doc clean.
Use "Return:" notation for function return values.
Add or modify function parameter descriptions as needed.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
---
 fs/fs_context.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- linux-next-20210319.orig/fs/fs_context.c
+++ linux-next-20210319/fs/fs_context.c
@@ -92,7 +92,7 @@ static int vfs_parse_sb_flag(struct fs_c
  *
  * This may be called multiple times for a context.
  *
- * Returns 0 on success and a negative error code on failure.  In the event of
+ * Return: %0 on success and a negative error code on failure.  In the event of
  * failure, supplementary error information may have been set.
  */
 int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param)
@@ -139,6 +139,10 @@ EXPORT_SYMBOL(vfs_parse_fs_param);
 
 /**
  * vfs_parse_fs_string - Convenience function to just parse a string.
+ * @fc: The filesystem context for this config option
+ * @key: The string option's name
+ * @value: The string option's value (optional)
+ * @v_size: Length of the @value string
  */
 int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			const char *value, size_t v_size)
@@ -166,13 +170,13 @@ EXPORT_SYMBOL(vfs_parse_fs_string);
 
 /**
  * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
- * @ctx: The superblock configuration to fill in.
+ * @fc: The superblock configuration to fill in.
  * @data: The data to parse
  *
  * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
  * called from the ->monolithic_mount_data() fs_context operation.
  *
- * Returns 0 on success or the error returned by the ->parse_option() fs_context
+ * Return: %0 on success or the error returned by the ->parse_option() fs_context
  * operation on failure.
  */
 int generic_parse_monolithic(struct fs_context *fc, void *data)
@@ -310,7 +314,7 @@ void fc_drop_locked(struct fs_context *f
 static void legacy_fs_context_free(struct fs_context *fc);
 
 /**
- * vfs_dup_fc_config: Duplicate a filesystem context.
+ * vfs_dup_fs_context - Duplicate a filesystem context.
  * @src_fc: The context to copy.
  */
 struct fs_context *vfs_dup_fs_context(struct fs_context *src_fc)
@@ -356,7 +360,9 @@ EXPORT_SYMBOL(vfs_dup_fs_context);
 
 /**
  * logfc - Log a message to a filesystem context
- * @fc: The filesystem context to log to.
+ * @log: The filesystem context to log to.
+ * @prefix: message prefix
+ * @level: kernel log message level
  * @fmt: The format of the buffer.
  */
 void logfc(struct fc_log *log, const char *prefix, char level, const char *fmt, ...)
