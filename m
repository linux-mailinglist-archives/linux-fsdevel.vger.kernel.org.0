Return-Path: <linux-fsdevel+bounces-78690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBIBMu1SoWkfsAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:16:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D781B45A8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 09:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8E19A3051729
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 08:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B280B38B7D1;
	Fri, 27 Feb 2026 08:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b="Cj62H3cT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from e3i670.smtp2go.com (e3i670.smtp2go.com [158.120.86.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C637C0FB
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Feb 2026 08:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.120.86.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772180171; cv=none; b=Ds2YrNd+u6D6TOye36mxuvSiHCTxVC5ViolXvCE+8QoJbjrM+r9xSCCFxYpxDd4iOtR37zk4kFtVFfLMb3ThU6AR2hVWdctGY9zixHA9kSGxFZ9M9eG/wxR5VbI1/S7xv10hsAE/z1L4XM/AyN0bGhUTQeKwD4s5ErP9ozFMn2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772180171; c=relaxed/simple;
	bh=VJzOVm3d+UInNVvJHA3UFeTzICW+bacfZ9dNPm5PZLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7arWUvbkAsJRHy3oMdMnJTJrCHnFpegMGeAOMmqHKzLSCi/c5J47RH8fbcnvzXrKPgXkIKAl8qrhHVNuu2VT/CDwunp6IKzJqjLIjMlM3JZEOdLtGUsHftuDAP9AckUuaq/gJ65/wIZNMcJ5zBCZqN4zKwxDAmuN3ktGRZU9GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt; spf=pass smtp.mailfrom=em510616.triplefau.lt; dkim=pass (2048-bit key) header.d=triplefau.lt header.i=@triplefau.lt header.b=Cj62H3cT; arc=none smtp.client-ip=158.120.86.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=triplefau.lt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em510616.triplefau.lt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=triplefau.lt;
 i=@triplefau.lt; q=dns/txt; s=s510616; t=1772180166; h=from : subject
 : to : message-id : date;
 bh=srBzmYxFdm2Z87VKEA6e9S7JlctVLD7IafBiS0gswbA=;
 b=Cj62H3cTVZubc+PnbrhLt0NzcvWaZBgoQILXy6qESs4au3NdDS/64jEwWmvUay/uDYb3Y
 dfep7QC2SN+sSV759FaTmWcJMYmtA3E9kJvN0O4eal7MpqeyoIY776XMfD4+caAffNJHYUF
 /APmuZ5Ncx96omMDkE/7TGZf6yCaIslPN6ui2dWkVmfMuSilzD2jSk9oGLRSI0vvUYRwooS
 CfxUgZAAxDkwXYl6yxzPWJYvvmUzpuGjSSF6tGB//wknEPQPx3y7Arhvq9D/xrOcTYITfZi
 a3OWZzT1fRIc19P0MuRjO/NxNE0uT83evEtVfgfdAfEQAm7K8pJAWYVmzYLQ==
Received: from [10.12.239.196] (helo=localhost)
	by smtpcorp.com with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.99.1-S2G)
	(envelope-from <repk@triplefau.lt>)
	id 1vvt0z-AIkwcC8lk1Q-GnCM;
	Fri, 27 Feb 2026 08:16:01 +0000
