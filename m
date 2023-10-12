Return-Path: <linux-fsdevel+bounces-145-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBF87C61D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 02:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A127F1C20F97
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 00:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401307EE;
	Thu, 12 Oct 2023 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImGT8t4k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC1663F;
	Thu, 12 Oct 2023 00:33:01 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543E19E;
	Wed, 11 Oct 2023 17:32:58 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so766061a12.0;
        Wed, 11 Oct 2023 17:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697070777; x=1697675577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23pjpMx4TRTKzVdZP5YrXJXyMvsd+ffEMTEOZRbRQxQ=;
        b=ImGT8t4k4YnRhdI6vbWIlDkbJCnTk5Gjm/nnbR7JThNkJZhgZPVF2zjn1O3qtoQp+l
         w9RKjMBfKL6KpW2HpxYu/o55YZQ0dGGrJDS3l+aUFK73TzsJNjcAr/ST/RxWuuUVpZww
         HhRr0Fx51ywKNaDBKISIu58DNOL70Us+uU6W8dVteZmt1x7pXVg4s7a3RPZufBtiMW4B
         ZO7mvKb3XENjFX/Wqq/Z+Hfl7BkAQN6gncryy2SvxzQe6ySCc9wy3iqizeZCIMWD2q1I
         agC+90NnIo981/kVqurX7O3CMMbji8daH+3LpZHcWo5+zZdS4hKjf2hRM+pIujFqa7W6
         YBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070777; x=1697675577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23pjpMx4TRTKzVdZP5YrXJXyMvsd+ffEMTEOZRbRQxQ=;
        b=Ho//d5zMJ+uXvEHanBd6gN++ud+ZsPZWKo0BsKYc3zvGGFkrX913avugDe99xnRCtF
         srCQ3c76mjMQ1eKeKzPWrHvJ7xNvlsG9kalzOOj3wDQLYsE/EYxwr/FI2TvesWyWYXvo
         UdaF3FmNo7z+547YBgHB3Gd14z01b9xiHFgS2mhXyuGDjRMUIbfAVoYkVDLLeGKBj6Un
         GrjZGyOeK2kMfNSq/98GHCKU7CXjHLV8lxHVgenm1HonN2Ple6DXPD+KshKlHKcM09sI
         rkcqxqld1Qop9JO6KGHB6Z3g4OM8039ExXmPUdBddFi8ups6lA9AF93iX06HBG9R/VGy
         Oi3w==
X-Gm-Message-State: AOJu0YyUDdI7AdkrKJ/iurCiafJ2CceoYfPyNHZQqsDChZeOZSs1j65m
	4AA39Uax+9oPjATuoIClrigM5T8asuE3VYtWxyo=
X-Google-Smtp-Source: AGHT+IGMzDs6iM7RMzIUL8l2ZxiB36t+AelnjaJtNBbedGxN/M1ikJmdDqWnVzuXTnWVwncUXi3rCl2cgfn3Dc9irWw=
X-Received: by 2002:a05:6402:5194:b0:53e:395:59d with SMTP id
 q20-20020a056402519400b0053e0395059dmr575307edd.8.1697070776645; Wed, 11 Oct
 2023 17:32:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230912212906.3975866-3-andrii@kernel.org> <3808036a0b32a17a7fd9e7d671b5458d.paul@paul-moore.com>
 <CAEf4BzYiKhG3ZL-GGQ4fHzSu6RKx2fh2JHwcL9_XKzQBvx3Bjg@mail.gmail.com>
 <CAHC9VhSOCAb6JQJn96xgwNNMGM0mKXf64ygkj4=Yv0FA8AYR=Q@mail.gmail.com>
 <CAEf4BzZC+9GbCsG56B2Q=woq+RHQS8oMTGJSNiMFKZpOKHhKpg@mail.gmail.com>
 <CAHC9VhTiqhQcfDr-7mThY1kH-Fwa7NUUU8ZWZvLFVudgtO8RAA@mail.gmail.com>
 <CAEf4BzZ8RvGwzVfm-EN1qdDiTv3Q2eYxBKOdBgGT96XzcvJCpw@mail.gmail.com> <CAHC9VhTp-YPRi8NzCr4_GT8BiWUcpQ4RrYqVQNE1HZwFOOffMg@mail.gmail.com>
