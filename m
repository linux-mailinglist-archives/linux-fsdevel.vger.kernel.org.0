Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F437725B9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 15:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbjHGN3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 09:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233967AbjHGN3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:29:16 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A0DB3
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 06:28:54 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A939E417BE
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414909;
        bh=CQAHRH/ms/cFOl3S4jtiakCJJYzaMB08Yq0KPV8/UVY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wQ1hU/ppKY7wcxL7+1DWkdjyQPUulMHa/ItrbOMcJBRnYdtkPwFl+O/ByVMPamc2B
         d6++rk0yp5CQkMYdqRc5cxFYJNUsy56OQl3ZXZnu4pfoTCk43WD9po1NDCcVgwlW0o
         IyR4A08xXl4uP7kmA/anf9HoLbRVMVZhdYLx72CbWt4et1XiENgEN/3zZQ1BJzowa1
         KsSdA0hkDDBsyN5apkYGYCKhYVtkmCJmppFRq6g+hzmI7uFJnMvBLLW6se8OwOYfLz
         r3lHsNgO85FmVPW0vFvyR6TbHSPqMmwLMJKpWL+k7U7B23Bxr27g3RRRHYold5gZUR
         +jAmueKqVPYqA==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-993eeb3a950so343972866b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414909; x=1692019709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQAHRH/ms/cFOl3S4jtiakCJJYzaMB08Yq0KPV8/UVY=;
        b=kwCAep3i3qdvDa6/WhjeTSTJydQWmsU9tL5i9qaDYswt9p/KO5RjRTSpwItzRZuvfb
         pNxSn2rRpSkaOctNfD55fg/UXxSlfNJyx4HMb2r8mfyGqvQilAuILKqo/q4CmjCUiMLj
         K+U+F+apxkJ3e5SKBmPpCnBaenqktLdb3mVCZw3/J+BDfy0Qu2X2vpDEv4rRL1ni5Pxh
         kH+LP5zrzwWdbk6TKujyxZ5xqOWH8R9UvzknmKKk1eVjc48i/6tX7HMNSl8wYlx71G+i
         EYBfDfX6uCAm7EifmJ7yNGsmaO+zynPhtNJr1rCKBFKXKyLg6xxgyoKn6w8u8YGBQkXn
         yTRQ==
X-Gm-Message-State: AOJu0YznusH97dpMlerSe4yxlQOa2rsCdD6/D0SxYUCGnMVBOe33Nrw0
        2FYXXIVcadZvUCz4/Ujnzkc2Vz57HoDsdeyo+RLzBRCdrbdfaZ/Km6E2+AxyeHfvBjbrPE5jsS8
        BR9k1rOISU/PnKPrgt/PLAS/pePCRYkfVIpxfBKA5HQ4=
X-Received: by 2002:a17:906:41:b0:99c:47a:8bcd with SMTP id 1-20020a170906004100b0099c047a8bcdmr9099860ejg.67.1691414909457;
        Mon, 07 Aug 2023 06:28:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgxLGvA+W26confnfTAXig7L7dd3JYPpVQO+961emsoepRkzqFS8FTAnx3jrfgTDKBFgX4Uw==
X-Received: by 2002:a17:906:41:b0:99c:47a:8bcd with SMTP id 1-20020a170906004100b0099c047a8bcdmr9099847ejg.67.1691414909294;
        Mon, 07 Aug 2023 06:28:29 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:29 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 09/12] ceph: allow idmapped setattr inode op
Date:   Mon,  7 Aug 2023 15:26:23 +0200
Message-Id: <20230807132626.182101-10-aleksandr.mikhalitsyn@canonical.com>
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

Enable __ceph_setattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
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
index 6c4cc009d819..0a8cc0327f85 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2553,33 +2553,37 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 #endif /* CONFIG_FS_ENCRYPTION */
 
 	if (ia_valid & ATTR_UID) {
+		kuid_t fsuid = from_vfsuid(idmap, i_user_ns(inode), attr->ia_vfsuid);
+
 		doutc(cl, "%p %llx.%llx uid %d -> %d\n", inode,
 		      ceph_vinop(inode),
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
 		doutc(cl, "%p %llx.%llx gid %d -> %d\n", inode,
 		      ceph_vinop(inode),
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
@@ -2807,7 +2811,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (err)
 		return err;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err != 0)
 		return err;
 
@@ -2822,7 +2826,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	err = __ceph_setattr(idmap, inode, attr, NULL);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
-		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
+		err = posix_acl_chmod(idmap, dentry, attr->ia_mode);
 
 	return err;
 }
-- 
2.34.1

