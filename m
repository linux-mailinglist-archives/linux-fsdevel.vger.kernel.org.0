Return-Path: <linux-fsdevel+bounces-61270-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 139A5B56E38
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 04:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373DF162AEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 02:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376C421D3CC;
	Mon, 15 Sep 2025 02:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="edax7Xcq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jwHwJO79"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637B82DC790
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 02:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757902582; cv=none; b=qngQjd8q+8T1YYy2Zu+d1UnRFqNdXefhrsqxho33Egr9dCGIaus85imeceTMWsYRXZq0kGMFIVvnL5Fe9Kwp9N2XA5TAFgroH+p8PPq/faHOUD3QkpX9c/sIaZv1B9931rcJFI2nVcNtz6fLSw8tggB/iD1cQ0NAPVwqjpjFRZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757902582; c=relaxed/simple;
	bh=NfU2WNFVcmJFQqFO8cEqjsg2gtpuMMiH5PMGysDIHO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxjMUqKdd6lfh54vu5TjBP262ik5TifQnylLuobdxEUv4n68+0IOQ5p+BAhKlvf95NwMkSBrMyhofPbB+WIrrGRSZl4hzyO7H4E0kDxR/5OFq3FgjdzJJb6ATYfPh9krvrfeut5SX0m/VRH4WzP5BzLiSKXKvREMbrLSUVEjqz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=edax7Xcq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jwHwJO79; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 44BEB1D0010E;
	Sun, 14 Sep 2025 22:16:19 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sun, 14 Sep 2025 22:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to; s=fm1; t=1757902579;
	 x=1757988979; bh=0jUV3JLQp2xY6O/3dB/61sNL0UhLEjUQ6SBHk4L82BQ=; b=
	edax7XcqmetOqjVU+/cf3i4mZICsRumNTDgTIvLVx6QeJcbQnpblEL0uQfd3YWGm
	8wqfOP805IltPSCojtVqAzKigvmBETApxqz+VEGuZlCMSDCfI7oQMAc3Kcn5XyaK
	TpYf/mub6vk4bLGhnRpX9agrVRZYkNJdCKa6nZwcK+a5qHX64V4BZqPjs8P4Mvya
	OoBHrvHqk8/STH21t3LwvrxTbgMNqMecUaMdrao1O6XpVhbGcmIWyQOirP4I1Rpu
	xycA0MWc3fXBiOMbsToF4NNkL8BQDM4pebltcuBIjPRl1JaUBxkr1Xi6w2Mx39En
	ShPoHFWYYKuA+OgQTYyMtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1757902579; x=1757988979; bh=0
	jUV3JLQp2xY6O/3dB/61sNL0UhLEjUQ6SBHk4L82BQ=; b=jwHwJO79JrC+oMSBB
	5iF9Tgeb67xl7H9Sr9dN3I8BkyuYBhsGw0ae9FjZ6JLBZHP2mBNib73bfYVmN0Fg
	xDxWpySun/AjSVudbfqbIoCFMrCJcuUJKejMfQdLa/SSpysXQZmxbPIt9oNajdPr
	s5pjbA2MkgsNRlU035JjvdCo3vKzaTRVXNliXk9S+3HbxejS0uQWW8ALtQZPMVn3
	/iBGv8gXr1hozfgoINMJB4C94cFW0LDBNVr4SFE25t2g0r2UewWLXDWKAo60T/Jb
	lsPbndHdHzC05nmCeyqyiAxseOkhGT0kmNDpiMU+ACHBvytsfvMifc078vdnv6nA
	K3itw==
X-ME-Sender: <xms:8nbHaDzWid7KvAPu9agF8RCIEBBIH5CETPWWhqn2fsT1CkA09QvcNg>
    <xme:8nbHaCqWgizZd4jQfyPsGgonGVIJUTH4bIAUQnbpjKBE_-pSphgMQ0VkcP4NydP4u
    ZP5DeH3I31j4g>
