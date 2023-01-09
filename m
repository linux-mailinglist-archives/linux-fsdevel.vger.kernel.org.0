Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56552662C48
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 18:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbjAIRIP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 12:08:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbjAIRHl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:07:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C88395D2;
        Mon,  9 Jan 2023 09:06:49 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m7so8876036wrn.10;
        Mon, 09 Jan 2023 09:06:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPkTBe5nXBDQeS7sbYnJgmbxzogLVWQKfGg5it5w+j0=;
        b=Nya5FjSn4JCeFq2y0CmErxCxp7pYyK5bShmb/W4CYDzyNPPor57EiUDicwRfHL1bMW
         c0o9I+UQeayca1x467qnNOCf3rYaPQiasR1B+cKTt0sWFeD21XkvUHDwAxleG/daZxCn
         FS/z+tzzl55TnWhUEJjgCVvykcif5Usnehjbp1yq8LklJJBkPFGANUDZ5TDqNHCNXUz5
         X1M49jI2sbMl6TfNJ4Yod33ZxBbqmkGOv6IXPscdFLNcrE+/yxoxF1k0n+zvI1eEKre3
         O50lCk2QYSPzGTvkSHJ045ppjFJ0oaeSmHVG7m/Gs1DBLYKs7FPetnmqBS0vPH37q/gc
         Fg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPkTBe5nXBDQeS7sbYnJgmbxzogLVWQKfGg5it5w+j0=;
        b=1gVmTeA6GnrPOqzOHEf4JHz9NgNPIb3tSGdYrVdrOW/ZhcVMv5wTRqPEfcTNPIzRD6
         nCOHZt86g76k5cPguiNGyyNIj2bCKRrWShv1cclpCc05uqzB47LUe7bN3OTctqtXwJwF
         6WX6hwHsUWXgb5Ck1g+RBtnK1Q8QDuROVyatxNYD7W8q7x9Px6YX4P0KOPAE2cIE+X/J
         ScBF3VD16fynlCZ790dll3I1CWgwvBKMxrv9X02GUL5yxbDPrfl21cK4e6W9pW6gSSVR
         fbHawbucxUIvk6Hz4Bc1KTLf3HDuqgckcn532d0cNBOdz/B99botEfBb6p8mY33ORq1b
         3KQw==
X-Gm-Message-State: AFqh2kqQyuYZi0An5Mims0eO2U0IBIwsd8ky0a7azjp8fArqvMxK9Nd6
        ZnYVJDuaKWVuHKTzloWeaOk=
X-Google-Smtp-Source: AMrXdXsuYL8GEoCzIHG9q3L6sLS/1ci5pp6PdIM383SbhlMinw2ASPReqF5L41QsgT1W9Rube+5GjA==
X-Received: by 2002:a5d:6f0e:0:b0:2ba:73e3:f4f2 with SMTP id ay14-20020a5d6f0e000000b002ba73e3f4f2mr10072993wrb.2.1673284007856;
        Mon, 09 Jan 2023 09:06:47 -0800 (PST)
Received: from localhost.localdomain (host-79-13-98-249.retail.telecomitalia.it. [79.13.98.249])
        by smtp.gmail.com with ESMTPSA id n10-20020a5d6b8a000000b002425787c5easm8954527wrx.96.2023.01.09.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:06:47 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v2 2/4] fs/sysv: Change the signature of dir_get_page()
Date:   Mon,  9 Jan 2023 18:06:37 +0100
Message-Id: <20230109170639.19757-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230109170639.19757-1-fmdefrancesco@gmail.com>
References: <20230109170639.19757-1-fmdefrancesco@gmail.com>
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

Change the signature of ufs_get_page() in order to prepare this function
to the conversion to the use of kmap_local_page(). Change also those call
sites which are required to conform to the new signature.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

Delete an unnecessary assignment from v1 (thanks to Dan).
Reported-by: Dan Carpenter <error27@gmail.com>

 fs/sysv/dir.c | 51 ++++++++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 685379bc9d64..f953e6b9251e 100644
--- a/fs/sysv/dir.c
+++ b/fs/sysv/dir.c
@@ -52,13 +52,15 @@ static int dir_commit_chunk(struct page *page, loff_t pos, unsigned len)
 	return err;
 }
 
