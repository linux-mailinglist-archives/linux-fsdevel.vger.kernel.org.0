Return-Path: <linux-fsdevel+bounces-78688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOq/GvZSoWkfsAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:16:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D88671B45AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1327E3090FE4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F62347FC0;
	Fri, 27 Feb 2026 08:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="SCyTXJGz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e3i670.smtp2go.com (e3i670.smtp2go.com [158.120.86.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CBC284B3B
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180162; cv=none; b=AX/uyEsbxxF7hKVnMWZ5XDxAx0D1Ch3WND21ld2N0SdVzIG3owqHD9a1ijB8vTMh2U7vwSpEe5VPHtQAgVvD7lI8Z8bqnHiYB+5/3UhhgOOcvFWIH9wdjbNBjI6FExaFbMrP9fFLFUDYowzKAom8BvRwo/BHRHBtRJKvW3fRxQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180162; c=relaxed/simple;
	bh=ynWBbuGP/koaH7WRe8R9sSGfvcwCMNK/dsbPn/tzbvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AfOYFm2TIyeixVvlLN/Pzgsgv9/Q8W7UCbAm4F9Kql+C6Xsxk/iPmWty4Qk59tzot5E8nEKdN5VvOg1DEdAkMY6vc1+HsYnzMKHhGeyIp2wZ8TLJttNAA402IgjNAu5eApNyeEPp17Ca6kPUIdNx3x2iPQci6THTVq86z3aNbgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=SCyTXJGz; arc=none smtp.client-ip=158.120.86.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1772180158; h=from : subject
 : to : message-id : date;
 bh=Ki6Xgur5y/H6e0WK6nXljJwnOvj1cuP0OcNeJN2NSSA=;
 b=SCyTXJGzO6EHy1F1DKo6/eSxstKcU1lPx8U6hzjB+PJRkInsSv/YRE9g57+y9wUj5qtjw
 ghwltpAegpsd1xYVFrM225WCS4sl+SshEWrjvWYbyeqpzausXRV024pPv5N2k4JpCVNrd6a
 uQD4cSiJTawDXYTYSp4CqGrNOI8P1yQtKlIx8u3OjkUcZAcwjVu1GraR3fsCIIHZSz0NQCH
 kkD7CyQ8Cd2N5ZUijepQX58UMpolK0LKoJb31lVvEc38JJ8NNKlTqsK63zbLh3j8lZWFUgU
 H2DtA0pJCNfDQHUvleBJPmuJuWo5eRUu/4u/6qsQO/3Qve4s/D5aahcAzplQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vvt0u-FnQW0hPlFjm-moPK;
	Fri, 27 Feb 2026 08:15:56 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 1/4] 9p: Cache negative dentries for lookup performance
Date: Fri, 27 Feb 2026 08:56:52 +0100
Message-ID: <c2b00b0230b49561915d416a2183691ed82f4923.1772178819.git.repk@triplefau.lt>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1772178819.git.repk@triplefau.lt>
References: <cover.1772178819.git.repk@triplefau.lt>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers, to <abuse-report@smtp2go.com>
Feedback-ID: 510616m:510616apGKSTK:510616snj1IPvPwx
X-smtpcorp-track: OpsaKJPCokST.s9r0ta4njv8C.bKVOdAKhyi4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78688-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D88671B45AF
X-Rspamd-Action: no action

Not caching negative dentries can result in poor performance for
workloads that repeatedly look up non-existent paths. Each such
lookup triggers a full 9P transaction with the server, adding
unnecessary overhead.

A typical example is source compilation, where multiple cc1 processes
are spawned and repeatedly search for the same missing header files
over and over again.

This change enables caching of negative dentries, so that lookups for
known non-existent paths do not require a full 9P transaction. The
cached negative dentries are retained for a configurable duration
(expressed in milliseconds), as specified by the ndentry_timeout
field in struct v9fs_session_info. If set to -1, negative dentries
are cached indefinitely.

This optimization reduces lookup overhead and improves performance for
workloads involving frequent access to non-existent paths.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/fid.c             |  11 +++--
 fs/9p/v9fs.c            |   1 +
 fs/9p/v9fs.h            |   5 ++
 fs/9p/v9fs_vfs.h        |  15 ++++++
 fs/9p/vfs_dentry.c      | 105 ++++++++++++++++++++++++++++++++++------
 fs/9p/vfs_inode.c       |  12 +++--
 fs/9p/vfs_super.c       |   1 +
 include/net/9p/client.h |   2 +
 8 files changed, 128 insertions(+), 24 deletions(-)

