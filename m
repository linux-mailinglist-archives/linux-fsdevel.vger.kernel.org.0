Return-Path: <linux-fsdevel+bounces-2661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C5E7E7463
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 23:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97831F20CA6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 22:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8214939840;
	Thu,  9 Nov 2023 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY794xPS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECB38FB3;
	Thu,  9 Nov 2023 22:30:09 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CD6420B;
	Thu,  9 Nov 2023 14:30:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso2941567a12.0;
        Thu, 09 Nov 2023 14:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699569007; x=1700173807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fyqbUgJLQxj0g5gla4Q+z2h1h+eh0jxwqc1gn+pGg8Q=;
        b=jY794xPS7KHGhGRBJhRxDJSDO8bGUmh8mFzFt5hmVe8W2hS6Fq2h9py1AZ4nSdTAGJ
         PerClFzgY8ibD+l0Tbrpixo9Rgp7DBMoAOZCFiIarobE8GoC6m52I+gj0ZcV71zpL67B
         N8poIcBi2jT70pogFfrmOYDWpBP8Qz6fiP1oanUdVe3v3gdztHLZC4wLx8s4Ftf0yzaL
         +vADkavIMnHv4SB7dk/32N0sPTrqih5OHTosWFGeON2aomhzCWI3ro+qbwnjsvxIBIXg
         dHLndflSaLW7CAJkSyEh0ZNewqi3q/Y2aswqoGggQm2Jnq1xN7RrrKc4u98aETiUzt7i
         Qfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699569007; x=1700173807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fyqbUgJLQxj0g5gla4Q+z2h1h+eh0jxwqc1gn+pGg8Q=;
        b=Oea2n/ToQnxQZDa2FY8PPwpYMGYEKYeJeRhNm8KAoWGBQL0vZ0bW7/mIDPwfl+2lYH
         tCs4cAfU7tpIjegCiarUN7pSojcOPdHhErv5lEu5pfAhp96+HhQgzGeqY7+HFrPEwmTH
         HhEo2zxeI0DGWc5qA0lzLGC84FjuLP3Sk/3zHyyZj5RT+WcNECuW3dkwu9X47KyoMSGU
         d7NHcgNlZB4NCIhqlpPTTiydXK0bd90RaRQDQ0W5osC04hiBfCtqKcslffzP9uHTRAQo
         8Ne8PegFwOODXqBQseFbs45lQiv80yQMX3McV6TQbEdVZRNqrHWYMoJtwyAXyQ4TChxH
         yNxQ==
X-Gm-Message-State: AOJu0Yy55ZDc9ywEJmsQZLchVavLPyPC06K2nAjbXUe8zvnbaqqf4rHP
	qWAp/pvX1QOB+eXoeGDrnIKL5LX9z+gZNcS4XxM=
X-Google-Smtp-Source: AGHT+IG84JT9UewRXM082FZckw39TFUa9OkG37r2aSlZYG4SQp6xgazG2m+Ex/Y6dbzmt/61LOe2Hj8208NDWBQ8IcA=
X-Received: by 2002:a05:6402:520b:b0:543:5144:1779 with SMTP id
 s11-20020a056402520b00b0054351441779mr629434edd.11.1699569007198; Thu, 09 Nov
 2023 14:30:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103190523.6353-1-andrii@kernel.org> <20231103190523.6353-3-andrii@kernel.org>
 <20231108-ungeeignet-uhren-698f16b4b36b@brauner> <CAEf4BzbanZO_QPhzyFgBEuB0i+uZZO4rZn7mO1qNp3aoPx+32g@mail.gmail.com>
 <20231109-linden-kursprogramm-15c2cbd860b3@brauner> <CAEf4Bza-Rv4YJs8R2YeMyk6psnT71dnuwBt2H=p32PdTCt-6nA@mail.gmail.com>
In-Reply-To: <CAEf4Bza-Rv4YJs8R2YeMyk6psnT71dnuwBt2H=p32PdTCt-6nA@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 14:29:55 -0800
Message-ID: <CAEf4BzZwsc3RHpyzJ6nhxNTqFQE+Re=rKHYfD91J4GiBgF9rsw@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 9:09=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 9, 2023 at 12:48=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > On Wed, Nov 08, 2023 at 01:09:27PM -0800, Andrii Nakryiko wrote:
> > > On Wed, Nov 8, 2023 at 5:51=E2=80=AFAM Christian Brauner <brauner@ker=
nel.org> wrote:
> > > >
> > > > On Fri, Nov 03, 2023 at 12:05:08PM -0700, Andrii Nakryiko wrote:
> > > > > Add few new mount options to BPF FS that allow to specify that a =
given
> > > > > BPF FS instance allows creation of BPF token (added in the next p=
atch),
> > > > > and what sort of operations are allowed under BPF token. As such,=
 we get
> > > > > 4 new mount options, each is a bit mask
> > > > >   - `delegate_cmds` allow to specify which bpf() syscall commands=
 are
