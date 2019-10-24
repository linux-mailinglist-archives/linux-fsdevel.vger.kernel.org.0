Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCDE0E3F65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2019 00:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbfJXWdP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Oct 2019 18:33:15 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:38794 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731152AbfJXWdO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Oct 2019 18:33:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AB08D616210E;
        Fri, 25 Oct 2019 00:33:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id nPSmY1q9GW68; Fri, 25 Oct 2019 00:33:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 57A5D60632C6;
        Fri, 25 Oct 2019 00:33:12 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id yLpP1SrFhWoP; Fri, 25 Oct 2019 00:33:12 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 38961616210E;
        Fri, 25 Oct 2019 00:33:12 +0200 (CEST)
Date:   Fri, 25 Oct 2019 00:33:12 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Chris Murphy <lists@colorremedies.com>
Cc:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Message-ID: <1758125728.38509.1571956392152.JavaMail.zimbra@nod.at>
In-Reply-To: <CAJCQCtSsLRVPV3dn-XN1QgidVUC6pUrXDWDbtE2XhobKUo6fqA@mail.gmail.com>
References: <CAJCQCtQ38W2r7Cuu5ieKRQizeKF0tf--3Z8yOJeeR+ZZ4S6CVQ@mail.gmail.com> <20191023171611.qfcwfce2roe3k3qw@pali> <CAFLxGvxCVNy0yj8SQmtOyk5xcmYag1rxe3v7GtbEj8fF1iPp5g@mail.gmail.com> <CAJCQCtTEN50uNmuSz9jW5Kk51TLmB2jfbNGxceNqnjBVvMD9ZA@mail.gmail.com> <CAFLxGvwDraUwZOeWyGfVAOh+MxHgOF--hMu6P4J=P6KRspGsAA@mail.gmail.com> <CAJCQCtQhCRPG-UV+pcraCLXM5cVW887uX1UoymQ8=3Mk56w1Ag@mail.gmail.com> <854944926.38488.1571955377425.JavaMail.zimbra@nod.at> <CAJCQCtSsLRVPV3dn-XN1QgidVUC6pUrXDWDbtE2XhobKUo6fqA@mail.gmail.com>
Subject: Re: Is rename(2) atomic on FAT?
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF60 (Linux)/8.8.12_GA_3809)
Thread-Topic: Is rename(2) atomic on FAT?
Thread-Index: U9uKUa4wcty9oxWfGZmqOkL7kbAJ2A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
>> U-boot, for example. Of course it does not so for any filesystem, but whe=
> re
>> it is needed and makes sense.
> 
> Really? uboot does journal replay on ext3/4? I think at this point the
> most common file system on Linux distros is unquestionably ext4, and
> the most common bootloader is GRUB and for sure GRUB is no doing
> journal replay on anything, including ext4.

For ext4 it does a replay when you start to write to it.
 
> Yeah that's got its own difficulties, including the way distro build
> systems work. I'm not opposed to it, but it's a practical barrier to
> adoption. I'd almost say it's easier to make Btrfs $BOOT compulsory,
> make static ESP compulsory, and voila!

I really don't get your point. I thought you are designing a "sane"
system which can tolerate powercuts down an update.
Why care about distros?
The approach with Linux being a "bootloader" is common for embedded/secure
systems.

Thanks,
//richard
