Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1379E1FC793
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 09:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgFQHiO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 03:38:14 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:33941 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726804AbgFQHiN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:38:13 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id E83FC478;
        Wed, 17 Jun 2020 03:38:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Jun 2020 03:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        U0hpE2t4Jb5LiAicyzV44p0oKfUxQp3342ldxD2V7j8=; b=AHZvD4oMx3a+1tZg
        NoNMRNSKlQrDTRN65fMY52gYUV/GR435OUwKa89btZespVl4A2nd/Z/FfXHdpX6Z
        T+OuxZoxYTWiCnM+wVfDAX/nvRFX61vCrIfIFH6GePQmqg5myKzCXeaxX8E9LxPY
        nDXWPQT0Wmqm9Q0nnNXgvilD2ZJKY/TLnROeHl3cr0k3f4OQ3nHyfCsK1Y0DxLAa
        2quwgI2bTX7jA0jcqcBmA4PDLroehgGR14Gcj5SVlyV2xygbun/Q5IJDXCjnzmyS
        1vUeuX4lSVjgtHMkC25ylT4P1acmC/ZXGAoEtHe3U26SC5ADfYV1VniMEG6f/quN
        entGtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=U0hpE2t4Jb5LiAicyzV44p0oKfUxQp3342ldxD2V7
        j8=; b=Pj5ug67ulDJK+utTDVWd5yo7ai80EN2g7Sk3p9h6ejclxbTg+PsPWrw8d
        v30Mc22VJ3preasooPo0jZqQlMYbdHMF/m9Ma1SEGQaFphYoOyqcZDAdky3Oin5U
        DKnQBNyGLCzI5DZ06LjOlg4IYq3PdGyxwO4o3mI2u81/ZcfusO2ObOMAF2abjCTe
        TVmsLG8E51gsSyAokSt2R5KiNysgj4dA4+NiylJp8JtW0FxcaIfzBiiZwDBsBV4f
        wqVtbblxoUdEvhn10aTrIagcIrrTJ40/gdROrMe2YJ2hNQiFULyG3aNgGkBtzrCv
        vhuAy6foC+XboRdd21ZqZ+MGrk8BQ==
X-ME-Sender: <xms:Y8jpXhgeYGSv3Ee0m1-5Psf429ksBWEwaJ3AmMVuwC94sySSeEqfDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuhffvfffkjghffgggtgfgsehtjedttddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epvddvvdfgleefhfelgfekvdejjefhvdetfeevueeggeefhfdujeegveejveejgfdunecu
    kfhppeehkedrjedrudelgedrkeejnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:Y8jpXmB8DO7VD1EisVt8R9QEXCrJnVoDr6QTQYbR-Z-PL8P3Al-Xlg>
    <xmx:Y8jpXhGN73IV9m33z-WQIdVMyuDSs6oxvaWWgGqxsqPRpLk9bKwgNw>
    <xmx:Y8jpXmTCSzd9C5MClizP8lWuFYNfBGUF8PSLtY4IioPQXkdmXfHZhQ>
    <xmx:Y8jpXlrm6II5unf80aogDl7e0-OlaOjxdlk4VBs5ItEDpirvrNQJZA>
