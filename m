Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7313CF5AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jul 2021 10:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhGTHVk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Jul 2021 03:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhGTHVe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:21:34 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19E9C061574;
        Tue, 20 Jul 2021 01:02:08 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dt7so32985701ejc.12;
        Tue, 20 Jul 2021 01:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2edD4ZbIoOM5dgV01Aj0vA4z3mEuf8snofuXl1oXreo=;
        b=d95LEuqAdqoJ9ACA/94Go38gEhST2eZd9Qx7/4ma9tR1Saj3T7L/Y+GORjnWGEU2Sc
         6YdawSAlWqwyZ/nn/11TgzaXx+BGOkrn6/HgBuqjebbxfyRnv1j0dVnGA1npVHdvkLT+
         s2ZmXIh5mUvzoygiu+4tjVL8u3Bzy8HPhS1eL4I0Msh0Y9vuUoso1Y3m73iRSX7F5ids
         8I8hukdpPLqX98oT7NZ6zuS5Mz8cAO9D8WvR4w8m2xt9aH2T/mxHeHaDhvZ3suOTOuLB
         6cRgdBqQsqlCriqA73Sf7YzK6Ayx/kejohpedHFCUyaAHRJz26BTM7mRFWR+h4izZ0I3
         O5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2edD4ZbIoOM5dgV01Aj0vA4z3mEuf8snofuXl1oXreo=;
        b=GxE+HNvX6mfX7j8rXcESECcdzx3KI4wevhiMTSo6lcvlqmdNTYUdhZWUDwfNxZFML6
         nXH5E+yoN/mcqxgy21ZuPEMcTZFXavp3u1UyK7dSST8gahFyEeWCuRHLRUuVvJicUeDe
         9kEbh1cs6ucEhX7rs41ohTFX1FArnshcnYTSnPMUO1XAnyYVgwOT3/Z1VkZ7O+PhMRzk
         UxLgHqkAJqubZyUUCHqGVz5SrKRfoVBGPXi842rykvsVUvCdBHEZ8/lDa/m8ep0XC8qS
         v49hBb7UP9iOcF8/vmVUX54W/lfCSrVWIub5WHoWNtwzU/1lT/tIlIgTgocspOIu8eN6
         5AuA==
X-Gm-Message-State: AOAM531ttyq1q2RyFi+faYC1dEjk+zbnaUJq3uG7izxEM8Q7Pu+oopRV
        TtPPdAVxxwucvFGOn8wPz7pkTpokv1StZS7aLA8MH+wdjaQ=
X-Google-Smtp-Source: ABdhPJyO9ZvIDN2d6vogWARmI2N8r8z5KnWcZOZsKssnZq9MdMiE9SwxK57GIk2vAlTtMjpmt6tqwyPg5BbH3zAiNBs=
X-Received: by 2002:a17:906:6050:: with SMTP id p16mr22033077ejj.43.1626768127286;
 Tue, 20 Jul 2021 01:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <YPGojf7hX//Wn5su@kroah.com> <568938486.33366.1626452816917.JavaMail.zimbra@nod.at>
 <CAOuPNLj1YC7gjuhyvunqnB_4JveGRyHcL9hcqKFSNKmfxVSWRA@mail.gmail.com>
 <1458549943.44607.1626686894648.JavaMail.zimbra@nod.at> <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at>
In-Reply-To: <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 20 Jul 2021 13:31:55 +0530
Message-ID: <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Richard Weinberger <richard@nod.at>
Cc:     Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 20 Jul 2021 at 12:10, Richard Weinberger <richard@nod.at> wrote:

> > Anyways, I will create a separate thread for dm-verity issue and keep
> > this thread still open for UBI image size issue.
> > We may use dm-verify for rootfs during booting, but still we need to
> > perform integrity check for other nand partitions and UBI volumes.
> >
> > So, instead of calculating the checksum for the entire partition, is
> > it possible to perform checksum only based on the image size ?
> > Right now, we are still exploring what are the best possible
> > mechanisms available for this.
>
> I still don't fully understand what you are trying to achieve.
> Is it about cryptographic integrity of your storage or detecting
> errors after the flashing process?
>
Yes, it is about md5 checksum verification for every partition to
check its integrity before updates.


> But let me advertise ubiblock a second time.
Sorry, I could not understand about the ubiblock request. Is it
possible to elaborate little more ?
We are already using squashfs on top of our UBI volumes (including
rootfs mounting).
This is the kernel command line we pass:
rootfstype=squashfs root=/dev/mtdblock44 ubi.mtd=40,0,30
And CONFIG_MTD_UBI_BLOCK=y is already enabled in our kernel.
Do we need to do something different for ubiblock ?

> If you place your squashfs on a UBI static volume, UBI knows the exact length and you can checksum it
> more easily.
Yes, we use squashfs on UBI volumes, but our volume type is still dynamic.
Also, you said, UBI knows the exact length, you mean the whole image length ?
How can we get this length at runtime ?
Also, how can we get the checksum of the entire UBI volume content
(ignoring the erased/empty/bad block content) ?

Or, you mean to say, the whole checksum logic is in-built inside the
UBI layer and users don't need to worry about the integrity at all ?


Thanks,
Pintu
