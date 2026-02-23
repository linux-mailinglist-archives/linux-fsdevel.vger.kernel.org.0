Return-Path: <linux-fsdevel+bounces-77988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BPFOd2PnGnRJQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77988-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:35:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA3F17AE54
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 18:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B935B302BEBA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9C2331A73;
	Mon, 23 Feb 2026 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F+M8ReRS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD513321C7
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 17:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771867918; cv=pass; b=lWfYxt4V5DA8PGwiQFD4AbV8SVbmSYHb+czRWjSHBBG1uqmwAkniCYKlS7j0IAof8WeYh/DzGTDme6uY5kYpJM5d8+gdZmEZ2f/cpdv86ydtn5sCuDXs30Q6KOsUx5OacokFD9u5xy1sWb5KRfVdrZ6EykRu3jtn+8Fh1thUQEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771867918; c=relaxed/simple;
	bh=hK/0jeoKCkucbRZSvX1AYVctVojQdWNjxRFJpKPT85c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=grjlGxhE+g1KnfZY499G6l+kmFyHsHlCjW10e/t38CshGHoyh5bk7jlCXeH/CrLHU3ECXOfKWsVRBszIBzNIwjSZS/kLB4j9OarSJU4xmpjXVw9dc/kSem3qdbDjdAtrmt8ek+SOvfzzYuWsqBumCNo1lUxCCcKPPShzwhVmlB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F+M8ReRS; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354c16d83b2so2163542a91.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 09:31:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771867915; cv=none;
        d=google.com; s=arc-20240605;
        b=IljCOCYQAigexwh5FxlxMLeE9alFudksZ7hjXFI6sg4jDZaq1Oh1uNFj4Xirvfn16+
         8I2m3ixuG/FyCt5FHUpJggrSWC2eenWUZYpZlGQx0CRwzQWewNPj8nZLE0Y1dPk2J35d
         ifvH9gN+k/+GrHwMbRqZErGWsycB4QhnrqLWuSjTHA8lh8hT64SjI9juwWyz6oK/UEKX
         t8e9bXQzQXgJAp+aPGOD7lbUelIJ8SZYDzKh621ZIltl+aj61kfxZu7/aZiDELE4Rb97
         Eoqoxx9mBO4oufjua4dBzI0UONtI0efNmhJI/VhGjYKCRFY80ItCF/yxB3nnPDvTb9nv
         i8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        fh=+K3LYCtlhH2JJSHqXoDB//qJycfkm6wXeFcZhEXipqk=;
        b=HPENV07/Olu4zQb/ozLd/n/XdkWhDoqQXGz/MROVIYlaPbenj6rFW7uaLvVDBkk6oz
         azOHOzvCy3d7LjlpcpgivflMoGJxNhGMjSBLwmDpObIuMAtYKpJJNOnZA50ZRdyO0EHz
         h01VlYFGPLQps/fovs6xkhzCwPF8OKgjbQNcdCarTeBWWif+m91XIaneFnNLBuXOPZFW
         c5SJVDtBKXzpWdxb90Guar0AqfG8/IwosQAifJaRod0TgOSIHGZGgTDyzXKY95mxOFpo
         GduKwZa42Cb2IQ+2hZ3GeF5CslaXQf/bhHyCkGv7Z+Pa98crrF+xXKO2aluWNDQJKsji
         xBiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1771867915; x=1772472715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        b=F+M8ReRSjHBcODwL6YMsB62k5KM9tS8sOWzeJ5+cgWNwRgCriw3XQa/eD8Yx/Hni30
         IdB+LiB/ApJjquQB5KcxVEI5HLkLWuZ1vTpKyL0E0HUfvIQZRWdXowU9+z67g7Gwx52C
         +oyHQZzV3WLMrQboFAG7U9dC2B2apXVJrFgLqbBoeCt8vO8eZLDHjMm8iii0dsQnf5WW
         Z+IHssdjgGYFzkGRQY1XVAsJ4gq0CVWEFyPOg2QbuYKPHrO7FhEUN0jl57qhGgMjZ2bq
         zTkZ+QXwpKHtOYw10dJFzE57zltv532RD2Y3Hk+vJDyanvg3sI0G/4PpvFt2TNvnCaPd
         NKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771867915; x=1772472715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6UKo5s8UZQoKFDeeGaREA8NHzO9NWVOgEQkt9hAvBaw=;
        b=ODS4QuvFN6eqX/HEPXzyaaM2Ox9aY9sRZYZ69MM/ho5Gz7xqqC30CAU6ABtxZ7+7jC
         eFnOQCydJkz3VtiBCLaoMIB4VVPYzZVlqVLZ8Eb4i+XhPAdK2MuUNwtgKB9kIDqvl3kK
         lxbOuk3cVwjoupcmAidfJNRzMxyjbEuqX6dGQycQHqzNDqESucFN2P/vzoIyZb1I4ATN
         LfecQcMbrhW7hVdzlLznUjaFPFV0Y74NLHOHbxwQb10bEwMsJ9PwIESb0oS5fZ7VtFZY
         vKph8/2nGpoILsTgxXU0LOq/lXg5sJrMi1Zk1NCh6JFaYt2ct8gC56plVET8kTPr0fq2
         LW2w==
X-Forwarded-Encrypted: i=1; AJvYcCWUZN+lyQhADulh+fvJAb7RX1ciJ+jKtK1yvJJXVgQ1zkbN4TvrBWc/ZySBD8jQFNLYvzO17HjW5byJ3KhK@vger.kernel.org
X-Gm-Message-State: AOJu0YyRO8j0OkAg0tecz/Py3PbFtiX/x+YNux+vU1ME2tschzCRfIXJ
	nhio+2xQYn5+29NWC4u2uYzubYwC04SgOVNZNy+aU+QKCvBtwSzNlLfBZDcnhBsDEb+OYDbDzt8
	Ud10mPJ9WE4Pg1llM+izXwtVEf7+YTHk+aqkISnSq
