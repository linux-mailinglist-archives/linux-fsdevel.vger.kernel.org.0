Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EFE39C58E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Jun 2021 05:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFEDsU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Jun 2021 23:48:20 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43632 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhFEDsT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Jun 2021 23:48:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id e22so9353639pgv.10;
        Fri, 04 Jun 2021 20:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q5AeDLf+a8AwPCCUtEt+QawZwpPhzutW1uszRngdpoY=;
        b=UEgF4gW/UCsSbJHt5erm4kwHu+aH/ShI3iNWDGHTEKL6OiTJMmHFlcjJn9PSnh0LQl
         3qbRnTZ1no6LWp3ACKk+AaiPVWrwRuZJvxj9rSailecx/aI2ApAe0SPllW8QGEnc4OyH
         RNuZpwrPMz5Tgjfx14VZZx9ivrXAWdLFoJgFozgijXvihDRkrrhLW49Sv6iDg6RkDv7D
         M9ptj4F2I6onW6afTgJI7KX1KvLkHhY4Ve3UPfFOyWdATMIPUPVFU+1ZGoDt851dPVTO
         PM04OUppaW2PTkjCdk2ESuGRhq4Y3PW4aB78l56cfo4nvCtFybTPj9IQLo9nTLvDqZ20
         IJzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q5AeDLf+a8AwPCCUtEt+QawZwpPhzutW1uszRngdpoY=;
        b=QE1Z5EQEiakKXAUr+5STOo21OuNjuU3Z3RPU3M3lNlU6xtjN0pjggiUpi3bZ7+wTpq
         4Lf2SDiG8+gKJ8LsZ6soT08SsFLMopqcc52/Xz62v1XzrG7bghhGI9kXQLM6W7ny3iD/
         lVX7Q+usZBIK1Bw08Rx2CoZAfKWDfSAz74oBxt9d9yqOebfNfHOmY39ib6XfcVJTzQrZ
         fffHM+vBsCJetLQHqpTJuBYZrikT0sCzImMKWSmSyMRw0/8uLlwMsq+3J7aA9scQGOJf
         1Ms9JjLViyiyuarloduseV8Bq8idDKxVmOJcJIzCOhRYQnuPVkRNUg17/Tj4KcjJDzex
         QMTg==
X-Gm-Message-State: AOAM533hW24h8V7poBQuu4g5cTO/tR7eSDJCHhP82ciZCle1NzRYvEBo
        F5Ar+t6MYCkWXeixHCwlZ08=
X-Google-Smtp-Source: ABdhPJyvEKjN1WPmdRE8I796ORw/HdPBwZMSwF/zyPGtLNmyZIQRA/TfMkKM/ZR94XQLLgQ+OVe5YQ==
X-Received: by 2002:a62:7b4c:0:b029:2e9:cec2:e252 with SMTP id w73-20020a627b4c0000b02902e9cec2e252mr7595128pfc.56.1622864717110;
        Fri, 04 Jun 2021 20:45:17 -0700 (PDT)
Received: from localhost ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id d22sm3040006pgb.15.2021.06.04.20.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 20:45:16 -0700 (PDT)
From:   menglong8.dong@gmail.com
X-Google-Original-From: dong.menglong@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     viro@zeniv.linux.org.uk, keescook@chromium.org,
        samitolvanen@google.com, johan@kernel.org, ojeda@kernel.org,
        jeyu@kernel.org, masahiroy@kernel.org, joe@perches.com,
        dong.menglong@zte.com.cn, jack@suse.cz, hare@suse.de,
        axboe@kernel.dk, tj@kernel.org, gregkh@linuxfoundation.org,
        song@kernel.org, neilb@suse.de, akpm@linux-foundation.org,
        linux@rasmusvillemoes.dk, brho@google.com, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        mhiramat@kernel.org, rostedt@goodmis.org, vbabka@suse.cz,
        glider@google.com, pmladek@suse.com, johannes.berg@intel.com,
        ebiederm@xmission.com, jojing64@gmail.com, terrelln@fb.com,
        geert@linux-m68k.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org, arnd@arndb.de,
        chris@chrisdown.name, mingo@kernel.org, bhelgaas@google.com,
        josh@joshtriplett.org
Subject: [PATCH v6 1/2] init/main.c: introduce function ramdisk_exec_exist()
Date:   Sat,  5 Jun 2021 11:44:46 +0800
Message-Id: <20210605034447.92917-2-dong.menglong@zte.com.cn>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210605034447.92917-1-dong.menglong@zte.com.cn>
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
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

