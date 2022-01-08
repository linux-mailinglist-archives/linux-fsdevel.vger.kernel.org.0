Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F0E488702
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jan 2022 00:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiAHXzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Jan 2022 18:55:31 -0500
Received: from mout.gmx.net ([212.227.15.19]:50579 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229974AbiAHXzb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Jan 2022 18:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641686128;
        bh=tLEqv6MN/iJ9BJHmdTUiojJfm2Ierwu//B8gxWLz8Gs=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=A+Nqieb36kpnfdNrD9Z24NfM8/o9IIn4fIbqfHttqEPcDP+z7qEZYqOxb/vtqr2KX
         A1BcYblkKK/nFBSgy657X/BK7W5ntEjfpkbqyFE/FF+RsP4oWj6LuVATLSxTrFxdzF
         VqbBlmYntw6x1GI9PHTh7DjKHivMYiPcKT6p45e4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MVvPD-1myx8k1kJR-00Ro3e; Sun, 09
 Jan 2022 00:55:28 +0100
Message-ID: <5ffc44f1-7e82-bc85-fbb1-a4f89711ae8f@gmx.com>
Date:   Sun, 9 Jan 2022 07:55:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [dm-devel] Proper way to test RAID456?
Content-Language: en-US
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        linux-raid@vger.kernel.org
References: <0535d6c3-dec3-fb49-3707-709e8d26b538@gmx.com>
 <20220108195259.33e9bdf0@gecko> <20220108202922.6b00de19@gecko>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
In-Reply-To: <20220108202922.6b00de19@gecko>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BVRGUUZIO9w0zpfZKPOWTlrdRKy2XP9MQupgHUM5oIewSBjhOs4
 svXluN/0+v3ESSi3sLWhSM0N0A9E2ysoTIY7HPb4OAT2PHYDcmuvIFAadI8HBL5jnLwetek
 LJC9VWzhP+VjyYCTQ/GDykKGquQwn8P3/UEftFjJ4zpTU2In8Gu+7lOk+BoC0vqHs3Hus75
 Pri2/mZl15MwyxoTis1Ag==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:t4ygZ1xfhRY=:aszCUv/cnRDUnUZaClUDKI
 C+B41B4hagqjTYzoIK/rB4p0hQHKl/Tsj2kG82o/qzDsCsUj2p9JvuFx5O83zvJtsE9GXUkbX
 6I6HdKEYqErfrFIJZS0ii3MPZt/cKJ5gGNIj2J2RiYmHmZLandyJogh5yRCQOip1dxsVgrxx5
 DyzkhBSuERhOzoVcMfuaQ+Q65jfoJDudpIO4mwS4aqtIUAtFJgL7yYLcLhrcSaX1wpeynX4Ya
 IomnefyPCUcu+otEiDPBG+Z0b59jKl8r/BfLzPLGuj1maP9LUkK5oPzmfPgUEZ+385/Fle72J
 A6mazlkmcKRt/Zj7eq8wwT8LeRt76JTDF4T19fUdkBirRikPxU51q8va55DlQdNO/RujgYXOx
 p7z/Bm99PuHHdX7tW4GWtyWE7mD/LLtdlSp5Ak+oLB7QH+8korUct+4jN8XfPYJ/E1bkDt52w
 0TbmqMFjo4R8+RaJj2IAKhDIIAjNzQQwdlvxJ+HxZdbwT6PXJ/w9g2oXWtkpup17/2pVmx1qA
 I2kFa+Q4PNaBr2rxJfUaJmsgQbwN7abbzSViHNahInEyw+8b/1FmJbOBQ2MbHitWWXtAdPDZ3
 cZKMrFefbJxmcxSJrSyPSJXQV6aB5AcNup4bq58pg8Pou0LCjQU+m3mG/MW7KmRDrI7OkPtNr
 hql7N+tqXVVtlYFXwangNq4XV+Fm29Ps1FDkBW6OeugGsVO9yIzGXmGUSppfbt2tAttf8zdwS
 FuLmjPL8Jzr9FozHceo/HZn4JxuF/Lh0eGkyYpNOWVH80F656Y8j7S2Q/hIbBr1CFrTgvejX2
 lo6DxNIG10nY1S7Kq2rJiV2twurjxc23tyWDM12NUEH0/7wVT45ZhKB5c6SYXSg2tj8Y+bHjP
 /fpIvtyuXMK/8JGTYwa/o+RWjDrWCzzlFUeoS7EPPPjR8phZ7yQ6tUOkIgWjaCalsCLXlihGM
 os9KHW6/WByumMkZlTzckWhtrFixMHFErUMRWn/ExYPALWTeQAMVQA4ZY2n/DJPSxkIxwbhNB
 M5SWbwViMizZYFgL8pLb30LSxDPvKs93FPjzlqxPNmzX0j2HJSo1ZDwomPR9gI5IKl0BaR7yN
 acBLXwFmCxbelI=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/1/9 04:29, Lukas Straub wrote:
> On Sat, 8 Jan 2022 19:52:59 +0000
> Lukas Straub <lukasstraub2@web.de> wrote:
>
>> CC'ing linux-raid mailing list, where md raid development happens.
>> dm-raid is just a different interface to md raid.
>>
>> On Fri, 7 Jan 2022 10:30:56 +0800
>> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>>
>>> Hi,
>>>
>>> Recently I'm working on refactor btrfs raid56 (with long term objectiv=
e
>>> to add proper journal to solve write-hole), and the coverage of curren=
t
>>> fstests for btrfs RAID56 is not that ideal.
>>>
>>> Is there any project testing dm/md RAID456 for things like
>>> re-silvering/write-hole problems?
>>>
>>> And how you dm guys do the tests for stacked RAID456?
>>>
>>> I really hope to learn some tricks from the existing, tried-and-true
>>> RAID456 implementations, and hopefully to solve the known write-hole
>>> bugs in btrfs.
>
> Just some thoughts:
> Besides the journal to mitigate the write-hole, md raid has another
> trick:
> The Partial Parity Log
> https://www.kernel.org/doc/html/latest/driver-api/md/raid5-ppl.html
>
> When a stripe is partially updated with new data, PPL ensures that the
> old data in the stripe will not be corrupted by the write-hole. The new
> data on the other hand is still affected by the write hole, but for
> btrfs that is no problem.
>
> But there is a even simpler solution for btrfs: It could just not touch
> stripes that already contain data.

That would waste a lot of space, if the fs is fragemented.

Or we have to write into data stripes when free space is low.

That's why I'm trying to implement a PPL-like journal for btrfs RAID56.

Thanks,
Qu

>
> The big problem will be NOCOW files, since a write to an already
> allocated extent will necessarily touch a stripe with old data in it
> and the new data also needs to be protected from the write-hole.
>
> Regards,
> Lukas Straub
>
>>> Thanks,
>>> Qu
>>>
>>>
>>> --
>>> dm-devel mailing list
>>> dm-devel@redhat.com
>>> https://listman.redhat.com/mailman/listinfo/dm-devel
>>>
>>
>>
>>
>
>
>
