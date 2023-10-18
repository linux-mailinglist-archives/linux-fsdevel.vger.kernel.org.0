Return-Path: <linux-fsdevel+bounces-581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0227CD1D8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 03:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3EFD1C20C55
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Oct 2023 01:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C681C05;
	Wed, 18 Oct 2023 01:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="MteHerEV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97017E9
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 01:34:14 +0000 (UTC)
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8179109
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 18:34:12 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2D633C0DA4
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 01:34:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a302.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AB167C0ACA
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Oct 2023 01:34:11 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697592851; a=rsa-sha256;
	cv=none;
	b=SjIZtFRwtjwI1wExvyRLAuVDy/yLIemyPopi7vcOwLT812A50v32G9CKY3dgnGa25ub8ut
	5Zkzvmo44bA0jhXz7rByNveUFQISQiu//5+vmZeIIPTfbsYmlrj09QwCtPFexg//D8QEBX
	v8PCDvIwgA3cCqRlvHKQja6EcwF62xnRulJq2I6UXlfssNGbXt++MR30GoJxMKVX4h05Sg
	CHEy/yh0qz4cceHQuPcBTnIgYD8FC1N2noKkCMIUPLLpLn1KflSsWOxDPHx30+hp33WWbh
	ghzliXe0Ax1Vdy/hVlChJIzi7Kccu5k+vQt+a6U99g3OPpW5PauB362Fxn9M/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1697592851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=PWcGcc1N96pVbtjYCrBHSWdBU6sl93dC5YZCNRVRav8=;
	b=1tBIjxld/uzK/UEmwHBvW+HCQ6hIiMGkV9xztO7KmAo2F6b4KDI9KpDdk20AWE17bgq1vB
	GSSWchS2m1xvnU7M7Gqx4hygxhqw4lV3qEEUspY8VM+oPshQB41eGxPFLEKQsIr4bTQMNK
	f++pHKgMt2U5r+COU1RXVlrHDqIQLLmlXv0JY+1dh7HrE5pU++1grK/bWN4DP/8rr5kdf8
	tUiGTfIjRX+TLaBcF/WwL3tdgD6O/F5ddUVx1WuZqJ7sYFtsgcHDSmI4zFzuw1swuPseS7
	0HhnM3QT8HriIiUB89WDMbZtKwkiBibou3haCUA3DYYT0bqdn3at4fOnrYIFpA==
ARC-Authentication-Results: i=1;
	rspamd-555cdc57c9-2pf7v;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Arch: 04dcf6880ceaa68c_1697592851937_1511239899
X-MC-Loop-Signature: 1697592851937:2358896406
X-MC-Ingress-Time: 1697592851937
Received: from pdx1-sub0-mail-a302.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.113.192.191 (trex/6.9.2);
	Wed, 18 Oct 2023 01:34:11 +0000
