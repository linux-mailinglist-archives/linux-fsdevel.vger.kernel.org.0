Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469F41FC78F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 09:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgFQHiD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 03:38:03 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:49493 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726629AbgFQHiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:38:03 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D23F4574;
        Wed, 17 Jun 2020 03:38:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 Jun 2020 03:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        /rAbDMt6FC3fG09UnQPczhNktJ9DSAXatCwomfNKw7A=; b=EZ+hu2XSckUTh2ww
        9ChVrX43WWyu1hOF1y2dRHfKAYYvNcZrlWcuhfyle3e0DOj1puR+RCeEAkryYp/m
        jORajl2/0TKGS8GTBloS1v8lJ6TuYDKVPsiWgFqRlAy+rtG82p/7/Ae6K7V1d72F
        Kqeilin2R6vSR2WKNTnLkCLxKfo6i3NtEm1L53X5LL/vEXJMQtGFgYVYpVZVtvcQ
        keCDqXhx+RI4SdAVXFq0R610EE/AEMCfck6odQphJz4UxcgRCjA0s1oJd0U383wE
        TpCEtBnUEAwXsPDH/yFUOzCgh/XHm6Zb7Vfkm9cSb0WrXWaEP8rAK5COgCdwQRjP
        HqqMFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=/rAbDMt6FC3fG09UnQPczhNktJ9DSAXatCwomfNKw
        7A=; b=rKZrjB2o86mRXyffoXCH8nD6a1yeD2qKkhpJdp6+qxv+0lvcO1e/nYybC
        nnDKyg/1iMDISUrdFHx2ibqAdC4wTZPFNe4gg/egISiHgWdOd82KhQpscPTijUpS
        KoCzfNrbAAYHVEFFHMqNpBxivz4+tJCwHSrnHYU96W6/fAkNhGsgl7knCA2ckCg5
        lVkoVDXVKvI9KSH49+DBkGhnouVfcCsi+pIH+La1xY0o98Ko+2XNBbaj7rt8wptm
        MZKHEoHCq9o8PQJh5BG0Q+IwazlGwSKZ19UrLFvWRblh4Cb6/DRyTI6Haxp3SDMN
        aygKiVtsNkSzoNPZGJARed4p5+Pug==
X-ME-Sender: <xms:WcjpXs1F6Mwi6-1PBZjCTCOmk8EuK-4tX39h3WpxHJCBldvMxNGn6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuhffvfffkjghffgggtgfgsehtjedttddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epvddvvdfgleefhfelgfekvdejjefhvdetfeevueeggeefhfdujeegveejveejgfdunecu
    kfhppeehkedrjedrudelgedrkeejnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:WcjpXnECjlRxolJOcpVcaPhBTGVBmCyNsSz6QVYDv43jVHCi7RQbRQ>
    <xmx:WcjpXk7oNMyoL7cPXxSNUulyEnFr_zXBvVu2XzLSo5vIGokMuh9_cA>
    <xmx:WcjpXl1pCIy2nBAYABob42NNGnHyt9_KV9kCHF3y5LEF4isZ_G94Qw>
    <xmx:WcjpXgMsJwFVSDSoL177lggFhTKF5GbDUesEL14Qzrvj-KT05mFEYw>
Received: from mickey.themaw.net (58-7-194-87.dyn.iinet.net.au [58.7.194.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0112430618B7;
        Wed, 17 Jun 2020 03:38:01 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.themaw.net (Postfix) with ESMTP id 69E00A0314;
        Wed, 17 Jun 2020 15:37:58 +0800 (AWST)
Subject: [PATCH v2 3/6] kernfs: improve kernfs path resolution
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
Date:   Wed, 17 Jun 2020 15:37:58 +0800
Message-ID: <159237947839.89469.7331804336434093565.stgit@mickey.themaw.net>
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


