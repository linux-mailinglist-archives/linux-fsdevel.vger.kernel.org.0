Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4793A1FC799
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 09:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFQHi3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 03:38:29 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43099 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726769AbgFQHiI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:38:08 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D04F1561;
        Wed, 17 Jun 2020 03:38:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 17 Jun 2020 03:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        YP81i3I+Z4aS6pPC7VYSp+SNREBPRhMa7fFT8ZR5kf8=; b=VARnqolEz9kMpyOG
        rueMBTTc+omAW2E/8JihoNv6+SbQLONF4FMTPJhJzGUjCqPFVvgTtZklKCqXuKQH
        sao7DxZ/XzN70CRTPA4E4bnihrSsTnOOIekMaob8Kp/iVRStsBGraheOmaT7Shij
        E2oMFstbgp00D+43D+GzXGoFCCP4ZW+v9Ejjg0RjLeg2HecT1MBulnu37pbCEi7Q
        aveHGFplNn/At35OKw02tWbRBE1KLjGR2XACHGKDsn+FJjU71RjR3x7pIkVa5Fis
        OPsVsMPv+PWwWLkrQAkF4XEl0yK87QYQ65mNLiGKQ6HfHfhOyBZfwq+pNTdpYmk6
        Ncy7RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=YP81i3I+Z4aS6pPC7VYSp+SNREBPRhMa7fFT8ZR5k
        f8=; b=kA62n4dMK9q8KoCq0Z/fLzeUfL/w+UQpRJXyfpc9mpEclDNnJO5790ci1
        sle1qA3nJDbJmmv6h/EyIeivRAfB2Ojg4FjP3UhE3Ug9g5LNKRhB7SaOEs9iYc5g
        9BS3u0SQ8s5wQzb5snW//h3SN9xqTQ0h0CnNZcih2lX2k51leP8zb5jQXast5Slk
        5HOBBME9yEJXmHyaai5/Kk324Nxye1TngWDKxqLztPnUMYwQv7/mQukwpiMY/XfP
        MyJ5Aqj6o1C/NLvDN+5UUIk0eGdJbbKApq1euafVZD80efG3+2ma2Jj3IHGXqaA1
        MD0I5gGbGC1OWOQpG17pQz8z0yqXA==
X-ME-Sender: <xms:XsjpXgKLoE92dhsF0V8fcFM7aZRABP6vdQoLS6dwplYqAnI1I_6OuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejuddguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefuhffvfffkjghffgggtgfgsehtjedttddtreejnecuhfhrohhmpefkrghn
    ucfmvghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnh
    epvddvvdfgleefhfelgfekvdejjefhvdetfeevueeggeefhfdujeegveejveejgfdunecu
    kfhppeehkedrjedrudelgedrkeejnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrg
    hmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:XsjpXgIYDU4kFtnkUPrcD-ZyPtGbQ5jdO6-jN1GknWPzqQi0JFDHXA>
    <xmx:XsjpXgtdXdR2d-wTAUmwI4HLSSkO1fpfGQprOWjGATWAmlC9y9HmEg>
    <xmx:XsjpXtbrX-LRvBGuvwJWD3UxGl8IBVEzC_V-O8EQn6DIHcRrtynUHQ>
    <xmx:XsjpXix1YaR-vfywETePTw3dNre2k7ALE-fwMlAsqqTGTpXO0CKbEg>
