Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6217295CA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 11:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241816AbjFIJqk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 05:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241815AbjFIJqI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:46:08 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF8B49F4
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 02:40:49 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8B7803F13F
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 09:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303175;
        bh=d5khlOcPOkR48ashhbagswr/xnjgstKG+L7ceqQR68I=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=t6MJJajGgpqhLtt2ZIK2Vrind5EIIpdL8fNbYVs7VFf0zyttJSFkc6tCUp9F3vRMq
         meT9Ahciak7NE/P/GJfLTHFU4mq2spljEYmk0E7c/KPwsCzpOjUiZeYdVrpuJ3DI8P
         dfW8WCTp5hYRXhWQuEFVyEp6E81zp+fUEoBxYZvYQlLnIyq79+ieYytla7giiHMlz0
         XpAWF/TXM6t6eaplHF9oBKbBP5iiUZB3QD9CgbLlB4Dd8amhfOOF9XQ5D4MHh9teG/
         8vNYKBU9sXHB4aISSk/VFp5ILxlO2yNEEkxWVcVKmdnJcFq1o+tGp8paKIT1fogCfp
         E/UA+s5ZGVW4A==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-94a34a0b75eso134160166b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 02:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303172; x=1688895172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5khlOcPOkR48ashhbagswr/xnjgstKG+L7ceqQR68I=;
        b=TbH6RqB+LsebYDIOGn7XpD4MJ1nuff4esqZRAqIliFCH/zdkeEmF9KoyjSVOCNyWj/
         ZGue3Z1qLdRejwMtQV7gM/ql4HHa02AhVtCjTz0VZMu9NkZNNVXojw3z8uEMSv2rfwpW
         rO0n3sTEgnfcTpkYKChRId+fgw50RQN9ScRw4Y2epQR7xbXilZhYwc79Oj9jH2u2KJ5W
         ko9QWiYxykidpe5+RFocUKADZQmrIAEm3hoMckOgdTBEnVhWYVoC1ztjl7UNSE+5tKXQ
         5lfff3M7h5phdwoh/0uWvOdany4geII355hX26FTBMm97kAf8yO5cy6kUiyFWeDyKsft
         XySQ==
X-Gm-Message-State: AC+VfDwoFnsuiqPi+9W3AiS24kwpXDp6k61XPqlYehngjqDw3/qV9YlK
        PbDzWMrq07j9c5ue9M98QALDSkpnn9t98GKZ3OR1SGkSxJ1Xye0g4QLEr4LqxslPeGOyN/xvJ9p
        EgBRMP8jltu0yv3vnkQH4TXj65NjV4csU9hUOP8JlhG0=
X-Received: by 2002:a17:907:2d0f:b0:965:6075:d0e1 with SMTP id gs15-20020a1709072d0f00b009656075d0e1mr1243439ejc.72.1686303171874;
        Fri, 09 Jun 2023 02:32:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59kDZebVrWioHVCJrl8ktxJliY7MnEjejxAd9hrZlN9hAJ/qDACsG7YUf21ymnpatNXrM/eQ==
X-Received: by 2002:a17:907:2d0f:b0:965:6075:d0e1 with SMTP id gs15-20020a1709072d0f00b009656075d0e1mr1243429ejc.72.1686303171703;
        Fri, 09 Jun 2023 02:32:51 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:32:51 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 08/15] ceph: allow idmapped setattr inode op
Date:   Fri,  9 Jun 2023 11:31:19 +0200
Message-Id: <20230609093125.252186-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230609093125.252186-1-aleksandr.mikhalitsyn@canonical.com>
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
	https://lore.kernel.org/lkml/20230602-vorzeichen-praktikum-f17931692301@brauner/
---
 fs/ceph/inode.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9a4579da32f8..6a8aeb4b8fb8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2509,31 +2509,35 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 #endif /* CONFIG_FS_ENCRYPTION */
 
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
@@ -2756,7 +2760,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (err)
 		return err;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err != 0)
 		return err;
 
@@ -2771,7 +2775,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	err = __ceph_setattr(idmap, inode, attr, NULL);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
-		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
+		err = posix_acl_chmod(idmap, dentry, attr->ia_mode);
 
 	return err;
 }
-- 
2.34.1

