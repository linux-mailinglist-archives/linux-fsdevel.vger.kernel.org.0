Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5F3B183A74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 21:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCLUNR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 16:13:17 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:43183 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726803AbgCLUNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:13:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 64A77501;
        Thu, 12 Mar 2020 16:03:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 12 Mar 2020 16:03:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=lc0QBU1yCIerk
        rnOWmO0QlaRB2GRt3K2i1+d3aZJ1TU=; b=rDGyrd1qXQhmJNxyGEJTIKdXNpvk2
        6HawOHFoz8yCMXOKKZ/VIV5qcRV+7qC3tpjzEp2yC4IT4wkf1BdOKG84aj0b7+DM
        vKrQlXX+LaWRowVMS9SLI7bavbOP8FTu9390Fsp83Y7ZD5kM0BcOIy2H3Q16AIU2
        DaGLWo9FeLnXhPnknu6xO9XFKjwSsX5Lj/rJWzxhSMmQ0jA68tDpb8n/g88wMTYB
        M4+cVBSNX0OSnKW5+zJlEObnIPjzBIn2RTG1sNXem6IDTysTIDu8oFtNbhx6m0Xb
        SZKkW5vqx8HhTb+gDY9wtbAdZJPOHWQYmY6LSnGdskDg1J3TxpAvjJMgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=lc0QBU1yCIerkrnOWmO0QlaRB2GRt3K2i1+d3aZJ1TU=; b=iFzwbcct
        UCOxSBqTN8CK+6W9LnsaokHTueIJo8EnO8cpKrME2fheloysFXc1SzGYzT3BJU/I
        pJ6d9hH6XOTQp8Jga7CcbczS7ZKYZIhGLtGZV5BzX9jtQc251JjS3s//z/7DAf4x
        vadUU3qwt+vH3o+zCADdq6GDixb7K7TzGe7k4B1gUU+intq/ari8Gd2xDECuT284
        0fif09ZiDVBJ24SZr7We2nl6OhinwhRZ1gYySeyn9nnrN9+Hm7N3cKfzz0dxstys
        ismVDWeGYPEd9mwkEqmHaNe36Pad/CWeyxAs+p+LSdlI6fB5TfRrNbyJY4kDXpYz
        2EUzruzapS9QUg==
X-ME-Sender: <xms:m5VqXlptA_Bfjcd6l-Lyz7ymcsY5AiTFSMn6C1Sa7LxAuGW1fn2zDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrdegnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:m5VqXr5g0cEhGbTJrjo-H5rcADB72EgNEDcu0Ur7HiIfFXpnYZjEwg>
    <xmx:m5VqXtPR41eoSdH9-jjkEzj-XHmbptn9BmOyH5HhZZZxW9FzxaEZ4A>
    <xmx:m5VqXlPyBpK8hSsUafhwec63mKvlOsec0jXY3RJYu5aiCeyYWyegpg>
    <xmx:nJVqXi0xLsEXbDvHVAfedPkY8FiosI1egFfbtYvLsOsODXMDxfC5Dy9aqeA>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9AAA53061363;
        Thu, 12 Mar 2020 16:03:38 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, viro@zeniv.linux.org.uk
Cc:     Daniel Xu <dxu@dxuuu.xyz>, shakeelb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Subject: [PATCH v3 2/4] kernfs: Add removed_size out param for simple_xattr_set
Date:   Thu, 12 Mar 2020 13:03:15 -0700
Message-Id: <20200312200317.31736-3-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200312200317.31736-1-dxu@dxuuu.xyz>
References: <20200312200317.31736-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helps set up size accounting in the next commit. Without this out
param, it's difficult to find out the removed xattr size without taking
a lock for longer and walking the xattr linked list twice.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/kernfs/inode.c     |  2 +-
 fs/xattr.c            | 11 ++++++++++-
 include/linux/xattr.h |  3 ++-
 mm/shmem.c            |  2 +-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index d0f7a5abd9a9..5f10ae95fbfa 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -303,7 +303,7 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 	if (!attrs)
 		return -ENOMEM;
 
-	return simple_xattr_set(&attrs->xattrs, name, value, size, flags);
+	return simple_xattr_set(&attrs->xattrs, name, value, size, flags, NULL);
 }
 
 static int kernfs_vfs_xattr_get(const struct xattr_handler *handler,
diff --git a/fs/xattr.c b/fs/xattr.c
index 0d3c9b4d1914..e13265e65871 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -860,6 +860,7 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
  * @value: value of the xattr. If %NULL, will remove the attribute.
  * @size: size of the new xattr
  * @flags: %XATTR_{CREATE|REPLACE}
+ * @removed_size: returns size of the removed xattr, -1 if none removed
  *
  * %XATTR_CREATE is set, the xattr shouldn't exist already; otherwise fails
  * with -EEXIST.  If %XATTR_REPLACE is set, the xattr should exist;
@@ -868,7 +869,8 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
  * Returns 0 on success, -errno on failure.
  */
 int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
-		     const void *value, size_t size, int flags)
+		     const void *value, size_t size, int flags,
+		     ssize_t *removed_size)
 {
 	struct simple_xattr *xattr;
 	struct simple_xattr *new_xattr = NULL;
@@ -895,8 +897,12 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 				err = -EEXIST;
 			} else if (new_xattr) {
 				list_replace(&xattr->list, &new_xattr->list);
+				if (removed_size)
+					*removed_size = xattr->size;
 			} else {
 				list_del(&xattr->list);
+				if (removed_size)
+					*removed_size = xattr->size;
 			}
 			goto out;
 		}
@@ -908,6 +914,9 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 		list_add(&new_xattr->list, &xattrs->head);
 		xattr = NULL;
 	}
+
+	if (removed_size)
+		*removed_size = -1;
 out:
 	spin_unlock(&xattrs->lock);
 	if (xattr) {
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 6dad031be3c2..4cf6e11f4a3c 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -102,7 +102,8 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
 int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 		     void *buffer, size_t size);
 int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
-		     const void *value, size_t size, int flags);
+		     const void *value, size_t size, int flags,
+		     ssize_t *removed_size);
 ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs, char *buffer,
 			  size_t size);
 void simple_xattr_list_add(struct simple_xattrs *xattrs,
diff --git a/mm/shmem.c b/mm/shmem.c
index aad3ba74b0e9..f47347cb30f6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3243,7 +3243,7 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 
 	name = xattr_full_name(handler, name);
-	return simple_xattr_set(&info->xattrs, name, value, size, flags);
+	return simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
 }
 
 static const struct xattr_handler shmem_security_xattr_handler = {
-- 
2.21.1

