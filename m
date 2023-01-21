Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF8D6762FC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jan 2023 03:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjAUCTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Jan 2023 21:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbjAUCTs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:19:48 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8205871345;
        Fri, 20 Jan 2023 18:19:47 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9so6835991pll.9;
        Fri, 20 Jan 2023 18:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/fdOQVFdPi9HnJ4z6CkmymohYw1G1ENm8XngoDK5mo=;
        b=HLSEsGxPAc4Ai1lxlN0Xi3PCV0jA7NmVrlbuyp2z6eehW7HRZ7lRk9QVMxqLe6QY42
         9k6B030ehVSkS0TrQKxrBqOEd8dUUfpxr22laTrc6SQyWo4/jpO5l+NzQM8uAdQGwAkx
         DZNBCja36iLKJUWH+OQM0Z6MxzcxqfqEkFuS5/2Qzn+upIfp2/q1XHiT7Ucd7rr8ie1Y
         v1Cvb7D6DRBetdf0us/Q6Tj9pAX6JOn9OV8ySBf7f0CIumYCNVOHK0FT2rT6+5cZ3FOp
         +0aK9IYFWtw0JREXVVZoVd/QX6lBzpcGGGwuierTzLQ+LAMMnKU8Mndc/LpNHuM6evtC
         ginQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/fdOQVFdPi9HnJ4z6CkmymohYw1G1ENm8XngoDK5mo=;
        b=kzHFGu3bzSi/OCs1XLRkkXn0N2i+H74WyeDV9zFspWcSUhH0Lqbs1awYLuN0s7PaUf
         atiQxboCTffJEUKhO14L38JciRxHNN7kwYl3vLBOp1SqEIAaLMsdaavKkuzuKaQonrOa
         a11lobrJg0/Znr3i3TRf1ERMJLHqFeWRxeTrjSjlXbcZz9XQ0qNNd96+RGnmB0/Tu9ds
         Nl23WcPBtJ+hNshEIR6Wywdip0VFojTgJBGt/rNdEiXMIkigxC82WbFzQA8qzu9tFaqT
         Jwe+Sc20j/i3c1Lu31xjQ8CgkALSOLhpnlvqxEwNFuGi6+mzkpy4nMAuzH0pMWhnVu3b
         MTSQ==
X-Gm-Message-State: AFqh2kokKDeIs/bGw9Gj2R4Imrc0ahRbXbdQ/BaOXz2r3z7R2zA8heH6
        pwsiqU44iYe4Cvtyn7VC4CU=
X-Google-Smtp-Source: AMrXdXuusgHnc5G3EvtFYeX5aiteN4IMHnHcuaxSRrxsz4n3xHYaPzVxYXgHiUDEPOLa/PNlTrmKqg==
X-Received: by 2002:a17:902:6b4c:b0:193:38ef:10cf with SMTP id g12-20020a1709026b4c00b0019338ef10cfmr17359258plt.29.1674267587011;
        Fri, 20 Jan 2023 18:19:47 -0800 (PST)
Received: from debian.me (subs02-180-214-232-22.three.co.id. [180.214.232.22])
        by smtp.gmail.com with ESMTPSA id o13-20020a170903210d00b0018853dd8832sm27728804ple.4.2023.01.20.18.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 18:19:46 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 39CA5104399; Sat, 21 Jan 2023 09:19:43 +0700 (WIB)
Date:   Sat, 21 Jan 2023 09:19:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Alexander Larsson <alexl@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, gscrivan@redhat.com,
        david@fromorbit.com, brauner@kernel.org, viro@zeniv.linux.org.uk,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 5/6] composefs: Add documentation
Message-ID: <Y8tLvvzwekoXfDmx@debian.me>
References: <cover.1674227308.git.alexl@redhat.com>
 <20baca7da01c285b2a77c815c9d4b3080ce4b279.1674227308.git.alexl@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hSqAm8IiEMxeruQl"
Content-Disposition: inline
In-Reply-To: <20baca7da01c285b2a77c815c9d4b3080ce4b279.1674227308.git.alexl@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--hSqAm8IiEMxeruQl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2023 at 04:23:33PM +0100, Alexander Larsson wrote:
> +For more details, see cfs.h.
> +

"See a code comment describing the descriptor file layout in
fs/composefs/cfs.h for details."

Otherwise LGTM.

--=20
An old man doll... just what I always wanted! - Clara

--hSqAm8IiEMxeruQl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8tLugAKCRD2uYlJVVFO
ow9mAP4tR9OCENw9j8nNTkS6VoRntDIvhFYomtkMhIc4aqcZOQD+OkkBWTi0uOLp
sZ0El1ZD5ZSVv5ALrn/yZ6Z2YAlAfw0=
=tK8A
-----END PGP SIGNATURE-----

--hSqAm8IiEMxeruQl--
