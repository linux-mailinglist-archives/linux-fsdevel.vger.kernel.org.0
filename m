Return-Path: <linux-fsdevel+bounces-4478-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2902A7FF9EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2AEFB20E0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2795A0E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adaktQGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4E310E6;
	Thu, 30 Nov 2023 10:17:25 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a195e0145acso45840766b.2;
        Thu, 30 Nov 2023 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701368244; x=1701973044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUIjlhGrTCTJrqHaZjfICGnj00MmGrI2My3h00EAwwQ=;
        b=adaktQGmuhlUpATa8rAJ+K4ZSg4dGwSw4clQSopSJkgjIh4gmCKXzder1UhZmAGzrF
         TEmPoz7Df66nqpVN5OatU5oQrK3SaHmap9EBQtBhL0enCw59gRscMwQGYH219vcBGp9k
         hfh98m3/yNhx/G/aL4ttGJdt4l0S5jvd2pFzAYXsMjM0r1rdrNQ72wgwgOMsyU7yf5FJ
         zYTI8Brm7LkEwlGxsqeUHIcw1a2IHyIP4xtYx/L1qzNO5kOw8soe5dzezVg9M4vGVVRh
         Czpzdr47HpWxFGc4Es1llwj9Aaut0XZYGBQzmm3i6qOoS1wLJhw/GOT5l31WoCEXN9cC
         Q/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701368244; x=1701973044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AUIjlhGrTCTJrqHaZjfICGnj00MmGrI2My3h00EAwwQ=;
        b=o7PuOlXV8Zp2UrDZfFqMbcGFDLr0ETCQSATzl6S3jmDzMG15iRE4H5yhV0fs9kJklG
         FWwV0H5S/bpltqOoLTrQqLh7BbhvllZEAS4g9j9zK+dMP6tnfvWZhTWAE1bLts7UYbGQ
         YjZVCTZ+g7gk5FQvWZfLixghenDzgp9NeRvgw+3Jb3muaB9T/Xd5rQhciBpU5zXCT4Mz
         y9XebXC1CgCgQgKt1/+J9YhG/MVB2/Zw2HOHCqwlGraEIH3rk73sxl0QxfX345SH710X
         Zhjl+4QMwqOMCXKM+m3v1dbp0Hl/KPxxSg7HT1V4bdUk5v/NNT8fX6YGkCzUCWHDIb8/
         eZyg==
X-Gm-Message-State: AOJu0YzoQ+4+GHMsUkThRDgKjAjvPC0vjc7r65o9DwTZS1tkWiWPwn5f
	hEMEZoDGSqVFOJEy34voDOMC3hVKoHwH5kEYvCHAz0WC
X-Google-Smtp-Source: AGHT+IFJZP+RKDKBSfiySbRt/YdnMzp5WC7WmUAF0E2nLx9EsIl6Q+l26jvjkX8V9USQK5qdRhwPBjcrILuMmKFsag8=
X-Received: by 2002:a17:906:590a:b0:a19:a19b:4274 with SMTP id
 h10-20020a170906590a00b00a19a19b4274mr7871ejq.223.1701368034201; Thu, 30 Nov
 2023 10:13:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127190409.2344550-1-andrii@kernel.org> <20231127190409.2344550-3-andrii@kernel.org>
 <20231130163655.GC32077@kernel.org> <CAEf4BzZ0JWFrS_DLk_YOGNqyh39kqFcCNbd_D6mCM6d0mzxO_Q@mail.gmail.com>
In-Reply-To: <CAEf4BzZ0JWFrS_DLk_YOGNqyh39kqFcCNbd_D6mCM6d0mzxO_Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Nov 2023 10:13:41 -0800
Message-ID: <CAEf4BzbN2xovoTyQeK1sHZdB-YMeiC=U7oOmUcpcb5_ZHEcFgA@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
To: Simon Horman <horms@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 10:03=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Nov 30, 2023 at 8:37=E2=80=AFAM Simon Horman <horms@kernel.org> w=
rote:
> >
> > On Mon, Nov 27, 2023 at 11:03:54AM -0800, Andrii Nakryiko wrote:
> >
> > ...
> >
> > > @@ -764,7 +817,10 @@ static int bpf_get_tree(struct fs_context *fc)
> > >
> > >  static void bpf_free_fc(struct fs_context *fc)
> > >  {
> > > -     kfree(fc->fs_private);
> > > +     struct bpf_mount_opts *opts =3D fc->s_fs_info;
> > > +
> > > +     if (opts)
> > > +             kfree(opts);
> > >  }
> >
> > Hi Andrii,
> >
> > as it looks like there will be a v12, I have a minor nit to report: The=
re
> > is no need to check if opts is non-NULL because kfree() is basically a
> > no-op if it's argument is NULL.
> >
> > So perhaps this can become (completely untested!):
> >
> > static void bpf_free_fc(struct fs_context *fc)
> > {
> >         kfree(fc->s_fs_info);
> > }
> >
>
> sure, I can drop the check, I wasn't sure if it's canonical or not to
> check the argument for NULL before calling kfree(). For user-space
> it's definitely quite expected to not have to check for null before
> calling free().

Heh, turns out I already simplified this, but it's in the next patch.
I'll move it into patch #2, though, where it actually belongs.

>
>
> > ...

