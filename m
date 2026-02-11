Return-Path: <linux-fsdevel+bounces-76921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHkGJGLki2kVcgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:07:30 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07FDF120B02
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 03:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94FEF3054677
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3612F6900;
	Wed, 11 Feb 2026 02:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kwMQgQTm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D982F6574
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 02:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770775647; cv=pass; b=jP9+5ze3b9TqzwTSA2SkmG/YbI+ieepy80uG6ROaVhy4vjI78Kybur9VHlbb/XM2ZaJ5lSssPpLG+z9zmo69ILiyCTQ+bhqqA0mOx8ZT8Izp6eub5enTqPEIjE+ZZWnGSiIJz6ljF8ze4tPuaXZMTMFonXmV2uc4tqcu1koT6V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770775647; c=relaxed/simple;
	bh=AxBXb5SCGivO3xfe6IfaEGDChh6p7TOiflwqConeq6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlygmGaJPkiQqBwtLJHkbvjbClFxQUBZ5KPXiUZfeeNRFsNCU615H6Ve0PmZgKDdq5RhmBD+/xhNyzYCzJfM0AFKfjjxPhy513FYh/uaBsbQlrskD1X1Mcw6l3JBazh1brzD0BJO4m1fKgVv8BqwVy9zprtg7qTmgUQaNmoTtPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kwMQgQTm; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65a3a1740e7so3363a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 18:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770775644; cv=none;
        d=google.com; s=arc-20240605;
        b=kPVoC7aCIH+3Ko2fzQX05ZIsNmANWVtFHf3shln+aFwcwUfE7sQyqUkr2MF9ykKT+E
         oDQFeW8IBHDQDDO8AUAGX9OgGqQcGfGJBQBqQgBEVv5ycqpMKzISHZIGXQ7OfccBttYd
         Io9TjyECjjbot9U45VojjxrR+APX3ZEYWt6Pn2OPN3OGxSifm2qq04BGxWsKhLKnG20p
         zDV+vVbFCwgsIN++RZ3I1N4kuk7AAZR/FyJV3jf1Hg/Tn7EV45SNr4aZx+WeUfNykDfN
         zjuMGr55507KOkdZd/If7b376PMEVwIpaJj7am0hshUni9PHi8X3NAvHnYrJ6xurIrnp
         DUNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mJabroHKALl1X22f8hKKr+ilxhz+jnb/D5nxpOzqNdI=;
        fh=Vtwpl/oKrWJoy4M0ropZhiAzogRvzgJdKDVNc3ua86c=;
        b=eXhSSzuCXbSTmZ6E6ppQcCISFho8pVVTgmtByoC1xJftXwC7viL7MF2sIZNxZP8xnj
         qMO+qzBECu6moAza8ZLpjYSA7DajuR3pGmi2uSIZ5AJbPlc7tm2nDIprxiUgplgRYbAx
         70d53VrJ8rqu4IioL9OfQKTXNAowMPRWtODBDc6pnwoXkgCRjwNJo9Mwk/Y0bm9V85M6
         wDIisRh82dkSv3a+cg995sBdaHOh5kC7DKPdi/TAYQ9qN3ZsMAyH/d2KrKP9S6GnC5/z
         5eIKyJt6Fzzsih9u2UZJEjVEmR/jf/deqHveKifx8bfGrlGpJx0OQw8UrUWu811J3Mvn
         6GnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770775644; x=1771380444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJabroHKALl1X22f8hKKr+ilxhz+jnb/D5nxpOzqNdI=;
        b=kwMQgQTmJfN9PVA0aEgm0CgVfM1+JON/K003EM+EmfGKnX72epEWd0CHvjFm/s0kOm
         gOwJE+ZrG4mZ2h31ZZ7mOqL/ekc6sMFLMDOxWWm7s9SqI7kXMSIpaCiCGA4uaXeRRyaB
         zMr3zgEESWKn/rBW4m6EJRocF/tvnEBkVECRkZOKceEM7ValV1cID9IwzQC/MqvUsPgR
         DOGzkulQmvWaTHxpfi/jxiST5gVDCws0t6gzbNcDcbnwGJ2ii+90mcaCKblH/g+4hIwW
         omXaBMNImLI0Uj4GeNp6ec3fAIM+YIkEndhIR1v1whfctqlWMjoJgRyWLWnnWK/rMf0X
         wF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770775644; x=1771380444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mJabroHKALl1X22f8hKKr+ilxhz+jnb/D5nxpOzqNdI=;
        b=cmOa8rAj1cYNxIgQHWV+gCNyc6XSx8gQeuO3AjKCdQz8cNtlsUWd0r1JA6tBgTQfwe
         y6fs1MxAg8PXWkWg/KVV9CpCjE40KqjiPrRiNn43uKO+9kYrYHcbOg2cNauAmw2w0CFP
         tkJe/1lNnWAFjA+UU1gOKWkggMCUwfo+YUVAQFsYMG+6tvtxtGdG6EmXbJbLnhOaQx3r
         D51GdVxlvdwFFoOqkemP/URQe1pwkUY4FpSGX+2bavBQMo51aDsW4/vNcyzZdFSwj9H+
         2YktWlkQW7NVyRPhyQcJ2IE+vjd1+h2RpbZ9s6F/0D0JyHDeMm7zQ9yX2Ok7a/QBN+pU
         Xmwg==
