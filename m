Return-Path: <linux-fsdevel+bounces-1639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FAB7DCD2B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 13:47:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA31728176F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 12:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BBEA1C3A;
	Tue, 31 Oct 2023 12:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA282A57
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 12:47:18 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B28C2;
	Tue, 31 Oct 2023 05:47:17 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7eef0b931so53665537b3.0;
        Tue, 31 Oct 2023 05:47:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698756436; x=1699361236;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dtpwqyp0A02VdCSa2nK6MzwPbTqa+e280XT4tyuC4zk=;
        b=YF3qas8q/OxGaXVMDiv5OlZ9BeuRPsRHg3ZAY8CLlL8jeuvCt0H2MFsaRnb3BH9gnZ
         l7iE3/SzpT74JysnnS6PN1FfTtl3GMYkvnSfml9WRsm9nUmunXiEeULi42FjpjrS+CC+
         V0d4Zx/ydd9tUNxpHk7KQIenBzXq7CrdlIHGMJCZY8DgnARsOKPLTB2Q0cA6c+CmDQQO
         x2r94QXrtDzIab9dqVM4CqgpOU7NHcZuwSG7McHjrdxFujicpV3T1GPqqZj0Mvs3+SEV
         93NIdSHpyrzn+pMdiyutGlb4UeR/YaWNBz05Mxk91BA7JFF9LlC/KSV2l602HJfkKGxg
         pv+Q==
X-Gm-Message-State: AOJu0YwjJfFXS51CTdJCbDNiftUZ82f+z2Tmf4fywrtmgRTQbDda4Qjg
	gRPt4xG+ke87qcnjXsKoHLbcnYSEP0YxXQ==
X-Google-Smtp-Source: AGHT+IGv50Jyg14I5ATij6XR9WTbTLhs4fH0g+tTx6SOrSqaEvL/HtGcU6fZoSOSQK42fXtVM3WXZw==
X-Received: by 2002:a05:690c:714:b0:5a8:d86f:bb3f with SMTP id bs20-20020a05690c071400b005a8d86fbb3fmr13720875ywb.8.1698756436034;
        Tue, 31 Oct 2023 05:47:16 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id t8-20020a0dea08000000b0059b085c4051sm741572ywe.85.2023.10.31.05.47.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 05:47:15 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9a4c0d89f7so5110330276.1;
        Tue, 31 Oct 2023 05:47:15 -0700 (PDT)
X-Received: by 2002:a25:fc16:0:b0:d9b:4f28:f6ce with SMTP id
 v22-20020a25fc16000000b00d9b4f28f6cemr10853098ybd.1.1698756435614; Tue, 31
 Oct 2023 05:47:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
In-Reply-To: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 31 Oct 2023 13:47:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXpwMdLuoWsNGa8qacT_5Wv-vSTz0xoBR5n_fnD9cNOuQ@mail.gmail.com>
Message-ID: <CAMuHMdXpwMdLuoWsNGa8qacT_5Wv-vSTz0xoBR5n_fnD9cNOuQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs for v6.7
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Mon, Oct 30, 2023 at 3:56=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d=
1d:
>
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
>
> are available in the Git repository at:
>
>   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-10-30
>
> for you to fetch changes up to b827ac419721a106ae2fccaa40576b0594edad92:
>
>   exportfs: Change bcachefs fid_type enum to avoid conflicts (2023-10-26 =
16:41:00 -0400)
>
> ----------------------------------------------------------------
> Initial bcachefs pull request for 6.7-rc1
>
> Here's the bcachefs filesystem pull request.
>
> One new patch since last week: the exportfs constants ended up
> conflicting with other filesystems that are also getting added to the
> global enum, so switched to new constants picked by Amir.
>
> I'll also be sending another pull request later on in the cycle bringing
> things up to date my master branch that people are currently running;
> that will be restricted to fs/bcachefs/, naturally.
>
> Testing - fstests as well as the bcachefs specific tests in ktest:
>   https://evilpiepirate.org/~testdashboard/ci?branch=3Dbcachefs-for-upstr=
eam
>
> It's also been soaking in linux-next, which resulted in a whole bunch of
> smatch complaints and fixes and a patch or two from Kees.
>
> The only new non fs/bcachefs/ patch is the objtool patch that adds
> bcachefs functions to the list of noreturns. The patch that exports
> osq_lock() has been dropped for now, per Ingo.

Thanks for your PR!

>  fs/bcachefs/mean_and_variance.c                 |  159 ++
>  fs/bcachefs/mean_and_variance.h                 |  198 ++
>  fs/bcachefs/mean_and_variance_test.c            |  240 ++

Looking into missing dependencies for MEAN_AND_VARIANCE_UNIT_TEST and
failing mean_and_variance tests, this does not seem to match what was
submitted for public review?

Lore only has:
"[PATCH 31/32] lib: add mean and variance module."
https://lore.kernel.org/all/20230509165657.1735798-32-kent.overstreet@linux=
.dev/

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

