Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33991382644
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 May 2021 10:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhEQIJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 May 2021 04:09:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59769 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbhEQIJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 May 2021 04:09:23 -0400
Received: from mail-lf1-f69.google.com ([209.85.167.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <juerg.haefliger@canonical.com>)
        id 1liYII-0002ka-3A
        for linux-fsdevel@vger.kernel.org; Mon, 17 May 2021 08:08:06 +0000
Received: by mail-lf1-f69.google.com with SMTP id z1-20020a195e410000b0290229c07c3305so517293lfi.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 May 2021 01:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2nfOfJbiW4LP47Os6SKNJii3XzVzNGlTqIy0yN4oc5s=;
        b=t8dfpMwSvIP3rC8s01YN4AF+jDJHZgrMgEHiAtvGhBER5QHDkLVcPMGNDLXzIhX4JO
         NR2uDKyHBPX4YXl9fN4KVwDqi5zot0KhFgaTIxBnVE/wqnqSmI4Gw3CYH08TkWeXmkWI
         Rx7yBsXEmNGogE4d2g2WMKAXDx37J+iABlGfXWfrFgSGWTkJQ4t4kysBOPLHivKxYHBe
         fRSD7hf3+FIzSrVLKEEr0yBIbc6C8ZhzIaXY22XeslmLjbKN9w4muNtmKhNNf4wbQpfx
         gfvMLC/IzZFA0gwJ9J+/zYztrZR/nkuksRh0jUSjZ+IAdJAS1AUWmb/uczUkPWi2QSOv
         H6Fg==
X-Gm-Message-State: AOAM531XIUFkWPz3/eDKg1OOVmmEqSCnLowMX4zYpRS59hRT+DO39ibU
        wKwrtSdaxuIuWk2UvnI2Pw6D7hBPhzTIEuxuOjq0fbWjzatglMxLDE6UoAHI7gQHSuuAf0uupTR
        znHl8LDS2/E2kXrSYhyxRYB+LbElU6kMFVIvseHjI69cRXPkIjnj3u2sLtw4=
X-Received: by 2002:a05:6512:22c5:: with SMTP id g5mr7249795lfu.540.1621238874890;
        Mon, 17 May 2021 01:07:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLtpww2uPvpXvqqFSrHjVtl5+PaUMtX5la3CRUKSXX9w5roG0JSHKvA7LN99mpG0HgsEAdcu8ZL6lhlLJqIdM=
X-Received: by 2002:a05:6512:22c5:: with SMTP id g5mr7249760lfu.540.1621238874702;
 Mon, 17 May 2021 01:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210516132209.59229-1-juergh@canonical.com> <YKIDJIfuufBrTQ4f@kroah.com>
In-Reply-To: <YKIDJIfuufBrTQ4f@kroah.com>
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
Date:   Mon, 17 May 2021 10:07:43 +0200
Message-ID: <CAB2i3ZgszsUVDuK2fkUXtD72tPSgrycnDawM4VAuGGPJiA9+cA@mail.gmail.com>
Subject: Re: [PATCH] treewide: Remove leading spaces in Kconfig files
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     aaro.koskinen@iki.fi, tony@atomide.com, linux@prisktech.co.nz,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, mst@redhat.com, jasowang@redhat.com,
        zbr@ioremap.net, pablo@netfilter.org, kadlec@netfilter.org,
        fw@strlen.de, horms@verge.net.au, ja@ssi.bg,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev <netdev@vger.kernel.org>, linux-scsi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, lvs-devel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Juerg Haefliger <juergh@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 17, 2021 at 7:46 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, May 16, 2021 at 03:22:09PM +0200, Juerg Haefliger wrote:
> > There are a few occurences of leading spaces before tabs in a couple of
> > Kconfig files. Remove them by running the following command:
> >
> >   $ find . -name 'Kconfig*' | xargs sed -r -i 's/^[ ]+\t/\t/'
> >
> > Signed-off-by: Juerg Haefliger <juergh@canonical.com>
> > ---
> >  arch/arm/mach-omap1/Kconfig     | 12 ++++++------
> >  arch/arm/mach-vt8500/Kconfig    |  6 +++---
> >  arch/arm/mm/Kconfig             | 10 +++++-----
> >  drivers/char/hw_random/Kconfig  |  8 ++++----
> >  drivers/net/usb/Kconfig         | 10 +++++-----
> >  drivers/net/wan/Kconfig         |  4 ++--
> >  drivers/scsi/Kconfig            |  2 +-
> >  drivers/uio/Kconfig             |  2 +-
> >  drivers/video/backlight/Kconfig | 10 +++++-----
> >  drivers/virtio/Kconfig          |  2 +-
> >  drivers/w1/masters/Kconfig      |  6 +++---
> >  fs/proc/Kconfig                 |  4 ++--
> >  init/Kconfig                    |  2 +-
> >  net/netfilter/Kconfig           |  2 +-
> >  net/netfilter/ipvs/Kconfig      |  2 +-
> >  15 files changed, 41 insertions(+), 41 deletions(-)
>
> Please break this up into one patch per subsystem and resend to the
> proper maintainers that way.

Hmm... How is my patch different from other treewide Kconfig cleanup
patches like:
a7f7f6248d97 ("treewide: replace '---help---' in Kconfig files with 'help'")
8636a1f9677d ("treewide: surround Kconfig file paths with double quotes")
83fc61a563cb ("treewide: Fix typos in Kconfig")
769a12a9c760 ("treewide: Kconfig: fix wording / spelling")
f54619f28fb6 ("treewide: Fix typos in Kconfig")

...Juerg


> thanks,
>
> greg k-h