-static struct page * dir_get_page(struct inode *dir, unsigned long n)
+static void *dir_get_page(struct inode *dir, unsigned long n, struct page **p)
 {
 	struct address_space *mapping = dir->i_mapping;
 	struct page *page = read_mapping_page(mapping, n, NULL);
-	if (!IS_ERR(page))
-		kmap(page);
-	return page;
+	if (IS_ERR(page))
+		return ERR_CAST(page);
+	kmap(page);
+	*p = page;
+	return page_address(page);
 }
 
 static int sysv_readdir(struct file *file, struct dir_context *ctx)
@@ -80,11 +82,11 @@ static int sysv_readdir(struct file *file, struct dir_context *ctx)
 	for ( ; n < npages; n++, offset = 0) {
 		char *kaddr, *limit;
 		struct sysv_dir_entry *de;
-		struct page *page = dir_get_page(inode, n);
+		struct page *page;
 
-		if (IS_ERR(page))
+		kaddr = dir_get_page(inode, n, &page);
+		if (IS_ERR(kaddr))
 			continue;
-		kaddr = (char *)page_address(page);
 		de = (struct sysv_dir_entry *)(kaddr+offset);
 		limit = kaddr + PAGE_SIZE - SYSV_DIRSIZE;
 		for ( ;(char*)de <= limit; de++, ctx->pos += sizeof(*de)) {
@@ -142,11 +144,10 @@ struct sysv_dir_entry *sysv_find_entry(struct dentry *dentry, struct page **res_
 	n = start;
 
 	do {
-		char *kaddr;
-		page = dir_get_page(dir, n);
-		if (!IS_ERR(page)) {
-			kaddr = (char*)page_address(page);
-			de = (struct sysv_dir_entry *) kaddr;
+		char *kaddr = dir_get_page(dir, n, &page);
+
+		if (!IS_ERR(kaddr)) {
+			de = (struct sysv_dir_entry *)kaddr;
 			kaddr += PAGE_SIZE - SYSV_DIRSIZE;
 			for ( ; (char *) de <= kaddr ; de++) {
 				if (!de->inode)
@@ -185,11 +186,9 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 
 	/* We take care of directory expansion in the same loop */
 	for (n = 0; n <= npages; n++) {
-		page = dir_get_page(dir, n);
-		err = PTR_ERR(page);
-		if (IS_ERR(page))
-			goto out;
-		kaddr = (char*)page_address(page);
+		kaddr = dir_get_page(dir, n, &page);
+		if (IS_ERR(kaddr))
+			return PTR_ERR(kaddr);
 		de = (struct sysv_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE - SYSV_DIRSIZE;
 		while ((char *)de <= kaddr) {
@@ -219,7 +218,6 @@ int sysv_add_link(struct dentry *dentry, struct inode *inode)
 	mark_inode_dirty(dir);
 out_page:
 	dir_put_page(page);
-out:
 	return err;
 out_unlock:
 	unlock_page(page);
@@ -288,12 +286,11 @@ int sysv_empty_dir(struct inode * inode)
 	for (i = 0; i < npages; i++) {
 		char *kaddr;
 		struct sysv_dir_entry * de;
-		page = dir_get_page(inode, i);
 
-		if (IS_ERR(page))
+		kaddr = dir_get_page(inode, i, &page);
+		if (IS_ERR(kaddr))
 			continue;
 
-		kaddr = (char *)page_address(page);
 		de = (struct sysv_dir_entry *)kaddr;
 		kaddr += PAGE_SIZE-SYSV_DIRSIZE;
 
@@ -339,16 +336,16 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	mark_inode_dirty(dir);
 }
 
-struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
+struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
 {
-	struct page *page = dir_get_page(dir, 0);
-	struct sysv_dir_entry *de = NULL;
+	struct page *page = NULL;
+	struct sysv_dir_entry *de = dir_get_page(dir, 0, &page);
 
-	if (!IS_ERR(page)) {
-		de = (struct sysv_dir_entry*) page_address(page) + 1;
+	if (!IS_ERR(de)) {
 		*p = page;
+		return (struct sysv_dir_entry *)page_address(page) + 1;
 	}
-	return de;
+	return NULL;
 }
 
 ino_t sysv_inode_by_name(struct dentry *dentry)
-- 
2.39.0