In-Reply-To: <CAHC9VhTp-YPRi8NzCr4_GT8BiWUcpQ4RrYqVQNE1HZwFOOffMg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Oct 2023 17:32:45 -0700
Message-ID: <CAEf4BzZ4V0dSgTNLS7HKh6JuXcKP-WZNVn3gV_PTAWY5tBSF_Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/12] bpf: introduce BPF token object
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com, 
	sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 2:20=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Fri, Sep 22, 2023 at 6:35=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> > On Thu, Sep 21, 2023 at 3:18=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Fri, Sep 15, 2023 at 4:59=E2=80=AFPM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > > On Thu, Sep 14, 2023 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore=
.com> wrote:
> > > > > On Thu, Sep 14, 2023 at 1:31=E2=80=AFPM Andrii Nakryiko
> > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > On Wed, Sep 13, 2023 at 2:46=E2=80=AFPM Paul Moore <paul@paul-m=
oore.com> wrote:
> > > > > > >
> > > > > > > On Sep 12, 2023 Andrii Nakryiko <andrii.nakryiko@gmail.com> w=
rote:
>
> ...
>
> > > > > > > I mentioned this a while back, likely in the other threads wh=
ere this
> > > > > > > token-based approach was only being discussed in general term=
s, but I
> > > > > > > think we want to have a LSM hook at the point of initial toke=
n
> > > > > > > delegation for this and a hook when the token is used.  My in=
itial
> > > > > > > thinking is that we should be able to address the former with=
 a hook
> > > > > > > in bpf_fill_super() and the latter either in bpf_token_get_fr=
om_fd()
> > > > > > > or bpf_token_allow_XXX(); bpf_token_get_from_fd() would be si=
mpler,
> > > > > > > but it doesn't allow for much in the way of granularity.  Ins=
erting the
> > > > > > > LSM hooks in bpf_token_allow_XXX() would also allow the BPF c=
ode to fall
> > > > > > > gracefully fallback to the system-wide checks if the LSM deni=
ed the
> > > > > > > requested access whereas an access denial in bpf_token_get_fr=
om_fd()
> > > > > > > denial would cause the operation to error out.
> > > > > >
> > > > > > I think the bpf_fill_super() LSM hook makes sense, but I though=
t
> > > > > > someone mentioned that we already have some generic LSM hook fo=
r
> > > > > > validating mounts? If we don't, I can certainly add one for BPF=
 FS
