Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7971673D8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 16:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjASPdC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 10:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbjASPcp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:32:45 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB2C829A1;
        Thu, 19 Jan 2023 07:32:41 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3205583wmb.0;
        Thu, 19 Jan 2023 07:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ds3dXezsU4NdrKaDu6LJLSqsqIanylkO6E6ANlGew+I=;
        b=ZX8I6/Z2f1xnY11MtiRDdVud2RqfcdW/Pj+UAvb8a+RcNn5tHXITZPYi3a2FijsR5g
         dfFBMp2oQrMOLlhw+QFnmTlMT4REdgRdgNNrbmcs7ro/EyDTdGSdm8BdDf+Hjxa/Aqee
         xgUhL7oj5tQxoT4aZH/HnxMIBulLrBXMect4UeduGmssN2e0W0L44lLiSfCqbxtICMLK
         gdfDFkuBvnNkEtDLhI6QUU47rToHg+HBsTLS6aWwHwSgnaARKKXCFr1ilnmnLh2g70xj
         /p9elxWwdv4nzdHyjYe2JxVLOQGpbooDUHL4bAW6KH5sqhPbmLPOpXDzOpjbJktYCh62
         aynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ds3dXezsU4NdrKaDu6LJLSqsqIanylkO6E6ANlGew+I=;
        b=vjUmQB19Y9FJwFGyIxPd5w//P3Olfj9ExCxKViAFLD2mTUV2rcoCpnKnQW1E237R2G
         /D0MwGl0hBf/9PKzriLaBvwoG7WZ2fZOsEjlziDzZRgxXtSg8q3D9zIhusjgpEJaTJXU
         2dWOKNBBAsczx/Ke3nPpQN0IMJLhX7zBZRKaL+MEO8AovfeeoNQrEds9ut8DA3ENQUGD
         0vWrzprmqmRuQJC3C4FESdX1UQTXrPHs80CQj0CcmisoFqmIZnFX5KIe4T4i+xDaZw/I
         2IXO7m9DoXY3784wVPtcP7xAhs6azFfunWGcn/gmv1C8nRl6CQiqxHmfGK5kM8r00U/q
         ZdWg==
X-Gm-Message-State: AFqh2kpCOVpeqVCLou+jglkqxFVJ7L+kl0AOviBtwjx21+xtCjyknIU5
        m2x4Owdr27gEB36JZNi1I7A=
X-Google-Smtp-Source: AMrXdXt+QFPoMVbUMSqJRmoLSNyQlCiSstRKzkbcqsj9pdTN9bfox3poZauJbSNeCLCHdGvkc3dNDQ==
X-Received: by 2002:a05:600c:982:b0:3da:f5b5:13ec with SMTP id w2-20020a05600c098200b003daf5b513ecmr10259172wmp.34.1674142359679;
        Thu, 19 Jan 2023 07:32:39 -0800 (PST)
Received: from localhost.localdomain (host-82-55-106-56.retail.telecomitalia.it. [82.55.106.56])
        by smtp.gmail.com with ESMTPSA id k34-20020a05600c1ca200b003cfd4e6400csm5827815wms.19.2023.01.19.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:32:39 -0800 (PST)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 2/4] fs/sysv: Change the signature of dir_get_page()
Date:   Thu, 19 Jan 2023 16:32:30 +0100
Message-Id: <20230119153232.29750-3-fmdefrancesco@gmail.com>
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

Change the signature of dir_get_page() in order to prepare this function
to the conversion to the use of kmap_local_page(). Change also those call
sites which are required to adjust to the new signature.

Cc: Ira Weiny <ira.weiny@intel.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/sysv/dir.c | 53 +++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/fs/sysv/dir.c b/fs/sysv/dir.c
index 685379bc9d64..8d14c6c02476 100644
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
 
@@ -339,16 +336,14 @@ void sysv_set_link(struct sysv_dir_entry *de, struct page *page,
 	mark_inode_dirty(dir);
 }
 
-struct sysv_dir_entry * sysv_dotdot (struct inode *dir, struct page **p)
+struct sysv_dir_entry *sysv_dotdot(struct inode *dir, struct page **p)
 {
-	struct page *page = dir_get_page(dir, 0);
-	struct sysv_dir_entry *de = NULL;
+	struct sysv_dir_entry *de = dir_get_page(dir, 0, p);
 
-	if (!IS_ERR(page)) {
-		de = (struct sysv_dir_entry*) page_address(page) + 1;
-		*p = page;
-	}
-	return de;
+	if (IS_ERR(de))
+		return NULL;
+	/* ".." is the second directory entry */
+	return de + 1;
 }
 
 ino_t sysv_inode_by_name(struct dentry *dentry)
-- 
2.39.0

