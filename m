Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA180E3F55
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 00:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbfJXW1O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 18:27:14 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40567 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727635AbfJXW1O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:27:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id o28so154556wro.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Oct 2019 15:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1JypsBKLOsOLlry9td2kxCufkApYtkji+UGMdS/s4Y4=;
        b=lhwygGo7quWPEenCSlFpooat3g257nHbFyGADvYG9iwxwE+66eyTbY+vBdAc3LWB+9
         TOFak2CRAJZS5x3DDg42WlA+YS77Hz1guImNS7SkM9bsMoPAsY60uEsbIkxKU4OtMdk/
         lpCQ1dTGqNXvyXQfeY0/JYzn6CqnCtXBEiwkeUOEOyQHEYLn9mMfWSciSaZ69L96LY3u
         Shcvt2zgj+QWekIVSxY9SQDNdu72fA/8sKf31jU2tEXShqyafDYFA6fm6zUyVzVeTyTX
         zOzOLCn7x5m42KgODC4ZPfGFGQmIa+P6g92V/eopToCh1zWm8+JyfBF5x7KsDlUAO68N
         DJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1JypsBKLOsOLlry9td2kxCufkApYtkji+UGMdS/s4Y4=;
        b=dibmRDRNIk5EXwDWsHm7uFEX1b8d07WdM7g4IOymVEVvOYCu4LdUHWgw8LPRon3dh2
         kl9l507Yhz+xS4kSB7sHRy8+qFdM4piWLbG304xFeqe/llNalIHNcrlifzSuT9NVV+Gv
         suML7OQdXFQQIMQ47+qGLaRmx/OtTFeenDuIIXiZgnHZzM1nRR01+qOae4UfwR0zx94/
         HBGIDyPShFAorb6v2wXwGQaeQsTk929ajkmcScP1XNC6wNvyf8uzqM2Z2vD1dVDDP3g4
         2g+5n32ShsfpryX4/HVjFB2BD8tft7TqcdRdTeC/ubZygNUqHYQh2+CejWcUB/436xbQ
         04rw==
X-Gm-Message-State: APjAAAWGjOpU1sMh5vuLNqZKkz5ijXGehMpKzNmvo98WyMaiyfVfhbYI
        HMxuVB5lo/sJccBJmMHdpht8L4kmrrjzQAadS5UdHQ==
X-Google-Smtp-Source: APXvYqyK/JspKIIpOpmklDvz25DKb3T6ToujaEnI8CS1NA5vyKNhzmk1Zzwtm6baJZPPJ/9Z/RZFtRcG+g58yN5dX5Q=
X-Received: by 2002:a5d:4a8a:: with SMTP id o10mr5899583wrq.101.1571956029638;
 Thu, 24 Oct 2019 15:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com>
 <20191023115001.vp4woh56k33b6hiq@pali> <CAJCQCtTZRoDKWj2j6S+_iWJzA+rejZx41zwM=VKgG90fyZhX6w@mail.gmail.com>
 <20191023171611.qfcwfce2roe3k3qw@pali> <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com>
 <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com>
 <CAFLxGvwDraUwZOeWyGfVAOh+MxHgOF--hMu6P4J=P6KRspGsAA@mail.gmail.com>
 <CAJCQCtQhCRPG-UV+pcraCLXM5cVW887uX1UoymQ8=3Mk56w1Ag@mail.gmail.com> <854944926.38488.1571955377425.JavaMail.zimbra@nod.at>
