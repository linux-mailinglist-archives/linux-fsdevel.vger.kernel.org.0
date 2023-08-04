Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB6776FC99
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjHDIvg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjHDIuN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:50:13 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC50930EB
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:51 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4F6063F205
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138988;
        bh=ARhwDsiPa3Ci/G2xteJutduXCGuj42UUR3o8sfJhjpo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=tB0vkqV4+JXkkhN8K0zglXZiN0t1WkUTs/obTiAROq/xYXjQ2vQ8AVSb8fmIHaOPD
         RaKWuVVpSIZRBxRj+BpAnhcco5unBlCDFk37eSSFt55Xjw0+d+XAb51pM3ILQqOHSH
         4PFu2jQ3CWODiVjsiV4z5b9Mld4hkzJBAvzMHe96Q3V9YUwIWywNXniVteOK80X2IN
         HRiaEsRS3aUG0usPlKSbw841deTUDGgujOBXHxnrh+WFe2sI0d05mD4+ed+hR7kVgJ
         jS0V2dpmIxuKgyYHVNfge1KPucGyOBQ/EQqwpJU5/DesBgoiovARzzImp4fHgAk0Os
         9TQmtLT60COMg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-99c03869a67so124527766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138987; x=1691743787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARhwDsiPa3Ci/G2xteJutduXCGuj42UUR3o8sfJhjpo=;
        b=Gz51yg3AZ/0Ld3Yt4qBpqnXCWP13W+3wpo88wdlZL6R16fzL1PDq8gTiOlINaSU6D9
         z+J0XTUKd4WkeoH3/qvK4DH8nb2hHdmg0Lk1XdaN04zXRMqRQO7fG3uylJmavW8Ao4bL
         E0CbBzKdN/9Utf3pJxTgca6bsE56N33YTy1PuQyYwJ19j+qwg0tXWEBKgv4VjJK4GTCs
         Tu2gIUJBt8FRiOmEUWMMsUHUEMJ2ZWyReqGLQrNK4ULE6WSz5AIWTqFFzv41H246Irpy
         XJtjtxRAdJmJtDs5/AWKcPK/FS5ML93zt0o5MMMNDByQ7jbEVaTlCjwzUiXM0V8Bf8fE
         0i3g==
X-Gm-Message-State: AOJu0YyvPr1/0czx1eT4I+72WkcCNhkp7dOuypcqlDHpWKwJwEMZHgyp
        qNyylL/0IC0ni/+VFri9bczbZqbFoua4JuAOI8BerqJo+f97npFHZYS+lFbaLL6mPbi31T1x9B4
        ac74V+TDUsOHlTcuPv0khSPZ0YRnihPH922CcmZc/jONvKcXQ2h0=
X-Received: by 2002:a17:907:77d0:b0:994:5577:aeed with SMTP id kz16-20020a17090777d000b009945577aeedmr995719ejc.5.1691138987400;
        Fri, 04 Aug 2023 01:49:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFij2ZN/HuBWc4Nu5STOSW9BVGSH6Wz3WtoLMx8eDAi/KUmbdzucsXu/L2vGnsUCM+iyzwOrQ==
X-Received: by 2002:a17:907:77d0:b0:994:5577:aeed with SMTP id kz16-20020a17090777d000b009945577aeedmr995708ejc.5.1691138987251;
        Fri, 04 Aug 2023 01:49:47 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:46 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 10/12] ceph/acl: allow idmapped set_acl inode op
Date:   Fri,  4 Aug 2023 10:48:56 +0200
Message-Id: <20230804084858.126104-11-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_set_acl() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 89280c168acb..ffc6a1c02388 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -107,7 +107,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
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

