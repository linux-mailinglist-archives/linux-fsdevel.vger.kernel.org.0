Return-Path: <linux-fsdevel+bounces-41136-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBF36A2B6DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 00:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A6EF163F02
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 23:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FF5237711;
	Thu,  6 Feb 2025 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iGRxwEdG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yLjPZIyi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iGRxwEdG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yLjPZIyi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948AD2417D3;
	Thu,  6 Feb 2025 23:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738886235; cv=none; b=P4lj9kiBDDo8JKaovIPOkEDz/8+K7+9X4aznWYeye2MKQBlBBDKMJFF4q+2fwjtcSFRnCf7G9XpNHUl9ua7VcSExUhEVXtsoCVFt/CXbqIUfNsKq4ATVQwtRKqhh9p6I0Xv3KdWscnlN2i6DlpwIRGw8+rnMR6XCGgIKYmXBAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738886235; c=relaxed/simple;
	bh=A81b+ydZ+b1eXj5y/pSMefXQhNFwKiUO6JwqDbKVQXI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=mjRdI82rSRn+yu2Lb+28++JdmH4WLoPO16Zpe+os44pnk+jYeksDdH9plQXu2MTFAP8dZkJzLXGyco6+qN2ALUaT2JUN79GxtCawRiMrUdrTzwxSB9cFxVv46BmVSKl3aLTyghX6afUtUP7qW1ubf9mO3GN9GEQ4y90m9ZY/0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iGRxwEdG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yLjPZIyi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iGRxwEdG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yLjPZIyi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C116F21160;
	Thu,  6 Feb 2025 23:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738886231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrVDNLAQuLnAq4PHsrYCK4OyhN9aDEJGPCXOyutiPmo=;
	b=iGRxwEdGlNF8xIIMoPvB31HMRMM87Oga2OVh4pjWds8RJ3QGYppFcc6ppPM64Mw6CvgydL
	UWmPDX9GMKjSuJWh4ILgi7e0e81ZZoB6Zmy8JpWsMO3SED5gHUKqVvjKyvBzDTvD01M7A1
	KN3QXbYn3jDffcHztVXI9T9aWd7rozY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738886231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrVDNLAQuLnAq4PHsrYCK4OyhN9aDEJGPCXOyutiPmo=;
	b=yLjPZIyiItI1dvJKz8H/Q2H3Uxb3sTqUoP9l42JML+UeacCvFg8jxNTlUCAUvIFPPKvI2t
	sCWVeR0V+2qhfQAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738886231; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrVDNLAQuLnAq4PHsrYCK4OyhN9aDEJGPCXOyutiPmo=;
	b=iGRxwEdGlNF8xIIMoPvB31HMRMM87Oga2OVh4pjWds8RJ3QGYppFcc6ppPM64Mw6CvgydL
	UWmPDX9GMKjSuJWh4ILgi7e0e81ZZoB6Zmy8JpWsMO3SED5gHUKqVvjKyvBzDTvD01M7A1
	KN3QXbYn3jDffcHztVXI9T9aWd7rozY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738886231;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrVDNLAQuLnAq4PHsrYCK4OyhN9aDEJGPCXOyutiPmo=;
	b=yLjPZIyiItI1dvJKz8H/Q2H3Uxb3sTqUoP9l42JML+UeacCvFg8jxNTlUCAUvIFPPKvI2t
	sCWVeR0V+2qhfQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0402A13312;
	Thu,  6 Feb 2025 23:57:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i3toKlRMpWcRRwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 23:57:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neilb@suse.de>