> > > > >     allowed with BPF token derived from this BPF FS instance;
> > > > >   - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifi=
es
> > > > >     a set of allowable BPF map types that could be created with B=
PF token;
> > > > >   - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifi=
es
> > > > >     a set of allowable BPF program types that could be loaded wit=
h BPF token;
> > > > >   - if BPF_PROG_LOAD command is allowed, `delegate_attachs` speci=
fies
> > > > >     a set of allowable BPF program attach types that could be loa=
ded with
> > > > >     BPF token; delegate_progs and delegate_attachs are meant to b=
e used
> > > > >     together, as full BPF program type is, in general, determined
> > > > >     through both program type and program attach type.
> > > > >
> > > > > Currently, these mount options accept the following forms of valu=
es:
> > > > >   - a special value "any", that enables all possible values of a =
given
> > > > >   bit set;
> > > > >   - numeric value (decimal or hexadecimal, determined by kernel
> > > > >   automatically) that specifies a bit mask value directly;
> > > > >   - all the values for a given mount option are combined, if spec=
ified
> > > > >   multiple times. E.g., `mount -t bpf nodev /path/to/mount -o
> > > > >   delegate_maps=3D0x1 -o delegate_maps=3D0x2` will result in a co=
mbined 0x3
> > > > >   mask.
> > > > >
> > > > > Ideally, more convenient (for humans) symbolic form derived from
> > > > > corresponding UAPI enums would be accepted (e.g., `-o
> > > > > delegate_progs=3Dkprobe|tracepoint`) and I intend to implement th=
is, but
> > > > > it requires a bunch of UAPI header churn, so I postponed it until=
 this
> > > > > feature lands upstream or at least there is a definite consensus =
that
> > > > > this feature is acceptable and is going to make it, just to minim=
ize
> > > > > amount of wasted effort and not increase amount of non-essential =
code to
> > > > > be reviewed.
> > > > >
> > > > > Attentive reader will notice that BPF FS is now marked as
> > > > > FS_USERNS_MOUNT, which theoretically makes it mountable inside no=
n-init
> > > > > user namespace as long as the process has sufficient *namespaced*
> > > > > capabilities within that user namespace. But in reality we still
> > > > > restrict BPF FS to be mountable only by processes with CAP_SYS_AD=
MIN *in
> > > > > init userns* (extra check in bpf_fill_super()). FS_USERNS_MOUNT i=
s added
> > > > > to allow creating BPF FS context object (i.e., fsopen("bpf")) fro=
m
> > > > > inside unprivileged process inside non-init userns, to capture th=
at
> > > > > userns as the owning userns. It will still be required to pass th=
is
> > > > > context object back to privileged process to instantiate and moun=
t it.
> > > > >
> > > > > This manipulation is important, because capturing non-init userns=
 as the
> > > > > owning userns of BPF FS instance (super block) allows to use that=
 userns
> > > > > to constraint BPF token to that userns later on (see next patch).=
 So
