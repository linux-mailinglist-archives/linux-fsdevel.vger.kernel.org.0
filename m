Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0A920F26D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732384AbgF3KQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 06:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732330AbgF3KQR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 06:16:17 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B37DC061755;
        Tue, 30 Jun 2020 03:16:17 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x9so17225691ila.3;
        Tue, 30 Jun 2020 03:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=SbAEPN1m4iKiBG7QA+v5cU/z7WYXiQ4xQRuZe2DabsE=;
        b=JagFxB5Alxz5lawsJrsU1BV3p45tgLIiw6eyUiLkQ9M2clbGsq/EUH4mHWDUI7V+Z7
         ykJ6E1/dzBdJUNP3bGIl984EaTjwXv/xOUYgoaY4+D9udjTTeTqW1mOsRvmgGv7Xh5ja
         atogqR0dfQ7KneaRgE46UwZR11RYw2pqF+QETBRdKTgQL5rCLTRl1UJ9BBJ9LCXEo2ER
         Jz9zN312H0j7chDLj34pxs5TaD6OqqQeScBqX/SMicm3wHRFdmN/zLo9lrqhWoA1Cv3L
         ximYiJNO2PRIYxSJQoDAfoNUbJOatMPWwYjBbFO16cZJMsDsS9TxwC/DyiA48bqGoNW8
         fn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=SbAEPN1m4iKiBG7QA+v5cU/z7WYXiQ4xQRuZe2DabsE=;
        b=HZA/Y7enn0CEkPBlCeWj0bHhuxz4i8k0oLO/YZpdfqstlIlgiEluhKFsnp3DpwuDJr
         Q36OTH1e6d+Vy8wmM+idPIo0EeRVbszDIGK4GctF/50cJMYSxTzD3oZIjHzCYzGQsGma
         QwfLJczCIgVa2GEVZaE8dYq1oz2iylpPnqWo503BOkGzeKMtSwb8dT2g99TUGg3hNIyi
         /E0hX0AJKwasOgWxfQQczL++A/FUWm7jYsM0iXicZ00tLsSj+/L/II2o9b1d/nfGvCe7
         C2w3pbnlyPJ/EzYJ6e3afY02qMcg2bzRGi7ItBlFNfkyc0ycBUfTLh3Il+0cps7NIVr9
         eXlA==
X-Gm-Message-State: AOAM531UYnoJknImIOF5zpFzWIHQ9jydMX/DDeNQ3K7CBEZnOmj/6RzB
        S1L9G1BHyD0mbDcUCwgixJ3Dw3CeZMVO0zx6qk8=
X-Google-Smtp-Source: ABdhPJyaCeWhPWJX1rNdVyxwunt0oDSFfid+9IdQTFGd6ZVsBgSziCP0bPkd2a7xYaiH53s/3vetfJQKqWLlilwNzpk=
X-Received: by 2002:a92:940f:: with SMTP id c15mr1993358ili.204.1593512177008;
 Tue, 30 Jun 2020 03:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200512081526epcas1p364393ddc6bae354db5aaaae9b09ffbff@epcas1p3.samsung.com>
 <000201d62835$7ddafe50$7990faf0$@samsung.com>
In-Reply-To: <000201d62835$7ddafe50$7990faf0$@samsung.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 30 Jun 2020 12:16:33 +0200
Message-ID: <CA+icZUUjcyrVsDNQ4gHVMYWkLLX9oscme3PmXUnfnc5DojkqVA@mail.gmail.com>
Subject: Re: exfatprogs-1.0.3 version released
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Nicolas Boos <nicolas.boos@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 10:17 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
> Hi folk,
>
> We have released exfatprogs-1.0.3 version.
> Any feedback is welcome!:)
>
> CHANGES :
>  * Rename label.exfat to tune.exfat.
>  * tune.exfat: change argument style(-l option for print level,
>    -L option for setting label)
>  * mkfs.exfat: harmonize set volume label option with tune.exfat.
>
> NEW FEATURES :
>  * Add man page.
>
> BUG FIXES :
>  * Fix the reported build warnings/errors.
>  * Add memset to clean garbage in allocation.
>  * Fix wrong volume label array size.
>  * Open a device using O_EXCL to avoid formatting it while it is mounted.
>  * Fix incomplete "make dist" generated tarball.
>
> The git tree is at:
>       https://github.com/exfatprogs/exfatprogs
>
> The tarballs can be found at:
>       https://github.com/exfatprogs/exfatprogs/releases/download/1.0.3/exfatprogs-1.0.3.tar.gz
>

Hi,

thanks for the upgrade.

Today, I contacted the Debian maintainer on how he wants to
distinguish between exfat-utils vs. exfatprogs as Linux v5.7 entered
Debian/unstable.

When I looked at the release/tags page on github:

Can you please offer tar.xz tarballs, please?
Hashes? Like sha256sum
Signing keys? (Signed tarballs?)

Thanks.

Regards,
- Sedat -
