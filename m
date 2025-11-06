Return-Path: <linux-fsdevel+bounces-67249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED740C389BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 02:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4570E4F69C4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF9122E3E9;
	Thu,  6 Nov 2025 00:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="W+pCljlw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wdugi8eV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A747212554;
	Thu,  6 Nov 2025 00:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390595; cv=none; b=nr3O522kCRirdMJseozcVUsrWhgZyN6lOsFBQGKKfpYHm9upL6yBeqrUQkxZdbraz/ED+H2CUgXGp3lIoG5HBEZvHS5IxdQAzBitYVaROxIeFIK3p+GHsGmG3GYJoqy9gmsrJQjpLG+dQBOgOAXx5for6yWeFWmUdD30QLtlgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390595; c=relaxed/simple;
	bh=cnYQMovU24Imj0/Yi5XOPwESZWBl3VGgoXYYabP6F1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VY659RFrq9MOU2+BN/ydDKzlMLz7JhVjeIp5EDR3yVJlkAgMzuBqriE4rRPvJ1X0IV1iSmc6ySJ5+ltZij9tgAteJflHCmd+HA6KZx4oPgOpF1CMaIf/qT0poqzVKcl5gds9W4krLJtFuHR+oDMbU1Bg9BBI9njd3tlwCD76uRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=W+pCljlw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wdugi8eV; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 4293F138067B;
	Wed,  5 Nov 2025 19:56:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 05 Nov 2025 19:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762390592;
	 x=1762397792; bh=G5X6FDpGtkAmNXYvk/JaLXiGh2JZ3DVZjZ19qFI5vTg=; b=
	W+pCljlwNPw3HP+H8zVneo44GP1UFCcFwD3uJwTj/oYI/nt5M4EcGBvrSXPtKvUt
	HXPr6BTRy9jcBjeg0em2Fg7CatiDX4sUms4Z55gzCaPTzdxodLuG2w/wDSHsikRR
	ewZvLRzvEK4nuuoEYQMJkLrz3ZEjvaBbiyAK4BRD7WkckBIZ6hfNUHjcBRN9xqb5
	KHQL5/FIOjbn/S9/FM0KQgUnz9+P2bvZ0gIu8mxsdaTGEmd3lxo8JsyI6bzgud+s
	cXzUJvUGQvDddmOdimCZv9xKBre0GSSID65tGbYp+IYXy7uzusCGyrOhGNEZTg3b
	8BFtwua6owAIqICt63th0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762390592; x=1762397792; bh=G
	5X6FDpGtkAmNXYvk/JaLXiGh2JZ3DVZjZ19qFI5vTg=; b=Wdugi8eVyMpadDxHy
	PEdcRBdH0mv+dZbTNboSm0nT0be/FCsKyjhyfn1WA5HP2vaO3H1KE8RfepaoXTAO
	X1vhhJT+zlj1IErmhQVuRqQ6UFoJqE52xYJZ7XAfkZYSBeCuWeHNbTv1Kl6+hm+m
	T9rQf6JCNkFVz7NOPTT4EHCRLaPGBxKmx7t19I8IBfs3+gCgJH1r1He9BLpcGPRU
	uabC8u5BUW5I1ptcjO4Litz5+BNYPcDnvQEpdy41aqSJvwKhtTj4fwvsWfqJL7Xq
	oObWIfzHNtMfUGzcAOtWwwfhZKJGouCH23OwHou8TfxLVGp1dPO5/OEBvXh0aoX3
	LXMPg==
X-ME-Sender: <xms:P_ILaTuBLfdy5UHYXgJCjxNFtJoWu9TlzUkDh5HCMqsVEueKMx45xg>
    <xme:P_ILaZjW4FndihXq4dvMxZA_csRD9PXdCwLn8dkoq7YXLzlujqEX4R_n38Bd8cfJs
    2nemBYifXqv03_k3sBCSucKQmUJLTVXd62-OY18S4LWR0uU7Q>
