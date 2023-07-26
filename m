Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4982776388B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjGZOJ1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbjGZOIK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:08:10 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F385A3C0D
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:29 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1DD1740821
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380446;
        bh=V+geJeK43HRcagd4RPosGF8b069CSl1zVYPfJFF5DgU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=scXOCpM7mzEFDlX1tJCN+26CEVSlPEuEF70KwmerdIgi8IlyPiS5humZx/GLQpi7R
         atFSxCiX+uQJh3gpSIQvePoqvw5L4r9mMZSgMrTgl+WFxoQSdfqmBHgpQUWvXoNPyt
         J8CG5NcVcrmZ+m1oyHlx20R3KdXki05iKJbVnJ3dsOZPrPn24J6aj5fmDtxI/Z9tus
         9P+a1EEYxNrzqnhK1MKxqRanKkt5WAkUVUi8IIvCmrVUIweRDbZ02OHzvoI/jRKXoR
         AljJll7Qcp6Zrv5f2ypooNLSNXyn4EjYq4vGm9Behkh1Yw2VWqagSaPj2Hbe5nJKsm
         22eXw+IQby77w==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51e0fc38f16so5137239a12.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380444; x=1690985244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+geJeK43HRcagd4RPosGF8b069CSl1zVYPfJFF5DgU=;
        b=OJ3uy0khTZtCjJHBzZVb52q+CqrPEdVqvuE4Oeft2a3yJCZcZWee8b1OF//sGIIPeY
         65X6y25G/0Dk7ovmTMKon6rfhk8M2I/bJY3CJbpl/FO6wBJ52dwEq8opgm6sxcoX88iX
         +SiPNP8UzFM4mMhujIV27gaIiR6lAhlXgKme+UH8AjqIKt+8Of1tphxHEIj0ZHSE5y2p
         sfDIEiYcl/sZMCRNg2FRCMv1s9Q6tVmUlCHeFKut9J4KXktpJfRItMoO7W+X7SYX0dPe
         OUzgFP4Q+uXpHo6aZGGu3/8FTM1AyOjhcNlEfoY7BpnKK9ZTPRF91Ar2at0bhL1MuQhJ
         HWMw==
X-Gm-Message-State: ABy/qLZwLDUMHaAtCPHI+mmGLmD2HDI3zE19iYMhUoBGyXiP3zHAp85e
        RvVgQHsZPpsgVXT4EOdQHXvdiSQGfJWlDX3zlM2kuiaxvNDhlKvscUQD+2BpOk1MqqkVCY7evbK
        YysDJXZlgJbUMU901w8tkFndskR2pAnjyLoATO4GSUB0=
X-Received: by 2002:a17:906:73d0:b0:99b:ca0b:90d0 with SMTP id n16-20020a17090673d000b0099bca0b90d0mr1105786ejl.37.1690380444811;
        Wed, 26 Jul 2023 07:07:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHYNS6ydWUDIz+KoX/Z+jXvAzODgkUoK/FFuM9v8E3tFW7PoARWjcrVOz79y+SQStlOKZvI2Q==
X-Received: by 2002:a17:906:73d0:b0:99b:ca0b:90d0 with SMTP id n16-20020a17090673d000b0099bca0b90d0mr1105771ejl.37.1690380444512;
        Wed, 26 Jul 2023 07:07:24 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:24 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 11/11] ceph: allow idmapped mounts
Date:   Wed, 26 Jul 2023 16:06:49 +0200
Message-Id: <20230726140649.307158-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Now that we converted cephfs internally to account for idmapped mounts
allow the creation of idmapped mounts on by setting the FS_ALLOW_IDMAP
flag.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 49fd17fbba9f..6326ab32e7b3 100644
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

