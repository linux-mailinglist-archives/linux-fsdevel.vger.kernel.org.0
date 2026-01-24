Return-Path: <linux-fsdevel+bounces-75345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FE2BQpadGlM4wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75345-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 06:35:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7437C7C90E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 06:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63E34301107F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 24 Jan 2026 05:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B8223EA97;
	Sat, 24 Jan 2026 05:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hJYKecND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4901FC110
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Jan 2026 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769232900; cv=none; b=EREH6OnS0woD8rrvSaXUx6rxUE5h0o6YOzndaUyTvwhr9Ld3a0vl6/zjw9nBHAO5mWZ0t0vyyZwgU8bYOEptmeJ4E97lsQ2LI1T+XsyzhodKHTVasCj01jTAlDehCxx66ItfH7rI73t5P9iePQA8H3pagVuZ3HkUaa5kPrchZX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769232900; c=relaxed/simple;
	bh=m31dTP8m0ruf0LcHRzGBX7h98yOj4px84WQb+GGhh2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a88ccUAOMtuCU0LxGfm7mkd140jz4XXwHV9Ttrzl/qW+gE8E/0PnDN3yPIE8rBoOuWuHkBkqRWoyx/QVs8FdTa+N7VioPltlm5gUhQyrQ7gjBM6Vj0SLrw4PlgZaG2+zHvq8NKRucnijCHFrjVkLyP4vd3B+UL4YyRzmCQBlpa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hJYKecND; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nXu9ntvXi1FQKs+JL5uE7CfG+hH++tmdu25zaBWP57w=; b=hJYKecNDhDA27i2UXxfBI64d8n
	qyKNKsD9LyFwCYVF/D5WvayZXb2KcPS776RD7YepPoIhqazX4KhpSyrhYkL6XYXIEg1yHaUvZvf0K
	CCV76xbJvtWx7pcpnaRc/ZtfAqCjyU9xp4UZsCrCzU39ZhnCZVae5edFjs20WTRzcastvlgN5nprJ
	J8hj3z5CUfBMDE02MOayXEOZKW7/esJ8U2Z3fUf1N4aZ8/2VXXec4zIMlGZXrQn1LeTiOSIZtM9Lf
	6Coi3/yWc6F9alfDB2XQvrs3ZMI/NgBG9WkAms2j42xEu4EgMw0RsxNynoAnMpeAMMIrO2oZrQNPW
	pE+TvViQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1vjWK7-00000002aoG-0fzL;
	Sat, 24 Jan 2026 05:36:39 +0000
