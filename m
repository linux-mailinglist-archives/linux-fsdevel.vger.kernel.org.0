Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859207295AF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 11:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241661AbjFIJl5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 05:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241844AbjFIJli (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:41:38 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D4649ED
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 02:36:17 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5B3CA3F379
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 09:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303185;
        bh=ErpWfnSHCAR2b37e5NamwpmTb1AxMZzXeuUaWWgL6I4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=McE2C5ygIAAUsLZSv2rLyD7UEXzwLJa168uCkceRkwH2TElDOcitNZITWwOfuOrfL
         baPHKx+lc9sYJZDRlV7ekmjfrnGTSgHVgemnzjENOFc9yK5PyB/opZ0IKK7vQFe1wu
         CZRrqgkVA1ZqNW3j71RrrD6eLDZ/TDiE5lCk79EfclHspBle6/OSMEpZWvG5RUFMNW
         3Ok/fL8mhVRDGc4Vjgf6jC1NbUl/ic3Dvi3idQ22pxR24yrd72yQBEXmEEmUeTfk1m
         DZII69TB/vDcL1idkdpQ2rJzxIppEmclQo8dEowfgRJb1+vIlw3sWoXevnSSW/NPbk
         roqPMqWHVk0aQ==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a348facbbso187987466b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 02:33:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303185; x=1688895185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErpWfnSHCAR2b37e5NamwpmTb1AxMZzXeuUaWWgL6I4=;
        b=F0NfQO9Rgkj9cH1zAmumau0mvMelwo9mxvtHpPDAcaG7PPu5wQJudiZKLBB0rWThoM
         WDXe8x+a8yFgpZqKPekGGCje1jMkI645646Fy/ydnX3Es5HN1jR0CsEn0TnXO1dyVZa4
         LuLwoRtFT56UmDRJ3CItN8/xiFJtI0JgLS8lwIeuo23mKFKxFY0uzxQqA3PhwFr+B7uR
         zT+7dSrn4ttvM0BrW836DvZ0Bg2B4xbZVE1UU9DNz0pOf7qFYG/CmpwvqLtcN1sWYT9W
         JM8BPH3xsaBGwHrHXe0/OpKelq3AIAKKx7/NzRtYk7Fvms/UH520/H5sR46mV3xMV6UZ
         ZbpQ==
X-Gm-Message-State: AC+VfDxMYSw4pbKIeRXWAFyRJ4h9Yf3cg7or641gfDT+KJ0Zyv8e5x9i
        CwGreR37/rY6A7ZPuOFEBmYC+WRmzGxmf2+qymzV5Gw7gsTdSdlovEHrxHERVPKYAEv9d02d/D4
        A/L1aef1sHPyLwtsco1cmwT6B8LLS9J08KdyKz3DIPTM=
X-Received: by 2002:a17:907:320e:b0:966:53b1:b32a with SMTP id xg14-20020a170907320e00b0096653b1b32amr1404163ejb.53.1686303185198;
        Fri, 09 Jun 2023 02:33:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4BnVyK6mbmtzUJ+7grSTxADhjOPPojcQ0QDq/KdSEQIMmUKH1e7Jp4s+uJLDjcJCeRYCYC5A==
X-Received: by 2002:a17:907:320e:b0:966:53b1:b32a with SMTP id xg14-20020a170907320e00b0096653b1b32amr1404149ejb.53.1686303185014;
        Fri, 09 Jun 2023 02:33:05 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:33:04 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/15] ceph: pass idmap to __ceph_setxattr
Date:   Fri,  9 Jun 2023 11:31:23 +0200
Message-Id: <20230609093125.252186-13-aleksandr.mikhalitsyn@canonical.com>
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

Just pass down the mount's idmapping to __ceph_setxattr.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: brauner@kernel.org
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c   |  2 +-
 fs/ceph/super.h |  3 ++-
 fs/ceph/xattr.c | 12 +++++++-----
 3 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index d4be4c2d63c3..e34b4e859b82 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -145,7 +145,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out_free;
 	}
 
-	ret = __ceph_setxattr(inode, name, value, size, 0);
+	ret = __ceph_setxattr(idmap, inode, name, value, size, 0);
 	if (ret) {
 		if (new_mode != old_mode) {
 			newattrs.ia_ctime = old_ctime;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 57cbb69a17c8..05dbae76087c 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1116,7 +1116,8 @@ static inline bool ceph_inode_is_shutdown(struct inode *inode)
 }
 
 /* xattr.c */
-int __ceph_setxattr(struct inode *, const char *, const void *, size_t, int);
+int __ceph_setxattr(struct mnt_idmap *, struct inode *,
+		    const char *, const void *, size_t, int);
 int ceph_do_getvxattr(struct inode *inode, const char *name, void *value, size_t size);
 ssize_t __ceph_getxattr(struct inode *, const char *, void *, size_t);
 extern ssize_t ceph_listxattr(struct dentry *, char *, size_t);
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index d11295e0a115..663267bbee3c 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -1090,7 +1090,8 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 	return err;
 }
 
-static int ceph_sync_setxattr(struct inode *inode, const char *name,
+static int ceph_sync_setxattr(struct mnt_idmap *idmap,
+			      struct inode *inode, const char *name,
 			      const char *value, size_t size, int flags)
 {
 	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
@@ -1144,6 +1145,7 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 
 	req->r_inode = inode;
 	ihold(inode);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_num_caps = 1;
 	req->r_inode_drop = CEPH_CAP_XATTR_SHARED;
 
@@ -1158,8 +1160,8 @@ static int ceph_sync_setxattr(struct inode *inode, const char *name,
 	return err;
 }
 
-int __ceph_setxattr(struct inode *inode, const char *name,
-			const void *value, size_t size, int flags)
+int __ceph_setxattr(struct mnt_idmap *idmap, struct inode *inode,
+		    const char *name, const void *value, size_t size, int flags)
 {
 	struct ceph_vxattr *vxattr;
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -1288,7 +1290,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 				    "during filling trace\n", inode);
 		err = -EBUSY;
 	} else {
-		err = ceph_sync_setxattr(inode, name, value, size, flags);
+		err = ceph_sync_setxattr(idmap, inode, name, value, size, flags);
 		if (err >= 0 && check_realm) {
 			/* check if snaprealm was created for quota inode */
 			spin_lock(&ci->i_ceph_lock);
@@ -1324,7 +1326,7 @@ static int ceph_set_xattr_handler(const struct xattr_handler *handler,
 {
 	if (!ceph_is_valid_xattr(name))
 		return -EOPNOTSUPP;
-	return __ceph_setxattr(inode, name, value, size, flags);
+	return __ceph_setxattr(idmap, inode, name, value, size, flags);
 }
 
 static const struct xattr_handler ceph_other_xattr_handler = {
-- 
2.34.1

