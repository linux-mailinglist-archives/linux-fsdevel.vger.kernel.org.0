Return-Path: <linux-fsdevel+bounces-62688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7484DB9D020
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 03:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22B113833B7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Sep 2025 01:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEBE2DE702;
	Thu, 25 Sep 2025 01:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="BjlZsONY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q0fmER6p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7E1F95C;
	Thu, 25 Sep 2025 01:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758763341; cv=none; b=npD3gtUKzZ7JtxBjwLffCaDhRRiOu5JvEtLpBJ4BCL5by08Nx5NR2YaNOd15GbJsubHMV6rHlrhUoJucd80aJWLoA8wURfjtZvUGmw91QisUPxsmVbEwUiicGaY2EJ3Y1Hl4VmQ01jBLxlmJV6E/IC87FN0gq7+R5qrJB0J6568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758763341; c=relaxed/simple;
	bh=Op3p78ZmpI7tXuvElbNdODY09SqsPNMQiDpe8YM00PI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UWpS4KyM6VV96DpehGHt4RdzydTg9twc2ENX8qtAge1vQHbJtvgEr3dQesCgqVvfPX16qu6tZJDf5lUDPotHUCi7gka0g29nE2/DQkWvA0uaOjJwMN7gdvdD6dKFSevBA0Cil2YQigfsvnBfDR144l11C071uqqfEGJ+olv5AOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=BjlZsONY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q0fmER6p; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4FB391400151;
	Wed, 24 Sep 2025 21:22:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 24 Sep 2025 21:22:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1758763338;
	 x=1758849738; bh=sn2OwsVC7zbU/PDdlrfGFiV5QXKG++7/o9iHx3iLyh4=; b=
	BjlZsONYeNjd+JUyHEJHZ8SiYv81aJm/3ymR09U/+2/4xig8LgZgKaRUGQVnH1OM
	M0K56qvRY4i+PYXmFHJiiZCNiiIdVqHrp1+VGLYypz7ucONJrxNWFByQ7izisY5Q
	738NuEpWFGWLWdnRo5XVZdPSatU8WUDr2fqHHnd+gqzeraU+Zy5jWzhqseDhIPxd
	jnC/+XPe0fCGtFG+NBPhNybjWKOI4K06SbCnsO9GzZzORw4cMLKxFnv+N4lDn0p4
	hIDVM22piLFCMuwU51riJmebaxiMYuUMmkkVSJPKtkCwZj8pF5Mwef9rxvR6A7by
	8iNW4y5cqPpv8PZaNQaimQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1758763338; x=1758849738; bh=s
	n2OwsVC7zbU/PDdlrfGFiV5QXKG++7/o9iHx3iLyh4=; b=Q0fmER6phC4rRkMoE
	zUhxiHc9gsauSQ+Y41yDaFI2+LpOI98ejkJBGm/yW7bD3VPqKI5AFHfsxXO7P/k2
	T0OPb+rtF2GisRiDZ7wO6XI/6DQ64MB7Zikn0fluI7Sz7y/OLwR5L6f5MIbVLcWo
	DJ5nk6BxNSA8vO+j3BoDp2gHqtJUluPD3r98/xme7w1cOG80R8fhsVra4i036+Z6
	cZ74CmejWnsXBV/7aMOlTYz/LJSArmvFkaU9fGbKBeaN2lXcnNK1c4i+L7DaCu0e
	BQjSdn0MoM5uNKMqPpn3LFu/3O81/Z5G3Ztt1T5EWRjKljo6bNfXcc2Pp0Z5mflW
	bRqzQ==
X-ME-Sender: <xms:SpnUaIMp9hJFbL1m1igHhF4nGM4hyDq44HoF2x0gidx24YtyxwKTzg>
    <xme:SpnUaOBZSKmWW2eQZOTfllBSIfLKae4Hg4IlRaXiSnjB7ec5bm8o9gvszmPiz22w1
    dZRdN7KCoohJpjd6w3MLVPN-o5db2qtUwSjUx_Ykkh2yf-BAw>
