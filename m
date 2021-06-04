Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAFE39B8C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jun 2021 14:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhFDMK6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 08:10:58 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:35427 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbhFDMK5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 08:10:57 -0400
Received: by mail-pj1-f67.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso782264pjb.0;
        Fri, 04 Jun 2021 05:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5AeDLf+a8AwPCCUtEt+QawZwpPhzutW1uszRngdpoY=;
        b=mQH0p1hklRohnNjFflO5qe2hUl4fNx3TosjHJpuSg9VkHI1Za500AdQQCVcdVdnnEh
         P5YjwtvJypeJLUWDFh/apOYD/FkeKS9QMG9fgo7QwBHJaWY3haCA+pquckk/MJJZv4xG
         p1vuNlZk13Gw4vGjGzKutbA5WM5Gx1BcjouOVZWsHGc8+Hv3oZIbeTSnTJvmxoM4gcLf
         foee6Udv9mMIyCmfaRCNGg4DILmBg2RTzPwvFa9lN0vishSGKzPe8vdNhbNzFYtgAZHi
         HvrVqKwbhKFNb7nYlBt9L9leuTOUHE8PvRBjn3Ra7dHa//n6/f6t9+GBPR0oSmh2b2KQ
         UOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5AeDLf+a8AwPCCUtEt+QawZwpPhzutW1uszRngdpoY=;
        b=ok6AFoWORqppgp5ydm3Q+2+l54BC7ooN1fRs8Buz4ft8am2aiJxSG1PnYJMnY+8s0j
         s5c6yHq8Nn1pL/M3IkZI0JBXzZ2fbFFRBL/a/m7pwxrIO8WYa+jj2NJDn4c2W8ZtC5S0
         WfXRGpM4RpyaF6u+FEKn5FLeXaI/7+86SlOIGj4NIciaeuWrvEg/AyrguWa4/bNoRp2n
         5ybXnysFYgFinLzaZG3J8sHd0JSzxFlLys8t7PVTjan3OEZSqRcT0EPke8Ifg33EiL8T
         ufQyBGkHLwaOaQi1qGm4XUMTBtl495KdyPVsB+yZ6iOuJ/SXrUvhym4yGR+IDyXjZhJi
         vC2w==
X-Gm-Message-State: AOAM531lUgDF/FKLGxBDOmptSngXjZJEZ8fJQlkgGv8dcKrTJVkOjhBR
        dW1z04MJjMpAmeCl7JRMw3w=
X-Google-Smtp-Source: ABdhPJykHZSJ0ykpKhEFCQ4K4+JpyKhc2eys4cJJ56kHXIRI5D4BUpx3GfQvayLbjXjeCwRZTpj+sA==
X-Received: by 2002:a17:90b:30d0:: with SMTP id hi16mr4544237pjb.30.1622808478886;
        Fri, 04 Jun 2021 05:07:58 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id ev11sm4779146pjb.36.2021.06.04.05.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 05:07:58 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, ojeda@kernel.org, johan@kernel.org,
        elver@google.com, masahiroy@kernel.org, dong.menglong@zte.com.cn,
        joe@perches.com, axboe@kernel.dk, hare@suse.de, jack@suse.cz,
        gregkh@linuxfoundation.org, tj@kernel.org, song@kernel.org,
        neilb@suse.de, akpm@linux-foundation.org, f.fainelli@gmail.com,
        arnd@arndb.de, palmerdabbelt@google.com,
        wangkefeng.wang@huawei.com, linux@rasmusvillemoes.dk,
        brho@google.com, mhiramat@kernel.org, rostedt@goodmis.org,
        vbabka@suse.cz, pmladek@suse.com, glider@google.com,
        chris@chrisdown.name, ebiederm@xmission.com, jojing64@gmail.com,
        geert@linux-m68k.org, mingo@kernel.org, terrelln@fb.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, jeyu@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: [PATCH v5 1/3] init/main.c: introduce function ramdisk_exec_exist()
Date:   Fri,  4 Jun 2021 05:07:25 -0700
Message-Id: <20210604120727.58410-2-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210604120727.58410-1-dong.menglong@zte.com.cn>
References: <20210604120727.58410-1-dong.menglong@zte.com.cn>
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
 fs/init.c            | 11 +++++++++--
 include/linux/init.h |  1 +
 init/main.c          |  7 ++++++-
 3 files changed, 16 insertions(+), 3 deletions(-)

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
 
diff --git a/include/linux/init.h b/include/linux/init.h
index d82b4b2e1d25..889d538b6dfa 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -149,6 +149,7 @@ extern unsigned int reset_devices;
 void setup_arch(char **);
 void prepare_namespace(void);
 void __init init_rootfs(void);
+bool ramdisk_exec_exist(void);
 extern struct file_system_type rootfs_fs_type;
 
 #if defined(CONFIG_STRICT_KERNEL_RWX) || defined(CONFIG_STRICT_MODULE_RWX)
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

