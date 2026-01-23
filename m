Return-Path: <linux-fsdevel+bounces-75306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJcaOfygc2lqxgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 17:25:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6583678787
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 17:25:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0A91A300A5B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4742ECEAC;
	Fri, 23 Jan 2026 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmBsKrrw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F32221FBB
	for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 16:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769185090; cv=pass; b=GMsfI/aVXK6DnxjYO7ktq5vOQ74IFws/eDvjO4vUevR9DNcfOD/9XQfPTzg1gVVYDAe8hhOcY+9FUTd/2lRftrHtos6fuRifnhoAOUNAyDOrXAlprjpw2VmrX2d5BahH28D2iUgNbOTLt6bDFf6wG2OUNZLcEWYTWOldxNY5Wgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769185090; c=relaxed/simple;
	bh=i1DgHFPVQs585Y/CMYf6OR1vJUwohrUAbbhDHuwzReQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKa8yE/qBkJo8T/+d5mvftWdAgX0Tu8G+BqvN0Y3krMejXYjSf+vXAFRgMRmNb9qSg6AhpKoSgfFi30zyYjaBN/rBOCRfAuBWlddYy3J+Jk+AtziCS38vipD5zCVLzWH+DrKg6cb4h8kKCfLz3Mq/Q/rRr9xl/Q749QVYcyYwgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmBsKrrw; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-655af782859so4965007a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jan 2026 08:18:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769185087; cv=none;
        d=google.com; s=arc-20240605;
        b=Z1hZvh5fBgIlVcyoINf4a4btnMWlBppLoVynlXgdeIBG3KRgvXqUhQ8PfztaUuAifp
         wGnAs+I/rXnXzEeXeLa0dR3gKd6mJ9k3tKBpZ+kxwRn3uXIgWowRb7MiVyV+TDJi4qqF
         CZqRDUQkxavKWT3nmfB/EpZuW15djiMffsAwvfKpWOwZ0/sbag2r6/+q3Ovr2A+FWvRj
         CksptS7Oq7Rou0VGxcubjxvS02ra0I5mL9vyM9LZZAspcmMgkm4tpTYpM6H7NhsBLxae
         57VOs74Rw9thevTxjth7ANYJDD/tj1vLnvIUsjlRoMnC1sM+HMvnQh/9iOSju7U6j4pf
         HoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SD96aPMrtfgiGYDqqmsl9arCwgbWOGoG/7A1lxl2uyM=;
        fh=wkgDz3o9PilJPGC7c0UdDdwP82NNuokoMPti8gQbtHA=;
        b=gqDjKPeA/oWD8cbxNEMCZdn2OQIuq8Is9ptRyTUlqhblBMMajnYD9F4thyWyYTcxqh
         WuRPtbvlaX8d9ft3bPFPZOhGD4j6dqp5UfqIx+kdjCvft5S83a5VmvhAeWFkv/KxyUV4
         Q/WnNyp1rdzTL4F4q0vOPeMF/QARa4IqsigCYFb2jVitecsFKsuemLuvmUgFQ2CxRnPJ
         0V6RtqV9P68r0bouZ3GEc+jeNg5uKkOyYQ4kGMReCYS/JtasbEXptYDjYGMryf5l06ft
         kxqzmlzrTT0sGgWc6lkHUiiYEeusGscDUuFgxqoP+Rsh1zjMR5JaqrkL1wSrMVaRmzab
         hUIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769185087; x=1769789887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SD96aPMrtfgiGYDqqmsl9arCwgbWOGoG/7A1lxl2uyM=;
        b=CmBsKrrwuSb63REZc9m/y30AsddIV3Q0w5iPVGIdlEV6+9jLdXfsg8P367Cp1qSw18
         SELvAZo1WV7jEQiE0ZY3ziTdBNG2wW2U/4GPGYGOhlmfI/xhZ6B0RFzdzfDmoNlHUbET
         pMwiQYh/T1F5xDgArUZ5ZpKwgocwteXBFArKMMzwLaNg2GU7G8iZMaYQhtf04RbPYeXC
         3HeCTI9bhIb4XBghuYfZJiQ2/9BaiSouBDXkIKILGT2++BlmY9eOtaj+pM3UAW6JnKCy
         l2VwOaSzB56UjmiTgXL38ZWhc1X+kJMnyT6OwkailxwYimYV5DpDsKu0+Peio2YCo/GR
         WgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769185087; x=1769789887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SD96aPMrtfgiGYDqqmsl9arCwgbWOGoG/7A1lxl2uyM=;
        b=KypbiGQpk1DMPKnoUs/3e7pCJn2bF7JmeuV4qCAC1cgIAl5VhSQh9iPxAtjLzl7QJl
         1NfgTpltG5oBGzeHai34Ut9CbhEh39eaMohPuCsfQxIVSS1Rkwg0RVBUubKTCP/oSqOQ
         ORta473SFzNgAoCAKfAcpRWkHREBTml2N899CpLfInFeRhtVoNk0zHoX1ctoei0lMuhP
         R1Rl34kzdrCJiFhvDtuW1vx8IF20k2LT/wWNbNwtqdNq2Y4qirG2CXunmSMAKNH3Fs2x
         VvjN1BquwhcL01GRhuSqGli96gOi4poGKSoWRedMd5OXaGcpmpLnmskPWGTAUODWYsZK
         5x2g==
