Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7248E726823
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jun 2023 20:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjFGSLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Jun 2023 14:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjFGSLI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:11:08 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E94B10EA
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 11:11:01 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E35383F120
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jun 2023 18:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686161458;
        bh=upOvs6cNJRBF+ODdi690KD6aHJ8m7WaiezvTCZyfSFA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EXM9cTb2oIFgruKH3+yuFx/cTFCA67lrVeEVlg51dXgwDK0IFYmbB3wmVsojkEed/
         jcQhWL5DwwIvwRH+fkpYUWh33npch8VQbxVr6BcEnE1Jj++Koc2Y87PoLdkUsQXFu/
         UdGzJMW+CgoiB9NA28uxPk8fKnOiDxkYzkJGiHWXuNfF/XJoDVIQTDA5moME9s76BX
         7Tpaox/UF5prRb0s9f8OCEPcGXrKEb96cD9uOPX5vitQ884h0FOQkZiqi7UavNrMlW
         mATnsOCh+KmUFsj7Ne6rAmXbSSdnGBVBM6+4uMJEd9EhIsgtDiDdkaMQBu+nNB6htg
         6sxGiH9mGZW0g==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-97542592eb9so455752166b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 Jun 2023 11:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686161458; x=1688753458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upOvs6cNJRBF+ODdi690KD6aHJ8m7WaiezvTCZyfSFA=;
        b=C0shwyGc6ha58bORc2UKgUvuHHDwjgQ3JQoa5WGHk2nTqsw5RWQNqq4upOW9NLoMrT
         WqHlU2UKI0AlvKbcaZP/fbWbKuo0xqlObwpkYqh1ATzszl7hZtPavTyO5/DCsZaPLSAX
         oJk0Glo+idteMJgzN4ih5h3RH7U6yrCvGELJuzSAtdacMkdLlmwfQHa3qgV9PFhv7nxH
         0klS/Dqv6SbhqTfr1I/LmILR630Av8lSXX0whvrDOEXnNymqS1Gsv831NcgTNe+JoQcT
         s9Z5PvU1yMipAnJbqMosTsfvjHY31uDThfi7wRXRfAu2KIK7i9TkcaNblSF3a/iSik7i
         rbxQ==
X-Gm-Message-State: AC+VfDyG2Xt5KLH6ULAwsPNtTjOHcXLKMRsBB2k5EKyetXzBunrwYq1R
        ZR5tlnPPWLT2e38k5iAcs/1+nbbY09ecejMfene64lalG/ev7jpoMu/qXL5y7IfghW1WJFB2xnk
        2caD61W7xSw64g/yNbZgRTGXMhkqyjbQQQB80QWqwhV8=
X-Received: by 2002:a17:907:1687:b0:96f:d345:d104 with SMTP id hc7-20020a170907168700b0096fd345d104mr8799384ejc.38.1686161458015;
        Wed, 07 Jun 2023 11:10:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6QoESNX2izdSFLKQWMWvnXZssKwKUI4czDAd1i3v2k99ChaC1wwq77PMB4DrAQyTJe7ndMPw==
X-Received: by 2002:a17:907:1687:b0:96f:d345:d104 with SMTP id hc7-20020a170907168700b0096fd345d104mr8799368ejc.38.1686161457854;
        Wed, 07 Jun 2023 11:10:57 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id oz17-20020a170906cd1100b009745edfb7cbsm7170494ejb.45.2023.06.07.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 11:10:57 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/14] ceph: allow idmapped setattr inode op
Date:   Wed,  7 Jun 2023 20:09:54 +0200
Message-Id: <20230607180958.645115-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com>
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
v4:
	- introduced fsuid/fsgid local variables
v3:
	- reworked as Christian suggested here:
	https://lore.kernel.org/lkml/20230602-vorzeichen-praktikum-f17931692301@brauner/
---
 fs/ceph/inode.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index bcd9b506ec3b..ca438d1353b2 100644
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
@@ -2241,7 +2245,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	if (ceph_inode_is_shutdown(inode))
 		return -ESTALE;
 
-	err = setattr_prepare(&nop_mnt_idmap, dentry, attr);
+	err = setattr_prepare(idmap, dentry, attr);
 	if (err != 0)
 		return err;
 
@@ -2256,7 +2260,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	err = __ceph_setattr(idmap, inode, attr);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
-		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
+		err = posix_acl_chmod(idmap, dentry, attr->ia_mode);
 
 	return err;
 }
-- 
2.34.1

