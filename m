Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D30970FA67
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 May 2023 17:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbjEXPgM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 May 2023 11:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236691AbjEXPfM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 May 2023 11:35:12 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6F10DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 08:34:48 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B8F441D56
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684942457;
        bh=iDvGWD+26D2Z+S1TMox8zoqslkMySxbj4ujfm+xfm2I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vrMYXkGriAviV9qWwNkbWKOpq2y/pYuxaMpgv6HSGch/09joM0c4d4Jm9yccjMyNT
         5XN4nnRT1VtV6hfhcuQLoyvvLTblZvvNq32DZgisWlSMcdZX6lgEE3zG0JoSFsdOfo
         GU1WpcpKhhqhmZANfPG8C7Yebu6yehSEo/ZsZUq1MAGsGuioCS8GZdzSQhU6urV43Z
         WdMVs+bUTH67gs9j5652QSUwEZzm88TRRlB2EnRSscTLl8IVT4Kbl4VqNiKVJBTDfc
         AV0vTkB90cUYmGDTGMSJUJHcOV9raToGwVof27ZLADaePwvW7ejSEcN5LihborjSGi
         ZxkGFtA7x7++A==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a355c9028so120327366b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 May 2023 08:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684942457; x=1687534457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDvGWD+26D2Z+S1TMox8zoqslkMySxbj4ujfm+xfm2I=;
        b=jN+C3NiV+5ClQfPiaAXsA4eo3YzQwcrRTHsLBcG84RPXBDLk+MJhOY045jO3cuGFaQ
         pmEV3gXu7InzYv2n2+6fFkzTochlYdaV8Sjfv4yx05eGVZ4SwzEKSHW+U6RCYVHtvOF5
         gE/ZPlnU7tAYOiG0h1L7tRX5X/bngF6PaQThVg5LPcsblR5Eb82/2Qw0eh/05PQXCdj9
         7nOd0dbkZjJyJy3HrVRGE8kQQ5AQQ5yLlu5IHwR73HwBEGOssP4ZgntIzLBCR3Bi9xHe
         0G1IexcKmfqDKVtVNGgBLMf2eySct9T/g/+B2lcfP6qpwCqhPWOJdeZsYsXMOO5C+uYa
         jJ0w==
X-Gm-Message-State: AC+VfDwN1lyjQF+jm2hXvSFFfk+46V2EDAlqZGbjl1qqgW0lQyD3v/t+
        PVbdO2iUtRoxlZrEUKi5rkPe+BKuR1arDZmvjkpo5eKri1Op/MOMQAG8EaWZ3gN4UwN3LcYe5F+
        ppfLJ5eCrswInY2/k5B9MLENV2zocqFy84jSNPFxrS3s=
X-Received: by 2002:a17:906:dac1:b0:966:471c:2565 with SMTP id xi1-20020a170906dac100b00966471c2565mr15855326ejb.48.1684942457338;
        Wed, 24 May 2023 08:34:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DVPnmHEEXyH6/S3ZdnkASC78MliSVSX6eChUtaO68Ytw9hQ0oJ2rkgjtW+JQ8P1CYQhOU4w==
X-Received: by 2002:a17:906:dac1:b0:966:471c:2565 with SMTP id xi1-20020a170906dac100b00966471c2565mr15855304ejb.48.1684942457080;
        Wed, 24 May 2023 08:34:17 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id p26-20020a17090664da00b0096f7105b3a6sm5986979ejn.189.2023.05.24.08.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 08:34:16 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/13] ceph/acl: allow idmapped set_acl inode op
Date:   Wed, 24 May 2023 17:33:13 +0200
Message-Id: <20230524153316.476973-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_set_acl() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 6945a938d396..4291c890e324 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -105,7 +105,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 	case ACL_TYPE_ACCESS:
 		name = XATTR_NAME_POSIX_ACL_ACCESS;
 		if (acl) {
-			ret = posix_acl_update_mode(&nop_mnt_idmap, inode,
+			ret = posix_acl_update_mode(idmap, inode,
 						    &new_mode, &acl);
 			if (ret)
 				goto out;
-- 
2.34.1