X-Forwarded-Encrypted: i=1; AJvYcCXSmL/yCntucqUJi6lWs/oMmkzOpFcVybj9q5jqgOtlEqux0HS2plyGvESVi8F8e6ff4qLfzz7mOrypgZeT@vger.kernel.org
X-Gm-Message-State: AOJu0YxIHmizrmBYoYkBYXXUB1Wl80hlippsrcp+DDJuZ+ajJ30X4nHL
	lA6FHfWfEm+S5ljiC7B6UXshcXLRI7mdDosIiadWifwWpjvlrKM4IqnIIgCAg0soDRDAVwa/3C4
	jvSK+fbUWX59JS1ZLAKhMxIIWKnsKDXY=
X-Gm-Gg: AZuq6aIkVrp8cyjdVVS8L+sQq7RI4MMZ41RPtpV6MlKlIM+lEwNQACMlgMatMfgAXwP
	AW7bG5bIcA/aUdA/oQmjAbqmL0pFzJ0s5zSAEmNSFkr9UNkExry99wI3PmAfreSwyV+axLbsF6/
	RKenlOPXBiL30L3mMo3gLtIfjTpIsDpYFuWev0bBXoyZfvt2sAHNlNTwseDHAgasbEa7NwoKVym
	2kdUjj2MraYSitWGJYDJrw6mPuK5Y7SkyMJa+ahit3xf8eHhhrYrjLXGlEzTPCSyIR6qj7N8QQ4
	AsjRQUbuW6a5/IYqF+wD7NbP4J+YWdmD//HR/g==
X-Received: by 2002:a05:6402:234a:b0:64d:d85:4c75 with SMTP id
 4fb4d7f45d1cf-65853d198d9mr1322645a12.12.1769185086965; Fri, 23 Jan 2026
 08:18:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120184539.1480930-1-mjguzik@gmail.com> <20260123-entledigen-kippt-045f9e533397@brauner>
