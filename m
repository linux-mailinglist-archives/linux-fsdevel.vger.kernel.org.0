Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB2E616FD59
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 12:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgBZLUd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 06:20:33 -0500
Received: from foss.arm.com ([217.140.110.172]:34128 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728073AbgBZLU3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:20:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D624C1FB;
        Wed, 26 Feb 2020 03:20:28 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7393FA00;
        Wed, 26 Feb 2020 03:20:28 -0800 (PST)
Date:   Wed, 26 Feb 2020 11:20:27 +0000
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
Subject: Re: [PATCH v6 01/11] ELF: UAPI and Kconfig additions for ELF program
 properties
Message-ID: <20200226112027.GA4136@sirena.org.uk>
References: <20200212192906.53366-1-broonie@kernel.org>
 <20200212192906.53366-2-broonie@kernel.org>
 <202002252147.7BFF9EE@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
In-Reply-To: <202002252147.7BFF9EE@keescook>
X-Cookie: May all your PUSHes be POPped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 25, 2020 at 09:49:35PM -0800, Kees Cook wrote:

> Both BTI and SHSTK depend on this. If BTI doesn't land soon, can this
> and patch 2 land separately? I don't like seeing the older version in
> the SHSTK series -- I worry there will be confusion and the BTI version
> (which is more up to date) will get missed.

Please.

> What's left to land BTI support?

As far as I'm aware it's basically good to go, there's been no really
substantial feedback in the months I've been pushing it, just fairly
trivial stuff and rebases - it's going to need another resend for your
comment just now about moving a hunk forward to a different patch for
example.

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5WVHcACgkQJNaLcl1U
h9AcDwf9GZxAN5rdZOpKz4dNmbfGRCoB9nc9O6lSiDkP2JOEtG8pbkeX6TMI39Hm
+x/8gudWU6oq2Yg4KpIdz4QyZ8guZTRdoEsg9e7NJJaYC/JppbOBEsk8tR8qGRDQ
2ryYp2atIxhfcBQ+KuDEPP9/qMOhCNrDZHwfNe1jI+LtTc3aZ94XgbloqFvno9+B
2fpH28bHWi8iL+Kk5K7wN78O1dyb+8EkWz/2WXjo2hz5mfEJsAnIR2QnaY2HoJSO
9t6fLU/TJ21XcOExtnjTB19nWEScEcIltEWCGjWlAGJRxSQyWnlXZaPc4cDjyN+x
iGx9ujR4FphdpqhQNmWrZOccbdTqwQ==
=QAgA
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
