Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084BC6A6128
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 22:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjB1VWR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 16:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjB1VVY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:21:24 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D46A2D14F;
        Tue, 28 Feb 2023 13:21:23 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-173435e0ec4so2149762fac.12;
        Tue, 28 Feb 2023 13:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677619283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvMhoVZJQR+9k8669IqUInbv8WaxTFEW79E0/TzqezI=;
        b=InN1PdxS1Ig3AqY0EFaeDacEVieZ8gQks59gHIBpopfo/ZArCwWTsmtmRjwecogeVV
         z9GZ9f+7SJNC2DyXm5brIT7znZ8nzAKaEuwuX7JcbGUEL2ndwko5cBvGDhwpG/dNgh6n
         9o5HmJFxqsUlzPfW4VSnrTzfI8jLb/6wjZauMCzoENGPTgc0kEf7sD8kJn5r0tR3GWn7
         knNGmeSv8AF7M2txBwbsRqTOeRKYUkT/5r62dslUxkN3Jkvc8fbGpMF0muwgI/yzgApU
         1wa0tedCt43MvMdOaijuUmkp1SFG7UxHZx9nNLly8/0Y+ebtX6mUdVHWSxXsEQFhsYVw
         Vung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677619283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvMhoVZJQR+9k8669IqUInbv8WaxTFEW79E0/TzqezI=;
        b=dFXbf4NTkUg7wrYY+7t23NA/Ljt0dh7zHpX4BmSUlZ6GdQxHTLQrZPj/o7Ui0GfgNd
         PhsEICcO2GhvrBRJHeOBDqV7Z9nTPp38+NBA8cGxG4tdBuei6IhAiOSisDzGkf3mk1Vs
         iLZ2MsPmqO95cP5zNrF8HRO9WemuD++bdBvVVsKiTK29PSAFGGN1d1V4TpQH4TxRe72z
         f4ESv3ZiV+ZbVf418VCk61EPjWq3cFCfdvDS0ko6fZjuydHVs1+28YduMjnnZxvUDzGi
         KPiD9cquIh1Lox+BYxlYvRK77hq+M9MAiH3x054ROUSAdhOrSexf8EeCiUwxC2wSKBLx
         Al7w==
X-Gm-Message-State: AO0yUKUQLlR4/4v0n1Dh7Iw+wE7rCKwLXKQ8/NGyC4ejV9GTESAPuKuI
        wxXERqi2eHkq4WAeImFL5vZVHOof6j4qaG9guMC4wTeH
X-Google-Smtp-Source: AK7set9R/jo+MUDJv56iNgwvKNRjoes1A5oNk32zTeA4myQbDPlus24Ej+pDHNKTOW3aHcq1+8GxmevxJkbTag5v5/M=
X-Received: by 2002:a05:6870:a8a9:b0:176:218b:521e with SMTP id
 eb41-20020a056870a8a900b00176218b521emr18919oab.11.1677619282845; Tue, 28 Feb
 2023 13:21:22 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:4304:0:b0:4c1:4768:8c59 with HTTP; Tue, 28 Feb 2023
 13:21:22 -0800 (PST)
In-Reply-To: <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com>
References: <20230125155557.37816-1-mjguzik@gmail.com> <CAHk-=wjz8O4XX=Mg6cv5Rq9w9877Xd4DCz5jk0onVKLnzzaPTA@mail.gmail.com>
 <97465c08-7b6e-7fd7-488d-0f677ac22f81@schaufler-ca.com> <CAGudoHEV_aNymUq6v9Trn_ZRU45TL12AVXqQeV2kA90FuawxiQ@mail.gmail.com>
 <CAHk-=wgCMTUV=5aE-V8WjxuCME8LTBh-8k5XTPKz6oRXJ_sgTg@mail.gmail.com> <CAHk-=whwBb5Ws8x6aDV9u6CzMBQmsAtzF+UjWRnoe9xZxuW=qQ@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Tue, 28 Feb 2023 22:21:22 +0100
Message-ID: <CAGudoHH-u3KkwSsrSQPGKmhL9uke4HEL8U1Z+aU9etk9-PmdQQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] capability: add cap_isidentical
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/28/23, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Tue, Feb 28, 2023 at 11:39=E2=80=AFAM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Call me crazy.
>

Hello crazy,

> I had to go through the patch with a find comb, because everything
> worked except for some reason network name resolution failed:
> systemd-resolved got a permission error on
>
>     Failed to listen on UDP socket 127.0.0.53:53: Permission denied
>
> Spot the insufficient fixup in my cut-and-paste capget() patch:
>
>   kdata[0].effective   =3D pE.val;
>         kdata[1].effective   =3D pE.val >> 32;
>   kdata[0].permitted   =3D pP.val;
>         kdata[1].permitted   =3D pP.val >> 32;
>   kdata[0].inheritable =3D pI.val;
>         kdata[0].inheritable =3D pI.val >> 32;
>
> Oops.
>
> But with that fixed, that patch actually does seem to work.
>

This is part of the crap which made me unwilling to do the clean up.

Unless there is a test suite (which I'm guessing there is not), I
think this warrants a prog which iterates over all methods with a
bunch of randomly generated capsets (+ maybe handpicked corner cases?)
and compares results new vs old. Otherwise I would feel very uneasy
signing off on the patch.

That said, nice cleanup if it works out :)

--=20
Mateusz Guzik <mjguzik gmail.com>
