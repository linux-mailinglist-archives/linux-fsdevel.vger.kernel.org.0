Return-Path: <linux-fsdevel+bounces-4238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7FF7FDF83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F6291C209CA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AC85DF08
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u+r6OyfX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC351C293;
	Wed, 29 Nov 2023 17:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04ADEC433C9;
	Wed, 29 Nov 2023 17:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701278036;
	bh=rwJvppmrLy1P/MmPKSamrNN7Qxe5PzI8xPdRqi5d0VM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=u+r6OyfX0aEHZDbfGWAJ7VuOmIawZC6PpoVobG1JmykL9aSG0hlltlzDyZqIjibIT
	 gyCV3iJOMlgPlbzHaIDC+gyqeywkfnxQpGu6Xj2NOE4EmtDn+ANIlxUDaocq1bGS1s
	 t4OPgBQoxw5FNjSYW5VmR8REfBHRBVS6pnZRCIJ/yYwLnmZmghgwU17WZQQ9n0EwkF
	 nZZtmaohPylpJvq8nbWn/Q6n2FOJkOL9zuiB55dDMcRx3bvkQtgsPmz24CdF6ooXoD
	 aeKscXlyPsP1rfbgycZ8iCvssYmdcx8+p9PygktKdD6QbrmYY2Rd95qqYIz70DgI3Z
	 cR9AoEhMCsgGg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c9b1839e90so11383631fa.1;
        Wed, 29 Nov 2023 09:13:55 -0800 (PST)
X-Gm-Message-State: AOJu0YxTDNoSPugAKWIOKC6EeM+KUMnWqYFGPc3tNaA95LJvEU2yl7p8
	vahvz5sRFpOZyBZU/RjzryA90kE3WHfBzmQO46I=
X-Google-Smtp-Source: AGHT+IExa5zwajC/GzqsEbFlosESXxxXS3HE7q1ADy5OKUBLi4tjjkw2bL5QtF3VQO1Jfq0SC8DxdAXc77R2cVLltiA=
X-Received: by 2002:a2e:b04e:0:b0:2c9:bf97:81c1 with SMTP id
 d14-20020a2eb04e000000b002c9bf9781c1mr857584ljl.22.1701278034233; Wed, 29 Nov
 2023 09:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003656.1165061-1-song@kernel.org> <20231129003656.1165061-7-song@kernel.org>
 <CAADnVQJb3Ur--A8jaiVqpea1kFXMCd46uP+X4ydcOVG3a5Ve3Q@mail.gmail.com>
 <CAPhsuW5Kvcj8cOFf0ZeLZ428+=pjXQfCqx7aYBCthVgtRN2J3g@mail.gmail.com> <CAADnVQLnMfu91VMVzdh=_qMNhzwvks69XHa5RPbsXk1c437-Hg@mail.gmail.com>
In-Reply-To: <CAADnVQLnMfu91VMVzdh=_qMNhzwvks69XHa5RPbsXk1c437-Hg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 29 Nov 2023 09:13:42 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7xGNybcovxTO+T_R7FqYpPvU7J1EX2OCOfbtASRG9yAg@mail.gmail.com>
Message-ID: <CAPhsuW7xGNybcovxTO+T_R7FqYpPvU7J1EX2OCOfbtASRG9yAg@mail.gmail.com>
Subject: Re: [PATCH v14 bpf-next 6/6] selftests/bpf: Add test that uses
 fsverity and xattr to sign a file
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, fsverity@lists.linux.dev, 
	Eric Biggers <ebiggers@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, 
	Amir Goldstein <amir73il@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 6:56=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Nov 29, 2023 at 3:20=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> >
> > On Tue, Nov 28, 2023 at 10:47=E2=80=AFPM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Tue, Nov 28, 2023 at 4:37=E2=80=AFPM Song Liu <song@kernel.org> wr=
ote:
> > > > +char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) + SHA256_D=
IGEST_SIZE];
> > >
> > > when vmlinux is built without CONFIG_FS_VERITY the above fails
> > > in a weird way:
> > >   CLNG-BPF [test_maps] test_sig_in_xattr.bpf.o
> > > progs/test_sig_in_xattr.c:36:26: error: invalid application of
> > > 'sizeof' to an incomplete type 'struct fsverity_digest'
> > >    36 | char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) +
> > > SHA256_DIGEST_SIZE];
> > >       |                          ^     ~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > Is there a way to somehow print a hint during the build what
> > > configs users need to enable to pass the build ?
> >
> > Patch 5/6 added CONFIG_FS_VERITY to tools/testing/selftests/bpf/config.
> > This is a more general question for all required CONFIG_* specified in =
the
> > file (and the config files for other selftests).
> >
> > In selftests/bpf/Makefile, we have logic to find vmlinux. We can add si=
milar
> > logic to find .config used to build the vmlinux, and grep for each requ=
ired
> > CONFIG_* from the .config file. Does this sound like a viable solution?
>
> No need for new logic to parse .config.
> libbpf does it already and
> extern bool CONFIG_FS_VERITY __kconfig __weak;
> works.
>
> Since you hard code MAGIC_SIZE anyway I'm asking
> to hard code sizeof(struct fsverity_digest) as well, since the bpf prog
> doesn't access it directly. It only needs to know its size.
>
> While inside:
> int BPF_PROG(test_file_open, struct file *f)
> {
>   if (!CONFIG_FS_VERITY) {
>      skip_fs_verity_test =3D true;
>      return 0;
>   }
>
> and report it as a clean error message in test_progs.

Yeah, this makes sense. Let me update the tests.

Thanks,
Song

> We keep adding new config requirements selftests/bpf/config which
> forces all developers to keep adding new configs to their builds.
> In the past, when we didn't have BPF CI, that was necessary, but now
> BPF CI does it for us.
> With clean error message from test_progs the developers can either
> ignore the error and proceed with their work or adjust their .config
> eventually. While hard selftest build error forces all devs to
> update .config right away and build error has no info of what needs
> to be done which is not developer friendly.
>
> pw-bot: cr
>