X-Forwarded-Encrypted: i=1; AJvYcCX+eI7h7QkZYoW1MbYLlguRV20fNNMxVQKGuZ9PGgouhNcgAM4N5c+VxBuRO70ou5Q6pzy7TxBKHlJP8+2u@vger.kernel.org
X-Gm-Message-State: AOJu0YwuVtPcKYrJkJ8RsT1bJVv1pZeVgWFVWb4s3yLccagU98sd3/G3
	UMqms25WUl9Z2lS1vV/fd/oG9pmT4YBkCydP4H2KnXJPoOZEHvH356aC98cebu+xnEz3EyBD21y
	4xjWVy3amagtoJhn9/JTd5o96xN9vsdsJ1lfeVaeK
X-Gm-Gg: AZuq6aJEJc+2hAbdYhgFJ/YP5/vfnafjEgdyWTt14/A9IT/X+8bDOuIOAqy2nzDeG05
	JVK3lY5sIT0/DKDoMXOSIYZsew4qtdLMxKnYztaelp1AaV2p+9smQG4Aw+LpbzZ+1rz/Ezre/4w
	qzUt95ioDg1ripejeBo99pYGgcef0pnltYHxcSGjC3D48cZBBstoah3/ke09qM0Nlq9IgK3Hi47
	8asdMCzyDPB8QCOWgHHYMhIiHwB5p2NjcTDeqGCiXehZqRipquAcYF2Xg0y06tCpAqWL4DRgOHC
	T8FgXJTwz0aZG6JB5Dhxp4kovB5BbqFl6SxadJXB4WmN6E4=
X-Received: by 2002:aa7:cf01:0:b0:65a:14a1:b1b9 with SMTP id
 4fb4d7f45d1cf-65a3c82019emr9271a12.7.1770775643972; Tue, 10 Feb 2026 18:07:23
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211004811.work.981-kees@kernel.org> <CAG48ez1GYR+6kZHDmy4CTZvEfdyUySCxhZaXRo1S=YyN=Fsp8Q@mail.gmail.com>
 <202602101736.80F1783@keescook>
In-Reply-To: <202602101736.80F1783@keescook>
From: Jann Horn <jannh@google.com>
Date: Wed, 11 Feb 2026 03:06:47 +0100
X-Gm-Features: AZwV_QjPTRHY7ecu-LGBz6_R6c4vMFqAvHTO5CIG3USeS7WeOghwX1xpcWJ5bfc
Message-ID: <CAG48ez1wxj5uxuMXQLV+yxfT4gumNSoK8UX2+K=5aCLAKg+VPg@mail.gmail.com>
Subject: Re: [PATCH] fs: Keep long filenames in isolated slab buckets
To: Kees Cook <kees@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-76921-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,linux.org.uk:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 07FDF120B02
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 2:41=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Wed, Feb 11, 2026 at 02:28:53AM +0100, Jann Horn wrote:
> > On Wed, Feb 11, 2026 at 1:48=E2=80=AFAM Kees Cook <kees@kernel.org> wro=
te:
> > > A building block of Use-After-Free heap memory corruption attacks is
> > > using userspace controllable kernel allocations to fill specifically =
sized
> > > kmalloc regions with specific contents. The most powerful of these ki=
nds
> > > of primitives is arbitrarily controllable contents with arbitrary siz=
e.
> > > Keeping these kinds of allocations out of the general kmalloc buckets=
 is
> > > needed to harden the kernel against such manipulations, so this is wh=
y
> > > these sorts of "copy data from userspace into kernel heap" situations=
 are
