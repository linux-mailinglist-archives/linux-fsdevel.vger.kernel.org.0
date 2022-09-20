Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592B55BF071
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Sep 2022 00:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiITWoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 18:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbiITWnx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:43:53 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3B26A4A3;
        Tue, 20 Sep 2022 15:43:51 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id f23so3854014plr.6;
        Tue, 20 Sep 2022 15:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=uAS0iDLxzD353KsDs4kAYxP485Qmoe2eFMWR1njqlns=;
        b=5kg6iZ5rQHI0lXuSGBKRldARqo5CY0wqoVfSlGH7R2kbmjIogfR4VNSeeYSxiV5DAz
         hdes+MP59NVUj80O5ini1Mq0cU5iCTpmGPldv4Z1l6KshFXUPv02uiwq2N7o+nFyRxYe
         rFc67r3qK6LOU/ePTyXmfVTzkkPo1GrAiUXLl8fPvDYi/AEXAnNKEIm5yMskY3t2C0Ne
         nwNWBWonE9jIs5R8z00+rNdjcPrfbm6SICnwftSEKtIZkF+sgojdhNj+WhWqPJdPtONe
         nQVBbYbsfSTB31t4Hy0B5LPEGWZJd336lCm/DyZdXv65JRtYl4G2GhPmBRWpF9HX6vxW
         rF8g==
X-Gm-Message-State: ACrzQf3lGp1/DqmT8mritpeDKoUXaj0+cihoftBhdqjJ6irVh+2ZoYZ/
        JMYeACGyNxJGZm8dVM+nMiocPZxaeAs=
X-Google-Smtp-Source: AMsMyM6qAGlo0dnx4uRcMkjhBrEGq4Ix91kKZWfpw0MRRun8xz6l+XGzCJ1wJKFvD3gX+GrlQNnaAQ==
X-Received: by 2002:a17:902:f394:b0:176:b7b7:2 with SMTP id f20-20020a170902f39400b00176b7b70002mr1757505ple.57.1663713830948;
        Tue, 20 Sep 2022 15:43:50 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id 13-20020a62140d000000b0053e93aa8fb9sm451352pfu.71.2022.09.20.15.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:43:50 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        atteh.mailbox@gmail.com, Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH v7 1/3] ksmbd: remove internal.h include
Date:   Wed, 21 Sep 2022 07:43:36 +0900
Message-Id: <20220920224338.22217-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220920224338.22217-1-linkinjeon@kernel.org>
References: <20220920224338.22217-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
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
index 4fcf96a01c16..d994ee1f2c18 100644
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
2.25.1

