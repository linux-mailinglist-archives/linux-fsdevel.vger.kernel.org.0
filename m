Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D03D918464D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 12:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgCML4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 07:56:01 -0400
Received: from foss.arm.com ([217.140.110.172]:53580 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgCML4B (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 07:56:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D30EFEC;
        Fri, 13 Mar 2020 04:56:01 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 607D83F534;
        Fri, 13 Mar 2020 04:56:00 -0700 (PDT)
Date:   Fri, 13 Mar 2020 11:55:58 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v9 02/13] ELF: Add ELF program property parsing support
Message-ID: <20200313115558.GC5528@sirena.org.uk>
References: <20200311192608.40095-1-broonie@kernel.org>
 <20200311192608.40095-3-broonie@kernel.org>
 <202003121658.39A47CE098@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <202003121658.39A47CE098@keescook>
X-Cookie: This page intentionally left blank.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2020 at 04:59:21PM -0700, Kees Cook wrote:

> I think my review got lost along the way. Please consider this:

> Reviewed-by: Kees Cook <keescook@chromium.org>

Yes, sorry - I've added it locally (and the other two you sent just now).

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5rdM0ACgkQJNaLcl1U
h9Ct3wf+MPz1HrOXhlGATJUUi/83pv08oTCCzRaHqlsusA4dPg41W77Sgpj37/Yr
9LGONneWZqrufnFxx7ZEMJpqwJU1ROce8kl59OqNPAvVm25jQSBFMoboDrWHPCXB
GbTThVC6FmnF/QboOwdYKGH5/PVXLyxlH5widr4tjataNyWfaxVfk9RUmm8zCZHI
EqNJbvFejd2e6+g32ZxnnqAl8/nWswnuorlm884nKrqdAN69dyJIcDb19NaP9ZDc
8WJd4HoiMr+vT1a/JnkZCB/LwJU3nBlbOFWm7CNuHntRErsTZ5vZJ9m6ORz9v0oY
wU2OLaDYGXBG21NDPFxxWbEEBW2zFg==
=f6yG
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
