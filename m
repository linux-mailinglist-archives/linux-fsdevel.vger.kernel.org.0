Return-Path: <linux-fsdevel+bounces-2443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 217947E5FAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 22:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A6FAB20F92
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 21:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4E4374DD;
	Wed,  8 Nov 2023 21:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6ty0Vk/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8980374C7;
	Wed,  8 Nov 2023 21:09:42 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00332580;
	Wed,  8 Nov 2023 13:09:41 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d216597f64so30028266b.3;
        Wed, 08 Nov 2023 13:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699477780; x=1700082580; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3VLfq7sx7EQNPSuIP7+UwIreDQvznY4bi5G4L5TGSE=;
        b=I6ty0Vk/3DUT/sA+UM1OEpTxgbCI3Kdra+UAKezUmnE9ryYuhCahN2P66Qp0vZDzo7
         fSASFzbvMHnnmGxbjrMjEMyUc7S5vb27DQW1VJrhY+1zcohLf6Sv0rRap0AZIbRO5cef
         Nc5w9Alczv3BpKNgrNHfkdacMHSLpGi6fFl/pnl3fCCuWpolBl6HBUdIlqRrFbc1H2hE
         6KrcY+vlg/9Bc+SrFy4zjtjoyu+IMxkjHv7rJhfdA2jenhJlqDGi0nL58lQQMf941SEy
         RzUqZnBu1tmV/VkR6GTWKyKYzMwKb6Z3bIu7wo+II9AXnMVRzlZunFIDZUaLOGEn73/S
         QQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477780; x=1700082580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b3VLfq7sx7EQNPSuIP7+UwIreDQvznY4bi5G4L5TGSE=;
        b=JrgMvxBlOdc6CX0tVFihqZ7ZJz1TlJTseSgWzG4wS814HYpT72PrjDkHbUF9JZZA+R
         ZnoksZ8jerw8HZ0VZTuoIjYPKVhJnghPYf7kxFMAZ0hlVp3zSzKdauXAj6jQyNdmXxB+
         WtJu9R2GwWWBP1rB7rl++mNlStEf3toqvW4TPHNnR41Cp8VppP1+/m1KWcBUA1BwZp9L
         yVIaRZUOnyPVGQHQrxaDhqMUmk+b7UwzuEUz65fI3Z4oJmfV9DIQlD+f+k9FSc1cTjUe
         SerJ9r9UV+DLPSJ/1V6fXV7gLilYE5kOYtiQiiDPxznF/XMhVb6JL2whEwG7Rgt2bXon
         HnIw==
X-Gm-Message-State: AOJu0Yyl7FWZ7sZGJBtesQ7ZLm5L90jOdnS4en50t2OZmc2iaLMfsYgM
	0jBi3ZRXyN3NqkXKA/fo9LlHw0KFdKjyfJPFS5RUJyuahPM=
X-Google-Smtp-Source: AGHT+IHhn+yfXlFZr0ffESTNZIm1zxhEz3ywwkAAJ1sXW+xaO+oJbbc827jTcn8YH4qA7DzHTqxRst22gAd5l3vviTk=
X-Received: by 2002:a17:907:a03:b0:9d1:92bb:ce74 with SMTP id
 bb3-20020a1709070a0300b009d192bbce74mr2281906ejc.38.1699477779886; Wed, 08
 Nov 2023 13:09:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103190523.6353-1-andrii@kernel.org> <20231103190523.6353-3-andrii@kernel.org>
 <20231108-ungeeignet-uhren-698f16b4b36b@brauner>
