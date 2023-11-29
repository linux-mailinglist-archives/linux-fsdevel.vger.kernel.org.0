Return-Path: <linux-fsdevel+bounces-4208-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE547FDD3F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 17:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0C48B20D75
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4159C3B287
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Nov 2023 16:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bt+vYPF5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCCBBE;
	Wed, 29 Nov 2023 06:55:58 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so49460555e9.3;
        Wed, 29 Nov 2023 06:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701269757; x=1701874557; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dipYvg42OwDFtNP8NLC4YIgEjGXTRLnE8T56UnncH5E=;
        b=bt+vYPF5c9IbpbnzZslOuz0ex2C7azsg6hPzEs3iM9P9vgwEEHglqH/nglqMJwKMvA
         aCA5KT908gLA5pZ4gE+TnW0Kpwc4yG8GKUtA6m/Le6aOeyAVAOq8fl7sFnQwzGsDlIet
         PNmJiVeHHyxfRQ73WMC3or0H4kImDsSSNqy3tQUPZITGkxk9iEcyG2IONV6qcl1RP0Pm
         d82NRtfJ1SGxfwWYENOScMzSLazoIduVqtK/uxYgDp8jGHZcHdzTfJnee+NUp3yOONnD
         VmFjJe4UgHIyI+1rk/AzQyQ4Ma6IFUXn6EglJSM/xtkVePVmPi1AKCo76AMfHDKTLJhR
         0oMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701269757; x=1701874557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dipYvg42OwDFtNP8NLC4YIgEjGXTRLnE8T56UnncH5E=;
        b=iJXhCJqbBxn9S+vaazeEq1BZiT+ejxmPB5yGlP1PqiUQV90tcySvNTTqP+454H7C5X
         3coHJsy3Eb0Pay4k8CGvW17A14uEk+XMFkmq9Ek+dR/ZAwa5EZLbdfH2xloq92PdKbc7
         YvSD+EQxmqeGBahssPbt283hikhjnqesxWkrS/rycBKyx+tY73sPyeFGPUAfgLb/ewW0
         Pwa4/X30jCuJ9rPc+t9jbF8W8dUzst481iPhLNa5ENjrupYAVU8R0Kpn4OMi8C1TWD6s
         41vY5NN3VBNWgwCluYuQEc1orVr3dbwtLEAYqnRnnFp5IuDPTOvHruehrWHgKFGeEGH6
         SW4A==
X-Gm-Message-State: AOJu0YygqXMi122Y28ylbTwPRQLWhDtdVfoO+l+mzayQf2Ht6pJNbslV
	TJ4Ej1nT9koslLk5aqjzrRg7GRoNJ3h1oHKz8FA=
X-Google-Smtp-Source: AGHT+IGVGk8y1wrBIZR2gg28dTjFQVvKmvbqfq74CgxHF3Z8MSIv2e7ZCqSjehjFKongjjzpNKSkLVQ6itsxPGa8Luc=
X-Received: by 2002:a05:6000:239:b0:32d:a01a:9573 with SMTP id
 l25-20020a056000023900b0032da01a9573mr11678650wrz.8.1701269757001; Wed, 29
 Nov 2023 06:55:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129003656.1165061-1-song@kernel.org> <20231129003656.1165061-7-song@kernel.org>
 <CAADnVQJb3Ur--A8jaiVqpea1kFXMCd46uP+X4ydcOVG3a5Ve3Q@mail.gmail.com> <CAPhsuW5Kvcj8cOFf0ZeLZ428+=pjXQfCqx7aYBCthVgtRN2J3g@mail.gmail.com>
In-Reply-To: <CAPhsuW5Kvcj8cOFf0ZeLZ428+=pjXQfCqx7aYBCthVgtRN2J3g@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 29 Nov 2023 06:55:45 -0800
Message-ID: <CAADnVQLnMfu91VMVzdh=_qMNhzwvks69XHa5RPbsXk1c437-Hg@mail.gmail.com>
Subject: Re: [PATCH v14 bpf-next 6/6] selftests/bpf: Add test that uses
 fsverity and xattr to sign a file
To: Song Liu <song@kernel.org>
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

On Wed, Nov 29, 2023 at 3:20=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Tue, Nov 28, 2023 at 10:47=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, Nov 28, 2023 at 4:37=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > > +char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) + SHA256_DIG=
EST_SIZE];
> >
> > when vmlinux is built without CONFIG_FS_VERITY the above fails
> > in a weird way:
> >   CLNG-BPF [test_maps] test_sig_in_xattr.bpf.o
> > progs/test_sig_in_xattr.c:36:26: error: invalid application of
> > 'sizeof' to an incomplete type 'struct fsverity_digest'
> >    36 | char digest[MAGIC_SIZE + sizeof(struct fsverity_digest) +
> > SHA256_DIGEST_SIZE];
> >       |                          ^     ~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Is there a way to somehow print a hint during the build what
> > configs users need to enable to pass the build ?
>
> Patch 5/6 added CONFIG_FS_VERITY to tools/testing/selftests/bpf/config.
> This is a more general question for all required CONFIG_* specified in th=
e
> file (and the config files for other selftests).
>
> In selftests/bpf/Makefile, we have logic to find vmlinux. We can add simi=
lar
> logic to find .config used to build the vmlinux, and grep for each requir=
ed
> CONFIG_* from the .config file. Does this sound like a viable solution?

No need for new logic to parse .config.
libbpf does it already and
extern bool CONFIG_FS_VERITY __kconfig __weak;
works.

Since you hard code MAGIC_SIZE anyway I'm asking
to hard code sizeof(struct fsverity_digest) as well, since the bpf prog
doesn't access it directly. It only needs to know its size.

While inside:
int BPF_PROG(test_file_open, struct file *f)
{
  if (!CONFIG_FS_VERITY) {
     skip_fs_verity_test =3D true;
     return 0;
  }

and report it as a clean error message in test_progs.

We keep adding new config requirements selftests/bpf/config which
forces all developers to keep adding new configs to their builds.
In the past, when we didn't have BPF CI, that was necessary, but now
BPF CI does it for us.
With clean error message from test_progs the developers can either
ignore the error and proceed with their work or adjust their .config
eventually. While hard selftest build error forces all devs to
update .config right away and build error has no info of what needs
to be done which is not developer friendly.

pw-bot: cr

