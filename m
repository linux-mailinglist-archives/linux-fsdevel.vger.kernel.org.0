Return-Path: <linux-fsdevel+bounces-75744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAzZFSItemnd3gEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:37:06 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D37A4137
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 16:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A892D3012955
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38EE2D660E;
	Wed, 28 Jan 2026 15:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFbLVbKy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B362D5408
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 15:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614606; cv=pass; b=q2W3/f25LtssqNXhYKKCjxEbSP1dJECrRnWmOfSfIugq7jU6z3O2W4zTV068YoS6Zcpk1Wrg6OTT8Lsz5OzvUrMRIgfKStsgdiCb3ZTFMu5GI/LMv8FZDLx+YRkf3O8hrgEL4k8C7N9eg1k2dul9I1pMXlq/ryVo3MZKXyYh3T4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614606; c=relaxed/simple;
	bh=7zXVIknH4ehIRtCBnTdf6a0bIKLMMTjayaGHW92kfq0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GMYuh1zzy0vngdnBV07/rhxdS6y3EKS+W74+I1XOiklhQ8ITxXEygGJ6tpl8IrnpANWf683SUW1AFrJTpYkGpKabpXH9AksgCWNKwvaHfM8GO5WDbjV6YNgTaIzTrNnUFTkTjGvpP8py3hfWAD+NJ9Oeg71JWbAK2y3lp12Eges=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFbLVbKy; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-559f4801609so2954685e0c.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jan 2026 07:36:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769614603; cv=none;
        d=google.com; s=arc-20240605;
        b=Vl7O0tywRoH7DyTIqIBEt8GqYNsR96HT5d4gF6/BM5tMng75rfBN2CbtT0L/hWDKzm
         zos1KkVtEbcbc5lR6kNDWK0Noao0OgVbX1GME23nzorHmoSK7q8CX0PzcIYCW/WbmCgZ
         pjnJEs4/VFD+1l6KTHh7ZR/5YuqyxCehR3rXFTXt7iJqlGZzjkCnq64raDz5JCRF7mA2
         eeupmSUVaJmMrywroPCOgtopa37uAoGqECXc+mfXQzBKCm/EoPWi1Cr+2mysJqmCrPX1
         zCVsRHj2btPzJvpxphGcqDvVGLgb8c4IIWVwB0EsVDaCAKVja9alUrXlXxTznjlqSBPb
         S/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RJxlmr5jeUa8zBWPjQHSC6PqXSlyh6rIMyIPjh7RV2Y=;
        fh=jgsd5EeLgyKhfyWJbwXLAsr1YUB9aneFkr3EZlTIlHQ=;
        b=hcXd3SBaA8ZP45mqhnCZEkayEJxeZ+M0jOk+HY7OmodlUtB9snd7nbPq8IMgdBptBC
         7rLUyBk4jjRz8d2Eg7YTZtgO/AlWHqARCDnJMN8ETN8zFepw8laC7+qn92Jk8r0jao6/
         +apbre3sZO1UsMI+Bq0T0tCkCVdMKcMDhZDg2PNyruVrtts0BiazZAQsAdK9pNidd1Q/
         L3BQaq5pkuhUEH2qgEL7sy6q15hiyE7ZXM/x/xKuMAQE17MK30bs9EZoAVPf8Q+qmTmb
         9pRNC9Kt1glDn1kElfewbv4cJ0kREef1caGJXXzNL6RkWbTAu6qEoYCBHmiViHj9SWVh
         RTHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769614603; x=1770219403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RJxlmr5jeUa8zBWPjQHSC6PqXSlyh6rIMyIPjh7RV2Y=;
        b=FFbLVbKyDzWF2GAsXEkiawMh73T3u9vrMDuIo+hg7qHCpqHet21nnZQw2rAgy4/27n
         QljJ7iaZqB8zm627vuEN18SyrRKX8wHaXac4S26BbWi9GVLQeZdqW8j2+tUgkaFl3wMM
         /MxrA3USFfpnBkQbKywyKBhhJ0Qnl5RYUYKMniBWWZ/cDa/VnusXA+ZVnz54tDfjUIg9
         DAZEg4MnSrgi41d+NCKmuvoAT5eYu/emfsQV4k/7dtan9kcuPwPAi8hR8mj1FqlxjWiD
         dX1RDxLsCmmNgg+4QRKP7+jaWb7dqLe/YkGofeueBM7MIE7/GM7v0Yy+LJlp2bvhwuS5
         QEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769614603; x=1770219403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RJxlmr5jeUa8zBWPjQHSC6PqXSlyh6rIMyIPjh7RV2Y=;
        b=BcQnR51trfgPD/DPvjor1tsXgy/B80OWI1lHBIRYfRpIf3s4ijGf6K3s8Hh8eO5H1b
         kCCjy1Zlr8X4Tt/M087B6DlMrOdr+v+oxzQOxC2EwfG7KSF1Cmtv0dhpxW+2eWDsHM4N
         3SyaJvlo+Nxpz7y8Yz8e/cl+BShAjtlnznB0Sk0JIjMYkughhNorNQYTtMI2IzmK28BI
         Qzjq+bXwGFxkUyMjR7Eha4SZGoCHeobnd+0ivOA/5DVzW59tT01Umku03HM7cuREBt4C
         FnORZ8O5T/gmFT/6x8rS+sM9hQiTtNte+JmzmKPBldcb1fiJEusKnWf/QvmE+ael7jE6
         Ai9w==
