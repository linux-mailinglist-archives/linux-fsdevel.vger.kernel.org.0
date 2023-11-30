Return-Path: <linux-fsdevel+bounces-4474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A74E17FF9DF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 189B5B20FFA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E745A10B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJ09unx4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08936D50;
	Thu, 30 Nov 2023 10:04:18 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-a011e9bf336so173888866b.3;
        Thu, 30 Nov 2023 10:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701367456; x=1701972256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdrcCqNOeGaX8nRiVZ0kuDo8oSBz6AvGcrMALAwkn2E=;
        b=RJ09unx4M7h+GuRAris2yEnIDIQyRRXK7xOsZrzniHvOt+kmGEyes7Jy9UF/xEy32J
         09u7fY95FaA/ZPzQZvPbeA4vCscXLS7ZMaSRxiBn9tgw1iIjSybNpgv3FWCsECAzkgI+
         6LkHYRkGPHg1hPfV7LDy1Ig511meMCvDuKmQ98yc/HdKmQ5vCrRKV9aUtZnjtVhc+Ysq
         mrp4a51XQYpO7SY2qNdWmnP6ofNEKKo8Cdicbc3BBqrsZnAFvkNfXTpvHZXeVCdIYnF1
         mNvZHL9mhsCIiOGEHfHwhO2j/2Yd7opbpKFS0m8xakAu2B20vgZdhvRwDT5muVPzpiej
         eAdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701367456; x=1701972256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gdrcCqNOeGaX8nRiVZ0kuDo8oSBz6AvGcrMALAwkn2E=;
        b=kS0SMZY4g99/q06YxFm+jZ3nLK8TuLE9F+A3nrJjSiuDqs2o8LSAvN9yjVzbQf2dy9
         2dEzrqaYe9WSNwhCYixQmMNgpOUa7yp6QQ13HZbH7yMOhtyOMH7cwHWo05A5iBJRYHRl
         AoW+3GPTw5HOrWW7RibwqrvmIaPXq2SJxqxdmzyd7xdPomE4rwwW6m3dvVxJsDQjOc4r
         1bmzAyMCFRIUDHu3nbS6cuFhAUSg8aEZwWEK2hGIJxbBQIlWaLyN0RJP+ojf4sfRH4+T
         aj/lwC4YEMUrXnttLtqvRitWNpyvf50O2+Q8r43IugVCsFIRlDQqC6fg97yg5cbuIJrx
         qr3g==
X-Gm-Message-State: AOJu0YxHerCx7R4IxsOegSuGd/oklp/1sJ1nL3AMZNzzKdj0mR9oi13b
	dfvKwzpDnXYw70BDeaKOmR+wDoqAEydk7oTw2mZH46AY
X-Google-Smtp-Source: AGHT+IEu6Fr0dqU4fzAJQwVeYTuRr7gEcBms+52y3BUpy6n6FgG7Jf9/2fgWYQ5cep9MRJBWoqtok5f8KAbPTzO1Clc=
X-Received: by 2002:a17:906:5306:b0:a18:c553:21cb with SMTP id
 h6-20020a170906530600b00a18c55321cbmr11407ejo.19.1701367375112; Thu, 30 Nov
 2023 10:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127190409.2344550-1-andrii@kernel.org> <20231127190409.2344550-3-andrii@kernel.org>
 <20231130-zivildienst-weckt-4888b2689eea@brauner>
In-Reply-To: <20231130-zivildienst-weckt-4888b2689eea@brauner>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Nov 2023 10:02:43 -0800
Message-ID: <CAEf4BzY6+tOpi+2vx9xdS0M1qC0NvnVhM8LDaakXkCc7n4CO1w@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
To: Christian Brauner <brauner@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 6:18=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Mon, Nov 27, 2023 at 11:03:54AM -0800, Andrii Nakryiko wrote:
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
> > making it scoped to a intended "container". Also, setting these
> > delegation options requires capable(CAP_SYS_ADMIN), so unprivileged
> > process cannot set this up without involvement of a privileged process.
> >
> > There is a set of selftests at the end of the patch set that simulates
> > this sequence of steps and validates that everything works as intended.
> > But careful review is requested to make sure there are no missed gaps i=
n
> > the implementation and testing.
> >
> > This somewhat subtle set of aspects is the result of previous
> > discussions ([0]) about various user namespace implications and
> > interactions with BPF token functionality and is necessary to contain
> > BPF token inside intended user namespace.
> >
> >   [0] https://lore.kernel.org/bpf/20230704-hochverdient-lehne-eeb9eeef7=
85e@brauner/
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> I still think this is a little weird because this isn't really
> unprivileged bpf and it isn't really safe bpf as well.
>
> All this does is allow an administrator to punch a big fat hole into an
> unprivileged container so workloads get to play with their favorite toy.
>
> I think that having a way to have signed bpf programs in addition to
> this would be much more interesting to generic workloads that don't know
> who or what they can trust.

Absolutely, that is the trust part of the puzzle. Song's LSM+fsverity
patch set is a step in that direction.

>
> And there's a few things to remember:
>
> * This absolutely isn't a safety mechanism.
> * This absolutely isn't safe to enable generically in containers.

100% agreed, this should be used only with trusted workloads (however
the trust is established in any particular setup: signing, fsverity,
whatnot)

> * This is a workaround and not a solution to unprivileged bpf.
>
> And this is an ACK solely on the code of this patch, not the concept.
> Acked-by: Christian Brauner <brauner@kernel.org> (reluctantly)

Thank you anyways! I appreciate your efforts to make sure this doesn't
create unintended security holes.

