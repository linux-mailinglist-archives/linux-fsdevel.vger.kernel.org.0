Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2C648D024
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jan 2022 02:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231341AbiAMBah (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jan 2022 20:30:37 -0500
Received: from mout.gmx.net ([212.227.15.15]:40435 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231324AbiAMBag (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jan 2022 20:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642037424;
        bh=mq9bW3p6NpBcihXHvI0LYCV+TPIOfIHX8cNLcfu07Qc=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=XnaWLR2GBxueKieX89caOldRXQ9f9tflldJoi7Sh1VzxTqFv9msiLoSX3TgX9sfbV
         hv57TGWAIZAVXCtcPQplKt6t0lxGzMn3iNAnsff3gv0Z+yvUQuGkuaChgOMya2c7/t
         G4QoEt9qnNmcyVBxCWUfTtlddB0UwfQZr1ecaXlw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mel7v-1mX7DG1drR-00algE; Thu, 13
 Jan 2022 02:30:24 +0100
Message-ID: <d8a4ab1f-f6eb-06a3-cdf4-6122a6b3cbf6@gmx.com>
Date:   Thu, 13 Jan 2022 09:30:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-raid@vger.kernel.org
References: <0535d6c3-dec3-fb49-3707-709e8d26b538@gmx.com>
 <20220108195259.33e9bdf0@gecko> <20220108202922.6b00de19@gecko>
 <5ffc44f1-7e82-bc85-fbb1-a4f89711ae8f@gmx.com>
 <e209bfe191442846f66d790321f2db672edfb8ca.camel@infradead.org>
 <24998019-960c-0808-78df-72e0d08c904e@gmx.com>
 <20220112155351.5b670d81@gecko>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [dm-devel] Proper way to test RAID456?
In-Reply-To: <20220112155351.5b670d81@gecko>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UerDNmPKLlus2Pxmptpvr2B2Iop8EYbu1P0Fdu1O8neE5S59DYe
 xT6zzMRJR78JmWf1AmmWm9wYMi69yHPHtxpC73LPZ48//FarAODtB0yNZXkqFE9m0LjfdKy
 nywJDLgHAjmA1H9E6f8wi87Mt1hYOa9s5ibZP3Gx3VMlenhrhYbziZo1LhTg4fEYN1zCuiZ
 k4Wx9Vy423RxIH9tI9a2Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+n/mTaIWfEM=:RhhlemtXcANIxJfX7X6c26
 TZ5ZnwlVkKYxGafYznTogLzddIm9XwfAaZRc+ecS04UfvDGLLL8X6C2usQZ4ZHX1YB+mqsn2t
 UvLkN/v2TwTn7OeS6CK2b0FST5lqWWowJ0htmrZBxcpuo+GumBAJTvwBL6wQXDjrQesjReuM4
 C8EYUwDxyNqPcX3iFRT1alWdFGxKRxOqrRClFxya/PguqpIOsY4WX/DVbdLLyJ2xAzEMf08AN
 0wde98XxP22gzx5bi+ySQiasy6I+QG2RN549G74XAYQY1J1wXeO2iRZ7Y78+6o+FqxW/zZj9X
 1cRlds8fnISxX2ONVxMyAEdP6s5vm1gEGE0dcCMZG57F4ONf7432VsNVbNtGj/s1goHnG9BjD
 xuWhXf12tcYwx5F7blz/A4kdFhWFhN2oXN7ZW0uYZaPirk5TgNMemF78tqZd4K5hCPbHLFMh/
 vA4ij/mCGOmFCgRVsOOpsr9KeXBJo9rzx/0+JinDC88+3qXT/746SVv+Jv7JpdI1CPdUPK7pt
 fUspPLGw3kakqnp841LPxBUB5UZYNlRyPfhkhINbkUYT8LYvVXqpmxPUlkOb789e1YmCE7RBq
 z7iYfOfb0d+SXRa7owIdlghwfub4i5vyYnljMoR9ojSfqaOhXtRG2212DUzKWf0ZGrFRLzGS0
 cRbNq76LNw7G73T1A7icIuifxEI4jXuRw9UQuXuQdfWQ1gawCU8Zp32DUION2vA4/AQR/XWfF
 DXzbAS+p1ohdjh7OmaZKnxn5XsI1bFXVdwPB9W44ZmObNl2dbGWj11LBt6nQRLw2fNVRXG+us
 Bnx7pJH5GLstX9gI96+XEARquP6d4b0VYoz1F7DNfY7a8blAnuEiRlO8VlHWzAntp9n/RLjxe
 UpbCxktkfL5enSrkrgE6ZU7LT5SDzCVivCLOPnsXiXjTzLJBrelgMq10c6PeH23FylbjuAiSI
 Y/nfVfUZpcOYiPhHL8YBObWuz1Tj+/5qQtBQekzRC89OlEB+SkmLECZGvtYLt1Sb5oIlQOJXB
 ePcA7uOy9iZIM8BUhb3AAYGoqEUbks1WPxL9NZ4YcPXqKsqRrIKa1rJe5OJpoTHobmlE6LEhP
 KcCUr5mJn94XWc=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/1/13 00:56, Lukas Straub wrote:
> On Sun, 9 Jan 2022 20:13:36 +0800
> Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
>
>> On 2022/1/9 18:04, David Woodhouse wrote:
>>> On Sun, 2022-01-09 at 07:55 +0800, Qu Wenruo wrote:
>>>> On 2022/1/9 04:29, Lukas Straub wrote:
>>>>> But there is a even simpler solution for btrfs: It could just not to=
uch
>>>>> stripes that already contain data.
>>>>
>>>> That would waste a lot of space, if the fs is fragemented.
>>>>
>>>> Or we have to write into data stripes when free space is low.
>>>>
>>>> That's why I'm trying to implement a PPL-like journal for btrfs RAID5=
6.
>>>
>>> PPL writes the P/Q of the unmodified chunks from the stripe, doesn't
>>> it?
>>
>> Did I miss something or the PPL isn't what I thought?
>>
>> I thought PPL either:
>>
>> a) Just write a metadata entry into the journal to indicate a full
>>      stripe (along with its location) is going to be written.
>>
>> b) Write a metadata entry into the journal about a non-full stripe
>>      write, then write the new data and new P/Q into the journal
>>
>> And this is before we start any data/P/Q write.
>>
>> And after related data/P/Q write is finished, remove corresponding
>> metadata and data entry from the journal.
>>
>> Or PPL have even better solution?
>
> Yes, PPL is a bit better than a journal as you described it (md
> supports both). Because a journal would need to be replicated to
> multiple devices (raid1) in the array while the PPL is only written to
> the drive containing the parity for the particular stripe. And since the
> parity is distributed across all drives, the PPL overhead is also
> distributed across all drives. However, PPL only works for raid5 as
> you'll see.
>
> PPL works like this:
>
> Before any data/parity write either:
>
>   a) Just write a metadata entry into the PPL on the parity drive to
>      indicate a full stripe (along with its location) is going to be
>      written.
>
>   b) Write a metadata entry into the PPL on the parity drive about a
>      non-full stripe write, including which data chunks are going to be
>      modified, then write the XOR of chunks not modified by this write i=
n
>      to the PPL.

