Return-Path: <linux-fsdevel+bounces-75797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE9CJnRjemmB5gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75797-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 20:28:52 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35DA827B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 20:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A2A4303E4A1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 19:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78EDE37419A;
	Wed, 28 Jan 2026 19:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOWeo3z/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E87372B53
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 19:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628524; cv=pass; b=G8A2kn6GiuGvBEn6ElQPojN4WLezK2ngzKMzw0VMp4Jd/28DQa/EUWEWwCc0byrwSwUziIr3bbBRsaSEzCpzuxsFyVIS7NzHEF2ypX1p0VH4f8ogsWYxv4EWEFwK56EjxwUVEkBppK0JLnnbovMGlELPh34sGHl5ARFzKT202es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628524; c=relaxed/simple;
	bh=1VR64+xgk5sFrJfV+cOSAqG9s0CfJIAZvD+8VJYkD8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rktJG/Uqoi03YT2/B/d+fpdnhYRWGT0mKyH/iGjXWun0Au0/97kK9RiVPqvJkJzqzi/fILgtb/CwfDhysE/fDBivtgYk8fmeONRGYdL4ZsoyBWVO906OPJrEDWe+pSkUj45m59AQqH363PPXoDjHnOH7VUg1irCbA5SckA9ovCk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOWeo3z/; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8ddad7359fso37403266b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 11:28:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769628521; cv=none;
        d=google.com; s=arc-20240605;
        b=V94Cu1jhmJ19wkP3TudnPgWHbp1kJ++cgaXWT3GKrynrTbhelIAc3u/L0KZOxdmR3U
         K+7YaYptMtfHdkeAQqT0K6hfmXKFFQXBWt3pNa2YXpyqy3gPoDxGQPcqt99lxc8Nvk4T
         KEv64RXMff0qNAsB/wc+IKOmz10uUgUKjzIyCA559NcE0Lq3ms0+56+jr/9DZZZSRNXz
         sUf4FnVtA6+gb+E0Sa2IeffizPdWTqK2K+XrotPLR+bFGIl9AEvSZfuuvXQZRfAnoNTB
         ADcDIXvbA9LbCZITH42tXoKdilJ8Ia/nq6Q1J+skJhU+3I1f9LAVTi+pDVeMHMyB+hvk
         I/4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=27ro1TGJU4wnlvWapkLVQUt4YNL7CdjZ7mreSXMURlM=;
        fh=uNW1g3gazHsTKc7zAxamK7HMjIoq08Uk1nWy2XRipYo=;
        b=EQ9299IPtJOomKxXS7ovEo2Ol3tZEb4l2SgR0P9O2GT2jawgLd2WhyqeaaW7W0ggLT
         2p92XVPiwDBLIaQQfRwCuAREfffIr9wtQXD8qTcfJlzMQx2si3o6bHwXtKdffSTnzrk+
         o4vxWZawXWkP84Xt+zZbbOH+k3KLOBK0tsduzhFoV6rQ1v5kU7rMnWd8ivAXERjb1TXF
         TDQKb281EIV+0kK5vxJaeDfSi+lKaFDWGukXYTLH02rHnF2IOjpUeZCfnpL/fiX9GGxo
         +1SeaFV9uHn7jKSBLuJlvtLz/rZOKLaKm7PspUgwiGrz49Wgr39vdfoiHI6dvK96Jmm4
         ldQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769628521; x=1770233321; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=27ro1TGJU4wnlvWapkLVQUt4YNL7CdjZ7mreSXMURlM=;
        b=OOWeo3z/ZI46/7FRYbSkdTXI5sH9NTclsLbcBVn2HTRDwerehcQvXatk6VNEOtfIpb
         zaGJ8Qpv+4pCuOielI5ulHk6fnt2Qj4d8yDHin2MDJsTkCjz1OWA9cALC7R8I069x0Yr
         EJW6K5rvh6aHnT/XZxOcCtE4KE/+aVQ1rN2UF2/LKc9QvnbqzLZ1EaP38Pan4IjX4qS9
         vpe22EYLBYzMYRoEiStPw5TB8rS0Z9uNdtUAA8jebWy95UWteH/kYWHuSxWMY3eS/C5P
         IUaPseU9V3p9O1apPdonZFw87N95A68afcsc5VNBNQVNY0HZNcSefKnLX9U6DrCa4dba
         NjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769628521; x=1770233321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=27ro1TGJU4wnlvWapkLVQUt4YNL7CdjZ7mreSXMURlM=;
        b=LI1Yh/rSvF/ZJAIN7GW63rKI5fJiJA8HSYtERDkMfVMLNoCfR3wyGMlZvdA676uZaG
         59OvI+3zFObHiUe8MlUi7igpljbPc8xMioHvXHQbjgyw1sI8vX7pyAEmVbpqhwHdz2Ch
         f60Q/KyFKDh7ZxzTlpyFL58GmRaCunjKLUUCyIGww9PeE1pQX+K5dIkIrV5a03H8BK/y
         FA+P6WTWLNA2QWXuAqVBlMqs9a16qTKvztue1jk2qaNNtRWgBCLBUZvyZwSw+2xONaQs
         1N46EgIA3iE5DSNtBR6+B5r5iDMr/A8juUzWzKASt6nFMbs8/ZhdhdxZ816DHKQ4i7fk
         zdDA==