Received: from mickey.themaw.net (58-7-194-87.dyn.iinet.net.au [58.7.194.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id EC8ED328005D;
        Wed, 17 Jun 2020 03:38:05 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.themaw.net (Postfix) with ESMTP id 79164A0314;
        Wed, 17 Jun 2020 15:38:03 +0800 (AWST)
Subject: [PATCH v2 4/6] kernfs: use revision to identify directory node
 changes
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
Date:   Wed, 17 Jun 2020 15:38:03 +0800
Message-ID: <159237948345.89469.9839924207092477321.stgit@mickey.themaw.net>
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

If a kernfs directory node hasn't changed there's no need to search for
an added (or removed) child dentry.

Add a revision counter to kernfs directory nodes so it can be used
to detect if a directory node has changed.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/kernfs/dir.c             |   17 +++++++++++++++--
 fs/kernfs/kernfs-internal.h |   24 ++++++++++++++++++++++++
 include/linux/kernfs.h      |    5 +++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index f4943329e578..03f4f179bbc4 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -383,6 +383,7 @@ static int kernfs_link_sibling(struct kernfs_node *kn)
 	/* successfully added, account subdir number */
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs++;
+	kernfs_inc_rev(kn->parent);
 
 	return 0;
 }
@@ -405,6 +406,7 @@ static bool kernfs_unlink_sibling(struct kernfs_node *kn)
 
 	if (kernfs_type(kn) == KERNFS_DIR)
 		kn->parent->dir.subdirs--;
+	kernfs_inc_rev(kn->parent);
 
 	rb_erase(&kn->rb, &kn->parent->dir.children);
 	RB_CLEAR_NODE(&kn->rb);
@@ -1044,9 +1046,16 @@ struct kernfs_node *kernfs_create_empty_dir(struct kernfs_node *parent,
 
 static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 {
+	struct kernfs_node *parent;
 	struct kernfs_node *kn;
 
 	if (flags & LOOKUP_RCU) {
+		/* Directory node changed? */
+		parent = kernfs_dentry_node(dentry->d_parent);
+
+		if (!kernfs_dir_changed(parent, dentry))
+			return 1;
+
 		kn = kernfs_dentry_node(dentry);
 		if (!kn) {
 			/* Negative hashed dentry, tell the VFS to switch to
@@ -1093,8 +1102,6 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 
 	kn = kernfs_dentry_node(dentry);
 	if (!kn) {
-		struct kernfs_node *parent;
-
 		/* If the kernfs node can be found this is a stale negative
 		 * hashed dentry so it must be discarded and the lookup redone.
 		 */
@@ -1102,6 +1109,10 @@ static int kernfs_dop_revalidate(struct dentry *dentry, unsigned int flags)
 		if (parent) {
 			const void *ns = NULL;
 
+			/* Directory node changed? */
+			if (kernfs_dir_changed(parent, dentry))
+				goto out_bad;
+
 			if (kernfs_ns_enabled(parent))
 				ns = kernfs_info(dentry->d_parent->d_sb)->ns;
 			kn = kernfs_find_ns(parent, dentry->d_name.name, ns);
@@ -1156,6 +1167,8 @@ static struct dentry *kernfs_iop_lookup(struct inode *dir,
 
 	down_read(&kernfs_rwsem);
 
+	kernfs_set_rev(dentry, parent);
+
 	if (kernfs_ns_enabled(parent))
 		ns = kernfs_info(dir->i_sb)->ns;
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 097c1a989aa4..a7b0e2074260 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -82,6 +82,30 @@ static inline struct kernfs_node *kernfs_dentry_node(struct dentry *dentry)
 	return d_inode(dentry)->i_private;
 }
 
+static inline void kernfs_set_rev(struct dentry *dentry,
+				  struct kernfs_node *kn)
+{
+	dentry->d_time = kn->dir.rev;
+}
+
+static inline void kernfs_inc_rev(struct kernfs_node *kn)
+{
+	if (kernfs_type(kn) == KERNFS_DIR) {
+		if (!++kn->dir.rev)
+			kn->dir.rev++;
+	}
+}
+
+static inline bool kernfs_dir_changed(struct kernfs_node *kn,
+				      struct dentry *dentry)
+{
+	if (kernfs_type(kn) == KERNFS_DIR) {
+		if (kn->dir.rev != dentry->d_time)
+			return true;
+	}
+	return false;
+}
+
 extern const struct super_operations kernfs_sops;
 extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
 
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 89f6a4214a70..74727d98e380 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -98,6 +98,11 @@ struct kernfs_elem_dir {
 	 * better directly in kernfs_node but is here to save space.
 	 */
 	struct kernfs_root	*root;
+	/*
+	 * Monotonic revision counter, used to identify if a directory
+	 * node has changed during revalidation.
+	 */
+	unsigned long rev;
 };
 
 struct kernfs_elem_symlink {