This is a little different than I thought, and I guess that's why RAID6
is not supported.

My original assumption would be something like this for one RMW
(X =3D modified data, | | =3D unmodified data)

Data 1:    |XXXXXXXXX|   |        |
Data 2:    |         |   |XXXXXXXX|
P(1+2):    |XXXXXXXXX|   |XXXXXXXX|

In that case, modified Data 1 and 2 will go logged into PPL for the
corresponding disks.
Then for P(1+2), only the modified two parts will be logged into the devic=
e.

I'm wondering if we go this solution, wouldn't it be able to handle
RAID6 too?
Even we lost two disks, the remaining part in the PPL should still be
enough to recover whatever is lost, as long as the unmodified sectors
are really unmodified on-disk.

Although this would greatly make the PPL management much harder, as
different devices will have different PPL data usage.


>
> To recover a inconsistent array with a lost drive:
>
> In case a), the stripe consists only of newly written data, so it will
> be affected by the write-hole (this is the trade-off that PPL makes) so
> just standard parity recovery.
>
> In case b), XOR what we wrote to the PPL (the XOR of chunks not
> modified) with the modified data chunks to get our new (consistent)
> parity. Then do standard parity recovery. This just works if we lost a
> unmodified data chunk.
> If we lost a modified data chunk this is not possible and just do
> standard parity recovery from the beginning. Again, the newly written
> data is affected by the write-hole but existing data is not.
> If we lost the parity drive (containing the PPL) there is no need to
> recover since all the data chunks are present.
>
> Of course, this was a simplified explanation, see drivers/md/raid5-ppl.c
> for details (it has good comments with examples). This also covers the
> case where a data chunk is only partially modified and the unmodified
> part of the chunk also needs to be protected (by working on a per-block
> basis instead of per-chunk).

Thanks for the detailed explanation.
Qu

>
> The PPL is not possible for raid6 AFAIK, because there it could happen
> that you loose both a modified data chunk and a unmodified data chunk.
>
> Regards,
> Lukas Straub
>
>>>
>>> An alternative in a true file system which can do its own block
>>> allocation is to just calculate the P/Q of the final stripe after it's
>>> been modified, and write those (and) the updated data out to newly-
>>> allocated blocks instead of overwriting the original.
>>
>> This is what Johannes is considering, but for a different purpose.
>> Johannes' idea is to support zoned device. As the physical location a
>> zoned append write will only be known after it's written.
>>
>> So his idea is to maintain another mapping tree for zoned write, so tha=
t
>> full stripe update will also happen in that tree.
>>
>> But that idea is still in the future, on the other hand I still prefer
>> some tried-and-true method, as I'm 100% sure there will be new
>> difficulties waiting us for the new mapping tree method.
>>
>> Thanks,
>> Qu
>>
>>>
>>> Then the final step is to free the original data blocks and P/Q.
>>>
>>> This means that your RAID stripes no longer have a fixed topology; you
>>> need metadata to be able to *find* the component data and P/Q chunks..=
.
>>> it ends up being non-trivial, but it has attractive properties if we
>>> can work it out.
>
>
>
>
> --
> dm-devel mailing list
> dm-devel@redhat.com
> https://listman.redhat.com/mailman/listinfo/dm-devel
