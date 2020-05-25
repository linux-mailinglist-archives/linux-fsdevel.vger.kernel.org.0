Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F70A1E0685
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 07:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388605AbgEYFrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 01:47:20 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:48979 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388508AbgEYFrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 01:47:19 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 1E52EE95;
        Mon, 25 May 2020 01:47:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 May 2020 01:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        /rAbDMt6FC3fG09UnQPczhNktJ9DSAXatCwomfNKw7A=; b=1BcISEUsmembfiAk
        uJgmNsmda1TxNncHvG+2lhjU4sMPNRvgLIsVRdPjTxbuY8RclLxaosNVQYT5HoKx
        RbpC0aNf7gm+IPSYhLYbZ97v72jwrrDtdteiIDA/7Nuj7gJrBL63M5OZxVfMNTqj
        JVNLhNq87RiX6fVyEXO7Bt/7bnl85QFY3qF6bbkC1EqjbRwijvbEHlaWoj6hm2jP
        ozSIJ/ZxabQYbMTBPf+tFqqB4OlLYxFnKoA8sJ2bZlDYQglOSVZVs5dA4ZsQZn+L
        ti3BJYA1lOkhbrDCaGQh0/BpyslDxkso0CqF8upJ3KU0Ld9nZ6YYDyXJwLKNO0MG
        6KvHnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=/rAbDMt6FC3fG09UnQPczhNktJ9DSAXatCwomfNKw
        7A=; b=JT3Vn6slGzHi27Xyf+LDuLF1anCpHRaUHJlicO7s6YOiIgy8wVnHkE9+P
        DNq+cliTGWoQxjlm7OohBuegvWAcVgrtnmMqCbvlku94BnOLYpQboeX+cxkPE0XT
        HcAdhqHNjxPxn7x9zSbS9hIKpARF8KtrrrQwM8Qy3+M+Aq+2Q/MI8X6RR0tdMyoO
        /aZdahWrv/xKO9g8/6ADK2J5EHmPGG7DtRaFG7XjwNWZjdmWo3dwSHD7eAu1rGnX
        l04FjBYPrqpI5IsDQPfobcsKi1zC7RUw1m1pBGvZZEZgocN8pnOkpYtECE2nreq1
        129XErrk9v8VZE/z0uzVOHdREH0Ig==
X-ME-Sender: <xms:5VvLXjXfJkgl8It31ihxyiFCBA7gCaNjVOXnRlAWTHb5moquEawrLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffhvfffkfgjfhgfgggtgfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    egveeuudffieeiffefieehvdetieeiteelheetueekledtledugeffheffieduieenucfk
    phepuddukedrvddtkedrudejkedrudeknecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:5VvLXrnD6KdFFdmQedKQPqdy8_1ZSn9WLdMV2f_9pHP4twsHxBBpYQ>
    <xmx:5VvLXvbj33H5qNipKZ9uX4eWTrZs1vidw7M5mm2Nr8a_VDNGt5VzyQ>
    <xmx:5VvLXuV_zmJ3XqSZbd5TQOV37fN2mgiT6QmwoSn70vQm9CRjV2mVWw>
    <xmx:5VvLXgv8H708A-EuGS0uCkVtQcuRoRsuVab2pa4zI99ff7rSpdAUPg>
Received: from mickey.localdomain (unknown [118.208.178.18])
        by mail.messagingengine.com (Postfix) with ESMTPA id 435083280059;
        Mon, 25 May 2020 01:47:17 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.localdomain (Postfix) with ESMTP id BD48DA01C8;
        Mon, 25 May 2020 13:47:14 +0800 (AWST)
Subject: [PATCH 3/4] kernfs: improve kernfs path resolution
From:   Ian Kent <raven@themaw.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Rick Lindsley <ricklind@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 25 May 2020 13:47:14 +0800
Message-ID: <159038563473.276051.9549849659872866062.stgit@mickey.themaw.net>
In-Reply-To: <159038508228.276051.14042452586133971255.stgit@mickey.themaw.net>
References: <159038508228.276051.14042452586133971255.stgit@mickey.themaw.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that an rwsem is used by kernfs, take advantage of it to reduce
lookup overhead.

If there are many lookups (possibly many negative ones) there can
be a lot of overhead during path walks.

To reduce lookup overhead avoid allocating a new dentry where possible.

