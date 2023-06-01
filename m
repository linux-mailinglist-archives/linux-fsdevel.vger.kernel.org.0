Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B353471F6DD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 01:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjFAXyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 19:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjFAXyc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:54:32 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D887618D;
        Thu,  1 Jun 2023 16:54:29 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so1946093e87.1;
        Thu, 01 Jun 2023 16:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685663668; x=1688255668;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybQ5L2WYRZQfSpMuiAlYLCMUlB1UvLkSX2ryNU/d/kY=;
        b=dFyHInLr3LItv/MzgJKceQw1GUbQCk79pkixpfVW1hDFwwSn5PLuav/2iuHoJ3uBnn
         +awDk09JA2RP/uHLCOKwxu84nKmrkku6jbcrFt0q33ywHzKEDdpKmzzz1WN8G9wC1sIL
         B0bR+lYLk9QeW2OcVMx9EPJ4g8pbOHhf3anzF3EXanaryFFah00B0jDU/CEeYd1PcPME
         8X2aCZ4usagdGbwfwUAHk5gpu7SoVCRrFm++DTgqpke8JCyi1xAZYJWUfooouV53okS+
         2ZjoGJO9yv1APS8ZjHvStkoVHMyDBUQkbucIYHV2YV07T+S6uFAu8A5Jd9EgIsAklKEd
         K6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685663668; x=1688255668;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ybQ5L2WYRZQfSpMuiAlYLCMUlB1UvLkSX2ryNU/d/kY=;
        b=TNXBCKDFMb0TyMckQOu3pFTg4nE3C1gSVqnJpvCBY20uMNseyrur5iZM+9iRLpCdIO
         skptwTC7/7LFZSU7CGPU1v1aWHr8wZX5zOBxY8QO3fO6w1WWnPOBU07if6cyGLn6WoMm
         JPhq5ImNjuri2xVZ0Ak+agXj4rYf0T0kvrGWnPkyEblAIvzmssLkrl8Xr4ufvYi513yn
         +GMM0AB7XhAF+5MUV31J9Ushbkz+o0rAmDyhpxdXpd6PtCH6dyqAvR7UtG4h64p5QFqI
         cobpljX/Qj9AqSfrQJMdMoIM6Zwo267ojfbgCSY2cccXrdxDY7JvJzJ9BjLF7XqsBA2X
         FphQ==
X-Gm-Message-State: AC+VfDwqL3akiPqpbMCDLAuexUI3OKM/iQ5dHDqmdfRI2jPbpXxCpk59
        UNTJOwflIL44s0JJlLx8ImQ=
X-Google-Smtp-Source: ACHHUZ75XZN1swP9jyK/M05bwnJ7gb6IJvY5Tex8+culbYuiZScBJeEJYlu3OQV5/tY96Uy0EvCtuA==
X-Received: by 2002:ac2:4192:0:b0:4ed:bfcf:3109 with SMTP id z18-20020ac24192000000b004edbfcf3109mr808493lfh.56.1685663667804;
        Thu, 01 Jun 2023 16:54:27 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c00c800b003f4ebeaa970sm144177wmm.25.2023.06.01.16.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 16:54:27 -0700 (PDT)
Message-ID: <0822f75a-267c-faa5-bdc5-55eca5dbbc62@gmail.com>
Date:   Fri, 2 Jun 2023 01:54:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tmpfs.5: extend with new noswap documentation
Content-Language: en-US
To:     Luis Chamberlain <mcgrof@kernel.org>, alx@kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hughd@google.com, p.raghav@samsung.com, da.gomez@samsung.com,
        rohan.puri@samsung.com, rpuri.linux@gmail.com,
        a.manzanares@samsung.com, dave@stgolabs.net, yosryahmed@google.com,
        keescook@chromium.org, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230526210703.934922-1-mcgrof@kernel.org>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <20230526210703.934922-1-mcgrof@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------fhGnL7Zf9xrdwVrHSelHTA4N"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------fhGnL7Zf9xrdwVrHSelHTA4N
