Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A01686692
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Feb 2023 14:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjBANQL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Feb 2023 08:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjBANPr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Feb 2023 08:15:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAD664DB8
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 05:15:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBBD0B82047
        for <linux-fsdevel@vger.kernel.org>; Wed,  1 Feb 2023 13:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5BCC433EF;
        Wed,  1 Feb 2023 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675257338;
        bh=YAU1nHEYb2ZBbEUkEM2VAZp/qw82pqdUx0wedzzg3Mk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=d+ypK0rzexFJZV8l5hN2jCdzmyWs+jdXAcV233t3okQlM88V1H8IUk/KotYd/KJR/
         ykHmWLq6HuplAbiJaMhB52OQjkOdThh5LbdWi4CTJjP953nj0XYWlTqGol8ve/tq++
         Eguc6baUSO6zaMAK9sFO4H2A1hfFHzuKp8urjFQE3SLqjYVCf9Pu7Xj/opGRjTIszG
         fsTQkfXyLVSP0sOTsxYC7OfPYdLirx6TZAaMUC9lHwokWsz3E9vH+XuuJb2fd/RrQW
         bSUtnX2CyqQcCsMcS/cHWK6JQSh2Cq6ckJ1DwTTPI+gq8tSOC7hVQ+Z70HHZHmg8wA
         g2nIHfhRKzUHA==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 01 Feb 2023 14:14:54 +0100
Subject: [PATCH v3 03/10] xattr: remove unused argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v3-3-f760cc58967d@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v3-0-f760cc58967d@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2716; i=brauner@kernel.org;
 h=from:subject:message-id; bh=YAU1nHEYb2ZBbEUkEM2VAZp/qw82pqdUx0wedzzg3Mk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTfSv3Y/KLP8KK39YV3y9Pt1kq6CgQuOVvXv9f+1gz9JX9W
 +Jl0dpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk8QfD/zr5k7+2Ls0wW8Wg/OJ49P
 lTzwU9Be2fZSxjOnbO7sdnxyRGhu8x+XO2Wy4yyHmXkpyfeO5rh92Jj9OsJ3+eW+pb97dPgxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

his helpers is really just used to check for user.* xattr support so
don't make it pointlessly generic.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
Changes in v3:
  - Patch unchanged.

Changes in v2:
- Patch unchanged.
---
 fs/nfsd/nfs4xdr.c     |  3 +--
 fs/xattr.c            | 10 ++++------
 include/linux/xattr.h |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 97edb32be77f..79814cfe8bcf 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3442,8 +3442,7 @@ nfsd4_encode_fattr(struct xdr_stream *xdr, struct svc_fh *fhp,
 		p = xdr_reserve_space(xdr, 4);
 		if (!p)
 			goto out_resource;
-		err = xattr_supported_namespace(d_inode(dentry),
-						XATTR_USER_PREFIX);
+		err = xattr_supports_user_prefix(d_inode(dentry));
 		*p++ = cpu_to_be32(err == 0);
 	}
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 20a562d431fe..8743402a5e8b 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -159,11 +159,10 @@ xattr_permission(struct user_namespace *mnt_userns, struct inode *inode,
  * Look for any handler that deals with the specified namespace.
  */
 int
-xattr_supported_namespace(struct inode *inode, const char *prefix)
+xattr_supports_user_prefix(struct inode *inode)
 {
 	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
 	const struct xattr_handler *handler;
-	size_t preflen;
 
 	if (!(inode->i_opflags & IOP_XATTR)) {
 		if (unlikely(is_bad_inode(inode)))
@@ -171,16 +170,15 @@ xattr_supported_namespace(struct inode *inode, const char *prefix)
 		return -EOPNOTSUPP;
 	}
 
-	preflen = strlen(prefix);
-
 	for_each_xattr_handler(handlers, handler) {
-		if (!strncmp(xattr_prefix(handler), prefix, preflen))
+		if (!strncmp(xattr_prefix(handler), XATTR_USER_PREFIX,
+			     XATTR_USER_PREFIX_LEN))
 			return 0;
 	}
 
 	return -EOPNOTSUPP;
 }
-EXPORT_SYMBOL(xattr_supported_namespace);
+EXPORT_SYMBOL(xattr_supports_user_prefix);
 
 int
 __vfs_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 39c496510a26..e24f052e8dcd 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -94,7 +94,7 @@ int vfs_getxattr_alloc(struct user_namespace *mnt_userns,
 		       struct dentry *dentry, const char *name,
 		       char **xattr_value, size_t size, gfp_t flags);
 
-int xattr_supported_namespace(struct inode *inode, const char *prefix);
+int xattr_supports_user_prefix(struct inode *inode);
 
 static inline const char *xattr_prefix(const struct xattr_handler *handler)
 {

-- 
2.34.1

