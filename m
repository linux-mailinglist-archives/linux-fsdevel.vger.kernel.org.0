Return-Path: <linux-fsdevel+bounces-4242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 914AD7FDF87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 19:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 291D7B20BDD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9A15DF0B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 18:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J+Ctap0B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9F5AB81;
	Wed, 29 Nov 2023 17:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B257EC433BA;
	Wed, 29 Nov 2023 17:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701280701;
	bh=lk1f0hn2qVXW4ecUUKiqu+LXLxJwkG1hbYtD13CIm20=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=J+Ctap0BevVBrz5sugCSk54lFR0qL8B+CpYxOK3p+GGnAPsjrSdHFA3nD2dH04/Sa
	 7Am9yJXLC1wvPA+0PW+ijIJuAntjDi5GNyuyH+M8WOdni+wxJM0xwXmttVdzMLVBAA
	 tZWQtyrCew4/TvSxAVbVCstI56oY5mTVKmYdA4j4aKdH2lTjuR4WmjB2u/BrMnXp6N
	 kXOTQdRCKbKczlItp2HaJ6OCOZQtoF3FZqGJNex8SaHmRh1uazyu40TRuJqAJs5Su8
	 1SU2jPS5i4YP3YVAIZptna92EG8ve/9H5AWU3OBsWtv4mbTMhKm+Cp7rzOIaelZ8G5
	 1j+5YcEPytzfQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2c6b30aca06so993721fa.3;
        Wed, 29 Nov 2023 09:58:21 -0800 (PST)
X-Gm-Message-State: AOJu0YxfnE1P/D3F+cX5hhK/DsM0Z1GgZHJG9Rl6tqSaJ1c4bQ1l9ccd
	MinAwwbyzTi0QrcaSnNVStsuMSHh2y+E9vlIyhE=
X-Google-Smtp-Source: AGHT+IE8o/36p3qgOhqkmeD4J4euHMN9yETM3L1Ilxj4CpAFF75IXfVCmGG75QZsWJ+usvSg/zmtlDh5lPu5c85Iqkg=
X-Received: by 2002:a2e:3e17:0:b0:2c9:baca:a92b with SMTP id
 l23-20020a2e3e17000000b002c9bacaa92bmr2907404lja.48.1701280699758; Wed, 29
 Nov 2023 09:58:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003656.1165061-1-song@kernel.org> <20231129003656.1165061-7-song@kernel.org>
 <CAADnVQJb3Ur--A8jaiVqpea1kFXMCd46uP+X4ydcOVG3a5Ve3Q@mail.gmail.com>
 <CAPhsuW5Kvcj8cOFf0ZeLZ428+=pjXQfCqx7aYBCthVgtRN2J3g@mail.gmail.com>
 <CAADnVQLnMfu91VMVzdh=_qMNhzwvks69XHa5RPbsXk1c437-Hg@mail.gmail.com> <CAPhsuW7xGNybcovxTO+T_R7FqYpPvU7J1EX2OCOfbtASRG9yAg@mail.gmail.com>
In-Reply-To: <CAPhsuW7xGNybcovxTO+T_R7FqYpPvU7J1EX2OCOfbtASRG9yAg@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Wed, 29 Nov 2023 09:58:07 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4aOLb9sPBF69r8Sd=nR+En17XswfP==En-sZJ8rNd8Zg@mail.gmail.com>
Message-ID: <CAPhsuW4aOLb9sPBF69r8Sd=nR+En17XswfP==En-sZJ8rNd8Zg@mail.gmail.com>
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

On Wed, Nov 29, 2023 at 9:13=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Wed, Nov 29, 2023 at 6:56=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Nov 29, 2023 at 3:20=E2=80=AFAM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > On Tue, Nov 28, 2023 at 10:47=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > On Tue, Nov 28, 2023 at 4:37=E2=80=AFPM Song Liu <song@kernel.org> =
wrote:
> > > > > +char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) + SHA256=
_DIGEST_SIZE];
> > > >
> > > > when vmlinux is built without CONFIG_FS_VERITY the above fails
> > > > in a weird way:
> > > >   CLNG-BPF [test_maps] test_sig_in_xattr.bpf.o
> > > > progs/test_sig_in_xattr.c:36:26: error: invalid application of
> > > > 'sizeof' to an incomplete type 'struct fsverity_digest'
> > > >    36 | char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) +
> > > > SHA256_DIGEST_SIZE];
> > > >       |                          ^     ~~~~~~~~~~~~~~~~~~~~~~~~
> > > >
> > > > Is there a way to somehow print a hint during the build what
> > > > configs users need to enable to pass the build ?
> > >
> > > Patch 5/6 added CONFIG_FS_VERITY to tools/testing/selftests/bpf/confi=
g.
> > > This is a more general question for all required CONFIG_* specified i=
n the
> > > file (and the config files for other selftests).
> > >
> > > In selftests/bpf/Makefile, we have logic to find vmlinux. We can add =
similar
> > > logic to find .config used to build the vmlinux, and grep for each re=
quired
> > > CONFIG_* from the .config file. Does this sound like a viable solutio=
n?
> >
> > No need for new logic to parse .config.
> > libbpf does it already and
> > extern bool CONFIG_FS_VERITY __kconfig __weak;
> > works.
> >
> > Since you hard code MAGIC_SIZE anyway I'm asking
> > to hard code sizeof(struct fsverity_digest) as well, since the bpf prog
> > doesn't access it directly. It only needs to know its size.
> >
> > While inside:
> > int BPF_PROG(test_file_open, struct file *f)
> > {
> >   if (!CONFIG_FS_VERITY) {
> >      skip_fs_verity_test =3D true;
> >      return 0;
> >   }
> >
> > and report it as a clean error message in test_progs.
>
> Yeah, this makes sense. Let me update the tests.

Actually, it is easier. We already have skip-test logic for cases
where FS verity is not supported (as we need to enable it in
vmlinux and enable it per filesystem). So we only need to hard
code sizeof(struct fsverity_digest).

Thanks,
Song