> > > > > > specifically.
> > > > >
> > > > > We do have security_sb_mount(), but that is a generic mount opera=
tion
> > > > > access control and not well suited for controlling the mount-base=
d
> > > > > capability delegation that you are proposing here.  However, if y=
ou or
> > > > > someone else has a clever way to make security_sb_mount() work fo=
r
> > > > > this purpose I would be very happy to review that code.
> > > >
> > > > To be honest, I'm a bit out of my depth here, as I don't know the
> > > > mounting parts well. Perhaps someone from VFS side can advise. But
> > > > regardless, I have no problem adding a new LSM hook as well, ideall=
y
> > > > not very BPF-specific. If you have a specific form of it in mind, I=
'd
> > > > be curious to see it and implement it.
> > >
> > > I agree that there can be benefits to generalized LSM hooks, but in
> > > this hook I think it may need to be BPF specific simply because the
> > > hook would be dealing with the specific concept of delegating BPF
> > > permissions.
> >
> > Sure. As an alternative, if this is about controlling BPF delegation,
> > instead of doing mount-time checks and LSM hook, perhaps we can add a
> > new LSM hook to BPF_CREATE_TOKEN, just like we have ones for
> > BPF_MAP_CREATE and BPF_PROG_LOAD. That will enable controlling
> > delegation more directly when it is actually attempted to be used.
>
> I'm also going to reply to the v6 patchset, but I thought there were
> some important points in this thread that were worth responding to
> here so that it would have the context of our previous discussion.
>
> So yes, from an LSM perspective we are concerned with who grants the
> delegation (creates the token) and who leverages that token to do
> work.  When this patchset was still using anonymous inodes, marking
> and controlling token creation was relatively easy as we have existing
> hooks/control-points for anonymous inodes which take into account the
> anonymous inode class/type, e.g. bpffs.  Now that this patchset is
> using a regular bpffs inode we may need to do some additional work so
> that we can mark the bpffs token inode as a "token" so that we can
> later distinguish it from an ordinary bpffs inode; it might also serve
> as a convenient place to control creation of the token, but as you
> have already mentioned we could also control this from the existing
> security_bpf(BPF_CREATE_TOKEN, ...) hook at the top of __sys_bpf().
>
> Anyway, more on this in the v6 patchset.
>
> > > I haven't taken the time to write up any hook patches yet as I wanted
> > > to discuss it with you and the others on the To/CC line, but it seems
> > > like we are roughly on the same page, at least with the initial
> > > delegation hook, so I can put something together if you aren't
> > > comfortable working on this (more on this below) ...
> >
> > I'd appreciate the help from the SELinux side specifically, yes. I'm
> > absolutely OK to add a few new LSM hooks, though.
>
> I just want to say again that I'm very happy we can work together to
> make sure everything is covered :)

Likewise! I ran out of time today to finish all the requested changes,
but hopefully I will be able to post a new version tomorrow with all
the feedback applied.

>
> > > > > > As for the bpf_token_allow_xxx(). This feels a bit too specific=
 and