X-ME-Received: <xmr:SpnUaFdCmsJC4KT__LlRkB-j0uSFU2Y9nVQYbM-hW42MiTV4snsEEQScvhwxaYJ84gZz30oq_BAl5S7vWSOUFzhPWlXVuSnwg8fi1jI1UpDH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhgrtghksehsuhhsvgdrtgiipdhrtghpthhtohepthhrohhnughmhieskhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheprghnnhgrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SpnUaNOGZYJa2_dGau0P1DLBtqrAVDtV8aOCwYnIorAttvWoMhlznw>
    <xmx:SpnUaFKIHimFYfrXL41aZSOpI195a4ojblSwHuhvM7WxjkyBPQ7U4w>
    <xmx:SpnUaNK0yZjM7AGSL-hCgWLkBta_GQSlZxL6YGZyOoQ5BgrRSLg0rA>
    <xmx:SpnUaP75sZZqlQX8jtYPt-_ZiOpkZHlmPT9NlDuRwuz02ewWVGENcQ>
    <xmx:SpnUaBgRNwtThWpFXFBnTE79BFCPABAGvexNlvdsTW5MjmmqKwPsXEQA>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Sep 2025 21:22:15 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH v2 2/2] VFS: don't call ->atomic_open on cached negative without O_CREAT
Date: Thu, 25 Sep 2025 11:17:53 +1000
Message-ID: <20250925012129.1340971-3-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250925012129.1340971-1-neilb@ownmail.net>
References: <20250925012129.1340971-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

If the dentry is found to be negative (not d_in_lookup() and not
positive) and if O_CREATE wasn't requested then we do not have exclusive
access the dentry.

If we pass it to ->atomic_open() the filesystem will need to ensure any
lookup+open operations are serialised so that two threads don't both try
to instantiate the dentry.  This is an unnecessary burden to put on the
filesystem.

If the filesystem wants to perform such a lookup+open operation when a
negative dentry is found, it should return 0 from ->d_revalidate in that
case (when LOOKUP_OPEN) so that the calls serialise in
d_alloc_parallel().

All filesystems with ->atomic_open() currently handle the case of a
negative dentry without O_CREAT either by returning -ENOENT or by
calling finish_no_open() with a NULL dentry.  These have the same effect
of causing atomic_open() to return -ENOENT.

For filesystems without ->atomic_open(), lookup_open() will, in this
case, also return -ENOENT.

So this patch removes the burden from filesystems by returning -ENOENT
early on a negative cached dentry when O_CREAT isn't requested.

With this change any ->atomic_open() function can be certain that it has
exclusive access to the dentry, either because an exclusive lock is held
on the parent directory or because DCACHE_PAR_LOOKUP is set implying an
exclusive lock on the dentry itself.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 10 ++++++++++
 Documentation/filesystems/vfs.rst     |  4 ++++
 fs/namei.c                            |  9 +++++++++
 3 files changed, 23 insertions(+)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index ab48ab3f6eb2..0ce53a9d36ec 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1297,3 +1297,13 @@ a different length, use
 	vfs_parse_fs_qstr(fc, key, &QSTR_LEN(value, len))
 
 instead.
+
+---
+
+**mandatory**
+
+If a filesystem provides ->atomic_open and needs to handle non-creating
+open of a cached-negative dentry, it should provide a ->d_revalidate
+that returns zero for a negative dentry when LOOKUP_OPEN is set.
+In return it is guaranteed exclusive access to any dentry passed to
+->atomic_open.
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 486a91633474..6ef17a97064f 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -678,6 +678,10 @@ otherwise noted.
 	flag should be set in file->f_mode.  In case of O_EXCL the
 	method must only succeed if the file didn't exist and hence
 	FMODE_CREATED shall always be set on success.
+	atomic_open() will always have exclusive access to the dentry,
+	as if O_CREAT hasn't caused the directory to be locked exclusively,
+	then the dentry will have DCACHE_PAR_LOOKUP which also
+	provides exclusivity.
 
 ``tmpfile``
 	called in the end of O_TMPFILE open().  Optional, equivalent to
diff --git a/fs/namei.c b/fs/namei.c
index ba8bf73d2f9c..520296f70f34 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3647,6 +3647,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		/* Cached positive dentry: will open in f_op->open */
 		return dentry;
 	}
+	if ((open_flag & O_CREAT) == 0 && !d_in_lookup(dentry)) {
+		/* Cached negative dentry and no create requested.
+		 * If a filesystem wants to be called in this case
+		 * it should trigger dentry invalidation in
+		 * ->d_revalidate(.., LOOKUP_OPEN).
+		 */
+		error = -ENOENT;
+		goto out_dput;
+	}
 
 	if (open_flag & O_CREAT)
 		audit_inode(nd->name, dir, AUDIT_INODE_PARENT);
-- 
2.50.0.107.gf914562f5916.dirty


