Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C28785155
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Aug 2023 09:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233223AbjHWHRh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Aug 2023 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjHWHRg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:17:36 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321CFD1;
        Wed, 23 Aug 2023 00:17:34 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe5c0e587eso49725735e9.0;
        Wed, 23 Aug 2023 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692775052; x=1693379852;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ewZ2mWN9LxAUhMlOUISD3iVaY7UEtPxBol9YtDw3XhE=;
        b=Q88dSrytaqwxWzfjzA1ZJ6+bTOxAUAH8+ppmZ17nWFFL8PtUNquF+Fg2uv4ROtfAYq
         cpix5tdcx6rNcAXwR5FbRMZw6JF8vu4drNZ5QeA4DYacKuHJxAvApWWXqYwxHUr7LhJG
         oX30XnHBB04qwFuA0Lr0Obm8fr5Iu+GGqdgVSKL9zZ4ZlRkZyzbGM1Rl8zrOU3qaQLX9
         yZ0lz6Dh22yrhMWJJjBGiULKXRes7gcaXS15zqc/bUl9xhyhw9CCqDPOSi140KpDFB5C
         YcpPRMljMsgZFAzU/mbmKEFKt0xZIo9MW8+hvWSME+Eqb88AIh3KUKwP80yalm0XiSOE
         g/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692775052; x=1693379852;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ewZ2mWN9LxAUhMlOUISD3iVaY7UEtPxBol9YtDw3XhE=;
        b=beedB2a6nv8Pq6cbgY8YO1qbj1p+UgqHAXqc58s5lf4x9TMlQtYepI2CEM8xd9LDfR
         TNP5+05n4zNDENjtb46eDyNUm7kHOWiHZDrrvFux6mU7K5qpBwGkoE7IdaytwCAxiDKW
         +ta+9aKOI/WSL8Y1c+R+EVSsKoNsQM+dRcS4GmK0s/VwYLIZRTS0v6+ESJahm/sMosf0
         Nxhl50wO1WDBRaRbkzFOl7hbv/MJRb8It5EQuca5xDiIPXO7Oq2ghXroLxqoJNX/ULUe
         HVFzR4SEpcv5DnCEObg9OmfjepJMbd3YQJdzxPy3l/deO/fz4LWA2PLZHvrB7NKd4SAA
         /nIg==
X-Gm-Message-State: AOJu0YxGsITmBzp3nUeqHDXytW+LnLGXdbGZqXLEVwrAVgSIVJAQiEME
        SHRxHGnsosAhJsZrAGaeAtQ=
X-Google-Smtp-Source: AGHT+IH5+pR9lSjailTZrJCPgAIZSypSKxZvFMA06mqn57NIoNdanFbIFPE8bJKrwRE5Slcf3bZhLQ==
X-Received: by 2002:a7b:c38b:0:b0:3fd:30cb:18bd with SMTP id s11-20020a7bc38b000000b003fd30cb18bdmr9394660wmj.15.1692775052435;
        Wed, 23 Aug 2023 00:17:32 -0700 (PDT)
Received: from khadija-virtual-machine ([124.29.208.67])
        by smtp.gmail.com with ESMTPSA id o3-20020a5d4743000000b0031912c0ffebsm17996205wrs.23.2023.08.23.00.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 00:17:31 -0700 (PDT)
Date:   Wed, 23 Aug 2023 12:17:29 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org, ztarkhani@microsoft.com,
        alison.schofield@intel.com
Subject: [PATCH] lsm: constify 'file' parameter in
 security_bprm_creds_from_file()
Message-ID: <ZOWyiUTHCmKvsoX8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The 'bprm_creds_from_file' hook has implementation registered in
commoncap. Looking at the function implementation we observe that the
'file' parameter is not changing.

Mark the 'file' parameter of LSM hook security_bprm_creds_from_file() as
'const' since it will not be changing in the LSM hook.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 include/linux/fs.h            | 2 +-
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 6 +++---
 security/commoncap.c          | 4 ++--
 security/security.c           | 2 +-
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 133f0640fb24..15d58978efea 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2314,7 +2314,7 @@ struct filename {
 };
 static_assert(offsetof(struct filename, iname) % sizeof(long) == 0);
 
-static inline struct mnt_idmap *file_mnt_idmap(struct file *file)
+static inline struct mnt_idmap *file_mnt_idmap(const struct file *file)
 {
 	return mnt_idmap(file->f_path.mnt);
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 6bb55e61e8e8..1a05d95148e9 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -50,7 +50,7 @@ LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
 LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
-LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, struct file *file)
+LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committing_creds, struct linux_binprm *bprm)
 LSM_HOOK(void, LSM_RET_VOID, bprm_committed_creds, struct linux_binprm *bprm)
diff --git a/include/linux/security.h b/include/linux/security.h
index e2734e9e44d5..fbd498046e39 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -150,7 +150,7 @@ extern int cap_capset(struct cred *new, const struct cred *old,
 		      const kernel_cap_t *effective,
 		      const kernel_cap_t *inheritable,
 		      const kernel_cap_t *permitted);
-extern int cap_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
+extern int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file);
 int cap_inode_setxattr(struct dentry *dentry, const char *name,
 		       const void *value, size_t size, int flags);
 int cap_inode_removexattr(struct mnt_idmap *idmap,
@@ -289,7 +289,7 @@ int security_syslog(int type);
 int security_settime64(const struct timespec64 *ts, const struct timezone *tz);
 int security_vm_enough_memory_mm(struct mm_struct *mm, long pages);
 int security_bprm_creds_for_exec(struct linux_binprm *bprm);
-int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file);
+int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file);
 int security_bprm_check(struct linux_binprm *bprm);
 void security_bprm_committing_creds(struct linux_binprm *bprm);
 void security_bprm_committed_creds(struct linux_binprm *bprm);
@@ -611,7 +611,7 @@ static inline int security_bprm_creds_for_exec(struct linux_binprm *bprm)
 }
 
 static inline int security_bprm_creds_from_file(struct linux_binprm *bprm,
-						struct file *file)
+						const struct file *file)
 {
 	return cap_bprm_creds_from_file(bprm, file);
 }
diff --git a/security/commoncap.c b/security/commoncap.c
index 0b3fc2f3afe7..02a778257e2c 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -720,7 +720,7 @@ int get_vfs_caps_from_disk(struct mnt_idmap *idmap,
  * its xattrs and, if present, apply them to the proposed credentials being
  * constructed by execve().
  */
-static int get_file_caps(struct linux_binprm *bprm, struct file *file,
+static int get_file_caps(struct linux_binprm *bprm, const struct file *file,
 			 bool *effective, bool *has_fcap)
 {
 	int rc = 0;
@@ -882,7 +882,7 @@ static inline bool nonroot_raised_pE(struct cred *new, const struct cred *old,
  *
  * Return: 0 if successful, -ve on error.
  */
-int cap_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
+int cap_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
 {
 	/* Process setpcap binaries and capabilities for uid 0 */
 	const struct cred *old = current_cred();
diff --git a/security/security.c b/security/security.c
index d5ff7ff45b77..bf7de5211542 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1078,7 +1078,7 @@ int security_bprm_creds_for_exec(struct linux_binprm *bprm)
  *
  * Return: Returns 0 if the hook is successful and permission is granted.
  */
-int security_bprm_creds_from_file(struct linux_binprm *bprm, struct file *file)
+int security_bprm_creds_from_file(struct linux_binprm *bprm, const struct file *file)
 {
 	return call_int_hook(bprm_creds_from_file, 0, bprm, file);
 }
-- 
2.34.1

