Return-Path: <linux-fsdevel+bounces-67239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDEFC388BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 06 Nov 2025 01:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CAE3B3E40
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Nov 2025 00:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551BE1E2614;
	Thu,  6 Nov 2025 00:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="C0OBokuh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tBYGPOta"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D92133E7;
	Thu,  6 Nov 2025 00:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762390466; cv=none; b=q6gwEV7lKuQdTxIpJpfB5qT7CO+lGucfpCooPnKrsqEDUxjAoW9S8vvgX1mxe0y5XnUNfFjh0K/F8dcewVaCDDNF3uXUUcYiYjQYHbjUTfPoeYc6RDIaNsa1QmejBdJN1rnzRJh3Mg30MK7B1klSpScF9SibTh7Ub7L9PvfVrxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762390466; c=relaxed/simple;
	bh=RmVeYvKIABKYj54i2E6DdVi9uVuFWJDVWmWLlMKnkpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gAihD0ClrJ0fu5ijELIN0N1sRBKoaZ1RpaPMZpQOeV2vyTCCe02u2mVy9RdXN7FAqI0DQz5l3QERvU2ObCGYXE1oYM5kkFww1Jj7S+GbrrHURlM3y73/Fe+i0JKkBj28EUP6sEjQkp8asFmhvTYpTKLWNPscatfI156VfbHX424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=C0OBokuh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tBYGPOta; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id D2B5D13005D8;
	Wed,  5 Nov 2025 19:54:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 05 Nov 2025 19:54:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm3; t=1762390462;
	 x=1762397662; bh=m9Ag5U4v4i0p1qdD5EHBf7dKjG+6HaGzyjuRSYZwFvo=; b=
	C0OBokuhXWT2UkB3yPPJHiYYNz8NLWW6BbQvqCZhYhPktFMedI9zsznwIrUjprfl
	iwr5pJIM5wq0k+apvTpqbKFnzP4LSsGz+wsCTZhFzi2ngVp8fVT8ZKMfbaJqi9yS
	QpNURMBqBWos5hW7mixBY47mzoomv8Mm57ZquErlmvHoPJ8csH06bayWXNjdwB+w
	JHxlnAb9JEKt2+qmrF+ZzYDloWW/N1gjAA5S+GPTp7eli8hqvUGYYqhaGgjHZj3o
	JjAgIP3/4Pb7RES7rwkvek8ilZqtF2kwY4fw65UGzj3TcDl2pj08QexSJwTl10Le
	X0V1IoiT4/2mP3hQG2EaLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1762390462; x=1762397662; bh=m
	9Ag5U4v4i0p1qdD5EHBf7dKjG+6HaGzyjuRSYZwFvo=; b=tBYGPOtaquO4GwuTe
	eURMTe9Mi9yerxaPXiJiwnFdW/9uWwafvWj+Jdrd0R9R/jkD71D35l1CVhEj+uVn
	uZ2C0q7y4ccb2I362KBoNvHnxPuZGkeXOds0HwKi2DMLkt7k3tGCd/Ud7cuKL5+O
	HpJbpOPZ6kQDsbnPD5EpKjFwguUYg8EhBukThRBXM+sFGqkZ6evWlUdus8GrcNUY
	FNPGN15lUF4xsScf1UiEdLZxnqNGuO/HaoE1XMduyuBDu30lLlvWiUyd6vm8zbIJ
	VkflTDIAE3nfq48IOliNOP971T6udy3tT7Xnyif4kIIlIYopHIgj9oUoOUOq9N42
	BbE2A==
X-ME-Sender: <xms:vfELaYqeInkSUbHKc3HlBTn5ZPfbiW68STvoIHgYjGkeLkKsc_K8sA>
    <xme:vfELaTtLZ25pvoiaXmyBnmIbynKnJRIxhC5j6cS5sdmj7gDQlvrQPkm-Aev9rpqGe
    WktTbpBiJNAKAzseZN5A7o4C7JVTPeDhPZkKLNllYK1EuWs4w>
