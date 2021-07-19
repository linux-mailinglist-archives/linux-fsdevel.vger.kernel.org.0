Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 726393CD0C9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jul 2021 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhGSIrr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Jul 2021 04:47:47 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:50818 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234868AbhGSIrp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Jul 2021 04:47:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8799C6074005;
        Mon, 19 Jul 2021 11:28:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id mOx5PEkD266R; Mon, 19 Jul 2021 11:28:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0CBD06169BCD;
        Mon, 19 Jul 2021 11:28:15 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SIFyXQH69MuA; Mon, 19 Jul 2021 11:28:14 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id CCEAA6074005;
        Mon, 19 Jul 2021 11:28:14 +0200 (CEST)
Date:   Mon, 19 Jul 2021 11:28:14 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Pintu Agarwal <pintu.ping@gmail.com>
Cc:     Greg KH <greg@kroah.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Sean Nyekjaer <sean@geanix.com>,
        Kernelnewbies <kernelnewbies@kernelnewbies.org>
Message-ID: <1458549943.44607.1626686894648.JavaMail.zimbra@nod.at>
In-Reply-To: <CAOuPNLj1YC7gjuhyvunqnB_4JveGRyHcL9hcqKFSNKmfxVSWRA@mail.gmail.com>
References: <CAOuPNLjzyG_2wGDYmwgeoQuuQ7cykJ11THf8jMrOFXZ7vXheJQ@mail.gmail.com> <YPGojf7hX//Wn5su@kroah.com> <568938486.33366.1626452816917.JavaMail.zimbra@nod.at> <CAOuPNLj1YC7gjuhyvunqnB_4JveGRyHcL9hcqKFSNKmfxVSWRA@mail.gmail.com>
Subject: Re: MTD: How to get actual image size from MTD partition
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: How to get actual image size from MTD partition
Thread-Index: HGpmZleyphvaG4K0/EnAjW05MlN5eA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Pintu Agarwal" <pintu.ping@gmail.com>
> An: "richard" <richard@nod.at>
> CC: "Greg KH" <greg@kroah.com>, "linux-kernel" <linux-kernel@vger.kernel.org>, "linux-mtd"
> <linux-mtd@lists.infradead.org>, "linux-fsdevel" <linux-fsdevel@vger.kernel.org>, "Phillip Lougher"
> <phillip@squashfs.org.uk>, "Sean Nyekjaer" <sean@geanix.com>, "Kernelnewbies" <kernelnewbies@kernelnewbies.org>
> Gesendet: Montag, 19. Juli 2021 11:09:46
> Betreff: Re: MTD: How to get actual image size from MTD partition

> On Fri, 16 Jul 2021 at 21:56, Richard Weinberger <richard@nod.at> wrote:
> 
>> >> My requirement:
>> >> To find the checksum of a real image in runtime which is flashed in an
>> >> MTD partition.
>> >
>> > Try using the dm-verity module for ensuring that a block device really
>> > is properly signed before mounting it.  That's what it was designed for
>> > and is independent of the block device type.
>>
>> MTDs are not block devices. :-)
>>
> Is it possible to use dm-verity with squashfs ?
> We are using squashfs for our rootfs which is an MTD block /dev/mtdblock44

Well, if you emulate a block device using mtdblock, you can use dm-verity and friends.
Also consider using ubiblock. It offers better performance and wear leveling support.

Thanks,
//richard
