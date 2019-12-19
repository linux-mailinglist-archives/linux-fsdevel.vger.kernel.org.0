Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB551261CF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 13:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfLSMPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 07:15:23 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:49619 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726668AbfLSMPW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:15:22 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MirfG-1i5ZgJ30Vg-00exGF; Thu, 19 Dec 2019 13:15:19 +0100
Received: by mail-qt1-f180.google.com with SMTP id q20so4865171qtp.3;
        Thu, 19 Dec 2019 04:15:19 -0800 (PST)
X-Gm-Message-State: APjAAAU2ozyKe1HKrRDr4/+bTdOo+BZBhvLR0n6tXjhJH6yTp66+ccmq
        959YKNQhp8FJOjifitsupAIvhcWUxa37I12tWjs=
X-Google-Smtp-Source: APXvYqzBJaTMUPYhRE1yI60oc1+7sq5M0T66IfZX2Nf0hnuyPkKbQDZSiXOuH7DY+joNcZzsJrZtnzD3uIY4JdbWGfE=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr6556062qtr.142.1576757718254;
 Thu, 19 Dec 2019 04:15:18 -0800 (PST)
MIME-Version: 1.0
References: <20191217221708.3730997-1-arnd@arndb.de> <20191217221708.3730997-22-arnd@arndb.de>
 <5826d31fcf2fcbe25bf2396e32df3df7d585dd99.camel@codethink.co.uk>
In-Reply-To: <5826d31fcf2fcbe25bf2396e32df3df7d585dd99.camel@codethink.co.uk>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Dec 2019 13:15:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3W+5RTa5jTunotZyV=hgXTxJaPqz_5kJnsdbvSZZPmjg@mail.gmail.com>
Message-ID: <CAK8P3a3W+5RTa5jTunotZyV=hgXTxJaPqz_5kJnsdbvSZZPmjg@mail.gmail.com>
Subject: Re: [PATCH v2 21/27] compat_ioctl: move cdrom commands into cdrom.c
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TEDryguOcCH9gogHQGldrcRHNWTpgeIL8C4kJi51MAPgG/9mxVV
 Rk3wyzHd4pGTUXGPm2w/KXpFoRl43u8nPX2/oMroULIcXjY9TW1HJ8+ygH5Hena4Ea+klC/
 9xXvZTGMjge1E86DPJTR5zSKBekB4VK7nHCTJ0fWNP93pB2DSfeoKhOfg4w80WRMn3lqAzp
 4vNVezU7c3PLFXQ4F3ixw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WMG3D85XS7Y=:kQOXUFqRvWoxbmscz/tw+x
 6VSej/2D+FLv45TGznZknJYXn8O5k9WJO9YTvnQF9TteweSfCHkRGCSbCWU8/Y9rAqKBgOz0J
 X8xlJ6Cp21no9Zr+4GoOrHlIzW4sMFuklW2xxXixLrMA4rTnCWOzaC0xwhkDA6NygdyuFLEpN
 3lnEONQ3v3NTTsZEwt9u+Knpa9C/aFjfwCjnntsDtQpq13qzRSN5nzu1wRU27RArdlHnGhB4i
 0y7jVtJBLN+WXK560KgN1PZR6LgPUh15HgEgvVtVxRUmVCEzkmCf/gRKt3ZvvkUiP3nhyc8W9
 gr2LMIYImwZgl7wNuiDBX2SvX2mJ8v7AKlMcnfnD84f8lET3kyk8PIBzzmHMQbLCOtB8nZlA+
 9E9VyiSPQnUGbq7DJywUAAsSl6xrrTueXIysBtCgpcKAtHaAS30elfaodA19qKXrmhtBLw6HE
 Gs+hIwWWJB3WlfkYtM236Bfwg6JIcdSMUelzXzc5N91CeYUpJrp2I4/9x/xOPbax6++9YMvBF
 nGvOfYDDgo6Ee53pQ5++Y2fmbnQ9i00u4ADJhxaGdkl3JCSn36S6Ou6wZB6IDFIfTH4/KfT+o
 L6uXkkF0Vlf7UfbYQOVp1SEcgVftSRC9PthPNcFG2fD6QmfybeidkM8CaN8ZuPF1Ko3ZM/V9Y
 uLUzxJVynaZjQs7K6rKeEEQ4HE9Tl6QNOUypxmlmjI+tU9bwwh3DaPI8LDREoXJ63wV0Ob7sh
 RMq9+1xDIVSwqS2bTm2GgMbcWWQmHq1n0lxqmen+SO24j8xBjXOaTNISHwWmStR83PsxJyi2+
 k/unNOVE+XZ+5vhmJ55fYzAdp3wic/xZqYvy4fE/+K1vPyPdeRbfPA04kgA6LvszgkaZhA7Pz
 2sbCKfQ8sZA9MhpOCuUg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 18, 2019 at 9:11 PM Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
>
> On Tue, 2019-12-17 at 23:17 +0100, Arnd Bergmann wrote:
> [...]
> > @@ -1710,6 +1711,38 @@ static int idecd_ioctl(struct block_device *bdev, fmode_t mode,
> >       return ret;
> >  }
> >
> > +#ifdef CONFIG_COMPAT
> > +static int idecd_locked_compat_ioctl(struct block_device *bdev, fmode_t mode,
> > +                     unsigned int cmd, unsigned long arg)
> > +{
> > +     struct cdrom_info *info = ide_drv_g(bdev->bd_disk, cdrom_info);
> > +     int err;
> > +
> > +     switch (cmd) {
> > +     case CDROMSETSPINDOWN:
> > +             return idecd_set_spindown(&info->devinfo, arg);
> > +     case CDROMGETSPINDOWN:
> > +             return idecd_get_spindown(&info->devinfo, arg);
>
> compat_ptr() should also be applied to the argument for these two
> commands, though I'm fairly sure IDE drivers have never been useful on
> s390 so it doesn't matter in practice.

Agreed on both, fixed by folding in this change:

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 2de6e8ace957..e09b949a7c46 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1716,19 +1716,20 @@ static int idecd_locked_compat_ioctl(struct
block_device *bdev, fmode_t mode,
                        unsigned int cmd, unsigned long arg)
 {
        struct cdrom_info *info = ide_drv_g(bdev->bd_disk, cdrom_info);
+       void __user *argp = compat_ptr(arg);
        int err;

        switch (cmd) {
        case CDROMSETSPINDOWN:
-               return idecd_set_spindown(&info->devinfo, arg);
+               return idecd_set_spindown(&info->devinfo, (unsigned long)argp);
        case CDROMGETSPINDOWN:
-               return idecd_get_spindown(&info->devinfo, arg);
+               return idecd_get_spindown(&info->devinfo, (unsigned long)argp);
        default:
                break;
        }

        return cdrom_ioctl(&info->devinfo, bdev, mode, cmd,
-                          (unsigned long)compat_ptr(arg));
+                          (unsigned long)argp);
 }

static int idecd_compat_ioctl(struct block_device *bdev, fmode_t mode,

Unfortunately the generic_ide_ioctl() call still needs an unconverted arg,
so I can't just use compat_ptr() to call the native idecd_locked_ioctl()
for all commands.

Thanks,

       Arnd