In-Reply-To: <20231108-ungeeignet-uhren-698f16b4b36b@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 8 Nov 2023 13:09:27 -0800
Message-ID: <CAEf4BzbanZO_QPhzyFgBEuB0i+uZZO4rZn7mO1qNp3aoPx+32g@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 8, 2023 at 5:51=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Fri, Nov 03, 2023 at 12:05:08PM -0700, Andrii Nakryiko wrote:
> > Add few new mount options to BPF FS that allow to specify that a given
> > BPF FS instance allows creation of BPF token (added in the next patch),
> > and what sort of operations are allowed under BPF token. As such, we ge=
t
> > 4 new mount options, each is a bit mask
> >   - `delegate_cmds` allow to specify which bpf() syscall commands are
> >     allowed with BPF token derived from this BPF FS instance;
> >   - if BPF_MAP_CREATE command is allowed, `delegate_maps` specifies
> >     a set of allowable BPF map types that could be created with BPF tok=
en;
> >   - if BPF_PROG_LOAD command is allowed, `delegate_progs` specifies
> >     a set of allowable BPF program types that could be loaded with BPF =
token;
> >   - if BPF_PROG_LOAD command is allowed, `delegate_attachs` specifies
> >     a set of allowable BPF program attach types that could be loaded wi=
th
> >     BPF token; delegate_progs and delegate_attachs are meant to be used
> >     together, as full BPF program type is, in general, determined
> >     through both program type and program attach type.
> >
> > Currently, these mount options accept the following forms of values:
> >   - a special value "any", that enables all possible values of a given
> >   bit set;
> >   - numeric value (decimal or hexadecimal, determined by kernel
> >   automatically) that specifies a bit mask value directly;
> >   - all the values for a given mount option are combined, if specified
> >   multiple times. E.g., `mount -t bpf nodev /path/to/mount -o
> >   delegate_maps=3D0x1 -o delegate_maps=3D0x2` will result in a combined=
 0x3
> >   mask.
> >
> > Ideally, more convenient (for humans) symbolic form derived from
> > corresponding UAPI enums would be accepted (e.g., `-o
> > delegate_progs=3Dkprobe|tracepoint`) and I intend to implement this, bu=
t
> > it requires a bunch of UAPI header churn, so I postponed it until this
> > feature lands upstream or at least there is a definite consensus that
> > this feature is acceptable and is going to make it, just to minimize
> > amount of wasted effort and not increase amount of non-essential code t=
o
> > be reviewed.
> >
> > Attentive reader will notice that BPF FS is now marked as
> > FS_USERNS_MOUNT, which theoretically makes it mountable inside non-init
> > user namespace as long as the process has sufficient *namespaced*
> > capabilities within that user namespace. But in reality we still
> > restrict BPF FS to be mountable only by processes with CAP_SYS_ADMIN *i=
n
> > init userns* (extra check in bpf_fill_super()). FS_USERNS_MOUNT is adde=
d
> > to allow creating BPF FS context object (i.e., fsopen("bpf")) from
> > inside unprivileged process inside non-init userns, to capture that
> > userns as the owning userns. It will still be required to pass this
> > context object back to privileged process to instantiate and mount it.
> >
> > This manipulation is important, because capturing non-init userns as th=
e
> > owning userns of BPF FS instance (super block) allows to use that usern=
s
> > to constraint BPF token to that userns later on (see next patch). So
> > creating BPF FS with delegation inside unprivileged userns will restric=
t
> > derived BPF token objects to only "work" inside that intended userns,
> > making it scoped to a intended "container".
> >
> > There is a set of selftests at the end of the patch set that simulates
> > this sequence of steps and validates that everything works as intended.
> > But careful review is requested to make sure there are no missed gaps i=
n
> > the implementation and testing.
> >
> > All this is based on suggestions and discussions with Christian Brauner
> > ([0]), to the best of my ability to follow all the implications.
>
> "who will not be held responsible for any CVE future or present as he's
>  not sure whether bpf token is a good idea in general"
>
> I'm not opposing it because it's really not my subsystem. But it'd be
> nice if you also added a disclaimer that I'm not endorsing this. :)
>

Sure, I'll clarify. I still appreciate your reviewing everything and
pointing out all the gotchas (like the reconfiguration and other
stuff), thanks!