X-ME-Received: <xmr:P_ILaTw0ztQF06mBofam8HZBpoIcOGc0OyAG8gvkqaxnaT8yjRDxw9uWgc-vcVm8Lw2n1B6oolqvH6j_YNZiS9yKA41BIPuF2NpiutlgGmXP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
    esohifnhhmrghilhdrnhgvthdpnhgspghrtghpthhtohepgedtpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpd
    hrtghpthhtohepshgvlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdigfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhinhhugidquhhnihhonhhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehlihhnuhigqdhsvggtuhhrihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqtghifhhssehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:P_ILaf7GOIMicysDlEdQk7K7XEk92iWWLhwYTHGJXxYRNSOHBW_xYQ>
    <xmx:P_ILaVeFrVN3uZz01BzeBSx9K38_lzWTSMNJl4uPP_YsGxiuxwK5Kg>
    <xmx:P_ILaXr-vjjazFV5j_lQTgwKDyn9in5TQRopVnqh9034Y0In9SygXg>
    <xmx:P_ILaZ0KpQLo9JAqwtZa91UHf1rVoiWMzj4asamNlXrfpwdPuqcFow>
    <xmx:QPILae5wbfimK5u_ULoWmF8096YI0to3JW3AlWZCmqx8aGhsXFR_Shaz>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:56:21 -0500 (EST)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>
Cc: "Jan Kara" <jack@suse.cz>,	linux-fsdevel@vger.kernel.org,
	Jeff Layton <jlayton@kernel.org>,	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,	David Howells <dhowells@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,	Tyler Hicks <code@tyhicks.com>,
	Miklos Szeredi <miklos@szeredi.hu>,	Chuck Lever <chuck.lever@oracle.com>,
	Olga Kornievskaia <okorniev@redhat.com>,	Dai Ngo <Dai.Ngo@oracle.com>,
	Namjae Jeon <linkinjeon@kernel.org>,	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Carlos Maiolino <cem@kernel.org>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>,	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,	Mateusz Guzik <mjguzik@gmail.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,	linux-kernel@vger.kernel.org,
	netfs@lists.linux.dev,	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,	linux-unionfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,	linux-xfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,	selinux@vger.kernel.org
Subject: [PATCH v5 11/14] Add start_renaming_two_dentries()
Date: Thu,  6 Nov 2025 11:50:55 +1100
Message-ID: <20251106005333.956321-12-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20251106005333.956321-1-neilb@ownmail.net>
References: <20251106005333.956321-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

A few callers want to lock for a rename and already have both dentries.
Also debugfs does want to perform a lookup but doesn't want permission
checking, so start_renaming_dentry() cannot be used.

This patch introduces start_renaming_two_dentries() which is given both
dentries.  debugfs performs one lookup itself.  As it will only continue
with a negative dentry and as those cannot be renamed or unlinked, it is
safe to do the lookup before getting the rename locks.

overlayfs uses start_renaming_two_dentries() in three places and  selinux
uses it twice in sel_make_policy_nodes().

In sel_make_policy_nodes() we now lock for rename twice instead of just
once so the combined operation is no longer atomic w.r.t the parent
directory locks.  As selinux_state.policy_mutex is held across the whole
operation this does open up any interesting races.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>

---
changes since v3:
 added missing assignment to rd.mnt_idmap in ovl_cleanup_and_whiteout