X-ME-Received: <xmr:vfELaaNPHD-XKTuwF07frbtGC1u1RxYR0WFm-5NOmgViiGW0EZ_Uq5uDmIm5K0hgsUd5VTKaxK3KvPSOXhahMdoPKO6-jF0GF1n2zOZxZKH3>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeehfeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhhrggfgsedtkeertdertddtnecuhfhrohhmpefpvghilheu
    rhhofihnuceonhgvihhlsgesohifnhhmrghilhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveevkeffudeuvefhieeghffgudektdelkeejiedtjedugfeukedvkeffvdefvddunecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepnhgvihhlsg
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
X-ME-Proxy: <xmx:vfELadn7DIhGYyeDxi6lFnSbys3HAZP_879Td6VIM7UFJBLoRTCnBA>
    <xmx:vfELaZbIaK02Slm892O8LJtreogV2VMElB_bx9IA-nzvyXFtIgk34Q>
    <xmx:vfELaU06-UtBdmQecmc_f_ILuTFuGtcQLcY1f0YylkpU9Pv0vCfMeQ>
    <xmx:vfELaXQVtKSsEWKTkO9opBq6-AcSHyH6aChLOsNH_DMd5xxhQKg9Nw>
    <xmx:vvELaVwSc-LrSD9xDPCQij-8kUWnU_DVHtq83Eoyc0ZiCkBBmw_qosBH>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 19:54:11 -0500 (EST)
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
Subject: [PATCH v5 02/14] VFS: introduce start_dirop() and end_dirop()
Date: Thu,  6 Nov 2025 11:50:46 +1100
Message-ID: <20251106005333.956321-3-neilb@ownmail.net>
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

The fact that directory operations (create,remove,rename) are protected
by a lock on the parent is known widely throughout the kernel.
In order to change this - to instead lock the target dentry  - it is
best to centralise this knowledge so it can be changed in one place.

This patch introduces start_dirop() which is local to VFS code.
It performs the required locking for create and remove.  Rename
will be handled separately.

Various functions with names like start_creating() or start_removing_path(),
some of which already exist, will export this functionality beyond the VFS.

end_dirop() is the partner of start_dirop().  It drops the lock and
releases the reference on the dentry.
It *is* exported so that various end_creating etc functions can be inline.

As vfs_mkdir() drops the dentry on error we cannot use end_dirop() as
that won't unlock when the dentry IS_ERR().  For now we need an explicit
unlock when dentry IS_ERR().  I hope to change vfs_mkdir() to unlock
when it drops a dentry so that explicit unlock can go away.

end_dirop() can always be called on the result of start_dirop(), but not
after vfs_mkdir().  After a vfs_mkdir() we still may need the explicit
unlock as seen in end_creating_path().

As well as adding start_dirop() and end_dirop()
this patch uses them in:
 - simple_start_creating (which requires sharing lookup_noperm_common()
        with libfs.c)
 - start_removing_path / start_removing_user_path_at
 - filename_create / end_creating_path()
 - do_rmdir(), do_unlinkat()

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/internal.h      |  3 ++
 fs/libfs.c         | 36 ++++++++---------
 fs/namei.c         | 98 ++++++++++++++++++++++++++++++++++------------
 include/linux/fs.h |  2 +
 4 files changed, 95 insertions(+), 44 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 9b2b4d116880..d08d5e2235e9 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -67,6 +67,9 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 		const struct path *parentpath,
 		struct file *file, umode_t mode);
 struct dentry *d_hash_and_lookup(struct dentry *, struct qstr *);
+struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
+			   unsigned int lookup_flags);
+int lookup_noperm_common(struct qstr *qname, struct dentry *base);
 
 /*
  * namespace.c
diff --git a/fs/libfs.c b/fs/libfs.c
index 1661dcb7d983..2d6657947abd 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2290,27 +2290,25 @@ void stashed_dentry_prune(struct dentry *dentry)
 	cmpxchg(stashed, dentry, NULL);
 }
 
-/* parent must be held exclusive */
+/**
+ * simple_start_creating - prepare to create a given name
+ * @parent: directory in which to prepare to create the name
+ * @name:   the name to be created
+ *
+ * Required lock is taken and a lookup in performed prior to creating an
+ * object in a directory.  No permission checking is performed.
+ *
+ * Returns: a negative dentry on which vfs_create() or similar may
+ *  be attempted, or an error.
+ */
 struct dentry *simple_start_creating(struct dentry *parent, const char *name)
 {
-	struct dentry *dentry;
-	struct inode *dir = d_inode(parent);
+	struct qstr qname = QSTR(name);
+	int err;
 
-	inode_lock(dir);
-	if (unlikely(IS_DEADDIR(dir))) {
-		inode_unlock(dir);
-		return ERR_PTR(-ENOENT);
-	}
-	dentry = lookup_noperm(&QSTR(name), parent);
-	if (IS_ERR(dentry)) {
-		inode_unlock(dir);
-		return dentry;
-	}
-	if (dentry->d_inode) {
-		dput(dentry);
-		inode_unlock(dir);
-		return ERR_PTR(-EEXIST);
-	}
-	return dentry;
+	err = lookup_noperm_common(&qname, parent);
+	if (err)
+		return ERR_PTR(err);
+	return start_dirop(parent, &qname, LOOKUP_CREATE | LOOKUP_EXCL);
 }
 EXPORT_SYMBOL(simple_start_creating);
diff --git a/fs/namei.c b/fs/namei.c
index 39c4d52f5b54..231e1ffd4b8d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2765,6 +2765,48 @@ static int filename_parentat(int dfd, struct filename *name,
 	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
 }
 
+/**
+ * start_dirop - begin a create or remove dirop, performing locking and lookup
+ * @parent:       the dentry of the parent in which the operation will occur
+ * @name:         a qstr holding the name within that parent
+ * @lookup_flags: intent and other lookup flags.
+ *
+ * The lookup is performed and necessary locks are taken so that, on success,
+ * the returned dentry can be operated on safely.
+ * The qstr must already have the hash value calculated.
+ *
+ * Returns: a locked dentry, or an error.
+ *
+ */
+struct dentry *start_dirop(struct dentry *parent, struct qstr *name,
+			   unsigned int lookup_flags)
+{
+	struct dentry *dentry;
+	struct inode *dir = d_inode(parent);
+
+	inode_lock_nested(dir, I_MUTEX_PARENT);
+	dentry = lookup_one_qstr_excl(name, parent, lookup_flags);
+	if (IS_ERR(dentry))
+		inode_unlock(dir);
+	return dentry;
+}
+
+/**
+ * end_dirop - signal completion of a dirop
+ * @de: the dentry which was returned by start_dirop or similar.
+ *
+ * If the de is an error, nothing happens. Otherwise any lock taken to
+ * protect the dentry is dropped and the dentry itself is release (dput()).
+ */
+void end_dirop(struct dentry *de)
+{
+	if (!IS_ERR(de)) {
+		inode_unlock(de->d_parent->d_inode);
+		dput(de);
+	}
+}
+EXPORT_SYMBOL(end_dirop);
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__start_removing_path(int dfd, struct filename *name,
 					   struct path *path)
