Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA65609BF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 09:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJXH7W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiJXH7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:59:21 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE455D112;
        Mon, 24 Oct 2022 00:59:19 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w189so6897250pfw.4;
        Mon, 24 Oct 2022 00:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6I0ey3aih9a3XrOVjFr6gc3tcZK3pmbJvqWHXM6itXk=;
        b=DDuR2rX5h3II7ekkrl2J2jjsbdDarya0EPkMn1eRH80Kccou2S7TdBPdRqOJrua9bv
         REs+XORASZWp0tGQBwGGwRcT08y5v9TaiTfGd8Yvql3PuP/M+5K3ONY64QbryI0ReQ/y
         nc6is5iyRutUdzOH13RAdUXB3J12pyqpxMghQc0rk3ICksj1TTaWHHmhq7QrK3W8Iare
         V3iOmsMkcSI/OgTfyFEXlfspPXfmdVc3MjJbrAwbXRGZBI3/7Jiy9EHc35oj56ElbR8m
         mxc1BIHf8zbuwmL/xM7UdaANODsVVDqmg6yqazWfbyBNNq9d3WwmRkQxEnLfxrc3La1M
         Z1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6I0ey3aih9a3XrOVjFr6gc3tcZK3pmbJvqWHXM6itXk=;
        b=693dFanOYavV6QXx1OmooARTEceAidVgsCa8io+ZQTZrzdvO7LvysMEC9dhM8ycryI
         GO/Th4lvKh24we+pucQx3L9EkMaPuslx5zN3pvAivhak1mTJF0iC3Y93eOCeQ9frWkOG
         wGEUL/u9NJ4NjeTuivOZc1jA+XmtrXSkdKFXAE8aXnkMcI3rOwAnqC9CSpuydC56Gy8l
         hOvvuwPrvBdIby9D4KApuBV/p6HOTDPyvOO9Gsh/H6VJ64qIUK9IekquWqbkaJb53Pxc
         x4PT4x6RutNjx7QrggL2f3T3ADVFbh+KtWgj7Vbtq6MjZpLjvoH8vPKLw07Xw/oN/E+x
         w0tw==
X-Gm-Message-State: ACrzQf0BtfLIcvwyH37PHpOwSqF+BiGr9q+o2lvQrp2hTfUBaIz/00iR
        bL6OsYMa0CcyEphGY20QRu0=
X-Google-Smtp-Source: AMsMyM7GQS1hhTQO3pZz7d3WKzmaWR5rDRIosN/6DopAu7IxNxUt4kkGxNlPzXhH3PhFD7exsX4jvw==
X-Received: by 2002:a63:90c1:0:b0:45f:c9a7:15c3 with SMTP id a184-20020a6390c1000000b0045fc9a715c3mr27211904pge.304.1666598359162;
        Mon, 24 Oct 2022 00:59:19 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-77.three.co.id. [180.214.233.77])
        by smtp.gmail.com with ESMTPSA id b5-20020a62a105000000b0056299fd2ba2sm19409255pff.162.2022.10.24.00.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 00:59:18 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id DEDD9103F1E; Mon, 24 Oct 2022 14:59:15 +0700 (WIB)
Date:   Mon, 24 Oct 2022 14:59:15 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     krisman@collabora.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] unicode: mkutf8data: Add malloc allocation check
Message-ID: <Y1ZF040OJaJ31doE@debian.me>
References: <20221024045150.177521-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8aHSJs7T8SNboEuL"
Content-Disposition: inline
In-Reply-To: <20221024045150.177521-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--8aHSJs7T8SNboEuL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2022 at 12:51:50PM +0800, Li kunyu wrote:
> Increase the judgment of malloc allocation, and return NULL if the
> condition is met.
>=20
> Signed-off-by: Li kunyu <kunyu@nfschina.com>
> ---
>  fs/unicode/mkutf8data.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/fs/unicode/mkutf8data.c b/fs/unicode/mkutf8data.c
> index e06404a6b106..a929ddf1438c 100644
> --- a/fs/unicode/mkutf8data.c
> +++ b/fs/unicode/mkutf8data.c
> @@ -495,6 +495,9 @@ static struct node *alloc_node(struct node *parent)
>  	int bitnum;
> =20
>  	node =3D malloc(sizeof(*node));
> +	if (!node)
> +		return NULL;
> +
>  	node->left =3D node->right =3D NULL;
>  	node->parent =3D parent;
>  	node->leftnode =3D NODE;

What?

This is not "malloc judgement", but rather return NULL if node fails to
allocate.

Please, please reword the patch description.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--8aHSJs7T8SNboEuL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1ZF0wAKCRD2uYlJVVFO
o+NuAP9Yd3rapanReflkP3Ipd3eMM7Fi+VtoWwz62FI2bQavdAEAsKLyMkVadxgJ
HX1uqDw05+4qYGzxB4VhFksevfugews=
=lKLi
-----END PGP SIGNATURE-----

--8aHSJs7T8SNboEuL--
