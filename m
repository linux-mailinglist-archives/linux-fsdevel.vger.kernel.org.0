Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4E513C866
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 16:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgAOPwc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 10:52:32 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:57647 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgAOPwb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:52:31 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MHG4c-1iw6Xd3h6e-00DJTn; Wed, 15 Jan 2020 16:52:30 +0100
Received: by mail-qk1-f172.google.com with SMTP id j9so16107856qkk.1;
        Wed, 15 Jan 2020 07:52:29 -0800 (PST)
X-Gm-Message-State: APjAAAVA1f2vTcfnXM0zsPyCU81xT4xBVoeAFP1pTfuRx4GmJcKTOral
        AKY7fHyBbhf96+NdSHfd30KbELP72alDGqm5wVk=
X-Google-Smtp-Source: APXvYqyGRd69VGhmXUx6e4teyjZqa0NYLVdbqN2FyC+i0ZdlSzOVavJ0u2B/XLAnvT0F0550ujfZyMpnj3oOoBBM23g=
X-Received: by 2002:a37:84a:: with SMTP id 71mr27099157qki.138.1579103548648;
 Wed, 15 Jan 2020 07:52:28 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200115082824epcas1p4eb45d088c2f88149acb94563c4a9b276@epcas1p4.samsung.com>
 <20200115082447.19520-1-namjae.jeon@samsung.com> <20200115082447.19520-10-namjae.jeon@samsung.com>
 <CAK8P3a3Vqz=T_=sFwBBPa2_Hi_dA=BwWod=L9JkLxUgi=aKNWw@mail.gmail.com>
 <CAKYAXd9_qmanQCcrdpScFWvPXuZvk4jhv7Gc=t_vRL9zqWNSjA@mail.gmail.com>
 <20200115133838.q33p5riihsinp6c4@pali> <CAK8P3a1ozgLYpDtveU0CtLj5fEFG8i=_QrnEAtoVFt-yC=Dc0g@mail.gmail.com>
 <20200115142428.ugsp3binf2vuiarq@pali> <CAK8P3a0_sotmv40qHkhE5M=PwEYLuJfX+uRFZvh9iGzhv6R6vw@mail.gmail.com>
 <20200115153943.qw35ya37ws6ftlnt@pali>
In-Reply-To: <20200115153943.qw35ya37ws6ftlnt@pali>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Jan 2020 16:52:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1iYPA9MrXORiWmy1vQGoazwHs7OfPdoHLZLJDWqu9jqA@mail.gmail.com>
Message-ID: <CAK8P3a1iYPA9MrXORiWmy1vQGoazwHs7OfPdoHLZLJDWqu9jqA@mail.gmail.com>
Subject: Re: [PATCH v10 09/14] exfat: add misc operations
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     Namjae Jeon <linkinjeon@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Christoph Hellwig <hch@lst.de>, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:S6ZEsT6whPDpodLWS5C/v6xe4qXptO7E7I36/HFhoLteqD60zXz
 Pc6bW5a3OyyL8LyNe9jf2lQX3Ax0Ffmv5tftXg7y85jpOQLgAKz/zWoQQjPqOBs3y0gKQ/Z
 eWgOu2BTN0WaOk3tHYoBDcGVBsMQ+zzlPd2DFjlQ8+v7/o/SCQAwsF2G0EEkqvYV5oS8w8f
 2LrjbvhzEodeuKJO6wM7g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XL8nm85kI74=:kDlDUKeQW/8k4eFOwF0MIt
 unCk3LtmTlOuSt5JAdR4XQ81fSdKdPkD07RW+1n0d8z/YKNDLUoHhSSbv/9Dp5lR5D02i6u02
 +tAPBeTSBzhZiMkhfcw3MwUCIJ/RLXK4laf0p4hAdXONQ513qdVST7p9r29NMsF1xRME+N6AW
 ZKBbzH9ZZAajRhjnWnXHbIWDWCWzWozDVRYM30FEJoT/ZRBQDSyDorvEgOmd8Pgu96GsLemGE
 aGeu5BNGg0s1CpIDoIJqqOx8Ll1mBva4fGwzSdfx5ude4dxGMQG+3tttjGH4V2GWPMA1UJfx4
 SliHA1QRuP1DyAQklkA+ktCsThk8/uId6ggRtHoAMd2TruJHiiLYWkvY+B6E7xPwx1CC6gMBz
 ptpK8J3Ze3ss64kNqonFLzg8E+/wXlI7RguIn/LZ9QCmzte3fn6YO9p3TGOg9pVMCQKbXT10m
 uFkelFjs7rVM6ezAZJo4Oo935XmcX0UNKe6xX9CFv98F1hIXgY/izM1F7j+DGwtUAJaim6kyp
 QGfLKuz5Pk1zm6nFB5fsYFEzgOKeJ68vDcv/6mc9zG3+EAgnJfg1xUOYvEJuATMa8G+Fb+eK7
 Xxpy0tKqSQuJkTskHKgw78G4sT7BecjAoNB8zcReB6HZZLEGetAINrLoNZYgTXl5EpijPi5qx
 X1aqIloNBmCL1mYkW9Qazl7Ve3tHWB68SSpH46VByJTk1eM2vVBk/xocw5VHrnyXwkNJkPClf
 7FgNdTHkiVc2J2mR4yqoxc0iDOVLbo8eWtgmQuEQHRORnT9dE+zkW2lebN1ePfQ/QQHyCMJ1Z
 996OJG8qeFtkS68Ja4bZ83bMLzY3m57y6USqp4w9HaMDUmxxUW9mZq3rlfTjl9yo46wcGVxpG
 BcUa2ROG9acicwginVkw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 15, 2020 at 4:39 PM Pali Rohár <pali.rohar@gmail.com> wrote:
