Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793EC678F29
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 05:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjAXEH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 23:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjAXEHw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 23:07:52 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E975B8A;
        Mon, 23 Jan 2023 20:07:50 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id jl3so13531309plb.8;
        Mon, 23 Jan 2023 20:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lL0bdFacrc9ge7DB6mAF/QSWkXTA0W04qNvYnU+lWBY=;
        b=moG9Wlq4TN8PHNFz8JfMC7FgmM7wTQNDOd3QgZM2BRs9J+8MLsF3QJwAo84z9hqdkh
         LrWZn+euoyotjBtGO08lzwtXf5Ke1HECk/yKKqAwABnMjDB/gn1WacMLE1wTdb0jJP0Z
         wlQZo/N6Y3RsfGqC9BgFNUycrbqaykAQDudv/+uooX0NV9TWPRHF10QXBcTL9vEVS6Yz
         Hp8ASlrkAAkmE8E3gJS/dtEox8kWYApn1RQqgA5qhJU0Yvr15gTKDC/aD34hD8EAv1vO
         saFWBvszkrCcwFpIeFhs3DxIeHKjVNughhBvo/ASfbIDKjscwSP5/XJE2bZ+d0y+cBue
         RaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lL0bdFacrc9ge7DB6mAF/QSWkXTA0W04qNvYnU+lWBY=;
        b=TEExSNYuwXqCBobc3LFcp//6c7YPO1oy5eVsMnO2Xcp4bXVw5R/KYK4OYbPgdhdVwK
         d3BQfUVp3SMIjR9NRTAiyAAA8ju7SxUZvCqsE8BvepSJ00UNNYhhTcuj77UhC+GPRKyZ
         yAdIHV81mgQcxSsLzY4hj64rwX8xK2MqVNwdDDXr895hN5rYaSx8pMnLDadD42ZVyV7J
         jZXvSJ8Y+UWEga+vr1kmkge+r2BpxHVazt0CZ3l7juf3ck30sAIPe03Ry6bFvDXwsgw+
         EwrpXJjMOpTkAEgEFDFu3nAjpqFIpPc4iAYkuMPVEmhO0N+YGRlKZXXJnpEo74/FR9cv
         oNeQ==
X-Gm-Message-State: AFqh2kqdhqCTjIlH9mrGpSGgtZqQs6HnSM3Qy3/4Qx3UoOpc8kPgIiqT
        AR5vzjo85DfE4aYsECmWoIA=
X-Google-Smtp-Source: AMrXdXsNSCItCGSM2pN8gxAWVEaT9DX+HZ0rV5I95pBYsZxcELompWI1vLKah4SbxiE2BShrK2qFNg==
X-Received: by 2002:a05:6a20:4407:b0:b8:66f6:6263 with SMTP id ce7-20020a056a20440700b000b866f66263mr38667881pzb.23.1674533270400;
        Mon, 23 Jan 2023 20:07:50 -0800 (PST)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id bt21-20020a632915000000b0045dc85c4a5fsm331533pgb.44.2023.01.23.20.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 20:07:49 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 9AD56105170; Tue, 24 Jan 2023 11:07:46 +0700 (WIB)
Date:   Tue, 24 Jan 2023 11:07:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v1 10/20] docs: document general_profit sysfs
 knob
Message-ID: <Y89Zko/TWYcphmJA@debian.me>
References: <20230123173748.1734238-1-shr@devkernel.io>
 <20230123173748.1734238-11-shr@devkernel.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ml68OXFDXr5GpjRs"
Content-Disposition: inline
In-Reply-To: <20230123173748.1734238-11-shr@devkernel.io>
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


--Ml68OXFDXr5GpjRs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 23, 2023 at 09:37:38AM -0800, Stefan Roesch wrote:
> This adds documentation for the new /sys/kernel/mm/ksm/general_profit
> knob.

"Document general_profit knob."

>=20
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>  Documentation/ABI/testing/sysfs-kernel-mm-ksm | 8 ++++++++
>  Documentation/admin-guide/mm/ksm.rst          | 2 ++
>  2 files changed, 10 insertions(+)
>=20
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentatio=
n/ABI/testing/sysfs-kernel-mm-ksm
> index d244674a9480..7768e90f7a8f 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
> @@ -51,3 +51,11 @@ Description:	Control merging pages across different NU=
MA nodes.
> =20
>  		When it is set to 0 only pages from the same node are merged,
>  		otherwise pages from all nodes can be merged together (default).
> +
> +What:		/sys/kernel/mm/ksm/general_profit
> +Date:		January 2023
> +KernelVersion:  6.1
> +Contact:	Linux memory management mailing list <linux-mm@kvack.org>
> +Description:	Measure how effective KSM is.
> +		general_profit: how effective is KSM. The formula for the
> +		calculation is in Documentation/admin-guide/mm/ksm.rst.
> diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-g=
uide/mm/ksm.rst
> index fb6ba2002a4b..72189bf1283e 100644
> --- a/Documentation/admin-guide/mm/ksm.rst
> +++ b/Documentation/admin-guide/mm/ksm.rst
> @@ -159,6 +159,8 @@ stable_node_chains_prune_millisecs
> =20
>  The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm=
/ksm/``:
> =20
> +general_profit
> +        how effective is KSM. The calculation is explained below.
>  pages_shared
>          how many shared pages are being used
>  pages_sharing

Seems like the wording is confusing me, so I write the improv:

---- >8 ----
diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-ksm b/Documentation/=
ABI/testing/sysfs-kernel-mm-ksm
index 7768e90f7a8fef..5309a912ab679b 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-ksm
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-ksm
@@ -56,6 +56,6 @@ What:		/sys/kernel/mm/ksm/general_profit
 Date:		January 2023
 KernelVersion:  6.1
 Contact:	Linux memory management mailing list <linux-mm@kvack.org>
-Description:	Measure how effective KSM is.
-		general_profit: how effective is KSM. The formula for the
-		calculation is in Documentation/admin-guide/mm/ksm.rst.
+Description:	Measure the KSM profit. See
+		:ref:`KSM documentation <monitoring-ksm-profit>` for details
+		on the calculated formula.
diff --git a/Documentation/admin-guide/mm/ksm.rst b/Documentation/admin-gui=
de/mm/ksm.rst
index 70896f01d64106..fb67318aab1ba2 100644
--- a/Documentation/admin-guide/mm/ksm.rst
+++ b/Documentation/admin-guide/mm/ksm.rst
@@ -160,7 +160,8 @@ stable_node_chains_prune_millisecs
 The effectiveness of KSM and MADV_MERGEABLE is shown in ``/sys/kernel/mm/k=
sm/``:
=20
 general_profit
-        how effective is KSM. The calculation is explained below.
+        the KSM profit. The calculation is described :ref:`below
+        <monitoring-ksm-profit>`.
 pages_shared
         how many shared pages are being used
 pages_sharing
@@ -186,6 +187,8 @@ The maximum possible ``pages_sharing/pages_shared`` rat=
io is limited by the
 ``max_page_sharing`` tunable. To increase the ratio ``max_page_sharing`` m=
ust
 be increased accordingly.
=20
+.. _monitoring-ksm-profit:
+
 Monitoring KSM profit
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--Ml68OXFDXr5GpjRs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY89ZjQAKCRD2uYlJVVFO
o7BlAQDMyhqJu2Gd5aYmI3wObMlSEIFv1Ac/f3j1FXfD812CqAD/Za4EumtDc83n
k0qMH+uB80ZYuRPQwLaAw2vO4gNCOAI=
=AqVg
-----END PGP SIGNATURE-----

--Ml68OXFDXr5GpjRs--