diff --git a/fs/9p/fid.c b/fs/9p/fid.c
index f84412290a30..76242d450aa7 100644
--- a/fs/9p/fid.c
+++ b/fs/9p/fid.c
@@ -20,7 +20,9 @@
 
 static inline void __add_fid(struct dentry *dentry, struct p9_fid *fid)
 {
-	hlist_add_head(&fid->dlist, (struct hlist_head *)&dentry->d_fsdata);
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	hlist_add_head(&fid->dlist, &v9fs_dentry->head);
 }
 
 
@@ -112,6 +114,7 @@ void v9fs_open_fid_add(struct inode *inode, struct p9_fid **pfid)
 
 static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 {
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
 	struct p9_fid *fid, *ret;
 
 	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p) uid %d any %d\n",
@@ -119,11 +122,9 @@ static struct p9_fid *v9fs_fid_find(struct dentry *dentry, kuid_t uid, int any)
 		 any);
 	ret = NULL;
 	/* we'll recheck under lock if there's anything to look in */
-	if (dentry->d_fsdata) {
-		struct hlist_head *h = (struct hlist_head *)&dentry->d_fsdata;
-
+	if (!hlist_empty(&v9fs_dentry->head)) {
 		spin_lock(&dentry->d_lock);
-		hlist_for_each_entry(fid, h, dlist) {
+		hlist_for_each_entry(fid, &v9fs_dentry->head, dlist) {
 			if (any || uid_eq(fid->uid, uid)) {
 				ret = fid;
 				p9_fid_get(ret);
diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 057487efaaeb..c5dca81a553e 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -422,6 +422,7 @@ static void v9fs_apply_options(struct v9fs_session_info *v9ses,
 	v9ses->cache = ctx->session_opts.cache;
 	v9ses->uid = ctx->session_opts.uid;
 	v9ses->session_lock_timeout = ctx->session_opts.session_lock_timeout;
+	v9ses->ndentry_timeout_ms = ctx->session_opts.ndentry_timeout_ms;
 }
 
 /**
diff --git a/fs/9p/v9fs.h b/fs/9p/v9fs.h
index 6a12445d3858..8410f7883109 100644
--- a/fs/9p/v9fs.h
+++ b/fs/9p/v9fs.h
@@ -91,6 +91,7 @@ enum p9_cache_bits {
  * @debug: debug level
  * @afid: authentication handle
  * @cache: cache mode of type &p9_cache_bits
+ * @ndentry_timeout: Negative dentry lookup cache retention time in ms
  * @cachetag: the tag of the cache associated with this session
  * @fscache: session cookie associated with FS-Cache
  * @uname: string user name to mount hierarchy as
@@ -101,6 +102,7 @@ enum p9_cache_bits {
  * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the hierarchy
  * @clnt: reference to 9P network client instantiated for this session
  * @slist: reference to list of registered 9p sessions
+ * @ndentry_timeout_ms: Negative dentry caching retention time
  *
  * This structure holds state for each session instance established during
  * a sys_mount() .
@@ -116,6 +118,7 @@ struct v9fs_session_info {
 	unsigned short debug;
 	unsigned int afid;
 	unsigned int cache;
+	unsigned int ndentry_timeout_ms;
 #ifdef CONFIG_9P_FSCACHE
 	char *cachetag;
 	struct fscache_volume *fscache;
@@ -133,6 +136,8 @@ struct v9fs_session_info {
 	long session_lock_timeout; /* retry interval for blocking locks */
 };
 
+#define NDENTRY_TMOUT_NEVER (-1U)
+
 /* cache_validity flags */
 #define V9FS_INO_INVALID_ATTR 0x01
 
diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index d3aefbec4de6..83c2335f438d 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -28,6 +28,19 @@
 /* flags for v9fs_stat2inode() & v9fs_stat2inode_dotl() */
 #define V9FS_STAT2INODE_KEEP_ISIZE 1
 
+/**
+ * struct v9fs_dentry - v9fs specific dentry data
+ * @head: List of fid associated with this dentry
+ * @expire_time: Lookup cache expiration time for negative dentries
+ * @rcu: used by kfree_rcu to schedule clean up job
+ */
+struct v9fs_dentry {
+	struct hlist_head head;
+	u64 expire_time;
+	struct rcu_head rcu;
+};
+#define to_v9fs_dentry(d) ((struct v9fs_dentry *)((d)->d_fsdata))
+
 extern struct file_system_type v9fs_fs_type;
 extern const struct address_space_operations v9fs_addr_operations;
 extern const struct file_operations v9fs_file_operations;
@@ -35,6 +48,8 @@ extern const struct file_operations v9fs_file_operations_dotl;
 extern const struct file_operations v9fs_dir_operations;
 extern const struct file_operations v9fs_dir_operations_dotl;
 extern const struct dentry_operations v9fs_dentry_operations;
+extern void v9fs_ndentry_refresh_timeout(struct dentry *dentry);
+extern void v9fs_dentry_fid_remove(struct dentry *dentry);
 extern const struct dentry_operations v9fs_cached_dentry_operations;
 extern struct kmem_cache *v9fs_inode_cache;
 
diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
index c5bf74d547e8..5a900d3cef89 100644
--- a/fs/9p/vfs_dentry.c
+++ b/fs/9p/vfs_dentry.c
@@ -23,6 +23,46 @@
 #include "v9fs_vfs.h"
 #include "fid.h"
 
+/**
+ * v9fs_ndentry_is_expired - Check if negative dentry lookup has expired
+ *
+ * This should be called to know if a negative dentry should be removed from
+ * cache.
+ *
+ * @dentry: dentry in question
+ *
+ */
+static bool v9fs_ndentry_is_expired(struct dentry const *dentry)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	if (v9ses->ndentry_timeout_ms == NDENTRY_TMOUT_NEVER)
+		return false;
+
+	return time_before_eq64(v9fs_dentry->expire_time, get_jiffies_64());
+}
+
+/**
+ * v9fs_ndentry_refresh_timeout - Refresh negative dentry lookup cache timeout
+ *
+ * This should be called when a look up yields a negative entry.
+ *
+ * @dentry: dentry in question
+ *
+ */
+void v9fs_ndentry_refresh_timeout(struct dentry *dentry)
+{
+	struct v9fs_session_info *v9ses = v9fs_dentry2v9ses(dentry);
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	if (v9ses->ndentry_timeout_ms == NDENTRY_TMOUT_NEVER)
+		return;
+
+	v9fs_dentry->expire_time = get_jiffies_64() +
+				   msecs_to_jiffies(v9ses->ndentry_timeout_ms);
+}
+
 /**
  * v9fs_cached_dentry_delete - called when dentry refcount equals 0
  * @dentry:  dentry in question
@@ -33,20 +73,15 @@ static int v9fs_cached_dentry_delete(const struct dentry *dentry)
 	p9_debug(P9_DEBUG_VFS, " dentry: %pd (%p)\n",
 		 dentry, dentry);
 
-	/* Don't cache negative dentries */
-	if (d_really_is_negative(dentry))
-		return 1;
-	return 0;
-}
+	if (!d_really_is_negative(dentry))
+		return 0;
 
-/**
- * v9fs_dentry_release - called when dentry is going to be freed
- * @dentry:  dentry that is being release
- *
- */
+	return v9fs_ndentry_is_expired(dentry);
+}
 
-static void v9fs_dentry_release(struct dentry *dentry)
+static void __v9fs_dentry_fid_remove(struct dentry *dentry)
 {
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
 	struct hlist_node *p, *n;
 	struct hlist_head head;
 
@@ -54,13 +89,54 @@ static void v9fs_dentry_release(struct dentry *dentry)
 		 dentry, dentry);
 
 	spin_lock(&dentry->d_lock);
-	hlist_move_list((struct hlist_head *)&dentry->d_fsdata, &head);
+	hlist_move_list(&v9fs_dentry->head, &head);
 	spin_unlock(&dentry->d_lock);
 
 	hlist_for_each_safe(p, n, &head)
 		p9_fid_put(hlist_entry(p, struct p9_fid, dlist));
 }
 
