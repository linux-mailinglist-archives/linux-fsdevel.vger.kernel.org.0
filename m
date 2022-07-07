Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3043256A201
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jul 2022 14:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbiGGMcg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jul 2022 08:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbiGGMce (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:32:34 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF341222AC;
        Thu,  7 Jul 2022 05:32:33 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id 145so18217772pga.12;
        Thu, 07 Jul 2022 05:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z1HV4QHwdZW8PPs0gTIR2eMtxWWt1aDvWNTekhaZT8k=;
        b=wU/l/sbvQ9CEpPjzCOulPCs8BpLMJSOS+FojGj6jKnkxQCO2AaGUiej+4OX7B/Pzh9
         BGngXKNK5gj0WP8JhQnpA+7WZ6Yropfi+pKnjcMi2yIzklRk1kkkNYeQwOC/8cGx+Jk2
         rrm9nR3qti9MC0hVfAoH/YFdGi1hQTeQzBrhDP4ogOH+hw9X5f+uAtdr1FM9eHcZUtf/
         icmFcEJ6O/35QIIkZi6GZpdGPfo5HN/UPBgBW4Y99vwwfYMFKWa1obrNmVp/W/EeG0uW
         vfPZ3FTo2VKMwx7TcOL7W1Jss//huYlrmgwU7fvWxwGstUMrk6vDF+pFsxn5Le3AtQF2
         D/LA==
X-Gm-Message-State: AJIora9j7qGQlsO7y+kAuVlwx7eyfT9GE/eSpGUsslNkDF5b3Jg8cSnG
        REmI8ue/x7H/Zjw3OINyhf0=
X-Google-Smtp-Source: AGRyM1vIw/tbTbRwqCQXlW5nAqwsZsOA8IERz773Wh8aTUOKsNuWpWWP85jYTorYk6Algvu94sMVUA==
X-Received: by 2002:a63:9142:0:b0:412:b171:b6ac with SMTP id l63-20020a639142000000b00412b171b6acmr4582053pge.206.1657197153519;
        Thu, 07 Jul 2022 05:32:33 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id u13-20020a63454d000000b0040d2224ae04sm25825227pgk.76.2022.07.07.05.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 05:32:33 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     viro@zeniv.linux.org.uk
Cc:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        smfrench@gmail.com, hyc.lee@gmail.com, senozhatsky@chromium.org,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v6 1/3] ksmbd: remove internal.h include
Date:   Thu,  7 Jul 2022 21:32:03 +0900
Message-Id: <20220707123205.6902-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707123205.6902-1-linkinjeon@kernel.org>
References: <20220707123205.6902-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since vfs_path_lookup is exported, It should not be internal.
Move vfs_path_lookup prototype in internal.h to linux/namei.h.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/internal.h         | 2 --
 fs/ksmbd/vfs.c        | 2 --
 include/linux/namei.h | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 87e96b9024ce..c994f0408b29 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -58,8 +58,6 @@ extern int finish_clean_context(struct fs_context *fc);
  */
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
-extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
-			   const char *, unsigned int, struct path *);
 int do_rmdir(int dfd, struct filename *name);
 int do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct user_namespace *mnt_userns, struct path *link);
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index 5d185564aef6..1770b30772da 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -18,8 +18,6 @@
 #include <linux/sched/xacct.h>
 #include <linux/crc32c.h>
 
-#include "../internal.h"	/* for vfs_path_lookup */
-
 #include "glob.h"
 #include "oplock.h"
 #include "connection.h"
diff --git a/include/linux/namei.h b/include/linux/namei.h
index caeb08a98536..40c693525f79 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -63,6 +63,8 @@ extern struct dentry *kern_path_create(int, const char *, struct path *, unsigne
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
+		    unsigned int, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
-- 
2.34.1

