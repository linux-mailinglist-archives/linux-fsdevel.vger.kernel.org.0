Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19ED755C63
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jul 2023 09:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjGQHHS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jul 2023 03:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjGQHHQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:07:16 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889831AE
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 00:07:14 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4CnX20H1zBQHHX
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jul 2023 15:07:12 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689577632; x=1692169633; bh=TRPMaZ7z6lfdqj4fssGi4QAIMSX
        OwcQSbEONR5PWssc=; b=PqGqTThuhKaNQaa/4hsPx5DrWpN/VNRzCx9Na/JnKI0
        FFHzQu2oMdBP2GHFLXC3R9WY+i/ZpFNUNt3iovUPhlq1YkH0PeNP67k1y0eOPBR+
        yIWI2vTGrlnpcxcudPhUstdsS3Nsx9d6bQD8O9JWyRf5aha7VHPssS/JnGbIYiRq
        WvD7UR/pVH9mFbZZixksqMb6wXA+SMeqYGYjSFf6kmahiNa+tJujC+mWmD6hjTjZ
        62hSDg/XF9BBLoqQTZjga91BjOeT2IVmo1syjnejTSXZKVw/nwgdDcmEO2rzM/+4
        rlLIergdgGUvgNMouMABRtIEOZlPvo9hyTDGfhEQqQg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PTE0PLT8siIU for <linux-fsdevel@vger.kernel.org>;
        Mon, 17 Jul 2023 15:07:12 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4CnX000dzBJR3x;
        Mon, 17 Jul 2023 15:07:11 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 15:07:11 +0800
From:   wuyonggang001@208suo.com
To:     viro@zeniv.linux.org.uk, brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/filesystems.c: ERROR: "(foo*)" should be "(foo *)"
In-Reply-To: <20230717070500.38410-1-zhanglibing@cdjrlc.com>
References: <20230717070500.38410-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <a456720721d2f8fc33bb0befbe2ad115@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix five occurrences of the checkpatch.pl error:
ERROR: "(foo*)" should be "(foo *)"

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  fs/filesystems.c | 20 ++++++++++----------
  1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 58b9067b2391..6a93b4904d27 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -69,10 +69,10 @@ static struct file_system_type 
**find_filesystem(const char *name, unsigned len)
   *    unregistered.
   */

-int register_filesystem(struct file_system_type * fs)
+int register_filesystem(struct file_system_type *fs)
  {
      int res = 0;
-    struct file_system_type ** p;
+    struct file_system_type **p;

      if (fs->parameters &&
          !fs_validate_description(fs->name, fs->parameters))
@@ -105,9 +105,9 @@ EXPORT_SYMBOL(register_filesystem);
   *    may be freed or reused.
   */

-int unregister_filesystem(struct file_system_type * fs)
+int unregister_filesystem(struct file_system_type *fs)
  {
-    struct file_system_type ** tmp;
+    struct file_system_type **tmp;

      write_lock(&file_systems_lock);
      tmp = &file_systems;
@@ -129,9 +129,9 @@ int unregister_filesystem(struct file_system_type * 
fs)
  EXPORT_SYMBOL(unregister_filesystem);

  #ifdef CONFIG_SYSFS_SYSCALL
-static int fs_index(const char __user * __name)
+static int fs_index(const char __user *__name)
  {
-    struct file_system_type * tmp;
+    struct file_system_type *tmp;
      struct filename *name;
      int err, index;

@@ -153,9 +153,9 @@ static int fs_index(const char __user * __name)
      return err;
  }

-static int fs_name(unsigned int index, char __user * buf)
+static int fs_name(unsigned int index, char __user *buf)
  {
-    struct file_system_type * tmp;
+    struct file_system_type *tmp;
      int len, res;

      read_lock(&file_systems_lock);
@@ -175,7 +175,7 @@ static int fs_name(unsigned int index, char __user * 
buf)

  static int fs_maxindex(void)
  {
-    struct file_system_type * tmp;
+    struct file_system_type *tmp;
      int index;

      read_lock(&file_systems_lock);
@@ -236,7 +236,7 @@ int __init list_bdev_fs_names(char *buf, size_t 
size)
  #ifdef CONFIG_PROC_FS
  static int filesystems_proc_show(struct seq_file *m, void *v)
  {
-    struct file_system_type * tmp;
+    struct file_system_type *tmp;

      read_lock(&file_systems_lock);
      tmp = file_systems;
