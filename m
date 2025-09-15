Return-Path: <linux-fsdevel+bounces-61276-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C360DB56EBE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 05:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4682F177791
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 03:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9D7239591;
	Mon, 15 Sep 2025 03:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="TyuuT6dC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMLIbkIf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B50A22173A;
	Mon, 15 Sep 2025 03:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905969; cv=none; b=EFBwlP66QOxui2h2J75k5KvaE+ciJZmqEENhObXLw3e12O1q/banfe5tzgVfGrW46jyt3WXWe59PS/jAcKUJz2P5kXrl9yBDme+GBZQVWLzzpjU6n3rHP/Fo3n0EKEG+TwHAfL1McT2bqSnZKxUhKlM7JW+VeE0HHMR2agKLlQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905969; c=relaxed/simple;
	bh=g3iP9mSHzeimQ1owqwMEemrcx0YEVWAHUT4W/NqodS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcJrHc+esB00oor4kUD7xAcUQuap8T2W8CSvU7wirk79phiCBpURyaKXGMjt3TX/WTYhZlv3WtOQ4jwKrWLhvvNS1G6+8NaKJzeeMTl0Z3Wn4kxKJ+v4vidnu98d7J3cD3XInE1TWOrTHp3CRlChzZrs81SpWXzI2jfiUF+/za8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=TyuuT6dC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iMLIbkIf; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D89F1D000B8;
	Sun, 14 Sep 2025 23:12:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 14 Sep 2025 23:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757905966;
	 x=1757992366; bh=5H+IOTextlM7T2psowwtP600Ua9Jo8aLAeD6ncvUXzo=; b=
	TyuuT6dC/fuROJTPb36kbkPJWlpPGsoqONvMVk9KFhwo/lTK72F1S/4tuZo3tNoU
	1Vleafrhiqp36rQ2RWdKE8BXZyFk1UhZ15nR/XKQBOFdnrDFs8lIGWEGa8z45rpN
	+mvE7KiXurR5MrraDTrYGIZU+qrHzJvGBog4Wq5+/VJS7vKQNWlFfScLu7FuPdXn
	Ez6JUW0a2rAXUD8kXBGxeKi54mC1jf0vOHKLQQ1wmt/ZH1TcrKeFyrdNc6Dfje8i
	6aGjwlPpPMkHUXLYeZbxOrgkq8zIE4Dbx6ui6HvtXPiQ8UgvrZYXJgZ6xL98KVWL
	PAPhJYqhzaEyU1qrlm3Aiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757905966; x=1757992366; bh=5
	H+IOTextlM7T2psowwtP600Ua9Jo8aLAeD6ncvUXzo=; b=iMLIbkIfXg9WgQ0If
	Ma0EZhkBvteQFNt062kDu8gdJxRiqlA33aIqTYTKaTtNeU9mjKz+dABEKiHvouh/
	3uyq8zZcZu2ct97874ZXMp64d3mHj6NKHRPZrY6a62E1EC0ymE/5InkG7AxDR3Zi
	K4C5eXltRHd8E6rFCexaY+kNR85eIKRq66Lw8M/ixN4KWNFQSPo2Ftp1qOjPXKJT
	o4B+mCLdsgmNLpeNESaZIKe1AePNYzmGBsaR1pLN3frq9nX16ERs7xAeBkOp988u
	zJX5bdeY1P66bUvDw5Zfogx1mC6dSO1Mqc89KLk2UvtBgT1F3f9ZZ7HZn2Fadzgk
	tnqxg==
X-ME-Sender: <xms:LYTHaG7gu6JFv7KtEG6NOOWpi5jBGMnZTpAs1KOwbDt6Bud5QMU3UA>
    <xme:LYTHaLmbr9IYTe7fjoESiSdmgFvlTbFi-NoM3CvhIFrF2ETqQ3rtJFip1T2IXWewJ
    X8I5oo1-iQX1Q>
X-ME-Received: <xmr:LYTHaB6Frqcw0R_o7T536-TbZws93K2rvzrdIuaZIrNT-eU9bkVNA6iTUCMVLNqtiHAH3TvXtXYxhBXyOLqS6s_VHWx6bPmjoE14eYw5BuRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepthhrohhnughmhieskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhlrgihthhonheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghn
    nhgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:LYTHaMR5rUi7_cNAMQ1v45LaPbqyK4HAHK8QvfAgrG3Smq3OdcQ-CA>
    <xmx:LYTHaPxn9d5IGr-ChPCWSGajzgW_f9QOahaH_5X4GQk2Gpr3_nXmYQ>
    <xmx:LYTHaEoX-mF2Q6vp45BbY2kGmc7oRX6gk5xsBNviwTqvcPQ9v93LCQ>
    <xmx:LYTHaC13Es-UzMkTOUa845YAgYBDy61WZUlUyNtdfMDpdhUDdPnNfA>
    <xmx:LoTHaAYOc9wH79JXMy9LpZMGV6aMR5j3lsWsh5J_hLlgF2QsRfBsjbfL>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 23:12:42 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	"Jan Kara" <jack@suse.cz>