Received: from mickey.themaw.net (58-7-194-87.dyn.iinet.net.au [58.7.194.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1736B306215A;
        Wed, 17 Jun 2020 03:38:11 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.themaw.net (Postfix) with ESMTP id 86338A0314;
        Wed, 17 Jun 2020 15:38:08 +0800 (AWST)
Subject: [PATCH v2 5/6] kernfs: refactor attr locking
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
Date:   Wed, 17 Jun 2020 15:38:08 +0800
Message-ID: <159237948850.89469.14590162329652845934.stgit@mickey.themaw.net>
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

The inode operations .permission() and .getattr() use the kernfs node
write lock but all that's needed is to keep the rb tree stable while
copying the node attributes. And .permission() is called frequently
during path walks so it can cause quite a bit of contention between
kernfs node opertations and path walks when the number of concurrant
walks is high.

Ideally the inode mutex would protect the inode update but .permission()
may be called both with and without holding the inode mutex so there's no
way for kernfs .permission() to know if it is the holder of the mutex
which means it could be released during the update.

So refactor __kernfs_iattrs() by moving the static mutex declaration out
of the function and changing the function itself a little. And also use
the mutex to protect the inode attribute fields updated by .permission()
and .getattr() calls to kernfs_refresh_inode().

Using the attr mutex to protect two different things, the node
attributes as well as the copy of them to the inode is not ideal. But
the only other choice is to use two locks which seems like excessive
ovherhead when the attr mutex is so closely related to the inode fields
it's protecting.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/inode.c |   50 ++++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 23a7996d06a9..5c3fac356ce0 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -17,6 +17,8 @@
 
 #include "kernfs-internal.h"
 
+static DEFINE_MUTEX(attr_mutex);
+
 static const struct address_space_operations kernfs_aops = {
 	.readpage	= simple_readpage,
 	.write_begin	= simple_write_begin,
@@ -32,33 +34,33 @@ static const struct inode_operations kernfs_iops = {
 
 static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, int alloc)
 {
-	static DEFINE_MUTEX(iattr_mutex);
-	struct kernfs_iattrs *ret;
-
-	mutex_lock(&iattr_mutex);
+	struct kernfs_iattrs *iattr = NULL;
 
-	if (kn->iattr || !alloc)
+	mutex_lock(&attr_mutex);
+	if (kn->iattr || !alloc) {
+		iattr = kn->iattr;
 		goto out_unlock;
+	}
 
-	kn->iattr = kmem_cache_zalloc(kernfs_iattrs_cache, GFP_KERNEL);
-	if (!kn->iattr)
+	iattr = kmem_cache_zalloc(kernfs_iattrs_cache, GFP_KERNEL);
+	if (!iattr)
 		goto out_unlock;
 
 	/* assign default attributes */
-	kn->iattr->ia_uid = GLOBAL_ROOT_UID;
-	kn->iattr->ia_gid = GLOBAL_ROOT_GID;
+	iattr->ia_uid = GLOBAL_ROOT_UID;
+	iattr->ia_gid = GLOBAL_ROOT_GID;
 
-	ktime_get_real_ts64(&kn->iattr->ia_atime);
-	kn->iattr->ia_mtime = kn->iattr->ia_atime;
-	kn->iattr->ia_ctime = kn->iattr->ia_atime;
+	ktime_get_real_ts64(&iattr->ia_atime);
+	iattr->ia_mtime = iattr->ia_atime;
+	iattr->ia_ctime = iattr->ia_atime;
 
-	simple_xattrs_init(&kn->iattr->xattrs);
-	atomic_set(&kn->iattr->nr_user_xattrs, 0);
-	atomic_set(&kn->iattr->user_xattr_size, 0);
+	simple_xattrs_init(&iattr->xattrs);
+	atomic_set(&iattr->nr_user_xattrs, 0);
+	atomic_set(&iattr->user_xattr_size, 0);
+	kn->iattr = iattr;
 out_unlock:
-	ret = kn->iattr;
-	mutex_unlock(&iattr_mutex);
-	return ret;
+	mutex_unlock(&attr_mutex);
+	return iattr;
 }
 
 static struct kernfs_iattrs *kernfs_iattrs(struct kernfs_node *kn)
@@ -189,9 +191,11 @@ int kernfs_iop_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = d_inode(path->dentry);
 	struct kernfs_node *kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
+	mutex_lock(&attr_mutex);
 	kernfs_refresh_inode(kn, inode);
-	up_writeread(&kernfs_rwsem);
+	mutex_unlock(&attr_mutex);
+	up_read(&kernfs_rwsem);
 
 	generic_fillattr(inode, stat);
 	return 0;
@@ -281,9 +285,11 @@ int kernfs_iop_permission(struct inode *inode, int mask)
 
 	kn = inode->i_private;
 
-	down_write(&kernfs_rwsem);
+	down_read(&kernfs_rwsem);
+	mutex_lock(&attr_mutex);
 	kernfs_refresh_inode(kn, inode);
-	up_write(&kernfs_rwsem);
+	mutex_unlock(&attr_mutex);
+	up_read(&kernfs_rwsem);
 
 	return generic_permission(inode, mask);
 }


