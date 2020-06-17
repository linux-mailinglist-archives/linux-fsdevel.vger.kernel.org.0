Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9C11FC797
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgFQHiV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 03:38:21 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42595 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726542AbgFQHiS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:38:18 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id E49C94C5;
        Wed, 17 Jun 2020 03:38:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 Jun 2020 03:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        trUDM6J4xTL+EvlxC8X7RzYKusxzZbaupwPRTQgum+k=; b=O9uu4vFr57zyFqdT
        ku9gOfS4bETKmnlks7bHBs6kQyaFSZNTUmTxsUlid8DIQIqFw+NPeEj9qaPxUfiT
        y1Bn9ofqrChhfnC2pFLCnTbIkMYRC4rAYQ3+ATVzr9h2hFwGNitY0kiq1iVJ1Igs
        6nOF0TnoiYeZXaRV8VZSb4C0BoXyWMBBaNc2dr/+4gIBQcwskII5gmCxXEFcZvWI
        oYGzjYJbIXn0gWU7CT6zemyOOaEW9Vznj+ISUdfDrtDCA4EZ2qOgE+OjiikRAtQA
        DnR2g9l1Cf/0X6Y/wL/9kUOJW1M/yU/4vylGRTN08BwYaGJBFl/PrgKzlykXq1Oa
        wZIaDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=trUDM6J4xTL+EvlxC8X7RzYKusxzZbaupwPRTQgum
        +k=; b=Tei9xWnyMb36/BJ9CIKJSta419ZA02dxi9Hff7wXNiSj3/VyLGvDxMfFk
        F0Wrluwr+YyGkZXeDlsKoLGAj0w6kFHH9m0gVJLkwo1+N8WaUHsY51a3L31EzsMv
        4zHSfL+GvqbN5TOzDyxDCuh84bJnEAS9eqkM6Gr/Z2tnULvOXTuQ9jA8ylyKYHQG
        FO+lW9tLWwZupxzJTPPUoOs/HO9mW+uczUiUahTxQs+z5QeYmnLPTuz9SbHbO+DU
        FE6/xYYOlAFPQ/JX9Dxbok+gE7JCKmtZ2H6MziroLpdcFCGmLaZFHs95VQzJ9gFs
        UBbmblffbHgC30BU+M7x0xTGh143w==
X-ME-Sender: <xms:aMjpXlkTsLOmI160YiThV4Tey0lKnzbfUnkKZzQJTRn3oiHzskrQ7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuhffvfffkjghffgggtgfgsehtjedttddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epvddvvdfgleefhfelgfekvdejjefhvdetfeevueeggeefhfdujeegveejveejgfdunecu
    kfhppeehkedrjedrudelgedrkeejnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:aMjpXg1PXP9-JJ8KEc4yqRLLEf_4XjL45nEaxG5h9OvvY_b8ciNy6Q>
    <xmx:aMjpXrqur8YpFwVW-GzYu2lfh2KVi7O7ldGnkvC2Kg-C-aWJHq6TZg>
    <xmx:aMjpXlntIxSwGT97dnFA-rEnSgYuwO-t_Qj4X2ELC69FsV81S3fprg>
    <xmx:aMjpXj8vyGi8Pb1e1Hktx5u5xddScSPOY4Ezz9Nsl0-8BSDNjjppIQ>
Received: from mickey.themaw.net (58-7-194-87.dyn.iinet.net.au [58.7.194.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1837F328005E;
        Wed, 17 Jun 2020 03:38:16 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.themaw.net (Postfix) with ESMTP id 9413FA0314;
        Wed, 17 Jun 2020 15:38:13 +0800 (AWST)
Subject: [PATCH v2 6/6] kernfs: make attr_mutex a local kernfs node lock
From:   Ian Kent <raven@themaw.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 17 Jun 2020 15:38:13 +0800
Message-ID: <159237949356.89469.1012120560805135591.stgit@mickey.themaw.net>
In-Reply-To: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The global mutex attr_mutex is used to protect the update of inode
attributes in kernfs_refresh_inode() (as well as kernfs node attribute
structure creation) and this function is called by the inode operation
.permission().

Since .permission() is called quite frequently during path walks it
can lead to contention when the number of concurrent path walks is
high.

This mutex is used for kernfs node objects only so make it local to
the kernfs node to reduce the impact of this type of contention.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c        |    1 +
 fs/kernfs/inode.c      |   12 ++++++------
 include/linux/kernfs.h |    2 ++
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 03f4f179bbc4..3233e01651e4 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -597,6 +597,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	kn = kmem_cache_zalloc(kernfs_node_cache, GFP_KERNEL);
 	if (!kn)
 		goto err_out1;
+	mutex_init(&kn->attr_mutex);
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&kernfs_idr_lock);
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 5c3fac356ce0..5eb11094bb2e 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -36,7 +36,7 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
 {
 	struct kernfs_iattrs *iattr = NULL;
 
-	mutex_lock(&attr_mutex);
+	mutex_lock(&kn->attr_mutex);
 	if (kn->iattr || !alloc) {
 		iattr = kn->iattr;
 		goto out_unlock;
@@ -59,7 +59,7 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
 	atomic_set(&iattr->user_xattr_size, 0);
 	kn->iattr = iattr;
 out_unlock:
-	mutex_unlock(&attr_mutex);
+	mutex_unlock(&kn->attr_mutex);
 	return iattr;
 }
 
@@ -192,9 +192,9 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 	struct kernfs_node *kn = inode->i_private;
 
 	down_read(&kernfs_rwsem);
-	mutex_lock(&attr_mutex);
+	mutex_lock(&kn->attr_mutex);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&attr_mutex);
+	mutex_unlock(&kn->attr_mutex);
 	up_read(&kernfs_rwsem);
 
 	generic_fillattr(inode, stat);
@@ -286,9 +286,9 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 	kn = inode->i_private;
 
 	down_read(&kernfs_rwsem);
-	mutex_lock(&attr_mutex);
+	mutex_lock(&kn->attr_mutex);
 	kernfs_refresh_inode(kn, inode);
-	mutex_unlock(&attr_mutex);
+	mutex_unlock(&kn->attr_mutex);
 	up_read(&kernfs_rwsem);
 
 	return generic_permission(inode, mask);
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 74727d98e380..8669f65d5a39 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -142,6 +142,8 @@ struct kernfs_node {
 
 	struct rb_node		rb;
 
+	struct mutex		attr_mutex; /* protect attr updates */
+
 	const void		*ns;	/* namespace tag */
 	unsigned int		hash;	/* ns + name hash */
 	union {


