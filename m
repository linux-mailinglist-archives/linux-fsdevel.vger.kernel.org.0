Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3CE44001A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 18:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhJ2QPi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 12:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhJ2QPi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 12:15:38 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2BCC061570;
        Fri, 29 Oct 2021 09:13:09 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z20so40717129edc.13;
        Fri, 29 Oct 2021 09:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0wvzHoUOEfSo0QpbymG71OXbWd0opNeWs5Mvq+1kJHs=;
        b=bttkRNnwDVZGZ/506wkfjbdj4MbdiwdXcjXepVjxY6RlXLPW0JoGna2rKlMRho/QsF
         CUboZ2XXsB1Gixrkq+Wryu8Rg7jOhaX1IVBA+rL/JcPi+TKwGxQrf52qrKOZ8Y64pMRr
         3hg34vj7Sac9UUVNkFkTA1EV5tXlrKo0p0HvyEcNTWpb5RFHAmGEp8NrqfCnQ/QpIU5i
         zDrxZ7aXNZP8XmPIEwbKxwD5tJ+A3tpuIVlm4HBmS9Cm7mUO+eUdBL1WthVMU2nWIzzS
         1RAT9OMIbeJS+KCOIFBrnbZRKuCpLbHE2GuwtlhUYh//TlOYv+kJEZaTPS5FMMOgY4+M
         VDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0wvzHoUOEfSo0QpbymG71OXbWd0opNeWs5Mvq+1kJHs=;
        b=rV2z28sEVMIPwx9JWCy1iZhq1qul4EoqQTsbG48pFOAu3i2DMTuW9esJMtMEIKg+N+
         7uCXtApoXP/PBewxUC35JPJAvly1ex9U/opPR5Ntg87izGR+FmnMNXa0xKY9WaVs788S
         fIc83ULQY7xtRUvjoOJhqSBK62OOYtECBdmlRWa7Bg6G9Qs42rkQVe+2EJ30nSKTzLv5
         T9s6FdJ4XcANdsOjNupeg2KDRZFw57iCEWg8f0CBREOXsebOWPaG/Fx9dLCojo9NUT3Y
         sEgwx+Ij02Q35XrpOqBxDDSsJm0TiDRpsp1SfWhtX4QEAUT3nOWbInbRPYy7sYXGzWMA
         Tj/Q==
X-Gm-Message-State: AOAM531hdjCVdVE8s5zh1A+gKBVzVheCc1cOCV6+0wfTXOyxxvqmEKQ5
        WUGtD7LRRi3TkgOofcd6U+BctoWkICijDRPLWCjsly/8qboe1g==
X-Google-Smtp-Source: ABdhPJzdQkG5B+bZTPGh0PQuLtcPMbFfSIS5r54brUfY+4yiYodQuzSWzST1ZdK4jctl+4Y+AjBBqCQU9lJF/eEi1yk=
X-Received: by 2002:a17:906:1db2:: with SMTP id u18mr14568403ejh.227.1635523987737;
 Fri, 29 Oct 2021 09:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com>
 <CAOuPNLh_KY4NaVWSEV2JPp8fx0iy8E1MU8GHT-w7-hMXrvSaeA@mail.gmail.com>
 <1556211076.48404.1626763215205.JavaMail.zimbra@nod.at> <CAOuPNLhti3tocN-_D7Q0QaAx5acHpb3AQyWaUKgQPNW3XWu58g@mail.gmail.com>
 <2132615832.4458.1626900868118.JavaMail.zimbra@nod.at> <CAOuPNLhCMT7QTF+QadJyGDFNshH9VjEAzWStRpe8itw7HXve=A@mail.gmail.com>
 <CAFLxGvywv29u6DJZrJxnJJmUDSQ4xpbT0u5LNKY1uGKyQom+WA@mail.gmail.com>
 <CAAEAJfCY+X-G=7Oe9NqrJ4yQZ29DBA78jOFAX44GD0g6=s7qhg@mail.gmail.com>
 <1668790824.35266.1627559144878.JavaMail.zimbra@nod.at> <CAAEAJfDDtGcUquyP7Jn0Urttt4kSfAQbJ_qPQ90ROtWLavW9EA@mail.gmail.com>
 <CAOuPNLj+DSigRY_AgHQnGKCK-Vm4ykQBR8UfnTi2UObORTcBFg@mail.gmail.com>
 <CAOuPNLgfJGzp-RJBjydFDL1ZAvOd7=-MgXhnsb2eb_xFSLC66w@mail.gmail.com>
 <CAAEAJfBuut7VSbrrz6CxOC+Cke36eGGv8VUvfdbfLwvSBxOAAA@mail.gmail.com> <CAOuPNLjJMCyxK8mvnBo2aZQXSNqY47YeXCxWmtPECq-=csz6bQ@mail.gmail.com>
