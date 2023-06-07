Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89EBF72681F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 20:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjFGSLb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbjFGSLK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:11:10 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE341FE3
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 11:11:07 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F17613F120
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161465;
        bh=sitF6aKufbc7DklTCjus/+uMnJoHcKEt7G8gHEJda3g=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=N7NNSLDJ2nftMuH2rWNI4p0YhHM5oYWx8agupH1lFLGYd1MM3feMEGYucrtbpmvQa
         fTQhi9NB/mE/H2zLuCPHSIixNJHs4TXTQsQSbR9vQJQfoZVpDfSjkXAYEDVelxumT7
         ONwT8AaBiW0WJpv0+SC1BATzfZV27zu6MQ4kRQv6EMX11w2bi2F0VG7MqRyJlo0W05
         00AxeXQsSvyfzA2ptRduOjOtXSJGehDk1vH4v88Um6jY/TkTnLXpmx1w2wDibGk1/2
         7tHTRlGqWuO6SAD77WBisl3TC2jn+wrKciiBJLx/p37o7TJYxOgvSRYw5XBz42QpuU
         oM3esVZOPQ6Ew==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9749b806f81so473005766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 11:11:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161464; x=1688753464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sitF6aKufbc7DklTCjus/+uMnJoHcKEt7G8gHEJda3g=;
        b=YMpnaZ3/6LyTqI/9ZkOP4LmoPNgf3A1RQIbssQDlpogXVGLWBQWhw25wR7l+a4BEzl
         pbeCfgUX7BZ9oZOJWDsCrxn6SADtZsaDGs/ITv5ky+muutiFr4Yy6JwDI9iSzycyF/TS
         SVpa92ZLHevRqjO90Hw9xyz/0dAiahuDCuRtoBMOBp/1KGhZn97EoHN+Kn4JF2witEd+
         bDkOMjQeEBY+pYqZ5P2j2xxb7ED8ETdxxY2G9KbpumxzzRQwt8/Glav6+IW3RYybvJVM
         KNTllqi9/IUq15Rwp43KqvaZjwupC/SWrsKqz0cJJWHqrvK0VPwMNS9M0wxEoQJqdTxO
         adIQ==
X-Gm-Message-State: AC+VfDy9HSz2zvn83lFUwFwXfuJVMq8P1gaATtSewImllrtMa2RuGGqW
        lCQU0VXNzpG0nmmpiWEwd+BapZHTe9rVoZ0JPf2tvfAupaLSwio1PUZmWNbpyuXNtjshtY8ICoy
        igQ+//91dzhEA0oHTrRBkQS/+gApLJUEDONROSVLftg4=
X-Received: by 2002:a17:907:3f9a:b0:96f:8666:5fc4 with SMTP id hr26-20020a1709073f9a00b0096f86665fc4mr8344020ejc.50.1686161464803;
        Wed, 07 Jun 2023 11:11:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7nkVS7ZYAZ2Uqeu+xxXRJBqJNHMUbuyQOiZzF6LyCbvyOJsxfiv60u5P1yL7Rjjj7ZaBQFEg==
X-Received: by 2002:a17:907:3f9a:b0:96f:8666:5fc4 with SMTP id hr26-20020a1709073f9a00b0096f86665fc4mr8344006ejc.50.1686161464604;
        Wed, 07 Jun 2023 11:11:04 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:11:04 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 14/14] ceph: allow idmapped mounts
Date:   Wed,  7 Jun 2023 20:09:57 +0200
Message-Id: <20230607180958.645115-15-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
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
index 3fc48b43cab0..4f6e6d57f3f1 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1389,7 +1389,7 @@ static struct file_system_type ceph_fs_type = {
 	.name		= "ceph",
 	.init_fs_context = ceph_init_fs_context,
 	.kill_sb	= ceph_kill_sb,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("ceph");
 
-- 
2.34.1