> A comment below.
>
> >
> >   [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef7=
85e@brauner/
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h | 10 ++++++
> >  kernel/bpf/inode.c  | 88 +++++++++++++++++++++++++++++++++++++++------
> >  2 files changed, 88 insertions(+), 10 deletions(-)
> >

[...]

> >       opt =3D fs_parse(fc, bpf_fs_parameters, param, &result);
> >       if (opt < 0) {
> > @@ -665,6 +692,25 @@ static int bpf_parse_param(struct fs_context *fc, =
struct fs_parameter *param)
> >       case OPT_MODE:
> >               opts->mode =3D result.uint_32 & S_IALLUGO;
> >               break;
> > +     case OPT_DELEGATE_CMDS:
> > +     case OPT_DELEGATE_MAPS:
> > +     case OPT_DELEGATE_PROGS:
> > +     case OPT_DELEGATE_ATTACHS:
> > +             if (strcmp(param->string, "any") =3D=3D 0) {
> > +                     msk =3D ~0ULL;
> > +             } else {
> > +                     err =3D kstrtou64(param->string, 0, &msk);
> > +                     if (err)
> > +                             return err;
> > +             }
> > +             switch (opt) {
> > +             case OPT_DELEGATE_CMDS: opts->delegate_cmds |=3D msk; bre=
ak;
> > +             case OPT_DELEGATE_MAPS: opts->delegate_maps |=3D msk; bre=
ak;
> > +             case OPT_DELEGATE_PROGS: opts->delegate_progs |=3D msk; b=
reak;
> > +             case OPT_DELEGATE_ATTACHS: opts->delegate_attachs |=3D ms=
k; break;
> > +             default: return -EINVAL;
> > +             }
> > +             break;
> >       }
>
> So just to repeat that this will allow a container to set it's own
> delegation options:
>
>         # unprivileged container
>
>         fd_fs =3D fsopen();
>         fsconfig(fd_fs, FSCONFIG_BLA_BLA, "give-me-all-the-delegation");
>
>         # Now hand of that fd_fs to a privileged process
>
>         fsconfig(fd_fs, FSCONFIG_CREATE_CMD, ...)
>
> This means the container manager can't be part of your threat model
> because you need to trust it to set delegation options.
>
> But if the container manager is part of your threat model then you can
> never trust an fd_fs handed to you because the container manager might
> have enabled arbitrary delegation privileges.
>
> There's ways around this:
>
> (1) kernel: Account for this in the kernel and require privileges when
>     setting delegation options.

What sort of privilege would that be? We are in an unprivileged user
namespace, so that would have to be some ns_capable() checks or
something? I can add ns_capable(CAP_BPF), but what else did you have
in mind?

I think even if we say that privileged parent does FSCONFIG_SET_STRING
and unprivileged child just does sys_fsopen("bpf", 0) and nothing
more, we still can't be sure that child won't race with parent and set
FSCONFIG_SET_STRING at the same time. Because they both have access to
the same fs_fd.

> (2) userspace: A trusted helper that allocates an fs_context fd in
>     the target user namespace, then sets delegation options and creates
>     superblock.
>
> (1) Is more restrictive but also more secure. (2) is less restrictive
> but requires more care from userspace.
>
> Either way I would probably consider writing a document detailing
> various delegation scenarios and possible pitfalls and implications
> before advertising it.
>
> If you choose (2) then you also need to be aware that the security of
> this also hinges on bpffs not allowing to reconfigure parameters once it
> has been mounted. Otherwise an unprivileged container can change
> delegation options.
>
> I would recommend that you either add a dummy bpf_reconfigure() method
> with a comment in it or you add a comment on top of bpf_context_ops.
> Something like:
>
> /*
>  * Unprivileged mounts of bpffs are owned by the user namespace they are
>  * mounted in. That means unprivileged users can change vfs mount
>  * options (ro<->rw, nosuid, etc.).
>  *
>  * They currently cannot change bpffs specific mount options such as
>  * delegation settings. If that is ever implemented it is necessary to
>  * require rivileges in the initial namespace. Otherwise unprivileged
>  * users can change delegation options to whatever they want.
>  */

Yep, I will add a custom callback. I think we can allow reconfiguring
towards less permissive delegation subset, but I'll need to look at
the specifics to see if we can support that easily.