Subject: [PATCH 1/2] NFS: remove d_drop()/d_alloc_paralle() from nfs_atomic_open()
Date: Mon, 15 Sep 2025 13:01:07 +1000
Message-ID: <20250915031134.2671907-2-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250915031134.2671907-1-neilb@ownmail.net>
References: <20250915031134.2671907-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

It is important that two non-create NFS "open"s of a negative dentry don't race.
They both have a shared lock on i_rwsem and so could run concurrently, but
they might both try to call d_exact_alias() or d_splice_alias() at the
same time which is confusing at best.

nfs_atomic_open() currently avoids this by discarding the negative dentry
and creating a new one with d_alloc_parallel().  Only one thread can
successfully get the d_in_lookup() dentry, the other will wait for the
first to finish, and can use the result of that first lookup.

Dropping the dentry like this will defeat a proposed new locking scheme
which locks the dentry and requires it to remain hashed.

We can achieve the same effect by causing ->d_revalidate to invalidate a
negative dentry when LOOKUP_OPEN is set.  Doing this is consistent with
the "close to open" caching semantics of NFS which require the server to
be queried whenever opening a file - cached information must not be
trusted.

With this change to d_revaliate (implemented in nfs_neg_need_reval)
we can be sure that if the dentry that reaches nfs_atomic_open() is
not d_in_lookup and is negative, then some other lookup or atomic_open
must have happened since d_revalidate was called, so we have recent
confirmation from the server that the name doesn't exist, and we can
safely fail the open request (which finish_no_open() will effectively do
when passed a negative dentry).

Note that none of the above applies to O_CREAT opens.  These are fully
serialised with an exclusive lock on i_rwsem and there is no attempt to
d_drop() the dentry in that case.  d_revalidate() does not need to
request invalidation of a negative dentry as a create will proceed in
that case anyway.

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/nfs/dir.c | 30 +++++++-----------------------
 1 file changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index d81217923936..bc417566508e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1615,6 +1615,11 @@ int nfs_neg_need_reval(struct inode *dir, struct dentry *dentry,
 {
 	if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET))
 		return 0;
+	if (flags & LOOKUP_OPEN)
+		/* close-to-open semantics require we go to server
+		 * on each open.
+		 */
+		return 1;
 	if (NFS_SERVER(dir)->flags & NFS_MOUNT_LOOKUP_CACHE_NONEG)
 		return 1;
 	/* Case insensitive server? Revalidate negative dentries */
@@ -2060,14 +2065,12 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		    struct file *file, unsigned open_flags,
 		    umode_t mode)
 {
-	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 	struct nfs_open_context *ctx;
 	struct dentry *res;
 	struct iattr attr = { .ia_valid = ATTR_OPEN };
 	struct inode *inode;
 	unsigned int lookup_flags = 0;
 	unsigned long dir_verifier;
-	bool switched = false;
 	int created = 0;
 	int err;
 
@@ -2112,16 +2115,8 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 		attr.ia_size = 0;
 	}
 
-	if (!(open_flags & O_CREAT) && !d_in_lookup(dentry)) {
-		d_drop(dentry);
-		switched = true;
-		dentry = d_alloc_parallel(dentry->d_parent,
-					  &dentry->d_name, &wq);
-		if (IS_ERR(dentry))
-			return PTR_ERR(dentry);
-		if (unlikely(!d_in_lookup(dentry)))
-			return finish_no_open(file, dentry);
-	}
+	if (!(open_flags & O_CREAT) && !d_in_lookup(dentry))
+		return finish_no_open(file, dentry);
 
 	ctx = create_nfs_open_context(dentry, open_flags, file);
 	err = PTR_ERR(ctx);
@@ -2165,10 +2160,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	trace_nfs_atomic_open_exit(dir, ctx, open_flags, err);
 	put_nfs_open_context(ctx);
 out:
-	if (unlikely(switched)) {
-		d_lookup_done(dentry);
-		dput(dentry);
-	}
 	return err;
 
 no_open:
@@ -2191,13 +2182,6 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 			res = ERR_PTR(-EOPENSTALE);
 		}
 	}
-	if (switched) {
-		d_lookup_done(dentry);
-		if (!res)
-			res = dentry;
-		else
-			dput(dentry);
-	}
 	if (IS_ERR(res))
 		return PTR_ERR(res);
 	return finish_no_open(file, res);
-- 
2.50.0.107.gf914562f5916.dirty


