Return-Path: <linux-fsdevel+bounces-144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC707C61D4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 02:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AE0E1C20B13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 00:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E13E802;
	Thu, 12 Oct 2023 00:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1vIRHFd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2C6645;
	Thu, 12 Oct 2023 00:32:11 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD5B9D;
	Wed, 11 Oct 2023 17:32:09 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32d569e73acso403523f8f.1;
        Wed, 11 Oct 2023 17:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697070728; x=1697675528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJfRrXMe+CPTMJ8Rp+Um6fMWxKzltB9dGZHa4Am8HVY=;
        b=g1vIRHFdvY+N4TUSzMb7nVuJw3Up5WyVJRsh//MOQ8CjpMyS9lOd3cF3Zhk/KQ9Zlk
         XEa3o+01yfT0YIDy2qtMb05jvrUq5B7XVxDfUrbgBZlBB7+9HCBN/7Zu1I1TakP9s3E4
         Ivy2kPepOF9FQuBThtKfZMl36HD3HGBsRVm4kUwfK6yAo4vLZ5RkMCy5SVwOp7FmVUm8
         UBfiCn0gYcTfwFjU32rBa88zxBSskM2shHYKjn3+zA6iNNo/JeOD6hLev7MO4//uKlrr
         73tQo2wDVdKazig7TpMLJR9JWndaVPCMB+r7pzWxHd5GEOw2Pdh/TnFMQDtEqB0Ty7mV
         XujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697070728; x=1697675528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJfRrXMe+CPTMJ8Rp+Um6fMWxKzltB9dGZHa4Am8HVY=;
        b=TRhox6zYhv9Le7zegKluKVzbvNnJrHZf9a5638EZ6mmmznLhmcFhgmBXHMlwR61be3
         QmRtU9Jwa5pEBn8Mj997I+Pd4Qa1UOLBCr1Ds/ABpOtRQmkBdd9cVhJ+iMzPkNuv0tOR
         t0Z3HfXZVvbEi6mVrakgIGYYW4KM2C6qzKBRA0Wv2u+4Kk0N7Wysc8SThvcH9DetZBll
         kA1EF1geEdWQrPnfxcBJydqYx9N08CiE9z33x0gQSzoym2PSpsviDIBQzF21jiQLUYxK
         QKlSQmawQBi5iY4eG9M2Sgbhw9RyGUU4XRRxbs8MJfv3bIw/JYY07JCmC2HukNLZJC5a
         m4VA==
X-Gm-Message-State: AOJu0YwgJxve+oF8Y2NMa6wme0ybkjQWwczWzHTFUTSFGxD+7I0SFcY6
	/ILj9qqSJxTuhCziOAtmGFvzIEkV2eTYzwBdoT4=
X-Google-Smtp-Source: AGHT+IEXfVeuwKII/e1Y+kF47QXwIgTrZ44hkpop3xbThiuwXu/5t5Mzu5CgixPfta4zBReuqQ7LtT1+6dhyOmj37tE=
X-Received: by 2002:a5d:5e0f:0:b0:32d:895a:db7d with SMTP id
 ce15-20020a5d5e0f000000b0032d895adb7dmr1976875wrb.40.1697070727782; Wed, 11
 Oct 2023 17:32:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927225809.2049655-7-andrii@kernel.org> <9fe88aef7deabbe87d3fc38c4aea3c69.paul@paul-moore.com>
In-Reply-To: <9fe88aef7deabbe87d3fc38c4aea3c69.paul@paul-moore.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Oct 2023 17:31:56 -0700
Message-ID: <CAEf4BzYXujp5CgyuG5uhwk20+bQCdQ68jaNBO0SjO=1xNWiiow@mail.gmail.com>
Subject: Re: [PATCH v6 6/13] bpf: add BPF token support to BPF_PROG_LOAD command
To: Paul Moore <paul@paul-moore.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	keescook@chromium.org, brauner@kernel.org, lennart@poettering.net, 
	kernel-team@meta.com, sargun@sargun.me, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 6:17=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sep 27, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Add basic support of BPF token to BPF_PROG_LOAD. Wire through a set of
> > allowed BPF program types and attach types, derived from BPF FS at BPF
> > token creation time. Then make sure we perform bpf_token_capable()
> > checks everywhere where it's relevant.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  include/linux/bpf.h                           |  6 ++
> >  include/uapi/linux/bpf.h                      |  2 +
> >  kernel/bpf/core.c                             |  1 +
> >  kernel/bpf/inode.c                            |  6 +-
> >  kernel/bpf/syscall.c                          | 87 ++++++++++++++-----
> >  kernel/bpf/token.c                            | 25 ++++++
> >  tools/include/uapi/linux/bpf.h                |  2 +
> >  .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
> >  .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
> >  9 files changed, 108 insertions(+), 26 deletions(-)
>
> ...
>
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 5c5c2b6648b2..d0b219f09bcc 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -2685,6 +2718,10 @@ static int bpf_prog_load(union bpf_attr *attr, b=
pfptr_t uattr, u32 uattr_size)
> >       prog->aux->sleepable =3D attr->prog_flags & BPF_F_SLEEPABLE;
> >       prog->aux->xdp_has_frags =3D attr->prog_flags & BPF_F_XDP_HAS_FRA=
GS;
> >
> > +     /* move token into prog->aux, reuse taken refcnt */
> > +     prog->aux->token =3D token;
> > +     token =3D NULL;
> > +
> >       err =3D security_bpf_prog_alloc(prog->aux);
> >       if (err)
> >               goto free_prog;
>
> As we discussed in the earlier thread, let's tweak/rename/move the
> security_bpf_prog_alloc() call down to just before the bpf_check() call
> so it looks something like this:
>
>   err =3D security_bpf_prog_load(prog, &attr, token);
>   if (err)
>     goto proper_jump_label;
>
>   err =3D bpf_check(...);
>
> With the idea being that LSMs which implement the token hooks would
> skip any BPF_PROG_LOAD access controls in security_bpf() and instead
> implement them in security_bpf_prog_load().
>
> We should also do something similar for map_create() and
> security_bpf_map_alloc() in patch 4/13.

Sounds good, will do!


>
> --
> paul-moore.com

