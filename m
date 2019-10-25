Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38A3DE47CF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 11:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392312AbfJYJul convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Oct 2019 05:50:41 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46492 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390193AbfJYJul (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Oct 2019 05:50:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D6D99609D2DE;
        Fri, 25 Oct 2019 11:50:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R9fIw2k4BHWZ; Fri, 25 Oct 2019 11:50:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 62265609D2E3;
        Fri, 25 Oct 2019 11:50:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9B4V-bC5gA_0; Fri, 25 Oct 2019 11:50:37 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3D091609D2DE;
        Fri, 25 Oct 2019 11:50:37 +0200 (CEST)
Date:   Fri, 25 Oct 2019 11:50:37 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <1376825056.38827.1571997037107.JavaMail.zimbra@nod.at>
In-Reply-To: <CAJCQCtTU3NXrg=yVosYcj6F6NQLQ21hO3Xd=ta=JCZWjRUh8QQ@mail.gmail.com>
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com> <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com> <CAFLxGvwDraUwZOeWyGfVAOh+MxHgOF--hMu6P4J=P6KRspGsAA@mail.gmail.com> <CAJCQCtQhCRPG-UV+pcraCLXM5cVW887uX1UoymQ8=3Mk56w1Ag@mail.gmail.com> <854944926.38488.1571955377425.JavaMail.zimbra@nod.at> <CAJCQCtSsLRVPV3dn-XN1QgidVUC6pUrXDWDbtE2XhobKUo6fqA@mail.gmail.com> <1758125728.38509.1571956392152.JavaMail.zimbra@nod.at> <CAJCQCtTU3NXrg=yVosYcj6F6NQLQ21hO3Xd=ta=JCZWjRUh8QQ@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: Is rename(2) atomic on FAT?
Thread-Index: rgIWHHtPCqicZlJ44INz5Bg9KW6H9Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Chris Murphy" <lists@colorremedies.com>
> An: "richard" <richard@nod.at>
> CC: "Chris Murphy" <lists@colorremedies.com>, "Pali Rohár" <pali.rohar@gmail.com>, "linux-fsdevel"
> <linux-fsdevel@vger.kernel.org>
> Gesendet: Freitag, 25. Oktober 2019 11:22:17
> Betreff: Re: Is rename(2) atomic on FAT?

> On Fri, Oct 25, 2019 at 12:33 AM Richard Weinberger <richard@nod.at> wrote:
>>
>> ----- Ursprüngliche Mail -----
>> >> U-boot, for example. Of course it does not so for any filesystem, but whe=
>> > re
>> >> it is needed and makes sense.
>> >
>> > Really? uboot does journal replay on ext3/4? I think at this point the
>> > most common file system on Linux distros is unquestionably ext4, and
>> > the most common bootloader is GRUB and for sure GRUB is no doing
>> > journal replay on anything, including ext4.
>>
>> For ext4 it does a replay when you start to write to it.
> 
> That strikes me as weird. The bootloader will read from the file
> system before it writes, and possibly get the wrong view of the file
> system's true state because journal replay wasn't done.

This can't happen. U-boot is strictly single threaded, no interrupts,
no nothing.

For the ext4 case in U-boot, it does a replay not to have clean file
system upon read but to not corrupt it upon write.

For UBIFS, for example, U-boot does a replay also before reading.
But it replays into memory. The journal size is fixed and known,
so no big deal.

>> > Yeah that's got its own difficulties, including the way distro build
>> > systems work. I'm not opposed to it, but it's a practical barrier to
>> > adoption. I'd almost say it's easier to make Btrfs $BOOT compulsory,
>> > make static ESP compulsory, and voila!
>>
>> I really don't get your point. I thought you are designing a "sane"
>> system which can tolerate powercuts down an update.
>> Why care about distros?
>> The approach with Linux being a "bootloader" is common for embedded/secure
>> systems.
> 
> I want something as generic as possible, so as many use cases have
> reliable kernel/bootloader updates as possible, so that fewer users
> experience systems face planting following such updates. Any system
> can experience an unscheduled, unclean shutdown. Exceptions to the
> generic case should be rare and pretty much be about handling hardware
> edge cases.

Don't forget UEFI updates. ;-)

Really, you can't have it all on a x86 system in such a generic way.

Thanks,
//richard