In-Reply-To: <20260123-entledigen-kippt-045f9e533397@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 23 Jan 2026 17:17:54 +0100
X-Gm-Features: AZwV_QhFFfoK7vfdjm3cm3KA9qtog-FQrZXtSn7PqJ-jP42ujuH89zc_onJDtUM
Message-ID: <CAGudoHET9YLe9E9j5kTadhFtF=7j+9jNJj6TaQG4vukRp9ivfw@mail.gmail.com>
Subject: Re: [PATCH] pidfs: implement ino allocation without the pidmap lock
To: Christian Brauner <brauner@kernel.org>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-75306-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mjguzik@gmail.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6583678787
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 1:06=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Tue, Jan 20, 2026 at 07:45:39PM +0100, Mateusz Guzik wrote:
> > This paves the way for scalable PID allocation later.
> >
> > The 32 bit variant merely takes a spinlock for simplicity, the 64 bit
> > variant uses a scalable scheme.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >
> > this patch assumes the rb -> rhashtable conversion landed
> >
> > i booted the 32 bit code on the 64 bit kernel, i take it its fine
> >
> > I'm slightly worried about error handling. It seems pid->pidfs_hash.nex=
t
> > =3D NULL is supposed to sort it out.
>
> r
> >
> > Given that ino of 0 is not legal, I think it should be used as a
> > sentinel value for presence in the table instead.
> >
> > so something like:
> >
> > alloc_pid:
> > pid->ino =3D 0;
> > ....
> >
> > then:
> >
> > void pidfs_remove_pid(struct pid *pid)
> > {
> >         if (unlikely(!pid->ino))
> >                 return;
> >         rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> >                                pidfs_ino_ht_params);
> > }
>
> All fine, but we should probably just use DEFINE_COOKIE() and accept
> that numbering starts at 1 for 64-bit. Does the below look good to you
> too?
>
> From aaaa5cbb6e6920854aaee0ed59382d71614e785e Mon Sep 17 00:00:00 2001
> From: Mateusz Guzik <mjguzik@gmail.com>
> Date: Tue, 20 Jan 2026 19:45:39 +0100
> Subject: [PATCH] pidfs: implement ino allocation without the pidmap lock
>
> This paves the way for scalable PID allocation later.
>
> The 32 bit variant merely takes a spinlock for simplicity, the 64 bit
> variant uses a scalable scheme.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> Link: https://patch.msgid.link/20260120184539.1480930-1-mjguzik@gmail.com
> Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/pidfs.c   | 115 ++++++++++++++++++++++++++++++++++-----------------
>  kernel/pid.c |   3 +-
>  2 files changed, 78 insertions(+), 40 deletions(-)
>
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index ee0e36dd29d2..3e7e7bdda780 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -23,6 +23,7 @@
>  #include <linux/coredump.h>
>  #include <linux/rhashtable.h>
>  #include <linux/xattr.h>
> +#include <linux/cookie.h>
>
>  #include "internal.h"
>  #include "mount.h"
> @@ -65,7 +66,39 @@ static const struct rhashtable_params pidfs_ino_ht_par=
ams =3D {
>         .automatic_shrinking    =3D true,
>  };
>
> +/*
> + * inode number handling
> + *
> + * On 64 bit nothing special happens. The 64bit number assigned
> + * to struct pid is the inode number.
> + *
> + * On 32 bit the 64 bit number assigned to struct pid is split
> + * into two 32 bit numbers. The lower 32 bits are used as the
> + * inode number and the upper 32 bits are used as the inode
> + * generation number.
> + *
> + * On 32 bit pidfs_ino() will return the lower 32 bit. When
> + * pidfs_ino() returns zero a wrap around happened. When a
> + * wraparound happens the 64 bit number will be incremented by 2
> + * so inode numbering starts at 2 again.
> + *
> + * On 64 bit comparing two pidfds is as simple as comparing
> + * inode numbers.
> + *
> + * When a wraparound happens on 32 bit multiple pidfds with the
> + * same inode number are likely to exist (This isn't a problem
> + * since before pidfs pidfds used the anonymous inode meaning
> + * all pidfds had the same inode number.). Userspace can
> + * reconstruct the 64 bit identifier by retrieving both the
> + * inode number and the inode generation number to compare or
> + * use file handles.
> + */
> +
>  #if BITS_PER_LONG =3D=3D 32
> +
> +DEFINE_SPINLOCK(pidfs_ino_lock);
> +static u64 pidfs_ino_nr =3D 2;
> +
>  static inline unsigned long pidfs_ino(u64 ino)
>  {
>         return lower_32_bits(ino);
> @@ -77,6 +110,18 @@ static inline u32 pidfs_gen(u64 ino)
>         return upper_32_bits(ino);
>  }
>
> +static inline u64 pidfs_alloc_ino(void)
> +{
> +       u64 ino;
> +
> +       spin_lock(&pidfs_ino_lock);
> +       if (pidfs_ino(pidfs_ino_nr) =3D=3D 0)
> +               pidfs_ino_nr +=3D 2;

this should + 1 for consistency with the 64 bit variant

> +       ino =3D pidfs_ino_nr++;
> +       spin_unlock(&pidfs_ino_lock);
> +       return ino;
> +}
> +
>  #else
>
>  /* On 64 bit simply return ino. */
> @@ -90,61 +135,55 @@ static inline u32 pidfs_gen(u64 ino)
>  {
>         return 0;
>  }
> +
> +DEFINE_COOKIE(pidfs_ino_cookie);
> +
> +static u64 pidfs_alloc_ino(void)
> +{
> +       u64 ino;
> +
> +       preempt_disable();
> +       ino =3D gen_cookie_next(&pidfs_ino_cookie);
> +       preempt_enable();
> +
> +       VFS_WARN_ON_ONCE(ino < 1);
> +       return ino;
> +}
> +
>  #endif
>
>  /*
> - * Allocate inode number and initialize pidfs fields.
> - * Called with pidmap_lock held.
> + * Initialize pidfs fields.
>   */
>  void pidfs_prepare_pid(struct pid *pid)
>  {
> -       static u64 pidfs_ino_nr =3D 2;
> -
> -       /*
> -        * On 64 bit nothing special happens. The 64bit number assigned
> -        * to struct pid is the inode number.
> -        *
> -        * On 32 bit the 64 bit number assigned to struct pid is split
> -        * into two 32 bit numbers. The lower 32 bits are used as the
> -        * inode number and the upper 32 bits are used as the inode
> -        * generation number.
> -        *
> -        * On 32 bit pidfs_ino() will return the lower 32 bit. When
> -        * pidfs_ino() returns zero a wrap around happened. When a
> -        * wraparound happens the 64 bit number will be incremented by 2
> -        * so inode numbering starts at 2 again.
> -        *
> -        * On 64 bit comparing two pidfds is as simple as comparing
> -        * inode numbers.
> -        *
> -        * When a wraparound happens on 32 bit multiple pidfds with the
> -        * same inode number are likely to exist (This isn't a problem
> -        * since before pidfs pidfds used the anonymous inode meaning
> -        * all pidfds had the same inode number.). Userspace can
> -        * reconstruct the 64 bit identifier by retrieving both the
> -        * inode number and the inode generation number to compare or
> -        * use file handles.
> -        */
> -       if (pidfs_ino(pidfs_ino_nr) =3D=3D 0)
> -               pidfs_ino_nr +=3D 2;
> -
> -       pid->ino =3D pidfs_ino_nr;
>         pid->pidfs_hash.next =3D NULL;
>         pid->stashed =3D NULL;
>         pid->attr =3D NULL;
> -       pidfs_ino_nr++;
>  }
>
>  int pidfs_add_pid(struct pid *pid)
>  {
> -       return rhashtable_insert_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> -                                     pidfs_ino_ht_params);
> +       int ret;
> +
> +       pid->ino =3D pidfs_alloc_ino();
> +       ret =3D rhashtable_insert_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> +                                    pidfs_ino_ht_params);
> +       /*
> +        * This is fine. The pid will not have a task attached to it so
> +        * no pidfd can be created for it. So we can unset the inode
> +        * number.
> +        */
> +       if (unlikely(ret))
> +               pid->ino =3D 0;

