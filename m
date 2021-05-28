Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C990E39444D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 May 2021 16:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbhE1Okw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 May 2021 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhE1Okv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 May 2021 10:40:51 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A182C061574;
        Fri, 28 May 2021 07:39:17 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id m8-20020a17090a4148b029015fc5d36343so2655236pjg.1;
        Fri, 28 May 2021 07:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=66dg2aaZ9e2L3aFdWXYXkm2XrdcrMJS707lfJTzmtCY=;
        b=Xb1BfpJq+Eum4Z4MQlu7foWRpLwG6F0G7ft7/+WDftmPWvGNVXa9A/NYiEvDo87OsH
         VY4JSb5IBSGqKIyphxbq+/mYgjdeIWES1B93/Vl+kFgTWpWR6Vmwid6mZn0UFLaIOEkY
         H99C09dsRz/QcfjrMlYJtFv5NBQ3tPqXQXeKWgtHFikB3XeHP6NuUQZBZ3ejR17O+GAK
         E+4xkSHvd7cNkeVuShZgcAWnd+jb/VEej7idwKtU3fhMAHzyV90ahN0wVRcaxgttdKr3
         XQY+KsO77yGQe1/M2YTxDi9+H9POYxNzPmwopCd3bqUSCk4yLbW5XzAw9Y34lEWrjQvh
         hQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66dg2aaZ9e2L3aFdWXYXkm2XrdcrMJS707lfJTzmtCY=;
        b=BZBUijfJVMx4hbI3xeRYQGt6xxMfaBdJc/l5+27Xu2hP0z10rtFOzBIrpZbApglw87
         QXHKG7fornQSrfBmeCqCiE7onh3XTsSsnzBDu2m+VCPenBwdTVx+443rgPWSlDLd7Jht
         l+ng6/nwyZQveXoaX0tSZjAQENRlm4oQ1ZmJeEzdsw5/1uX9brpS/J99F/3p3mbdkJC0
         TJVp00tjZ83/mPdQt5nRImn1CaixlXz1t3myrbEGFb7rAHJGprpcGcYCXaN27H8Z8gp9
         GT5XeNJaH/QByCnySihwKFbdhNIuSAnBHoOfUqnBbRf2ip8qNhxKnvaP3zbmZ4OaZDsQ
         4EFQ==
X-Gm-Message-State: AOAM531pngOK8bPMKzSnwKATj0VzQO/b2xOmkQvLI97fYu1d5rxXHOV0
        /8sXW5In4f8Q6TR9mgYMLjg=
X-Google-Smtp-Source: ABdhPJz5O7Iayy4Dw9I19ug4/Xwa4+w87oYEhUJmagxvgbrVIwwTQrOlFjB90CKa0isXKNEEyJK0Pg==
X-Received: by 2002:a17:902:e542:b029:f8:1d1e:fc3a with SMTP id n2-20020a170902e542b02900f81d1efc3amr8481033plf.30.1622212756657;
        Fri, 28 May 2021 07:39:16 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id d13sm4384712pfn.136.2021.05.28.07.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 07:39:16 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     mhiramat@kernel.org, mcgrof@kernel.org, josh@joshtriplett.org
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        jeyu@kernel.org, masahiroy@kernel.org, dong.menglong@zte.com.cn,
        joe@perches.com, axboe@kernel.dk, jack@suse.cz, hare@suse.de,
        tj@kernel.org, gregkh@linuxfoundation.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, f.fainelli@gmail.com,
        wangkefeng.wang@huawei.com, arnd@arndb.de,
        linux@rasmusvillemoes.dk, brho@google.com, rostedt@goodmis.org,
        vbabka@suse.cz, pmladek@suse.com, glider@google.com,
        chris@chrisdown.name, jojing64@gmail.com, ebiederm@xmission.com,
        mingo@kernel.org, terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: [PATCH v3 1/3] init/main.c: introduce function ramdisk_exec_exist()
Date:   Fri, 28 May 2021 22:38:00 +0800
Message-Id: <20210528143802.78635-2-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210528143802.78635-1-dong.menglong@zte.com.cn>
References: <20210528143802.78635-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Menglong Dong <dong.menglong@zte.com.cn>

Introduce the function ramdisk_exec_exist, which is used to check the
exist of 'ramdisk_execute_command'.

To make path lookup follow the mount on '/', use vfs_path_lookup() in
init_eaccess(), and make the filesystem that mounted on '/' as root
during path lookup.

Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>
---
 fs/init.c   | 11 +++++++++--
 init/main.c |  7 ++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/fs/init.c b/fs/init.c
index 5c36adaa9b44..166356a1f15f 100644
--- a/fs/init.c
+++ b/fs/init.c
@@ -112,14 +112,21 @@ int __init init_chmod(const char *filename, umode_t mode)
 
 int __init init_eaccess(const char *filename)
 {
-	struct path path;
+	struct path path, root;
 	int error;
 
-	error = kern_path(filename, LOOKUP_FOLLOW, &path);
+	error = kern_path("/", LOOKUP_DOWN, &root);
 	if (error)
 		return error;
+	error = vfs_path_lookup(root.dentry, root.mnt, filename,
+				LOOKUP_FOLLOW, &path);
+	if (error)
+		goto on_err;
 	error = path_permission(&path, MAY_ACCESS);
+
 	path_put(&path);
+on_err:
+	path_put(&root);
 	return error;
 }
 
diff --git a/init/main.c b/init/main.c
index eb01e121d2f1..1153571ca977 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1522,6 +1522,11 @@ void __init console_on_rootfs(void)
 	fput(file);
 }
 
+bool __init ramdisk_exec_exist(void)
+{
+	return init_eaccess(ramdisk_execute_command) == 0;
+}
+
 static noinline void __init kernel_init_freeable(void)
 {
 	/*
@@ -1568,7 +1573,7 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-	if (init_eaccess(ramdisk_execute_command) != 0) {
+	if (!ramdisk_exec_exist()) {
 		ramdisk_execute_command = NULL;
 		prepare_namespace();
 	}
-- 
2.32.0.rc0

