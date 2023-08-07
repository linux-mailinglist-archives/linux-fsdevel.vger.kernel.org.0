Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B247725CB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 15:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234047AbjHGNbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 09:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjHGNao (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:30:44 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C942D66
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 06:29:52 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 32F4F4427A
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414921;
        bh=4z/daiO88HhZeOEnY3F9QYhLlQO1p3UrY3NiyEq1U7U=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kLWym1tpcF36phHFDefL9y77tzGIPb2o+gsRAA6ZblR3Vl5dh1tvntKF1GwfXgw9H
         ve5jTFhIg8zYF7qzMGZs0tfSe3lfZIt4HxLv/cZ8Vw2P1KIRgz5u51YUXrmWuzhu1h
         tnrmMBuCA4hEZAWO+un3Cv69xjl/XqhX/irAvo5BemvCjzCnReZ0VvHJ53rhWsh+dK
         0j4WTG4xsi3HNXJKhWpg3AMaia56TGe8csPjUEYoxqK/7YS083SUghGIg3LUOqkYsO
         uUcYPKiTC761JloRpw9ZVFwUdjXwJpt8Nrno+sAHOmv2M586WEvDjjYDjaieEDtWYF
         hJRD4mtqj+8jg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99cb1b83eacso347427466b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414921; x=1692019721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4z/daiO88HhZeOEnY3F9QYhLlQO1p3UrY3NiyEq1U7U=;
        b=Hs83ZUdcThzAy/FN4A1TUrZmJITIaRpyB2rKQ4Ma2C7JXT9V5xZMdfWgFg89oCakNQ
         Yv4gLU6WHV7SVFMLfsG84O7OO7aUrfYUMD1rHym1COzrxMqUSbbTzuj6CVgewqldHJwf
         kvFueDv0g3IKkUUQgcTr2+Qan4yXfC4vbgLLXto8w9FHjsy5X2LPJptpx6suRJFy4S6F
         6F0xRIGIY0RTMKH538X1aJTWJ0PkImMQXbRtDf36ytJKbCR7thztdjtcI5eDUrmnt7PZ
         +bSzkNr0Js1nWwCmF+1bWFmk1S2DJDv6fYH5dhpK8pgfydvf9HedjMPDg3QB+sYKWDBg
         QclQ==
X-Gm-Message-State: AOJu0YzOD0pDUnhM6ZKXp3YD+K8m5Zs9Zd1pQ2DvBGedkt9WNMmFNNTT
        yB1uCzonlCg/UpzbUrmcwyu3uvtSn4b/pngHfy5C9XQWyGPT8ERBhMx9TciJLrXI6QGLJdS8Ws/
        pPxC3hJQEi9m2Z7Li8bYRPufNHjRoW89VJlYi9nDrl+0=
X-Received: by 2002:a17:906:8a44:b0:99b:cdfd:fb44 with SMTP id gx4-20020a1709068a4400b0099bcdfdfb44mr7381517ejc.9.1691414920938;
        Mon, 07 Aug 2023 06:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwy+L+nCPnNmq6S3V19tL64bywfoR6mM7JJPFsVDhKATekruSoiqA62F3J2sZzqV/zbNE/KQ==
X-Received: by 2002:a17:906:8a44:b0:99b:cdfd:fb44 with SMTP id gx4-20020a1709068a4400b0099bcdfdfb44mr7381510ejc.9.1691414920783;
        Mon, 07 Aug 2023 06:28:40 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:40 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 12/12] ceph: allow idmapped mounts
Date:   Mon,  7 Aug 2023 15:26:26 +0200
Message-Id: <20230807132626.182101-13-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Now that we converted cephfs internally to account for idmapped mounts
allow the creation of idmapped mounts on by setting the FS_ALLOW_IDMAP
flag.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 18bfdfd48cef..ad6d40309ebe 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1581,7 +1581,7 @@ static struct file_system_type ceph_fs_type = {
 	.name		= "ceph",
 	.init_fs_context = ceph_init_fs_context,
 	.kill_sb	= ceph_kill_sb,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("ceph");
 
-- 
2.34.1

