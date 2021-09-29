Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D0441CC3C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Sep 2021 21:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346407AbhI2TDT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Sep 2021 15:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345276AbhI2TDN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:03:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C94A961452;
        Wed, 29 Sep 2021 19:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632942092;
        bh=9BZ9SSNsunYXKIbF+mdQMEB+a7jO8KRnYCiZ9joa8Kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ByqA7vIURnm2UsOZu2n0iL0xlzT0yi80z6jgMGuxYEqGCH0zXDvI6R1U0qBAfdIKf
         mvm55L8qEXRhYLRnAo/xnvZk88WT3ihqdM7wzWzxzmAUvVmF7XPWpdZdrVMCm7kz0v
         JNF1LiRbKiZztxduPw91K44Mg1QcybzLj87Dtw0T1a3L8LpUcdvtwi61dEaEpWLh0R
         mNFmWK+uPoDh4AV4G+3h3EbzPHPxPazjmxBT7uAUBxdxaIZ/QqnUsEJzN/P1kKwArp
         czJvKoCKbo0uSN92OmrSI74V/u89rF0mcDU0FXPXKWmCFvWNX3OYBp7Fmq6nwiANeJ
         TWlsJvmH339pA==
Date:   Wed, 29 Sep 2021 20:00:42 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vito Caputo <vcaputo@pengaru.com>,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Metzmacher <metze@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Anand K Mistry <amistry@google.com>,
        Alexey Gladkov <legion@kernel.org>,
        Michal Hocko <mhocko@suse.com>, Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Ohhoon Kwon <ohoono.kwon@samsung.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] proc: Disable /proc/$pid/wchan
Message-ID: <20210929190042.GU4199@sirena.org.uk>
References: <20210923234917.pqrxwoq7yqnvfpwu@shells.gnugeneration.com>
 <CAG48ez0Rtv5kqHWw368Ym3GkKodPA+JETOAN+=c2KPa3opENSA@mail.gmail.com>
 <20210924002230.sijoedia65hf5bj7@shells.gnugeneration.com>
 <202109231814.FD09DBAD3@keescook>
 <20210924135424.GA33573@C02TD0UTHF1T.local>
 <202109240716.A0792BE46@keescook>
 <20210927090337.GB1131@C02TD0UTHF1T.local>
 <202109271103.4E15FC0@keescook>
 <20210927205056.jjdlkof5w6fs5wzw@treble>
 <202109291152.681444A135@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pzbqGaOtRNiVr7w4"
Content-Disposition: inline
In-Reply-To: <202109291152.681444A135@keescook>
X-Cookie: 98% lean.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--pzbqGaOtRNiVr7w4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 29, 2021 at 11:54:55AM -0700, Kees Cook wrote:
> On Mon, Sep 27, 2021 at 01:50:56PM -0700, Josh Poimboeuf wrote:

> > Even with that patch, it doesn't lock the task's runqueue before reading
> > the stack, so there's still the possibility of the task running on
> > another CPU and the unwinder going off the rails a bit, which might be
> > used by an attacker in creative ways similar to the /proc/<pid>/stack
> > vulnerability Jann mentioned earlier.

> Since I think we're considering get_wchan() to be slow-path, can we just
> lock the runqueue and use arch_stack_walk_reliable()?

Unfortunately arch_stack_walk_reliable() is only available for powerpc,
s390 and x86 currently - work is in progress to implement it for arm64
as well but it's not there yet.

--pzbqGaOtRNiVr7w4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmFUt9kACgkQJNaLcl1U
h9BfJgf+O3xANtFrCZ5ZmvugZNPSBKmFmwXYza30TbY2cow+hwARTUCHPxRCDxq3
xHnib4kJ43GPqzw/CGZzdzYMv9JY6Uxk7o0v/4bemkoH5hywwVC0vefRVeFCsX9b
Wq7NwpmwbKz9hL3fRnlWL5Y8MGWieuOo+QgK5eOe82h9Z9BjzxLTY2hIKk09AlQA
NGouW/lSLQPyfN5SyD2LKETG1y2SlY3GwYEZIDSCScY/9JnlF40pgByIudz+Xi5O
xIZUR6UpeCQAAFf6f6VgoUWVAdVgLKMq/wnBmajicvzj+p8QFi3krttH2H8ZwVX6
v2RVJaXwOmj/g/llVWW6WgZqgxcz2Q==
=nUIA
-----END PGP SIGNATURE-----

--pzbqGaOtRNiVr7w4--
