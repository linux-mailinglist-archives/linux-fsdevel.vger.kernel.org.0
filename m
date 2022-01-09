Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494D9488944
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Jan 2022 13:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbiAIMOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Jan 2022 07:14:01 -0500
Received: from mout.gmx.net ([212.227.15.19]:47973 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235456AbiAIMN7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Jan 2022 07:13:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641730424;
        bh=+rx5mLkm9BwtdUEjKaK+z7kikzpiDvrlMe6lNGEhH6Q=;
        h=X-UI-Sender-Class:Date:To:Cc:References:From:Subject:In-Reply-To;
        b=GYFnk3jH/5ygTr7joWhx9T6oTiffhCcHhtucu7f+34yaVdTP5+4mUfissLMBuyBQy
         ELHyZ5Mda1H5Oq3ei+/CMLasd8sh/ubTpVGJrpGemOysm2q9bbkmBeqNWAcUXp89bD
         MNVIXCKgqnqTNT3nvFt26WMCiK4VvKrHSFYbS3PM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N4hzZ-1mPC5I2jDT-011gcq; Sun, 09
 Jan 2022 13:13:44 +0100
Message-ID: <24998019-960c-0808-78df-72e0d08c904e@gmx.com>
Date:   Sun, 9 Jan 2022 20:13:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     David Woodhouse <dwmw2@infradead.org>,
        Lukas Straub <lukasstraub2@web.de>
Cc:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        linux-raid@vger.kernel.org
References: <0535d6c3-dec3-fb49-3707-709e8d26b538@gmx.com>
 <20220108195259.33e9bdf0@gecko> <20220108202922.6b00de19@gecko>
 <5ffc44f1-7e82-bc85-fbb1-a4f89711ae8f@gmx.com>
 <e209bfe191442846f66d790321f2db672edfb8ca.camel@infradead.org>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Re: [dm-devel] Proper way to test RAID456?
In-Reply-To: <e209bfe191442846f66d790321f2db672edfb8ca.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jlQVE+/r/IvUTXjokf8+aq7uOR3bDJoMLsEaBgeBjLYkxXW32iE
 talm/Gipi7vJPC0kMgJyyH/90wROMReJc6SiWTn5JuLKf0RGBKt2vruvQ5up6fTIG3mtdDe
 lVCGC8akgMUa5tDZ7+kZett74J/bg7M9UYlJ0Ui+mLgfNoTHaMs0VltUb/cGReKZ5f0sFSR
 VQDWLWHapZFjTSIxih13g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:lerS60OMhpE=:8KHikiXVrIUJHyw+qLIUlE
 8IEKKv3A6+ovrl9UkYTrZg0UFW8GKl58Iv6OydPHF9cUvTIVlJff8k9nrb6jXet69J3v2Q5Dm
 01ac8tiZuA881CQbSJxG1ChktFZO+yaA8arJWfu+7YfX1qDTdjzf1ku6a2YDgHn+4PjzBYQJb
 73xnKCKqraCKw3mr0048B9GBoO1SKABv+MxY3savkzXsJ4oB9Ur6LOq/JClld2UBACQGQUZWa
 T47zhpnRvFNsFZ2c6T1cP1PwF9MsjtGowltqdBhI5ZXkNKvowWYORbwV3q5Yy+xi5i2r9fWcZ
 GcdFNYzHZfmcv4fkskladM8jjYqP7rUd0+icJyMGUE1otPWBcequQRr58dXCx1WyxuuTrRwTk
 evHCxlxhX24dSSy9ZBI4YStpmI8yGfsEBJH0sZXh5MX5qBQzDt0zU00n+9dWiVbOJop1mv6KJ
 ir0VNyxn5pnlLzU3rUpFfFGNoT99yw/mw42GGKSxIK9bDgX6FuVWb6A1kGp36IhEYrusGqUfS
 T+LCpO2UH2+wZK1r/l9AmxkSUuBXZBUnwLjV8iFj2oxcbLlUrjJu2AW0SPHiRJj0f80fGGQI5
 mNukyhhgIkH/fsly4hLHqIJZhqreK/Cw/R3/b2UQ8D66kPetnkoI+QwFQ77EFny1gLoIeGpJ7
 Vmzm5HwVq7j8atO8R3muuyzuUHbJBES09iSTqEvumuahhO28NGldDQ6Sw8z1vbwGtdy2o/Xjn
 iNIZphSf4i1wF7o0YXLWKUGwS4VCKmwCvq9q+IqVxWBHj+E3eZe3/ghwK6qn4dDvHT/E+fZ/y
 T3tByuc+UeuWiSNugUHlUWvfZCcMeGhO5Z28pH/ouIxnkzyS1iMT6x3yZBdh+ptIb4TnIEdiB
 ZwEPefLtfowVZ93zVtfcXJTjpk3lk2bzYHe4O8rWqWtN0/sZbjriLhPwcJfzmcQA0hvHn8Sbd
 9v/Ie24Y1iMiDFlo6b89g/DezxvqzLnq8Tl/BdYWEjtrc+ZItmtnMuHbfwo34ffIqBYMDYYhQ
 UhAcfVaj5HwPuQhtNpQuCO6Uvr0Va6klVuhY3jlvxPUORXGvv/odw82RpmrME0Q1rdlJA2jGv
 up7MPEA5+KlJVM=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 2022/1/9 18:04, David Woodhouse wrote:
> On Sun, 2022-01-09 at 07:55 +0800, Qu Wenruo wrote:
>> On 2022/1/9 04:29, Lukas Straub wrote:
>>> But there is a even simpler solution for btrfs: It could just not touc=
h
>>> stripes that already contain data.
>>
>> That would waste a lot of space, if the fs is fragemented.
>>
>> Or we have to write into data stripes when free space is low.
>>
>> That's why I'm trying to implement a PPL-like journal for btrfs RAID56.
>
> PPL writes the P/Q of the unmodified chunks from the stripe, doesn't
> it?

Did I miss something or the PPL isn't what I thought?

I thought PPL either:

a) Just write a metadata entry into the journal to indicate a full
    stripe (along with its location) is going to be written.

b) Write a metadata entry into the journal about a non-full stripe
    write, then write the new data and new P/Q into the journal

And this is before we start any data/P/Q write.

And after related data/P/Q write is finished, remove corresponding
metadata and data entry from the journal.

Or PPL have even better solution?
>
> An alternative in a true file system which can do its own block
> allocation is to just calculate the P/Q of the final stripe after it's
> been modified, and write those (and) the updated data out to newly-
> allocated blocks instead of overwriting the original.

This is what Johannes is considering, but for a different purpose.
Johannes' idea is to support zoned device. As the physical location a
zoned append write will only be known after it's written.

So his idea is to maintain another mapping tree for zoned write, so that
full stripe update will also happen in that tree.

But that idea is still in the future, on the other hand I still prefer
some tried-and-true method, as I'm 100% sure there will be new
difficulties waiting us for the new mapping tree method.

Thanks,
Qu

>
> Then the final step is to free the original data blocks and P/Q.
>
> This means that your RAID stripes no longer have a fixed topology; you
> need metadata to be able to *find* the component data and P/Q chunks...
> it ends up being non-trivial, but it has attractive properties if we
> can work it out.
