Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513407295A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Jun 2023 11:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbjFIJlB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Jun 2023 05:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbjFIJkf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Jun 2023 05:40:35 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BD04C02
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 02:35:41 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D354C3F4B3
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Jun 2023 09:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686303174;
        bh=ZRthp9gk8MduiBj9HJPfpfWTS97IoCeG1QDk4jIY0GY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=iRVqD/MswAmS62UA8AG4OfYj3Qd+oUFNwUC7Rb2uJApmkT31uI9DKKigVsbkgHXmL
         FGcUy4axnJ2OqxsB7nr1nLsjAuekmzkk3ip95McROO7xx6aFa0/Q1Riu1S/khUUlkz
         sjdlnFXJ9YmnE3viXczQYfM8CRi6bH1vn0rQgD0fFYAlEKOtCcBLkzWJtu2jX0twT4
         pREo7hS84yCjSJrvRDsQtO0anTTMh5Ybu8zwKi8siRZfAd4RZ7XWCJZpb6DVF3RUpz
         R/wld+rVqFWkm2JlA7SLqMjMevRGjJXbuUEfH/O4oQBU2Rmn65pWZJdyNJe/AaYnH8
         Tnz0YedP7eeQw==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-97463348446so187479166b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Jun 2023 02:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686303169; x=1688895169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRthp9gk8MduiBj9HJPfpfWTS97IoCeG1QDk4jIY0GY=;
        b=G11nHpIyG+0RywBv3mNEk/wfCaE0LTTVOJJ2XtglWvEwmE1am7FXNNfAgCS9x585uS
         BPrF9VawU+Q0uvJB15ND4qxoey/mhYv9tIlV7GdCRwoqOmVk+oUV0JwQFv5vCQJMqPDj
         eLm8RuWICu35qN8+XgdCCKh14/Xcm86wJLHLtfR4PdD7bCar2UPR40hRIHDS8n0kjj1J
         uLec7GTwAEez2q4FzHzIM/qKczJPkka2neEjfr0hNA1VLngG57xN0uMNdfB31MrvFlJg
         A9TLxFjixhq5bQQqf72vXGbR2tfUbMJy0+KGtk8ci+u2OT95FgE0qVCZZrBbghro6oxU
         VyaA==
X-Gm-Message-State: AC+VfDz53vyhplsCOk4cm+OluL8218N6OWgjr0rBRycLz8PVxv1Vg75F
        99YGvdntTs3kGbYnHJOmgc3sg1666gRTDS3QCQQG9FNCJbZuN0i9WLejkMRtIjQTmL7ZRSKd6x8
        RoyuGgvHCnFDlPjFy5dS1r02CrqhgKPkua0QqJREJLSw=
X-Received: by 2002:a17:907:1c90:b0:974:ae01:3af4 with SMTP id nb16-20020a1709071c9000b00974ae013af4mr1458850ejc.68.1686303169217;
        Fri, 09 Jun 2023 02:32:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5xI/FJy6um65fKv9ua9Yvf6NnhnhnqnjMGghe1gn0Q2nUmrZmyXP+uaPPgjZNrTtgBdvemIg==
X-Received: by 2002:a17:907:1c90:b0:974:ae01:3af4 with SMTP id nb16-20020a1709071c9000b00974ae013af4mr1458836ejc.68.1686303169020;
        Fri, 09 Jun 2023 02:32:49 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id e25-20020a170906081900b0094ee3e4c934sm1031248ejd.221.2023.06.09.02.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 02:32:48 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 07/15] ceph: pass idmap to __ceph_setattr
Date:   Fri,  9 Jun 2023 11:31:18 +0200
Message-Id: <20230609093125.252186-8-aleksandr.mikhalitsyn@canonical.com>
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
 fs/ceph/inode.c  | 6 ++++--
 fs/ceph/super.h  | 3 ++-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 8a56f979c7cb..f53f7a758c05 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -140,7 +140,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		newattrs.ia_ctime = current_time(inode);
 		newattrs.ia_mode = new_mode;
 		newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-		ret = __ceph_setattr(inode, &newattrs, NULL);
+		ret = __ceph_setattr(idmap, inode, &newattrs, NULL);
 		if (ret)
 			goto out_free;
 	}
@@ -151,7 +151,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			newattrs.ia_ctime = old_ctime;
 			newattrs.ia_mode = old_mode;
 			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-			__ceph_setattr(inode, &newattrs, NULL);
+			__ceph_setattr(idmap, inode, &newattrs, NULL);
 		}
 		goto out_free;
 	}
diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index e72bab29d5e1..8e298d7bf570 100644
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
index f45d9c066523..9a4579da32f8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2424,7 +2424,8 @@ static int fill_fscrypt_truncate(struct inode *inode,
 	return ret;
 }
 
-int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *cia)
+int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
+		   struct iattr *attr, struct ceph_iattr *cia)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	unsigned int ia_valid = attr->ia_valid;
@@ -2695,6 +2696,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr, struct ceph_iattr *c
 	if (mask) {
 		req->r_inode = inode;
 		ihold(inode);
+		req->r_mnt_idmap = mnt_idmap_get(idmap);
 		req->r_inode_drop = release;
 		req->r_args.setattr.mask = cpu_to_le32(mask);
 		req->r_num_caps = 1;
@@ -2766,7 +2768,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
 		return -EDQUOT;
 
-	err = __ceph_setattr(inode, attr, NULL);
+	err = __ceph_setattr(idmap, inode, attr, NULL);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
 		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 107a9d16a4e8..8516ac571da9 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1095,7 +1095,8 @@ struct ceph_iattr {
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