---
 fs/debugfs/inode.c           | 48 ++++++++++++--------------
 fs/namei.c                   | 65 ++++++++++++++++++++++++++++++++++++
 fs/overlayfs/dir.c           | 43 ++++++++++++++++--------
 include/linux/namei.h        |  2 ++
 security/selinux/selinuxfs.c | 27 ++++++++++-----
 5 files changed, 136 insertions(+), 49 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index f241b9df642a..532bd7c46baf 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -842,7 +842,8 @@ int __printf(2, 3) debugfs_change_name(struct dentry *dentry, const char *fmt, .
 	int error = 0;
 	const char *new_name;
 	struct name_snapshot old_name;
-	struct dentry *parent, *target;
+	struct dentry *target;
+	struct renamedata rd = {};
 	struct inode *dir;
 	va_list ap;
 
@@ -855,36 +856,31 @@ int __printf(2, 3) debugfs_change_name(struct dentry *dentry, const char *fmt, .
 	if (!new_name)
 		return -ENOMEM;
 
-	parent = dget_parent(dentry);
-	dir = d_inode(parent);
-	inode_lock(dir);
+	rd.old_parent = dget_parent(dentry);
+	rd.new_parent = rd.old_parent;
+	rd.flags = RENAME_NOREPLACE;
+	target = lookup_noperm_unlocked(&QSTR(new_name), rd.new_parent);
+	if (IS_ERR(target))
+		return PTR_ERR(target);
 
-	take_dentry_name_snapshot(&old_name, dentry);
-
-	if (WARN_ON_ONCE(dentry->d_parent != parent)) {
-		error = -EINVAL;
-		goto out;
-	}
-	if (strcmp(old_name.name.name, new_name) == 0)
-		goto out;
-	target = lookup_noperm(&QSTR(new_name), parent);
-	if (IS_ERR(target)) {
-		error = PTR_ERR(target);
-		goto out;
-	}
-	if (d_really_is_positive(target)) {
-		dput(target);
-		error = -EINVAL;
+	error = start_renaming_two_dentries(&rd, dentry, target);
+	if (error) {
+		if (error == -EEXIST && target == dentry)
+			/* it isn't an error to rename a thing to itself */
+			error = 0;
 		goto out;
 	}
-	simple_rename_timestamp(dir, dentry, dir, target);
-	d_move(dentry, target);
-	dput(target);
+
+	dir = d_inode(rd.old_parent);
+	take_dentry_name_snapshot(&old_name, dentry);
+	simple_rename_timestamp(dir, dentry, dir, rd.new_dentry);
+	d_move(dentry, rd.new_dentry);
 	fsnotify_move(dir, dir, &old_name.name, d_is_dir(dentry), NULL, dentry);
-out:
 	release_dentry_name_snapshot(&old_name);
-	inode_unlock(dir);
-	dput(parent);
+	end_renaming(&rd);
+out:
+	dput(rd.old_parent);
+	dput(target);
 	kfree_const(new_name);
 	return error;
 }
diff --git a/fs/namei.c b/fs/namei.c
index 4b740048df97..7f0384ceb976 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3877,6 +3877,71 @@ int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 }
 EXPORT_SYMBOL(start_renaming_dentry);
 
+/**
+ * start_renaming_two_dentries - Lock to dentries in given parents for rename
+ * @rd:           rename data containing parent
+ * @old_dentry:   dentry of name to move
+ * @new_dentry:   dentry to move to
+ *
+ * Ensure locks are in place for rename and check parentage is still correct.
+ *
+ * On success the two dentries are stored in @rd.old_dentry and
+ * @rd.new_dentry and @rd.old_parent and @rd.new_parent are confirmed to
+ * be the parents of the dentries.
+ *
+ * References and the lock can be dropped with end_renaming()
+ *
+ * Returns: zero or an error.
+ */
+int
+start_renaming_two_dentries(struct renamedata *rd,
+			    struct dentry *old_dentry, struct dentry *new_dentry)
+{
+	struct dentry *trap;
+	int err;
+
+	/* Already have the dentry - need to be sure to lock the correct parent */
+	trap = lock_rename_child(old_dentry, rd->new_parent);
+	if (IS_ERR(trap))
+		return PTR_ERR(trap);
+	err = -EINVAL;
+	if (d_unhashed(old_dentry) ||
+	    (rd->old_parent && rd->old_parent != old_dentry->d_parent))
+		/* old_dentry was removed, or moved and explicit parent requested */
+		goto out_unlock;
+	if (d_unhashed(new_dentry) ||
+	    rd->new_parent != new_dentry->d_parent)
+		/* new_dentry was removed or moved */
+		goto out_unlock;
+
+	if (old_dentry == trap)
+		/* source is an ancestor of target */
+		goto out_unlock;
+
+	if (new_dentry == trap) {
+		/* target is an ancestor of source */
+		if (rd->flags & RENAME_EXCHANGE)
+			err = -EINVAL;
+		else
+			err = -ENOTEMPTY;
+		goto out_unlock;
+	}
+
+	err = -EEXIST;
+	if (d_is_positive(new_dentry) && (rd->flags & RENAME_NOREPLACE))
+		goto out_unlock;
+
+	rd->old_dentry = dget(old_dentry);
+	rd->new_dentry = dget(new_dentry);
+	rd->old_parent = dget(old_dentry->d_parent);
+	return 0;
+
+out_unlock:
+	unlock_rename(old_dentry->d_parent, rd->new_parent);
+	return err;
+}
+EXPORT_SYMBOL(start_renaming_two_dentries);
+
 void end_renaming(struct renamedata *rd)
 {
 	unlock_rename(rd->old_parent, rd->new_parent);
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 6b2f88edb497..61e9484e4ab8 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -123,6 +123,7 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 			     struct dentry *dentry)
 {
 	struct dentry *whiteout;
+	struct renamedata rd = {};
 	int err;
 	int flags = 0;
 
@@ -134,10 +135,14 @@ int ovl_cleanup_and_whiteout(struct ovl_fs *ofs, struct dentry *dir,
 	if (d_is_dir(dentry))
 		flags = RENAME_EXCHANGE;
 
-	err = ovl_lock_rename_workdir(ofs->workdir, whiteout, dir, dentry);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = ofs->workdir;
+	rd.new_parent = dir;
+	rd.flags = flags;
+	err = start_renaming_two_dentries(&rd, whiteout, dentry);
 	if (!err) {
-		err = ovl_do_rename(ofs, ofs->workdir, whiteout, dir, dentry, flags);
-		unlock_rename(ofs->workdir, dir);
+		err = ovl_do_rename_rd(&rd);
+		end_renaming(&rd);
 	}
 	if (err)
 		goto kill_whiteout;
@@ -388,6 +393,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
+	struct renamedata rd = {};
 	struct path upperpath;
 	struct dentry *upper;
 	struct dentry *opaquedir;
@@ -413,7 +419,11 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (IS_ERR(opaquedir))
 		goto out;
 
-	err = ovl_lock_rename_workdir(workdir, opaquedir, upperdir, upper);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = workdir;
+	rd.new_parent = upperdir;
+	rd.flags = RENAME_EXCHANGE;
+	err = start_renaming_two_dentries(&rd, opaquedir, upper);
 	if (err)
 		goto out_cleanup_unlocked;
 
@@ -431,8 +441,8 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	if (err)
 		goto out_cleanup;
 
-	err = ovl_do_rename(ofs, workdir, opaquedir, upperdir, upper, RENAME_EXCHANGE);
-	unlock_rename(workdir, upperdir);
+	err = ovl_do_rename_rd(&rd);
+	end_renaming(&rd);
 	if (err)
 		goto out_cleanup_unlocked;
 
@@ -445,7 +455,7 @@ static struct dentry *ovl_clear_empty(struct dentry *dentry,
 	return opaquedir;
 
 out_cleanup:
-	unlock_rename(workdir, upperdir);
+	end_renaming(&rd);
 out_cleanup_unlocked:
 	ovl_cleanup(ofs, workdir, opaquedir);
 	dput(opaquedir);
@@ -468,6 +478,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct dentry *workdir = ovl_workdir(dentry);
 	struct dentry *upperdir = ovl_dentry_upper(dentry->d_parent);
+	struct renamedata rd = {};
 	struct dentry *upper;
 	struct dentry *newdentry;
 	int err;
@@ -499,7 +510,11 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	if (IS_ERR(newdentry))
 		goto out_dput;
 
-	err = ovl_lock_rename_workdir(workdir, newdentry, upperdir, upper);
+	rd.mnt_idmap = ovl_upper_mnt_idmap(ofs);
+	rd.old_parent = workdir;
+	rd.new_parent = upperdir;
+	rd.flags = 0;
+	err = start_renaming_two_dentries(&rd, newdentry, upper);
 	if (err)
 		goto out_cleanup_unlocked;
 
@@ -536,16 +551,16 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 		if (err)
 			goto out_cleanup;
 
-		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper,
-				    RENAME_EXCHANGE);
-		unlock_rename(workdir, upperdir);
+		rd.flags = RENAME_EXCHANGE;
+		err = ovl_do_rename_rd(&rd);
+		end_renaming(&rd);
 		if (err)
 			goto out_cleanup_unlocked;
 
 		ovl_cleanup(ofs, workdir, upper);
 	} else {
-		err = ovl_do_rename(ofs, workdir, newdentry, upperdir, upper, 0);
-		unlock_rename(workdir, upperdir);
+		err = ovl_do_rename_rd(&rd);
+		end_renaming(&rd);
 		if (err)
 			goto out_cleanup_unlocked;
 	}
@@ -565,7 +580,7 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	return err;
 
 out_cleanup:
-	unlock_rename(workdir, upperdir);
+	end_renaming(&rd);
 out_cleanup_unlocked:
 	ovl_cleanup(ofs, workdir, newdentry);
 	dput(newdentry);
diff --git a/include/linux/namei.h b/include/linux/namei.h
index c47713e9867c..9104c7104191 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -161,6 +161,8 @@ int start_renaming(struct renamedata *rd, int lookup_flags,
 		   struct qstr *old_last, struct qstr *new_last);
 int start_renaming_dentry(struct renamedata *rd, int lookup_flags,
 			  struct dentry *old_dentry, struct qstr *new_last);
+int start_renaming_two_dentries(struct renamedata *rd,
+				struct dentry *old_dentry, struct dentry *new_dentry);
 void end_renaming(struct renamedata *rd);
 
 /**
diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 232e087bce3e..a224ef9bb831 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -506,6 +506,7 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 {
 	int ret = 0;
 	struct dentry *tmp_parent, *tmp_bool_dir, *tmp_class_dir;
+	struct renamedata rd = {};
 	unsigned int bool_num = 0;
 	char **bool_names = NULL;
 	int *bool_values = NULL;
@@ -539,22 +540,30 @@ static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 	if (ret)
 		goto out;
 
-	lock_rename(tmp_parent, fsi->sb->s_root);
+	rd.old_parent = tmp_parent;
+	rd.new_parent = fsi->sb->s_root;
 
 	/* booleans */
-	d_exchange(tmp_bool_dir, fsi->bool_dir);
+	ret = start_renaming_two_dentries(&rd, tmp_bool_dir, fsi->bool_dir);
+	if (!ret) {
+		d_exchange(tmp_bool_dir, fsi->bool_dir);
 
-	swap(fsi->bool_num, bool_num);
-	swap(fsi->bool_pending_names, bool_names);
-	swap(fsi->bool_pending_values, bool_values);
+		swap(fsi->bool_num, bool_num);
+		swap(fsi->bool_pending_names, bool_names);
+		swap(fsi->bool_pending_values, bool_values);
 
-	fsi->bool_dir = tmp_bool_dir;
+		fsi->bool_dir = tmp_bool_dir;
+		end_renaming(&rd);
+	}
 
 	/* classes */
-	d_exchange(tmp_class_dir, fsi->class_dir);
-	fsi->class_dir = tmp_class_dir;
+	ret = start_renaming_two_dentries(&rd, tmp_class_dir, fsi->class_dir);
+	if (ret == 0) {
+		d_exchange(tmp_class_dir, fsi->class_dir);
+		fsi->class_dir = tmp_class_dir;
 
-	unlock_rename(tmp_parent, fsi->sb->s_root);
+		end_renaming(&rd);
+	}
 
 out:
 	sel_remove_old_bool_data(bool_num, bool_names, bool_values);
-- 
2.50.0.107.gf914562f5916.dirty


