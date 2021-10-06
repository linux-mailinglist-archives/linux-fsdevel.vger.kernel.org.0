Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130814238BB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Oct 2021 09:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbhJFHWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Oct 2021 03:22:52 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:60069 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbhJFHWu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Oct 2021 03:22:50 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HPQpv135dz4xbC;
        Wed,  6 Oct 2021 18:20:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1633504857;
        bh=5xLfVkrTGqN/HJjioq+vxTiY7Z/CCJV7NwAHksIQlwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ap4KEyNJxlqFppjTdHI9ntGJz2X9R7/2EpBdM+G1YRpkBDnKCtDBEGtNsd4lPjlWP
         RKxIVvRy5d/ALyz3HNs6JE2rV7Df0O8QgoaTwxcnGBPSS64Ny+FVan8MN+P2tm6KLU
         kxhltuYM1WDq3qGNZvCrL/pKRXSg6kexsTcPBwkaBV9tFln+3ziK8wkzixRZ7ytCkR
         3n95lHlHyq/mVifnvxkMElaGLxzV8/fcIh/NNfMge6tO7YPbAd3L5r+t0/4CD8JaxP
         6Ty39mdTPD9zaOwc96hZJaQA6RRMy34hH9lmEYoLxRZqb2Qv90pXWM0n/8CW2aQk0g
         Qv7WL8Unf71lg==
Date:   Wed, 6 Oct 2021 18:20:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, Rob Clark <robdclark@gmail.com>,
        Sean Paul <sean@poorly.run>, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: Re: mmotm 2021-10-05-19-53 uploaded
 (drivers/gpu/drm/msm/hdmi/hdmi_phy.o)
Message-ID: <20211006182052.6ecc17cf@canb.auug.org.au>
In-Reply-To: <58fbf2ff-b367-2137-aa77-fcde6c46bbb7@infradead.org>
References: <20211006025350.a5PczFZP4%akpm@linux-foundation.org>
        <58fbf2ff-b367-2137-aa77-fcde6c46bbb7@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8lmLGN7R8.LIgbOOVm06hk1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/8lmLGN7R8.LIgbOOVm06hk1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Tue, 5 Oct 2021 22:48:03 -0700 Randy Dunlap <rdunlap@infradead.org> wrot=
e:
>
> on i386:
>=20
> ld: drivers/gpu/drm/msm/hdmi/hdmi_phy.o:(.rodata+0x3f0): undefined refere=
nce to `msm_hdmi_phy_8996_cfg'
>=20
>=20
> Full randconfig fle is attached.

This would be because CONFIG_DRM_MSM is set but CONFIG_COMMON_CLOCK is
not and has been exposed by commit

  b3ed524f84f5 ("drm/msm: allow compile_test on !ARM")

from the drm-misc tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/8lmLGN7R8.LIgbOOVm06hk1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmFdTlQACgkQAVBC80lX
0GxFqggAoHnUDKXJzMXUDWJ9VVsg/j6q0XdAv2bkB5kFOB2Ze0YDuQfPouTmgW2j
JXMPeBswphq91GNUCjHi9/rzSgugDJ3Z9RY5NJU090Ldx+8BJ2fasHwMqwDUIO/K
JRAeSffxlfunKiGfjVmtkTtTYV/ejVP6DXJLw3aeToop3xJSaDwBDp/tZxZFFfnl
77hBxteurp1EDJKsyTWUbjXL2swhd0ekMh8ZK2xlL7wzb6IBGSSNyQdluOaBQxJg
uH97ebQ7gbSXYIGrKrOAKtttwNKSqvDl2BB4M9gwi6uoiGixf0NmBEls+iZoW265
3nOiKtVNsnBGjQZ+d9fFM8CyFtBToQ==
=XhpG
-----END PGP SIGNATURE-----

--Sig_/8lmLGN7R8.LIgbOOVm06hk1--
