Return-Path: <linux-fsdevel+bounces-38761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D298DA08199
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 21:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1643A8EA0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE4B1FE475;
	Thu,  9 Jan 2025 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nqmu/pKc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EE02046A3;
	Thu,  9 Jan 2025 20:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455791; cv=none; b=UBy+aN85LgoB5heqc4mz7hesEeKa/zL51yUvxTdhKbDkTumOMG2/mAR+WU+NWnuIvtB+3hIHSsc33rTay2d2AALJXs3rFJoOvW/Xdcd0sQq0+mbeyLkhEbQ4dm2QM3wW6zrAfPnsiJj0i+U7L6UvSksthpapLswvSkaKd9WCnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455791; c=relaxed/simple;
	bh=WaafDH5Bcz9EWnXTxxIKqj+1fKHhVssjjMJMFWARz68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cig0uxFQNaTQ8H/SCuYDbheJSr7WCX3bzGhyCN+LetajFbxtZbd6JSh68zwteHGAYAmrNqPnB2bwuyWOZJSlWAKTpZ7qNT2vtR9rUxkyMIHy5JErmcFJldQ4saKG2TTmWGNngunedZtoENzPPciE+J0ytsQAd9iTDc/CZrIFIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nqmu/pKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F267C4CED2;
	Thu,  9 Jan 2025 20:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736455791;
	bh=WaafDH5Bcz9EWnXTxxIKqj+1fKHhVssjjMJMFWARz68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Nqmu/pKcz1tyk9YnKVEPxZJ+HT0GGRgPkroLle6tsTq2iCdZXJUIqdhI8r1ZyOlSC
	 ljjOdZ/n0XUVaLWwO7bliryv77lUF0aEGWyu85CPLtttKsylU1KP9561emRA4GuncP
	 zOHdCzy9tI4whMdTlBd8WrAS3ICVU9DDJhEaPk++/jOlJZC+uAkgnixUKuasjsk0+Z
	 DjSvlTRO2hxej/tAcemKGihaJDHIU9OzYoV9MetjB+P7n8L16mvzrPY+UMk8++Q9/B
	 LyzdiwhzIRb5R+5csSXr+wv/MXtOMM3GgEDlbKd4h10rJUhS1I0pllZNO9qDy2TE+g
	 RO+J3N563RX5w==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3ce34c6872aso8537795ab.0;
        Thu, 09 Jan 2025 12:49:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVJJZJaI8uKfD6wN/97Z934v8UhruCKNt8fWmpXP0OQhonO5bB0CH1SQKQv6nfkf+25K6zlY+98jF9zGMmhFw==@vger.kernel.org, AJvYcCVQXo8KA4SEj25PRIe8jZU/P+SFcx3PG5uHpC7ynLqqrZ1B4ZNJOOvCXyE/b5pzsyEF47E=@vger.kernel.org, AJvYcCXmaVdTQGWB7W4Q5rxWg1bCI+eJD0gQGeHE2phqSV0Cjm333p7hZdFkTp97qU0p2FSLkhsFQtBW7c1PoByV@vger.kernel.org
X-Gm-Message-State: AOJu0YxSaFkRTAkRHXcZwcsj9TQhzDK7+PTzopfsGQ4Ms7hlk/R3vSCE
	begK2RCfxq6WiE2Fy+UI4XbpEA0xY+GKzdWSFqHhXrQYgkEgKcYI+uxCGYgTT0uGeNsJQiV/acY
	3gUvljmtBYFofR/iRnmKUSQpZ7xk=
X-Google-Smtp-Source: AGHT+IG+HTj1bjjXb12Biy0PzbE6SEssAyowE2uDsBvkQslv0uhRkEE8Uij+UVyc8qLh5iDSxPN/DkOiHcKjSRiFEqw=
X-Received: by 2002:a05:6e02:1d14:b0:3a7:d792:d6c4 with SMTP id
 e9e14a558f8ab-3ce3a8df63cmr68137945ab.21.1736455790677; Thu, 09 Jan 2025
 12:49:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB5080E0DFE4F9BAFFDB9D113B99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQLU=W7fuEQommfDYrxr9A2ESV7E3uUAm4VUbEugKEZbkQ@mail.gmail.com>
 <AM6PR03MB50805EAC8B42B0570A2F76B399032@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <CAADnVQJYVLEs8zr414j1xRZ_DAAwcxiCC-1YqDOt8oF13Wf6zw@mail.gmail.com>
In-Reply-To: <CAADnVQJYVLEs8zr414j1xRZ_DAAwcxiCC-1YqDOt8oF13Wf6zw@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Thu, 9 Jan 2025 12:49:39 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7KYss11bQpJo-1f7Pdpb=ky2QWQ=zoJuX3buYm1_nbFA@mail.gmail.com>
X-Gm-Features: AbW1kvbox1g93hvAB5XmZSYmcAJaZ1nrp647saDlplTeWU2dOTVFVRA8tCW2598
Message-ID: <CAPhsuW7KYss11bQpJo-1f7Pdpb=ky2QWQ=zoJuX3buYm1_nbFA@mail.gmail.com>
Subject: Re: per st_ops kfunc allow/deny mask. Was: [PATCH bpf-next v6 4/5]
 bpf: Make fs kfuncs available for SYSCALL program type
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Juntong Deng <juntong.deng@outlook.com>, Tejun Heo <tj@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, snorcht@gmail.com, 
	Christian Brauner <brauner@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 11:24=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Dec 23, 2024 at 4:51=E2=80=AFPM Juntong Deng <juntong.deng@outloo=
