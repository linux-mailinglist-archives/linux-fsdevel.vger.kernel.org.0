Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B371B4907
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Apr 2020 17:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDVPok (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Apr 2020 11:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgDVPoj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:44:39 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE9092076E;
        Wed, 22 Apr 2020 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587570279;
        bh=j6NY4BFiEsKARRJ64QkWadZPG9mu5NACrc/yxCpqHFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fZz9j/PMKPB+EDM7VJ1dl6F54xCJj27F8j+vV30/KLVPdzLEl4TljSqnjzfPVJYgg
         xBKTUGK/X0OJ6DaWuvmD3NQF0FrzJLO8CebiN0XcA7Z7OR6MA17nTV3JlWSceLSLQ8
         nfnUFNMpzKnf7pAw6/PIX6sx2ipj8OzUmZtOEM+w=
Date:   Wed, 22 Apr 2020 16:44:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH v10 00/13] arm64: Branch Target Identification support
Message-ID: <20200422154436.GJ4898@sirena.org.uk>
References: <20200316165055.31179-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Content-Disposition: inline
In-Reply-To: <20200316165055.31179-1-broonie@kernel.org>
X-Cookie: A stitch in time saves nine.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 16, 2020 at 04:50:42PM +0000, Mark Brown wrote:
> This patch series implements support for ARMv8.5-A Branch Target
> Identification (BTI), which is a control flow integrity protection
> feature introduced as part of the ARMv8.5-A extensions.

I've not resent this since the branch is still sitting in the arm64 tree
but it's also not in -next at the minute - is there anything you're
waiting for from my end here?

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl6gZmMACgkQJNaLcl1U
h9AYVQf/ajN/x5F2wiYIKFjzo2+jXBlUnF9FczZVVrXFDW2YeidwJw/eKCefOPQY
5HHDihIrHZBRdOrdnQ7UE8UIfQZMI8oOguL84O4O6IwCnwTZpEOuNhYHjCS1qMUI
nAHZjSGlSnKBp4MwttY/LRRomyGW74ukfnOU91v91LR6Aakw31PUIQZ8EDOT84jC
0hMnIjzmaA9LzLQRrMMQqSLi5FdLg4ps9NEb4zVklz94U/mzf4l+GzZczg6eJI1S
JUz9EwBdrJIwPCRdBoHCQbrVCuiCbvDjhobVK0tKRycjOFvWXh0nDWRWFwfZiD68
dpJmkHE2POaVhBEWnwhUJ57489SMCA==
=z9OW
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
