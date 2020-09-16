Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C63026BDDA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 09:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbgIPHUn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 03:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPHUm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:20:42 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCD2C06174A;
        Wed, 16 Sep 2020 00:20:41 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id c13so7020492oiy.6;
        Wed, 16 Sep 2020 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=gNDte3S/hSJSnDsiYxZw5wA137HY+z+jEHhh9TJtTao=;
        b=DaVPipPxKVC/gpTyN4KR0Ctl7CZDyBwQcM9Rmnm/4InSTijDwaWf0Vco2v6n4CSJ6Q
         KKKbvNNex3CJlWu1d1MM+S8MIlQb9bd/i6kojeZyuFiA+VHPdDjOErfrfji8bfzK2uJZ
         xQ8/sy4/AAS4ZiyIzQfndXkDYKw5JKJR20AHIMywGpmMqw4xu3A7EwCG7xiLp+v0tFS3
         +aMHcdl2BWHd2RyIGv57lUVxYPKN1BthAxxnhQ8HB1J0GzoDcVkIm1UJwbPuthcIAxx0
         NfPbeCdHjmkoMiSPfcTTHE36lA19nRO7WSvV2Um4rvXqJH8iPVX3nTNmjxHZORHwamQw
         piDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=gNDte3S/hSJSnDsiYxZw5wA137HY+z+jEHhh9TJtTao=;
        b=nwN9lyWYshjFviQkLSCG36XA8NFoQFhv4uxXM29r99t+HksZ0dpCbqY7HG8GV6P/6F
         yooutSGetvtcnncXUgQu82nqgnMcNbklQTRr339bRKptjBEoMyNGwpuBzWrkV+yVt9FC
         A6Mw1w0TZd0l2+uinSKN/CsvTyJT7TVGd+aUJzNOCuKXm9Sfif2FEdU7BzRVj6V/d5fI
         Y83+UDIxZ92B7eNASEQKVVMZJ4wzHq3gXhuLnI3ShdUsOAbPmlHIXn+1ppW03wRqXCKS
         died0GrmYuwekXwIHlyOTv8rOxjSwsOebJdYPlQwy6M8DWv+XqO/hyfW9POYt8qH1GQz
         51VA==
X-Gm-Message-State: AOAM530HR8/sAJ0CYUHsEGl9Fvf5tNMyRBBmSEUw/S69K1Oc1Fc0koVO
        ad0Qdw1csAQfcsO97m4s74D5hmcu2a57dLFOaws=
X-Google-Smtp-Source: ABdhPJzCc4qEMzE7TrxvsA6at1VRtP+FuaH49XHiuaQTXtAbmKP+V/811S14rpYhTOZtkDssbc3AifK31Af+8j3a4uM=
X-Received: by 2002:aca:d409:: with SMTP id l9mr2094286oig.70.1600240840763;
 Wed, 16 Sep 2020 00:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200915160336.36107-1-colin.king@canonical.com> <65fbb23b-a533-aedb-75eb-69e1c53eaae9@redhat.com>
In-Reply-To: <65fbb23b-a533-aedb-75eb-69e1c53eaae9@redhat.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 16 Sep 2020 09:20:29 +0200
Message-ID: <CA+icZUVx8=6H4MrzPKWLc-xsFveuB-9JtzfnH=VpnwWg7mPjtQ@mail.gmail.com>
Subject: Re: [PATCH] vboxsf: fix comparison of signed char constant with
 unsigned char array elements
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Colin King <colin.king@canonical.com>,
        Christoph Hellwig <hch@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 8:16 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 9/15/20 6:03 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > The comparison of signed char constants with unsigned char array
> > elements leads to checks that are always false. Fix this by declaring
> > the VBSF_MOUNT_SIGNATURE_BYTE* macros as octal unsigned int constants
> > rather than as signed char constants. (Argueably the U is not necessarily
> > required, but add it to be really clear of intent).
> >
> > Addresses-Coverity: ("Operands don't affect result")
> > Fixes: 0fd169576648 ("fs: Add VirtualBox guest shared folder (vboxsf) support")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
>
> A fix for this has already been queued up:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/log/?h=fixes
>
> Explicit nack for this one, since it will still apply, but combined
> with the other fix, it will re-break things.
>

Hans, your patch is from 2020-08-25 and in a "fixes" Git branch of vfs
- why wasn't it applied to Linux 5.9?

- Sedat -

> Regards,
>
> Hans
>
>
>
> > ---
> >   fs/vboxsf/super.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
> > index 25aade344192..986efcb29cc2 100644
> > --- a/fs/vboxsf/super.c
> > +++ b/fs/vboxsf/super.c
> > @@ -21,10 +21,10 @@
> >
> >   #define VBOXSF_SUPER_MAGIC 0x786f4256 /* 'VBox' little endian */
> >
> > -#define VBSF_MOUNT_SIGNATURE_BYTE_0 ('\000')
> > -#define VBSF_MOUNT_SIGNATURE_BYTE_1 ('\377')
> > -#define VBSF_MOUNT_SIGNATURE_BYTE_2 ('\376')
> > -#define VBSF_MOUNT_SIGNATURE_BYTE_3 ('\375')
> > +#define VBSF_MOUNT_SIGNATURE_BYTE_0 0000U
> > +#define VBSF_MOUNT_SIGNATURE_BYTE_1 0377U
> > +#define VBSF_MOUNT_SIGNATURE_BYTE_2 0376U
> > +#define VBSF_MOUNT_SIGNATURE_BYTE_3 0375U
> >
> >   static int follow_symlinks;
> >   module_param(follow_symlinks, int, 0444);
> >
>
