Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83C37AE2E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Sep 2023 02:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjIZAUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 20:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZAUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:20:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC09710A;
        Mon, 25 Sep 2023 17:20:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D62AC433C7;
        Tue, 26 Sep 2023 00:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695687635;
        bh=e3Yoq9pOLHOvljpOv+ix7wrGoqb64GYOUno0SrLgHPA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hIGlYoo/q44hoAwjR1Aux0HDlWYTPdNwBSFKBGCPSIoX9kEVVU2hmyChA7N9dYcDz
         ODnctHmhKndFZcpKA+0zX5k2sBv5aGMhnoXkqQA9wy9IbIpvtJcG5qnu2Fl1QwjFIg
         InpcRinxeduXnYkLMwE2GvadD7r5pUtGcxJ33ugDqljrHdEMFrsP7ucvnVktNX+aIR
         rfuU9EUA6x2fFwblj5aygUw3IdCjaLwpd+ONI3IgZcOQ0iPj5c+82JYRsw48Nzu5XI
         8xM5hlwYm/MHRQ24vTUMXxEqmf3DzkzQqXmva2YYp8pcBwjAeYAFi9hh2h77mMoiH0
         UaFHCoIwluBbA==
Date:   Tue, 26 Sep 2023 02:20:30 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        hughd@google.com, p.raghav@samsung.com, da.gomez@samsung.com,
        rohan.puri@samsung.com, rpuri.linux@gmail.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tmpfs.5: extend with new noswap documentation
Message-ID: <klaavttirlzwac4ztov777srbgmxngi7uc6jngoctvceatmjxh@tt4cgqnwnu5f>
References: <20230920235022.1070752-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ezffmyq2fe7k4oep"
Content-Disposition: inline
In-Reply-To: <20230920235022.1070752-1-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--ezffmyq2fe7k4oep
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] tmpfs.5: extend with new noswap documentation
MIME-Version: 1.0

Hi Luis,

On Wed, Sep 20, 2023 at 04:50:22PM -0700, Luis Chamberlain wrote:
> Linux commit 2c6efe9cf2d7 ("shmem: add support to ignore swap")
> merged as of v6.4 added support to disable swap for tmpfs mounts.
>=20
> This extends the man page to document that.
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Patch applied.

Thanks,
Alex

> ---
>=20
> changes on v2:
>=20
>  - Use semantic newlines
>=20
>  man5/tmpfs.5 | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/man5/tmpfs.5 b/man5/tmpfs.5
> index 5274e632d6fd..047a17a78ee0 100644
> --- a/man5/tmpfs.5
> +++ b/man5/tmpfs.5
> @@ -103,6 +103,12 @@ suffixes like
>  .BR size ,
>  but not a % suffix.
>  .TP
> +.BR noswap "(since Linux 6.4)"
> +.\" commit 2c6efe9cf2d7841b75fe38ed1adbd41a90f51ba0
> +Disables swap.
> +Remounts must respect the original settings.
> +By default swap is enabled.
> +.TP
>  .BR mode "=3D\fImode\fP"
>  Set initial permissions of the root directory.
>  .TP
> --=20
> 2.39.2
>=20

--ezffmyq2fe7k4oep
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUSI84ACgkQnowa+77/
2zJtahAAqgPqzQ/Py592AplsMuBWu30BMai3jki60tNkEL0DjUP0aVYdRag0H8ja
q7nKAC/Biqw+poS4EGFeZoaa0WqKfi6kVJhDKhlFXVa0l37l78CfJ38ldJDuENA2
+hkW531e1HBtz4xKPAJ56zRsbecmbIcc70FOHcE6k6rHTI3oy/WZ8MFVHKy1lALb
KwkTM9v/DmM2MdgWX5TFugZRP2X+gWG+AZYsO6nF7NgOI2/BSAw8FhrKeE9d/IG8
cO1iKXo3mecz86WRlbc72Flo4PnKezGVNJCddcV6gu6yD/Oy2nvFtV6Ni+WbVTU1
qMmfR5sLyKMUcY1kMMTdRhjHwu1B0wk9i/0bK2bGbrAmjo/pvsHlPBssRqXjWAib
Gdj+eCMqo81kV6bZwOHqYdVKZYrTy83Ou6Gn7x3KhMhubayrvkaHKOBgT4q15V97
B7dk7Zqh/zdPHyXap0CjYfIH20B1xMr7bblI1dIJsHbLAx0RtPue67/sK0F6ZiWn
tjdjcQ+EgvpQJVQqUpKGMQeR4450Dfd2thcWtFfRAzmoP+dCnmyxBAb2IEDj8WiZ
Q2kWzVG2++EWGCDKSltiAylNGKqZSzyWYgCr5K5CYDX1X2GOmo12MoFdi1mAovEt
ByI4/w92XL0glZCrsQQGRtE4bVeD/qMKVe/HPKVIUMm0yGiMkwQ=
=6UrE
-----END PGP SIGNATURE-----

--ezffmyq2fe7k4oep--