X-ME-Received: <xmr:8nbHaC6wCSDBN5Ii1Mu5QTvEyRrtlrKX9v8yezMPRvwc4MCQoI6Et1m-ncXWKj21rTEbqMwhxmphcQeNqXVvzfktTmpsQkub72_J3roPHxPz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefieegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfrhgggfestdekredtredttdenucfhrhhomheppfgvihhluehr
    ohifnhcuoehnvghilhgssehofihnmhgrihhlrdhnvghtqeenucggtffrrghtthgvrhhnpe
    evveekffduueevhfeigefhgfdukedtleekjeeitdejudfgueekvdekffdvfedvudenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehnvghilhgsse
    hofihnmhgrihhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjrggtkhesshhushgvrdgtiidprhgtphhtthhopehjlhgrhihtohhnse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegrmhhirhejfehilhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8nbHaJczFZJQGBQMYj-msgFX8AxPXMCxsnVO0nUXHuhysYHfbfg6QQ>
    <xmx:83bHaH4PRE-wWW4ocL8EUw0cvxAQDne298pAxHAPO7RlweFcO_ABAg>
    <xmx:83bHaAuhwrnRtarvs1_6soPiI37uT3Wpr5dFYuIRwxa0wPjHUnsVug>
    <xmx:83bHaHjT_0ZeV3SQhB5g3jji9lbByQsomQ0RsAYmMpaADcykmOX1Cg>
    <xmx:83bHaBLBqIgbZilEFYp8IXF5Diadd1EAFFlRPzXFsbgZoeVcp9QFbyEA>
Feedback-ID: iab3e480c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 14 Sep 2025 22:16:16 -0400 (EDT)
From: NeilBrown <neilb@ownmail.net>
To: "Alexander Viro" <viro@zeniv.linux.org.uk>,
	"Christian Brauner" <brauner@kernel.org>,
	"Amir Goldstein" <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: "Jan Kara" <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 4/6] VFS/audit: introduce kern_path_parent() for audit
Date: Mon, 15 Sep 2025 12:13:44 +1000
Message-ID: <20250915021504.2632889-5-neilb@ownmail.net>
X-Mailer: git-send-email 2.50.0.107.gf914562f5916.dirty
In-Reply-To: <20250915021504.2632889-1-neilb@ownmail.net>
References: <20250915021504.2632889-1-neilb@ownmail.net>
Reply-To: NeilBrown <neil@brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: NeilBrown <neil@brown.name>

audit_alloc_mark() and audit_get_nd() both need to perform a path
lookup getting the parent dentry (which must exist) and the final
target (following a LAST_NORM name) which sometimes doesn't need to
exist.

They don't need the parent to be locked, but use kern_path_locked() or
kern_path_locked_negative() anyway.  This is somewhat misleading to the
casual reader.

This patch introduces a more targeted function, kern_path_parent(),
which returns not holding locks.  On success the "path" will
be set to the parent, which must be found, and the return value is the
dentry of the target, which might be negative.

This will clear the way to rename kern_path_locked() which is
otherwise only used to prepare for removing something.

It also allows us to remove kern_path_locked_negative(), which is
transformed into the new kern_path_parent().

Signed-off-by: NeilBrown <neil@brown.name>
---
 fs/namei.c              | 23 +++++++++++++++++------
 include/linux/namei.h   |  2 +-
 kernel/audit_fsnotify.c | 11 ++++++-----
 kernel/audit_watch.c    |  3 +--
 4 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 180037b96956..4017bc8641d3 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2781,7 +2781,20 @@ static struct dentry *__kern_path_locked(int dfd, struct filename *name, struct
 	return d;
 }
 
