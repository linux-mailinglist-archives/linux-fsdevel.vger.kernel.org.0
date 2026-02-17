Return-Path: <linux-fsdevel+bounces-77405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFQfKU/ilGlqIgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77405-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:49:03 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50508150F4E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 22:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C04BD3040ABC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 21:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59502FB616;
	Tue, 17 Feb 2026 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACVk7zGO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5B2F5308;
	Tue, 17 Feb 2026 21:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771364869; cv=none; b=bo9cPQJWoRpECuVr7moUp7ojoY+NksRRmNRyOkDTUUixwuKf7lpZ/Sg1bcpp0jW6ZAO7uDj5JAY/Ii1ZqhROdpeeHxWkb6+W6IVyvLe105XV6eyk36tCysVEBG5vWju0Othspd8v/UgqZWcG4zmj1lxt28WZOV1FDni7KQHGVxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771364869; c=relaxed/simple;
	bh=LctAiSd9BeDNjjjmUFC0gRSRPzBQHPUhz2MMJP2LiZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jESqOKCltqV5eDiKXWrqQmBMgArQl6U0aa/6O1ybxldzcsBwJ7K1o9mPe3u2vTREYuD3ZEBwtqpkmIfU8hK2LS/IKOcHgGkbsYCC2HBq9MzRJOPKb/Oa5oS8WGYZA1MzbWiwoSksF34rcsjAz1Ag6lXxJy4mHoYU/9hp2iJFB6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACVk7zGO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4A2C19421;
	Tue, 17 Feb 2026 21:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771364868;
	bh=LctAiSd9BeDNjjjmUFC0gRSRPzBQHPUhz2MMJP2LiZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ACVk7zGO8Dvjx8+P4M4/0bzCltWT475XNNKSF6yfMizGEZZgP//NxuF4Cb+eRrosZ
	 pJA2vtZNd9TvSzcMuXg3ghwDJHyvFGUZcVescGoarZpyQV1r9mOSl79rlbHvBBfDyB
	 Cc/J6x62SFD6ufA7WFHs9uQVScYU7wbIZ8C30vGIsYXgMv0eIz8E0YFfiUg84KQMnT
	 50RhjiOPfJ4fymbO8V5Apyr3qcrn4LhY3UPg9X5JFPj/i3Vr3X8FdYyF+wqpZOEWfP
	 FiyONdpkAkAfZevczJhlYl7XzAj0VQEb4cg5BlXLcgnSlil2/91cHl74i5G5DdTzyP
	 jvLmt1WWdpvIA==
From: Chuck Lever <cel@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	sj1557.seo@samsung.com,
	yuezhang.mo@sony.com,
	almaz.alexandrovich@paragon-software.com,
	slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	cem@kernel.org,
	sfrench@samba.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	trondmy@kernel.org,
	anna@kernel.org,
	jaegeuk@kernel.org,
	chao@kernel.org,
	hansg@kernel.org,
	senozhatsky@chromium.org,
	Chuck Lever <chuck.lever@oracle.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v8 01/17] fs: Move file_kattr initialization to callers
Date: Tue, 17 Feb 2026 16:47:25 -0500
Message-ID: <20260217214741.1928576-2-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217214741.1928576-1-cel@kernel.org>
References: <20260217214741.1928576-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.sourceforge.net,mail.parknet.co.jp,kernel.org,samsung.com,sony.com,paragon-software.com,dubeyko.com,physik.fu-berlin.de,vivo.com,mit.edu,dilger.ca,samba.org,manguebit.org,gmail.com,microsoft.com,chromium.org,oracle.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-77405-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 50508150F4E
X-Rspamd-Action: no action

From: Chuck Lever <chuck.lever@oracle.com>

fileattr_fill_xflags() and fileattr_fill_flags() zero the entire
file_kattr struct before populating select fields. This behavior
prevents callers from setting flags in fa->fsx_xflags before
calling these helpers; the zeroing clears any pre-set values.

As Darrick Wong observed, when a function named "fill_xflags"
modifies more than just xflags, filesystems must understand
implementation details beyond the function's apparent scope. When
initialization occurs at entry points, helper functions need not
duplicate that zeroing.

Move struct file_kattr zero-initialization from the fill functions
to their callers. Entry points such as ioctl_setflags(),
ioctl_fssetxattr(), and the file_getattr/file_setattr syscalls
now perform aggregate initialization directly. The fill functions
retain their field-setting logic but no longer clear the struct.

This change enables subsequent patches where filesystem
->fileattr_get() handlers can set case-sensitivity flags
(FS_XFLAG_CASEFOLD, FS_XFLAG_CASENONPRESERVING) in fa->fsx_xflags
before calling the fill functions.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/file_attr.c     | 14 +++++---------
 fs/xfs/xfs_ioctl.c |  2 +-
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 6d2a298a786d..42aa511111a0 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -15,12 +15,10 @@
  * @fa:		fileattr pointer
  * @xflags:	FS_XFLAG_* flags
  *
- * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).  All
- * other fields are zeroed.
+ * Set ->fsx_xflags, ->fsx_valid and ->flags (translated xflags).
  */
 void fileattr_fill_xflags(struct file_kattr *fa, u32 xflags)
 {
-	memset(fa, 0, sizeof(*fa));
 	fa->fsx_valid = true;
 	fa->fsx_xflags = xflags;
 	if (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)
@@ -48,11 +46,9 @@ EXPORT_SYMBOL(fileattr_fill_xflags);
  * @flags:	FS_*_FL flags
  *
  * Set ->flags, ->flags_valid and ->fsx_xflags (translated flags).
- * All other fields are zeroed.
  */
 void fileattr_fill_flags(struct file_kattr *fa, u32 flags)
 {
-	memset(fa, 0, sizeof(*fa));
 	fa->flags_valid = true;
 	fa->flags = flags;
 	if (fa->flags & FS_SYNC_FL)
@@ -325,7 +321,7 @@ int ioctl_setflags(struct file *file, unsigned int __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	unsigned int flags;
 	int err;
 
@@ -357,7 +353,7 @@ int ioctl_fssetxattr(struct file *file, void __user *argp)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct dentry *dentry = file->f_path.dentry;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int err;
 
 	err = copy_fsxattr_from_user(&fa, argp);
@@ -378,7 +374,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	struct path filepath __free(path_put) = {};
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
@@ -431,7 +427,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 	struct path filepath __free(path_put) = {};
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = {};
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 4eeda4d4e3ab..369555275140 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -498,7 +498,7 @@ xfs_ioc_fsgetxattra(
 	xfs_inode_t		*ip,
 	void			__user *arg)
 {
-	struct file_kattr	fa;
+	struct file_kattr	fa = {};
 
 	xfs_ilock(ip, XFS_ILOCK_SHARED);
 	xfs_fill_fsxattr(ip, XFS_ATTR_FORK, &fa);
-- 
2.53.0


