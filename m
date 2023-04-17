Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5AF36E427D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Apr 2023 10:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjDQIXa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Apr 2023 04:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjDQIX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Apr 2023 04:23:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B3C4C28;
        Mon, 17 Apr 2023 01:23:00 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id b2-20020a17090a6e0200b002470b249e59so14382636pjk.4;
        Mon, 17 Apr 2023 01:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681719779; x=1684311779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OuMyQcD7/2ZnEl2+NMcgJTRjzR7cTySjiosq/Hj/fns=;
        b=njq8bqHT/tdLrEVkoZBCWvh2hUlvHjUEx6EOvIax20VxdE/vhi6LQmCiyTuNRQq72X
         gALUfNuIE2dNztcmvy/ujuLOcby3rl1fWFyCb7jRXbcZTA4SzE2IQOrpgRUG7TSMci/J
         RidMxJ03Fcv8CLINJ/RGG7460EChyk/iTySu3hNJ9N/ebYIN1GDbOT2nN4sVhTyEKqUm
         I3hGXedtj5Xfh5vmdt0SKdQOvkqlJ7Ch1/w5LZAzZKl57VuhbzzlFzdT+zrAfVAj2WTT
         qLKHAGbuUG5Hdg2QJKw3TbH/HAqYBtbI9LH44l7+CJ4zd9Oh8JUqRpQLpSQXnEqwiNzI
         bKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681719779; x=1684311779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuMyQcD7/2ZnEl2+NMcgJTRjzR7cTySjiosq/Hj/fns=;
        b=Kd0M1bB8nMPvADolBv1MWWTLAiiAZqpVTJmeRgFoJ/4uPzip627f3/0iW8PmTiEl+U
         r/K3gPK+8Nf/LnPagj2VKg+fJqCg4BF6HVMCYz809lg35zDncfMo59MJZNKbyrNax2bS
         WtNMqkSX9J8pQGXU5jFxBeI37qvyWOjXvivJ9lpIf3EnhUHvGr0Y8RG+5LWSyzTAD6FX
         /R3NaX/ixIpzXOItkHn7ix0ghTvQTYMJvIweAvpkNUndXDUCpq8c+SxltS+Z7jnUEMnU
         NTc0rzzAQ5zxV1MeZOqj9ZqxtPgyJMCyw761zKHBho082AUGvpQuqtdVdJ1yIBrkE+l+
         sKhg==
X-Gm-Message-State: AAQBX9cibR8393jnYC/niz1t/VbPbFbgiyt1uxevpelsu5RWaQ/TQBjB
        ON9JRw1fyFW8hxM8RRTEyDQ=
X-Google-Smtp-Source: AKy350Z/hEvAm7HtoRsj4jxrcIfGcT8qQYlXImKQLR5g1RkBxqulxcirnWiiC4sjDZ/BeE02AQy86A==
X-Received: by 2002:a17:90a:ec05:b0:23e:f855:79f2 with SMTP id l5-20020a17090aec0500b0023ef85579f2mr15485142pjy.12.1681719779393;
        Mon, 17 Apr 2023 01:22:59 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-3.three.co.id. [180.214.232.3])
        by smtp.gmail.com with ESMTPSA id u3-20020a17090282c300b001a1c721f7f8sm7101143plz.267.2023.04.17.01.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:22:58 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id CB7E3106852; Mon, 17 Apr 2023 15:22:55 +0700 (WIB)
Date:   Mon, 17 Apr 2023 15:22:55 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     wenyang.linux@foxmail.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Dylan Yudaken <dylany@fb.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>, Fu Wei <wefu@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eventfd: support delayed wakeup for non-semaphore
 eventfd to reduce cpu utilization
Message-ID: <ZD0B3wGasaWT0rsr@debian.me>
References: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U4v5feeXuk+NIROB"
Content-Disposition: inline
In-Reply-To: <tencent_AF886EF226FD9F39D28FE4D9A94A95FA2605@qq.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--U4v5feeXuk+NIROB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 16, 2023 at 07:31:55PM +0800, wenyang.linux@foxmail.com wrote:
> +eventfd_wakeup_delay_msec
> +------------------

Please match the section underline length as the section text above.

> +Frequent writing of an eventfd can also lead to frequent wakeup of the p=
eer
> +read process, resulting in significant cpu overhead.
> +How ever for the NON SEMAPHORE eventfd, if it's counter has a nonzero va=
lue,
> +then a read(2) returns 8 bytes containing that value, and the counter's =
value

reading eventfd?

> +is reset to zero.
> +So it coule be optimized as follows: N event_writes vs ONE event_read.
> +By adding a configurable delay after eventfd_write, these unnecessary wa=
keup
> +operations are avoided.

What is the connection from optimization you described to eventfd_write
delay?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--U4v5feeXuk+NIROB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZD0B2gAKCRD2uYlJVVFO
ozmaAP9tfTu24qCrnMYGSI9F1chtlQWOM77qbPwGMbmnpimGWQD+Iy9HE5ts10sR
EgsByMySCD2o4CVX6g+qpkkU/lkhAQU=
=xVAv
-----END PGP SIGNATURE-----

--U4v5feeXuk+NIROB--