> > > expected to use things like memdup_user(), which keeps the allocation=
s
> > > in their own set of slab buckets. However, using memdup_user() is not
> > > always appropriate, so in those cases, kmem_buckets can used directly=
.
> > >
> > > Filenames used to be isolated in their own (fixed size) slab cache so
> > > they would not end up in the general kmalloc buckets (which made them
> > > unusable for the heap grooming method described above). After commit
> > > 8c888b31903c ("struct filename: saner handling of long names"), filen=
ames
> > > were being copied into arbitrarily sized kmalloc regions in the gener=
al
> > > kmalloc buckets. Instead, like memdup_user(), use a dedicated set of
> > > kmem buckets for long filenames so we do not introduce a new way for
> > > attackers to place arbitrary contents into the general kmalloc bucket=
s.
> > >
> > > Fixes: 8c888b31903c ("struct filename: saner handling of long names")
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > > ---
> > > Also, from the same commit, is the loss of SLAB_HWCACHE_ALIGN|SLAB_PA=
NIC
> > > for filename allocations relavant at all? It could be added back for
> > > these buckets if desired, but I left it default in this patch.
> > >
> > > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > > Cc: Christian Brauner <brauner@kernel.org>
> > > Cc: Jan Kara <jack@suse.cz>
> > > Cc: <linux-fsdevel@vger.kernel.org>
> > > ---
> > >  fs/namei.c | 10 +++++++---
> > >  1 file changed, 7 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 8e7792de0000..a901733380cd 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -128,6 +128,8 @@
> > >  /* SLAB cache for struct filename instances */
> > >  static struct kmem_cache *__names_cache __ro_after_init;
> > >  #define names_cache    runtime_const_ptr(__names_cache)
> > > +/* SLAB buckets for long names */
> > > +static kmem_buckets *names_buckets __ro_after_init;
> > >
> > >  void __init filename_init(void)
> > >  {
> > > @@ -135,6 +137,8 @@ void __init filename_init(void)
> > >                          SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(stru=
ct filename, iname),
> > >                          EMBEDDED_NAME_MAX, NULL);
> > >         runtime_const_init(ptr, __names_cache);
> > > +
> > > +       names_buckets =3D kmem_buckets_create("names_bucket", 0, 0, P=
ATH_MAX, NULL);
> > >  }
> > >
> > >  static inline struct filename *alloc_filename(void)
> > > @@ -156,7 +160,7 @@ static inline void initname(struct filename *name=
)
> > >  static int getname_long(struct filename *name, const char __user *fi=
lename)
> > >  {
> > >         int len;
> > > -       char *p __free(kfree) =3D kmalloc(PATH_MAX, GFP_KERNEL);
> > > +       char *p __free(kfree) =3D kmem_buckets_alloc(names_buckets, P=
ATH_MAX, GFP_KERNEL);
> > >         if (unlikely(!p))
> > >                 return -ENOMEM;
> >
> > I think this path, where we always do maximally-sized allocations, is
> > the normal case where we're handling paths coming from userspace...
>
> Actually, is there any reason we can't use strnlen_user() in
> do_getname(), and then just use strndup_user() in the long case?

I'm not an expert, but as far as I know, this path is supposed to be
really fast (because pretty much every syscall that operates on a path
will hit it), and doesn't care how much memory it allocates (because
these allocations are normally only alive for the duration of a
syscall). strnlen_user() would add another pass over the userspace
buffer, which I think would probably have negative performance impact?

> > > @@ -264,14 +268,14 @@ static struct filename *do_getname_kernel(const=
 char *filename, bool incomplete)
> > >
> > >         if (len <=3D EMBEDDED_NAME_MAX) {
> > >                 p =3D (char *)result->iname;
> > > -               memcpy(p, filename, len);
> > >         } else {
> > > -               p =3D kmemdup(filename, len, GFP_KERNEL);
> > > +               p =3D kmem_buckets_alloc(names_buckets, len, GFP_KERN=
EL);
> >
> > ... while this is kind of the exceptional case, where paths are coming
> > from kernelspace.
> >
> > So you might want to get rid of the bucketing and instead just create
> > a single kmem_cache for long paths.
>
> I wasn't sure if there was a controllable way to reach this case or not.

I don't understand your point. I'm suggesting that in both of these
two cases, you can just allocate from the same dedicated slab.

But yes, you can get controlled data into the filename passed to
do_getname_kernel() - for example, when you execute a script (a file
that starts with "#!"), the interpreter path after "#!" is passed from
load_script() to open_exec(), which uses CLASS(filename_kernel, ...).

> > By the way, did you know that "struct filename" is only used for
> > storing fairly-temporary stuff like paths supplied to open(), but not
> > for storing the names of directory entries in the dentry cache (which
> > are more long-lived)? My understanding is that this is also why the
> > kernel doesn't really try to optimize the size of "struct filename" -
> > almost all instances of it only exist for the duration of a syscall or
> > something like that.
>
> Right, but it was enough of a location change that I felt like it was
> worth fixing it up.
>
> > The dentry cache allocates long names as "struct external_name" in
> > reclaimable kmalloc slabs, see __d_alloc().
>
> Oh hey, look at that!
>
>                 struct external_name *p =3D kmalloc(size + name->len,
>                                                   GFP_KERNEL_ACCOUNT |
>                                                   __GFP_RECLAIMABLE);
>
> Yeah, let's put that into dedicated buckets instead?

Actually, looking around a bit, there really aren't that many
allocations with __GFP_RECLAIMABLE, so this probably isn't all that
useful for same-cache attacks. (To be clear: Anything with
__GFP_RECLAIMABLE goes in the special kmalloc-rcl-* slabs.) Looking
around, the only other kmalloc users of __GFP_RECLAIMABLE I see are:

 - alloc_buffer_data() in drivers/md/dm-bufio.c
 - fuse_dentry_init()

So I don't think there's anything to be done here, this is already
using quasi-dedicated buckets. Sorry for the distraction.