From: Remi Pommarel <repk@triplefau.lt>
To: v9fs@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Remi Pommarel <repk@triplefau.lt>
Subject: [PATCH v3 4/4] 9p: Enable symlink caching in page cache
Date: Fri, 27 Feb 2026 08:56:55 +0100
Message-ID: <c17ddf1cf0b8962407cf023eb18b30c307c44f50.1772178819.git.repk@triplefau.lt>
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
Feedback-ID: 510616m:510616apGKSTK:510616sP6GiIHyuP
X-smtpcorp-track: 8E7mrf5_4MXX.74itNSjH-dv-.bL9D8gh7nlN
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[triplefau.lt,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[triplefau.lt:s=s510616];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78690-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[triplefau.lt:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[repk@triplefau.lt,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 68D781B45A8
X-Rspamd-Action: no action

Currently, when cache=loose is enabled, file reads are cached in the
page cache, but symlink reads are not. This patch allows the results
of p9_client_readlink() to be stored in the page cache, eliminating
the need for repeated 9P transactions on subsequent symlink accesses.

This change improves performance for workloads that involve frequent
symlink resolution.

Signed-off-by: Remi Pommarel <repk@triplefau.lt>
---
 fs/9p/vfs_addr.c       | 29 +++++++++++++++--
 fs/9p/vfs_inode.c      |  6 ++--
 fs/9p/vfs_inode_dotl.c | 72 +++++++++++++++++++++++++++++++++++++-----
 3 files changed, 94 insertions(+), 13 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 862164181bac..0683090a5f15 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -70,10 +70,24 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 {
 	struct netfs_io_request *rreq = subreq->rreq;
 	struct p9_fid *fid = rreq->netfs_priv;
+	char *target;
 	unsigned long long pos = subreq->start + subreq->transferred;
-	int total, err;
-
-	total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	int total, err, len, n;
+
+	if (S_ISLNK(rreq->inode->i_mode)) {
+		/* p9_client_readlink() must not be called for legacy protocols
+		 * 9p2000 or 9p2000.u.
+		 */
+		BUG_ON(!p9_is_proto_dotl(fid->clnt));
+		err = p9_client_readlink(fid, &target);
+		len = strnlen(target, PAGE_SIZE - 1);
+		n = copy_to_iter(target, len, &subreq->io_iter);
+		if (n != len)
+			err = -EFAULT;
+		total = i_size_read(rreq->inode);
+	} else {
+		total = p9_client_read(fid, pos, &subreq->io_iter, &err);
+	}
 
 	/* if we just extended the file size, any portion not in
 	 * cache won't be on server and is zeroes */
@@ -99,6 +113,7 @@ static void v9fs_issue_read(struct netfs_io_subrequest *subreq)
 static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
 	struct p9_fid *fid;
+	struct dentry *dentry;
 	bool writing = (rreq->origin == NETFS_READ_FOR_WRITE ||
 			rreq->origin == NETFS_WRITETHROUGH ||
 			rreq->origin == NETFS_UNBUFFERED_WRITE ||
@@ -115,6 +130,14 @@ static int v9fs_init_request(struct netfs_io_request *rreq, struct file *file)
 		if (!fid)
 			goto no_fid;
 		p9_fid_get(fid);
+	} else if (S_ISLNK(rreq->inode->i_mode)){
+		dentry = d_find_alias(rreq->inode);
+		if (!dentry)
+			goto no_fid;
+		fid = v9fs_fid_lookup(dentry);
+		dput(dentry);
+		if (IS_ERR(fid))
+			goto no_fid;
 	} else {
 		fid = v9fs_fid_find_inode(rreq->inode, writing, INVALID_UID, true);
 		if (!fid)
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index c82db6fe0c39..98644f27d6f1 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -302,10 +302,12 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 			goto error;
 		}
 
-		if (v9fs_proto_dotl(v9ses))
+		if (v9fs_proto_dotl(v9ses)) {
 			inode->i_op = &v9fs_symlink_inode_operations_dotl;
-		else
+			inode_nohighmem(inode);
+		} else {
 			inode->i_op = &v9fs_symlink_inode_operations;
+		}
 
 		break;
 	case S_IFDIR:
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 643e759eacb2..a286a078d6a6 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -686,9 +686,13 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 	int err;
 	kgid_t gid;
 	const unsigned char *name;
+	umode_t mode;
+	struct v9fs_session_info *v9ses;
 	struct p9_qid qid;
 	struct p9_fid *dfid;
 	struct p9_fid *fid = NULL;
+	struct inode *inode;
+	struct posix_acl *dacl = NULL, *pacl = NULL;
 
 	name = dentry->d_name.name;
 	p9_debug(P9_DEBUG_VFS, "%lu,%s,%s\n", dir->i_ino, name, symname);
@@ -702,6 +706,14 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 
 	gid = v9fs_get_fsgid_for_create(dir);
 
+	/* Update mode based on ACL value */
+	err = v9fs_acl_mode(dir, &mode, &dacl, &pacl);
+	if (err) {
+		p9_debug(P9_DEBUG_VFS, "Failed to get acl values in mknod %d\n",
+			 err);
+		goto error;
+	}
+
 	/* Server doesn't alter fid on TSYMLINK. Hence no need to clone it. */
 	err = p9_client_symlink(dfid, name, symname, gid, &qid);
 
@@ -712,8 +724,30 @@ v9fs_vfs_symlink_dotl(struct mnt_idmap *idmap, struct inode *dir,
 
 	v9fs_invalidate_inode_attr(dir);
 
+	/* instantiate inode and assign the unopened fid to the dentry */
+	fid = p9_client_walk(dfid, 1, &name, 1);
+	if (IS_ERR(fid)) {
+		err = PTR_ERR(fid);
+		p9_debug(P9_DEBUG_VFS, "p9_client_walk failed %d\n",
+			 err);
+		goto error;
+	}
+
+	v9ses = v9fs_inode2v9ses(dir);
+	inode = v9fs_get_new_inode_from_fid(v9ses, fid, dir->i_sb);
+	if (IS_ERR(inode)) {
+		err = PTR_ERR(inode);
+		p9_debug(P9_DEBUG_VFS, "inode creation failed %d\n",
+			 err);
+		goto error;
+	}
+	v9fs_set_create_acl(inode, fid, dacl, pacl);
+	v9fs_fid_add(dentry, &fid);
+	d_instantiate(dentry, inode);
+	err = 0;
 error:
 	p9_fid_put(fid);
+	v9fs_put_acl(dacl, pacl);
 	p9_fid_put(dfid);
 	return err;
 }
@@ -853,24 +887,23 @@ v9fs_vfs_mknod_dotl(struct mnt_idmap *idmap, struct inode *dir,
 }
 
 /**
- * v9fs_vfs_get_link_dotl - follow a symlink path
+ * v9fs_vfs_get_link_nocache_dotl - Resolve a symlink directly.
+ *
+ * To be used when symlink caching is not enabled.
+ *
  * @dentry: dentry for symlink
  * @inode: inode for symlink
  * @done: destructor for return value
  */
-
 static const char *
-v9fs_vfs_get_link_dotl(struct dentry *dentry,
-		       struct inode *inode,
-		       struct delayed_call *done)
+v9fs_vfs_get_link_nocache_dotl(struct dentry *dentry,
+			       struct inode *inode,
+			       struct delayed_call *done)
 {
 	struct p9_fid *fid;
 	char *target;
 	int retval;
 
-	if (!dentry)
-		return ERR_PTR(-ECHILD);
-
 	p9_debug(P9_DEBUG_VFS, "%pd\n", dentry);
 
 	fid = v9fs_fid_lookup(dentry);
@@ -884,6 +917,29 @@ v9fs_vfs_get_link_dotl(struct dentry *dentry,
 	return target;
 }
 
+/**
+ * v9fs_vfs_get_link_dotl - follow a symlink path
+ * @dentry: dentry for symlink
+ * @inode: inode for symlink
+ * @done: destructor for return value
+ */
+static const char *
+v9fs_vfs_get_link_dotl(struct dentry *dentry,
+		       struct inode *inode,
+		       struct delayed_call *done)
+{
+	struct v9fs_session_info *v9ses;
+
+	if (!dentry)
+		return ERR_PTR(-ECHILD);
+
+	v9ses = v9fs_inode2v9ses(inode);
+	if (v9ses->cache & (CACHE_META|CACHE_LOOSE))
+		return page_get_link(dentry, inode, done);
+
+	return v9fs_vfs_get_link_nocache_dotl(dentry, inode, done);
+}
+
 int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
 {
 	struct p9_stat_dotl *st;
-- 
2.52.0


