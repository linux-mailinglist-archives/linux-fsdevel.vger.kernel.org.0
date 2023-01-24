Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA749678F2E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 05:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjAXEJr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 23:09:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjAXEJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 23:09:46 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEAB4EF1;
        Mon, 23 Jan 2023 20:09:45 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id p24so13519390plw.11;
        Mon, 23 Jan 2023 20:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1CiC6L/MPz8ZmBhU93JAZAVZyRDaJoENCcWkRf+ufm4=;
        b=bdqWNXxaEAoHIX04bpEVSBIbEFxFmKE+NKUP+75biPBPRZHWfgH7gcbZuKt1OP9hOZ
         /vSdWxVYknC7sKp0ZSuaz1umVtqStNug+gJmIq5Q7Z54DDJ7YaG+qv728xcN+biUJ6cx
         /xndsgVYkazdnHPxfq0R2gEDJkxA4HBtk6f/RnpDhTdQRKKlUztkzRdhmQ/eaVmMkRcF
         i3XS5Lm6XwJQU68T64CCiS5tMPlSpREhvDTaDQ8kcqdGTPOBHwP6yt6udcIFeldEfw6U
         Exf37LEFu0wdqZ9LKjcCh43EaJZz8nPFptguv9BH8ETcoyeaTtt5jT5aa/lqBoDvURay
         sKJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1CiC6L/MPz8ZmBhU93JAZAVZyRDaJoENCcWkRf+ufm4=;
        b=WihfXxiUesJuFTm1Tr6YxOnzn3kAnSnZgjAh4W3ZHr88tOK4hE0bSlPzzy0PrXe6dO
         FKuAG+xd65pqFDzWyQCBadyPZ3k8XIx+BbuIUXQXFTdvPrAkdh2XTo0/+Vps0+xOlqj0
         sC6O/nX5J5u8macVRJbt6JIzFY61pa0Qse+jKiVVQN0LQhNuqWAdvU4af0muD9zNCkNi
         RdDKnd4VIwWOOcpgOu3uunTENOTvIl1SCz6a/gj83PnYiQJaghf/fED+gU/JKi1NdSR6
         nSj9NsrYv6hjiSseDSzYTqfNa4ixDFopgO0Ws3e9cdc431Ei/AAIVuGJKTljYxQLwRtP
         R0CQ==
X-Gm-Message-State: AFqh2kqe6mHAHF95JLE9b79/wKERRHx8dDaJF+pobb0EjtCfNU0BVR1F
        QHYawO5bsZ3LOjLuNAjFBQnJVHoLVacctA==
X-Google-Smtp-Source: AMrXdXvZt1un5aXiFJAX4vKuY9CQmfzHY67G3vdATIaA7xHuJXH9BYTDB/1ELClrg0gcDiebTJXDZA==
X-Received: by 2002:a05:6a20:6592:b0:a4:8725:fdcd with SMTP id p18-20020a056a20659200b000a48725fdcdmr27632969pzh.15.1674533384795;
        Mon, 23 Jan 2023 20:09:44 -0800 (PST)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id i127-20020a639d85000000b00478162d9923sm336384pgd.13.2023.01.23.20.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 20:09:44 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id D22F7105170; Tue, 24 Jan 2023 11:09:41 +0700 (WIB)
Date:   Tue, 24 Jan 2023 11:09:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v1 15/20] docs: document new procfs ksm knobs
Message-ID: <Y89aBXuPrbjrFAmC@debian.me>
References: <20230123173748.1734238-1-shr@devkernel.io>
 <20230123173748.1734238-16-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XX6agEIUzIpHNuNV"
Content-Disposition: inline
In-Reply-To: <20230123173748.1734238-16-shr@devkernel.io>
X-Spam-Status: No, score=1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--XX6agEIUzIpHNuNV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2023 at 09:37:43AM -0800, Stefan Roesch wrote:
> This documents the ksm_process_profit and ksm_merge_type settings in
> ksm_stat.

"Document both ksm_process_profit and ksm_merge_type proc settings."

>=20
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>  Documentation/admin-guide/mm/ksm.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
> index 72189bf1283e..70896f01d641 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -211,7 +211,8 @@ several times, which are unprofitable memory consumed.
>  			  ksm_rmap_items * sizeof(rmap_item).
> =20
>     where ksm_merging_pages is shown under the directory ``/proc/<pid>/``,
> -   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``.
> +   and ksm_rmap_items is shown in ``/proc/<pid>/ksm_stat``. The process =
profit
> +   is also shown in ``/proc/<pid>/ksm_stat`` as ksm_process_profit.
> =20
>  From the perspective of application, a high ratio of ``ksm_rmap_items`` =
to
>  ``ksm_merging_pages`` means a bad madvise-applied policy, so developers =
or
> @@ -222,6 +223,9 @@ so if the ``ksm_rmap_items/ksm_merging_pages`` ratio =
exceeds 64 on 64-bit CPU
>  or exceeds 128 on 32-bit CPU, then the app's madvise policy should be dr=
opped,
>  because the ksm profit is approximately zero or negative.
> =20
> +The ksm_merge_type in ``/proc/<pid>/ksm_stat`` shows the merge type of t=
he
> +process. Valid values are ``none``, ``madvise`` and ``process``.
> +
>  Monitoring KSM events
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20

The change LGTM.

--=20
An old man doll... just what I always wanted! - Clara

--XX6agEIUzIpHNuNV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY89aBQAKCRD2uYlJVVFO
o5VVAQDUTWIM8oin7v2bLz8Fg+xjQgz6v0OLJxT0G5Q0oiQeuAEAtVt3/yWMls24
CeYG0s/x1NbG/nXXj/D9+N7HeZvVSwY=
=O4Jm
-----END PGP SIGNATURE-----

--XX6agEIUzIpHNuNV--
