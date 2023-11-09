Return-Path: <linux-fsdevel+bounces-2599-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3C77E6FDE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA2F1C209EA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 17:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CEF22308;
	Thu,  9 Nov 2023 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8uIzFhW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCE013AE3;
	Thu,  9 Nov 2023 17:10:05 +0000 (UTC)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D730D0;
	Thu,  9 Nov 2023 09:10:04 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so1921887a12.0;
        Thu, 09 Nov 2023 09:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699549803; x=1700154603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBLwLk+pvhgBmgsdDnRZ5FktbGP6WVJe4voawdFNuzY=;
        b=O8uIzFhWr4yEvJdBU9Gyf78fYaPPxAYub9K5psd8NU8j7zox3jg5nYftM0jk5697q6
         GtZQpVUimTipRasgtukBuui4EhCzJSE5qOLHDYV/OnbkfnL3o6Xw3/HCfBj4RQMEPDPp
         zCQS1Wh5ZpcnJ1UqglSFUbw/74XqJgTFBEc66fZlYDO0Knhr1jyQsiX/kuYdjDvMg6iY
         Fft++AI/lG/oouzqHNg81zNL+TWoeHWokThUG8YtZT1FqcYaywEs/IiLEx0aQBheRHJq
         GVY2xujD++4jCh0twR++5WfYuRUGi8XXJvS7pa/QrLmTMkdvnxADKGKBsiw+r5Fsvlr8
         dnIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699549803; x=1700154603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bBLwLk+pvhgBmgsdDnRZ5FktbGP6WVJe4voawdFNuzY=;
        b=A3A+yeESy6SRMYlT9BVkv0G3pmyudlXErC0l4EJvfyGIc9c2Z09Up0kUzgYck4drTV
         V6sZIw0wwJC68e7hER07TJV0v9XiZQyBAkr1fcYiC+1Q2Y3I4dlCZE9x+UMdrpA4+kuI
         EQMd7o0hj88F0lhvXojyk9mIyYA21he0Lhfand5VZvlAzKqAkKXdOuJ2ZEG3jwDyP4wh
         oI/e3iNgo0Sx9ydVEvTCnDMOwCI9ynDptVg3Osuxb2J99x8WLyPlsODeMiQpFmrvy7ap
         hDRmIEZUrsSs3yK5z4lWsu1UmEND5KeW4qUKplSBfYLrgxNOpeArmjpp/Xuzi7IS19q5
         wDiA==
X-Gm-Message-State: AOJu0YzjEdh3cqsJlz1ZrjPA6/KbtTkVBIljDKZKw7qXUuRC1p2CjZdM
	C8AaO8yTpfrCI6N+h8j9CSL6jXpMkFQFDcDuMc4=
X-Google-Smtp-Source: AGHT+IH+BXE2TcCK7OLC0VlwF4WB2/z6g/txyB4F4TbsReHBevUeymbMVQgsRWkvTp2LeJVqPqBaRFr2ckQ9doxG4ic=
X-Received: by 2002:a17:907:9716:b0:9bd:d405:4e7e with SMTP id
 jg22-20020a170907971600b009bdd4054e7emr4745055ejc.6.1699549802712; Thu, 09
 Nov 2023 09:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103190523.6353-1-andrii@kernel.org> <20231103190523.6353-3-andrii@kernel.org>
 <20231108-ungeeignet-uhren-698f16b4b36b@brauner> <CAEf4BzbanZO_QPhzyFgBEuB0i+uZZO4rZn7mO1qNp3aoPx+32g@mail.gmail.com>
 <20231109-linden-kursprogramm-15c2cbd860b3@brauner>
In-Reply-To: <20231109-linden-kursprogramm-15c2cbd860b3@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 9 Nov 2023 09:09:51 -0800
Message-ID: <CAEf4Bza-Rv4YJs8R2YeMyk6psnT71dnuwBt2H=p32PdTCt-6nA@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 12:48=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Nov 08, 2023 at 01:09:27PM -0800, Andrii Nakryiko wrote:
> > On Wed, Nov 8, 2023 at 5:51=E2=80=AFAM Christian Brauner <brauner@kerne=
l.org> wrote:
> > >
> > > On Fri, Nov 03, 2023 at 12:05:08PM -0700, Andrii Nakryiko wrote:
> > > > Add few new mount options to BPF FS that allow to specify that a gi=
ven
> > > > BPF FS instance allows creation of BPF token (added in the next pat=
ch),
> > > > and what sort of operations are allowed under BPF token. As such, w=
e get
> > > > 4 new mount options, each is a bit mask
> > > >   - `delegate_cmds` allow to specify which bpf() syscall commands a=
re
> > > >     allowed with BPF token derived from this BPF FS instance;
> > > >   - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifies
> > > >     a set of allowable BPF map types that could be created with BPF=
 token;
