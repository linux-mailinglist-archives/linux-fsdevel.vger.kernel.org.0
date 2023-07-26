Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852AB7638B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjGZONc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjGZOL7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:59 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D961211F
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:26 -0700 (PDT)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id F360B42477
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380660;
        bh=V+geJeK43HRcagd4RPosGF8b069CSl1zVYPfJFF5DgU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=NgqCGWkwlYWKRiG0nASc3s2hGyUolQ4i/wDuOGS0osHsb3D6dJHd+W617mJZiiOKT
         iTIZ4UdMdympZm0ggFUt+4R+gPmopYwBsXQEetUuj2y8PlsYdEtpn5nayAh4fXvtVP
         Z4HPBCIoZsDmd2n4yM7x8nwN/W36iUEMyeoOCisns2P31FcM1RrZWDBGCaiJN/rAdq
         sgC0xPYRIMx4EZ13wf8RgoASqkY4wgQmocB2jmhf4MyHXSPWfuoOflYqZcn8YBbcl3
         9yIDgshV5maAfp537YkmS135iR2Xz1DOA5taXBgm9CHHT8bj+Vl7y8EZIrbP9JQz1J
         BqyirWWlknxbQ==
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa9a282fffso34340625e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380659; x=1690985459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+geJeK43HRcagd4RPosGF8b069CSl1zVYPfJFF5DgU=;
        b=CWoksmLHFWpywGU+uN/743Cv61N1R6TN/pH1UCRRIN/0vmK9ujacDNs6W62DCBKkCQ
         L7RTXYrfIayICF8ah8w/UxZDpU07dm1qfFZKO1LXLtLBWWyRAzzjbxe21Gjo+thz3Ptk
         Gy3X568c9+MC3PAEnB6m5pG7yjgqedJPNTMXUdFMcoQu0lMrjlsvZtritlkDbFhBE2uV
         CAf4SPxpUcWPPYhE/xlUcF390FV2C9yHN1Ohm64L/jzq1fB/8qY2uCPrvarPNLRyFchc
         gcS9ysNAF4zvDkZBrRKrcPI0tmvMhV34gm1SYz5HyHtZ1coNU4ZNk4eDlqEqMlG7XSHC
         Th2Q==
X-Gm-Message-State: ABy/qLY8kolrBmFmVrQa4ayU7wng/XV04NMBtgrxpu7xDeKrhRm2N0G5
        MwuIp9Euf4YupN2ZOUUK0dxcnMRmLO5rsyqN3l4GmwKIBoH1LkBdPsM0V4SAqcS6ke0/1IaX8jp
        hZmPHx+2HYKAxUgdy83pU/Ly8N7hC1lUX6xdaV9Cu+CY=
X-Received: by 2002:a1c:cc08:0:b0:3fb:dbd0:a7ea with SMTP id h8-20020a1ccc08000000b003fbdbd0a7eamr1439457wmb.37.1690380658871;
        Wed, 26 Jul 2023 07:10:58 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEIWQs4zQ3W3/YfffTF9QwaQh3tob3Vdd0DEnPyLt818r49Fpkk08smHP7Awq3GxxXYqPpH8A==
X-Received: by 2002:a1c:cc08:0:b0:3fb:dbd0:a7ea with SMTP id h8-20020a1ccc08000000b003fbdbd0a7eamr1439440wmb.37.1690380658568;
        Wed, 26 Jul 2023 07:10:58 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:58 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/11] ceph: allow idmapped mounts
Date:   Wed, 26 Jul 2023 16:10:26 +0200
Message-Id: <20230726141026.307690-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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

