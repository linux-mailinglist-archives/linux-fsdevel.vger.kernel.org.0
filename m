Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8747283F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237255AbjFHPoi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbjFHPoR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:44:17 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE5A30CB
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 08:43:51 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DE04A3F372
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239022;
        bh=gghyNGCh9Nhwv51CwrkrRVAEuotD0ib4eCZetw54L9Q=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=TtS9Bh644+5q0boodMQLUJ4lTBcUTjo9TteChfFF9hij/Y9chzQAQspjQE6avG+9X
         N+hV8WeWvPcuVo19hYohumj1sHWZ7YusJWHw56wtRQNPT+u5iD/L+e9uyZVDgli9h6
         pGhdrtWe24hIj6gqvswg5lNHZa1L6e3iX8B4Kjet+rF50BoExtCK+c1gRfis//Cr0Y
         wA+fFGEQhhUL+NgdY0EPrebF8zccAQSuFow0UW9S6sT7rpRl25r8yCDUwUu+oPE8JI
         94ltbnnVNOh4fdCAup3DnO/3QgdLFCMfD4KQfaJ+Hhbnh9ZJhcLpKnqALsxSqqaMBP
         bgKc0JbZfqq8g==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-513f337d478so692922a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239022; x=1688831022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gghyNGCh9Nhwv51CwrkrRVAEuotD0ib4eCZetw54L9Q=;
        b=AcrvyBrfH1CO0Gg29unWpL7m1EM6MKs4/6zNY2MolE7gN6zs2HntiljXugoGLS/f5g
         o2eZhe9CH9rCSngaxt/qUzuHljy7ajAHanQzWWwdEGtj98Hkn2dStlLDqJ24tkFWrFM9
         FMSM7vMF7Tyf6hBGwAz7g8hR5Rs5Jc8ccYdzGKCZc1hw2Q7snN1KZYqowGXgOpg8tgep
         EQas0ZNGP7U2Zx0KxALEoUuAprh/pztnwI8cwj/WZw9HlZERdzdrt9c9eO1kfYMsWMNp
         BGJYUjB7x2wGwnt8eHAmF20I9h9zWQhqUPuDyGewydeSH8d8dHJjWKICJjfCD06R7pl8
         91nA==
X-Gm-Message-State: AC+VfDzO3l+gGtQxNbHb4Fh7MU0I8Vd17sgofBhkH/xPXs2x8LuOigAz
        1C0lvznIzMbM7jfoEwqbN/8RpU9Jg3P2VHOD+cbXb926pMvKbaTgVTxeHz49GEkt9Pohui7hsLe
        7ppempcNLwjSFfr7a+IrFoSA6iLy+EXHSlpd/jyd7330=
X-Received: by 2002:a05:6402:2cc:b0:514:ae18:1637 with SMTP id b12-20020a05640202cc00b00514ae181637mr7681214edx.23.1686239022298;
        Thu, 08 Jun 2023 08:43:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ63b1wA/FX3sQfco4KxR832VVJA6Hb0940jQo24+Gp017FLpW0d586mQ7ovqxlzwyLxzMj3Mw==
X-Received: by 2002:a05:6402:2cc:b0:514:ae18:1637 with SMTP id b12-20020a05640202cc00b00514ae181637mr7681197edx.23.1686239022090;
        Thu, 08 Jun 2023 08:43:42 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:41 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/14] ceph: allow idmapped setattr inode op
Date:   Thu,  8 Jun 2023 17:42:49 +0200
Message-Id: <20230608154256.562906-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
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

Enable __ceph_setattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
[ adapted to b27c82e12965 ("attr: port attribute changes to new types") ]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- introduced fsuid/fsgid local variables
v3:
	- reworked as Christian suggested here:
	https://lore.kern
---
 fs/ceph/inode.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index bface707c9bb..58ec603a55af 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2052,31 +2052,35 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
 
 	if (ia_valid & ATTR_UID) {
+		kuid_t fsuid = from_vfsuid(idmap, i_user_ns(inode), attr->ia_vfsuid);
+
 		dout("setattr %p uid %d -> %d\n", inode,
 		     from_kuid(&init_user_ns, inode->i_uid),
 		     from_kuid(&init_user_ns, attr->ia_uid));
 		if (issued & CEPH_CAP_AUTH_EXCL) {
-			inode->i_uid = attr->ia_uid;
+			inode->i_uid = fsuid;
 			dirtied |= CEPH_CAP_AUTH_EXCL;
 		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0 ||
-			   !uid_eq(attr->ia_uid, inode->i_uid)) {
+			   !uid_eq(fsuid, inode->i_uid)) {
 			req->r_args.setattr.uid = cpu_to_le32(
-				from_kuid(&init_user_ns, attr->ia_uid));
+				from_kuid(&init_user_ns, fsuid));
 			mask |= CEPH_SETATTR_UID;
 			release |= CEPH_CAP_AUTH_SHARED;
 		}
 	}
 	if (ia_valid & ATTR_GID) {
+		kgid_t fsgid = from_vfsgid(idmap, i_user_ns(inode), attr->ia_vfsgid);
+
 		dout("setattr %p gid %d -> %d\n", inode,
 		     from_kgid(&init_user_ns, inode->i_gid),
 		     from_kgid(&init_user_ns, attr->ia_gid));
 		if (issued & CEPH_CAP_AUTH_EXCL) {
-			inode->i_gid = attr->ia_gid;
+			inode->i_gid = fsgid;
 			dirtied |= CEPH_CAP_AUTH_EXCL;
 		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0 ||
-			   !gid_eq(attr->ia_gid, inode->i_gid)) {
+			   !gid_eq(fsgid, inode->i_gid)) {
 			req->r_args.setattr.gid = cpu_to_le32(
-				from_kgid(&init_user_ns, attr->ia_gid));
+				from_kgid(&init_user_ns, fsgid));
 			mask |= CEPH_SETATTR_GID;
 			release |= CEPH_CAP_AUTH_SHARED;
 		}
@@ -2242,7 +2246,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err != 0)
 		return err;
 
@@ -2257,7 +2261,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	err = __ceph_setattr(idmap, inode, attr);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
-		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
+		err = posix_acl_chmod(idmap, dentry, attr->ia_mode);
 
 	return err;
 }
-- 
2.34.1

