Return-Path: <linux-fsdevel+bounces-6314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E91815AAB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 18:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21E761F23BC0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 17:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3018C30FA1;
	Sat, 16 Dec 2023 17:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyF9kZnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B1130CE1;
	Sat, 16 Dec 2023 17:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c236624edso18764115e9.1;
        Sat, 16 Dec 2023 09:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702748482; x=1703353282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgO3so/ClDZBEw7D8E47G0uO1x+v0kVGhpT7tUy/jx0=;
        b=UyF9kZnlnFlisFziArZCzslMxBJKbIkWClfm4iyr7Qddbk5hQL9HadYnD4mVTzLv4O
         6biJgkU/I8pku1CgQKApaGKDfry5t13p4aH6Q6NAImm9znCgzJUnFuImvsZN3IiC3NhB
         ZLdOQ+gtBAN5mBwMUf+0p7BUGBTG8H5a/kas9N0XFQ6GZY+I2PTtgcHpPbbIhzgIrIZw
         RVxDY0cjnxuV8UkaDHs7BdP8Yg88nTAmp0nHEirgwA2xhXsFysNYBCcsiIQ5Ke5DvU+q
         O99P4iurS3GyM1Z/tmmQf91ywbvkMhiHfIF+tCcXYCwWm8z4QXvzQJLYeFjEJ6+pEpGE
         EQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702748482; x=1703353282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgO3so/ClDZBEw7D8E47G0uO1x+v0kVGhpT7tUy/jx0=;
        b=taP68O3XNsU4vOmUfkRXnRcCxZun3CUGakNtSCAJeuL550rIFBHFhM5nr4hpnkc2cm
         6LQs2+s/9MumyLDS5t9qHYH2FCaFi5HU1d0oALm39wEkTNB61REiKOuQQgp9SMX/FZh3
         lua+N2lvko/m5W4LEoR3uPw6DmrHz3IELLnEDjOhhLl+yFRGv/gTqt3NbCj9+alIKP0L
         0hPIZx6Iafw4M704CVFLv8PLM+Xrlv9szluRoOUTmxh54k7xgae4S1ArP8E8m72+Sgjo
         Htw6vRk3J2hdqN6XO6U/n6mIouNezqyewPqwQe14Dz7/lKc1wt5uAV/zWxN7+kQI7h3B
         1MzA==
X-Gm-Message-State: AOJu0Yys0bofY1f/S90go/Z9yWNudv6TvxdGE0mkxXSfpJ4gMIN9zIBR
	BnemGXHy8/sP05zfG2deoEcOMp6uomEdPjtJJSM=
X-Google-Smtp-Source: AGHT+IE8An/2yulhZyamNYs/YrJilzHQsy0S13pN/y+fPs+/X0zorsPG6Usu7MuQog5xttvPH9Ax/4dNtv3tfwdY/rs=
X-Received: by 2002:a7b:ce88:0:b0:40b:5e21:cc26 with SMTP id
 q8-20020a7bce88000000b0040b5e21cc26mr6984240wmj.81.1702748481740; Sat, 16 Dec
 2023 09:41:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de> <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner> <CAADnVQKeUmV88OfQOfiX04HjKbXq7Wfcv+N3O=5kdL4vic6qrw@mail.gmail.com>
 <20231216-vorrecht-anrief-b096fa50b3f7@brauner>
In-Reply-To: <20231216-vorrecht-anrief-b096fa50b3f7@brauner>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 16 Dec 2023 09:41:10 -0800
Message-ID: <CAADnVQK7MDUZTUxcqCH=unrrGExCjaagfJFqFPhVSLUisJVk_Q@mail.gmail.com>
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
To: Christian Brauner <brauner@kernel.org>
Cc: =?UTF-8?Q?Michael_Wei=C3=9F?= <michael.weiss@aisec.fraunhofer.de>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Alexei Starovoitov <ast@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Quentin Monnet <quentin@isovalent.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, gyroidos@aisec.fraunhofer.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 16, 2023 at 2:38=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Fri, Dec 15, 2023 at 10:08:08AM -0800, Alexei Starovoitov wrote:
> > On Fri, Dec 15, 2023 at 6:15=E2=80=AFAM Christian Brauner <brauner@kern=
el.org> wrote:
> > >
> > > On Fri, Dec 15, 2023 at 02:26:53PM +0100, Michael Wei=C3=9F wrote:
> > > > On 15.12.23 13:31, Christian Brauner wrote:
> > > > > On Wed, Dec 13, 2023 at 03:38:13PM +0100, Michael Wei=C3=9F wrote=
:
> > > > >> devguard is a simple LSM to allow CAP_MKNOD in non-initial user
> > > > >> namespace in cooperation of an attached cgroup device program. W=
e
> > > > >> just need to implement the security_inode_mknod() hook for this.
> > > > >> In the hook, we check if the current task is guarded by a device
> > > > >> cgroup using the lately introduced cgroup_bpf_current_enabled()
> > > > >> helper. If so, we strip out SB_I_NODEV from the super block.
> > > > >>
> > > > >> Access decisions to those device nodes are then guarded by exist=
ing
> > > > >> device cgroups mechanism.
> > > > >>
> > > > >> Signed-off-by: Michael Wei=C3=9F <michael.weiss@aisec.fraunhofer=
.de>
> > > > >> ---
> > > > >
> > > > > I think you misunderstood me... My point was that I believe you d=
on't
> > > > > need an additional LSM at all and no additional LSM hook. But I m=
ight be
> > > > > wrong. Only a POC would show.
> > > >
> > > > Yeah sorry, I got your point now.
> > >
> > > I think I might have had a misconception about how this works.
> > > A bpf LSM program can't easily alter a kernel object such as struct
> > > super_block I've been told.
> >
> > Right. bpf cannot change arbitrary kernel objects,
> > but we can add a kfunc that will change a specific bit in a specific
> > data structure.
> > Adding a new lsm hook that does:
> >     rc =3D call_int_hook(sb_device_access, 0, sb);
> >     switch (rc) {
> >     case 0: do X
> >     case 1: do Y
> >
> > is the same thing, but uglier, since return code will be used
> > to do this action.
> > The 'do X' can be one kfunc
> > and 'do Y' can be another.
> > If later we find out that 'do X' is not a good idea we can remove
> > that kfunc.
>
> The reason I moved the SB_I_MANAGED_DEVICES here is that I want a single
> central place where that is done for any possible LSM that wants to
> implement device management. So we don't have to go chasing where that
> bit is set for each LSM. I also don't want to have LSMs raise bits in
> sb->s_iflags directly as that's VFS property.

a kfunc that sets a bit in sb->s_iflags will be the same central place.
It will be somewhere in the fs/ directory and vfs maintainers can do what t=
hey
wish with it, including removal.
For traditional LSM one would need to do an accurate code review to make
sure that they don't mess with sb->s_iflags while for bpf_lsm it
will be done automatically. That kfunc will be that only one central place.

