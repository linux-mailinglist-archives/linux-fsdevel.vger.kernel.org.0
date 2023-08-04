Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F57B76FC97
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Aug 2023 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjHDIve (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Aug 2023 04:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjHDItz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:49:55 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690924C01
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:48 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 456F7417B9
        for <linux-fsdevel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138987;
        bh=CQAHRH/ms/cFOl3S4jtiakCJJYzaMB08Yq0KPV8/UVY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dHCinPhIwLfckZkFU7tt4yPZR4kmCSgq/DySlrKITX/xaRPrdWkOudxg4LcEbYLVa
         AKxThHX1/+lsoaoaEARPNEy39iIUUVuDPr2P6wKyl5VJhcsHw8jBX3h68kqLcfPnzJ
         s/++6LuUDGkU7JlMDruW6fy727ZYasa9yZBgK/rQ4kWfSjsWmM9D6cVsNECsUYZr7I
         6ZJRd5O3GUJIL/9qwP6+ieqRPFK8h0v5Qh1msWe/eNKGYa94jKk+e8yIHudosB29jO
         OEKaQXbxgrWFZhyycaU1O2NHE/oaUY1BNRxRHI4JQDv0nCYU4nhHdRtRZg1HIkOK6k
         tNN6dV0qSDz2w==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a35b0d4ceso122137666b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138986; x=1691743786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQAHRH/ms/cFOl3S4jtiakCJJYzaMB08Yq0KPV8/UVY=;
        b=Ti3lkOj7aCEf1f1EK9UnA/Ohva/UoVJCNtupL4ZOVpNxYRlECZOBIIrntpwBnJFVyj
         k/fN4ozbmwwsPhZt0EA0QZDDnfBTGtEtl3WUGzYDygtJ4HmMcolwm8H6b306+1MTeUxJ
         5KnjGSoGmRyaBvaxwEkLJ1i0Vqg6mdpwlUYQzM2Tjd0GNiXcPUphYtlYRhMwhyrlrjdq
         7IByMBvvgRxG5Kangr6I+IN6ecOejCyMd1WSfmMFWrD1nmlyppShoSbE4VG91AsVN6rg
         NxKJec9KEaM7AASwrqfCvBHhLA4XnuxrTFrNC4gwtbrj+yIe70meB2Is+ftrbdYEZsiI
         UHlA==
X-Gm-Message-State: AOJu0Yx75KCyxVcwUD7SbPYN7n2B1vqdwz1lmY2pVSzZ/wOqj9+qS4MK
        H3q5neWX/EdY75Q6Gbpt/Ky1TTw94+0jaxKhAK5toboZpfFLoJ0yO90vslHPLEiGSwDhCA5gB6W
        d80K39ytybbxT2GLss6PmaN3vBK+E3nbA/yp5LcgFeO0=
X-Received: by 2002:a17:906:7494:b0:99c:4b70:4d6a with SMTP id e20-20020a170906749400b0099c4b704d6amr934857ejl.63.1691138985975;
        Fri, 04 Aug 2023 01:49:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVvZo5HsarBNOVycY50aKC5Clr4BW+jwzyxSFJ0XsHAbQYXZZdVEQArwzBO3xTW2T0oLqbNg==
X-Received: by 2002:a17:906:7494:b0:99c:4b70:4d6a with SMTP id e20-20020a170906749400b0099c4b704d6amr934851ejl.63.1691138985538;
        Fri, 04 Aug 2023 01:49:45 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:45 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 09/12] ceph: allow idmapped setattr inode op
Date:   Fri,  4 Aug 2023 10:48:55 +0200
Message-Id: <20230804084858.126104-10-aleksandr.mikhalitsyn@canonical.com>
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

