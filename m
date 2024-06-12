Return-Path: <linux-fsdevel+bounces-21494-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D639048BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 04:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC961F231C0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jun 2024 02:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF44B6FB2;
	Wed, 12 Jun 2024 02:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sOJf4R4b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UCpoGaeG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sOJf4R4b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UCpoGaeG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB9A23A6;
	Wed, 12 Jun 2024 02:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157922; cv=none; b=ECMEPSkzJe1apSB7XY61r+wRaiLFJiqrDQD0FKvviBMNxuiUCYQZ3D3DSoEbAGZMHM4Z1Hc6EblWGcwLOF5aPE3gQ4r6/fbJilBRFzlmSaAljd1NFvMVode9JAcXz2NKKBlO7043QMx38bYag01E5Gv2SfIGWjVrGD7IBovB6bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157922; c=relaxed/simple;
	bh=Mum+qm7GtdoUKeBg3LBwrHGGRIPokdwMBt8qOoewaJ4=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=HTUy4laIac+P1bLklNXolWP5sjtM+3WsYFSv8T8c13vErMjI87m79dS/VSPwS8Vva8ooAoTPNfbjEXUmIfBUJBrQOBILCMoA/F9yc9R4435skWNpvffq+cM6ohDaPC66vthMUKH7DYEKG3Pj8u2tcpDB9krxj9UCLXKRhZeK99I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sOJf4R4b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UCpoGaeG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sOJf4R4b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UCpoGaeG; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B2C920DD4;
	Wed, 12 Jun 2024 02:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718157918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K/0OakpSlCQtQslkD2QJx6C1Jl2BBYj8HYQ/y0YHZAk=;
	b=sOJf4R4bJIN8Ow4VCOl2Dax7xXurTL8FrEpYKU3usMTtVsPWPcovu5ze3vkXHC30p+G8bR
	pGR6IEQ25Wift5g+T4YlVhDdi429XsGCyyBO1KankMH+VXuq4Dc1ZKNEOx/IS87O66PUwU
	LRAEYtLCUde7eJQO4VqmUnK4/pUouEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718157918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K/0OakpSlCQtQslkD2QJx6C1Jl2BBYj8HYQ/y0YHZAk=;
	b=UCpoGaeG/mPX/Bs748g8hMLVDE7phucUzVrTMDh8o8YDEaVDGxLEmldwnF9T2sqzhiqAif
	CfrjsOwhH8z8JtAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sOJf4R4b;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UCpoGaeG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718157918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K/0OakpSlCQtQslkD2QJx6C1Jl2BBYj8HYQ/y0YHZAk=;
	b=sOJf4R4bJIN8Ow4VCOl2Dax7xXurTL8FrEpYKU3usMTtVsPWPcovu5ze3vkXHC30p+G8bR
	pGR6IEQ25Wift5g+T4YlVhDdi429XsGCyyBO1KankMH+VXuq4Dc1ZKNEOx/IS87O66PUwU
	LRAEYtLCUde7eJQO4VqmUnK4/pUouEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718157918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K/0OakpSlCQtQslkD2QJx6C1Jl2BBYj8HYQ/y0YHZAk=;
	b=UCpoGaeG/mPX/Bs748g8hMLVDE7phucUzVrTMDh8o8YDEaVDGxLEmldwnF9T2sqzhiqAif
	CfrjsOwhH8z8JtAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D368013AA4;
	Wed, 12 Jun 2024 02:05:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8ja8HVoCaWbLfQAAD6G6ig
	(envelope-from <neilb@suse.de>); Wed, 12 Jun 2024 02:05:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>, James Clark <james.clark@arm.com>,
 ltp@lists.linux.it, linux-nfs@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject:
 [PATCH] VFS: generate FS_CREATE before FS_OPEN when ->atomic_open used.