X-Gm-Gg: ATEYQzwVVNqH/JchGpgqkKLI7Fx212UcnH2NqE9KJq/BBbDECyUfDJkBsxikMlP/J9h
	XaxFdD+FGXB+y4OnLfldzyOIRQYfVek9v1gJYRx9Pam2FJezeCyVq7srfZRm6U308N7T9T6FkKd
	4kxOsWF7OSQA88NR+9x6IrKtehqqyUI4HacAbQEwhMn2Jkl+vF5DvgIO+WxSqFCR6SW3GkrZf0K
	aVtfq2dcP9+4ATwONcf1b6xBLIPGz7tDqNsD8nZoJrNnVkHjRFHtkcRuoPqFQqGPVyM3bwtO6Qv
	E6B0dD0=
X-Received: by 2002:a17:90b:2543:b0:352:b674:2592 with SMTP id
 98e67ed59e1d1-358ae7c3605mr8357173a91.7.1771867914678; Mon, 23 Feb 2026
 09:31:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223011210.3853517-1-neilb@ownmail.net> <20260223011210.3853517-7-neilb@ownmail.net>
 <20260223132533.136328-1-clm@meta.com>
In-Reply-To: <20260223132533.136328-1-clm@meta.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 23 Feb 2026 12:31:40 -0500
X-Gm-Features: AaiRm52jwDH7iM8Njra-WDPg6xnZ2flvbCTBnLCHZ5MkdIrvbyo0z9crRKbktmQ
Message-ID: <CAHC9VhSVjLNeTdxHmwYsGX75Z4FOAP+26=PjVdFxpmEkTrPvxA@mail.gmail.com>
Subject: Re: [PATCH v2 06/15] selinux: Use simple_start_creating() / simple_done_creating()
To: Chris Mason <clm@meta.com>
Cc: NeilBrown <neil@brown.name>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	John Johansen <john.johansen@canonical.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"Darrick J. Wong" <djwong@kernel.org>, linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77988-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FREEMAIL_CC(0.00)[brown.name,kernel.org,zeniv.linux.org.uk,redhat.com,suse.cz,oracle.com,szeredi.hu,gmail.com,canonical.com,namei.org,hallyn.com,vger.kernel.org,lists.linux.dev,lists.ubuntu.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brown.name:email,paul-moore.com:dkim,paul-moore.com:url,paul-moore.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,ownmail.net:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3AA3F17AE54
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 8:26=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
> NeilBrown <neilb@ownmail.net> wrote:
> > From: NeilBrown <neil@brown.name>
> >
> > Instead of explicitly locking the parent and performing a lookup in
> > selinux, use simple_start_creating(), and then use
> > simple_done_creating() to unlock.
> >
>
> Hi everyone,
>
> Amir suggested I run these through, and this commit was flagged:
>
> commit bc981629767980bbaee2ca3c7348b5a648665a9d
> Author: NeilBrown <neil@brown.name>
>
> selinux: Use simple_start_creating() / simple_done_creating()
>
> Instead of explicitly locking the parent and performing a lookup in
> selinux, use simple_start_creating(), and then use
> simple_done_creating() to unlock.
>
> This extends the region that the directory is locked for, and also
> performs a lookup. The lock extension is of no real consequence.
> The lookup uses simple_lookup() and so always succeeds. Thus when
> d_make_persistent() is called the dentry will already be hashed.
> d_make_persistent() handles this case.
>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
> > diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.=
c
> > index 3245cc531555b..7d4f90e5b12a0 100644
> > --- a/security/selinux/selinuxfs.c
> > +++ b/security/selinux/selinuxfs.c
> > @@ -1931,15 +1931,16 @@ static const struct inode_operations swapover_d=
ir_inode_operations =3D {
> >  static struct dentry *sel_make_swapover_dir(struct super_block *sb,
> >                                               unsigned long *ino)
> >  {
> > -     struct dentry *dentry =3D d_alloc_name(sb->s_root, ".swapover");
> > +     struct dentry *dentry;
> >       struct inode *inode;
> >
> > -     if (!dentry)
> > +     inode =3D sel_make_inode(sb, S_IFDIR);
> > +     if (!inode)
> >               return ERR_PTR(-ENOMEM);
> >
> > -     inode =3D sel_make_inode(sb, S_IFDIR);
> > -     if (!inode) {
> > -             dput(dentry);
> > +     dentry =3D simple_start_creating(sb->s_root, ".swapover");
> > +     if (!dentry) {
> > +             iput(inode);
> >               return ERR_PTR(-ENOMEM);
> >       }
>
> Can this cause a kernel crash when simple_start_creating() fails?
>
> The function simple_start_creating() returns ERR_PTR on failure, not
> NULL. The check `if (!dentry)` only catches NULL values. When
> simple_start_creating() fails and returns an ERR_PTR value like
> ERR_PTR(-ENOMEM), this value is non-NULL and the error check is bypassed.
>
> Execution would continue to d_make_persistent(dentry, inode), which
> attempts to lock dentry->d_lock, dereferencing the ERR_PTR value and
> causing a kernel crash.
>
> The old code used d_alloc_name() which returns NULL on error. The new
> code uses simple_start_creating() which returns ERR_PTR on error, but
> the error checking pattern wasn't updated to match.
>
> Should the check be `if (IS_ERR(dentry))` instead, and return dentry
> rather than ERR_PTR(-ENOMEM) to preserve the actual error code?

Good catch Chris, yes, please change this Neil and feel free to preserve my=
 ACK.

--=20
paul-moore.com

