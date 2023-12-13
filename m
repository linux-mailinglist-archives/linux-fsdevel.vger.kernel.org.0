Return-Path: <linux-fsdevel+bounces-6020-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 980D5812354
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Dec 2023 00:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427771F218B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 23:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23FD83B09;
	Wed, 13 Dec 2023 23:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DTcCefQy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0keUagkY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DTcCefQy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0keUagkY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0938B1FC8;
	Wed, 13 Dec 2023 15:40:44 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1ED091F78D;
	Wed, 13 Dec 2023 23:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702510841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9VmviNzu9Vwca8703AouDgcma1pNK0L4pW+RXROQG0=;
	b=DTcCefQyx55pwmL2mGR0MioA8apjC56cyXfk2vmBVnRWw8plloJ0H4aRv8Zg7A1QvuGiLg
	E0Fn5HfJ+IryBDFwP0A9mNQ9lhHGYUS8fMTMYKi+B4dihu2p5WGw3i7zhs7mJnUDOzAzvs
	5jZ2h+QV2B/BPn9bN4XYiaFv7DxDIso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702510841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9VmviNzu9Vwca8703AouDgcma1pNK0L4pW+RXROQG0=;
	b=0keUagkY9BeVDBral8DE309qVmkAahULA87OHFvpChAXnthK972UkaI1+BHl+zBK7/+UC0
	fVmasfbAKqkKkFAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1702510841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9VmviNzu9Vwca8703AouDgcma1pNK0L4pW+RXROQG0=;
	b=DTcCefQyx55pwmL2mGR0MioA8apjC56cyXfk2vmBVnRWw8plloJ0H4aRv8Zg7A1QvuGiLg
	E0Fn5HfJ+IryBDFwP0A9mNQ9lhHGYUS8fMTMYKi+B4dihu2p5WGw3i7zhs7mJnUDOzAzvs
	5jZ2h+QV2B/BPn9bN4XYiaFv7DxDIso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1702510841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9VmviNzu9Vwca8703AouDgcma1pNK0L4pW+RXROQG0=;
	b=0keUagkY9BeVDBral8DE309qVmkAahULA87OHFvpChAXnthK972UkaI1+BHl+zBK7/+UC0
	fVmasfbAKqkKkFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF3271377F;
	Wed, 13 Dec 2023 23:40:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iYN9LPhAemVhPgAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 13 Dec 2023 23:40:40 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk,
	ebiggers@kernel.org,
	jaegeuk@kernel.org,
	tytso@mit.edu
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Gabriel Krisman Bertazi <krisman@suse.de>
Subject: [PATCH 1/8] dcache: Add helper to disable d_revalidate for a specific dentry
Date: Wed, 13 Dec 2023 18:40:24 -0500
Message-ID: <20231213234031.1081-2-krisman@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213234031.1081-1-krisman@suse.de>
References: <20231213234031.1081-1-krisman@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]

Case-insensitive wants d_compare/d_hash for every dentry in the
filesystem, while fscrypt needs d_revalidate only for DCACHE_NOKEY_NAME.
This means we currently can't use sb->s_d_op to set case-insensitive
hooks in fscrypt+case-insensitive filesystems without paying the cost to
call d_revalidate for every dentry in the filesystem.

In preparation to doing exactly that, add a way to disable d_revalidate
later.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
---
 fs/dcache.c            | 10 ++++++++++
 include/linux/dcache.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index c82ae731df9a..1f5464cd3bd1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1911,6 +1911,16 @@ struct dentry *d_alloc_name(struct dentry *parent, const char *name)
 }
 EXPORT_SYMBOL(d_alloc_name);
 
+void d_set_always_valid(struct dentry *dentry)
+{
+	if (!(dentry->d_flags & DCACHE_OP_REVALIDATE))
+		return;
+
+	spin_lock(&dentry->d_lock);
+	dentry->d_flags &= ~DCACHE_OP_REVALIDATE;
+	spin_unlock(&dentry->d_lock);
+}
+
 void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op)
 {
 	WARN_ON_ONCE(dentry->d_op);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 3da2f0545d5d..d2ce151b2d8e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -225,6 +225,7 @@ extern struct dentry * d_instantiate_anon(struct dentry *, struct inode *);
 extern void __d_drop(struct dentry *dentry);
 extern void d_drop(struct dentry *dentry);
 extern void d_delete(struct dentry *);
+extern void d_set_always_valid(struct dentry *dentry);
 extern void d_set_d_op(struct dentry *dentry, const struct dentry_operations *op);
 
 /* allocate/de-allocate */
-- 
2.43.0


