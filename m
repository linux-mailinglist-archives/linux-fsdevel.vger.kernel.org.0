Return-Path: <linux-fsdevel+bounces-42614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F04A4507F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 23:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6F4189B7F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Feb 2025 22:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC3B230D0E;
	Tue, 25 Feb 2025 22:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MnJXDNnq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tzcjQGIU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PwShaa1E";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ROot/kVt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EB1C84C8
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Feb 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740523909; cv=none; b=TYT6ZTIPfoJmgAC8vAQwKMBomJgWCRdg2IW1aXq1sUhP+3q4pafHqMX8LGqI0gv7r8HUAOwBHeYUvYEcuPeXhcTa/XevL+/6eIM+VP0chNObEo8cwcc6flOVgUmi21d72oLwghAKXWOk6VmDX7pSlu8aZY5XAYnKQO518gf+jpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740523909; c=relaxed/simple;
	bh=w9nE2B8RIJJlVXUG/gqc1qASm7gWChSfNDvro4vBvVk=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=XAMbbnJpZNVTSaIifEQXobnelqRoYTUqZRZcNqCr5yM5u2va4J5U6H1IqjXol9nlQNw9G9+6igyyz7hzYYIc95A+/eFDOzolmpvcvbcY+1f/SU4SrNaMLZWhOm5bjS5hxRNrSEr19qX2UQXnKo5kLCtttyvwOF0E2sBb2lL17FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MnJXDNnq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tzcjQGIU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PwShaa1E; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ROot/kVt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DC3951F38A;
	Tue, 25 Feb 2025 22:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740523906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJvWCHptaZGY8JKDpb4MVBz3fCC6bBDmaPVL8wZuuDw=;
	b=MnJXDNnqIOQQMG4ZjxqzNyJ6Q1rGlX5rKv1669Vr1w+3MoXBi5KkMVIXy3qwTVuZpfu3YW
	cddZrfZYTesEamBJEp/45h7ksfph0kBNk8HPy3Ezm98TO5zFBVU52lKX++xTsUUcMrYxQ4
	QGjhrTtqC4xg0DO2ispp2vx/yjP2N10=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740523906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJvWCHptaZGY8JKDpb4MVBz3fCC6bBDmaPVL8wZuuDw=;
	b=tzcjQGIUbYxG7ZkZ8z8imib8rF8EhaQawUJczEdf+nqMbg04gzWNrTE+7dfLyFoiwYPREl
	J7CxPqQWNyuM0bAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740523905; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJvWCHptaZGY8JKDpb4MVBz3fCC6bBDmaPVL8wZuuDw=;
	b=PwShaa1EhxDzUuZocn6dsvjA5+PVH2LDT+l0+UJ0jUB7zwqKV6mBM0HY0yW6D/QjHT9sgB
	O/FyclOCOVA3dNm2/0o2S1D91V+0Isb086UgWfXKKIPj87tXgGKFybJgB43hd319HfKgqq
	/EE60FfbWgi6+owH4lp/XLR5+/k0CcM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740523905;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vJvWCHptaZGY8JKDpb4MVBz3fCC6bBDmaPVL8wZuuDw=;
	b=ROot/kVtZTrejdDNTfcHuEWwYxYcR1AJacywgm9S8vFrB0iIPPT++r7im90aTWH9ufWLu0
	ixPvj+bjmxYx+DBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93E2213888;
	Tue, 25 Feb 2025 22:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vMTvEX9JvmfbJwAAD6G6ig
	(envelope-from <neilb@suse.de>); Tue, 25 Feb 2025 22:51:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Al Viro" <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Christian Brauner" <brauner@kernel.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>, "Jan Kara" <jack@suse.cz>
Subject: Re: [PATCH 01/21] procfs: kill ->proc_dops
In-reply-to: <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
References: <20250224141444.GX1977892@ZenIV>,
 <20250224212051.1756517-1-viro@zeniv.linux.org.uk>
Date: Wed, 26 Feb 2025 09:51:32 +1100
Message-id: <174052389204.102979.2659504356456752671@noble.neil.brown.name>
X-Spam-Level: 
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.914];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.28
X-Spam-Flag: NO

On Tue, 25 Feb 2025, Al Viro wrote:
> It has two possible values - one for "forced lookup" entries, another
> for the normal ones.  We'd be better off with that as an explicit
> flag anyway and in addition to that it opens some fun possibilities
> with ->d_op and ->d_flags handling.
>=20
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  fs/proc/generic.c  | 8 +++++---
>  fs/proc/internal.h | 5 +++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/proc/generic.c b/fs/proc/generic.c
> index 8ec90826a49e..499c2bf67488 100644
> --- a/fs/proc/generic.c
> +++ b/fs/proc/generic.c
> @@ -254,7 +254,10 @@ struct dentry *proc_lookup_de(struct inode *dir, struc=
t dentry *dentry,
>  		inode =3D proc_get_inode(dir->i_sb, de);
>  		if (!inode)
>  			return ERR_PTR(-ENOMEM);
> -		d_set_d_op(dentry, de->proc_dops);
> +		if (de->flags & PROC_ENTRY_FORCE_LOOKUP)
> +			d_set_d_op(dentry, &proc_net_dentry_ops);
> +		else
> +			d_set_d_op(dentry, &proc_misc_dentry_ops);
>  		return d_splice_alias(inode, dentry);
>  	}
>  	read_unlock(&proc_subdir_lock);
> @@ -448,9 +451,8 @@ static struct proc_dir_entry *__proc_create(struct proc=
_dir_entry **parent,
>  	INIT_LIST_HEAD(&ent->pde_openers);
>  	proc_set_user(ent, (*parent)->uid, (*parent)->gid);
> =20
> -	ent->proc_dops =3D &proc_misc_dentry_ops;
>  	/* Revalidate everything under /proc/${pid}/net */
> -	if ((*parent)->proc_dops =3D=3D &proc_net_dentry_ops)
> +	if ((*parent)->flags & PROC_ENTRY_FORCE_LOOKUP)
>  		pde_force_lookup(ent);
> =20
>  out:
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index 1695509370b8..07f75c959173 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -44,7 +44,6 @@ struct proc_dir_entry {
>  		const struct proc_ops *proc_ops;
>  		const struct file_operations *proc_dir_ops;
>  	};
> -	const struct dentry_operations *proc_dops;
>  	union {
>  		const struct seq_operations *seq_ops;
>  		int (*single_show)(struct seq_file *, void *);
> @@ -67,6 +66,8 @@ struct proc_dir_entry {
>  	char inline_name[];
>  } __randomize_layout;
> =20
> +#define PROC_ENTRY_FORCE_LOOKUP 2 /* same space as PROC_ENTRY_PERMANENT */

Should there be a note in include/linux/proc_fs.h say that '2' is in
use?

Otherwise it seems sensible.

Thanks,
NeilBrown


> +
>  #define SIZEOF_PDE	(				\
>  	sizeof(struct proc_dir_entry) < 128 ? 128 :	\
>  	sizeof(struct proc_dir_entry) < 192 ? 192 :	\
> @@ -346,7 +347,7 @@ extern const struct dentry_operations proc_net_dentry_o=
ps;
>  static inline void pde_force_lookup(struct proc_dir_entry *pde)
>  {
>  	/* /proc/net/ entries can be changed under us by setns(CLONE_NEWNET) */
> -	pde->proc_dops =3D &proc_net_dentry_ops;
> +	pde->flags |=3D PROC_ENTRY_FORCE_LOOKUP;
>  }
> =20
>  /*
> --=20
> 2.39.5
>=20
>=20