@@ -2781,10 +2823,9 @@ static struct dentry *__start_removing_path(int dfd, struct filename *name,
 		return ERR_PTR(-EINVAL);
 	/* don't fail immediately if it's r/o, at least try to report other errors */
 	error = mnt_want_write(parent_path.mnt);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
+	d = start_dirop(parent_path.dentry, &last, 0);
 	if (IS_ERR(d))
-		goto unlock;
+		goto drop;
 	if (error)
 		goto fail;
 	path->dentry = no_free_ptr(parent_path.dentry);
@@ -2792,10 +2833,9 @@ static struct dentry *__start_removing_path(int dfd, struct filename *name,
 	return d;
 
 fail:
-	dput(d);
+	end_dirop(d);
 	d = ERR_PTR(error);
-unlock:
-	inode_unlock(parent_path.dentry->d_inode);
+drop:
 	if (!error)
 		mnt_drop_write(parent_path.mnt);
 	return d;
@@ -2910,7 +2950,7 @@ int vfs_path_lookup(struct dentry *dentry, struct vfsmount *mnt,
 }
 EXPORT_SYMBOL(vfs_path_lookup);
 
-static int lookup_noperm_common(struct qstr *qname, struct dentry *base)
+int lookup_noperm_common(struct qstr *qname, struct dentry *base)
 {
 	const char *name = qname->name;
 	u32 len = qname->len;
@@ -4223,21 +4263,18 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	 */
 	if (last.name[last.len] && !want_dir)
 		create_flags &= ~LOOKUP_CREATE;
-	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path->dentry,
-				      reval_flag | create_flags);
+	dentry = start_dirop(path->dentry, &last, reval_flag | create_flags);
 	if (IS_ERR(dentry))
-		goto unlock;
+		goto out_drop_write;
 
 	if (unlikely(error))
 		goto fail;
 
 	return dentry;
 fail:
-	dput(dentry);
+	end_dirop(dentry);
 	dentry = ERR_PTR(error);
-unlock:
-	inode_unlock(path->dentry->d_inode);
+out_drop_write:
 	if (!error)
 		mnt_drop_write(path->mnt);
 out:
@@ -4256,11 +4293,26 @@ struct dentry *start_creating_path(int dfd, const char *pathname,
 }
 EXPORT_SYMBOL(start_creating_path);
 
+/**
+ * end_creating_path - finish a code section started by start_creating_path()
+ * @path: the path instantiated by start_creating_path()
+ * @dentry: the dentry returned by start_creating_path()
+ *
+ * end_creating_path() will unlock and locks taken by start_creating_path()
+ * and drop an references that were taken.  It should only be called
+ * if start_creating_path() returned a non-error.
+ * If vfs_mkdir() was called and it returned an error, that error *should*
+ * be passed to end_creating_path() together with the path.
+ */
 void end_creating_path(const struct path *path, struct dentry *dentry)
 {
-	if (!IS_ERR(dentry))
-		dput(dentry);
-	inode_unlock(path->dentry->d_inode);
+	if (IS_ERR(dentry))
+		/* The parent is still locked despite the error from
+		 * vfs_mkdir() - must unlock it.
+		 */
+		inode_unlock(path->dentry->d_inode);
+	else
+		end_dirop(dentry);
 	mnt_drop_write(path->mnt);
 	path_put(path);
 }
@@ -4592,8 +4644,7 @@ int do_rmdir(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = start_dirop(path.dentry, &last, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4602,9 +4653,8 @@ int do_rmdir(int dfd, struct filename *name)
 		goto exit4;
 	error = vfs_rmdir(mnt_idmap(path.mnt), path.dentry->d_inode, dentry);
 exit4:
-	dput(dentry);
+	end_dirop(dentry);
 exit3:
-	inode_unlock(path.dentry->d_inode);
 	mnt_drop_write(path.mnt);
 exit2:
 	path_put(&path);
@@ -4721,8 +4771,7 @@ int do_unlinkat(int dfd, struct filename *name)
 	if (error)
 		goto exit2;
 retry_deleg:
-	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
+	dentry = start_dirop(path.dentry, &last, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 
@@ -4737,9 +4786,8 @@ int do_unlinkat(int dfd, struct filename *name)
 		error = vfs_unlink(mnt_idmap(path.mnt), path.dentry->d_inode,
 				   dentry, &delegated_inode);
 exit3:
-		dput(dentry);
+		end_dirop(dentry);
 	}
-	inode_unlock(path.dentry->d_inode);
 	if (inode)
 		iput(inode);	/* truncate the inode here */
 	inode = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 03e450dd5211..9e7556e79d19 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3196,6 +3196,8 @@ extern void iterate_supers_type(struct file_system_type *,
 void filesystems_freeze(void);
 void filesystems_thaw(void);
 
+void end_dirop(struct dentry *de);
+
 extern int dcache_dir_open(struct inode *, struct file *);
 extern int dcache_dir_close(struct inode *, struct file *);
 extern loff_t dcache_dir_lseek(struct file *, loff_t, int);
-- 
2.50.0.107.gf914562f5916.dirty