> > > > > creating BPF FS with delegation inside unprivileged userns will r=
estrict
> > > > > derived BPF token objects to only "work" inside that intended use=
rns,
> > > > > making it scoped to a intended "container".
> > > > >
> > > > > There is a set of selftests at the end of the patch set that simu=
lates
> > > > > this sequence of steps and validates that everything works as int=
ended.
> > > > > But careful review is requested to make sure there are no missed =
gaps in
> > > > > the implementation and testing.
> > > > >
> > > > > All this is based on suggestions and discussions with Christian B=
rauner
> > > > > ([0]), to the best of my ability to follow all the implications.
> > > >
> > > > "who will not be held responsible for any CVE future or present as =
he's
> > > >  not sure whether bpf token is a good idea in general"
> > > >
> > > > I'm not opposing it because it's really not my subsystem. But it'd =
be
> > > > nice if you also added a disclaimer that I'm not endorsing this. :)
> > > >
> > >
> > > Sure, I'll clarify. I still appreciate your reviewing everything and
> > > pointing out all the gotchas (like the reconfiguration and other
> > > stuff), thanks!
> > >
> > > > A comment below.
> > > >
> > > > >
> > > > >   [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb=
9eeef785e@brauner/
> > > > >
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > > >  include/linux/bpf.h | 10 ++++++
> > > > >  kernel/bpf/inode.c  | 88 +++++++++++++++++++++++++++++++++++++++=
------
> > > > >  2 files changed, 88 insertions(+), 10 deletions(-)
> > > > >
> > >
> > > [...]
> > >
> > > > >       opt =3D fs_parse(fc, bpf_fs_parameters, param, &result);
> > > > >       if (opt < 0) {
> > > > > @@ -665,6 +692,25 @@ static int bpf_parse_param(struct fs_context=
 *fc, struct fs_parameter *param)
> > > > >       case OPT_MODE:
> > > > >               opts->mode =3D result.uint_32 & S_IALLUGO;
> > > > >               break;
> > > > > +     case OPT_DELEGATE_CMDS:
> > > > > +     case OPT_DELEGATE_MAPS:
> > > > > +     case OPT_DELEGATE_PROGS:
> > > > > +     case OPT_DELEGATE_ATTACHS:
> > > > > +             if (strcmp(param->string, "any") =3D=3D 0) {
> > > > > +                     msk =3D ~0ULL;
> > > > > +             } else {
> > > > > +                     err =3D kstrtou64(param->string, 0, &msk);
> > > > > +                     if (err)
> > > > > +                             return err;
> > > > > +             }
> > > > > +             switch (opt) {
> > > > > +             case OPT_DELEGATE_CMDS: opts->delegate_cmds |=3D ms=
k; break;
> > > > > +             case OPT_DELEGATE_MAPS: opts->delegate_maps |=3D ms=
k; break;
> > > > > +             case OPT_DELEGATE_PROGS: opts->delegate_progs |=3D =
msk; break;
> > > > > +             case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |=
=3D msk; break;
> > > > > +             default: return -EINVAL;
> > > > > +             }
> > > > > +             break;
> > > > >       }
> > > >
> > > > So just to repeat that this will allow a container to set it's own
> > > > delegation options:
> > > >
> > > >         # unprivileged container
> > > >
> > > >         fd_fs =3D fsopen();
> > > >         fsconfig(fd_fs, FSCONFIG_BLA_BLA, "give-me-all-the-delegati=
on");
> > > >
> > > >         # Now hand of that fd_fs to a privileged process
> > > >
> > > >         fsconfig(fd_fs, FSCONFIG_CREATE_CMD, ...)
> > > >
> > > > This means the container manager can't be part of your threat model
> > > > because you need to trust it to set delegation options.
> > > >
> > > > But if the container manager is part of your threat model then you =
can
> > > > never trust an fd_fs handed to you because the container manager mi=
ght
> > > > have enabled arbitrary delegation privileges.
> > > >
> > > > There's ways around this:
> > > >
> > > > (1) kernel: Account for this in the kernel and require privileges w=
hen
> > > >     setting delegation options.
> > >
> > > What sort of privilege would that be? We are in an unprivileged user
> > > namespace, so that would have to be some ns_capable() checks or
> > > something? I can add ns_capable(CAP_BPF), but what else did you have
> > > in mind?
> >
> > You would require privileges in the initial namespace aka capable()
> > checks similar to what you require for superblock creation.
>
> ok, I was just wondering if I'm missing something non-obvious.
> capable(CAP_SYS_ADMIN) makes sense and doesn't really hurt intended
> use case. Privileged parent will set these config values and then do
> FSCONFIG_CREATE_CMD.
>
> For reconfiguration I'll enforce same capable(CAP_SYS_ADMIN) checks,
> unless unprivileged user drops permissions to more restrictive ones
> (but I haven't had a chance to look at exact callback API, so we'll
> see if that's easy to support).

Ok, so I played with this a bit. It seems that if I require
capable(CAP_SYS_ADMIN) for in fsconfig() to set delegation options, I
don't have to do anything special about reconfiguration. Any
FSCONFIG_SET_xxx command for delegation option will just fail, and so
reconfiguration is harmless. I'm going to go with that and keep it
simple.

>
> Thanks for feedback!
>
> >
> > >
> > > I think even if we say that privileged parent does FSCONFIG_SET_STRIN=
G
> > > and unprivileged child just does sys_fsopen("bpf", 0) and nothing
> > > more, we still can't be sure that child won't race with parent and se=
t
> > > FSCONFIG_SET_STRING at the same time. Because they both have access t=
o
> > > the same fs_fd.
> >
> > Unless you require privileges as outlined above to set delegation
> > options in which case an unprivileged container cannot change delegatio=
n
> > options at all.
>
> Yep, makes sense, that's what I'm going to do.
>
> >
> > >
> > > > (2) userspace: A trusted helper that allocates an fs_context fd in
> > > >     the target user namespace, then sets delegation options and cre=
ates
> > > >     superblock.
> > > >
> > > > (1) Is more restrictive but also more secure. (2) is less restricti=
ve
> > > > but requires more care from userspace.
> > > >
> > > > Either way I would probably consider writing a document detailing
> > > > various delegation scenarios and possible pitfalls and implications
> > > > before advertising it.
> > > >
> > > > If you choose (2) then you also need to be aware that the security =
of
> > > > this also hinges on bpffs not allowing to reconfigure parameters on=
ce it
> > > > has been mounted. Otherwise an unprivileged container can change
> > > > delegation options.
> > > >
> > > > I would recommend that you either add a dummy bpf_reconfigure() met=
hod
> > > > with a comment in it or you add a comment on top of bpf_context_ops=
.
> > > > Something like:
> > > >
> > > > /*
> > > >  * Unprivileged mounts of bpffs are owned by the user namespace the=
y are
> > > >  * mounted in. That means unprivileged users can change vfs mount
> > > >  * options (ro<->rw, nosuid, etc.).
> > > >  *
> > > >  * They currently cannot change bpffs specific mount options such a=
s
> > > >  * delegation settings. If that is ever implemented it is necessary=
 to
> > > >  * require rivileges in the initial namespace. Otherwise unprivileg=
ed
> > > >  * users can change delegation options to whatever they want.
> > > >  */
> > >
> > > Yep, I will add a custom callback. I think we can allow reconfiguring
> > > towards less permissive delegation subset, but I'll need to look at
> > > the specifics to see if we can support that easily.