X-Gm-Message-State: AOJu0Yw959dKOhsl5JicvXu6Wp5xhFhiTH1DuLP0AxzxMdxKIWEDJBw3
	s5IWIYLJK6P3qC8V6lVNh2JMpZgkeh8F05Toc56dxB56HakGilbpt/W2d6QaynpiRudtl7oskyc
	w5oi4xY0CttDNFT8J/r9a+ZcigI/nu2E=
X-Gm-Gg: AZuq6aImX05Iauum7HQ+ePQUzJW8l4LuZ+IvHdz0MV1u0LUM+FVjTWBOqWj6I5eJYx5
	eDiot469M03WGZGJIwicL1Rrp5TxwHNWGnvQqmMG0LuaHsUfTkNkBGJQ5m0Vy0sFMOrR/Cu4c9S
	CiRD2ehNIfUYqkLwP+gQEuqsW+apnj8g2xd2ELizgF1iSVuJIPg5UQFQjdYTAws76+GPeLhRV0U
	uQ45xb7MLrHncXRnYcuCgpd4JH9mHx85wsxIdMiSSCnyjSofbOjmNEx3Y8no03sX5iX7K+OGvp6
	QNWm6uIsH+b9rVaOzo+dM0vYvGs7xPo=
X-Received: by 2002:a05:6122:1d4c:b0:566:26ce:546e with SMTP id
 71dfb90a1353d-566794ef197mr1997390e0c.5.1769614603205; Wed, 28 Jan 2026
 07:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127180109.66691-1-dorjoychy111@gmail.com>
 <20260127180109.66691-2-dorjoychy111@gmail.com> <1c6cccc3e058ef16fa8b296ef6126b76a12db136.camel@kernel.org>
