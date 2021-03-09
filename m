Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFEE331F04
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Mar 2021 07:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhCIGMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Mar 2021 01:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhCIGL4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Mar 2021 01:11:56 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0033C06174A;
        Mon,  8 Mar 2021 22:11:55 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4DvlGZ29Fqz9sW5;
        Tue,  9 Mar 2021 17:11:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1615270311;
        bh=yLJJE5xxeeaZ/0EtxYZhcbzn8VJqWRF42XlqZ1TBzpc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cVsM1vdAyP10esMijFiQ3sbTwoyHJXfYRxDuLalpWLARR+9KrOxUi+J/A6+YszFnv
         8t431YoqqFNS2QK/v0oj8utxDb4ua+SUn2VUs6RKGfQzUWRPUqh3Otl9YFtpZm/faX
         zLGyUArJSW/+l+23LCzy3pzj7nS/qDJTr0p2Nhx+MO6agIoBOpMNVnLiZfEg7Vkm0M
         pok0YryqA5zwcCvAQdtbZ4D3Fc/vIVtMiApKbqLn6apmKMyVPbf/DaJ1VDmsQIUVT8
         YoUWJ4I0vp6f3xYbZXda4ppuOgpFB4w8i8Wh1hlZ9K5c1tvDrCchpIEyvKrGTsfQog
         scfTp3jCgmM7g==
Date:   Tue, 9 Mar 2021 17:11:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     akpm@linux-foundation.org
Cc:     broonie@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org
Subject: Re: mmotm 2021-03-08-21-52 uploaded
Message-ID: <20210309171149.0039e74d@canb.auug.org.au>
In-Reply-To: <20210309055255.QSi-xADe2%akpm@linux-foundation.org>
References: <20210309055255.QSi-xADe2%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ITWOSbH7WFIqE1bGc_i+rPH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/ITWOSbH7WFIqE1bGc_i+rPH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, 08 Mar 2021 21:52:55 -0800 akpm@linux-foundation.org wrote:
>
> * mm-mempool-minor-coding-style-tweaks.patch
	.
	.
> * mm-mempool-minor-coding-style-tweaks.patch

This patch appears twice (I just dropped the second one).

--=20
Cheers,
Stephen Rothwell

--Sig_/ITWOSbH7WFIqE1bGc_i+rPH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmBHEaUACgkQAVBC80lX
0GwewQf/YCCIFc/sK82ulf0nzcVKVA13VkyYW3HgqZX3/t7wCiwRmEVcEpz27EwW
dy48G68N83df+nSgy1dfHJrMtden0nZsp15cQ1S4YX3C6AkY3brRTKYd/bxYzIAi
fE8U1Q5Bb6m13ouBiqrrijvkZ6E7i+nPOK9dlNHiVrqV3AAO16sP7+6r1Xol7Jfb
OxgBsnl2z9mNItbkalYSaJEYZg/TlwsloZnh5PB4wHd7Mrhtl0TbNW9qOJCCTVdw
yM/n6/z15TaxQR0RmTZwKVdw2mc3SnmkAnoU8/Uy4qidPfv/YBNlQebLsaNlWCgo
bSaRJD8QZNNqgu07tOxajEBrVP2CxQ==
=1Gcw
-----END PGP SIGNATURE-----

--Sig_/ITWOSbH7WFIqE1bGc_i+rPH--
