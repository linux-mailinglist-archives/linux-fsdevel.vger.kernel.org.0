Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0145567B140
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 12:30:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjAYLaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 06:30:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235567AbjAYL3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:29:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE815244B8
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 03:29:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84E91B8191A
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 11:29:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF23AC4339E;
        Wed, 25 Jan 2023 11:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674646171;
        bh=QmlDYYqZSAYFuk5CdnnztAbIgxZQWYoaQiNLu8Gb/Cw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VMmPRh8dLQHlrGgl5NmgOossAydMoWghG6gKRs/u6/MuLwvbbcH6kqm3J1YIl8Hrw
         30kWRJ7EwgoEk1aKCliIp3WgVzV9pxMdjGmxCtvtAt1TLCjaHsYT5aRvVU7xvLdVoZ
         7j2bWNWcTsmjinTXEU1p1TCsrAjakLCHTp409jZOiBTq30caLsmH6lwtTDfZZVbXh7
         hh1wok8mZUI+HDNUTXVcqBCd5w7RbQl1Sm5yP8Zjj4P3TbqY6ZHkSbHaqlIDkVnr1d
         17AbwMEpGrUxBWTd+LWVM6QZwJt69d2TKdV6Cd+I7Q+eZOS4GT5K9QpgxGtld+L+dK
         vLUDc/xpXbUEQ==
From:   Christian Brauner <brauner@kernel.org>
Date:   Wed, 25 Jan 2023 12:28:48 +0100
Subject: [PATCH 03/12] xattr: remove unused argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230125-fs-acl-remove-generic-xattr-handlers-v1-3-6cf155b492b6@kernel.org>
References: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
In-Reply-To: <20230125-fs-acl-remove-generic-xattr-handlers-v1-0-6cf155b492b6@kernel.org>
To:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Seth Forshee <sforshee@kernel.org>,
        "Christian Brauner (Microsoft)" <brauner@kernel.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QmlDYYqZSAYFuk5CdnnztAbIgxZQWYoaQiNLu8Gb/Cw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRfFJrI27JzX/lU/nfn5/L8P7yC2895FvchjoLvN/0d7Pf3
 aqpWdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkpx0jQ9crzcV+U803bLjx+5jQRu
 55T47Hrln2/mLH3IsPVwRGGD9j+GfP+MzFPtOyo70/7/+J/w/FGvPXXPNg41+r/KbePLopjxkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

his helpers is really just used to check for user.* xattr support so
don't make it pointlessly generic.

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/nfsd/nfs4xdr.c     |  3 +--
 fs/xattr.c            | 10 ++++------
 include/linux/xattr.h |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2b4ae858c89b..d78a73c732a3 100644
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
index ed7fcaab8e1a..b79f202c5857 100644
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
index d1150b7ba8d0..391ade703782 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -84,7 +84,7 @@ int vfs_getxattr_alloc(struct user_namespace *mnt_userns,
 		       struct dentry *dentry, const char *name,
 		       char **xattr_value, size_t size, gfp_t flags);
 
-int xattr_supported_namespace(struct inode *inode, const char *prefix);
+int xattr_supports_user_prefix(struct inode *inode);
 
 static inline const char *xattr_prefix(const struct xattr_handler *handler)
 {

-- 
2.34.1