I would pid->ino =3D 0 unconditoinally in pidfs_prepare_pid. this
gurantees safe execution of pidfs_remove_pid even with pidfs_add_pid
did not get called

this removes the above comment as well

then pidfs_prepare_pid can also stop nullyifying the hash thing

then that's something i'm happy ti sing off on

> +       return ret;
>  }
>
>  void pidfs_remove_pid(struct pid *pid)
>  {
> -       rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> -                              pidfs_ino_ht_params);
> +       if (likely(pid->ino))
> +               rhashtable_remove_fast(&pidfs_ino_ht, &pid->pidfs_hash,
> +                                      pidfs_ino_ht_params);
>  }
>
>  void pidfs_free_pid(struct pid *pid)
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 6077da774652..dfa545a97c00 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -198,6 +198,7 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t=
 *arg_set_tid,
>                 INIT_HLIST_HEAD(&pid->tasks[type]);
>         init_waitqueue_head(&pid->wait_pidfd);
>         INIT_HLIST_HEAD(&pid->inodes);
> +       pidfs_prepare_pid(pid);
>
>         /*
>          * 2. perm check checkpoint_restore_ns_capable()
> @@ -313,8 +314,6 @@ struct pid *alloc_pid(struct pid_namespace *ns, pid_t=
 *arg_set_tid,
>         retval =3D -ENOMEM;
>         if (unlikely(!(ns->pid_allocated & PIDNS_ADDING)))
>                 goto out_free;
> -       pidfs_prepare_pid(pid);
> -
>         for (upid =3D pid->numbers + ns->level; upid >=3D pid->numbers; -=
-upid) {
>                 /* Make the PID visible to find_pid_ns. */
>                 idr_replace(&upid->ns->idr, pid, upid->nr);
> --
> 2.47.3
>

