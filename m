Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054813201A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 00:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbhBSXPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 18:15:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:48319 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbhBSXPE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 18:15:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613776403;
        bh=wvOPCiWgMDf9jsq9HINytbUHTX7GkfmeagtAJ1eEuQM=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=DOOuFFdoV0iuxagpeMceFJgQjw9wVBOkBj8sZaws5AMsHDLCE4lsz13u9HX+KSzPU
         cdTDAXUZ4e6TODofwe7VPQ0ugEzA42n6GnbejkHmUQfoNo/aT6v230yrDKd50US/VI
         MJHNljCt/GABQczmPp15HzHqvwUKXAAto7BQCP1U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N3siG-1lvLEo3hYG-00zpC2; Sat, 20
 Feb 2021 00:13:23 +0100
Subject: Re: page->index limitation on 32bit system?
To:     Matthew Wilcox <willy@infradead.org>,
        Erik Jensen <erikjensen@rkjnsn.net>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <927c018f-c951-c44c-698b-cb76d15d67bb@rkjnsn.net>
 <20210219142201.GU2858050@casper.infradead.org>
 <20210219175108.GV2858050@casper.infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Message-ID: <9ff87076-17c5-ba44-a7f4-2af31fe02144@gmx.com>
Date:   Sat, 20 Feb 2021 07:13:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210219175108.GV2858050@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WV44KSsJ7Wt9CoZUdXtvY1R6ez0igeuYoGDtmZKh8X9Ob89sBGP
 4hY0U7Z1PkjrEOuXVQsXS9MxHiOd8I1gCyB+MAoAdKrHlKCLVlnNCzZptTztiz7bJVSu1V2
 6/a1S77yC2R2SAdc1LR/C7gSUHadyQbJhi6aipm/+lopIxV/kWCIQ/LBXgvvB/CAAe4UuNT
 5QvZRM3kMc9svW/8J3Gzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hoKzQm078YM=:N25V4QBnN9dgRJ8OnBT7ri
 oDdV97nGUhSWZvvrYltsiL+r3LFKrm5GiKjfTVkyoN45+KLJemVZLABfmxFW29X5GuiDDyixU
 x9fk7nt1pfa5nZWznKnPmlwH97RYb9Z9uW1G6ojRFVIfyoe/7QXCSmwTMT69DQv1luBwBCmE+
 RQpyAZNuJ4c4BLv+R6Qm7tEqG41ExO2MDPigmxLXTm5edxpEL6hnZ+0S7f/UgPL0Za3KBqVhe
 501WqxtOCosIP7QIbwWQwmPb6ZIHaFNZH36p6+wU1A91kTrE0lR74HVA3PO6++x/IItJl/VIB
 4o24RgSbaHJ0VrrxbR29PLrwkLE92KUKnM28p+jG2DHddY8QE00JaYFjHw3Zw5lBeNRHrPkf7
 ubrYDHz7UjyVt61sKp/ZYFd/gspJ+cplEIYs4NRE5hd+cEyC1dFZElJUeRP2vlJ37aYsgZkWv
 UXiRg1uOyrxXvAOEYSQi0bWl9mP/NzJrEmWqFoPNwYUBtBwj6r8mOgqfEFwCntMOc88PwJFv8
 RyKHRsefcZdXzsZYof+KYzR122eL+M+4IjlBrYfurki/J0UaFqAvil20KQmCbYEptMRUUhVf4
 slvxyuW2IKPKqgjxAtQLLILE2550YcvVc7dBTWoWyL9TIS96dd+wQ1zdalSa4fDzjMycc/m97
 BYbio9jvk8kwjLv7t639qw8tO9J0+jQfqGntpB7VW5rgjKQcp9PiIEHVsrDhs3jHCZlGfmjJx
 TQTGO+rpHDVn/1To1vRiOUqH9ctVH1MiTdyT1Su5Fyx0Tly7Cy5WIXFVgMLhaxGyhtf66r4rB
 br0OcwfnTtxznewm5Yd7R2/uQhltWvf8IH/E+ibnFe4EaJcgSUu5JpEIa5hy9nunIAv3CpLBI
 PsZBHqdKllLt19OkZJCA==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/20 =E4=B8=8A=E5=8D=881:51, Matthew Wilcox wrote:
> On Fri, Feb 19, 2021 at 02:22:01PM +0000, Matthew Wilcox wrote:
>> In the last decade, nobody's tried to fix it in mainline that I know of=
.
>> As I said, some vendors have tried to fix it in their NAS products,
>> but I don't know where to find that patch any more.
>
> Arnd found it for me.
>
> https://sourceforge.net/projects/dsgpl/files/Synology%20NAS%20GPL%20Sour=
ce/25426branch/alpine-source/linux-3.10.x-bsp.txz/download
>
> They've done a perfect job of making the source available while making i=
t
> utterly dreadful to extract anything useful from.
>
>   16084 files changed, 1322769 insertions(+), 285257 deletions(-)

Wow, I thought RedHat was the only open-source vendor that tries to send
out a super big patch to make life of every other guys miserable.
And I'm definitely wrong now.

>
> It's full of gratuitous whitespace changes to files that definitely
> aren't used (arch/alpha?  really?) and they've stripped out a lot of
> comments that they didn't need to touch.
>
> Forward porting a patch from 10 years ago wouldn't be easy, even if
> they hadn't tried very hard to obfuscate their patch.  I don't think
> this will be a fruitful line of inquiry.
>
Yeah, I believe it's not worthy now.

I'll make btrfs to try its best to reject the fs instead.

Thanks,
Qu
