Return-Path: <linux-fsdevel+bounces-2174-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A36867E2F8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 23:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F274B20F22
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 22:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8102FE22;
	Mon,  6 Nov 2023 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="BHVlEeJu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBD32FE0F
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 22:08:48 +0000 (UTC)
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6261BC
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 14:08:47 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7bae0c07007so791488241.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Nov 2023 14:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1699308526; x=1699913326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNj+yYFj8tqbacxBJz1am0Z6u5J0WjWsVcH94aw05E4=;
        b=BHVlEeJuuWvNk7U5IB68dWDP4yKfUFn9+sWB+K+z3xNPndQ8cVAP09IFOuSeSwUasv
         A0gSlFxhzk+bkBtZVDQ+vw6qwsC/4cuyR9yyyjY7SqNifmiKi11wyZznaPBIkxqlX4JZ
         f9VUoLhCE/45e2IQPZZr1hliQXpz5b2hS1NayGFKBnvJRz3aqAIrnh6a4o112cT9hR6c
         YuZUMY/XHv3sUlOn49Kd9OBJqywutIruY+2sAqzGMI2wdhFm8ELmMNXF9HmgI5nBGEXr
         3Z+bY2KWum68fTbuZNS0smsT2roLIH5EaeuXvA1m3YHR1ls3vBxKNmgwzeiq89Bg2DGn
         3xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699308526; x=1699913326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNj+yYFj8tqbacxBJz1am0Z6u5J0WjWsVcH94aw05E4=;
        b=mz6AYVDla1XNrGwkLJz1vWmsxu2rMehrRh/K8yLh+n8VM/Wos6SSnmCf7xgwYNYq/S
         1dBIfZYX3az55VPCE28g6DA3Ugdc3D/s/hm3ZANTg16aHEcFHtzyAJ2frsv4bx03GSTM
         yXnUTZAAOkQKUAiVryDZaJF8/wlCg/KEUePCkoyw5em7pU6OqdD5Dh+WHBsH2By6EHw2
         w/sLryN1R3l/4/4PksKy30Paf7ZxevHZmvGKf2WwT8EgqlGCv6oIPGDPImdNvJ+OAJdD
         laDxnXgWWcretmUDFX9SduR4Dj1gJTeOYXncPCz4tv0YDCyZSMjuhHgR7dK4ThaUe5gB
         tQBA==
X-Gm-Message-State: AOJu0Yw14OMk7gInIXzn1H611GVaEj0Iir4XTm5lgronCfun5eFDt51T
	5CJYoPNgqWxrCglxIJd4XkIDbw==
X-Google-Smtp-Source: AGHT+IHVhBh30f+JOoAVyc2QKsR/ah623UmoWl1SgIkgpR+dr8rnAw01DthOC2rPkDANWzHKMwaNFA==
X-Received: by 2002:a67:c315:0:b0:45d:a616:78c with SMTP id r21-20020a67c315000000b0045da616078cmr5820829vsj.21.1699308526373;
        Mon, 06 Nov 2023 14:08:46 -0800 (PST)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id ks12-20020ac8620c000000b0041cb8732d57sm3778912qtb.38.2023.11.06.14.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 14:08:45 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	brauner@kernel.org
Subject: [PATCH 10/18] btrfs: add fs context handling functions
Date: Mon,  6 Nov 2023 17:08:18 -0500
Message-ID: <e6dfe2604e70f50ca96ab03f8bd2c7bb03c8a6ba.1699308010.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699308010.git.josef@toxicpanda.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are going to use the fs context to hold the mount options, so
allocate the btrfs_fs_context when we're asked to init the fs context,
and free it in the free callback.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 2f7ee78edd11..facea4632a8d 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2641,10 +2641,44 @@ static void btrfs_kill_super(struct super_block *sb)
 	btrfs_free_fs_info(fs_info);
 }
 
-static const struct fs_context_operations btrfs_fs_context_ops __maybe_unused = {
+static void btrfs_free_fs_context(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx = fc->fs_private;
+
+	if (!ctx)
+		return;
+
+	kfree(ctx->subvol_name);
+	kfree(ctx);
+}
+
+static const struct fs_context_operations btrfs_fs_context_ops = {
 	.parse_param	= btrfs_parse_param,
+	.free		= btrfs_free_fs_context,
 };
 
+static int __maybe_unused btrfs_init_fs_context(struct fs_context *fc)
+{
+	struct btrfs_fs_context *ctx;
+
+	ctx = kzalloc(sizeof(struct btrfs_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->thread_pool_size = min_t(unsigned long, num_online_cpus() + 2, 8);
+	ctx->max_inline = BTRFS_DEFAULT_MAX_INLINE;
+	ctx->commit_interval = BTRFS_DEFAULT_COMMIT_INTERVAL;
+	ctx->subvol_objectid = BTRFS_FS_TREE_OBJECTID;
+#ifndef CONFIG_BTRFS_FS_POSIX_ACL
+	ctx->noacl = true;
+#endif
+
+	fc->fs_private = ctx;
+	fc->ops = &btrfs_fs_context_ops;
+
+	return 0;
+}
+
 static struct file_system_type btrfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "btrfs",
-- 
2.41.0


