Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643F276FCA2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjHDIwJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjHDIuY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:50:24 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493CC4EDA
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:53 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id EF3454421A
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138991;
        bh=4z/daiO88HhZeOEnY3F9QYhLlQO1p3UrY3NiyEq1U7U=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EyZI9tm/ie9SLrIP74WTf7r0qW2ki2tXuHU2LF9h8Tt1OZG3guyFwioLzVwQzhTJq
         nqxyYs9XZK2ubfL+6kbcYYjFN+Bk9/LymL3i7v2L9C+INNf8ILHrrMAQY2UX8YOpLi
         rtlyWaLonpBbQuXvn5ISQBKg/awAQ2rYB9z5wwWA9HoVMc2XkEDKXEJMRzMmhr41Vx
         ot58a9Ivvp3UivJ5iT8AxeEIAI7TJGzfaSm6HO0mTVmJS9z438aUuj9gH7XVr6q/Zf
         l7+tvB3vzMjbgXl/lEMounq0rwUPvLPBuUq0b+8y9JcpwLqUA1LgHMNMgqlHMTWYKg
         XAwkCZwHU+4CQ==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso124427266b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138991; x=1691743791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4z/daiO88HhZeOEnY3F9QYhLlQO1p3UrY3NiyEq1U7U=;
        b=MXdLITlZHc8hgoaCDb5i/wGXyg1qQ+2aMvTYA110VMPOqAu7S9ElpLrIJ9a8yd90SN
         7kJMdg3CTQzXeduowvnhS08Bga+cS8cMsbz9hkyeEzbs/6261vhd+1+9H61AYjOk1XOp
         0pT5be1aKCleiBdLXtkVhZy6k718W8SVyIstzh6c03v4jtC+7+VUWhV3WGSBS21nJFKi
         nfq4RQEcTm6sbeVNYHAdW8BW3wsftgjkX8IE1fJfXu4akjQB2/SyGIVo8uASGJlUT5uH
         lCkkiJCIqv4s9KFKCMFNWA76JsDRysCHpPO/h+Av54aOTxJidRIfhlkCbi1mwhM140Ku
         aokg==
X-Gm-Message-State: AOJu0YzhbFkMGkHmb4ZKcU71BOlHmEGwWTxQLd9mR/6khRdwe65gRiVk
        E7PH0GVrDzf4QnQI2eXi3Z76RdKikvXkUV4jtOz7RS/fFY+Bwl+cMGW0sEgbQ4Xnqu8VkdQLYLP
        meFGuE2wKw9+Syw+j/IwaKuI3PzSGHpj6Mjlz4JrstpM=
X-Received: by 2002:a17:906:2cb:b0:99c:ae35:ac0 with SMTP id 11-20020a17090602cb00b0099cae350ac0mr32347ejk.61.1691138991754;
        Fri, 04 Aug 2023 01:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdh2YBW+3zSthygL5eMI53A2dql4TVwWtXDEJAl+omt1I6HfFzDgF/roaG3QRdDVBhhechfA==
X-Received: by 2002:a17:906:2cb:b0:99c:ae35:ac0 with SMTP id 11-20020a17090602cb00b0099cae350ac0mr32336ejk.61.1691138991574;
        Fri, 04 Aug 2023 01:49:51 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:51 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 12/12] ceph: allow idmapped mounts
Date:   Fri,  4 Aug 2023 10:48:58 +0200
Message-Id: <20230804084858.126104-13-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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