-struct dentry *kern_path_locked_negative(const char *name, struct path *path)
+/**
+ * kern_path_parent: lookup path returning parent and target
+ * @name: path name
+ * @path: path to store parent in
+ *
+ * The path @name should end with a normal component, not "." or ".." or "/".
+ * A lookup is performed and if successful the parent information
+ * is store in @parent and the dentry is returned.
+ *
+ * The dentry maybe negative, the parent will be positive.
+ *
+ * Returns:  dentry or error.
+ */
+struct dentry *kern_path_parent(const char *name, struct path *path)
 {
 	struct path parent_path __free(path_put) = {};
 	struct filename *filename __free(putname) = getname_kernel(name);
@@ -2794,12 +2807,10 @@ struct dentry *kern_path_locked_negative(const char *name, struct path *path)
 		return ERR_PTR(error);
 	if (unlikely(type != LAST_NORM))
 		return ERR_PTR(-EINVAL);
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, LOOKUP_CREATE);
-	if (IS_ERR(d)) {
-		inode_unlock(parent_path.dentry->d_inode);
+
+	d = lookup_noperm_unlocked(&last, parent_path.dentry);
+	if (IS_ERR(d))
 		return d;
-	}
 	path->dentry = no_free_ptr(parent_path.dentry);
 	path->mnt = no_free_ptr(parent_path.mnt);
 	return d;
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 551a1a01e5e7..1d5038c21c20 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -57,12 +57,12 @@ struct dentry *lookup_one_qstr_excl(const struct qstr *name,
 				    struct dentry *base,
 				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
+struct dentry *kern_path_parent(const char *name, struct path *parent);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
-extern struct dentry *kern_path_locked_negative(const char *, struct path *);
 extern struct dentry *user_path_locked_at(int , const char __user *, struct path *);
 int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
 			   struct path *parent, struct qstr *last, int *type,
diff --git a/kernel/audit_fsnotify.c b/kernel/audit_fsnotify.c
index c565fbf66ac8..b92805b317a2 100644
--- a/kernel/audit_fsnotify.c
+++ b/kernel/audit_fsnotify.c
@@ -76,17 +76,18 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	struct audit_fsnotify_mark *audit_mark;
 	struct path path;
 	struct dentry *dentry;
-	struct inode *inode;
 	int ret;
 
 	if (pathname[0] != '/' || pathname[len-1] == '/')
 		return ERR_PTR(-EINVAL);
 
-	dentry = kern_path_locked(pathname, &path);
+	dentry = kern_path_parent(pathname, &path);
 	if (IS_ERR(dentry))
 		return ERR_CAST(dentry); /* returning an error */
-	inode = path.dentry->d_inode;
-	inode_unlock(inode);
+	if (d_really_is_negative(dentry)) {
+		audit_mark = ERR_PTR(-ENOENT);
+		goto out;
+	}
 
 	audit_mark = kzalloc(sizeof(*audit_mark), GFP_KERNEL);
 	if (unlikely(!audit_mark)) {
@@ -100,7 +101,7 @@ struct audit_fsnotify_mark *audit_alloc_mark(struct audit_krule *krule, char *pa
 	audit_update_mark(audit_mark, dentry->d_inode);
 	audit_mark->rule = krule;
 
-	ret = fsnotify_add_inode_mark(&audit_mark->mark, inode, 0);
+	ret = fsnotify_add_inode_mark(&audit_mark->mark, path.dentry->d_inode, 0);
 	if (ret < 0) {
 		audit_mark->path = NULL;
 		fsnotify_put_mark(&audit_mark->mark);
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index 0ebbbe37a60f..a700e3c8925f 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -349,7 +349,7 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 {
 	struct dentry *d;
 
-	d = kern_path_locked_negative(watch->path, parent);
+	d = kern_path_parent(watch->path, parent);
 	if (IS_ERR(d))
 		return PTR_ERR(d);
 
@@ -359,7 +359,6 @@ static int audit_get_nd(struct audit_watch *watch, struct path *parent)
 		watch->ino = d_backing_inode(d)->i_ino;
 	}
 
-	inode_unlock(d_backing_inode(parent->dentry));
 	dput(d);
 	return 0;
 }
-- 
2.50.0.107.gf914562f5916.dirty