Date: Wed, 12 Jun 2024 12:05:11 +1000
Message-id: <171815791109.14261.10223988071271993465@noble.neil.brown.name>
X-Spamd-Result: default: False [-6.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,arm.com,lists.linux.it,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8B2C920DD4
X-Spam-Flag: NO
X-Spam-Score: -6.51
X-Spam-Level: 


When a file is opened and created with open(..., O_CREAT) we get
both the CREATE and OPEN fsnotify events and would expect them in that
order.   For most filesystems we get them in that order because
open_last_lookups() calls fsnofify_create() and then do_open() (from
path_openat()) calls vfs_open()->do_dentry_open() which calls
fsnotify_open().

However when ->atomic_open is used, the
   do_dentry_open() -> fsnotify_open()
call happens from finish_open() which is called from the ->atomic_open
handler in lookup_open() which is called *before* open_last_lookups()
calls fsnotify_create().  So we get the "open" notification before
"create" - which is backwards.  ltp testcase inotify02 tests this and
reports the inconsistency.

This patch lifts the fsnotify_open() call out of do_dentry_open() and
places it higher up the call stack.  There are three callers of
do_dentry_open().

For vfs_open() and kernel_file_open() the fsnotify_open() is placed
directly in that caller so there should be no behavioural change.

For finish_open() there are three cases:
 - finish_open is used in ->atomic_open handlers.  For these we add a
   call to fsnotify_open() in do_open() if FMODE_OPENED is set - which
   means do_dentry_open() has been called. This happens after fsnotify_create=
().
 - finish_open is used in ->tmpfile() handlers.  For these a call to
   fsnotify_open() is added to vfs_tmpfile()
 - finish_open is used in gfs2_create_inode() which is used for
   atomic_open, but also for gfs2_create() which is a ->create handler
   and is not expected to open the file.  So losing the fsnotify_open()
   call in this case seems correct.

With this patch NFSv3 is restored to its previous behaviour (before
->atomic_open support was added) of generating CREATE notifications
before OPEN, and NFSv4 now has that same correct ordering that is has
not had before.  I haven't tested other filesystems.

Fixes: 7c6c5249f061 ("NFS: add atomic_open for NFSv3 to handle O_TRUNC correc=
tly.")
Reported-by: James Clark <james.clark@arm.com>
Closes: https://lore.kernel.org/all/01c3bf2e-eb1f-4b7f-a54f-d2a05dd3d8c8@arm.=
com
Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/namei.c |  9 +++++++--
 fs/open.c  | 19 ++++++++++++-------
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 37fb0a8aa09a..32031feaf6b6 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3646,8 +3646,12 @@ static int do_open(struct nameidata *nd,
 		do_truncate =3D true;
 	}
 	error =3D may_open(idmap, &nd->path, acc_mode, open_flag);
-	if (!error && !(file->f_mode & FMODE_OPENED))
-		error =3D vfs_open(&nd->path, file);
+	if (!error) {
+		if (file->f_mode & FMODE_OPENED)
+			fsnotify_open(file);
+		else
+			error =3D vfs_open(&nd->path, file);
+	}
 	if (!error)
 		error =3D security_file_post_open(file, op->acc_mode);
 	if (!error && do_truncate)
@@ -3706,6 +3710,7 @@ int vfs_tmpfile(struct mnt_idmap *idmap,
 	error =3D may_open(idmap, &file->f_path, 0, file->f_flags);
 	if (error)
 		return error;
+	fsnotify_open(file);
 	inode =3D file_inode(file);
 	if (!(open_flag & O_EXCL)) {
 		spin_lock(&inode->i_lock);
diff --git a/fs/open.c b/fs/open.c
index 89cafb572061..970f299c0e77 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1004,11 +1004,6 @@ static int do_dentry_open(struct file *f,
 		}
 	}
=20
-	/*
-	 * Once we return a file with FMODE_OPENED, __fput() will call
-	 * fsnotify_close(), so we need fsnotify_open() here for symmetry.
-	 */
-	fsnotify_open(f);
 	return 0;
=20
 cleanup_all:
@@ -1085,8 +1080,17 @@ EXPORT_SYMBOL(file_path);
  */
 int vfs_open(const struct path *path, struct file *file)
 {
+	int ret;
+
 	file->f_path =3D *path;
-	return do_dentry_open(file, NULL);
+	ret =3D do_dentry_open(file, NULL);
+	if (!ret)
+		/*
+		 * Once we return a file with FMODE_OPENED, __fput() will call
+		 * fsnotify_close(), so we need fsnotify_open() here for symmetry.
+		 */
+		fsnotify_open(file);
+	return ret;
 }
=20
 struct file *dentry_open(const struct path *path, int flags,
@@ -1178,7 +1182,8 @@ struct file *kernel_file_open(const struct path *path, =
int flags,
 	if (error) {
 		fput(f);
 		f =3D ERR_PTR(error);
-	}
+	} else
+		fsnotify_open(f);
 	return f;
 }
 EXPORT_SYMBOL_GPL(kernel_file_open);
--=20
2.44.0


