Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5EC666E4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 08:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbfGLGUc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 02:20:32 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:48829 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbfGLGUc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 02:20:32 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 45lN8F2HD4z9s4Y;
        Fri, 12 Jul 2019 16:20:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1562912429;
        bh=kOAbaMX8FlsTSm7oTq0mdhFEoLZ2DXr62rCz0QjP/SM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bEmpV3q8U9nxIYHUivDoFRMuLSZkz3J3dxpZxyqOKzxX5S/CuInMzSTlAng9Ewp5z
         vAJndwYRclJJUFDVrkWzd+kBGH1wY6LbQ6cmmcBinSWq6Cfv4mT/Rt+f5VvYSQHfJA
         JlHWYx8zZeeGXabBw6gZlG9ZJ87W0uBpiVBMhkS4MJ5Im/N4DUtyQcjO4ePHqPuVId
         NOKLGz2vukRZ4tfEJsTmStlsotXcXQqplazVuJyvfIAzfzdK/VZMqODLq+aFqnPSjt
         Fbd1zzZWXefXTSR2H0fM9EB5BL4dhezPVjYqg+zC4qi/0PEL2b8KZqJ5b1gaB7obdy
         xBteUwbEbXMLg==
Date:   Fri, 12 Jul 2019 16:20:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     akpm@linux-foundation.org
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2019-07-11-21-41 uploaded
Message-ID: <20190712162027.7ca31722@canb.auug.org.au>
In-Reply-To: <20190712044154.fiMaFQ0RD%akpm@linux-foundation.org>
References: <20190712044154.fiMaFQ0RD%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/P.802fFMgzhFjtLGcQJfXOl"; protocol="application/pgp-signature"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/P.802fFMgzhFjtLGcQJfXOl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, 11 Jul 2019 21:41:54 -0700 akpm@linux-foundation.org wrote:
>
> * mm-migrate-remove-unused-mode-argument.patch

I had to remove the hunk of this patch that updates fs/iomap.c which
should not exist in your tree by this point.

--=20
Cheers,
Stephen Rothwell

--Sig_/P.802fFMgzhFjtLGcQJfXOl
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl0oJqwACgkQAVBC80lX
0GwVTAf/UvvmoZmrwsW2LgtazMmufzEJPjW7/PDntLDpJeOsZWcsWol9S2I3nzHs
jNBwtvSQRhUoaZOLIiu4YxV9vTMlEfs8XtbRX3yzhTjg2B/Sb+c4xgfYTON0Ww7F
+McHuE/oiXLaOoiAFfsVVsyUSjlrf8Cs8Ko6gOOONLnvVyZzhiUmLVbCd0EmxwSQ
tB0GjW69nes1pMK356u8aApMhM9qIYJI88AZ6WcjN/AlZgAHdu1LGMTvd9LhdrFR
bpUUfIG1vbp0YvjSa5ztKTBHuB9ATQxULkk/1UyGyMbEmfM9TG1mbdn4K2eTQWWu
oMiSR91cGEtvuEC3/vmPaerfsFLY7A==
=77BJ
-----END PGP SIGNATURE-----

--Sig_/P.802fFMgzhFjtLGcQJfXOl--
