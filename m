Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5882E30FAB2
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 19:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238797AbhBDSCZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 13:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbhBDSCD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 13:02:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1762C061794;
        Thu,  4 Feb 2021 10:01:18 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g10so5357615eds.2;
        Thu, 04 Feb 2021 10:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iAefGUAHsipIScrR/9/fAqraahJJ176FZy1tyGb44vw=;
        b=iGtbYRev88Uzy3VDVnUl3Sa687iEw8bkhsWb0C1q4E6H53BzQ5dNOBg4RhvSrFA56F
         mALgi2oplscXM+CLyouiR7C2EunslrQ6nher22FVWjCdexlJ1Sj8wHIVGixyKhlYJQQd
         AlUJHvrolesk1/pX+qtI2DE0C051ao0eV5JdLMvXcq7E/ncs6M7mCiFOUnM/2Crao9B0
         BXrwlPcabFVf1kSQ5YBDoUDYdJnFABCWiqPxIkDT51qsyBuZFgIH346lCjyJMSLdyOQs
         ZG9wQLtaEOnQCPMSbi40MchPZxG+lVN8EVAiim7Le+rJ3yNHF7Z8OI5KANsReDbg4xxQ
         UyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iAefGUAHsipIScrR/9/fAqraahJJ176FZy1tyGb44vw=;
        b=h7ZN0Fn5NlJHHEQebR7SMIXinq3CL6T7TnfLkoRr680SF5PYeBuRVHBVSx3DqUALSP
         rfvOutRpRSUojpGQH6z7xl1IoLyf5tAhzYEUONeH/BWe+Ne3CxyL6V/qkL5nd+UDRt8e
         yq9QnvXFGMXVzkgz5HJD65mx4L89HxMegsTCRVJPU0u2tEVLczxgiGRUx7BjAEmjQ9B+
         wxYpiny34vwxHAIiFTXC+gNtubgTz2Lr1v9MdaK0mXv3PcQdT8RpOaydKyEURn2BvfVm
         W7k393+GBnPUAGpVBGeLsxXjyXNeX9GqmKPT4gU9w/OywzA/+HJC8hLFr1aBc5ekaJ1L
         evFw==
X-Gm-Message-State: AOAM5336+CN/NoVKUK1XnY9tiUsRyGzhDnsMqmuY9MnuU90EpZPTipuq
        bi3G/eAZYIyPrcGumzeEACo=
X-Google-Smtp-Source: ABdhPJyqeh5+0QXqBvKYPgZ4PRj1ZNDpndZ3yo2kgb2x8FR1zfOsgry1+iiTNr34UBp7Gw/+P12MHQ==
X-Received: by 2002:aa7:c24e:: with SMTP id y14mr173922edo.292.1612461677649;
        Thu, 04 Feb 2021 10:01:17 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de7:9900:24e0:4d40:c49:5282])
        by smtp.gmail.com with ESMTPSA id bo24sm2810326edb.51.2021.02.04.10.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:01:17 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/5] fs: update kernel-doc for vfs_rename()
Date:   Thu,  4 Feb 2021 19:00:56 +0100
Message-Id: <20210204180059.28360-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
References: <20210204180059.28360-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 9fe61450972d ("namei: introduce struct renamedata") introduces a
new struct for vfs_rename() and makes the vfs_rename() kernel-doc argument
description out of sync.

Move the description of arguments for vfs_rename() to a new kernel-doc for
the struct renamedata to make these descriptions checkable against the
actual implementation.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 fs/namei.c         |  9 +--------
 include/linux/fs.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f131d3efec63..98ea56ebcaf0 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4406,14 +4406,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
 
 /**
  * vfs_rename - rename a filesystem object
- * @old_mnt_userns:	old user namespace of the mount the inode was found from
- * @old_dir:		parent of source
- * @old_dentry:		source
- * @new_mnt_userns:	new user namespace of the mount the inode was found from
- * @new_dir:		parent of destination
- * @new_dentry:		destination
- * @delegated_inode:	returns an inode needing a delegation break
- * @flags:		rename flags
+ * @rd: struct with all information required for renaming
  *
  * The caller must hold multiple mutexes--see lock_rename()).
  *
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04b6b142dfcf..52b6d9e34b92 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1782,6 +1782,17 @@ int vfs_rmdir(struct user_namespace *, struct inode *, struct dentry *);
 int vfs_unlink(struct user_namespace *, struct inode *, struct dentry *,
 	       struct inode **);
 
+/**
+ * struct renamedata - contains all information required for renaming
+ * @old_mnt_userns:    old user namespace of the mount the inode was found from
+ * @old_dir:           parent of source
+ * @old_dentry:                source
+ * @new_mnt_userns:    new user namespace of the mount the inode was found from
+ * @new_dir:           parent of destination
+ * @new_dentry:                destination
+ * @delegated_inode:   returns an inode needing a delegation break
+ * @flags:             rename flags
+ */
 struct renamedata {
 	struct user_namespace *old_mnt_userns;
 	struct inode *old_dir;
-- 
2.17.1

