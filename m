Return-Path: <linux-fsdevel+bounces-76917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CF8eDITbi2nMcAAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76917-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:29:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B70E120768
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 02:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 575CC3059ADC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Feb 2026 01:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD283288525;
	Wed, 11 Feb 2026 01:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xkAXTK6F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BA0286415
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Feb 2026 01:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770773374; cv=pass; b=Fvb9bc5ZDYFIG//hVhtpuXUmFnpmyG5Na6MEytRc6W0fyO997+iTthDo8YKfJhLLoYqIr9IeC6zesw5ptoVAFfcAjNGJUZik+l8nEW1J08r5nV4oqgqNED8YIypUKSqrtEU6XU6W0n75H+H6x3YL9CujVSB2W2gdyp66SP135Lk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770773374; c=relaxed/simple;
	bh=qPcsPEFBNihehnPF+Cns71ACRy30CkK7Nd4hn+r9XP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxAUvWlnmtIP3vfEiXOVEw5D+LbI+Qcf4YXBKnVUR7siMLwmYllEiXVCcwa3jN9yyrcNoyCQjoV53MF3chO6S1oiierurEwOdbozdZStfgR1POEUmD8/MNqeBKGT8Jkt7ld+l9hXqg8O3/H8Zs2GAX3DU9eIQ5Kyqkf9KoO2pgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xkAXTK6F; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-652fe3bf65aso2444a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Feb 2026 17:29:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770773370; cv=none;
        d=google.com; s=arc-20240605;
        b=KyIrLJ0T/19qjZQBml2CQhzlOfge1Y9QWEa2fPKDrxK/tVP6TEe6T0DCXmMzTvtqpS
         RB2euU7hSvYg4qe+QY61U8WXtq5Gy1HdKtVI5P/M6Qv03HJqihpUYAQ85TZS1GgG0rJ1
         eL5p5bDnWjGt+TVFW7J4X+IfLJocL/YhT0vFYGDpkXtYyb9pxftPIrLGKNIWCfNZhPhf
         OCm55GyNUhZuEug+mVHIG31T5+lPa61hMPUGQAOXq/TOfXQZEpISbt21VqaAy5AJQ+89
         sTTYGQiaHYd8t8/oxXekRQAWihKVIvv0gMdSdNe6zZZiZPqc+DcUL3D2JvCEd9OuJ/ed
         xHEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8ImABGGp9PxKOWR+p+P+PfGguTUlRP81TAKub83SFos=;
        fh=JxxyN5ZLsURlIcBL+KvYn0H1LhlwH5R5mfHmHF3ICik=;
        b=X4blC+4cUyLO3EfCnweIbDZ5GsGGhUZq6PR2FEG1gmQWCxRG3dd6gGjM1y/Ryn+8X6
         6ulWm4DzBnEv/1j9dP/I+FQ1g3hpJzToCQqUDySufK5+qASsRviqEuORhH9jkjIhpLrw
         ocNtGm3FrzU9R+dMJRvY66BsQW32dy/B2tKi66xxFWWlHSw+qFySzNjErir8sXdG1MVo
         sS4KqW38NqcafBZ0iTeoRO7L0/csJMMmA/ARkzGIpLsvRABoLvUsClCJSG0C9cFNdcpI
         +U4AbJ/DfwVc3fIP543xn+XN2+S2fQe62VB2Ig1gqFQRW1fSSzyOr6bgoAk3q4ehn/ZR
         eOTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770773370; x=1771378170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ImABGGp9PxKOWR+p+P+PfGguTUlRP81TAKub83SFos=;
        b=xkAXTK6FExNpSywfGt3ShJ6WS2Msw+YDL1p25lLvi/J1HSeauJS1qCD9hK8kd+Axgb
         st4wN4VPtSb31zdQfvTeaoguJeRMiQPRb+SmtIm/qMU0YyYh5H7AP3LL49RGwhsgxxOL
         Djd012HMkkdZ+e80BDEgELdtdluAZ1limUuxuMZAzO+iExqbbohj5xFEcKfogsem6qxZ
         vd4GWkctt0sMJfxL2V///ws1OOkGxn4QjFWWfu51+70aLXpVUGEcEyM1x8TMT2YGvIcC
         SToVhk6hejwQVPH34BlVo87Tdku7VRwT/vrrY40LTkaeTGWf413RQX6UQbCcuGYum0bj
         hOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770773370; x=1771378170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8ImABGGp9PxKOWR+p+P+PfGguTUlRP81TAKub83SFos=;
        b=obaOZTGXIzvgtSutDVym7pOyzE5I0uH+ywRvOVXGhtFusiioma0fyIajTVfP7VKvoK
         i7GBRSb089CI33mqLfrOsFF++C0CmdOF+xC+digmuaAa5qN862YwEfEfv/YwjhPlvcom
         TLXoxjVRoP8dVFUSGVfA008zFEjm2xGEeXHeolNHFLWIOo1B7h0krPosrMZtYRlQ8pI8
         H5AJ2dKIVS0uClP0d0o6PKekDGpL+GXy9M6bpfIhsuQ8ZlNHV7/HPXVgEwTGkIxzQdAK
         ouuHY3qb0nBDGoaxAB0mAC3Y2lUR+3wPWR41X6+HGtM0i5g4b0ZQYuErfeB2noHOu5va
         8Q0A==
