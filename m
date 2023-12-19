Return-Path: <linux-fsdevel+bounces-6480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D22B818425
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 10:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858751C23AF8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 09:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8EC134B3;
	Tue, 19 Dec 2023 09:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oyDaiWY3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEB2134B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--alpic.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3366bf4adbcso900947f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Dec 2023 01:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702976953; x=1703581753; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KCOKKTCrhMmhELn2KaA9tA7ePXojaySJZUnrODbepzU=;
        b=oyDaiWY3JkcRZh6LwIo30LyVDU+PLZk3j9VwX2NoD3ufljIaS4xdNasuPMf//+fewn
         tOV3im96Zm83Rtb9CZMS/vyL79KtLuxt0d2bx1UMK+ik2yMGQvYhwJfpqKQHq7QRZvfA
         y2JsFKQcaIZGn8SlHx6eesE5jlQd74wU6b2vwRS/iCZivwVvEpfzk+eWDQXx6EyYtKg7
         DhK9ie6CJM4eZnI0jKJT4d+f2gvjfYM35XUZnxqNmWq7WCahHu7dYlO2UX8dYFMg3KQC
         nU316h2F9RNkCHYoaMHAlH0/AQqVGmfTo4+WlfLuUABKHu+0m2qHEUOrjJAZ2uxsMLpI
         Pitg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702976953; x=1703581753;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCOKKTCrhMmhELn2KaA9tA7ePXojaySJZUnrODbepzU=;
        b=ZCytQugHPTSUzDk7P9q7OwSdpJcsWlMMMQfNMAfsQ/MD8I6bHS3qEFeYujwOav03Vz
         BpwW7N8aM+sXEHPhMb1fBeySTN0uhADK1inMvJ31t7YX8eZrgZqWXLGC1PC7+u7Qqea2
         fjfnJkQf8J+HIckqNqkLY83liePDpc08gLybL5+1zxg/AR8tN/FmaOvjF9FReqbUPn6c
         Mxll6a/uZUGTwZe65c5gmef6iKITvSAwKVxHDrX0WUPyvyvm+RqajugWaAlOQ6wwSEWr
         pSpTS7+w3JqbefV6aV7Kwssj49J4pXhWhSEfKy3LMkEA1B4Zk6KmHeAI6899ZYyVT5c/
         cPXw==
X-Gm-Message-State: AOJu0YzfKfr1vWlA4NFlS1VNskBAzwfVU6CsZeMoCGAmODSDxcTIG2Ek
	wz2HKVSXy50p0B9iTrmvJTs2rqHasw==
X-Google-Smtp-Source: AGHT+IEMgpUJJImbF9sB0A1C2/ml9W2nIwssmwxL5xAbJRxOKk/6C14WdhWsYo1M1JBwCQapz4Lay/+LIA==
X-Received: from alpic.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1bf2])
 (user=alpic job=sendgmr) by 2002:a5d:64a5:0:b0:336:60b6:28a2 with SMTP id
 m5-20020a5d64a5000000b0033660b628a2mr25056wrp.1.1702976952862; Tue, 19 Dec
 2023 01:09:12 -0800 (PST)
Date: Tue, 19 Dec 2023 10:09:09 +0100
In-Reply-To: <20230906102557.3432236-1-alpic@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230906102557.3432236-1-alpic@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231219090909.2827497-1-alpic@google.com>
Subject: [PATCH] security: new security_file_ioctl_compat() hook
From: Alfred Piccioni <alpic@google.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Eric Paris <eparis@parisplace.org>
Cc: linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org, selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alfred Piccioni <alpic@google.com>
Content-Type: text/plain; charset="UTF-8"

Some ioctl commands do not require ioctl permission, but are routed to
other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).

However, if a 32-bit process is running on a 64-bit kernel, it emits
32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
being checked erroneously, which leads to these ioctl operations being
routed to the ioctl permission, rather than the correct file
permissions.

This was also noted in a RED-PEN finding from a while back -
"/* RED-PEN how should LSM module know it's handling 32bit? */".

This patch introduces a new hook, security_file_ioctl_compat, that is
called from the compat ioctl syscall. All current LSMs have been changed
to support this hook.

Reviewing the three places where we are currently using
security_file_ioctl, it appears that only SELinux needs a dedicated
compat change; TOMOYO and SMACK appear to be functional without any
change.

Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
Signed-off-by: Alfred Piccioni <alpic@google.com>
Cc: stable@vger.kernel.org
---
 fs/ioctl.c                    |  3 +--
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  7 +++++++
 security/security.c           | 17 +++++++++++++++++
 security/selinux/hooks.c      | 28 ++++++++++++++++++++++++++++
 security/smack/smack_lsm.c    |  1 +
 security/tomoyo/tomoyo.c      |  1 +
 7 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index f5fd99d6b0d4..76cf22ac97d7 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -920,8 +920,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	if (!f.file)
 		return -EBADF;
 
-	/* RED-PEN how should LSM module know it's handling 32bit? */
-	error = security_file_ioctl(f.file, cmd, arg);
+	error = security_file_ioctl_compat(f.file, cmd, arg);
 	if (error)
 		goto out;
 
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index ac962c4cb44b..626aa8cf930d 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -171,6 +171,8 @@ LSM_HOOK(int, 0, file_alloc_security, struct file *file)
 LSM_HOOK(void, LSM_RET_VOID, file_free_security, struct file *file)
 LSM_HOOK(int, 0, file_ioctl, struct file *file, unsigned int cmd,
 	 unsigned long arg)