> > > >   - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifies
> > > >     a set of allowable BPF program types that could be loaded with =
BPF token;
> > > >   - if BPF_PROG_LOAD command is allowed, `delegate_attachs` specifi=
es
> > > >     a set of allowable BPF program attach types that could be loade=
d with
> > > >     BPF token; delegate_progs and delegate_attachs are meant to be =
used
> > > >     together, as full BPF program type is, in general, determined
> > > >     through both program type and program attach type.
> > > >
> > > > Currently, these mount options accept the following forms of values=
:
> > > >   - a special value "any", that enables all possible values of a gi=
ven
> > > >   bit set;
> > > >   - numeric value (decimal or hexadecimal, determined by kernel
> > > >   automatically) that specifies a bit mask value directly;
> > > >   - all the values for a given mount option are combined, if specif=
ied
> > > >   multiple times. E.g., `mount -t bpf nodev /path/to/mount -o
> > > >   delegate_maps=3D0x1 -o delegate_maps=3D0x2` will result in a comb=
ined 0x3
> > > >   mask.
> > > >
> > > > Ideally, more convenient (for humans) symbolic form derived from
> > > > corresponding UAPI enums would be accepted (e.g., `-o
> > > > delegate_progs=3Dkprobe|tracepoint`) and I intend to implement this=
, but
> > > > it requires a bunch of UAPI header churn, so I postponed it until t=
his
> > > > feature lands upstream or at least there is a definite consensus th=
at
> > > > this feature is acceptable and is going to make it, just to minimiz=
e
> > > > amount of wasted effort and not increase amount of non-essential co=
de to
> > > > be reviewed.
> > > >
> > > > Attentive reader will notice that BPF FS is now marked as
> > > > FS_USERNS_MOUNT, which theoretically makes it mountable inside non-=
init
> > > > user namespace as long as the process has sufficient *namespaced*
> > > > capabilities within that user namespace. But in reality we still
> > > > restrict BPF FS to be mountable only by processes with CAP_SYS_ADMI=
N *in
> > > > init userns* (extra check in bpf_fill_super()). FS_USERNS_MOUNT is =
added
> > > > to allow creating BPF FS context object (i.e., fsopen("bpf")) from
> > > > inside unprivileged process inside non-init userns, to capture that
> > > > userns as the owning userns. It will still be required to pass this
> > > > context object back to privileged process to instantiate and mount =
it.
> > > >
> > > > This manipulation is important, because capturing non-init userns a=
s the
> > > > owning userns of BPF FS instance (super block) allows to use that u=
serns
> > > > to constraint BPF token to that userns later on (see next patch). S=
o
> > > > creating BPF FS with delegation inside unprivileged userns will res=
trict
> > > > derived BPF token objects to only "work" inside that intended usern=
s,
> > > > making it scoped to a intended "container".
> > > >
> > > > There is a set of selftests at the end of the patch set that simula=
tes
> > > > this sequence of steps and validates that everything works as inten=
ded.
> > > > But careful review is requested to make sure there are no missed ga=
ps in
> > > > the implementation and testing.
> > > >
> > > > All this is based on suggestions and discussions with Christian Bra=
uner
> > > > ([0]), to the best of my ability to follow all the implications.
> > >
> > > "who will not be held responsible for any CVE future or present as he=
's
> > >  not sure whether bpf token is a good idea in general"
> > >
> > > I'm not opposing it because it's really not my subsystem. But it'd be
> > > nice if you also added a disclaimer that I'm not endorsing this. :)
> > >
> >
> > Sure, I'll clarify. I still appreciate your reviewing everything and
> > pointing out all the gotchas (like the reconfiguration and other
> > stuff), thanks!
> >
> > > A comment below.
> > >
> > > >
> > > >   [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9e=
eef785e@brauner/
> > > >
> > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > ---
> > > >  include/linux/bpf.h | 10 ++++++
> > > >  kernel/bpf/inode.c  | 88 +++++++++++++++++++++++++++++++++++++++--=
----
> > > >  2 files changed, 88 insertions(+), 10 deletions(-)
> > > >
> >
> > [...]
> >
> > > >       opt =3D fs_parse(fc, bpf_fs_parameters, param, &result);
> > > >       if (opt < 0) {
> > > > @@ -665,6 +692,25 @@ static int bpf_parse_param(struct fs_context *=
fc, struct fs_parameter *param)
> > > >       case OPT_MODE:
> > > >               opts->mode =3D result.uint_32 & S_IALLUGO;
> > > >               break;
> > > > +     case OPT_DELEGATE_CMDS:
> > > > +     case OPT_DELEGATE_MAPS:
> > > > +     case OPT_DELEGATE_PROGS:
> > > > +     case OPT_DELEGATE_ATTACHS:
> > > > +             if (strcmp(param->string, "any") =3D=3D 0) {
> > > > +                     msk =3D ~0ULL;
> > > > +             } else {
> > > > +                     err =3D kstrtou64(param->string, 0, &msk);
> > > > +                     if (err)
> > > > +                             return err;
> > > > +             }
> > > > +             switch (opt) {
> > > > +             case OPT_DELEGATE_CMDS: opts->delegate_cmds |=3D msk;=
 break;
> > > > +             case OPT_DELEGATE_MAPS: opts->delegate_maps |=3D msk;=
 break;
> > > > +             case OPT_DELEGATE_PROGS: opts->delegate_progs |=3D ms=
k; break;
> > > > +             case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |=
=3D msk; break;
> > > > +             default: return -EINVAL;
> > > > +             }
> > > > +             break;
> > > >       }
> > >
> > > So just to repeat that this will allow a container to set it's own
> > > delegation options:
> > >
> > >         # unprivileged container
> > >
> > >         fd_fs =3D fsopen();
> > >         fsconfig(fd_fs, FSCONFIG_BLA_BLA, "give-me-all-the-delegation=
");
> > >
> > >         # Now hand of that fd_fs to a privileged process
> > >
> > >         fsconfig(fd_fs, FSCONFIG_CREATE_CMD, ...)
> > >
> > > This means the container manager can't be part of your threat model
> > > because you need to trust it to set delegation options.
> > >
> > > But if the container manager is part of your threat model then you ca=
n
> > > never trust an fd_fs handed to you because the container manager migh=
t
> > > have enabled arbitrary delegation privileges.
> > >
> > > There's ways around this:
> > >
> > > (1) kernel: Account for this in the kernel and require privileges whe=
n
> > >     setting delegation options.
> >
> > What sort of privilege would that be? We are in an unprivileged user
> > namespace, so that would have to be some ns_capable() checks or
> > something? I can add ns_capable(CAP_BPF), but what else did you have
> > in mind?
>
> You would require privileges in the initial namespace aka capable()
> checks similar to what you require for superblock creation.

ok, I was just wondering if I'm missing something non-obvious.
capable(CAP_SYS_ADMIN) makes sense and doesn't really hurt intended
use case. Privileged parent will set these config values and then do
FSCONFIG_CREATE_CMD.

For reconfiguration I'll enforce same capable(CAP_SYS_ADMIN) checks,
unless unprivileged user drops permissions to more restrictive ones
(but I haven't had a chance to look at exact callback API, so we'll
see if that's easy to support).

Thanks for feedback!

>
> >
> > I think even if we say that privileged parent does FSCONFIG_SET_STRING
> > and unprivileged child just does sys_fsopen("bpf", 0) and nothing
> > more, we still can't be sure that child won't race with parent and set
> > FSCONFIG_SET_STRING at the same time. Because they both have access to
> > the same fs_fd.
>
> Unless you require privileges as outlined above to set delegation
> options in which case an unprivileged container cannot change delegation
> options at all.

Yep, makes sense, that's what I'm going to do.

>
> >
> > > (2) userspace: A trusted helper that allocates an fs_context fd in
> > >     the target user namespace, then sets delegation options and creat=
es
> > >     superblock.
> > >
> > > (1) Is more restrictive but also more secure. (2) is less restrictive
> > > but requires more care from userspace.
> > >
> > > Either way I would probably consider writing a document detailing
> > > various delegation scenarios and possible pitfalls and implications
> > > before advertising it.
> > >
> > > If you choose (2) then you also need to be aware that the security of
> > > this also hinges on bpffs not allowing to reconfigure parameters once=
 it
> > > has been mounted. Otherwise an unprivileged container can change
> > > delegation options.
> > >
> > > I would recommend that you either add a dummy bpf_reconfigure() metho=
d
> > > with a comment in it or you add a comment on top of bpf_context_ops.
> > > Something like:
> > >
> > > /*
> > >  * Unprivileged mounts of bpffs are owned by the user namespace they =
are
> > >  * mounted in. That means unprivileged users can change vfs mount
> > >  * options (ro<->rw, nosuid, etc.).
> > >  *
> > >  * They currently cannot change bpffs specific mount options such as
> > >  * delegation settings. If that is ever implemented it is necessary t=
o
> > >  * require rivileges in the initial namespace. Otherwise unprivileged
> > >  * users can change delegation options to whatever they want.
> > >  */
> >
> > Yep, I will add a custom callback. I think we can allow reconfiguring
> > towards less permissive delegation subset, but I'll need to look at
> > the specifics to see if we can support that easily.

