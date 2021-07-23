Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72D43D3A28
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 14:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhGWLo4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbhGWLoz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:44:55 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED32C061575
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 05:25:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso996948ota.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 23 Jul 2021 05:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aRUskXGznymjiPhSPPZyhJYIsZLMytqVDg3CZ0gajkI=;
        b=dQT4tlqWkatDtLUgzzl1zSN7dtH3n39/QVn66bgkMWjc4p4kY16tD9Z7zhPTivaasa
         7y01sspGAtEP4d6tZIeP+GIe5MUv9rZabiNNQAVz0Cu0n9uT5ujG9tjFJ/nc395mfYr9
         A7FqOZ9iRlG+x8bEzf2bS/V8cpKblV4LD8owGUBU2xbHck5etFryu5ohz9hc+83Yuxfr
         I4uGojvb471OrMlDLn+pofsiy1wXFRdvYIk0OReuw5lCiNFCmspq0OOBeiJ0fWGLv/hT
         V+24BgzruN5ybwF4UWCV3oHEKgKwCSTGT8YAwM+HbLs85kZQsyUNjP662kQyyjbcunI0
         Bfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aRUskXGznymjiPhSPPZyhJYIsZLMytqVDg3CZ0gajkI=;
        b=NddP9uqtvbubXu84+zqTcCeEbNcjGpkDQuZ6wNlsiT2+wbcBUUs8jEaeGlB2LSzsVn
         ofDJwnzDiVDSDGpRxZpn2yeSzWGSjUcowQlGZMBujlsosEc3b42aicrCtFJA4IzLkOxd
         i5bgWBHLD6z7GPKMxZ39pb3L8zvRPrfhlTx1jNHCmx50Xvt4ZfG9v+csNrC85QFojIV9
         oLAce6A2ewvAN3qK20IPWV+oNzg3ocoe8kVTA3S0ZQ7y9Yo6oOyEH0k6fgTEDIMqdgvq
         Q2moAglC6rwYTUtRuySolvKyvaFPbvBdiETE3mu69ezan/dGBu6wp8kozvKKH42LQads
         I5wQ==
X-Gm-Message-State: AOAM531ekLz2/r4nCqt1qmaQvtpXitO7kkO48QGhAxnLpf/MBqKtK8Mc
        4v8c7MtO64MJn/G4OmrNe+F/Lyetu5aM98/2jVNxwQ==
X-Google-Smtp-Source: ABdhPJwXTpo12ME8GoDOuTPYTK33J28upzzgQJgLGzW+l1l5KobGs/3ySmoblDwwcR5fo1Pd7kAxk7/KUCLFlb24NBQ=
X-Received: by 2002:a9d:27a4:: with SMTP id c33mr2911795otb.281.1627043126908;
 Fri, 23 Jul 2021 05:25:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210722155628.371356843@linuxfoundation.org> <CA+G9fYt_9nfDcQzKm8SZtmQXzzrybutS9vD4GgUw_0o8UD1HOQ@mail.gmail.com>
 <YPqwF7wtM6n3wHlr@kroah.com>
In-Reply-To: <YPqwF7wtM6n3wHlr@kroah.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 23 Jul 2021 17:55:15 +0530
Message-ID: <CA+G9fYvjgkaQxdW52sMzQm73f2xJreQzrPiCV48qD+5EN-b0Kw@mail.gmail.com>
Subject: Re: [PATCH 5.13 000/156] 5.13.5-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, Pavel Machek <pavel@denx.de>,
        Jon Hunter <jonathanh@nvidia.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-stable <stable@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LTP List <ltp@lists.linux.it>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 23 Jul 2021 at 17:33, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Jul 23, 2021 at 05:26:22PM +0530, Naresh Kamboju wrote:
> > On Thu, 22 Jul 2021 at 22:17, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > This is the start of the stable review cycle for the 5.13.5 release.
> > > There are 156 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Sat, 24 Jul 2021 15:56:00 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.13.5-rc1.gz
> > > or in the git tree and branch at:
> > >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.13.y
> > > and the diffstat can be found below.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > The following error is due to SATA drive format failing with arm64 64k-page
> > size ( CONFIG_ARM64_64K_PAGES=y ) kernel.
> > while running LTP syscalls test suite on running 5.13.3 and 5.13.5-rc1 kernel.
> >
> > First it was noticed on the stable-rc 5.13.3-rc2 kernel.
> >
> > Whereas 64bit kernel and 32bit kernel pass with 4K page size.
> >
> > Initially, I thought it could be a Hard drive fault but it is reproducible on
> > other devices but not always. Which is a blocker to bisect the problem.
> >
> > The steps to reproduce:
> >  - Boot arm64 juno device with 64k page stable-rc 5.13 kernel Image [1]
> >    - CONFIG_ARM64_64K_PAGES=y
> >  - format connected SATA drives and mount /scratch
> >  - Use the mounted /scratch for LTP runs to create and delete files from this
> >  - cd /opt/ltp
> >  - ./runltp -d /scratch -f syscalls
>
> And does that also fail for 5.13.2?

Yes. It failed on 5.13.2 also.

Ref failed log:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.13.y/build/v5.13.2/testrun/5147287/suite/ltp-syscalls-tests/test/copy_file_range01/log

- Naresh
