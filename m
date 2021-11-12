Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7BB44E805
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Nov 2021 14:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhKLOBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Nov 2021 09:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbhKLOBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Nov 2021 09:01:46 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B113C061766
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 05:58:55 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id r12so38088360edt.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Nov 2021 05:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OzaSt1dTEwXnQfFV568DPDqxxZKhCtXnEKChhxAww5Y=;
        b=vY2SX+G2C7yg9GCvZZeJgGhZuqp4sXWtXTNEdAJRAGtZC/yXBVZJthziyw+xsnJjhS
         4WsIfaoxJDNVu83UM+OkWa5MuwRVJ+msSBLo64CGx8hJ3lpRhawo9g+Ve2NVy1c2rhrB
         kDQMxcdpoLg6Wa46HNSfIIJxa3ZaTs9Y/8w7nSXp38H9msXovRQGZYa+973PgYddBzf8
         4NsoNqOLfnMAZ0/at2r4BoCA3HLNGdMCxLkbAQR9xT62GNeV31yRJReKqEhdEikClY9I
         5GwXFHf1gus6AjMSjM+USzzbQCor/2uBH77MUkdeMCSw6CNEMe23mXje2AoVeG/6jrPO
         zn5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OzaSt1dTEwXnQfFV568DPDqxxZKhCtXnEKChhxAww5Y=;
        b=r9rGBa8iEMfY3Xip7vT+tohAIJwZfwepo64qIG0/eufeHQyxpTOHWH1/IDo3huFyUE
         95SCsLKSeQR76JWsLFSTV6PuPLqLQ2/seP7f+56SihzXeevLJobzLdRQmQqVd2OLIfVV
         PbSUB74paWEq8cU074y1WZJOdGd5bbI8K5JXbVYpGQUUsELPqU3oTGUhkRxrXGFHbWxG
         l6rAJYNrPvWRMUdw3pSyBNq97kvq55oq06YwxlViPRiZlahdaWZ1y2jzyzm5uJFUGvpr
         vow99SyVO8cJlQf9GKVxBYXBs379C4Sg87IDDUm4xcts3rviqsV4u5xFBf//k38sz06p
         jrWA==
X-Gm-Message-State: AOAM532DU2PaWmRs2H5gKUtAHs4G1h4Wjb0hTXIZhIU2QHmULhlaYRVz
        blP/828yWvtL8ExYdHxxT6eKDj/wvxDwKbLCeflHwA==
X-Google-Smtp-Source: ABdhPJxuEbX4C17B+G90OqW0eXG0c/AcsR9xxm2XLE3sU96n9kkkpyD5qlmx1r7KC6ejShM/YyWGdNH2dmWmD8Z6FuY=
X-Received: by 2002:a17:906:12db:: with SMTP id l27mr20466924ejb.244.1636725533848;
 Fri, 12 Nov 2021 05:58:53 -0800 (PST)
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
 <CAAEAJfBuut7VSbrrz6CxOC+Cke36eGGv8VUvfdbfLwvSBxOAAA@mail.gmail.com>
 <CAOuPNLjJMCyxK8mvnBo2aZQXSNqY47YeXCxWmtPECq-=csz6bQ@mail.gmail.com>
 <CAOuPNLghc1ktLrOEf8PN+snMB3QZG-LwzPbd3kGzrhGz8mEAVg@mail.gmail.com>
 <CAAEAJfDS3FK19xMs-7LcEjDe7Fx1XW6HZJGyb6Ff=zs2ZKHpJA@mail.gmail.com> <CAOuPNLiB5UogzjHqcwEf+HbLqB9QorQ1bU4qVdMSaSsE4taszw@mail.gmail.com>
In-Reply-To: <CAOuPNLiB5UogzjHqcwEf+HbLqB9QorQ1bU4qVdMSaSsE4taszw@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Fri, 12 Nov 2021 10:58:42 -0300
Message-ID: <CAAEAJfBsgfkqL0DXaBLRyR0VzLsof6z970J4=DawspPrbSpQ0w@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
To:     Pintu Agarwal <pintu.ping@gmail.com>
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

