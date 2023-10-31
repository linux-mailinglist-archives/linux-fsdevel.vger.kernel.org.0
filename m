Return-Path: <linux-fsdevel+bounces-1650-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848037DCFD4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 16:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3712228137B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FCD1DFDC;
	Tue, 31 Oct 2023 15:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA931A5AB
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 15:00:46 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C78DB;
	Tue, 31 Oct 2023 08:00:44 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1e993765c1bso3901079fac.3;
        Tue, 31 Oct 2023 08:00:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698764443; x=1699369243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFk7CTu0sTNMbN/yyWrgJyegrXLrps7A3T0HAuISYtg=;
        b=TBqRDNhMZPjxqN9c4ufMRIhPRwvRX/I7WBFP9K6BHjJUet6lMinKXozb6Vjsl4Kvb4
         9rEQQHAyA8GD14x4X/gEAM4G2PHH3Y7FptQlBpqqW8MoJPfBqrc91yQNg/p4qCB64jow
         NzXFkO2inNw7Fcui/76+6q/GPo0wD6Y3PWR0dmuJ1zShFskyvVPTvh30aKSNBuli6QGU
         YmEL7I3DfBJWrWamsYzJb50OMoK3lCDG9fYDUtIikHZNTxVQ3e3va2knDN+LHCizwXrM
         ABqey31CIoB5WuFLWvGalkEwDbfj30fDpDjkaJXuC3X+AIRinDvqIx5YaOUIfj/Rhh8w
         UM0A==
X-Gm-Message-State: AOJu0Ywma0p1NkutxlBojlCAtGg+EGmiLe5FLMkkwvZSAH20saEE2Zl+
	W3kc9sFQcdZ103xEM1Jz9RjzFenglmadHw==
X-Google-Smtp-Source: AGHT+IE0slbHt809PdGr+3wxZB301IeoV6MzJh77vHSWgA0R0+p8Pq3VrIX79dRBSpqv34URObAhTQ==
X-Received: by 2002:a05:6870:9d82:b0:1f0:b5f:8898 with SMTP id pv2-20020a0568709d8200b001f00b5f8898mr2758642oab.55.1698764441942;
        Tue, 31 Oct 2023 08:00:41 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id b19-20020a25ae93000000b00da086d6921fsm891774ybj.50.2023.10.31.08.00.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 08:00:41 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a7dd65052aso59607207b3.0;
        Tue, 31 Oct 2023 08:00:41 -0700 (PDT)
X-Received: by 2002:a81:ed0b:0:b0:5a7:ccf3:7163 with SMTP id
 k11-20020a81ed0b000000b005a7ccf37163mr11497141ywm.15.1698764441239; Tue, 31
 Oct 2023 08:00:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030145540.pjkggoiddobyjicq@moria.home.lan>
 <CAMuHMdXpwMdLuoWsNGa8qacT_5Wv-vSTz0xoBR5n_fnD9cNOuQ@mail.gmail.com> <20231031144505.bqnxu3pgrodp7ukp@moria.home.lan>
In-Reply-To: <20231031144505.bqnxu3pgrodp7ukp@moria.home.lan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 31 Oct 2023 16:00:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVKi=ShPUwTHrX0CEN2f9+jRXWymnKH=BiXTpmg857AJQ@mail.gmail.com>
Message-ID: <CAMuHMdVKi=ShPUwTHrX0CEN2f9+jRXWymnKH=BiXTpmg857AJQ@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs for v6.7
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kent,

On Tue, Oct 31, 2023 at 3:45=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Tue, Oct 31, 2023 at 01:47:02PM +0100, Geert Uytterhoeven wrote:
> > On Mon, Oct 30, 2023 at 3:56=E2=80=AFPM Kent Overstreet
> > <kent.overstreet@linux.dev> wrote:
> > > The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c=
917d1d:
> > >
> > >   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> > >
> > > are available in the Git repository at:
> > >
> > >   https://evilpiepirate.org/git/bcachefs.git tags/bcachefs-2023-10-30
> > >
> > > for you to fetch changes up to b827ac419721a106ae2fccaa40576b0594edad=
92:
> > >
> > >   exportfs: Change bcachefs fid_type enum to avoid conflicts (2023-10=
-26 16:41:00 -0400)
> > >
> > > ----------------------------------------------------------------
> > > Initial bcachefs pull request for 6.7-rc1
> > >
> > > Here's the bcachefs filesystem pull request.
> > >
> > > One new patch since last week: the exportfs constants ended up
> > > conflicting with other filesystems that are also getting added to the
> > > global enum, so switched to new constants picked by Amir.
> > >
> > > I'll also be sending another pull request later on in the cycle bring=
ing
> > > things up to date my master branch that people are currently running;
> > > that will be restricted to fs/bcachefs/, naturally.
> > >
> > > Testing - fstests as well as the bcachefs specific tests in ktest:
> > >   https://evilpiepirate.org/~testdashboard/ci?branch=3Dbcachefs-for-u=
pstream
> > >
> > > It's also been soaking in linux-next, which resulted in a whole bunch=
 of