In-Reply-To: <CAOuPNLjJMCyxK8mvnBo2aZQXSNqY47YeXCxWmtPECq-=csz6bQ@mail.gmail.com>
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Fri, 29 Oct 2021 21:42:56 +0530
Message-ID: <CAOuPNLghc1ktLrOEf8PN+snMB3QZG-LwzPbd3kGzrhGz8mEAVg@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     Richard Weinberger <richard@nod.at>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>,
        Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Sean Nyekjaer <sean@geanix.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi All,

On Mon, 30 Aug 2021 at 21:28, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> On Sun, 22 Aug 2021 at 19:51, Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
>
> > In other words, IMO it's best to expose the NAND through UBI
> > for both read-only and read-write access, using a single UBI device,
> > and then creating UBI volumes as needed. This will allow UBI
> > to spread wear leveling across the whole device, which is expected
> > to increase the flash lifetime.
> >
> > For instance, just as some silly example, you could have something like this:
> >
> >                                | RootFS SquashFS  |
> >                                | UBI block        | UBIFS User R-W area
> > ------------------------------------------------------------------------
> > Kernel A | Kernel B | RootFS A | RootFS B         | User
> > ------------------------------------------------------------------------
> >                                  UBIX
> > ------------------------------------------------------------------------
> >                                  /dev/mtdX
> >
> > This setup allows safe kernel and rootfs upgrading. The RootFS is read-only
> > via SquashFS and there's a read-write user area. UBI is supporting all
> > the volumes, handling bad blocks and wear leveling.
> >
> Dear Ezequiel,
> Thank you so much for your reply.
>
> This is exactly what we are also doing :)
> In our system we have a mix of raw and ubi partitions.
> The ubi partitioning is done almost exactly the same way.
> Only for the rootfs (squashfs) I see we were using /mtd/block<id> to
> mount the rootfs.
> Now, I understood we should change it to use /dev/ubiblock<id>
> This might have several benefits, but one most important could be,
> using ubiblock can handle bad-blocks/wear-leveling automatically,
> whereas mtdblocks access the flash directly ?
> I found some references for these..
> So, this seems good for my proposal.
>
> Another thing that is still open for us is:
> How do we calculate the exact image size from a raw mtd partition ?
> For example, support for one of the raw nand partitions, the size is
> defined as 15MB but we flash the actual image of size only 2.5MB.
> So, in the runtime how to determine the image size as ~2.5MB (at least
> roughly) ?
> Is it still possible ?
>

I am happy to inform you that using "ubiblock" for squashfs mounting
seems very helpful for us.
We have seen almost the double performance boost when using ubiblock
for rootfs as well as other read-only volume mounting.

However, we have found few issues while defining the read only volume as STATIC.
With static volume we see that OTA update is failing during "fsync".
That is ota_fsync is failing from here:
https://gerrit.pixelexperience.org/plugins/gitiles/bootable_recovery/+/ff6df890a2a01bf3bf56d3f430b17a5ef69055cf%5E%21/otafault/ota_io.cpp
int status = fsync(fd);
if (status == -1 && errno == EIO)
*
{ have_eio_error = true; }
*
return status;
}

Is this the known issue with static volume?

For now we are using dynamic volume itself but the problem is that
with dynamic volume we cannot get the exact image size from:
$ cat /sys/class/ubi/ubi0_0/data_bytes
==> In case of dynamic volume this will return the total volume size.
==> Thus our md5 integrity check does not match exactly with the
flashed image size.

Is there an alternate way to handle this issue ?


Thanks,
Pintu
