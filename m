Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F14A1B6BC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Apr 2020 05:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDXDQG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 23:16:06 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34645 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgDXDQF (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:16:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 497fSt1nGTz9sRN;
        Fri, 24 Apr 2020 13:15:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1587698163;
        bh=l8jJbVX0ogMNCiGXGwJKESvbAjTkBn+jWc97nMxrjrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=W9z2Qa4Ggw7Wr8uUkKn+6qlA5BfYbK/ojrveIBZCuWDC/Q2B0FxyGfSwh6flBVAeH
         lq5OV9gHxogB8aXtkY96B92nsfVE0Lg+JC3Jj8/2uQnCRPq/cXPo4KpnjsauM9z++W
         HVOnXWApYoraJWlZw6lzvGc04B3XaBKqdkoIzRVTW37lJk7Ppr6804hiP0rrbh9d3G
         Tj33JjLKeaXfavWqsNgX9yQYpcTm+hlVJTQ3f5wDcs2W5PkXJMZUpjM2GP0Uj8/Bgj
         fNezxPI75uhsTAgP+An1YPLfbLQF4CfRzyQB2X/WYnHkcr20YVOls/Q2b0ECj+jOzF
         d/QeO4VVlnEsw==
Date:   Fri, 24 Apr 2020 13:15:56 +1000
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
Message-ID: <20200424131556.1dbe18aa@canb.auug.org.au>
In-Reply-To: <20200424021420.GZ11244@42.do-not-panic.com>
References: <20200423203140.19510-1-mcgrof@kernel.org>
        <20200423180544.60d12af0@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200424021420.GZ11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/k5o_t+4houFn2a94ediPwL=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--Sig_/k5o_t+4houFn2a94ediPwL=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On Fri, 24 Apr 2020 02:14:20 +0000 Luis Chamberlain <mcgrof@kernel.org> wro=
te:
>
> > > Fixes: "firmware_loader: remove unused exports" =20
> >=20
> > Can't help but notice this strange form of the Fixes tag, is it
> > intentional? =20
>=20
> Yeah, no there is no commit for the patch as the commit is ephemeral in
> a development tree not yet upstream, ie, not on Linus' tree yet. Using a
> commit here then makes no sense unless one wants to use a reference
> development tree in this case, as development trees are expected to
> rebase to move closer towards Linus' tree. When a tree rebases, the
> commit IDs change, and this is why the commit is ephemeral unless
> one uses a base tree / branch / tag.

That commit is in Greg's driver-core tree which never rebases, so the
SHA1 can be considered immutable.  This is (should be) true for most
trees that are published in linux-next (I know it is not true for some).

--=20
Cheers,
Stephen Rothwell

--Sig_/k5o_t+4houFn2a94ediPwL=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6iWewACgkQAVBC80lX
0Gz5yggAiQwZi36rixL+wyBhd8ImqULtzKOOA9E8/NK3nuABYuCGY0rE6usORQae
6Q19X5RSYb0Olj/4oXIzGCUdZoXEqbUuMK52Dq34t+zP1n6dMxxEFoT7LXP0YqAI
LgpgH4uMxVZ7lgGhgymhCFnJsYe1xAH1lCGPL0q8g2gR/au3PDuGXnO1HuHbtHa9
jFO3sgMsIZYyN0Td32ipF6dX2JaMluyqodWMSGKMvYTpCcSUz4Zk19K/VgsqR8Pm
a0sjCbifVV3uF1L/KtuZqLlM8WpJcV9yp0S6prTYpS6czrFt7oSsB3cVmghKfa4q
IhcAB69WaEpVg0lzQ8Juw9VgLghBMA==
=1nCt
-----END PGP SIGNATURE-----

--Sig_/k5o_t+4houFn2a94ediPwL=--
