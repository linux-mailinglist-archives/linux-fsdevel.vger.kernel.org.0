Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88883673D8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 16:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjASPdF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 10:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbjASPcq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:32:46 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D5829A2;
        Thu, 19 Jan 2023 07:32:42 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id o17-20020a05600c511100b003db021ef437so1530522wms.4;
        Thu, 19 Jan 2023 07:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBbyUyezGmLPHORAlrPKLDLc/sGr6JdTGOI5HCWdOJI=;
        b=Zb4W1DR0WbGbQaQFmXiwmCKgvqi+27mlbiyT9j0pPjUba1LC5ofQ9Zp+rj0MfYujmg
         qUzVIEnz/BW9G+Nri0LPa+70ypVEweExCJaMleEhyjuEl0TR5XzvNwnbYouQ2mgu0aFy
         gm7jnUlgw9pPMdfI1whxla15dgw3yvITz19ehjGhyWb9f1l3prafBHCAUR8M7khjZJ/8
         h7Ffi7dfljxThwoYCAql8ZZG72eGwXwvZV6/o75EP/EElO0qeOwQX+Fijwvgpupvmb2A
         TcT8iglRPveJzh4p6BOGWrZiGqd3FyG3Xerm9pVdRX62Zu1X6p2e4rnSwoCScToFXosf
         8rWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBbyUyezGmLPHORAlrPKLDLc/sGr6JdTGOI5HCWdOJI=;
        b=awsX0iYCQB5b2Ei3jYs2SSulCNogcbdG7/thWEKCRj7OwakdD9321IeqrBGNAvWigh
         LWr/QhB9qK50hywV8c5W7xZ2mWPsi9CB6KrDueAUYSh9MeJCvqjIjFU8WYLEnyUVoNbu
         UKEVyFELwL1qc+w0aOeSYVcuXdwzEjnngHT9+cUsPL4ryFc/bMXn0q8hwM83UnR7ztZx
         UYXgkwXSmvk2N04TyhmUg2f0W9VdrsRGaIfVx7f5TSbxtXL8d9TJoKp1R2hbYZrRRHau
         X6p0en3+DnTSsUAK2lVbe+p3qcoCGsv+Papl/eLqU7GcOxnuwLe8wMlqel4c5pQg4oql
         hSmg==
X-Gm-Message-State: AFqh2kqQVgNlCKMHyNmdCDllXCtw7pSBj8A3bVDLS/lce2pr4pmEHKoW
        YXftyOzfkGQMlryad7dLNm0=
X-Google-Smtp-Source: AMrXdXttONXffOnJbfCnAslRnJ1wIEg8q3PztEx1BsnGRWbJWBm9XY07ZVSjfzIYb7ee3yS2watgTQ==
X-Received: by 2002:a05:600c:511f:b0:3d0:bd9:edd4 with SMTP id o31-20020a05600c511f00b003d00bd9edd4mr10683912wms.0.1674142361117;
        Thu, 19 Jan 2023 07:32:41 -0800 (PST)
Received: from localhost.localdomain (host-82-55-106-56.retail.telecomitalia.it. [82.55.106.56])
        by smtp.gmail.com with ESMTPSA id k34-20020a05600c1ca200b003cfd4e6400csm5827815wms.19.2023.01.19.07.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:32:40 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 3/4] fs/sysv: Use dir_put_page() in sysv_rename()
Date:   Thu, 19 Jan 2023 16:32:31 +0100
Message-Id: <20230119153232.29750-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119153232.29750-1-fmdefrancesco@gmail.com>
References: <20230119153232.29750-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use the dir_put_page() helper in sysv_rename() instead of open-coding two
kunmap() + put_page().

Cc: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/sysv/dir.c   | 2 +-
 fs/sysv/namei.c | 9 +++------
 fs/sysv/sysv.h  | 1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 8d14c6c02476..2e35b95d3efb 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -28,7 +28,7 @@ const struct file_operations sysv_dir_operations = {
 	.fsync		= generic_file_fsync,
 };
 
-static inline void dir_put_page(struct page *page)
+inline void dir_put_page(struct page *page)
 {
 	kunmap(page);
 	put_page(page);
diff --git a/fs/sysv/namei.c b/fs/sysv/namei.c
index b2e6abc06a2d..981c1d76f342 100644
--- a/fs/sysv/namei.c
+++ b/fs/sysv/namei.c
@@ -250,13 +250,10 @@ static int sysv_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	return 0;
 
 out_dir:
-	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
-	}
+	if (dir_de)
+		dir_put_page(dir_page);
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	dir_put_page(old_page);
 out:
 	return err;
 }
diff --git a/fs/sysv/sysv.h b/fs/sysv/sysv.h
index 99ddf033da4f..b250ac1dd348 100644
--- a/fs/sysv/sysv.h
+++ b/fs/sysv/sysv.h
@@ -148,6 +148,7 @@ extern void sysv_destroy_icache(void);
 
 
 /* dir.c */
+extern void dir_put_page(struct page *page);
 extern struct sysv_dir_entry *sysv_find_entry(struct dentry *, struct page **);
 extern int sysv_add_link(struct dentry *, struct inode *);
 extern int sysv_delete_entry(struct sysv_dir_entry *, struct page *);
-- 
2.39.0

