Return-Path: <linux-fsdevel+bounces-2663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D5D7E746E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 23:38:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75D228123E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906F038F9D;
	Thu,  9 Nov 2023 22:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="fw9zGrQ3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1198D38FA6
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:38:21 +0000 (UTC)
Received: from hamster.cherry.relay.mailchannels.net (hamster.cherry.relay.mailchannels.net [23.83.223.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691133C01
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:38:21 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id EE5206C238E
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:38:20 +0000 (UTC)
Received: from pdx1-sub0-mail-a219.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 964E66C2668
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 22:38:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1699569500; a=rsa-sha256;
	cv=none;
	b=tBxj1DfhNE594U0B/FF/E2O9Bk/z8CRD8uG+8Pk+Mt7HrUo/G8VARlU6VwvtmC6CSg5e6C
	/yzF4qs1rsgxN/aOyCR6u/2rsBXNiBy8VGdGZj+QIFLQxzXAzBc/I8obejmfkDUPWQybx/
	FpdXJ/fO2MIFr/KVJeTVnXChNCcdK/HiZNLy1rCRGkNGeyUKYjTGY316RkGo0etz7BCq0z
	WE1SkkZXsTQklrlp0YwU7tPO641C/Q6d8zxfkDYCThAlZnHtceJTBkGc2cIVnSrNvmF/zu
	KG3aImPdwIKdmDRYKXiAAeEPTYktXhqoJ8fXhPO+ihHoQJo7i1x26pBFKgNpow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1699569500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6HuS5Rvj2HRh01mLHyf14Nt/w5Z/py+pjFLszKB3Vss=;
	b=KOXg4DRhfJ78DNIJmE+064EFHKYJgQtxvXerUz999nztKuUaI/8YOy7VkMk2cfFp56+A12
	X3ffShzhXYDGrtwjPzcmvDU+a77vJs4Gmor4Udc1nBKsuV5Uot0IFs4J+0TQNFmDmWge3t
	2/+ucbIcacFme/YxYjUR9cANTackSZ4DGQO39SZUk/Z+3K/OlDFArkM3bLlM+SWE5HDXth
	9upFSyCvvFOm2Ipxx+hy87nWfYPlNI9wCqFvfTXqFeLRatlc8WjRCU+E0vBn3+wBYxxeQO
	/jZpAYIvWXHUvZywPPBBpxvAaZxGqmLufFT3BnPDPrcjTlBYR4qLNMwPgmzx2A==
ARC-Authentication-Results: i=1;
	rspamd-6f98f74948-x7vsh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Good
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Fearful-Abaft: 59246b132a0e4f9b_1699569500803_1861061384
X-MC-Loop-Signature: 1699569500802:3708247713
X-MC-Ingress-Time: 1699569500802
Received: from pdx1-sub0-mail-a219.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.67.125 (trex/6.9.2);
	Thu, 09 Nov 2023 22:38:20 +0000
Received: from kmjvbox.templeofstupid.com (c-73-231-176-24.hsd1.ca.comcast.net [73.231.176.24])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a219.dreamhost.com (Postfix) with ESMTPSA id 4SRH0r2VvfzR5
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 14:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1699569500;
	bh=6HuS5Rvj2HRh01mLHyf14Nt/w5Z/py+pjFLszKB3Vss=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fw9zGrQ3T3QBcm2P5Kks2tD1GUIW4o++D/7EzC1M9SwMjXLpXOz+dpbbaLym5aGdD
	 G2DcniL+EtmyocoX1/Fh41RPNlNrJCyNaRxx4oEtB9Y+yNqvlq22Os01b0mwGZPOCW
	 f11OBLRa9xSX7Mt1mZrZLKS7+X+q+HCoUgVZqOwoTM+1/pR18teYbrLGtp41kGiSGq
	 yDSns2possAdqbTC2VBFi6QwEaZi0xHQnZSyMx/dyRUpB2zbZXS7x5Oyu92m5ff2Ec
	 Pl72gYrysK2drx2Nre1U9Z5VYPgfa3fPqYRtrMH6YqhWEIeFBGwz1ILipy2JUef+GD
	 bmYvxjiAxkMoA==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0044
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Thu, 09 Nov 2023 14:37:46 -0800
Date: Thu, 9 Nov 2023 14:37:46 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org,
	German Maglione <gmaglione@redhat.com>, Greg Kurz <groug@kaod.org>,
	Max Reitz <mreitz@redhat.com>,
	Bernd Schubert <bernd.schubert@fastmail.fm>,
	"Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Kurmi, Suresh Kumar" <suresh.kumar.kurmi@intel.com>,
	"Saarinen, Jani" <jani.saarinen@intel.com>,
	lkft-triage@lists.linaro.org, linux-kselftest@vger.kernel.org,
	regressions@lists.linux.dev, intel-gfx@lists.freedesktop.org
Subject: [v5 PATCH 2/2] fuse: share lookup state between submount and its
 parent
Message-ID: <20231109223746.GC2073@templeofstupid.com>
References: <cover.1699564053.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699564053.git.kjlx@templeofstupid.com>

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
Changes since v4:

- Ensure that submount_lookup is NULL initialized in fuse_alloc_inode.
  (Feedback from Naresh Kamboju and Chaitanya Kumar Borah)

Changes since v3:

- Remove rcu head from lookup tracking struct along with unnecessary
  kfree_rcu call. (Feedback from Miklos Szeredi)
- Make nlookup one implicitly.  Remove from struct and simplify places
  where it was being used. (Feedback from Miklos Szeredi)
- Remove unnecessary spinlock acquisition. (Feedback from Miklos
  Szeredi)
- Add a WARN_ON if the lookup tracking cookie cannot be found during
  fuse_fill_super_submount.  (Feedback from Miklos Szeredi)

Changes since v2:

- Move to an approach where the lookup is shared between the submount's
  parent and children.  Use a reference counted lookup cookie to decide
  when it is safe to perform the forget of the final reference.
  (Feedback from Miklos Szeredi)

Changes since v1:

- Cleanups to pacify test robot

Changes since RFC:

- Modified fuse_fill_super_submount to always fail if dentry cannot be
  revalidated.  (Feedback from Bernd Schubert)
- Fixed up an edge case where looked up but subsequently declared
  invalid dentries were not correctly tracking nlookup.  (Error was
  introduced in my RFC).
---
 fs/fuse/fuse_i.h | 15 ++++++++++
 fs/fuse/inode.c  | 75 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 405252bb51f2..9377c46f14c4 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -63,6 +63,19 @@ struct fuse_forget_link {
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
+	/** The request used for sending the FORGET message */
+	struct fuse_forget_link *forget;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -158,6 +171,8 @@ struct fuse_inode {
 	 */
 	struct fuse_inode_dax *dax;
 #endif
+	/** Submount specific lookup tracking */
+	struct fuse_submount_lookup *submount_lookup;
 };
 
 /** FUSE inode state bits */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 444418e240c8..d7ebc322e55b 100644
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
@@ -85,6 +103,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->state = 0;
 	mutex_init(&fi->mutex);
 	spin_lock_init(&fi->lock);
+	fi->submount_lookup = NULL;
 	fi->forget = fuse_alloc_forget();
 	if (!fi->forget)
 		goto out_free;
@@ -113,6 +132,17 @@ static void fuse_free_inode(struct inode *inode)
 	kmem_cache_free(fuse_inode_cachep, fi);
 }
 
+static void fuse_cleanup_submount_lookup(struct fuse_conn *fc,
+					 struct fuse_submount_lookup *sl)
+{
+	if (!refcount_dec_and_test(&sl->count))
+		return;
+
+	fuse_queue_forget(fc, sl->forget, sl->nodeid, 1);
+	sl->forget = NULL;
+	kfree(sl);
+}
+
 static void fuse_evict_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
@@ -132,6 +162,11 @@ static void fuse_evict_inode(struct inode *inode)
 					  fi->nlookup);
 			fi->forget = NULL;
 		}
