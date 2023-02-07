Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2A468DE00
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Feb 2023 17:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBGQdM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Feb 2023 11:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjBGQdI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Feb 2023 11:33:08 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2603A586;
        Tue,  7 Feb 2023 08:33:02 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id q19so16562556edd.2;
        Tue, 07 Feb 2023 08:33:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=awWoQ9pWtl30P/fj1OZRKpXEwIyCWu6Z5dWu2NWrBsY=;
        b=Gy0rmu1n0mIAo3JYva4zyI3OkWY2xEA/06qAMphhXuwSTZ9XIa6bljNhwpb6dRX8s+
         g9NDkm2nGNCmD8Gwje5vLr98RnxKwxB3QXfEjUjNRGCGhSai2AUU/rpA1YNh4Ct/ighg
         x3eC/6gx6UPPheRLfwuGOPrRvp9mmUXWHBws6zehjUw62R/YIpfQ2ahNvNaoXmdi+8j3
         PTRDy2jpcZQB3YD0LRw26BnkTqw4F9FcyT82kQWuAbpx2GNjudKW8tpg6Y1ysIeG/KRc
         JG3rTA+tmamSOJO3KkYXE/Zryh7C1TMb+BhVqiLneQ1+LWH4xosyIMQGuJzgqi0harWu
         jBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awWoQ9pWtl30P/fj1OZRKpXEwIyCWu6Z5dWu2NWrBsY=;
        b=UjwZPZaAq0jxY4KgvNdiDWRbR4e9bqvSXogY9MDJAg9roRR/Z6wSA22GQy7/Qz2jCo
         jJHBG7W5mRsyz6dcKkFjcd72rRBkfAc2M+FxUBQrqmE6oqT6oKvIjU5cs0roKjDBo31w
         MR7rnBM+AcA/d/OEfzSBQIf55rm2k8zVDR0usvaS7JD1orB4uJEgLPNoagSqPZGHtP98
         fRKanGMJyaGGIJjjyzj7BU9O0fVxQpoK+wTxIozt9d6TQaed4mxCBKK0P18jkuxLXLTq
         eEw6SzQQUMiMtZ/j/0hZ5ffr+UtUBnbZVC0m+5dp5y6FyG9Ggdsz4arGrEh1/lkPV9Zf
         XYJg==
X-Gm-Message-State: AO0yUKVaJZy8Ar1i1j302Mtdf5NyVaf+bDlD2GFXXjGjG/X7OC1LEa7F
        /zQgbvsXqMVJrfuKyHfI7oQ=
X-Google-Smtp-Source: AK7set/P06KTZQ7TC5Q6iRmI0yQVNhupja3PtOGwb9cPzkpYMPZElL1UaB16PLTkTfG7miIS7Le5zQ==
X-Received: by 2002:a05:6402:51d2:b0:4a2:64d7:16bc with SMTP id r18-20020a05640251d200b004a264d716bcmr4606384edd.4.1675787581245;
        Tue, 07 Feb 2023 08:33:01 -0800 (PST)
Received: from mineorpe-virtual-machine.localdomain ([37.252.82.187])
        by smtp.gmail.com with ESMTPSA id u23-20020a50d517000000b004aab23dec5csm3271275edi.4.2023.02.07.08.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 08:33:00 -0800 (PST)
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     Ivan Orlov <ivan.orlov0322@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org
Subject: [PATCH] Fix warning messages during documentation compilation
Date:   Tue,  7 Feb 2023 19:32:43 +0300
Message-Id: <20230207163243.20249-1-ivan.orlov0322@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update vfs_tmpfile function description to make it correspond
to the actual parameters list. This patch will fix 2 of
the 'Excess function parameter' warning messages.

Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
---
 fs/namei.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 309ae6fc8c99..b6f89b29dbc7 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3571,9 +3571,9 @@ static int do_open(struct nameidata *nd,
 /**
  * vfs_tmpfile - create tmpfile
  * @mnt_userns:	user namespace of the mount the inode was found from
- * @dentry:	pointer to dentry of the base directory
+ * @parentpath:	pointer to path of the base directory
  * @mode:	mode of the new tmpfile
- * @open_flag:	flags
+ * @file:	pointer to the file structure
  *
  * Create a temporary file.
  *
-- 
2.34.1