> On Wednesday 15 January 2020 16:03:12 Arnd Bergmann wrote:
> > The vdso and kernel/time/ code are for maintaining the timezone through
> > settimeofday()/gettimeofday(), and the drivers should probably all be changed
> > to use UTC. The file systems (affs, fat, hfs, hpfs and udf) do this for
> > compatibility with other operating systems that store the metadata in
> > localtime.
>
> Ok. But situation for exFAT is quite different. exFAT timestamp
> structure contains also timezone information. Other filesystems do not
> store timezone into their metadata (IIRC udf is exception and also
> stores timezone). So question is in which timezone we should store to
> exFAT timestamps. This is not for compatibility with legacy systems, but
> because of fact that filesystem supports feature which is not common for
> other filesystems.
>
> Also, to make it more complicated exFAT supports storing timestamps also
> in "unspecified" (local user) timezone, which matches other linux
> filesystems.
>
> So for storing timestamp we have options:
>
> * Store them without timezone
> * Store them in sys_tz timezone
> * Store them in timezone specified in mount option
> * Store them in UTC timezone
>
> And when reading timestamp from exFAT we need to handle both:
>
> * Timestamps without timezone
> * Timestamps with timezone

Right.

> So what is the best way to handle timezone/timestamps?
>
> For me it looks sane:
>
> When storing use: mount option timezone. When not available then use
> sys_tz. And when sys_tz is not set (it is possible?), do not specify
> timezone at all. Maybe there should be a mount option which says that
> timestamps on exfat are stored without timezone.

I would argue we should always store files in UTC, which seems to be
the most consistent with other file systems, and can be understood
by any other implementation that understands the timezone information
on disk  or that expects UTC.

> When reading timestamp with timezone: Convert timestamp to timezone
> specified in mount option (or fallback to sys_tz or fallback to UTC).

Here I would just convert to UTC, which is what we store in the
in-memory struct inode anyway.

> And when reading timestamp without timezone: Pass it as is without
> conversion, ignoring all timezone mount options and sys_tz.
>
> Arnd, what do you think about it?

The last case (reading timestamp without timezone) is the only
one that I think we have to decide on: when reading an inode from
disk into memory, we have to convert it into UTC in some form.

This is what I think the timezone mount option should be used
for: if we don't know what the timezone was for the on-disk
timestamp, use the one provided by the user. However, if none
was specified, it should be either sys_tz or UTC (i.e. no
conversion). I would prefer the use of UTC here given the
problems with sys_tz, but sys_tz would be more consistent
with how fs/fat works.

    Arnd
