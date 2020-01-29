Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E1414D31D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 23:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgA2WdE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 17:33:04 -0500
Received: from ozlabs.org ([203.11.71.1]:39457 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgA2WdD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 17:33:03 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 487JCb1szQz9s29;
        Thu, 30 Jan 2020 09:32:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1580337180;
        bh=kNacujBNtky+MXS90bf53so+l7F4oZQu+AtY0NhlJNQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ex3FCk1X/t/U9hHBF2sRLvLfDOEKSrMvujvDnzfhanC0NRvt3DsN24J6O2vyUAMCL
         zd5wiTlkznS2Qu75ufZ1OmIFrswaqkqp05j3+j6LMqUrpfGqmYe1e76wMt3YBrbgQf
         QtfvrLVl3YQiAo2dkQLIfIX6m+/43xgK9V5xcy1P7DxsGzUKB4FeH95m/Pdjy7zuB6
         rePlTin9IP1is3iKQ0qzdOBPp8shvDhtv4oQ90JEN/PgfX5rP/iu/WoApUjxCPBdUa
         QGVzYQ2EjMHc2l60+oIVwpfchVBbb8SI+M5J1/QfirVBRT1RLaORPWLLuL7cw36A0Z
         W0Ynqk7uxFNSA==
Date:   Thu, 30 Jan 2020 09:32:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: mmotm 2020-01-28-20-05 uploaded (security/security.c)
Message-ID: <20200130093251.16e35ed3@canb.auug.org.au>
In-Reply-To: <56177bc4-441d-36f4-fe73-4e86edf02899@infradead.org>
References: <20200129040640.6PNuz0vcp%akpm@linux-foundation.org>
        <56177bc4-441d-36f4-fe73-4e86edf02899@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hT0psqc8acn.2nhNMeCMlga";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/hT0psqc8acn.2nhNMeCMlga
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Randy,

On Tue, 28 Jan 2020 20:52:28 -0800 Randy Dunlap <rdunlap@infradead.org> wro=
te:
>
> security/security.c contains duplicate lines for <lockdown_reasons> array:
>=20
> Stephen, you might delete half of those for linux-next....

I did not get that in my import of mmotm today.  But I actually git
merge the appropriate part of linux-next rather than applying the
linux-next.patch from mmotm - so that may have taken care of it.

--=20
Cheers,
Stephen Rothwell

--Sig_/hT0psqc8acn.2nhNMeCMlga
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl4yCBMACgkQAVBC80lX
0GxZwAf/ax84ntnjUlSEUbrRhOtzhkbCC0qfQRNOTKs4fDx067hyyDhauWtomiRK
MZQYkycawPmOiDwBhuaDpt7sYfa0/SculyJff5znss4VzIFrGjiHKRRfvsczKsqK
9y7yDCbR4PI2iIfId4iRp5qtj1Sx8NhUclS41DfgKFSsLicXrjWEcEVCqfjzKTjX
t9sUKS02kqpqY9YFN1+H87rvw/MTqYl5vKc2lbWQzE9DXxUqSwW972sTt2p2PEqT
tGkBV0tpmYvzP6E8Fbn8yQY5i8xen44TpVoMFRRdbutat74drdvKDUpVHxWUZsu3
3otwkaIwi2M98a6uRHAgMyJ/h0pMuA==
=FooJ
-----END PGP SIGNATURE-----

--Sig_/hT0psqc8acn.2nhNMeCMlga--
