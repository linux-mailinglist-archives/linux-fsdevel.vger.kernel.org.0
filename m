Return-Path: <linux-fsdevel+bounces-4480-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F047FF9EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 19:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316851C20BF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B095A0ED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3s9y6A1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6425810E6;
	Thu, 30 Nov 2023 10:35:09 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c8880f14eeso16977581fa.3;
        Thu, 30 Nov 2023 10:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701369307; x=1701974107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5j0MYi1EmpAs4vkSO6HL58vhT2GWcpH8toY8hu23OqE=;
        b=a3s9y6A1z8vTUIsoDQLneA17j2D9Gq7IzfFjiVBXDF6MYA4KS1yYWLOtcaqc/GlzQQ
         F8+kwpOetK1o7Nh8o9Kh85W3mYdae+ZKuoLjknd2co6ytfK7qc3kCmSVkyfvm/kQzIq0
         3Rs7LPABrwJN/EH8kuSpXgjqXkBNuhb+ue+efzRXAGJfAgKcesDOz0MXGUdCctu2J1nS
         j85DkQGkqXEHgEUjYKchB44Gsgub0D0woAWHN+BPW1T/pL90kF1zcQodfx3qMNWZdMEV
         G0fmPUdmgfMElFJp3kj6wUaLnrPsYr9JjlPQ6M2jCjKGk2LC1STZpOSx45SWW149uFl8
         4N5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701369307; x=1701974107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5j0MYi1EmpAs4vkSO6HL58vhT2GWcpH8toY8hu23OqE=;
        b=PdDNpvvt12IKXDit6VyN6JW91fhunDb0Rc6/sicHSV4Y2xc2vV1F2/7Pasj8JFSU2g
         CBDjPo5aTMWY+T9LwX4AN80cinrsBlBcAmaZUbWLBbMG+6CYBHOcsNAJGExMPwX7x3/k
         tnNPEox4N3vwukvX8bX7zZv3GKpcWdPsUrqZxnemohNgFpv9IUZ0auvoqDCMu6RWkRsc
         xEbOi9KIwQGsnI8uKTdhIEcihfSvJqXkGm47kuBfaEmaOYufts3BlZwoQAwu81phv08y
         Y1CLeBiAAPTH6LZPYHZ8l/uUrqtlF1SwleMa7m2hlUvz8uPbnCVJoekUeptp4GtlhLMv
         XFPA==
X-Gm-Message-State: AOJu0Yxtxd0dhqin8ZtBEzsxyQt2aBlaDqJgjycspN2Rxn3r4pVX3Foe
	Pc3azeumSvtPufSeAEDCZ4ChzeWHq0DLxTHbrwXkEpzv
X-Google-Smtp-Source: AGHT+IGQMmBamYKpbN3s4BKorxI5njxEwZ5bJJKISr5EAR2dxu2h/GTSJ0Kw/Di4VpmNbUaguMwK+1fO/gH2iWnx44k=
X-Received: by 2002:a17:906:d78d:b0:a19:8831:d76a with SMTP id
 pj13-20020a170906d78d00b00a198831d76amr9177ejb.38.1701367460243; Thu, 30 Nov
 2023 10:04:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127190409.2344550-1-andrii@kernel.org> <20231127190409.2344550-3-andrii@kernel.org>
 <20231130163655.GC32077@kernel.org>
In-Reply-To: <20231130163655.GC32077@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Nov 2023 10:03:48 -0800
Message-ID: <CAEf4BzZ0JWFrS_DLk_YOGNqyh39kqFcCNbd_D6mCM6d0mzxO_Q@mail.gmail.com>
Subject: Re: [PATCH v11 bpf-next 02/17] bpf: add BPF token delegation mount
 options to BPF FS
To: Simon Horman <horms@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	paul@paul-moore.com, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	kernel-team@meta.com, sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 8:37=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Mon, Nov 27, 2023 at 11:03:54AM -0800, Andrii Nakryiko wrote:
>
> ...
>
> > @@ -764,7 +817,10 @@ static int bpf_get_tree(struct fs_context *fc)
> >
> >  static void bpf_free_fc(struct fs_context *fc)
> >  {
> > -     kfree(fc->fs_private);
> > +     struct bpf_mount_opts *opts =3D fc->s_fs_info;
> > +
> > +     if (opts)
> > +             kfree(opts);
> >  }
>
> Hi Andrii,
>
> as it looks like there will be a v12, I have a minor nit to report: There
> is no need to check if opts is non-NULL because kfree() is basically a
> no-op if it's argument is NULL.
>
> So perhaps this can become (completely untested!):
>
> static void bpf_free_fc(struct fs_context *fc)
> {
>         kfree(fc->s_fs_info);
> }
>

sure, I can drop the check, I wasn't sure if it's canonical or not to
check the argument for NULL before calling kfree(). For user-space
it's definitely quite expected to not have to check for null before
calling free().


> ...