In-Reply-To: <1c6cccc3e058ef16fa8b296ef6126b76a12db136.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Wed, 28 Jan 2026 21:36:32 +0600
X-Gm-Features: AZwV_QiDjM_g9KAizMTQulrKnRDV0aYq3Xvzi08IzeHbbXpwKcddpiK7UH_xub8
Message-ID: <CAFfO_h5yrXR0-igVayH0ent1t12rm=6DUEGjUDW0zqfqy3=ZoQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] open: new O_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75744-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,oracle.com,gmail.com,arndb.de,dilger.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dorjoychy111@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E8D37A4137
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 5:52=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Tue, 2026-01-27 at 23:58 +0600, Dorjoy Chowdhury wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being tricke=
d
> > into opening device nodes with special semantics while thinking they
> > operate on regular files.
> >
> > A corresponding error code ENOTREG has been introduced. For example, if
> > open is called on path /dev/null with O_REGULAR in the flag param, it
> > will return -ENOTREG.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -ENOTREG is returned.
> >
> > -EINVAL is returned when O_REGULAR is combined with O_DIRECTORY (not
> > part of O_TMPFILE) because it doesn't make sense to open a path that
> > is both a directory and a regular file.
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  arch/alpha/include/uapi/asm/errno.h        | 2 ++
> >  arch/alpha/include/uapi/asm/fcntl.h        | 1 +
> >  arch/mips/include/uapi/asm/errno.h         | 2 ++
> >  arch/parisc/include/uapi/asm/errno.h       | 2 ++
> >  arch/parisc/include/uapi/asm/fcntl.h       | 1 +
> >  arch/sparc/include/uapi/asm/errno.h        | 2 ++
> >  arch/sparc/include/uapi/asm/fcntl.h        | 1 +
> >  fs/fcntl.c                                 | 2 +-
> >  fs/namei.c                                 | 6 ++++++
> >  fs/open.c                                  | 4 +++-
> >  include/linux/fcntl.h                      | 2 +-
> >  include/uapi/asm-generic/errno.h           | 2 ++
> >  include/uapi/asm-generic/fcntl.h           | 4 ++++
> >  tools/arch/alpha/include/uapi/asm/errno.h  | 2 ++
> >  tools/arch/mips/include/uapi/asm/errno.h   | 2 ++
> >  tools/arch/parisc/include/uapi/asm/errno.h | 2 ++
> >  tools/arch/sparc/include/uapi/asm/errno.h  | 2 ++
> >  tools/include/uapi/asm-generic/errno.h     | 2 ++
> >  18 files changed, 38 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/alpha/include/uapi/asm/errno.h b/arch/alpha/include/u=
api/asm/errno.h
> > index 6791f6508632..8bbcaa9024f9 100644
> > --- a/arch/alpha/include/uapi/asm/errno.h
> > +++ b/arch/alpha/include/uapi/asm/errno.h
> > @@ -127,4 +127,6 @@
> >
> >  #define EHWPOISON    139     /* Memory page has hardware error */
> >
> > +#define ENOTREG              140     /* Not a regular file */
> > +
> >  #endif
> > diff --git a/arch/alpha/include/uapi/asm/fcntl.h b/arch/alpha/include/u=
api/asm/fcntl.h
> > index 50bdc8e8a271..4da5a64c23bd 100644
> > --- a/arch/alpha/include/uapi/asm/fcntl.h
> > +++ b/arch/alpha/include/uapi/asm/fcntl.h
> > @@ -34,6 +34,7 @@
> >
> >  #define O_PATH               040000000
> >  #define __O_TMPFILE  0100000000
> > +#define O_REGULAR    0200000000
> >
> >  #define F_GETLK              7
> >  #define F_SETLK              8
> > diff --git a/arch/mips/include/uapi/asm/errno.h b/arch/mips/include/uap=
i/asm/errno.h
> > index c01ed91b1ef4..293c78777254 100644
> > --- a/arch/mips/include/uapi/asm/errno.h
> > +++ b/arch/mips/include/uapi/asm/errno.h
> > @@ -126,6 +126,8 @@
> >
> >  #define EHWPOISON    168     /* Memory page has hardware error */
> >
> > +#define ENOTREG              169     /* Not a regular file */
> > +
> >  #define EDQUOT               1133    /* Quota exceeded */
> >
> >
> > diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include=
/uapi/asm/errno.h
> > index 8cbc07c1903e..442917484f99 100644
> > --- a/arch/parisc/include/uapi/asm/errno.h
> > +++ b/arch/parisc/include/uapi/asm/errno.h
> > @@ -124,4 +124,6 @@
> >
> >  #define EHWPOISON    257     /* Memory page has hardware error */
> >
> > +#define ENOTREG              258     /* Not a regular file */
> > +
> >  #endif
> > diff --git a/arch/parisc/include/uapi/asm/fcntl.h b/arch/parisc/include=
/uapi/asm/fcntl.h
> > index 03dee816cb13..0cc3320fe326 100644
> > --- a/arch/parisc/include/uapi/asm/fcntl.h
> > +++ b/arch/parisc/include/uapi/asm/fcntl.h
> > @@ -19,6 +19,7 @@
> >
> >  #define O_PATH               020000000
> >  #define __O_TMPFILE  040000000
> > +#define O_REGULAR    0100000000
> >
> >  #define F_GETLK64    8
> >  #define F_SETLK64    9
> > diff --git a/arch/sparc/include/uapi/asm/errno.h b/arch/sparc/include/u=
api/asm/errno.h
> > index 4a41e7835fd5..8dce0bfeab74 100644
> > --- a/arch/sparc/include/uapi/asm/errno.h
> > +++ b/arch/sparc/include/uapi/asm/errno.h
> > @@ -117,4 +117,6 @@
> >
> >  #define EHWPOISON    135     /* Memory page has hardware error */
> >
> > +#define ENOTREG              136     /* Not a regular file */
> > +
> >  #endif
> > diff --git a/arch/sparc/include/uapi/asm/fcntl.h b/arch/sparc/include/u=
api/asm/fcntl.h
> > index 67dae75e5274..a93d18d2c23e 100644
> > --- a/arch/sparc/include/uapi/asm/fcntl.h
> > +++ b/arch/sparc/include/uapi/asm/fcntl.h
> > @@ -37,6 +37,7 @@
> >
> >  #define O_PATH               0x1000000
> >  #define __O_TMPFILE  0x2000000
> > +#define O_REGULAR    0x4000000
> >
> >  #define F_GETOWN     5       /*  for sockets. */
> >  #define F_SETOWN     6       /*  for sockets. */
> > diff --git a/fs/fcntl.c b/fs/fcntl.c
> > index f93dbca08435..62ab4ad2b6f5 100644
> > --- a/fs/fcntl.c
> > +++ b/fs/fcntl.c
> > @@ -1169,7 +1169,7 @@ static int __init fcntl_init(void)
> >        * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
> >        * is defined as O_NONBLOCK on some platforms and not on others.
> >        */
> > -     BUILD_BUG_ON(20 - 1 /* for O_RDONLY being 0 */ !=3D
> > +     BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=3D
> >               HWEIGHT32(
> >                       (VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
> >                       __FMODE_EXEC));
> > diff --git a/fs/namei.c b/fs/namei.c
> > index b28ecb699f32..f5504ae4b03c 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4616,6 +4616,10 @@ static int do_open(struct nameidata *nd,
> >               if (unlikely(error))
> >                       return error;
> >       }
> > +
> > +     if ((open_flag & O_REGULAR) && !d_is_reg(nd->path.dentry))
> > +             return -ENOTREG;
> > +
> >       if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dent=
ry))
> >               return -ENOTDIR;
> >
> > @@ -4765,6 +4769,8 @@ static int do_o_path(struct nameidata *nd, unsign=
ed flags, struct file *file)
> >       struct path path;
> >       int error =3D path_lookupat(nd, flags, &path);
> >       if (!error) {
> > +             if ((file->f_flags & O_REGULAR) && !d_is_reg(path.dentry)=
)
> > +                     return -ENOTREG;
> >               audit_inode(nd->name, path.dentry, 0);
> >               error =3D vfs_open(&path, file);
> >               path_put(&path);
> > diff --git a/fs/open.c b/fs/open.c
> > index 74c4c1462b3e..82153e21907e 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -1173,7 +1173,7 @@ struct file *kernel_file_open(const struct path *=
path, int flags,
> >  EXPORT_SYMBOL_GPL(kernel_file_open);
> >
> >  #define WILL_CREATE(flags)   (flags & (O_CREAT | __O_TMPFILE))
> > -#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CL=
OEXEC)
> > +#define O_PATH_FLAGS         (O_DIRECTORY | O_NOFOLLOW | O_PATH | O_CL=
OEXEC | O_REGULAR)
> >
> >  inline struct open_how build_open_how(int flags, umode_t mode)
> >  {
> > @@ -1250,6 +1250,8 @@ inline int build_open_flags(const struct open_how=
 *how, struct open_flags *op)
> >                       return -EINVAL;
> >               if (!(acc_mode & MAY_WRITE))
> >                       return -EINVAL;
> > +     } else if ((flags & O_DIRECTORY) && (flags & O_REGULAR)) {
> > +             return -EINVAL;
> >       }
> >       if (flags & O_PATH) {
> >               /* O_PATH only permits certain other flags to be set. */
> > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > index a332e79b3207..4fd07b0e0a17 100644
> > --- a/include/linux/fcntl.h
> > +++ b/include/linux/fcntl.h
> > @@ -10,7 +10,7 @@
> >       (O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_T=
RUNC | \
> >        O_APPEND | O_NDELAY | O_NONBLOCK | __O_SYNC | O_DSYNC | \
> >        FASYNC | O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> > -      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > +      O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_REGULAR)
> >
> >  /* List of all valid flags for the how->resolve argument: */
> >  #define VALID_RESOLVE_FLAGS \
> > diff --git a/include/uapi/asm-generic/errno.h b/include/uapi/asm-generi=
c/errno.h
> > index 92e7ae493ee3..2216ab9aa32e 100644
> > --- a/include/uapi/asm-generic/errno.h
> > +++ b/include/uapi/asm-generic/errno.h
> > @@ -122,4 +122,6 @@
> >
> >  #define EHWPOISON    133     /* Memory page has hardware error */
> >
> > +#define ENOTREG              134     /* Not a regular file */
> > +
> >  #endif
> > diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generi=
c/fcntl.h
> > index 613475285643..3468b352a575 100644
> > --- a/include/uapi/asm-generic/fcntl.h
> > +++ b/include/uapi/asm-generic/fcntl.h
> > @@ -88,6 +88,10 @@
> >  #define __O_TMPFILE  020000000
> >  #endif
> >
> > +#ifndef O_REGULAR
> > +#define O_REGULAR    040000000
> > +#endif
> > +
> >  /* a horrid kludge trying to make sure that this will fail on old kern=
els */
> >  #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
> >
> > diff --git a/tools/arch/alpha/include/uapi/asm/errno.h b/tools/arch/alp=
ha/include/uapi/asm/errno.h
> > index 6791f6508632..8bbcaa9024f9 100644
> > --- a/tools/arch/alpha/include/uapi/asm/errno.h
> > +++ b/tools/arch/alpha/include/uapi/asm/errno.h
> > @@ -127,4 +127,6 @@
> >
> >  #define EHWPOISON    139     /* Memory page has hardware error */
> >
> > +#define ENOTREG              140     /* Not a regular file */
> > +
> >  #endif
> > diff --git a/tools/arch/mips/include/uapi/asm/errno.h b/tools/arch/mips=
/include/uapi/asm/errno.h
> > index c01ed91b1ef4..293c78777254 100644
> > --- a/tools/arch/mips/include/uapi/asm/errno.h
> > +++ b/tools/arch/mips/include/uapi/asm/errno.h
> > @@ -126,6 +126,8 @@
> >
> >  #define EHWPOISON    168     /* Memory page has hardware error */
> >
> > +#define ENOTREG              169     /* Not a regular file */
> > +
> >  #define EDQUOT               1133    /* Quota exceeded */
> >
> >
> > diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/pa=
risc/include/uapi/asm/errno.h
> > index 8cbc07c1903e..442917484f99 100644
> > --- a/tools/arch/parisc/include/uapi/asm/errno.h
> > +++ b/tools/arch/parisc/include/uapi/asm/errno.h
> > @@ -124,4 +124,6 @@
> >
> >  #define EHWPOISON    257     /* Memory page has hardware error */
> >
> > +#define ENOTREG              258     /* Not a regular file */
> > +
> >  #endif
> > diff --git a/tools/arch/sparc/include/uapi/asm/errno.h b/tools/arch/spa=
rc/include/uapi/asm/errno.h
> > index 4a41e7835fd5..8dce0bfeab74 100644
> > --- a/tools/arch/sparc/include/uapi/asm/errno.h
> > +++ b/tools/arch/sparc/include/uapi/asm/errno.h
> > @@ -117,4 +117,6 @@
> >
> >  #define EHWPOISON    135     /* Memory page has hardware error */
> >
> > +#define ENOTREG              136     /* Not a regular file */
> > +
> >  #endif
> > diff --git a/tools/include/uapi/asm-generic/errno.h b/tools/include/uap=
i/asm-generic/errno.h
> > index 92e7ae493ee3..2216ab9aa32e 100644
> > --- a/tools/include/uapi/asm-generic/errno.h
> > +++ b/tools/include/uapi/asm-generic/errno.h
> > @@ -122,4 +122,6 @@
> >
> >  #define EHWPOISON    133     /* Memory page has hardware error */
> >
> > +#define ENOTREG              134     /* Not a regular file */
> > +
> >  #endif
>
> One thing this patch is missing is handling for ->atomic_open(). I
> imagine most of the filesystems that provide that op can't support
> O_REGULAR properly (maybe cifs can? idk). What you probably want to do
> is add in some patches that make all of the atomic_open operations in
> the kernel return -EINVAL if O_REGULAR is set.
>
> Then, once the basic support is in, you or someone else can go back and
> implement support for O_REGULAR where possible.

Thank you for the feedback. I don't quite understand what I need to
fix. I thought open system calls always create regular files, so
atomic_open probably always creates regular files? Can you please give
me some more details as to where I need to fix this and what the
actual bug here is that is related to atomic_open?  I think I had done
some normal testing and when using O_CREAT | O_REGULAR, if the file
doesn't exist, the file gets created and the file that gets created is
a regular file, so it probably makes sense? Or should the behavior be
that if file doesn't exist, -EINVAL is returned and if file exists it
is opened if regular, otherwise -ENOTREG is returned?

Regards,
Dorjoy