X-Forwarded-Encrypted: i=1; AJvYcCVDVeiMuUOQutvtiJx2EeoEl3b5BYDREWCo2757hCP10814/h+bG8jl4DmTI/T+fYcYFIL3DCWCkDKspGsH@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9mHMBYndiQuOi95/0NOic7EqAKdcOsOQ/TwpLYQN3eP7L+6rV
	niHwHhJjLpL6bQHDNIpkDleuo++JrPfJCMxCDhFscHh2KPlmBCEQA7R2m6DRLDDmBqE5keQm0CD
	XNr2sA+Ap3hhWohBgc0H1txRJ0xlT1eYryOfRVo7s
X-Gm-Gg: AZuq6aIn/qyOmXMU2hh8qOi2Vh/O6ZKXdwS6A3MHSjCscyjd9sWTvBGYCrTdJWNTWo2
	IgtplwDufCiDEAhFuOk6h29LMPL3ypq9AEQP+bDBVswbS2+m2RtYgj71LfZechmdcctfkVj0Td3
	MhFXp4JQQegwZZB1n6Fd6jARYdNAB5zuOzm6c1HuWc5UqPFm7RSp6Xoqgrs1X0tulnwkn0nw6OY
	0qfGMxSoTOBsLJK1wh9zQXa4yYFPeqTk9djF1jQ/HUrivALUviUQPo5U3vVhlbZrUDjFEcZWtfM
	Y+geAiLp8fti6mUG0weJ/amL1RqWiLZW1TZ3
X-Received: by 2002:aa7:d6cd:0:b0:658:bd2d:929c with SMTP id
 4fb4d7f45d1cf-65a39098edbmr15157a12.12.1770773369847; Tue, 10 Feb 2026
 17:29:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211004811.work.981-kees@kernel.org>
