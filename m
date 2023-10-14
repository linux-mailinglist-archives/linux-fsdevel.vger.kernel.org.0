Return-Path: <linux-fsdevel+bounces-361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3847C9622
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 21:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 472431C20921
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Oct 2023 19:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF961CA8B;
	Sat, 14 Oct 2023 19:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEqgkcPl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85441168BA
	for <linux-fsdevel@vger.kernel.org>; Sat, 14 Oct 2023 19:54:01 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD6FB7;
	Sat, 14 Oct 2023 12:53:59 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40666aa674fso32338745e9.0;
        Sat, 14 Oct 2023 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697313238; x=1697918038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tvy3FqnJ4DG6o/pLBeVM5ku9PA36gndTVq60MFOCCDs=;
        b=EEqgkcPl25NYFLsB0jK3bXctW6h0shKkFNj540dhcZTZ7znA1PqDusxXehoJnR6wua
         jMBKyNf26GhHEYzdsPvRGeTr0mu/zEtdc9hGpeANTuG60cEml3mvRLHNTUu+V5YN0Ibn
         9xuCe57Pxd7F9DRZoOss0yIS9CclN+89z9fElObUeVUKwsdF0R5sIGhRhDhM77Hnod8y
         E4VPDoXMYnjJMXi8EP+cvg+HAxBPjtDTehSNy3LzckS2EALUj/32fgo0Y18ocp59ENYu
         dWqCeM9afVntGkdA18peAwSazCJokEWW/Nis0MMf21u5hQrBKvUIXHybvPVhvNUNTu5g
         5YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697313238; x=1697918038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvy3FqnJ4DG6o/pLBeVM5ku9PA36gndTVq60MFOCCDs=;
        b=rqAiuPpSSapyqxxWDHkfihQrWJcopfA88qTKZRs1GoOhEnM//ctHfkl9kUmVy1S6hB
         x4YYYlJGoHVZVvg5TVL3G2oQjdOVtXPZmv6LSNlE2cB9TisweiUvwpNqldS1pyLDkf86
         EeHKCEQg4oDssOmLN5XjVsI30ZhHBHjO0+P/7rLBYRhmL7e6T0s93aBiAAjpSHZYQedS
         2xvXUXI7fcTHcZN3vDMoPFfCAjcnAsCCAv6TSSWCClgA8T/YPw++misvE7f8GD3Wf69U
         AAaYKSOH2RyLTznGJpsWOc3pATo19vHfdBWGxSeyoZ29e4zlaXV/zA032yv9nEAJe+HV
         uq1Q==
X-Gm-Message-State: AOJu0Yyhx6/Zk6QAeOFNW2suV36qbHtz+EnJxEbnxla9A6VHyYPC7ZvG
	NHgQ/5OzhtuQasNdX/xekTnRZSQhlC4=
X-Google-Smtp-Source: AGHT+IFGCniM+wPPAsfj+3xrP0RcVr3/eMTZmCBAmC5B/VzX0mvCjM06SYmau6MF6GONb93fSHD4YA==
X-Received: by 2002:a05:600c:1f89:b0:407:3b6d:b561 with SMTP id je9-20020a05600c1f8900b004073b6db561mr19170438wmb.9.1697313237799;
        Sat, 14 Oct 2023 12:53:57 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id c10-20020a05600c0a4a00b0040770ec2c19sm2775854wmq.10.2023.10.14.12.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 12:53:56 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] ovl: temporarily disable appending lowedirs
Date: Sat, 14 Oct 2023 22:53:53 +0300
Message-Id: <20231014195353.2103095-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Kernel v6.5 converted overlayfs to new mount api.
As an added bonus, it also added a feature to allow appending lowerdirs
using lowerdir=:/lower2,lowerdir=::/data3 syntax.

This new syntax has raised some concerns regarding escaping of colons.
We decided to try and disable this syntax, which hasn't been in the wild
for so long and introduce it again in 6.7 using explicit mount options
lowerdir+=/lower2,datadir+=/data3.

Suggested-by: Miklos Szeredi <miklos@szeredi.hu>
Link: https://lore.kernel.org/r/CAJfpegsr3A4YgF2YBevWa6n3=AcP7hNndG6EPMu3ncvV-AM71A@mail.gmail.com/
Fixes: b36a5780cb44 ("ovl: modify layer parameter parsing")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

I've pushed this to ovl-fixes and will send it to Linus.

Please prepare your patch for 6.7 on top of ovl-fixes (and overlayfs-next).

Thanks,
Amir.

 fs/overlayfs/params.c | 52 +++----------------------------------------
 1 file changed, 3 insertions(+), 49 deletions(-)

diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index 8b6bae320e8a..f6ff23fd101c 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -350,12 +350,6 @@ static void ovl_parse_param_drop_lowerdir(struct ovl_fs_context *ctx)
  *     Set "/lower1", "/lower2", and "/lower3" as lower layers and
  *     "/data1" and "/data2" as data lower layers. Any existing lower
  *     layers are replaced.
- * (2) lowerdir=:/lower4
- *     Append "/lower4" to current stack of lower layers. This requires
- *     that there already is at least one lower layer configured.
- * (3) lowerdir=::/lower5
- *     Append data "/lower5" as data lower layer. This requires that
- *     there's at least one regular lower layer present.
  */
 static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 {
@@ -377,49 +371,9 @@ static int ovl_parse_param_lowerdir(const char *name, struct fs_context *fc)
 		return 0;
 	}
 
-	if (strncmp(name, "::", 2) == 0) {
-		/*
-		 * This is a data layer.
-		 * There must be at least one regular lower layer
-		 * specified.
-		 */
-		if (ctx->nr == 0) {
-			pr_err("data lower layers without regular lower layers not allowed");
-			return -EINVAL;
-		}
-
-		/* Skip the leading "::". */
-		name += 2;
-		data_layer = true;
-		/*
-		 * A data layer is automatically an append as there
-		 * must've been at least one regular lower layer.
-		 */
-		append = true;
-	} else if (*name == ':') {
-		/*
-		 * This is a regular lower layer.
-		 * If users want to append a layer enforce that they
-		 * have already specified a first layer before. It's
-		 * better to be strict.
-		 */
-		if (ctx->nr == 0) {
-			pr_err("cannot append layer if no previous layer has been specified");
-			return -EINVAL;
-		}
-
-		/*
-		 * Once a sequence of data layers has started regular
-		 * lower layers are forbidden.
-		 */
-		if (ctx->nr_data > 0) {
-			pr_err("regular lower layers cannot follow data lower layers");
-			return -EINVAL;
-		}
-
-		/* Skip the leading ":". */
-		name++;
-		append = true;
+	if (*name == ':') {
+		pr_err("cannot append lower layer");
+		return -EINVAL;
 	}
 
 	dup = kstrdup(name, GFP_KERNEL);
-- 
2.34.1