k.com> wrote:
> >
> > >
> > > The main goal is to get rid of run-time mask check in SCX_CALL_OP() a=
nd
> > > make it static by the verifier. To make that happen scx_kf_mask flags
> > > would need to become KF_* flags while each struct-ops callback will
> > > specify the expected mask.
> > > Then at struct-ops prog attach time the verifier will see the expecte=
d mask
> > > and can check that all kfuncs calls of this particular program
> > > satisfy the mask. Then all of the runtime overhead of
> > > current->scx.kf_mask and scx_kf_allowed() will go away.
> >
> > Thanks for pointing this out.
> >
> > Yes, I am interested in working on it.
> >
> > I will try to solve this problem in a separate patch series.
> >
> >
> > The following are my thoughts:
> >
> > Should we really use KF_* to do this? I think KF_* is currently more
> > like declaring that a kfunc has some kind of attribute, e.g.
> > KF_TRUSTED_ARGS means that the kfunc only accepts trusted arguments,
> > rather than being used to categorise kfuncs.
> >
> > It is not sustainable to restrict the kfuncs that can be used based on
> > program types, which are coarse-grained. This problem will get worse
> > as kfuncs increase.
> >
> > In my opinion, managing the kfuncs available to bpf programs should be
> > implemented as capabilities. Capabilities are a mature permission model=
.
> > We can treat a set of kfuncs as a capability (like the various current
> > kfunc_sets, but the current kfunc_sets did not carefully divide
> > permissions).
> >
> > We should use separate BPF_CAP_XXX flags to manage these capabilities.
> > For example, SCX may define BPF_CAP_SCX_DISPATCH.
> >
> > For program types, we should divide them into two levels, types and
> > subtypes. Types are used to register common capabilities and subtypes
> > are used to register specific capabilities. The verifier can check if
> > the used kfuncs are allowed based on the type and subtype of the bpf
> > program.
> >
> > I understand that we need to maintain backward compatibility to
> > userspace, but capabilities are internal changes in the kernel.
> > Perhaps we can make the current program types as subtypes and
> > add 'types' that are only used internally, and more subtypes
> > (program types) can be added in the future.
>
> Sorry for the delay.
> imo CAP* approach doesn't fit.
> caps are security bits exposed to user space.
> Here there is no need to expose anything to user space.
>
> But you're also correct that we cannot extend kfunc KF_* flags
> that easily. KF_* flags are limited to 32-bit and we're already
> using 12 bits.
> enum scx_kf_mask needs 5 bits, so we can squeeze them into
> the current 32-bit field _for now_,
> but eventually we'd need to refactor kfunc definition into a wider set:
> BTF_ID_FLAGS(func, .. KF_*)
> so that different struct_ops consumers can define their own bits.
>
> Right now SCX is the only st_ops consumer who needs this feature,
> so let's squeeze into the existing KF facility.
>
> First step is to remap scx_kf_mask bits into unused bits in KF_
> and annotate corresponding sched-ext kfuncs with it.
> For example:
> SCX_KF_DISPATCH will become
> KF_DISPATCH (1 << 13)
>
> and all kfuncs that are allowed to be called from ->dispatch() callback
> will be annotated like:
> - BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
> - BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots)
> - BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel)
> + BTF_KFUNCS_START(scx_kfunc_ids_dispatch)
> + BTF_ID_FLAGS(func, scx_bpf_dispatch_nr_slots, KF_DISPATCH)
> + BTF_ID_FLAGS(func, scx_bpf_dispatch_cancel, KF_DISPATCH)
>
>
> For sched_ext_ops callback annotations, I think,
> the simplest approach is to add special
> BTF_SET8_START(st_ops_flags)
> BTF_ID_FLAGS(func, sched_ext_ops__dispatch, KF_DISPATCH)
> and so on for other ops stubs.
>
> sched_ext_ops__dispatch() is an empty function that
> exists in the vmlinux, and though it's not a kfunc
> we can use it to annotate
> (struct sched_ext_ops *)->dispatch() callback
> with a particular KF_ flag
> (or a set of flags for SCX_KF_RQ_LOCKED case).
>
> Then the verifier (while analyzing the program that is targeted
> to be attach to this ->dispatch() hook)
> will check this extra KF flag in st_ops
> and will only allow to call kfuncs with matching flags:
>
> if (st_ops->kf_mask & kfunc->kf_mask) // ok to call kfunc from this callb=
ack
>
> The end result current->scx.kf_mask will be removed
> and instead of run-time check it will become static verifier check.

Shall we move some of these logics from verifier core to
btf_kfunc_id_set.filter()? IIUC, this would avoid using extra
KF_* bits. To make the filter functions more capable, we
probably need to pass bpf_verifier_env into the filter() function.

Does this make sense?

Thanks,
Song

