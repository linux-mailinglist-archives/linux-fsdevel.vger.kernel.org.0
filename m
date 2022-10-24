Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE3D609BE7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Oct 2022 09:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJXH4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 03:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiJXH4f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:56:35 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB735D0F7;
        Mon, 24 Oct 2022 00:56:34 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 20so8061940pgc.5;
        Mon, 24 Oct 2022 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p8SE1tvfGUXU0O91MO2mkN0g4QvMjQD0SGq7REgmz8M=;
        b=RCXm6D6yJPEsCUFi5KVr5WzqZ+DLz2rJpww5vdWlat6dGr0dSdaoXdg4IBlbcQ2PAd
         sjCrzW5IotuY0TwwksR86RRVL14Xus163hE2eNh2MbMaJRIVUDH9dyGzZWoaZXu7J+0p
         q8jUGQIwfN3M3s4q+j5iyli+wWpexUCeK32vVMR/Hf9x1WDV6t8ZvMkgtdOJJ+M8KPeV
         nl1VwQCsCTqORRR8PY8hKG1HE8q5PygoEACPTX4IwDosf/SgpBgTqJOxTYwNOL7BIGd0
         VZ5hjUVowuJHfFQZ0Ch5N/uebe7/lWxoB3FNQZpm+oh4fZ8RQsQEwFEe2H8UfZmXiVUw
         t1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8SE1tvfGUXU0O91MO2mkN0g4QvMjQD0SGq7REgmz8M=;
        b=aGc7TJCgNM7xVdoZ/Ccxob7DsyXtQPU7G95rJCmMYlh1scQCgAAUZl9ES3x0t03pNn
         O4IgrDtqPI97Sh/6oRpy1MLqnV0+f8kW2pK2Gsi1ivqrHo1lwRTLlvDnPs4LVHn25/BJ
         NAnAvEWCZeTuoroiI1bc/wPwmGr6Dptcu31VIeC3KRj6QlkdIimVrdklb3yKJojj7so1
         XqDbZfqqVyoOBqRqu/5xumMahgAV31s3Ch7wPbA0Yh5iP/5TLOTjDXAcsLAcgWU0vXR/
         gcTmdgj6Ste9VhFYyRQK0n8jf5xJbFaLhsemwwI24vRSCmUK1IjPspAYlvV45Ls/G65L
         K3yA==
X-Gm-Message-State: ACrzQf1IJekoJOR/qyivxGOVwS8LwRKOFzokcYr0/jub6b/kMSmTyRVa
        0/oL3lX8PYCABCydHqIKo1U=
X-Google-Smtp-Source: AMsMyM4cjpzYSQ8OSAnpmfMKqhZaQnszcUx+wi8yJQdul3prtTUO+tTBmjly69B4d9DJGR8PNsSLgw==
X-Received: by 2002:a63:6986:0:b0:43c:8417:8dac with SMTP id e128-20020a636986000000b0043c84178dacmr27054128pgc.286.1666598193357;
        Mon, 24 Oct 2022 00:56:33 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-77.three.co.id. [180.214.233.77])
        by smtp.gmail.com with ESMTPSA id l3-20020a170903244300b00174f7d107c8sm19329495pls.293.2022.10.24.00.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 00:56:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 681871004AF; Mon, 24 Oct 2022 14:56:29 +0700 (WIB)
Date:   Mon, 24 Oct 2022 14:56:28 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     krisman@collabora.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] unicode: mkutf8data: Add compound malloc function
Message-ID: <Y1ZFLO98zNoAgniW@debian.me>
References: <20221024045030.177438-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sDFdsZx+99thmPxE"
Content-Disposition: inline
In-Reply-To: <20221024045030.177438-1-kunyu@nfschina.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--sDFdsZx+99thmPxE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2022 at 12:50:30PM +0800, Li kunyu wrote:
> The patch has the following modifications.
> 1. Add unicode_data_malloc function, which realizes the combined use of
> malloc and memcpy, and assigns values to dst.
> 2. Add unicode_data_remalloc function assigns 0 to the data in the
> allocated memory pointer. When the integer free parameter specifies 1,
> execute free (* dst), and finally assign the value to dst.
> 3. Remove the original um pointer related code and replace it with these
> two functions.
>=20

These changes should be split into separate patches.

Also, please take a time to review the patch description because what I
read above is somewhat confusing.

And the last, please learn how to use git-format-patch(1) and
git-send-email(1) correctly.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--sDFdsZx+99thmPxE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1ZFJgAKCRD2uYlJVVFO
o1tBAQDwKcOlq0JzuNcNkJwSJ+z+jSIrFDjUUSEmst/w6+/sRAD/QZLv948kpqlF
MELLTE9UeUW+RBSMxJR3O3F8O+oKVgs=
=j9Vn
-----END PGP SIGNATURE-----

--sDFdsZx+99thmPxE--
