Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB581821E3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Mar 2020 20:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbgCKTPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Mar 2020 15:15:23 -0400
Received: from foss.arm.com ([217.140.110.172]:53884 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731297AbgCKTPW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:15:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E81C21FB;
        Wed, 11 Mar 2020 12:15:21 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 02A0A3F534;
        Wed, 11 Mar 2020 12:15:21 -0700 (PDT)
Date:   Wed, 11 Mar 2020 19:15:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Richard Henderson <richard.henderson@linaro.org>
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
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
Message-ID: <20200311191519.GK5411@sirena.org.uk>
References: <20200227174417.23722-1-broonie@kernel.org>
 <562edd23-9d86-800e-aae3-e54c92601929@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mGCtrYeZ202LI9ZG"
Content-Disposition: inline
In-Reply-To: <562edd23-9d86-800e-aae3-e54c92601929@linaro.org>
X-Cookie: I'm a Lisp variable -- bind me!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--mGCtrYeZ202LI9ZG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 05:35:39PM -0800, Richard Henderson wrote:
> On 2/27/20 9:44 AM, Mark Brown wrote:
> >  * Binutils trunk supports the new ELF note, but this wasn't in a release
> >    the last time I posted this series.  (The situation _might_ have changed
> >    in the meantime...)

> I believe this support is in binutils 2.32.

It looks like it's actually 2.33 but either way it's in a release,
thanks for prompting me to check.  I've updated this for v9.

--mGCtrYeZ202LI9ZG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5pOMYACgkQJNaLcl1U
h9AOkgf/SY/gSI7QW/Lbe29z6/u9w1lrepP1itRV8ICgiWASwxjzBxEUDfHMgTsV
Ng7Lx+w79lkeoWKj1id3jmu9SXG8pAmKiBpnc/iGNpkUs1evKFp2XyaqMLl5w1mO
DaNzX4HwWOKK6mjLXS1ferTsYgP0h0SnrJpODS/3HbvD6Txoi8b/m+XvAqiKrJi9
UiPK06ESXjNibgAx2JUDWtuKumjSFWEEGXDx2q6lCI06ZEvBIdkSK5aB0yJwYJqc
k60lhGcyCoMK6T9zNOCutbhZbQpGMlr+GInkEjkuuf/xo6SLfmuZx5hiFJHAumim
NrgBSedG1UXpaC5rINKAgEc2IacPkQ==
=4P3c
-----END PGP SIGNATURE-----

--mGCtrYeZ202LI9ZG--
