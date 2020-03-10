Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA3F17FEA7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Mar 2020 14:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgCJNgo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Mar 2020 09:36:44 -0400
Received: from foss.arm.com ([217.140.110.172]:35116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbgCJMm2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:42:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 177C130E;
        Tue, 10 Mar 2020 05:42:28 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D64B3F67D;
        Tue, 10 Mar 2020 05:42:27 -0700 (PDT)
Date:   Tue, 10 Mar 2020 12:42:26 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
Message-ID: <20200310124226.GC4106@sirena.org.uk>
References: <20200227174417.23722-1-broonie@kernel.org>
 <20200306102729.GC2503422@arrakis.emea.arm.com>
 <20200309210505.GM4101@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XMCwj5IQnwKtuyBG"
Content-Disposition: inline
In-Reply-To: <20200309210505.GM4101@sirena.org.uk>
X-Cookie: In space, no one can hear you fart.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--XMCwj5IQnwKtuyBG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2020 at 09:05:05PM +0000, Mark Brown wrote:
> On Fri, Mar 06, 2020 at 10:27:29AM +0000, Catalin Marinas wrote:

> > Does this series affect uprobes in any way? I.e. can you probe a landing
> > pad?

> You can't probe a landing pad, uprobes on landing pads will be silently
> ignored so the program isn't disrupted, you just don't get the expected
> trace from those uprobes.  This isn't new with the BTI support since
> the landing pads are generally pointer auth instructions, these already
> can't be probed regardless of what's going on with this series.  It's
> already on the list to get sorted.

Sorry, I realized thanks to Amit's off-list prompting that I was testing
that I was verifying with the wrong kernel binary here (user error since
it took me a while to sort out uprobes) so this isn't quite right - you
can probe the landing pads with or without this series.

--XMCwj5IQnwKtuyBG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5nizEACgkQJNaLcl1U
h9CwvAf/ZRKRyzQ70X79x8NhEkUSVp2jprVe6r4y/8/g449xGTTicMDIWQKGeikg
Z2v/GrsJ7+EAW4fiTl3dz+srzmuQCLS+67Dk/PwL4G4l8eJKQlBVj8BpiAASUml6
mx3mbdZSIfcRKgz3BbzAsmW6p186TYm1Eh0MAQJhN11goYRuZjs0MNTDwZ0RuvSZ
76rUJVdjbiFhjam1Et05p4G8HDQFKU0QArmyibQtCz1kU9+7affCfVyXFj3bnXx4
qepGxIs1ld2UGb4lZ1BdlDxDpQoaQ+nVPxPRic0loZbovKlASlaSyKuRFl49jYg1
8wHzzFxXeERLY2RJGZxzvae6Fq1zzA==
=fbe8
-----END PGP SIGNATURE-----

--XMCwj5IQnwKtuyBG--
