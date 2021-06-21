Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA253AF5CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jun 2021 21:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhFUTHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 15:07:35 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:56885 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbhFUTHe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 15:07:34 -0400
Received: from [192.168.1.155] ([95.118.106.223]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1N4NHS-1lEorF0b5S-011O8n; Mon, 21 Jun 2021 21:05:15 +0200
Subject: Re: [PATCH RFC] fuse: add generic file store
To:     Peng Tao <bergwolf@gmail.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Peng Tao <tao.peng@linux.alibaba.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>
References: <1622537906-54361-1-git-send-email-tao.peng@linux.alibaba.com>
 <YLeoucLiMOSPwn4U@google.com>
 <244309bf-4f2e-342e-dd98-755862c643b8@metux.net>
 <CA+a=Yy5moy0Bv=mhsrC9FrY+cEYt8+YJL8TvXQ=N7pNyktccRQ@mail.gmail.com>
 <429fc51b-ece0-b5cb-9540-2e7f5b472d73@metux.net>
 <CA+a=Yy6k3k2iFb+tBMuBDMs8E8SsBKce9Q=3C2zXTrx3-B7Ztg@mail.gmail.com>
 <295cfc39-a820-3167-1096-d8758074452d@metux.net>
 <CA+a=Yy7DDrMs6R8qRF6JMco0VOBWCKNoX7E-ga9W2Omn=+QUrQ@mail.gmail.com>
 <e70a444e-4716-1020-4afa-fec6799e4a10@metux.net>
 <CA+a=Yy4iyMNK=8KxZ2PvB+zs8fbYNchEOyjcreWx4NEYopbtAg@mail.gmail.com>
 <6d58bd0f-668a-983a-bf7c-13110c02dae0@metux.net>
 <CA+a=Yy5rnqLqH2iR-ZY6AUkNJy48mroVV3Exmhmt-pfTi82kXA@mail.gmail.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <65fc0313-b01b-9882-d716-d5a2911222b7@metux.net>
Date:   Mon, 21 Jun 2021 21:05:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CA+a=Yy5rnqLqH2iR-ZY6AUkNJy48mroVV3Exmhmt-pfTi82kXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:eLWtupr6NCKIa2Kdgs7Y8G0YhBfhvQIARXIyu/1uCa+I1ZwcSmB
 IElHIPy/tBmCzg8GbG1mjAewLwklGCKxknQeABrxduD0xAPgx58Mxe5mGhCF8j8XgmK5Kcf
 SPirsJt3VLyWtp/X5vdfab2mJ/BKb4FTbUEE7r39VAXL3fya1cYm6t8mRi5zuvpn40heNGw
 rfFRRYDCF9IU0TR1st1eg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tqv8DbPulr0=:6cTkXfBM3mHKRifENBfpfc
 dlKM6UcLTirnXZAlW3OCjtNrUoOVVdhvqTYw8BLTc7MKPBvCAWjVjk6S0GaRzsIqygCI9dI9Y
 WHTF9MogYwadFF9lo/I8hNjQq4eMK+lUST1LIgmnBl00KbJuCb7vFZDAORa+TFwNmdxiRdjZG
 C1k2CiisITuU3o+sIAL8vt66z/0uhDL9oQI37DZYj2sFqV0rK3dal7yBSDZsExpyfdAufTvCr
 fTTaQnKIgcT+/awFN8gKwWTqyWmJPK0bitjz5Fi3DT5PilR5XwLejuEzXyS9Ro91Xo96eQOfi
 jgCZpmxRNyTvIfCrIAHF2H7PXJWnvRMjfjZTBLvdOI5l82mizEu5wqWgX5GW+zJ7tar5DbeXa
 ZN/x6UBq5MVRWXhuJXNExn1uFgl1Il4UhllaLGPIWseXvEtnfU2t3zBRaDxTStSbGu4nf4+u7
 y8vzoU5uIUoykt0LT0o6Wi3+0KSQ2Y4eMjb3C7deRYktUAlJY6IUvt7wNtnQcz4NHmKV0hyuZ
 kc7CF3htiPFzYpaXM8On8Q=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 17.06.21 15:23, Peng Tao wrote:

>> Just keeping fd's open while a server restarts ?
>> If that's what you want, I see much wider use far outside of fuse,
>> and that might call for some more generic approach - something like
>> Plan9's /srv filesystem.
>>
> 1. keeping FDs across userspace restart

if application needs to be rewritten for that anyways, there're other
ways to achieve this, w/o touching the kernel at all - exec() doesn't
automatically close fd's (unless they're opened w/ O_CLOEXEC)

> 2. help save FD in the FUSE fd passthrough use case as implemented by
> Alessio Balsini

you mean this one ?

https://lore.kernel.org/lkml/20210125153057.3623715-1-balsini@android.com

I fail to see why an extra fd store within the fuse device is necessary
for that - I'd just let the fuse daemon(s) reply the open request with
the fd it already holds.

I'd hate to run into situations where even killing all processes holding
some file open leads to a situation where it remains open inside the
kernel, thus blocking e.g. unmounting. I already see operators getting
very angy ... :o

by the way: alessio's approach is limited to simple read/write
operations anyways - other operations like ioctl() don't seem to work
easily that way.

and for the creds switching: I tend to believe that cases where a fs or
device looks at the calling process' creds in operations on an already
open fd, it's most likely a bad implementation.

yes, some legacy drivers actually do check for CAP_SYS_ADMIN e.g. for
low level hardware configuration (e.g. IO and IRQ on ISA bus), but I
wonder whether these are use at all in the our use cases and should be
ever allowed to non-root.

do you have any case where you really need to use the opener's creds ?
(after the fd is already open)

>> Does FUSE actually manipulate the process' fd table directly, while
>> in the open() callback ?
> 
> hmm, you are right. The open() callback cannot install FD from there.
> So in order for your use case to work, the VFS layer needs to be
> changed to transparently replace an empty file struct with another
> file struct that is prepared by the file system somewhere else. It is
> really beyond the current RFC patch's scope IMHO.

Exactly. That's where I'm struggling right now. Yet have to find out
whether I could just copy from one struct file into another (probably
some refcnt'ing required). And that still has some drawback: fd state
like file position won't be shared.

I've been thinking about changing the vfs_open() chain so that it
doesn't pass in an existing/prepared struct file, but instead returns
one, which is allocated further down the chain, right before the fs'
open operation is called. Then we could add another variant that
returns struct file. If the new one is present, it will be called,
otherwise a new struct file is allocated, the old variant is called
on the newly allocated one, and finally return this one.

this is a bigger job to do ...


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