Date: Sat, 24 Jan 2026 05:36:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>, Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH][RFC] get rid of busy-wait in shrink_dcache_tree()
Message-ID: <20260124053639.GL3183987@ZenIV>
References: <20260122202025.GG3183987@ZenIV>
 <CAHk-=wj1nKArJE8dj+mwF2bGu+N2-DL0P2ytaLYJRrDdPpa9MA@mail.gmail.com>
 <20260123003651.GH3183987@ZenIV>
 <20260124043623.GK3183987@ZenIV>
 <CAHk-=wgkSAHswtOzvTXeBOz1GLNfsohSPdyzZmnVYe2Qx4fetQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgkSAHswtOzvTXeBOz1GLNfsohSPdyzZmnVYe2Qx4fetQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zeniv.linux.org.uk,none];
	R_DKIM_ALLOW(-0.20)[linux.org.uk:s=zeniv-20220401];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75345-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[viro@zeniv.linux.org.uk,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.org.uk:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7437C7C90E
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 08:46:52PM -0800, Linus Torvalds wrote:

> Just make a proper "struct select_data *" union member that aliases
> that "d_alias.next" field, and the compiler will generate the EXACT
> same code, except the source code will be cleaner, and you won't need
> any hacky pointer casts.
> 
> And document how that field is NULL when the dentry is killed, and how
> that NULL 'dentry->d_u.d_alias.next' field at that point becomes a
> NULL 'dentry->d_u.d_select_data' field.
> 
> You don't need to describe 'struct select_data', you just need to
> declare it. IOW, something like this:

As the matter of fact, that _was_ the previous iteration of that patch -
see http://ftp.linux.org.uk/people/viro/y8

The only trouble is that as soon as some joker slaps __randomize_layout
on struct hlist_node they'll start flipping from sharing with ->next to
sharing with ->pprev, at random.

I'm not saying it wouldn't work, but I would rather have the proofs of
correctness less subtle.  And it's not even hard to do - the only
rule added would be that ->d_u.d_alias should never be accessed for
negative dentries and never without ->i_lock on the inode of dentry
in question.

The only places where it does not hold at the moment are those WARN_ON()
and we'll be better off having those spelled in less obscure way; we
want to verify that dentry is negative, so let's express that in the
idiomatic way.

And that's it - with that done, we can add a field, obviously with
forward declaration of struct select_data, etc. and have it explicitly
initialized whenever dentry goes negative.  Instead of zeroing
->d_u.d_alias.{next,pprev} as we do now.

Currently !hlist_unlinked(&dentry->d_u.d_alias) is equivalent to
dentry->d_inode != NULL, with identical stability requirements.
And nobody ever traverses that hlist without ->i_lock - no RCU accesses
there.  We do have lockless checks that list is not empty (right before
grabbing ->i_lock and rechecking), but those come from the inode side;
"are there any aliases for this inode" rather than "is this dentry
an alias for anything (== positive)".

I'm putting together short documentation on d_inode/d_alias/i_dentry/type
bits in d_flags; should be done by tomorrow morning...

PS: a fun catch while doing that code audit - AFAICS, we don't really need
to play with fake root dentry for NFS anymore; the reason why it used to be
needed had been gone since 2013 as an unnoticed side effect of switching
shrink_dcache_for_umount() to use of d_walk()...  Obviously needs
a review from NFS folks, but if they see no problems with that, it would
be nice to get rid of that kludge, as in

diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index f13d25d95b85..2ac8404e1a15 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -32,35 +32,6 @@
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
 
-/*
- * Set the superblock root dentry.
- * Note that this function frees the inode in case of error.
- */
-static int nfs_superblock_set_dummy_root(struct super_block *sb, struct inode *inode)
-{
-	/* The mntroot acts as the dummy root dentry for this superblock */
-	if (sb->s_root == NULL) {
-		sb->s_root = d_make_root(inode);
-		if (sb->s_root == NULL)
-			return -ENOMEM;
-		ihold(inode);
-		/*
-		 * Ensure that this dentry is invisible to d_find_alias().
-		 * Otherwise, it may be spliced into the tree by
-		 * d_splice_alias if a parent directory from the same
-		 * filesystem gets mounted at a later time.
-		 * This again causes shrink_dcache_for_umount_subtree() to
-		 * Oops, since the test for IS_ROOT() will fail.
-		 */
-		spin_lock(&d_inode(sb->s_root)->i_lock);
-		spin_lock(&sb->s_root->d_lock);
-		hlist_del_init(&sb->s_root->d_u.d_alias);
-		spin_unlock(&sb->s_root->d_lock);
-		spin_unlock(&d_inode(sb->s_root)->i_lock);
-	}
-	return 0;
-}
-
 /*
  * get a root dentry from the root filehandle
  */
@@ -99,10 +70,6 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		goto out_fattr;
 	}
 
-	error = nfs_superblock_set_dummy_root(s, inode);
-	if (error != 0)
-		goto out_fattr;
-
 	/* root dentries normally start off anonymous and get spliced in later
 	 * if the dentry tree reaches them; however if the dentry already
 	 * exists, we'll pick it up at this point and use it as the root
@@ -115,7 +82,6 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		goto out_fattr;
 	}
 
-	security_d_instantiate(root, inode);
 	spin_lock(&root->d_lock);
 	if (IS_ROOT(root) && !root->d_fsdata &&
 	    !(root->d_flags & DCACHE_NFSFS_RENAMED)) {
@@ -123,6 +89,8 @@ int nfs_get_root(struct super_block *s, struct fs_context *fc)
 		name = NULL;
 	}
 	spin_unlock(&root->d_lock);
+	if (!s->s_root)
+		s->s_root = dget(root);
 	fc->root = root;
 	if (server->caps & NFS_CAP_SECURITY_LABEL)
 		kflags |= SECURITY_LSM_NATIVE_LABELS;

