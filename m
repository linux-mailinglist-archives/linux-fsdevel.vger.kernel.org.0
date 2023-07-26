Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCF2763878
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjGZOIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234459AbjGZOH7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:59 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F30530F9
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:20 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7E44E413BD
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380438;
        bh=nLZMqtT0BTuD0r3ld9T+VcVOIz8LP+RVDN6gyhT7tPs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Pnq/Katvc1gnKR+t6mx1XpPifBjdldj7wpxxXCf1tzaqu7L+Xz7KTrPHZiMuaMmtj
         pnj9B958nVe6L0lVWv9DUIcG7VfPxRrd1mPqc7IkQHCJ9ieHSGSQy7STAPtztn2C6D
         +IvRjdaujT5k1OcdnpsdxUaIp353wOtmzs97KdkLfoGkWRHrL2367eM+hgG5eq1MCA
         jIhAnyKVTSfda+6iHEIa2ArGuZ+z5MI7PDzaUowlStJi5vooQJ08VsvrMecoplPKJz
         K4mJqqrDdOgsos2GDi3h+IiUrJ87gBqy6fRSqL+1STAhj0DrF9PXIwCeB4i/GcoFPy
         NxcYRv0zxSOpg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99388334de6so484194466b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380436; x=1690985236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nLZMqtT0BTuD0r3ld9T+VcVOIz8LP+RVDN6gyhT7tPs=;
        b=QPrnnOnoond/FQL4vjA+bdDHd/wg3PaXbKPkALm8kXswFOyugvwMtKuKQRvaEhKOGu
         VK9w0IdZnadbDvWUTmQTLgCkeqOGEaMap6283a6Mm+y41sdIXxPmUY9yDZVqtMBK3hbl
         rwyFHSErTz9rKNFMgYwoTId5/EqWoi1i6fZx6o2WvJ4aaY0oiK25NRKNZxxPdLC9KOVT
         WxUe8/5iZCfyYwO0zwgryUmCPoC7Cyw5Q7IT3xQcQ0e8MyO2g3zWS8D5l1g3v4xdKiow
         f957iQRGBFbgxxNd5NV8uXZPy+e/vvWBr6jFlXxTfhVffVkl4spDdNs+jN5MS84PXZO/
         4VTg==
X-Gm-Message-State: ABy/qLZaUtslajP4467/cNK1SRafZdvQrPG3OIK5QZFX0AOBqST9+DAD
        cOxxXiZ92AQv7vf8L1yE1moiZkc1cigfFyOmHO3Dr7B9azZ5i/g4bXFru6uXyd9f9644JiUmnFJ
        C2zJAdeUKkzH0XWbSQEVod6wTReBQF6vJKzcko83AF87nMweL/Ns=
X-Received: by 2002:a17:906:101b:b0:99b:4378:a5ab with SMTP id 27-20020a170906101b00b0099b4378a5abmr1898874ejm.74.1690380436708;
        Wed, 26 Jul 2023 07:07:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHIDZJRHC5/8M2FDMYcx7lLcJbaGOmJ8PaUO8A3SDvcgsdM/EDYNykFDABz3ys6IJ2EnQ2ixg==
X-Received: by 2002:a17:906:101b:b0:99b:4378:a5ab with SMTP id 27-20020a170906101b00b0099b4378a5abmr1898861ejm.74.1690380436503;
        Wed, 26 Jul 2023 07:07:16 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:16 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 07/11] ceph: pass idmap to __ceph_setattr
Date:   Wed, 26 Jul 2023 16:06:45 +0200
Message-Id: <20230726140649.307158-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
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

Just pass down the mount's idmapping to __ceph_setattr,
because we will need it later.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: brauner@kernel.org
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/acl.c    | 4 ++--
 fs/ceph/crypto.c | 2 +-
 fs/ceph/inode.c  | 5 +++--
 fs/ceph/super.h  | 3 ++-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 32b26deb1741..89280c168acb 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -142,7 +142,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		newattrs.ia_ctime = current_time(inode);
 		newattrs.ia_mode = new_mode;
 		newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-		ret = __ceph_setattr(inode, &newattrs, NULL);
+		ret = __ceph_setattr(idmap, inode, &newattrs, NULL);
 		if (ret)
 			goto out_free;
 	}
@@ -153,7 +153,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			newattrs.ia_ctime = old_ctime;
 			newattrs.ia_mode = old_mode;
 			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-			__ceph_setattr(inode, &newattrs, NULL);
+			__ceph_setattr(idmap, inode, &newattrs, NULL);
 		}
 		goto out_free;
 	}
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index b9071bba3b08..8cf32e7f59bf 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -112,7 +112,7 @@ static int ceph_crypt_set_context(struct inode *inode, const void *ctx, size_t l
 
 	cia.fscrypt_auth = cfa;
 
-	ret = __ceph_setattr(inode, &attr, &cia);
+	ret = __ceph_setattr(&nop_mnt_idmap, inode, &attr, &cia);
 	if (ret == 0)
 		inode_set_flags(inode, S_ENCRYPTED, S_ENCRYPTED);
 	kfree(cia.fscrypt_auth);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 9b50861bd2b5..6c4cc009d819 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2466,7 +2466,8 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	return ret;
 }
 
-int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia)
+int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
+		   struct iattr *attr, struct ceph_iattr *cia)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	unsigned int ia_valid = attr->ia_valid;
@@ -2818,7 +2819,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
 		return -EDQUOT;
 
-	err = __ceph_setattr(inode, attr, NULL);
+	err = __ceph_setattr(idmap, inode, attr, NULL);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
 		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 4e78de1be23e..e729cde7b4a0 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1101,7 +1101,8 @@ struct ceph_iattr {
 	struct ceph_fscrypt_auth	*fscrypt_auth;
 };
 
-extern int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia);
+extern int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
+			  struct iattr *attr, struct ceph_iattr *cia);
 extern int ceph_setattr(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct iattr *attr);
 extern int ceph_getattr(struct mnt_idmap *idmap,
-- 
2.34.1

