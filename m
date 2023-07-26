Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3938D7638AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234477AbjGZOMq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232432AbjGZOL5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:57 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3774C3C11
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:20 -0700 (PDT)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 089BC4246E
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380655;
        bh=5Jek2ao2Gg23mz8Y2ufU3Ts9QQq34R72Sad2dO2kfLI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Huw+yv96Q6JnUXQUHGSgOuuUwJu0mXq2UHfgU2SpUvA+5QrXdUHTwtzhTJ8wZsdRq
         t6FE4aa8kil3d5Clce6Cwpljm6fncxn+4CdZ/ci2YeMrPZLYdP2aiIQJ9djntqZjZl
         s6JXA/9FyJeTO0ORIBTI3As4eVpvamYCNt27JPVAWZ+ac2Qm+L020757LvbThTc2tt
         uXeSJcR4VT783Zde79w3RHiJluz3iPgezRIAfLkMv+U1bpAaph8RWUWbCkV87A5BRP
         t7vPkl6jU683jNz61vtdudloWbbtepHJKDVeI2PBEEs/et1UQ5f5ANYFEnRO6RIfwS
         E2rgmaJHac1Xw==
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fc00d7d62cso40675225e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380652; x=1690985452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Jek2ao2Gg23mz8Y2ufU3Ts9QQq34R72Sad2dO2kfLI=;
        b=lF9CDSTOWvoNxwCd1KkRJy/hjYEQp7qwDFs5/2xLHwg1ewB22g0OHkrLd/Qszf1zsq
         G8eCnyDUegdoKYHbSQEGcC8KDhBeB6CxpBKYv+0GPeuJH8we1Nzl3NPyKXaA4EPseRDB
         oWQpnDmC/tGqgIwdA80eckev23uvC6IZJnvZqfgwaz54bY0HDwGqu0lvv7B375m8otYG
         2UgA5vbx42myZnXdDybL31Uj2dBsMqkmlPdxlAps9w3U+wYOSQ4B2sKKCBmi6oYsoVeU
         lEfxc2zdaWUc4kSERrfv+vzDQsIzturpYCeE1zATD3mO/kSwMvTN8c6ULzS1gcu0W/fB
         3jug==
X-Gm-Message-State: ABy/qLZ4YFiK3g7l6ajdhz0oi3+i2eg1VaWh0Zgymr0ylXhHuh4TCWGi
        98WH2atacXHDgYAMOlSKLDxqliytyvwOj9/KvGZiRv5SBxng+C/BbDGdJNIaTvLxswMmh++oyxw
        UyaxGZcBVDs3Wux7QnMUt0gMEIOh59o4oSyecunl9D+o=
X-Received: by 2002:a7b:c319:0:b0:3fb:e206:ca5f with SMTP id k25-20020a7bc319000000b003fbe206ca5fmr1487594wmj.31.1690380652184;
        Wed, 26 Jul 2023 07:10:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEWv48lMUMQK7iTGEt9eWMLDMsQrSzRq0Pw33rkJh6iPkIcCj2xr9B5VzgjaUxTd/K5dKo2qA==
X-Received: by 2002:a7b:c319:0:b0:3fb:e206:ca5f with SMTP id k25-20020a7bc319000000b003fbe206ca5fmr1487585wmj.31.1690380651969;
        Wed, 26 Jul 2023 07:10:51 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:51 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/11] ceph: allow idmapped setattr inode op
Date:   Wed, 26 Jul 2023 16:10:23 +0200
Message-Id: <20230726141026.307690-9-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
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