To: "Jeff Layton" <jlayton@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Dave Chinner" <david@fromorbit.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/19] VFS: introduce vfs_mkdir_return()
In-reply-to: <6ca281d4e45052a3a23bd60a63ef20288931dae1.camel@kernel.org>
References: <>, <6ca281d4e45052a3a23bd60a63ef20288931dae1.camel@kernel.org>
Date: Fri, 07 Feb 2025 10:57:05 +1100
Message-id: <173888622594.22054.9704903327056265554@noble.neil.brown.name>
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Fri, 07 Feb 2025, Jeff Layton wrote:
> On Thu, 2025-02-06 at 16:42 +1100, NeilBrown wrote:
> > vfs_mkdir() does not guarantee to make the child dentry positive on
> > success.  It may leave it negative and then the caller needs to perform a
> > lookup to find the target dentry.
> >=20
> > This patch introduced vfs_mkdir_return() which performs the lookup if
> > needed so that this code is centralised.
> >=20
> > This prepares for a new inode operation which will perform mkdir and
> > returns the correct dentry.
> >=20
> > Signed-off-by: NeilBrown <neilb@suse.de>
> > ---
> >  fs/cachefiles/namei.c    |  7 +---
> >  fs/namei.c               | 69 ++++++++++++++++++++++++++++++++++++++++
> >  fs/nfsd/vfs.c            | 21 ++----------
> >  fs/overlayfs/dir.c       | 33 +------------------
> >  fs/overlayfs/overlayfs.h | 10 +++---
> >  fs/overlayfs/super.c     |  2 +-
> >  fs/smb/server/vfs.c      | 24 +++-----------
> >  include/linux/fs.h       |  2 ++
> >  8 files changed, 86 insertions(+), 82 deletions(-)
> >=20
> > diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> > index 7cf59713f0f7..3c866c3b9534 100644
> > --- a/fs/cachefiles/namei.c
> > +++ b/fs/cachefiles/namei.c
> > @@ -95,7 +95,6 @@ struct dentry *cachefiles_get_directory(struct cachefil=
es_cache *cache,
> >  	/* search the current directory for the element name */
> >  	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
> > =20
> > -retry:
> >  	ret =3D cachefiles_inject_read_error();
> >  	if (ret =3D=3D 0)
> >  		subdir =3D lookup_one_len(dirname, dir, strlen(dirname));
> > @@ -130,7 +129,7 @@ struct dentry *cachefiles_get_directory(struct cachef=
iles_cache *cache,
> >  			goto mkdir_error;
> >  		ret =3D cachefiles_inject_write_error();
> >  		if (ret =3D=3D 0)
> > -			ret =3D vfs_mkdir(&nop_mnt_idmap, d_inode(dir), subdir, 0700);
> > +			ret =3D vfs_mkdir_return(&nop_mnt_idmap, d_inode(dir), &subdir, 0700);
> >  		if (ret < 0) {
> >  			trace_cachefiles_vfs_error(NULL, d_inode(dir), ret,
> >  						   cachefiles_trace_mkdir_error);
> > @@ -138,10 +137,6 @@ struct dentry *cachefiles_get_directory(struct cache=
files_cache *cache,
> >  		}
> >  		trace_cachefiles_mkdir(dir, subdir);
> > =20
> > -		if (unlikely(d_unhashed(subdir))) {
> > -			cachefiles_put_directory(subdir);
> > -			goto retry;
> > -		}
> >  		ASSERT(d_backing_inode(subdir));
> > =20
> >  		_debug("mkdir -> %pd{ino=3D%lu}",
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 3ab9440c5b93..d98caf36e867 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4317,6 +4317,75 @@ int vfs_mkdir(struct mnt_idmap *idmap, struct inod=
e *dir,
> >  }
> >  EXPORT_SYMBOL(vfs_mkdir);
> > =20
> > +/**
> > + * vfs_mkdir_return - create directory returning correct dentry
> > + * @idmap:	idmap of the mount the inode was found from
> > + * @dir:	inode of the parent directory
> > + * @dentryp:	pointer to dentry of the child directory
> > + * @mode:	mode of the child directory
> > + *
> > + * Create a directory.
> > + *
> > + * If the inode has been found through an idmapped mount the idmap of
> > + * the vfsmount must be passed through @idmap. This function will then t=
ake
> > + * care to map the inode according to @idmap before checking permissions.
> > + * On non-idmapped mounts or if permission checking is to be performed o=
n the
> > + * raw inode simply pass @nop_mnt_idmap.
> > + *
> > + * The filesystem may not use the dentry that was passed in.  In that ca=
se
> > + * the passed-in dentry is put and a new one is placed in *@dentryp;
>=20
> This sounds like the filesystem is not allowed to use the dentry that
> we're passing it. Maybe something like this:
>=20
> "In the event that the filesystem doesn't use *@dentryp, the dentry is
> put and a new one is placed in *@dentryp;"

Good catch - thanks.
I've updated my patch you use your test, except I decided on "dput()"
rather than "put".

Thanks,
NeilBrown