+/**
+ * v9fs_dentry_fid_remove - Release all dentry's fids
+ * @dentry: dentry in question
+ *
+ */
+void v9fs_dentry_fid_remove(struct dentry *dentry)
+{
+	__v9fs_dentry_fid_remove(dentry);
+}
+
+/**
+ * v9fs_dentry_init - Initialize v9fs dentry data
+ * @dentry: dentry in question
+ *
+ */
+static int v9fs_dentry_init(struct dentry *dentry)
+{
+	struct v9fs_dentry *v9fs_dentry = kzalloc(sizeof(*v9fs_dentry),
+						  GFP_KERNEL);
+
+	if (!v9fs_dentry)
+		return -ENOMEM;
+
+	INIT_HLIST_HEAD(&v9fs_dentry->head);
+	dentry->d_fsdata = (void *)v9fs_dentry;
+	return 0;
+}
+
+/**
+ * v9fs_dentry_release - called when dentry is going to be freed
+ * @dentry:  dentry that is being released
+ *
+ */
+static void v9fs_dentry_release(struct dentry *dentry)
+{
+	struct v9fs_dentry *v9fs_dentry = to_v9fs_dentry(dentry);
+
+	__v9fs_dentry_fid_remove(dentry);
+	kfree_rcu(v9fs_dentry, rcu);
+}
+
 static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 {
 	struct p9_fid *fid;
@@ -72,7 +148,7 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 
 	inode = d_inode(dentry);
 	if (!inode)
-		goto out_valid;
+		return !v9fs_ndentry_is_expired(dentry);
 
 	v9inode = V9FS_I(inode);
 	if (v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
@@ -112,7 +188,6 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
 			return retval;
 		}
 	}