> > > smatch complaints and fixes and a patch or two from Kees.
> > >
> > > The only new non fs/bcachefs/ patch is the objtool patch that adds
> > > bcachefs functions to the list of noreturns. The patch that exports
> > > osq_lock() has been dropped for now, per Ingo.
> >
> > Thanks for your PR!
> >
> > >  fs/bcachefs/mean_and_variance.c                 |  159 ++
> > >  fs/bcachefs/mean_and_variance.h                 |  198 ++
> > >  fs/bcachefs/mean_and_variance_test.c            |  240 ++
> >
> > Looking into missing dependencies for MEAN_AND_VARIANCE_UNIT_TEST and
> > failing mean_and_variance tests, this does not seem to match what was
> > submitted for public review?
> >
> > Lore only has:
> > "[PATCH 31/32] lib: add mean and variance module."
> > https://lore.kernel.org/all/20230509165657.1735798-32-kent.overstreet@l=
inux.dev/
>
> It was later moved back into fs/bcachefs/, yes. I want to consolidate
> the time stats code in bcachefs and bcachefs, so I'll be sending a PR to
> move it back out at some point.

OK.

> Can you point me at what's failing?

MEAN_AND_VARIANCE_UNIT_TEST should depend on BCACHEFS_FS, as the actual
mean_and_variance code is only compiled if BCACHEFS_FS is enabled.

On m68k (ARAnyM), it fails with:

KTAP version 1
1..1
    KTAP version 1
    # Subtest: mean and variance tests
    # module: mean_and_variance_test
    1..9
    ok 1 mean_and_variance_fast_divpow2
    ok 2 mean_and_variance_u128_basic_test
    ok 3 mean_and_variance_basic_test
    ok 4 mean_and_variance_weighted_test
    ok 5 mean_and_variance_weighted_advanced_test
    ok 6 mean_and_variance_test_1
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 22 (0x16)
        mean[i] =3D=3D 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 32 (0x20)
        stddev[i] =3D=3D 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 21 (0x15)
        mean[i] =3D=3D 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 29 (0x1d)
        stddev[i] =3D=3D 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 20 (0x14)
        mean[i] =3D=3D 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 28 (0x1c)
        stddev[i] =3D=3D 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 19 (0x13)
        mean[i] =3D=3D 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 27 (0x1b)
        stddev[i] =3D=3D 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 18 (0x12)
        mean[i] =3D=3D 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 26 (0x1a)
        stddev[i] =3D=3D 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 17 (0x11)
        mean[i] =3D=3D 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 25 (0x19)
        stddev[i] =3D=3D 9 (0x9)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 16 (0x10)
        mean[i] =3D=3D 10 (0xa)
    # mean_and_variance_test_2: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 24 (0x18)
        stddev[i] =3D=3D 9 (0x9)
    not ok 7 mean_and_variance_test_2
    ok 8 mean_and_variance_test_3
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 22 (0x16)
        mean[i] =3D=3D 10 (0xa)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 32 (0x20)
        stddev[i] =3D=3D 9 (0x9)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 32 (0x20)
        mean[i] =3D=3D 11 (0xb)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 39 (0x27)
        stddev[i] =3D=3D 13 (0xd)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 40 (0x28)
        mean[i] =3D=3D 12 (0xc)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 42 (0x2a)
        stddev[i] =3D=3D 15 (0xf)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 46 (0x2e)
        mean[i] =3D=3D 13 (0xd)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 44 (0x2c)
        stddev[i] =3D=3D 17 (0x11)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:111
    Expected mean_and_variance_get_mean(mv) =3D=3D mean[i], but
        mean_and_variance_get_mean(mv) =3D=3D 50 (0x32)
        mean[i] =3D=3D 14 (0xe)
    # mean_and_variance_test_4: EXPECTATION FAILED at
fs/bcachefs/mean_and_variance_test.c:112
    Expected mean_and_variance_get_stddev(mv) =3D=3D stddev[i], but
        mean_and_variance_get_stddev(mv) =3D=3D 45 (0x2d)
        stddev[i] =3D=3D 19 (0x13)
    not ok 9 mean_and_variance_test_4
# mean and variance tests: pass:7 fail:2 skip:0 total:9
# Totals: pass:7 fail:2 skip:0 total:9
not ok 1 mean and variance tests

Haven't tried the test on any other platform yet, so this could be a
big-endian, 32-bit, m68k-specific, or even a generic problem.

Thanks!

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