Content-Type: multipart/mixed; boundary="------------3L7GuI8sJyU0F1PyzmHCFWDb";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>, alx@kernel.org,
 linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc: hughd@google.com, p.raghav@samsung.com, da.gomez@samsung.com,
 rohan.puri@samsung.com, rpuri.linux@gmail.com, a.manzanares@samsung.com,
 dave@stgolabs.net, yosryahmed@google.com, keescook@chromium.org,
 patches@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Message-ID: <0822f75a-267c-faa5-bdc5-55eca5dbbc62@gmail.com>
Subject: Re: [PATCH] tmpfs.5: extend with new noswap documentation
References: <20230526210703.934922-1-mcgrof@kernel.org>
In-Reply-To: <20230526210703.934922-1-mcgrof@kernel.org>

--------------3L7GuI8sJyU0F1PyzmHCFWDb
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Luis,

On 5/26/23 23:07, Luis Chamberlain wrote:
> Linux commit 2c6efe9cf2d7 ("shmem: add support to ignore swap")
> merged as of v6.4 added support to disable swap for tmpfs mounts.
>=20
> This extends the man page to document that.
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  man5/tmpfs.5 | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/man5/tmpfs.5 b/man5/tmpfs.5
> index 09d9558985e9..f7f90f112103 100644
> --- a/man5/tmpfs.5
> +++ b/man5/tmpfs.5
> @@ -99,6 +99,11 @@ suffixes like
>  .BR size ,
>  but not a % suffix.
>  .TP
> +.BR noswap "(since Linux 6.4)"
> +.\" commit 2c6efe9cf2d7841b75fe38ed1adbd41a90f51ba0
> +Disables swap. Remounts must respect the original settings.

Please use semantic newlines.  See man-pages(7):
   Use semantic newlines
       In the source of a manual page, new sentences should be started
       on  new  lines,  long  sentences  should be split into lines at
       clause breaks (commas, semicolons, colons, and so on), and long
       clauses should be split at phrase boundaries.  This convention,
       sometimes known as "semantic newlines", makes it easier to  see
       the  effect of patches, which often operate at the level of in=E2=80=
=90
       dividual sentences, clauses, or phrases.

Thanks,
Alex

> +By default swap is enabled.
> +.TP
>  .BR mode "=3D\fImode\fP"
>  Set initial permissions of the root directory.
>  .TP

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------3L7GuI8sJyU0F1PyzmHCFWDb--

--------------fhGnL7Zf9xrdwVrHSelHTA4N
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmR5L7EACgkQnowa+77/
2zKzPQ//eaMf/JhjExdKSJjWCIGk056qab5So1LYbuHQWrEJYFGnC1v9obCoGeoQ
lUj0/jsuKh0bNIZG7L01jDCLA+/lxrzq7UrqusAZpZu81DHKeh/ITysVkORfa5yZ
/Rl6RKe9eCo01jBPkhHF84bBJX6jQdD5jzo0ZkCci5PMx5GMna01daevr60Cd7Fg
1o+GYAJvZw/3aB98Pf40zT1DT3CsBKze284OAPwQqUFMO1gDKy9nJC6+j76Wgu5a
xnlxwxothoNslsS9oPZF/y9TCanxiGQTPXTkSd2oNgkn1pXN4al4AukoLyvh/B0G
GNvAnW57pAYr/2XCHXFU92yqrYaM1H9RF2dk6SbCjxjG6Uuz9G+icM6iRMLPscrI
CG9smE/ZKCXGE5sM0ddQ6JsIR+iT7y6wokeKapztN19jYCPlwr/SWT/EOElYlD8G
q683oVhzFcTSzCuIXBBBHm7lUOh3d0boOwHa7WZhVvcdPr4IV1BNWO7hb8hCg8uD
PyzC1lnWr2835RaaD9DNki9pj/9pSYwnUvANFPNyJCtAY4Hnh93UrPz82YHCIf/w
XJ7Snt+jzJApKGrdI0VvWwS9/8MTvj5bQczy5Z+KKocoV+W1yU2mnWkTiBvqItmU
ksvdZ0IsQjD5HLY3BkkgObykUwNyOI+4lhYkkXM0eg+gTcuvTjc=
=1akv
-----END PGP SIGNATURE-----

--------------fhGnL7Zf9xrdwVrHSelHTA4N--