-out_valid:
 	p9_debug(P9_DEBUG_VFS, "dentry: %pd (%p) is valid\n", dentry, dentry);
 	return 1;
 }
@@ -139,12 +214,14 @@ const struct dentry_operations v9fs_cached_dentry_operations = {
 	.d_revalidate = v9fs_lookup_revalidate,
 	.d_weak_revalidate = __v9fs_lookup_revalidate,
 	.d_delete = v9fs_cached_dentry_delete,
+	.d_init = v9fs_dentry_init,
 	.d_release = v9fs_dentry_release,
 	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
 	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
 };
 
 const struct dentry_operations v9fs_dentry_operations = {
+	.d_init = v9fs_dentry_init,
 	.d_release = v9fs_dentry_release,
 	.d_unalias_trylock = v9fs_dentry_unalias_trylock,
 	.d_unalias_unlock = v9fs_dentry_unalias_unlock,
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 97abe65bf7c1..c82db6fe0c39 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -549,7 +549,7 @@ static int v9fs_remove(struct inode *dir, struct dentry *dentry, int flags)
 
 		/* invalidate all fids associated with dentry */
 		/* NOTE: This will not include open fids */
-		dentry->d_op->d_release(dentry);
+		v9fs_dentry_fid_remove(dentry);
 	}
 	return retval;
 }
@@ -732,14 +732,16 @@ struct dentry *v9fs_vfs_lookup(struct inode *dir, struct dentry *dentry,
 	name = dentry->d_name.name;
 	fid = p9_client_walk(dfid, 1, &name, 1);
 	p9_fid_put(dfid);
-	if (fid == ERR_PTR(-ENOENT))
+	if (fid == ERR_PTR(-ENOENT)) {
 		inode = NULL;
-	else if (IS_ERR(fid))
+		v9fs_ndentry_refresh_timeout(dentry);
+	} else if (IS_ERR(fid)) {
 		inode = ERR_CAST(fid);
-	else if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+	} else if (v9ses->cache & (CACHE_META|CACHE_LOOSE)) {
 		inode = v9fs_get_inode_from_fid(v9ses, fid, dir->i_sb);
-	else
+	} else {
 		inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	}
 	/*
 	 * If we had a rename on the server and a parallel lookup
 	 * for the new name, then make sure we instantiate with
diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 0a1c4f7cb001..3b2a906528cd 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -327,6 +327,7 @@ static int v9fs_init_fs_context(struct fs_context *fc)
 	ctx->session_opts.uid = INVALID_UID;
 	ctx->session_opts.dfltuid = V9FS_DEFUID;
 	ctx->session_opts.dfltgid = V9FS_DEFGID;
+	ctx->session_opts.ndentry_timeout_ms = 0;
 
 	/* initialize client options */
 	ctx->client_opts.proto_version = p9_proto_2000L;
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index 838a94218b59..55c6cb54bd25 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -192,6 +192,7 @@ struct p9_rdma_opts {
  * @dfltgid: default numeric groupid to mount hierarchy as
  * @uid: if %V9FS_ACCESS_SINGLE, the numeric uid which mounted the hierarchy
  * @session_lock_timeout: retry interval for blocking locks
+ * @ndentry_timeout_ms: Negative dentry lookup cache retention time in ms
  *
  * This strucure holds options which are parsed and will be transferred
  * to the v9fs_session_info structure when mounted, and therefore largely
@@ -203,6 +204,7 @@ struct p9_session_opts {
 	unsigned short debug;
 	unsigned int afid;
 	unsigned int cache;
+	unsigned int ndentry_timeout_ms;
 #ifdef CONFIG_9P_FSCACHE
 	char *cachetag;
 #endif
-- 
2.52.0


