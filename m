Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F31B6C6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 06:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDXEJG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Apr 2020 00:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725823AbgDXEJG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:09:06 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BB0C09B045;
        Thu, 23 Apr 2020 21:09:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 497gf41Q18z9sSh;
        Fri, 24 Apr 2020 14:09:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587701344;
        bh=3BTSk4sjDI4VDtA4QcqlpHfqwVft8oWPVuJUoLtTKek=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=peEcD9/Bx/jrDaJvgqEdcVpav38EIqqVX+s+YKbAT5kkoGuW/xPq4+kSCXgnISeFn
         CI5Hidn4Pk65DerlY4HtBpI6ABpyKcXTrw37MuXZsJIGLHHYNMrZLTM3zB0NcYjmf6
         WjhVpUqliNJoS2wdN6F5DRzNUE4eTN1ebklgBm0lDy9RHLeIHv/p2vsNcqRKmz+v8T
         +Ql1Z+r53Pc7lcEqAI0NCFfCmarjNZnxdiKPQJjoBTjL8ZHbFtR2ofyYR5+s73QXNf
         QeZUKsSRh6gIloNbM2yHq2qYoFfrwfvCNNekPdHP/PbCUdLkkYncOkwzw9E8HzMt96
         l1DwO4qXJTeeQ==
Date:   Fri, 24 Apr 2020 14:08:53 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Jakub Kicinski <kubakici@wp.pl>, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, josh@joshtriplett.org,
        rishabhb@codeaurora.org, maco@android.com, andy.gross@linaro.org,
        david.brown@linaro.org, bjorn.andersson@linaro.org,
        linux-wireless@vger.kernel.org, keescook@chromium.org,
        shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
        dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
        arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
        markivx@codeaurora.org, broonie@kernel.org,
        dmitry.torokhov@gmail.com, dwmw2@infradead.org,
        torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
        jewalt@lgsinnovations.com, cantabile.desu@gmail.com, ast@fb.com,
        andresx7@gmail.com, dan.rue@linaro.org, brendanhiggins@google.com,
        yzaikin@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] firmware_loader: re-export fw_fallback_config into
 firmware_loader's own namespace
Message-ID: <20200424140853.5d001d8d@canb.auug.org.au>
In-Reply-To: <20200424031959.GB11244@42.do-not-panic.com>
References: <20200423203140.19510-1-mcgrof@kernel.org>
        <20200423180544.60d12af0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200424021420.GZ11244@42.do-not-panic.com>
        <20200424131556.1dbe18aa@canb.auug.org.au>
        <20200424031959.GB11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wE.85jsJZ4nTyPbO82kgXnL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/wE.85jsJZ4nTyPbO82kgXnL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Fri, 24 Apr 2020 03:19:59 +0000 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>
> Cool, but once merged on Linus' tree, I think it gets yet-another-commit
> ID right? So someone looking for:

No, Linus merges Greg's tree directly, so all the commits remain the same.

--=20
Cheers,
Stephen Rothwell

--Sig_/wE.85jsJZ4nTyPbO82kgXnL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6iZlUACgkQAVBC80lX
0GzmMwf/aZZRSQ8nx5S414xzj4iE0Cc6Ymxcx9fxaz1fG+4PEnYinI1lSIZiqtHX
1vU1GzcYx+54L5lIfeUpUfGpVekVfUzvjVK08N5JSFbs+MSfNm21l0h3F3DRC07N
pMzKd/YXwfil1rTlYWEDaGobkmKzVNM4XbbDT1mbNUa9zcD3QJLNy/gTiRpUKvI8
3bIFzCEuP7wbGcK7DLJ6KpdoBSPG/T6rR7e5/fwOXT/1FEC2b94oIOy2aeofbT9p
PiELaayXqS+8ysYVM5p9vB8hL5qskMhTFbR6G+77fc6VYqQl2yw6fjMNOi1lazdp
yuWoF6kN2yFBV3bmD0YlpsOlyvcoDg==
=zShb
-----END PGP SIGNATURE-----

--Sig_/wE.85jsJZ4nTyPbO82kgXnL--