+LSM_HOOK(int, 0, file_ioctl_compat, struct file *file, unsigned int cmd,
+	 unsigned long arg)
 LSM_HOOK(int, 0, mmap_addr, unsigned long addr)
 LSM_HOOK(int, 0, mmap_file, struct file *file, unsigned long reqprot,
 	 unsigned long prot, unsigned long flags)
diff --git a/include/linux/security.h b/include/linux/security.h
index 5f16eecde00b..22a82b7c59f1 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -389,6 +389,7 @@ int security_file_permission(struct file *file, int mask);
 int security_file_alloc(struct file *file);
 void security_file_free(struct file *file);
 int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int security_file_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg);
 int security_mmap_file(struct file *file, unsigned long prot,
 			unsigned long flags);
 int security_mmap_addr(unsigned long addr);
@@ -987,6 +988,12 @@ static inline int security_file_ioctl(struct file *file, unsigned int cmd,
 	return 0;
 }
 
+static inline int security_file_ioctl_compat(struct file *file, unsigned int cmd,
+				      unsigned long arg)
+{
+	return 0;
+}
+
 static inline int security_mmap_file(struct file *file, unsigned long prot,
 				     unsigned long flags)
 {
diff --git a/security/security.c b/security/security.c
index 23b129d482a7..5c16ffc99b1e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2648,6 +2648,23 @@ int security_file_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 }
 EXPORT_SYMBOL_GPL(security_file_ioctl);
 
+/**
+ * security_file_ioctl_compat() - Check if an ioctl is allowed in 32-bit compat mode
+ * @file: associated file
+ * @cmd: ioctl cmd
+ * @arg: ioctl arguments
+ *
+ * Compat version of security_file_ioctl() that correctly handles 32-bit processes
+ * running on 64-bit kernels.
+ *
+ * Return: Returns 0 if permission is granted.
+ */
+int security_file_ioctl_compat(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	return call_int_hook(file_ioctl_compat, 0, file, cmd, arg);
+}
+EXPORT_SYMBOL_GPL(security_file_ioctl_compat);
+
 static inline unsigned long mmap_prot(struct file *file, unsigned long prot)
 {
 	/*
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 2aa0e219d721..c617ae21dba8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3731,6 +3731,33 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	return error;
 }
 
+static int selinux_file_ioctl_compat(struct file *file, unsigned int cmd,
+			      unsigned long arg)
+{
+	/*
+	 * If we are in a 64-bit kernel running 32-bit userspace, we need to make
+	 * sure we don't compare 32-bit flags to 64-bit flags.
+	 */
+	switch (cmd) {
+	case FS_IOC32_GETFLAGS:
+		cmd = FS_IOC_GETFLAGS;
+		break;
+	case FS_IOC32_SETFLAGS:
+		cmd = FS_IOC_SETFLAGS;
+		break;
+	case FS_IOC32_GETVERSION:
+		cmd = FS_IOC_GETVERSION;
+		break;
+	case FS_IOC32_SETVERSION:
+		cmd = FS_IOC_SETVERSION;
+		break;
+	default:
+		break;
+	}
+
+	return selinux_file_ioctl(file, cmd, arg);
+}
+
 static int default_noexec __ro_after_init;
 
 static int file_map_prot_check(struct file *file, unsigned long prot, int shared)
@@ -7036,6 +7063,7 @@ static struct security_hook_list selinux_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(file_permission, selinux_file_permission),
 	LSM_HOOK_INIT(file_alloc_security, selinux_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, selinux_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, selinux_file_ioctl_compat),
 	LSM_HOOK_INIT(mmap_file, selinux_mmap_file),
 	LSM_HOOK_INIT(mmap_addr, selinux_mmap_addr),
 	LSM_HOOK_INIT(file_mprotect, selinux_file_mprotect),
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 65130a791f57..1f1ea8529421 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4973,6 +4973,7 @@ static struct security_hook_list smack_hooks[] __ro_after_init = {
 
 	LSM_HOOK_INIT(file_alloc_security, smack_file_alloc_security),
 	LSM_HOOK_INIT(file_ioctl, smack_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, smack_file_ioctl),
 	LSM_HOOK_INIT(file_lock, smack_file_lock),
 	LSM_HOOK_INIT(file_fcntl, smack_file_fcntl),
 	LSM_HOOK_INIT(mmap_file, smack_mmap_file),
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index 25006fddc964..298d182759c2 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -568,6 +568,7 @@ static struct security_hook_list tomoyo_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(path_rename, tomoyo_path_rename),
 	LSM_HOOK_INIT(inode_getattr, tomoyo_inode_getattr),
 	LSM_HOOK_INIT(file_ioctl, tomoyo_file_ioctl),
+	LSM_HOOK_INIT(file_ioctl_compat, tomoyo_file_ioctl),
 	LSM_HOOK_INIT(path_chmod, tomoyo_path_chmod),
 	LSM_HOOK_INIT(path_chown, tomoyo_path_chown),
 	LSM_HOOK_INIT(path_chroot, tomoyo_path_chroot),

base-commit: 196e95aa8305aecafc4e1857b7d3eff200d953b6
-- 
2.43.0.472.g3155946c3a-goog


