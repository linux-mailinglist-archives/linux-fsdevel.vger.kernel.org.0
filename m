Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91A958AE85
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Aug 2022 18:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240858AbiHEQz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Aug 2022 12:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiHEQz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:55:57 -0400
X-Greylist: delayed 437 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 05 Aug 2022 09:55:56 PDT
Received: from hop.stappers.nl (hop.stappers.nl [IPv6:2a02:2308:0:14e::686f:7030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60ACB2871A;
        Fri,  5 Aug 2022 09:55:56 -0700 (PDT)
Received: from gpm.stappers.nl (gpm.stappers.nl [82.168.249.201])
        by hop.stappers.nl (Postfix) with ESMTP id EFFC4200F4;
        Fri,  5 Aug 2022 16:48:35 +0000 (UTC)
Received: by gpm.stappers.nl (Postfix, from userid 1000)
        id 96E2F304049; Fri,  5 Aug 2022 18:48:35 +0200 (CEST)
Date:   Fri, 5 Aug 2022 18:48:35 +0200
From:   Geert Stappers <stappers@stappers.nl>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v9 01/27] kallsyms: use `sizeof` instead of hardcoded size
Message-ID: <20220805164834.4xq7hm6ee6ywjpjo@gpm.stappers.nl>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-2-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ojgl5e33l337cax4"
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-2-ojeda@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ojgl5e33l337cax4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 05, 2022 at 05:41:46PM +0200, Miguel Ojeda wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
>=20
> This removes one place where the `500` constant is hardcoded.
>=20
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  scripts/kallsyms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index f18e6dfc68c5..52f5488c61bc 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -206,7 +206,7 @@ static struct sym_entry *read_symbol(FILE *in)
> =20
>  	rc =3D fscanf(in, "%llx %c %499s\n", &addr, &type, name);
>  	if (rc !=3D 3) {
> -		if (rc !=3D EOF && fgets(name, 500, in) =3D=3D NULL)
> +		if (rc !=3D EOF && fgets(name, sizeof(name), in) =3D=3D NULL)
>  			fprintf(stderr, "Read error or end of file.\n");
>  		return NULL;
>  	}
> --=20
> 2.37.1
>=20


Signed-off-by: Geert Stappers <stappers@stappers.nl>


And I think that this patch and all other "rust" kallsyms patches
allready should have been accepted in the v3 or v5 series.





Regards
Geert Stappers
--=20
Silence is hard to parse

--ojgl5e33l337cax4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEin8gjG2ecykWV0FNITXRI9jBm+wFAmLtSdsACgkQITXRI9jB
m+yFvRAAqobvCSSsxB7Z87XEpwzMkNsdtwn04eRPEsQctCU3u1bfvVVHqq9G8rvH
RwUeyPpAOxbmEs+B5UCE3CbU5p/tSuw4au2+Gn3S23aAJLSNQd/ddtai3ca02y5a
Sw6ype8LlZsFnhmocfB+RsHsch7PQyS0CMkcfsFaYx7Lj44YsaHMLtuHOYt2jmCI
/B2kKn7dze85uCPF/tronsLR9aD1kpSEQ4x/ZUyZ88OtE3pQKQvPu1IWHLsGPBNC
bjg6NzkgyO4qFb3bgmv21q+VOSK3jMwr3kY1t9FoxMsHtoPi4c5+87aj4iLze0zK
enrSYseH670xScX19DqZvrY+C9uh5iVBsv2+Pz/0WaR3HT4sUxg3xkl1wdMlA1Ui
xLoBK3ayljhdaxhkLx6Eif5YxyB4BBCXq3cjugkMECT0L86DSj91dPB9mWGAItFN
dydrsOmAnh4Jl/LahJYoSmnkmCBtxAL4p2WkLmpEvHHcAfw/Hx8Bwu0LKXigMdDh
I4/BtNKknlceQ9hzY0VkeVbj3WUnZ2bkMPd1Q87YpQPVZlj6ArS+QXEB1Uq1GeHE
29gmr3CZOlOMiXEXnLM17uS8w9smjIkx4WpuE5CK3F4aVjYBdRWZF8NDsmYWglMT
K3RJ/FYKfaXfeXBwLLcN/vkgqOulY1Dg3buhg6mX5kYcjNCHlt4=
=6Oog
-----END PGP SIGNATURE-----

--ojgl5e33l337cax4--
