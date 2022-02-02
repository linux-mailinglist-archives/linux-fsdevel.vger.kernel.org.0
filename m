Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40BF4A6E44
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 10:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245683AbiBBJ6B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 04:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230295AbiBBJ6A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 04:58:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF3C061714;
        Wed,  2 Feb 2022 01:57:59 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id p7so40649318edc.12;
        Wed, 02 Feb 2022 01:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ey2z3i7QHrRTnQBlHi6Kalzf4a0PXCzJe1Kfeyo/MCQ=;
        b=RPidongy5qJOr/SrqmoszypGyzGA4K/PnD0/WQS7Y0ux6ophINPE3tX9q/5OgOqvek
         i1uf8Br4NTeUBf3GezletEwFFIT7V4/aHvzkxOAdWFPeKU8rcXbysTowx6xc+gUY7pUb
         2BGc0jYa/2E5Wb5vOcg+F2R6NWYp7i8dIC7uQLF27TcMDBKJeq2r1dL8Xz/8wfHH0wzc
         Ux0ihtyOS+k+bMMZEph040GH4ZMdWYKzPe+uD6t3RMM83MsIPkpE4C8DgZ9PQHm/raPh
         Lq1jLZZqNhR062h+DvaVdzZxkPHfvp5Lt0J/lc3tPcC+DdnVhzaw6sYM/LGH+QGZxjOw
         298w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ey2z3i7QHrRTnQBlHi6Kalzf4a0PXCzJe1Kfeyo/MCQ=;
        b=OR0I7BA7KrcTvdktt2KXRL+pdf8Ep4MfyK1IyM5Si14PB1naDhs7nqlGDoj5zX/66L
         d8D/UIuwr8bKQECF9nWVIOSP+L3Ex72yzEnJO6PrUO45jnE1Ac3GhO9DEl9PtfRNcelH
         sMikyE0qAQ7QbIzH3wQhZ5eFdRV1sOvopN3TTONvn6oMc+zdOnOoCP/2Ao0A3acjkJFB
         9Yl5KCrckn1p4q4ZjuM2f0YrQ7wXDFKVmBYy3LTHVq5g5K3u+ObWZoTYMe3aVXCk6XIi
         vFcV2mjBfbV1bk+H21fTXQNEOIlcB8I/bkf8Z1+w17zVymjo1As+e6xFTmT84I6bV7nr
         0aRQ==
X-Gm-Message-State: AOAM5336sMOQgII8Jvr/Shm4Xb/+ISD3mVpBBVfDScoCy81QTOEBAuWs
        ikWiF8QBk9qaKynfo1orAzjAe6ub3dIjznrvyaFACfsiK/l8ug==
X-Google-Smtp-Source: ABdhPJwvui5ZLz6UQOpsNpdYF2nOoANYChNKQAwx1JpetcJ/luF/01Pn+6rdyzfs852oX9Q/V260qkGOSE9fhDFb0Fg=
X-Received: by 2002:a50:cccb:: with SMTP id b11mr29474435edj.57.1643795878282;
 Wed, 02 Feb 2022 01:57:58 -0800 (PST)
MIME-Version: 1.0
References: <20220131151432.mfk62bwskotc6w64@ws.net.home> <20220131192337.lzpofr4pz3lhgtl3@zeha.at>
In-Reply-To: <20220131192337.lzpofr4pz3lhgtl3@zeha.at>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 2 Feb 2022 12:57:47 +0300
Message-ID: <CADxRZqwq=XmXZnnENU+vD7_2oC_VtqhG40P-xg=QAzKchT-3Ng@mail.gmail.com>
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
To:     Chris Hofstaedtler <zeha@debian.org>
Cc:     Karel Zak <kzak@redhat.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 1, 2022 at 11:48 PM Chris Hofstaedtler <zeha@debian.org> wrote:
>
> Hello,
>
> * Karel Zak <kzak@redhat.com> [220131 16:15]:
> >
> > The util-linux release v2.38-rc1 is available at
> >
> >   http://www.kernel.org/pub/linux/utils/util-linux/v2.38/
> >
> > Feedback and bug reports, as always, are welcomed.
>
> Thanks.
>
> Some lsfd tests appear to fail in a Debian sbuild build environment,
> in that they differ in the expected/actual values of DEV[STR] (see
> below). I did not find time to investigate this closer, but thought
> it would be best to report it sooner than later.
>
> Best,
> Chris
>
> ---snip---
>
>          lsfd: read-only regular file         ... FAILED (lsfd/mkfds-ro-regular-file)
> ========= script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-ro-regular-file =================
> ================= OUTPUT =====================
>      1  ABC         3  r--  REG /etc/passwd   1
>      2  COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
>      3  PID[RUN]: 0
>      4  PID[STR]: 0
>      5  INODE[RUN]: 0
>      6  INODE[STR]: 0
>      7  UID[RUN]: 0
>      8  UID[STR]: 0
>      9  USER[RUN]: 0
>     10  USER[STR]: 0
>     11  SIZE[RUN]: 0
>     12  SIZE[STR]: 0
>     13  MNTID[RUN]: 0
>     14  DEV[RUN]: 0
>     15  FINDMNT[RUN]: 0
>     16  DEV[STR]: 1
> ================= EXPECTED ===================
>      1  ABC         3  r--  REG /etc/passwd   1
>      2  COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
>      3  PID[RUN]: 0
>      4  PID[STR]: 0
>      5  INODE[RUN]: 0
>      6  INODE[STR]: 0
>      7  UID[RUN]: 0
>      8  UID[STR]: 0
>      9  USER[RUN]: 0
>     10  USER[STR]: 0
>     11  SIZE[RUN]: 0
>     12  SIZE[STR]: 0
>     13  MNTID[RUN]: 0
>     14  DEV[RUN]: 0
>     15  FINDMNT[RUN]: 0
>     16  DEV[STR]: 0
> ================= O/E diff ===================
> --- /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file    2022-01-31 19:12:43.802603811 +0000
> +++ /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-ro-regular-file  2022-01-31 14:57:47.000000000 +0000
> @@ -13,4 +13,4 @@
>  MNTID[RUN]: 0
>  DEV[RUN]: 0
>  FINDMNT[RUN]: 0
> -DEV[STR]: 1
> +DEV[STR]: 0
> ==============================================

Chris,

i had this error on my test system

https://github.com/util-linux/util-linux/issues/1511

but i can't reliably reproduce it now (on my current kernel 5.17.0-rc2
and on debian kernel 5.15.0-3-sparc64-smp )
Tested with the following command line (for current git util-linux sources):
$ for i in {1..100}; do tests/run.sh lsfd; done  | grep FAILED

^^ no failed output

I can reopen the issue above, so we could try to reproduce it.