> > > > > > narrow-focused. What if we later add yet another dimension for =
BPF FS
> > > > > > and token? Do we need to introduce yet another LSM for each suc=
h case?
> > > > >
> > > > > [I'm assuming you meant new LSM *hook*]
> > > >
> > > > yep, of course, sorry about using terminology sloppily
> > > >
> > > > > Possibly.  There are also some other issues which I've been think=
ing
> > > > > about along these lines, specifically the fact that the
> > > > > capability/command delegation happens after the existing
> > > > > security_bpf() hook is called which makes things rather awkward f=
rom a
> > > > > LSM perspective: the LSM would first need to allow the process ac=
cess
> > > > > to the desired BPF op using it's current LSM specific security
> > > > > attributes (e.g. SELinux security domain, etc.) and then later
> > > > > consider the op in the context of the delegated access control ri=
ghts
> > > > > (if the LSM decides to support those hooks).
> > > > >
> > > > > I suspect that if we want to make this practical we would need to
> > > > > either move some of the token code up into __sys_bpf() so we coul=
d
> > > > > have a better interaction with security_bpf(), or we need to cons=
ider
> > > > > moving the security_bpf() call into the op specific functions.  I=
'm
> > > > > still thinking on this (lots of reviews to get through this week)=
, but
> > > > > I'm hoping there is a better way because I'm not sure I like eith=
er
> > > > > option very much.
> > > >
> > > > Yes, security_bpf() is happening extremely early and is lacking a l=
ot
> > > > of context. I'm not sure if moving it around is a good idea as it
> > > > basically changes its semantics.
> > >
> > > There are a couple of things that make this not quite as scary as it
> > > may seem.  The first is that currently only SELinux implements a
> > > security_bpf() hook and the implementation is rather simplistic in
> > > terms of what information it requires to perform the existing access
> > > controls; decomposing the single security_bpf() call site into
> > > multiple op specific calls, perhaps with some op specific hooks,
> > > should be doable without causing major semantic changes.  The second
> > > thing is that we could augment the existing security_bpf() hook and
> > > call site with a new LSM hook(s) that are called from the op specific
> > > call sites; this would allow those LSMs that desire the current
> > > semantics to use the existing security_bpf() hook and those that wish
> > > to use the new semantics could implement the new hook(s).  This is
> > > very similar to the pathname-based and inode-based hooks in the VFS
> > > layer, some LSMs choose to implement pathname-based security and use
> > > one set of hooks, while others implement a label-based security
> > > mechanism and use a different set of hooks.
> >
> > Agreed. I think new LSM hooks that are operation-specific make a lot
> > of sense. I'd probably not touch existing security_bpf(), it's an
> > early-entry LSM hook for anything bpf() syscall-specific. This might
> > be very useful in some cases, probably.
> >
> > > > But adding a new set of coherent LSM
> > > > hooks per each appropriate BPF operation with good context to make
> > > > decisions sounds like a good improvement. E.g., for BPF_PROG_LOAD, =
we
> > > > can have LSM hook after struct bpf_prog is allocated, bpf_token is
> > > > available, attributes are sanity checked. All that together is a ve=
ry
> > > > useful and powerful context that can be used both by more fixed LSM
> > > > policies (like SELinux), and very dynamic user-defined BPF LSM
> > > > programs.
> > >
> > > This is where it is my turn to mention that I'm getting a bit out of
> > > my depth, but I'm hopeful that the two of us can keep each other from
> > > drowning :)
> > >
> > > Typically the LSM hook call sites end up being in the same general
> > > area as the capability checks, usually just after (we want the normal
> > > Linux discretionary access controls to always come first for the sake
> > > of consistency).  Sticking with that approach it looks like we would
> > > end up with a LSM call in bpf_prog_load() right after bpf_capable()
> > > call, the only gotcha with that is the bpf_prog struct isn't populate=
d
> > > yet, but how important is that when we have the bpf_attr info (honest
> > > question, I don't know the answer to this)?
> >
> > Ok, so I agree in general about having LSM hooks close to capability
> > checks, but at least specifically for BPF_PROG_CREATE, it won't work.
> > This bpf_capable() check you mention. This is just one check. If you
> > look into bpf_prog_load() in kernel/bpf/syscall.c, you'll see that we
> > can also check CAP_PERFMON, CAP_NET_ADMIN, and CAP_SYS_ADMIN, in
> > addition to CAP_BPF, based on various aspects (like program type +
> > subtype).
>
> That's a fair point.
>
> > So for such a complex BPF_PROG_CREATE operation I think we
> > should deviate a bit and place LSM in a logical place that would
> > enable doing LSM enforcement with lots of relevant information, but
> > before doing anything dangerous or expensive.
> >
> > For BPF_PROG_LOAD that place seems to be right before bpf_check(),
> > which is BPF verification ...
>
> > ... Right now we have `security_bpf_prog_alloc(prog->aux);`, which is
> > almost in the ideal place, but provides prog->aux instead of program
> > itself (not sure why), and doesn't provide bpf_attr and bpf_token.
> >
> > So I'm thinking that maybe we get rid of bpf_prog_alloc() in favor of
> > new security_bpf_prog_load(prog, &attr, token)?
>
> That sounds reasonable.  We'll need to make sure we update the docs
> for that LSM hook to indicate that it performs both allocation of the
> LSM's BPF program state (it's current behavior), as well as access
> control for BPF program loads both with and without delegation.

Heh, I asked about this distinction between "allocation of LSM state"
and "access control" in another email thread, but based on this it
seems like it's purely convention based and it's OK to do both with
the same hook, right? If that's the case, then I think we should
combine what you proposed as two hooks, security_bpf_token_alloc() and
security_bpf_token_create(), into one hook to minimize mental
overhead. But if I'm missing something, please point it out on the
patch.

>
> I think those are the big points worth wrapping up here in this
> thread, I'll move the rest over to the v6 patchset.

It all makes sense and I intend to add all those hooks and do
refactoring of existing map/prog ones. I will put that into a separate
patch in the series for a more focused review.



>
> --
> paul-moore.com