In-Reply-To: <20260211004811.work.981-kees@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Wed, 11 Feb 2026 02:28:53 +0100
X-Gm-Features: AZwV_QiEeWNUD9mWTR7Guj5j0lA9jpO168ZbrB-HNmoh1488VBqbWniAqGrwDtc
Message-ID: <CAG48ez1GYR+6kZHDmy4CTZvEfdyUySCxhZaXRo1S=YyN=Fsp8Q@mail.gmail.com>
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
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-76917-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 8B70E120768
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 1:48=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> A building block of Use-After-Free heap memory corruption attacks is
> using userspace controllable kernel allocations to fill specifically size=
d
> kmalloc regions with specific contents. The most powerful of these kinds
> of primitives is arbitrarily controllable contents with arbitrary size.
> Keeping these kinds of allocations out of the general kmalloc buckets is
> needed to harden the kernel against such manipulations, so this is why
> these sorts of "copy data from userspace into kernel heap" situations are
> expected to use things like memdup_user(), which keeps the allocations
> in their own set of slab buckets. However, using memdup_user() is not
> always appropriate, so in those cases, kmem_buckets can used directly.
>
> Filenames used to be isolated in their own (fixed size) slab cache so
> they would not end up in the general kmalloc buckets (which made them
> unusable for the heap grooming method described above). After commit
> 8c888b31903c ("struct filename: saner handling of long names"), filenames
> were being copied into arbitrarily sized kmalloc regions in the general
> kmalloc buckets. Instead, like memdup_user(), use a dedicated set of
> kmem buckets for long filenames so we do not introduce a new way for
> attackers to place arbitrary contents into the general kmalloc buckets.
>
> Fixes: 8c888b31903c ("struct filename: saner handling of long names")
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Also, from the same commit, is the loss of SLAB_HWCACHE_ALIGN|SLAB_PANIC
> for filename allocations relavant at all? It could be added back for
> these buckets if desired, but I left it default in this patch.
>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <linux-fsdevel@vger.kernel.org>
> ---
>  fs/namei.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 8e7792de0000..a901733380cd 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -128,6 +128,8 @@
>  /* SLAB cache for struct filename instances */
>  static struct kmem_cache *__names_cache __ro_after_init;
>  #define names_cache    runtime_const_ptr(__names_cache)
> +/* SLAB buckets for long names */
> +static kmem_buckets *names_buckets __ro_after_init;
>
>  void __init filename_init(void)
>  {
> @@ -135,6 +137,8 @@ void __init filename_init(void)
>                          SLAB_HWCACHE_ALIGN|SLAB_PANIC, offsetof(struct f=
ilename, iname),
>                          EMBEDDED_NAME_MAX, NULL);
>         runtime_const_init(ptr, __names_cache);
> +
> +       names_buckets =3D kmem_buckets_create("names_bucket", 0, 0, PATH_=
MAX, NULL);
>  }
>
>  static inline struct filename *alloc_filename(void)
> @@ -156,7 +160,7 @@ static inline void initname(struct filename *name)
>  static int getname_long(struct filename *name, const char __user *filena=
me)
>  {
>         int len;
> -       char *p __free(kfree) =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +       char *p __free(kfree) =3D kmem_buckets_alloc(names_buckets, PATH_=
MAX, GFP_KERNEL);
>         if (unlikely(!p))
>                 return -ENOMEM;

I think this path, where we always do maximally-sized allocations, is
the normal case where we're handling paths coming from userspace...

> @@ -264,14 +268,14 @@ static struct filename *do_getname_kernel(const cha=
r *filename, bool incomplete)
>
>         if (len <=3D EMBEDDED_NAME_MAX) {
>                 p =3D (char *)result->iname;
> -               memcpy(p, filename, len);
>         } else {
> -               p =3D kmemdup(filename, len, GFP_KERNEL);
> +               p =3D kmem_buckets_alloc(names_buckets, len, GFP_KERNEL);

... while this is kind of the exceptional case, where paths are coming
from kernelspace.

So you might want to get rid of the bucketing and instead just create
a single kmem_cache for long paths.


By the way, did you know that "struct filename" is only used for
storing fairly-temporary stuff like paths supplied to open(), but not
for storing the names of directory entries in the dentry cache (which
are more long-lived)? My understanding is that this is also why the
kernel doesn't really try to optimize the size of "struct filename" -
almost all instances of it only exist for the duration of a syscall or
something like that.

The dentry cache allocates long names as "struct external_name" in
reclaimable kmalloc slabs, see __d_alloc().

