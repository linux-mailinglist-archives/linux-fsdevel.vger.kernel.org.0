Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F9B6592A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Dec 2022 23:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiL2WvR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Dec 2022 17:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234271AbiL2WvL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Dec 2022 17:51:11 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C83328;
        Thu, 29 Dec 2022 14:51:10 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y8so18451832wrl.13;
        Thu, 29 Dec 2022 14:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oQGb1Ohj8QHcTVOUHNJM/HJgl8e+SQwlkoH2O3zdP0=;
        b=qy9Q39gpZmRFt5bIXV/z/IT2f3RjuyPAZJB8eYHQ8jdivBF3KFWss1ZNt9CsgojWMQ
         cQKQPlPv32X+dNAli5APM1YnbH234BBHHeLf2nBnSJj4NyISCYf/03gtIVqLf6ZLEJWd
         uCBGIghRQk9FTaaE5Kw7BXUq3Nw7pDyj1TmG6tp9G4TFMBrLVkueuksyfrhAT1dRYkuA
         +VXSYpE7/SL8VBYK2HhXmi795SneBkh31P8syZCKvvTyTCsYShYPgw3/4inzO1+ikwbe
         hBqosBvbgMYSV8zASmmJolMkzifxGAMBKgTQOzf8pRpQz5XChG8JdjNum103io9ugkFN
         bxow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oQGb1Ohj8QHcTVOUHNJM/HJgl8e+SQwlkoH2O3zdP0=;
        b=wuTBVmydemwjPK+n46DP4BvGyCmD6qptlNBVNvF7hwGNYwilW8JeBDLHhOhMHk6Xcr
         ZXPchIXKxvhtWUuoJxx5LlkXAiOo3S0t+m2GTE477KiECWU368EV1L2gjwnlVr337SRa
         eIaFf1yHMgXU5Quy8jsvYoBgvrVRtg2Kujp9DlxoPQx15cHyqlvC4izQP1jN0wrugqRF
         WuvdTbYVku84xaAr5emEPZVI/MRHwyIwVmsS1MEmCPpBAKZCI2Bt1WdfTjNadS2a124Q
         wKPjGEVu3PrqOWvhMo1t6kxC2yR8odBq9PS9RRForrUxJSFM8Pmjjp8W5S6GwoHj13zV
         xKlw==
X-Gm-Message-State: AFqh2kqcEAdl5Qt7bABvmTGXpkR6xuBOXOtCpss8EPhaz8aYU8dR6sDZ
        t3uDB1NMx2VhUfQA6zwDsU0=
X-Google-Smtp-Source: AMrXdXtBcGKY0uEwQSTIRSVPvkgu0nY2YVbI0KtMANXe4ahORcKO6ni9mMrZaXBME4IbcGKE3LgqBA==
X-Received: by 2002:adf:ce0a:0:b0:242:156f:9ce3 with SMTP id p10-20020adfce0a000000b00242156f9ce3mr19111857wrn.3.1672354268901;
        Thu, 29 Dec 2022 14:51:08 -0800 (PST)
Received: from localhost.localdomain (host-79-56-217-20.retail.telecomitalia.it. [79.56.217.20])
        by smtp.gmail.com with ESMTPSA id p3-20020adfcc83000000b0027a57c1a6fbsm13493312wrj.22.2022.12.29.14.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 14:51:08 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 3/4] fs/ufs: Use ufs_put_page() in ufs_rename()
Date:   Thu, 29 Dec 2022 23:50:59 +0100
Message-Id: <20221229225100.22141-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221229225100.22141-1-fmdefrancesco@gmail.com>
References: <20221229225100.22141-1-fmdefrancesco@gmail.com>
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

Use the ufs_put_page() helper in ufs_rename() instead of open-coding three
kunmap() + put_page().

Cc: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/ufs/dir.c   | 2 +-
 fs/ufs/namei.c | 9 +++------
 fs/ufs/ufs.h   | 1 +
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index ae3b20354a28..0bfd563ab0c2 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -61,7 +61,7 @@ static int ufs_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	return err;
 }
 
-static inline void ufs_put_page(struct page *page)
+inline void ufs_put_page(struct page *page)
 {
 	kunmap(page);
 	put_page(page);
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 29d5a0e0c8f0..486b0f2e8b7a 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -307,8 +307,7 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		if (old_dir != new_dir)
 			ufs_set_link(old_inode, dir_de, dir_page, new_dir, 0);
 		else {
-			kunmap(dir_page);
-			put_page(dir_page);
+			ufs_put_page(dir_page);
 		}
 		inode_dec_link_count(old_dir);
 	}
@@ -317,12 +316,10 @@ static int ufs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 
 out_dir:
 	if (dir_de) {
-		kunmap(dir_page);
-		put_page(dir_page);
+		ufs_put_page(dir_page);
 	}
 out_old:
-	kunmap(old_page);
-	put_page(old_page);
+	ufs_put_page(old_page);
 out:
 	return err;
 }
diff --git a/fs/ufs/ufs.h b/fs/ufs/ufs.h
index 550f7c5a3636..f7ba8df25d03 100644
--- a/fs/ufs/ufs.h
+++ b/fs/ufs/ufs.h
@@ -98,6 +98,7 @@ extern struct ufs_cg_private_info * ufs_load_cylinder (struct super_block *, uns
 extern void ufs_put_cylinder (struct super_block *, unsigned);
 
 /* dir.c */
+extern void ufs_put_page(struct page *page);
 extern const struct inode_operations ufs_dir_inode_operations;
 extern int ufs_add_link (struct dentry *, struct inode *);
 extern ino_t ufs_inode_by_name(struct inode *, const struct qstr *);
-- 
2.39.0