X-Forwarded-Encrypted: i=1; AJvYcCWT5M9XoeJ1BrDLLF5IXD1xpQ3FFQZOc/kZ6srY35NVcs5jty2pdB98IxTuc4R8gJu+wkTl0KbkD6LEiwq3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3/W7SSW/P9+R0rqbSl32JevgLBr3V7qDLLBiD4oUCPe7zSndk
	quQKz5sIANUjkvgUv+3LQ9xG6AvkmQ24VOq0MbdVMEFIutjKrkdTOskWbpScjoMn9C+cKav3Q30
	nSokBzWRJ7+QeQ47f6vHSBJHEma+Hqvs=
X-Gm-Gg: AZuq6aJwOz8fnL80/CGFXiyePy0NAzXVCLKfYUx7rIFK7tUDXQUkpd2CPe8ZQw6QmXZ
	mJx7H42XVTY+7xjiPJbAENZ/HvNDDgu1TVawC/p3m1cZnNqhwYL2o8pobksrFK+z9ELSLO+9UBu
	3O4u5ioXgMLfvolJepehNLekM9xGknKjJUruOcV+m8KApB47Ump9ynXxzRbMiBHg45moTTZRfQT
	70Db4xMziqCMUEdn1u8vpePsJXq1Cu3BrpfEgkwJZQ1OdoOCsg7yZ+iCKh26aM+md25x5gjZBEB
	J3jk4Am9dplMTBHtziAF+bNI1FxkPA==
X-Received: by 2002:a17:906:6a1c:b0:b88:7093:3cac with SMTP id
 a640c23a62f3a-b8dab48924amr465610966b.54.1769628520414; Wed, 28 Jan 2026
 11:28:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128111645.902932-1-amir73il@gmail.com> <20260128111645.902932-3-amir73il@gmail.com>
 <dce0e412-1a56-44b3-b910-29247ca23325@app.fastmail.com>
In-Reply-To: <dce0e412-1a56-44b3-b910-29247ca23325@app.fastmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 28 Jan 2026 20:28:28 +0100
X-Gm-Features: AZwV_QiUl-99zS-t8gDgOSYLXzRXaaSZXwfIn5ORyScIDynm1ZzvKFy0Z1UF39c
Message-ID: <CAOQ4uxhNdzM2tjLOLF=OoLqEnW5Z=izk0MHR56XkTntsWfJONQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] nfsd: do not allow exporting of special kernel filesystems
To: Chuck Lever <cel@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>, NeilBrown <neil@brown.name>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75797-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C35DA827B
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 5:12=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Wed, Jan 28, 2026, at 6:16 AM, Amir Goldstein wrote:
> > pidfs and nsfs recently gained support for encode/decode of file handle=
s
> > via name_to_handle_at(2)/opan_by_handle_at(2).
>
> s/opan/open
>
> One more below:
>
>
> > These special kernel filesystems have custom ->open() and ->permission(=
)
> > export methods, which nfsd does not respect and it was never meant to b=
e
> > used for exporting those filesystems by nfsd.
> >
> > Therefore, do not allow nfsd to export filesystems with custom ->open()
> > or ->permission() methods.
> >
> > Fixes: b3caba8f7a34a ("pidfs: implement file handle support")
> > Fixes: 5222470b2fbb3 ("nsfs: support file handles")
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
> >  fs/nfsd/export.c         | 8 +++++---
> >  include/linux/exportfs.h | 9 +++++++++
> >  2 files changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/nfsd/export.c b/fs/nfsd/export.c
> > index 2a1499f2ad196..09fe268fe2c76 100644
> > --- a/fs/nfsd/export.c
> > +++ b/fs/nfsd/export.c
> > @@ -427,7 +427,8 @@ static int check_export(const struct path *path,
> > int *flags, unsigned char *uuid
> >        *       either a device number (so FS_REQUIRES_DEV needed)
> >        *       or an FSID number (so NFSEXP_FSID or ->uuid is needed).
> >        * 2:  We must be able to find an inode from a filehandle.
> > -      *       This means that s_export_op must be set.
> > +      *       This means that s_export_op must be set and comply with
> > +      *       the requirements for remote filesystem export.
> >        * 3: We must not currently be on an idmapped mount.
> >        */
> >       if (!(inode->i_sb->s_type->fs_flags & FS_REQUIRES_DEV) &&
> > @@ -437,8 +438,9 @@ static int check_export(const struct path *path,
> > int *flags, unsigned char *uuid
> >               return -EINVAL;
> >       }
> >
> > -     if (!exportfs_can_decode_fh(inode->i_sb->s_export_op)) {
> > -             dprintk("exp_export: export of invalid fs type.\n");
> > +     if (!exportfs_may_export(inode->i_sb->s_export_op)) {
> > +             dprintk("exp_export: export of invalid fs type (%s).\n",
> > +                     inode->i_sb->s_type->name);
> >               return -EINVAL;
> >       }
> >
> > diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
> > index fafd22ed4c648..bf3dee2ad5f97 100644
> > --- a/include/linux/exportfs.h
> > +++ b/include/linux/exportfs.h
> > @@ -340,6 +340,15 @@ static inline bool exportfs_can_decode_fh(const
> > struct export_operations *nop)
> >       return nop && nop->fh_to_dentry;
> >  }
> >
> > +static inline bool exportfs_may_export(const struct export_operations =
*nop)
> > +{
> > +     /*
> > +      * Do not allow nfs export for filesystems with custom ->open() a=
nd
> > +      * ->permission() ops, which nfsd does not respect (e.g. pidfs, n=
sfs).
> > +      */
>
> The comment says "with custom ->open() and ->permission() ops" but the
> code blocks export if either one is set. The commit message correctly
> says "or" - should the comment be updated to match?
>

Of course.
Will fix for v4.

Thanks,
Amir.