To do this stay in rcu-walk mode where possible and use the dentry cache
handling of negative hashed dentries to avoid allocating (and freeing
shortly after) new dentries on every negative lookup.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c |   87 ++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 15 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 9b315f3b20ee..f4943329e578 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1046,15 +1046,75 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct kernfs_node *kn;
 
-	if (flags & LOOKUP_RCU)
+	if (flags & LOOKUP_RCU) {
+		kn = kernfs_dentry_node(dentry);
+		if (!kn) {
+			/* Negative hashed dentry, tell the VFS to switch to
+			 * ref-walk mode and call us again so that node
+			 * existence can be checked.
+			 */
+			if (!d_unhashed(dentry))
+				return -ECHILD;
+
+			/* Negative unhashed dentry, this shouldn't happen
+			 * because this case occurs in rcu-walk mode after
+			 * dentry allocation which is followed by a call
+			 * to ->loopup(). But if it does happen the dentry
+			 * is surely invalid.
+			 */
+			return 0;
+		}
+
+		/* Since the dentry is positive (we got the kernfs node) a
+		 * kernfs node reference was held at the time. Now if the
+		 * dentry reference count is still greater than 0 it's still
+		 * positive so take a reference to the node to perform an
+		 * active check.
+		 */
+		if (d_count(dentry) <= 0 || !atomic_inc_not_zero(&kn->count))
+			return -ECHILD;
+
+		/* The kernfs node reference count was greater than 0, if
+		 * it's active continue in rcu-walk mode.
+		 */
+		if (kernfs_active_read(kn)) {
+			kernfs_put(kn);
+			return 1;
+		}
+
+		/* Otherwise, just tell the VFS to switch to ref-walk mode
+		 * and call us again so the kernfs node can be validated.
+		 */
+		kernfs_put(kn);
 		return -ECHILD;
+	}
 
-	/* Always perform fresh lookup for negatives */
-	if (d_really_is_negative(dentry))
-		goto out_bad_unlocked;
+	down_read(&kernfs_rwsem);
 
 	kn = kernfs_dentry_node(dentry);
-	down_read(&kernfs_rwsem);
+	if (!kn) {
+		struct kernfs_node *parent;
+
+		/* If the kernfs node can be found this is a stale negative
+		 * hashed dentry so it must be discarded and the lookup redone.
+		 */
+		parent = kernfs_dentry_node(dentry->d_parent);
+		if (parent) {
+			const void *ns = NULL;
+
+			if (kernfs_ns_enabled(parent))
+				ns = kernfs_info(dentry->d_parent->d_sb)->ns;
+			kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
+			if (kn)
+				goto out_bad;
+		}
+
+		/* The kernfs node doesn't exist, leave the dentry negative
+		 * and return success.
+		 */
+		goto out;
+	}
+
 
 	/* The kernfs node has been deactivated */
 	if (!kernfs_active_read(kn))
@@ -1072,12 +1132,11 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 	if (kn->parent && kernfs_ns_enabled(kn->parent) &&
 	    kernfs_info(dentry->d_sb)->ns != kn->ns)
 		goto out_bad;
-
+out:
 	up_read(&kernfs_rwsem);
 	return 1;
 out_bad:
 	up_read(&kernfs_rwsem);
-out_bad_unlocked:
 	return 0;
 }
 
@@ -1092,7 +1151,7 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 	struct dentry *ret;
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_node *kn;
-	struct inode *inode;
+	struct inode *inode = NULL;
 	const void *ns = NULL;
 
 	down_read(&kernfs_rwsem);
@@ -1102,11 +1161,9 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 
 	kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
 
-	/* no such entry */
-	if (!kn || !kernfs_active(kn)) {
-		ret = NULL;
-		goto out_unlock;
-	}
+	/* no such entry, retain as negative hashed dentry */
+	if (!kn || !kernfs_active(kn))
+		goto out_negative;
 
 	/* attach dentry and inode */
 	inode = kernfs_get_inode(dir->i_sb, kn);
@@ -1114,10 +1171,10 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 		ret = ERR_PTR(-ENOMEM);
 		goto out_unlock;
 	}
-
+out_negative:
 	/* instantiate and hash dentry */
 	ret = d_splice_alias(inode, dentry);
- out_unlock:
+out_unlock:
 	up_read(&kernfs_rwsem);
 	return ret;
 }