Received: from kmjvbox (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a302.dreamhost.com (Postfix) with ESMTPSA id 4S9D0M35xbzBW
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Oct 2023 18:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1697592851;
	bh=PWcGcc1N96pVbtjYCrBHSWdBU6sl93dC5YZCNRVRav8=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=MteHerEVcBPfdyHbQ61dmZxob5N3zZu2sLo44dBVPhzLSrwzDrGDRNiEpQCqk/TFK
	 mx4VAhQ/lIvUbtjAPVICTWVfep7vNy8UMOtUMGlsSCfe17rl9XEvY9uF20gOmQzNDG
	 4XXnL6AABMN62wAz6Wh1aMu49fFadYRHyWY98kpZe9ypD/rHG7E7jaC4LQMJ+rrcBz
	 MSkztGCJm+xZZgZ2mR2N5iHaK2JT0q/30b1vO2Qijh4VkRTUPMOTfGoAKJoPI4lk7y
	 2vHiNJ5vDOeXCm1UedGaEKsDhgktIYCi5DhjOXoZtUoooYPH6oLcLyvQ6OZ0hXIqyK
	 EDRvE5Kgz1iLQ==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0083
	by kmjvbox (DragonFly Mail Agent v0.12);
	Tue, 17 Oct 2023 18:33:59 -0700
Date: Tue, 17 Oct 2023 18:33:59 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
	German Maglione <gmaglione@redhat.com>, Greg Kurz <groug@kaod.org>,
	Max Reitz <mreitz@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>
Subject: [PATCH v3] fuse: share lookup state between submount and its parent
Message-ID: <20231018013359.GB3902@templeofstupid.com>
References: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegtzyUhcVbYrLG5Uhdur9fPxtdvxyYhFzCBf9Q8v6fK3Ow@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fuse submounts do not perform a lookup for the nodeid that they inherit
from their parent.  Instead, the code decrements the nlookup on the
submount's fuse_inode when it is instantiated, and no forget is
performed when a submount root is evicted.

Trouble arises when the submount's parent is evicted despite the
submount itself being in use.  In this author's case, the submount was
in a container and deatched from the initial mount namespace via a
MNT_DEATCH operation.  When memory pressure triggered the shrinker, the
inode from the parent was evicted, which triggered enough forgets to
render the submount's nodeid invalid.

Since submounts should still function, even if their parent goes away,
solve this problem by sharing refcounted state between the parent and
its submount.  When all of the references on this shared state reach
zero, it's safe to forget the final lookup of the fuse nodeid.

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
Cc: stable@vger.kernel.org
Fixes: 1866d779d5d2 ("fuse: Allow fuse_fill_super_common() for submounts")
---
 fs/fuse/fuse_i.h | 20 +++++++++++
 fs/fuse/inode.c  | 88 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 105 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 405252bb51f2..0d1659c5016b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -63,6 +63,24 @@ struct fuse_forget_link {
 	struct fuse_forget_link *next;
 };
 
+/* Submount lookup tracking */
+struct fuse_submount_lookup {
+	/** Refcount */
+	refcount_t count;
+
+	/** Unique ID, which identifies the inode between userspace
+	 * and kernel */
+	u64 nodeid;
+
+	/** Number of lookups on this inode */
+	u64 nlookup;
+
+	/** The request used for sending the FORGET message */
+	struct fuse_forget_link *forget;
+
+	struct rcu_head rcu;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -158,6 +176,8 @@ struct fuse_inode {
 	 */
 	struct fuse_inode_dax *dax;
 #endif
+	/** Submount specific lookup tracking */
+	struct fuse_submount_lookup *submount_lookup;
 };
 
 /** FUSE inode state bits */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 444418e240c8..dc1499e2074f 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -68,6 +68,24 @@ struct fuse_forget_link *fuse_alloc_forget(void)
 	return kzalloc(sizeof(struct fuse_forget_link), GFP_KERNEL_ACCOUNT);
 }
 
+static struct fuse_submount_lookup *fuse_alloc_submount_lookup(void)
+{
+	struct fuse_submount_lookup *sl;
+
+	sl = kzalloc(sizeof(struct fuse_submount_lookup), GFP_KERNEL_ACCOUNT);
+	if (!sl)
+		return NULL;
+	sl->forget = fuse_alloc_forget();
+	if (!sl->forget)
+		goto out_free;
+
+	return sl;
+
+out_free:
+	kfree(sl);
+	return NULL;
+}
+
 static struct inode *fuse_alloc_inode(struct super_block *sb)
 {
 	struct fuse_inode *fi;
@@ -113,9 +131,24 @@ static void fuse_free_inode(struct inode *inode)
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
+static void fuse_cleanup_submount_lookup(struct fuse_conn *fc,
+					 struct fuse_submount_lookup *sl)
+{
+	if (!refcount_dec_and_test(&sl->count))
+		return;
+
+	if (sl->nlookup) {
+		fuse_queue_forget(fc, sl->forget, sl->nodeid, sl->nlookup);
+		sl->forget = NULL;
+	}
+	kfree(sl->forget);
+	kfree_rcu(sl, rcu);
+}
+
 static void fuse_evict_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
+	struct fuse_submount_lookup *sl = NULL;
 
 	/* Will write inode on close/munmap and in all other dirtiers */
 	WARN_ON(inode->i_state & I_DIRTY_INODE);
@@ -132,6 +165,15 @@ static void fuse_evict_inode(struct inode *inode)
 					  fi->nlookup);
 			fi->forget = NULL;
 		}