In-Reply-To: <854944926.38488.1571955377425.JavaMail.zimbra@nod.at>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Fri, 25 Oct 2019 00:26:49 +0200
Message-ID: <CAJCQCtSsLRVPV3dn-XN1QgidVUC6pUrXDWDbtE2XhobKUo6fqA@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
To:     Richard Weinberger <richard@nod.at>
Cc:     Chris Murphy <lists@colorremedies.com>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(sorry, hate it when i rever to old habits and don't reply all)


> > On Thu, Oct 24, 2019 at 12:22 AM Richard Weinberger
> > <richard.weinberger@gmail.com> wrote:
> >>
> >> On Wed, Oct 23, 2019 at 11:56 PM Chris Murphy <lists@colorremedies.com=
> wrote:
> >> > Any atomicity that depends on journal commits cannot be considered t=
o
> >> > have atomicity in a boot context, because bootloaders don't do journ=
al
> >> > replay. It's completely ignored.
> >>
> >> It depends on the bootloader. If you care about atomicity you need to =
handle
> >> the journal.
> >> There are also filesystems which *require* the journal to be handled.
> >> In that case you can still replay to memory.
> >
> > I'm vaguely curious about examples of bootloaders that do journal
> > replay, only because I can't think of any that apply. Certainly none
> > that do replay on either ext4 or XFS. I've got some stale brain cells
> > telling me there was at one time JBD code in GRUB for, I think ext3
> > journal replay (?) and all of that got ripped out a very long time
> > ago. Maybe even before GRUB 2.
>
> U-boot, for example. Of course it does not so for any filesystem, but whe=
re
> it is needed and makes sense.

Really? uboot does journal replay on ext3/4? I think at this point the
most common file system on Linux distros is unquestionably ext4, and
the most common bootloader is GRUB and for sure GRUB is no doing
journal replay on anything, including ext4.


> Another approach is using Linux as bootloader and kexec another kernel.
> That way you can have a full filesystem implementation and bring the file=
system
> in a consistent state before reading from it.

Sure the one or more file systems must be assumed to be dirty already.
The EFI system partition on UEFI; and the FAT32 $BOOT on ARM; as well
as the more conventional /boot which is ext4. Those must be assumed to
be dirty with journal replay required. Yes they should have been
cleanly unmounted and thus journal replay not required, but what if
that's not the case? We can't really claim atomic updates in ideal
cases, but rather worst case scenario.

>
> >
> >> And yes, filesystem implementations in many bootloaders are in beyond
> >> shameful state.
> >
> > Right. And while that's polite language, in their defence its just not
> > their area of expertise. I tend to think that bootloader support is a
> > burden primarily on file system folks. If you want this use case
> > supported, then do the work. Ideally the upstreams would pair
> > interested parties from each discipline to make this happen. But
> > anyway, as I've heard it described by file system folks, it may not be
> > practical to support it, in which case for the atomic update use case,
> > the modern journaled file systems are just flat out disqualified.
> >
> > Which again leads me to FAT. We must have a solution that works there,
> > even if it's some odd duck like thing, where the FAT ESP is
> > essentially a static configuration, not changing, that points to some
> > other block device (a different partition and different file system)
> > that has the desired behavioral charactersistics.
> >
> >> > If a journal is present, is it appropriate to consider it a separate
> >> > and optional part of the file system?
> >>
> >> No. This is filesystem specific.
> >
> > I understand it's optional for ext3/4 insofar as it can optionally be
> > disabled, where on XFS it's compulsory. But mere presence of a journal
> > doesn't mean replay is required, there's a file system specific flag
> > that indicates replay is needed for the file system to be valid/cought
> > up to date. To what degree a file system indicating journal replace is
> > required, but can't be replayed, is still a valid file system isn't
> > answered by file system metadata. The assumption is, replay must
> > happen when indicated. So if a bootloader flat out can't do that, it
> > essentially means the combination of GRUB2, das uboot,
> > syslinux/extlinux and ext3/4 or XFS, is *proscribed* if the use case
> > requires atomic kernel updates. Given the current state of affairs.
> >
> > So that leads me to, what about FAT? i.e. how does this get solved on
> > FAT? And does that help us solve it on journaled file systems? If not,
> > can it also be generic enough to solve it here? I'm actually not
> > convinced it can be solved in journaled file systems at all, unless
> > the bootloader can do journal replay, but I'm not a file system expert
> > :P
>
> Like I mentioned above, use Linux as bootloader.
> Have a minimal Linux kernel which can do kexec and the journaling filesys=
tem
> of your choice.

Yeah that's got its own difficulties, including the way distro build
systems work. I'm not opposed to it, but it's a practical barrier to
adoption. I'd almost say it's easier to make Btrfs $BOOT compulsory,
make static ESP compulsory, and voila!


--=20
Chris Murphy
