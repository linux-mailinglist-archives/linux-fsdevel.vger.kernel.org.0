Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5BC26B59A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 06:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfGQEie (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jul 2019 00:38:34 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:54889 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQEid (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jul 2019 00:38:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45pPfG6TYLz9s3l;
        Wed, 17 Jul 2019 14:38:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1563338311;
        bh=7o9BO0ADmmnMeCw0wqmCaRTFN+ZKwypcAxGKZdpgnH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X5ODQmuVyLfNoIKGCLu+tlRTXrGFI1NzAdzDXi+dNhzYhZ52JAHiH6ajzlN3GeRg+
         Oh3H2hbICg2tzXiMQQZdmIv42dQDjvuHTUyMtlqc69Vc8yesT0CUZ46RQyfzh4clUd
         XgeoS0OeA5BkcUogkbmMZGz57c/XmTDI/MBih8AHpPtK4DDNX4jvJqFtz/aZauPbs7
         VWfrGCAWtflRWAGnrNqLtRAEtDuahMn7MdXBWbus65jHa59P4brEIR5wKDgqSyX6NS
         Aw1LO7WJ7bWRN2F5kMB+cqyK0zmR6U+/ZTZGPOCdQGa0RZMH8XcEojfGZbuDf8rA3l
         Ac2SrTUUrLbYg==
Date:   Wed, 17 Jul 2019 14:38:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2019-07-16-17-14 uploaded
Message-ID: <20190717143830.7f7c3097@canb.auug.org.au>
In-Reply-To: <8165e113-6da1-c4c0-69eb-37b2d63ceed9@infradead.org>
References: <20190717001534.83sL1%akpm@linux-foundation.org>
        <8165e113-6da1-c4c0-69eb-37b2d63ceed9@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/dKk7_zXGQ.uoxSOd_E_Lg0m"; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/dKk7_zXGQ.uoxSOd_E_Lg0m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Tue, 16 Jul 2019 20:50:11 -0700 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> drivers/gpu/drm/amd/amdgpu/Kconfig contains this (from linux-next.patch):
>=20
> --- a/drivers/gpu/drm/amd/amdgpu/Kconfig~linux-next
> +++ a/drivers/gpu/drm/amd/amdgpu/Kconfig
> @@ -27,7 +27,12 @@ config DRM_AMDGPU_CIK
>  config DRM_AMDGPU_USERPTR
>  	bool "Always enable userptr write support"
>  	depends on DRM_AMDGPU
> +<<<<<<< HEAD
>  	depends on HMM_MIRROR
> +=3D=3D=3D=3D=3D=3D=3D
> +	depends on ARCH_HAS_HMM
> +	select HMM_MIRROR
> +>>>>>>> linux-next/akpm-base =20
>  	help
>  	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
>  	  isn't already selected to enabled full userptr support.
>=20
> which causes a lot of problems.

Luckily, I don't apply that patch (I instead merge the actual
linux-next tree at that point) so this does not affect the linux-next
included version of mmotm.

--=20
Cheers,
Stephen Rothwell

--Sig_/dKk7_zXGQ.uoxSOd_E_Lg0m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0upkYACgkQAVBC80lX
0GxY4Af+Oq4/F8H+zsaZlffvr9kWxLnnkP6seTpuCtjL3Lrao+6kmrHwvRxWXRmb
DqfVHihQ1LhaVW8VoP1GycoXaKBcQn0goSb15YVCUh/GPRhYnatbaUFZwk+ktGmq
k6ln30+yEY2kKT0FzWwX8dovVmwJ1UCQY1D0wCVMItQB58CerSX4mnmZWinA6lfO
NEX3APGd2tviTSbBhvy3O8GsCtLGmyX4WWT+TRWJqOZnHeuPLTsIDjDUCAhab/y6
SY6uOswYK1uKKBRJu7ATwmaJP2DMV2rm6Ueq+XH9Mx/sw19RG2Nji8/EoDhQ1WRh
Yc0S0HXamFnMIevXgk9IgqtFYoCrvA==
=eNFs
-----END PGP SIGNATURE-----

--Sig_/dKk7_zXGQ.uoxSOd_E_Lg0m--