+
+		if (fi->submount_lookup) {
+			fuse_cleanup_submount_lookup(fc, fi->submount_lookup);
+			fi->submount_lookup = NULL;
+		}
 	}
 	if (S_ISREG(inode->i_mode) && !fuse_is_bad(inode)) {
 		WARN_ON(!list_empty(&fi->write_files));
@@ -332,6 +367,13 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 		fuse_dax_dontcache(inode, attr->flags);
 }
 
+static void fuse_init_submount_lookup(struct fuse_submount_lookup *sl,
+				      u64 nodeid)
+{
+	sl->nodeid = nodeid;
+	refcount_set(&sl->count, 1);
+}
+
 static void fuse_init_inode(struct inode *inode, struct fuse_attr *attr,
 			    struct fuse_conn *fc)
 {
@@ -395,12 +437,22 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
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
@@ -423,11 +475,11 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
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
@@ -1465,6 +1517,8 @@ static int fuse_fill_super_submount(struct super_block *sb,
 	struct super_block *parent_sb = parent_fi->inode.i_sb;
 	struct fuse_attr root_attr;
 	struct inode *root;
+	struct fuse_submount_lookup *sl;
+	struct fuse_inode *fi;
 
 	fuse_sb_defaults(sb);
 	fm->sb = sb;
@@ -1487,12 +1541,27 @@ static int fuse_fill_super_submount(struct super_block *sb,
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
+	sl = parent_fi->submount_lookup;
+	WARN_ON(!sl);
+	if (sl) {
+		refcount_inc(&sl->count);
+		fi->submount_lookup = sl;
+	}
+
 	return 0;
 }
 
-- 
2.25.1