+
+		spin_lock(&fi->lock);
+		if (fi->submount_lookup) {
+			sl = fi->submount_lookup;
+			fi->submount_lookup = NULL;
+		}
+		spin_unlock(&fi->lock);
+		if (sl)
+			fuse_cleanup_submount_lookup(fc, sl);
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
 		WARN_ON(!list_empty(&fi->write_files));
@@ -332,6 +374,14 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		fuse_dax_dontcache(inode, attr->flags);
 }
 
+static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
+				      u64 nodeid)
+{
+	sl->nodeid = nodeid;
+	sl->nlookup = 1;
+	refcount_set(&sl->count, 1);
+}
+
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 			    struct fuse_conn *fc)
 {
@@ -395,12 +445,22 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 	 */
 	if (fc->auto_submounts && (attr->flags & FUSE_ATTR_SUBMOUNT) &&
 	    S_ISDIR(attr->mode)) {
+		struct fuse_inode *fi;
+
 		inode = new_inode(sb);
 		if (!inode)
 			return NULL;
 
 		fuse_init_inode(inode, attr, fc);
-		get_fuse_inode(inode)->nodeid = nodeid;
+		fi = get_fuse_inode(inode);
+		fi->nodeid = nodeid;
+		fi->submount_lookup = fuse_alloc_submount_lookup();
+		if (!fi->submount_lookup) {
+			iput(inode);
+			return NULL;
+		}
+		/* Sets nlookup = 1 on fi->submount_lookup->nlookup */
+		fuse_init_submount_lookup(fi->submount_lookup, nodeid);
 		inode->i_flags |= S_AUTOMOUNT;
 		goto done;
 	}
@@ -423,11 +483,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 		iput(inode);
 		goto retry;
 	}
-done:
 	fi = get_fuse_inode(inode);
 	spin_lock(&fi->lock);
 	fi->nlookup++;
 	spin_unlock(&fi->lock);
+done:
 	fuse_change_attributes(inode, attr, NULL, attr_valid, attr_version);
 
 	return inode;
@@ -1465,6 +1525,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	struct super_block *parent_sb = parent_fi->inode.i_sb;
 	struct fuse_attr root_attr;
 	struct inode *root;
+	struct fuse_submount_lookup *sl;
+	struct fuse_inode *fi;
 
 	fuse_sb_defaults(sb);
 	fm->sb = sb;
@@ -1487,12 +1549,32 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	 * its nlookup should not be incremented.  fuse_iget() does
 	 * that, though, so undo it here.
 	 */
-	get_fuse_inode(root)->nlookup--;
+	fi = get_fuse_inode(root);
+	fi->nlookup--;
+
 	sb->s_d_op = &fuse_dentry_operations;
 	sb->s_root = d_make_root(root);
 	if (!sb->s_root)
 		return -ENOMEM;
 
+	/*
+	 * Grab the parent's submount_lookup pointer and take a
+	 * reference on the shared nlookup from the parent.  This is to
+	 * prevent the last forget for this nodeid from getting
+	 * triggered until all users have finished with it.
+	 */
+	spin_lock(&parent_fi->lock);
+	sl = parent_fi->submount_lookup;
+	if (sl) {
+		refcount_inc(&sl->count);
+		spin_unlock(&parent_fi->lock);
+		spin_lock(&fi->lock);
+		fi->submount_lookup = sl;
+		spin_unlock(&fi->lock);
+	} else {
+		spin_unlock(&parent_fi->lock);
+	}
+
 	return 0;
 }
 
-- 
2.25.1


