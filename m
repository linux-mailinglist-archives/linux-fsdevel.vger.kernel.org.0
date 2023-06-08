Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862187283F4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 17:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbjFHPoR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 11:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237146AbjFHPoK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:44:10 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964332D55
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 08:43:44 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 096FF3F36C
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686239020;
        bh=g/m6XNFvTOUfG03RZDOMzrTB4ATEHu4pMqVecpMcDjA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lGCs21RnqQylUYOglmXDQaJI8oXK6la5RWeC1YmzYAYGjY8BmCrrqqypDIKC5YMEq
         dx+GHm1kzb1LmBEM033y0RgSxBAb7bK/Q8zCjhUEh4lcqAZ94/ROXSgYdJhbU3V5uP
         Gq/LH62D/kx+KxPzBGcl7/7NqH69c3cgjhvaNzH/piJxWLTTzwjyVHnzzMei85L9Z6
         Ky9+DYD/TIpHr25F6shueM+YO8q/rJ/5hPI2JydMS5dqVHu/vuCXYh4P5SAAH40Lgz
         QZNuHHLuT3qGD0Sg1TLdXt1LsFbKTIW7RyPz3lSRJzoNLBXh+oqqdQyiqCIN8doV2n
         P9mib2qZQTrmA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-975942c2a29so81971266b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686239019; x=1688831019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/m6XNFvTOUfG03RZDOMzrTB4ATEHu4pMqVecpMcDjA=;
        b=d8cqyKNQf4zmMhKAOXjVMPQlZUvLfxQ7CSCr9KWUSRyA214wEV5JbrqrFCfWY+f13Y
         JIGJfDLMvFqiE8Kph9M5qTO4KjssdpUEYZnrvDfYAa9DZY7jwe9jR59oEpFiAMg/fFY/
         /dwF3ZYU7sX/qJp55Vgtco11uGtchpuXEqCXAgqJxIA+14VqSgBawrdc42c4lvVlfzFZ
         tGmj0oejvHXwUm1HUcvAKx39IWdtxDo9V5SThLM0rItj9uJ7JaGNlEghBij82eOHZgKS
         vma8H5AsmEh9AKu9dOvN9zrJwwy3usBK8NdftNrRgk5MMUajKpldv2d5sUy58EpA8fBX
         VwPw==
X-Gm-Message-State: AC+VfDx2dnOaORCjK7VdhB3fjlv3cGHUj4TRvaueQEfSREGMMm8XPxPE
        gSdDleeK0Mn5uXVNigVhSXpOAzqk2Jcq2/RDzM7JdHRjSVvY3fR/fg5NY1urwja+Z/dMY5S2NK7
        hd5huXgb3O+ZFG0Nyga+6U9Yuf5oj/V2N2QdN0pkgOU4=
X-Received: by 2002:a17:907:74b:b0:978:a964:106e with SMTP id xc11-20020a170907074b00b00978a964106emr142672ejb.17.1686239019654;
        Thu, 08 Jun 2023 08:43:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4pVQz3zv+TMo0+MaPPdtqVPMggAHC+bOqWfjMzKnxBsBC+2g434NLItKfhx6N5DzgjQsn0CQ==
X-Received: by 2002:a17:907:74b:b0:978:a964:106e with SMTP id xc11-20020a170907074b00b00978a964106emr142658ejb.17.1686239019513;
        Thu, 08 Jun 2023 08:43:39 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:39 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/14] ceph: pass idmap to __ceph_setattr
Date:   Thu,  8 Jun 2023 17:42:48 +0200
Message-Id: <20230608154256.562906-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
 fs/ceph/acl.c   | 4 ++--
 fs/ceph/inode.c | 6 ++++--
 fs/ceph/super.h | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index 6945a938d396..51ffef848429 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -140,7 +140,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 		newattrs.ia_ctime = current_time(inode);
 		newattrs.ia_mode = new_mode;
 		newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-		ret = __ceph_setattr(inode, &newattrs);
+		ret = __ceph_setattr(idmap, inode, &newattrs);
 		if (ret)
 			goto out_free;
 	}
@@ -151,7 +151,7 @@ int ceph_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			newattrs.ia_ctime = old_ctime;
 			newattrs.ia_mode = old_mode;
 			newattrs.ia_valid = ATTR_MODE | ATTR_CTIME;
-			__ceph_setattr(inode, &newattrs);
+			__ceph_setattr(idmap, inode, &newattrs);
 		}
 		goto out_free;
 	}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 37e1cbfc7c89..bface707c9bb 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2009,7 +2009,8 @@ static const struct inode_operations ceph_symlink_iops = {
 	.listxattr = ceph_listxattr,
 };
 
-int __ceph_setattr(struct inode *inode, struct iattr *attr)
+int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
+		   struct iattr *attr)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	unsigned int ia_valid = attr->ia_valid;
@@ -2206,6 +2207,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	if (mask) {
 		req->r_inode = inode;
 		ihold(inode);
+		req->r_mnt_idmap = mnt_idmap_get(idmap);
 		req->r_inode_drop = release;
 		req->r_args.setattr.mask = cpu_to_le32(mask);
 		req->r_num_caps = 1;
@@ -2252,7 +2254,7 @@ int ceph_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	    ceph_quota_is_max_bytes_exceeded(inode, attr->ia_size))
 		return -EDQUOT;
 
-	err = __ceph_setattr(inode, attr);
+	err = __ceph_setattr(idmap, inode, attr);
 
 	if (err >= 0 && (attr->ia_valid & ATTR_MODE))
 		err = posix_acl_chmod(&nop_mnt_idmap, dentry, attr->ia_mode);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index d24bf0db5234..d9cc27307cb7 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -1052,7 +1052,8 @@ static inline int ceph_do_getattr(struct inode *inode, int mask, bool force)
 }
 extern int ceph_permission(struct mnt_idmap *idmap,
 			   struct inode *inode, int mask);
-extern int __ceph_setattr(struct inode *inode, struct iattr *attr);
+extern int __ceph_setattr(struct mnt_idmap *idmap, struct inode *inode,
+			  struct iattr *attr);
 extern int ceph_setattr(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct iattr *attr);
 extern int ceph_getattr(struct mnt_idmap *idmap,
-- 
2.34.1

