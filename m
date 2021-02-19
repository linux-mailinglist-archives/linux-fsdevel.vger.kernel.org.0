Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AAF31F35F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 01:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbhBSAkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 19:40:03 -0500
Received: from mout.gmx.net ([212.227.15.18]:35661 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBSAkD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 19:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1613695054;
        bh=pInc6uPG7HB09z6ZvJFfn7PDeFmncjM6F/Zg1GnOzKo=;
        h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
        b=ecR9l4bGetmsuPDvxFh93ZR09Ij/zPFLISy/fEKChwk1LgjSqnTm++dc2TTco3Ohl
         H+qSR8WDGkCT5cjuMavzKIJVvKO3O5fp/rOPUouaOcrA6V3bgTKF0TqI4mzDNddMpc
         rmepnXj9lgNuIpAT/+DQNStmvXuqDSmzzGJsGx7Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Md6Mj-1llPfZ0Mk7-00aFnI; Fri, 19
 Feb 2021 01:37:34 +0100
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
References: <1783f16d-7a28-80e6-4c32-fdf19b705ed0@gmx.com>
 <20210218121503.GQ2858050@casper.infradead.org>
 <af1aac2f-e7dc-76f3-0b3a-4cb36b22247f@gmx.com>
 <20210218133954.GR2858050@casper.infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: page->index limitation on 32bit system?
Message-ID: <e0faf229-ce7f-70b8-8998-ed7870c702a5@gmx.com>
Date:   Fri, 19 Feb 2021 08:37:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218133954.GR2858050@casper.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YD87Avkz+R8uz268iyEgTfqiD6799tgxDSeX8GinEBJb5pLPlju
 QM7rWz8ozpJig/G4c7lZ7W/1KHmQBl/8ji5C6up1OhlhM1jAHHV2xM7iaRH4bcI+mX7mRXO
 TDoLYeQpqRdNAVpCVJcpOs8OhyL3xI71nTzzdEaiERIw/Ur2SUKHXq9xSJltMAYOUxLgMOh
 W6o7f9ozcG/VbIpn5o6Rw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iAmBwf1UjLE=:0poaa+tpcFLvAXv4j84jMM
 FeBiEhlvXg9Cb6QFXPq/34NrMfV6j0jlUqCjqjUaO/fVbrn7vmNnrXYKO9YcpYsbxVcArp/3N
 Hv/0PakVJg1Vdj4QsfT/aA0Z9VTf3la8d18W7zMmi/4YnKUoPqrJpIqaV3MP/Wee3/stuFmDQ
 8Zml+VyIfH2+OlWjbjE1n5xww0XBK386+l1NBIApg7RG+Y7PnqalN76MsjJOMJhnKPW3Jr/Cg
 0+iIID3/UNUn/ZIEAqg7oPs7UEaQI69B7hLhU3QjD/67UshX3bfDa3FM1kbpbpk4vDpwdkOhz
 hCJizCELOgYblyL0E1GYGnKuJHuRDRYbpA9aJjY3/oXW1oOGf219iWtFlp7yjaPtgj7unB80Q
 ORS8gtgFvRNpnuuYbqwsq+CoxRfm3n1QpDmUU78UMJU7wdZ/GsQKW2RhSf4D2q1T7k8g6VYmw
 5W6X6fzPM0TotBh0oeEATlqHm1Z1mROEhchsjbW61frr7LwG+6+RTsrEDDR2fa89Xn/vL+Aol
 ZOwGvUyc/U60IE15PadP4vhdWqdrhZX4JFv2DF99saxJq6ydfRh0Yk0Idtb7XYiMeaG8iEprr
 Lc+uEomt+ajfuYvZaPverRk4sRRpKZOgQkqDsaQu2U+0eMafwMuC+53NWp6gtijsmjvrrFtgK
 wW/kFE4hzDKK2dtJyXPzrUli1xPL/5ZAfnax/Qr+GBGhL/QDbhAObOllv2nOwPgvRrsvnlebn
 x8mjRXeLMyBDoobQsKP5jIgFFBF/3N2BKO3tJtca/GN/aXa0Evob6UyjSTNL5G8Oxd66+h/WD
 ZfuIrVRBSW4D32bgfT6w9Ur4o6d0KX9REl5QSqlXTfQhRr90uPaAYyHKoNbmVYndvZN9ua+qu
 yX0mYaYrvhIB83zcVjRQ==
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2021/2/18 =E4=B8=8B=E5=8D=889:39, Matthew Wilcox wrote:
> On Thu, Feb 18, 2021 at 08:42:14PM +0800, Qu Wenruo wrote:
>> On 2021/2/18 =E4=B8=8B=E5=8D=888:15, Matthew Wilcox wrote:
>>> Yes, this is a known limitation.  Some vendors have gone to the troubl=
e
>>> of introducing a new page_index_t.  I'm not convinced this is a proble=
m
>>> worth solving.  There are very few 32-bit systems with this much stora=
ge
>>> on a single partition (everything should work fine if you take a 20TB
>>> drive and partition it into two 10TB partitions).
>> What would happen if a user just tries to write 4K at file offset 16T
>> fir a sparse file?
>>
>> Would it be blocked by other checks before reaching the underlying fs?
>
> /* Page cache limit. The filesystems should put that into their s_maxbyt=
es
>     limits, otherwise bad things can happen in VM. */
> #if BITS_PER_LONG=3D=3D32
> #define MAX_LFS_FILESIZE        ((loff_t)ULONG_MAX << PAGE_SHIFT)
> #elif BITS_PER_LONG=3D=3D64
> #define MAX_LFS_FILESIZE        ((loff_t)LLONG_MAX)
> #endif
>
>> This is especially true for btrfs, which has its internal address space
>> (and it can be any aligned U64 value).
>> Even 1T btrfs can have its metadata at its internal bytenr way larger
>> than 1T. (although those ranges still needs to be mapped inside the dev=
ice).
>
> Sounds like btrfs has a problem to fix.

You're kinda right. Btrfs metadata uses an inode to organize the whole
metadata as a file, but that doesn't take the limit into consideration.

Although to fix it there will be tons of new problems.

We will have cases like the initial fs meets the limit, but when user
wants to do something like balance, then it may go beyond the limit and
cause problems.

And when such problem happens, users won't be happy anyway.
>
>> And considering the reporter is already using 32bit with 10T+ storage, =
I
>> doubt if it's really not worthy.
>>
>> BTW, what would be the extra cost by converting page::index to u64?
>> I know tons of printk() would cause warning, but most 64bit systems
>> should not be affected anyway.
>
> No effect for 64-bit systems, other than the churn.
>
> For 32-bit systems, it'd have some pretty horrible overhead.  You don't
> just have to touch the page cache, you have to convert the XArray.
> It's doable (I mean, it's been done), but it's very costly for all the
> 32-bit systems which don't use a humongous filesystem.  And we could
> minimise that overhead with a typedef, but then the source code gets
> harder to work with.
>
So it means the 32bit archs are already 2nd tier targets for at least
upstream linux kernel?

Or would it be possible to make it an option to make the index u64?
So guys who really wants large file support can enable it while most
other 32bit guys can just keep the existing behavior?

Thanks,
Qu
