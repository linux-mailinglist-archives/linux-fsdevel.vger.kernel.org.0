Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEAF3D151A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jul 2021 19:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbhGUQtL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jul 2021 12:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhGUQtL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jul 2021 12:49:11 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B14C061575;
        Wed, 21 Jul 2021 10:29:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id bu12so4482179ejb.0;
        Wed, 21 Jul 2021 10:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XP0iAPTzXCS6/hXN5afn3pCSvhDsfbRfFxq+vdKUGU8=;
        b=TWWXO8Wznrfh3IEb+hXEjiNusl0FD/72xovtttyL5WjrF/Ze4BgxjMwxkP2/KJB6Y8
         m2dHFVKSV7yt1eRra8XALcC9TGq+9kJ97VYMxIsW4EIdmRBKJqMPhsf+aeB9vzl4MCcQ
         g41p8gXVEk51SiDFzZ5DpUxLteBk48kOLOMLHiy2mlSDJdD6qJgB0a0+fgSw/Qb/sKhF
         DaH3TG9QNVSHHSm1pOHI7yNP2csO37NZv8yguDkDVZELfc05Cl1r13sG58hnLI1vhnhZ
         92Uoyj884HVys25GJ2canrGoL0tpmS+CYhOKNTtJ1ssWIgAPTSMjcDba/h0+sgCarVXA
         DS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XP0iAPTzXCS6/hXN5afn3pCSvhDsfbRfFxq+vdKUGU8=;
        b=M2Z0GaHxQouinZiYZ+GOy1+1UdhfEzZGPdmqLzDQxGn8j2yOjrkWxrHRUZYSEnm7Jm
         p1e2AyqcMS8HfLX1qP+eVRDjMrknCsEmBgmmD7GtsCau3e7lcDdjNWEmHWLZ4RECFLJV
         QWQW4hzGU2BfosySzW8MFyRaUHLBWdAIeo10pdp88c/GA/tR6IAPrLDcIYPDQsg6e29e
         /hGNVnFAn6mrxEs+5uig90XRXv2ZD0F9m3EQPonBlS9xyvGvklo1w7ecIwQE0rMkLeI7
         c4ZV03rpRVLFiXXUgBN/UzzuMBaS9ZfWPR3+x04Uj6LOdpfZKaKgQi6BrioV+zInyc4o
         AjVQ==
X-Gm-Message-State: AOAM530YIoMDpD3FvcDnTKQca3xWMVD+DWR5SXRKG/EbYriGMPXRbMAV
        73Xjj+3TBWaKXK6UrR2JWGWY4QCyRupHTcxCGcE=
X-Google-Smtp-Source: ABdhPJxVd/rBQsk/2obbH5UlqtV4a0WbF0Li9IC6O9OpXl6Zt+WB0yfa2RTbxjYDls2VAOQ7rBIZWAci0SlwjWWDCjc=
X-Received: by 2002:a17:907:2125:: with SMTP id qo5mr39615957ejb.252.1626888585194;
 Wed, 21 Jul 2021 10:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLhqSpaTm3u4kFsnuZ0PLDKuX8wsxuF=vUJ1TEG0EP+L1g@mail.gmail.com>
 <alpine.LRH.2.02.2107200737510.19984@file01.intranet.prod.int.rdu2.redhat.com>
 <CAOuPNLhh_LkLQ8mSA4eoUDLCLzHo5zHXsiQZXUB_-T_F1_v6-g@mail.gmail.com> <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2107211300520.10897@file01.intranet.prod.int.rdu2.redhat.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Wed, 21 Jul 2021 22:59:33 +0530
Message-ID: <CAOuPNLi-xz_4P+v45CHLx00ztbSwU3_maf4tuuyso5RHyeOytg@mail.gmail.com>
Subject: Re: Kernel 4.14: Using dm-verity with squashfs rootfs - mounting issue
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>, dm-devel@redhat.com,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>, agk@redhat.com,
        snitzer@redhat.com, shli@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 21 Jul 2021 at 22:40, Mikulas Patocka <mpatocka@redhat.com> wrote:

> > >
> > > Try to set up dm-verity with block size 512 bytes.
> > >
> > > I don't know what block size does squashfs use, but if the filesystem
> > > block size is smaller than dm-verity block size, it doesn't work.
> > >
> > Okay thank you so much for this clue,
> > It seems we are using 65536 as the squashfs block size:
>
> 65536 is the compression block size - it is unrelated to I/O block size.
>
> There's a config option SQUASHFS_4K_DEVBLK_SIZE. The documentation says
> that it uses by default 1K block size and if you enable this option, it
> uses 4K block size.
>
Okay it seems this config is set in our case:
CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
So, with this the squashfs and dm-verity block size exactly matches (4K)

> So, try to set it. Or try to reduce dm-verity block size down to 1K.
>
Okay we are trying this.
Thank you so much!!

Regards,
Pintu