On Mon, 8 Nov 2021 at 10:51, Pintu Agarwal <pintu.ping@gmail.com> wrote:
>
> Hi,
>
>
> On Fri, 29 Oct 2021 at 22:18, Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> >
> > On Fri, 29 Oct 2021 at 13:13, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> > >
> > > Hi All,
> > >
> > > On Mon, 30 Aug 2021 at 21:28, Pintu Agarwal <pintu.ping@gmail.com> wrote:
> > > >
> > > > On Sun, 22 Aug 2021 at 19:51, Ezequiel Garcia
> > > > <ezequiel@vanguardiasur.com.ar> wrote:
> > > >
> > > > > In other words, IMO it's best to expose the NAND through UBI
> > > > > for both read-only and read-write access, using a single UBI device,
> > > > > and then creating UBI volumes as needed. This will allow UBI
> > > > > to spread wear leveling across the whole device, which is expected
> > > > > to increase the flash lifetime.
> > > > >
> > > > > For instance, just as some silly example, you could have something like this:
> > > > >
> > > > >                                | RootFS SquashFS  |
> > > > >                                | UBI block        | UBIFS User R-W area
> > > > > ------------------------------------------------------------------------
> > > > > Kernel A | Kernel B | RootFS A | RootFS B         | User
> > > > > ------------------------------------------------------------------------
> > > > >                                  UBIX
> > > > > ------------------------------------------------------------------------
> > > > >                                  /dev/mtdX
> > > > >
> > > > > This setup allows safe kernel and rootfs upgrading. The RootFS is read-only
> > > > > via SquashFS and there's a read-write user area. UBI is supporting all
> > > > > the volumes, handling bad blocks and wear leveling.
> > > > >
> > > > Dear Ezequiel,
> > > > Thank you so much for your reply.
> > > >
> > > > This is exactly what we are also doing :)
> > > > In our system we have a mix of raw and ubi partitions.
> > > > The ubi partitioning is done almost exactly the same way.
> > > > Only for the rootfs (squashfs) I see we were using /mtd/block<id> to
> > > > mount the rootfs.
> > > > Now, I understood we should change it to use /dev/ubiblock<id>
> > > > This might have several benefits, but one most important could be,
> > > > using ubiblock can handle bad-blocks/wear-leveling automatically,
> > > > whereas mtdblocks access the flash directly ?
> > > > I found some references for these..
> > > > So, this seems good for my proposal.
> > > >
> > > > Another thing that is still open for us is:
> > > > How do we calculate the exact image size from a raw mtd partition ?
> > > > For example, support for one of the raw nand partitions, the size is
> > > > defined as 15MB but we flash the actual image of size only 2.5MB.
> > > > So, in the runtime how to determine the image size as ~2.5MB (at least
> > > > roughly) ?
> > > > Is it still possible ?
> > > >
> > >
> > > I am happy to inform you that using "ubiblock" for squashfs mounting
> > > seems very helpful for us.
> > > We have seen almost the double performance boost when using ubiblock
> > > for rootfs as well as other read-only volume mounting.
> > >
> > > However, we have found few issues while defining the read only volume as STATIC.
> > > With static volume we see that OTA update is failing during "fsync".
> > > That is ota_fsync is failing from here:
> > > https://gerrit.pixelexperience.org/plugins/gitiles/bootable_recovery/+/ff6df890a2a01bf3bf56d3f430b17a5ef69055cf%5E%21/otafault/ota_io.cpp
> > > int status = fsync(fd);
> > > if (status == -1 && errno == EIO)
> > > *
> > > { have_eio_error = true; }
> > > *
> > > return status;
> > > }
> > >
> > > Is this the known issue with static volume?
> > >
> >
> > I don't know exactly how you are updating your volume,
> > the right way is using UBI_IOCVOLUP.
> >
> > See http://www.linux-mtd.infradead.org/doc/ubi.html#L_volupdate
> >
> > If you google around I'm sure you'll find some articles about this,
> > but I'm not sure if they'll go into details and subtleties.
> >
> > There are probably a few different ways to do firmware upgrade
> > when you are on top of static volumes (and you want to be on top
> > of static volumes if it's read-only, because AFAIK they give you an
> > extra data-integrity guarantee).
> >
> > One way, would be to have two static volumes A/B. The system
> > uses normally the A volume, and then you doUBI_IOCVOLUP
> > (or ubiupdatevol) to update the B volume. After the update is succesful
> > you run the atomic volume rename and flip A->B, B->A.
> >
> > (If you don't have enough space to hold two A/B volumes....
> >  ... you'll have to find some other solution, I have no idea about that.)
> >
>
> Yes, this is what we are also doing exactly.
> But, currently we are running into this issue right now:
> 1) The FOTA update is failing if we use static volume (building and
> flashing the static image is fine)

Please add traces to find what syscall is failing, and provide more
details about it.

Thanks,
Ezequiel
