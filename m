Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E381E0686
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 May 2020 07:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbgEYFrZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 May 2020 01:47:25 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:56777 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388508AbgEYFrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 May 2020 01:47:24 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 315FFEAD;
        Mon, 25 May 2020 01:47:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 25 May 2020 01:47:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        subject:from:to:cc:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=fm3; bh=
        YP81i3I+Z4aS6pPC7VYSp+SNREBPRhMa7fFT8ZR5kf8=; b=WDSzJbSeRjxarBWv
        uv+FsTeoLHNBUCj55Tk1jNwyu+h4111LyEigBRNGAbPPV1ywpHAMX9VFScYCOcD4
        5BPC+lAEJB68cOBM7YeYeOwlbZ7ut8hPFyTYu8EGUBLGkMbE15D3OdnN+E4dz7VS
        138LOUGQ7Om0IJOevVRd5ipY7HI5LCDIbFBUgwC6OUWI4zPr6zEn8o6UZhlG8xKV
        WUcipVNcZ0Knn3soEXgIiyaedl0JULkM+JUjcVaAZp9vqYCQxoib4sxZCouqCc9T
        VUxeenSbrHPcFIfcgRMXP9VYlTCI8+QFW2DURMN1YkX+WbzRZyEwElRiHVjCCRl1
        XUjx3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=YP81i3I+Z4aS6pPC7VYSp+SNREBPRhMa7fFT8ZR5k
        f8=; b=0IWE8Xn2u1YXzPUhw7aBa/tFsK6szhdkkcNKrofSzVr2KWuggjzBcIaej
        b8YjMvai3Acei9R8HjyT508uHyFnb5hbKPjzJDPsDPngF3jTMZxLkUim9KwrvubU
        nybuXdbs0Yt51xfZorKuBaxHD3k6sgt0fifVl7RP6YJ4gl/302SG8piLdSWzA2Ue
        YHnfu6rMic9QDJwI2E6y2JguL/lq/Br0sTyhRhT5vuYQyBtuIQFxNgP3r3TE1PgY
        gEgUG2mSHgL9Opnrz5EtaiwKY9XNKjM+PGy15j9cSGa0Gnjt+v6pQZJNVVv9zaoa
        YziGmE5PP15WDXK+ea7778AbFNNoQ==
X-ME-Sender: <xms:6lvLXkciKzKtVO-5E1rUz39f39itD07mGV8P9vuwZAem4X_ObUJWGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudduledgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffhvfffkfgjfhgfgggtgfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    egveeuudffieeiffefieehvdetieeiteelheetueekledtledugeffheffieduieenucfk
    phepuddukedrvddtkedrudejkedrudeknecuvehluhhsthgvrhfuihiivgepfeenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgrvhgvnhesthhhvghmrgifrdhnvght
X-ME-Proxy: <xmx:6lvLXmN-k5A4x0wRYKYGB5qD6kXMyqgdqXmrGznvIg_mR8EBa0_ZXw>
    <xmx:6lvLXlga_mZpoCD0F32O1Go95EIv4hI-84Vdpp83CHOFVkuflq96uw>
    <xmx:6lvLXp-z3wMk2LGxj90NYS0zeV-pzirM-iyQr7ugTRhIucAmZhPoOg>
    <xmx:6lvLXqUCIoz11odeReRy0UABzy-9c7DATZL2ij7yT9l9iI3rujySfw>
Received: from mickey.localdomain (unknown [118.208.178.18])
        by mail.messagingengine.com (Postfix) with ESMTPA id 546803066549;
        Mon, 25 May 2020 01:47:22 -0400 (EDT)
Received: from mickey.themaw.net (localhost [127.0.0.1])
        by mickey.localdomain (Postfix) with ESMTP id CC18FA01C8;
        Mon, 25 May 2020 13:47:19 +0800 (AWST)
Subject: [PATCH 4/4] kernfs: use revision to identify directory node changes
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
Date:   Mon, 25 May 2020 13:47:19 +0800
Message-ID: <159038563978.276051.367264947378071815.stgit@mickey.themaw.net>
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


