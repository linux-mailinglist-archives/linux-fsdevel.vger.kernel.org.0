Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5210A72643C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 17:22:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241410AbjFGPWr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 11:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241426AbjFGPWG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:22:06 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FA1FC
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:43 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 93DF63F1E3
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151301;
        bh=aP80D7IJtF5T0WH6ImgNwtx1y7/GP3UA0si/dTzxF1Q=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=mRi3m18Q76CrGvI81VPbZaBnwTFBqw3xeNS+sziZs+jRKr4zbJ/dNH9XmkaXAMMRw
         9LjNuNMSbx5DqsqGjx+scbr3Vu/YHYwKCCMua5R4vGIZcYxTaaWuuMpDkBeRVTnUYn
         ZtjwnLY4PTDl9j2GaC4HcHekM3KMJD7iB3x5x8/q/eZs0UjvpW4iSp4l/CxJZvtz3c
         FPRYgYzr5ikCpaaVs1sPksb4+LvGaRJV95tHOvd3DwrHJ1XSupltQd78AUI8Imvq3D
         26CcemUj6SzYj5jS6P2qs2hRIF9Rmz+Qf6rwJ1B3jJwnP1SLgcak3iTz8hlp78CNg/
         olkJe8tt0w8Qg==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-506b21104faso1055030a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151301; x=1688743301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aP80D7IJtF5T0WH6ImgNwtx1y7/GP3UA0si/dTzxF1Q=;
        b=O+Kd32FfflOhTlBTiBesgdYSs09nXwsDNO4NQxH/Pf3ng2EG4cUHlUqFyZlhIKqGm6
         87EtRQs+Ur/zlDTuW56ftX5Qzp67d8FbpLN3ZaDuJ2T0V6x8pfqchu4EBkCrt9opQ2Lb
         K/+4AAhVDUYLWrow363i0SFIlCS+gUINGN9Q77erab/EB9U8beK3yQp+ncmxLdup+DD9
         okFF1UTuGk3fDqFjMCi8BCexK5rJ786749NXy4B7Ubiaas4NhayakurI+G+ls3qyaorI
         n2GZRi3gXop8HYumI1OKnL4CNfyu/knlrgrc6W/9SMFoHiZdvHzrH/9N0Mk1SiLu/iYc
         AfDA==
X-Gm-Message-State: AC+VfDwUxR2dQjTQin5sxPZq0YuajJQ6ZJX1ZddbY2Zye9gS/e/h+TCk
        F9ZOuD9geDQ5EGNVDQRtUc/TTQBf4VNcbDOWuTkCsOTJ1C2S1cFDBfewKUwkkdDqKRJaWt+dvIw
        /s8Aj77htV/Xdk5Z5Mynb3J99VshuiC1wakEZih6QbS4=
X-Received: by 2002:a05:6402:1207:b0:514:9c7c:8a30 with SMTP id c7-20020a056402120700b005149c7c8a30mr4752013edw.30.1686151301141;
        Wed, 07 Jun 2023 08:21:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5C/ocYU2yAPeNH8/65GFlsb1gg0GKVtLLnbC2OVeYGiRDh0YawOOodw8SZ7Vyn3ao+X9HziA==
X-Received: by 2002:a05:6402:1207:b0:514:9c7c:8a30 with SMTP id c7-20020a056402120700b005149c7c8a30mr4751993edw.30.1686151300822;
        Wed, 07 Jun 2023 08:21:40 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:40 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/14] ceph: allow idmapped setattr inode op
Date:   Wed,  7 Jun 2023 17:20:35 +0200
Message-Id: <20230607152038.469739-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
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
v3:
	- reworked as Christian suggested here:
	https://lore.kernel.org/lkml/20230602-vorzeichen-praktikum-f17931692301@brauner/
---
 fs/ceph/inode.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index bcd9b506ec3b..09c78a67738b 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2051,17 +2051,27 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 
 	dout("setattr %p issued %s\n", inode, ceph_cap_string(issued));
 
+	/*
+	 * The attr->ia_{g,u}id members contain the target {g,u}id we're
+	 * sending over the wire. The mount idmapping only matters when we
+	 * create new filesystem objects based on the caller's mapped
+	 * fs{g,u}id.
+	 */
+	req->r_mnt_idmap = &nop_mnt_idmap;
 	if (ia_valid & ATTR_UID) {
 		dout("setattr %p uid %d -> %d\n", inode,
 		     from_kuid(&init_user_ns, inode->i_uid),
 		     from_kuid(&init_user_ns, attr->ia_uid));
 		if (issued & CEPH_CAP_AUTH_EXCL) {
-			inode->i_uid = attr->ia_uid;
+			inode->i_uid = from_vfsuid(idmap, i_user_ns(inode),
+						   attr->ia_vfsuid);
 			dirtied |= CEPH_CAP_AUTH_EXCL;
 		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0 ||
-			   !uid_eq(attr->ia_uid, inode->i_uid)) {
+			   !uid_eq(from_vfsuid(idmap, i_user_ns(inode), attr->ia_vfsuid),
+				   inode->i_uid)) {
+			kuid_t fsuid = from_vfsuid(idmap, i_user_ns(inode), attr->ia_vfsuid);
 			req->r_args.setattr.uid = cpu_to_le32(
-				from_kuid(&init_user_ns, attr->ia_uid));
+				from_kuid(&init_user_ns, fsuid));
 			mask |= CEPH_SETATTR_UID;
 			release |= CEPH_CAP_AUTH_SHARED;
 		}
@@ -2071,12 +2081,15 @@ int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
 		     from_kgid(&init_user_ns, inode->i_gid),
 		     from_kgid(&init_user_ns, attr->ia_gid));
 		if (issued & CEPH_CAP_AUTH_EXCL) {
-			inode->i_gid = attr->ia_gid;
+			inode->i_gid = from_vfsgid(idmap, i_user_ns(inode),
+						   attr->ia_vfsgid);
 			dirtied |= CEPH_CAP_AUTH_EXCL;
 		} else if ((issued & CEPH_CAP_AUTH_SHARED) == 0 ||
-			   !gid_eq(attr->ia_gid, inode->i_gid)) {
+			   !gid_eq(from_vfsgid(idmap, i_user_ns(inode), attr->ia_vfsgid),
+				   inode->i_gid)) {
+			kgid_t fsgid = from_vfsgid(idmap, i_user_ns(inode), attr->ia_vfsgid);
 			req->r_args.setattr.gid = cpu_to_le32(
-				from_kgid(&init_user_ns, attr->ia_gid));
+				from_kgid(&init_user_ns, fsgid));
 			mask |= CEPH_SETATTR_GID;
 			release |= CEPH_CAP_AUTH_SHARED;
 		}
@@ -2241,7 +2254,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err != 0)
 		return err;
 
@@ -2256,7 +2269,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	err = __ceph_setattr(idmap, inode, attr);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
-		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
+		err = posix_acl_chmod(idmap, dentry, attr->ia_mode);
 
 	return err;
 }
-- 
2.34.1

