Return-Path: <linux-fsdevel+bounces-177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 590A97C6F8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 15:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14505282C38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 13:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E98F2E641;
	Thu, 12 Oct 2023 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KpcNF2DJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EDF29436
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 13:44:43 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D31E94;
	Thu, 12 Oct 2023 06:44:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3248ac76acbso827972f8f.1;
        Thu, 12 Oct 2023 06:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697118280; x=1697723080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++BNR3CLM1Hqkl3ibmZEgetPNeFTdnn0TXTRaeDafCU=;
        b=KpcNF2DJlP0nn0y1Fm268BDu8hZWmd1Q8bZXxf2Fup1QLVumBS4HWk9R2svfmVvQ1V
         OI6U+shpwbsRH3e/7Q4rgSl6KreP0beE6+G8nEVU8k5KERszvnGSZ8KKpDo2N5JxWbn4
         7J0wv1Uml6dvK8vencnQ1gYtiGAh+YTN+XJDV5TSILcoUfmxtcUjqZTZp7tIa2tm5Kae
         JFe/gYZaJL4lJ959hGwbZQ6j+BatXXXrSqc4iwDGAiEa2T6o3D2emaccTMe/P+UWW2d9
         6sg3tHT0gLS3O+4gzcIxzfcHG6KkQKU1X9MjuCbmDjmTB+alYxV391Q6Lgz2w6TR6gqy
         8Ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118280; x=1697723080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++BNR3CLM1Hqkl3ibmZEgetPNeFTdnn0TXTRaeDafCU=;
        b=iERcbQMoPufI83cDe7zLGnB2GEiD12xMcuUgtLr1RijpC65WbeqS4lef++TI+AK4MH
         d1IWW9zjVLda2lyg+KJaI4Ay86yzRqPPb9sLLMNPP8DKHckFCTfpsZBUZuZ8jZSt706B
         NxG+AiqDKDGTXyvHK0icGo9SRnoqkHsK+dskNMrxxSImDND6MF/VZCm4s8mv5wADmc1V
         fkAYsPgmHjZjMV6LvqiDNOTan91nI37DUpkmkPUQ/j0pSq+fueJdwDD3bFFgNJqegUNd
         InARENaqs83pU7jweJzvGiaUXtrn++LOR2HJPDZx9N/tEsZLqWTewAhy96o86o1xL+uf
         2N+A==
X-Gm-Message-State: AOJu0YwUQiJi/2E4l/A5P9/JCGQdTx7cjOUuMD5K6CFaygXcxC6EvQht
	txdk5WoIG6zJe3A9sglqTWE=
X-Google-Smtp-Source: AGHT+IF3GSrFErLJaSsB/NrY9ljP5+T1+2/K0AyXfIeRRhjP3+KZZDJaa2qzKOW+7pCqTdRySLu0Rw==
X-Received: by 2002:a5d:5103:0:b0:31f:b138:5a0 with SMTP id s3-20020a5d5103000000b0031fb13805a0mr20030683wrt.48.1697118279593;
        Thu, 12 Oct 2023 06:44:39 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id l16-20020a7bc450000000b0040536dcec17sm21825154wmi.27.2023.10.12.06.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:44:38 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] fs: factor out vfs_parse_monolithic_sep() helper
Date: Thu, 12 Oct 2023 16:44:27 +0300
Message-Id: <20231012134428.1874373-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231012134428.1874373-1-amir73il@gmail.com>
References: <20231012134428.1874373-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Factor out vfs_parse_monolithic_sep() from generic_parse_monolithic(),
so filesystems could use it with a custom option separator callback.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Christian,

If you can ack this patch, I'd rather send it to Linus for 6.6-rc6,
along with the two ovl option parsing fixes.

I checked that it does not conflict with any code on vfs.all OTM.

Thanks,
Amir.

 fs/fs_context.c            | 34 +++++++++++++++++++++++++++++-----
 include/linux/fs_context.h |  2 ++
 2 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index a0ad7a0c4680..98589aae5208 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -192,17 +192,19 @@ int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 EXPORT_SYMBOL(vfs_parse_fs_string);
 
 /**
- * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
+ * vfs_parse_monolithic_sep - Parse key[=val][,key[=val]]* mount data
  * @fc: The superblock configuration to fill in.
  * @data: The data to parse
+ * @sep: callback for separating next option
  *
- * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
- * called from the ->monolithic_mount_data() fs_context operation.
+ * Parse a blob of data that's in key[=val][,key[=val]]* form with a custom
+ * option separator callback.
  *
  * Returns 0 on success or the error returned by the ->parse_option() fs_context
  * operation on failure.
  */
-int generic_parse_monolithic(struct fs_context *fc, void *data)
+int vfs_parse_monolithic_sep(struct fs_context *fc, void *data,
+			     char *(*sep)(char **))
 {
 	char *options = data, *key;
 	int ret = 0;
@@ -214,7 +216,7 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 	if (ret)
 		return ret;
 
-	while ((key = strsep(&options, ",")) != NULL) {
+	while ((key = sep(&options)) != NULL) {
 		if (*key) {
 			size_t v_len = 0;
 			char *value = strchr(key, '=');
@@ -233,6 +235,28 @@ int generic_parse_monolithic(struct fs_context *fc, void *data)
 
 	return ret;
 }
+EXPORT_SYMBOL(vfs_parse_monolithic_sep);
+
+static char *vfs_parse_comma_sep(char **s)
+{
+	return strsep(s, ",");
+}
+
+/**
+ * generic_parse_monolithic - Parse key[=val][,key[=val]]* mount data
+ * @fc: The superblock configuration to fill in.
+ * @data: The data to parse
+ *
+ * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
+ * called from the ->monolithic_mount_data() fs_context operation.
+ *
+ * Returns 0 on success or the error returned by the ->parse_option() fs_context
+ * operation on failure.
+ */
+int generic_parse_monolithic(struct fs_context *fc, void *data)
+{
+	return vfs_parse_monolithic_sep(fc, data, vfs_parse_comma_sep);
+}
 EXPORT_SYMBOL(generic_parse_monolithic);
 
 /**
diff --git a/include/linux/fs_context.h b/include/linux/fs_context.h
index 96332db693d5..c13e99cbbf81 100644
--- a/include/linux/fs_context.h
+++ b/include/linux/fs_context.h
@@ -136,6 +136,8 @@ extern struct fs_context *vfs_dup_fs_context(struct fs_context *fc);
 extern int vfs_parse_fs_param(struct fs_context *fc, struct fs_parameter *param);
 extern int vfs_parse_fs_string(struct fs_context *fc, const char *key,
 			       const char *value, size_t v_size);
+int vfs_parse_monolithic_sep(struct fs_context *fc, void *data,
+			     char *(*sep)(char **));
 extern int generic_parse_monolithic(struct fs_context *fc, void *data);
 extern int vfs_get_tree(struct fs_context *fc);
 extern void put_fs_context(struct fs_context *fc);
-- 
2.34.1


