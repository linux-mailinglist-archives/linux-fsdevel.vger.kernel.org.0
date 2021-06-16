Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 130233AA0F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 18:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbhFPQMK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 12:12:10 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:38309 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235070AbhFPQMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:12:09 -0400
Received: from [192.168.1.155] ([95.115.35.150]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MI5Dj-1m7YkC0BGh-00FFOx; Wed, 16 Jun 2021 18:09:59 +0200
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
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <6d58bd0f-668a-983a-bf7c-13110c02dae0@metux.net>
Date:   Wed, 16 Jun 2021 18:09:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CA+a=Yy4iyMNK=8KxZ2PvB+zs8fbYNchEOyjcreWx4NEYopbtAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:d+HZnyHWcPZFe5T0rf3Ohp2pUJ0kiDbjKV+4Rt6mDqWv0Kit6NG
 C9P14lbXM6jdDKzZYjAAd/M4d/dNKuSbra+x93SlGv69io0HSMd6BLrBAz9YGYRtyhEQjhm
 VsMPiK/M+No+7L11VcFHJMDdZq7SmSqB9lzuCe8VuhKAqzSWSaO0BxIR8UEiOU8GzcL10EQ
 7VIwj46L8u7mD0aA17+Gg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TL6reGOlP3I=:0W7w2svMrVKPrnb/oNdc9S
 K0eHm8LW6R1Fylp464P0vEi1PGAD9dtJZEWoEw2XxQTgFaEjPgAeD6H2CvnFfLO8/TNPKUthC
 KiQI3HSriBac9crSzX5Aah1kSoSkcozh8rwtRglvKxuxnEmrDyQtLwiahOkuqYI0RuK3gaWIP
 wHzAQPqf27KNmJjCdaF9PVBLPArETliwfj+jOx7JWJdMl/OpqrhBY7BQjjeKUGyy6PMOD6wne
 e5ZfUMRRsbPQbxxAshgDRbIltzDcJICNJX0zMMEyZ8s8KCvd2rOvmMf5GpTpm5M+uEnbMACIb
 4TSNxy/SA6Zjf0h+cSUoMq1pvqavVSJcFMOCYCusv+7kWW9QWGewmpRhTiZ+1zi2Bd/u06yDe
 zsns31lYYGTqiNa/uahAv4ULIh/H5KFV7xaEvCPxE4FpoWiFA3VVzWr4mZYPSXG3lwYSiBEe3
 1hf5kIBZNyuTg5BtjERvtJw8PRmXUMVNVoZEeeF1UzbxSKZgipxgNL/lmHXFCSjnkBcDfnx2p
 Frj7J5ElECGG5UKsUamTM8=
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 16.06.21 12:20, Peng Tao wrote:
>> So, just open() a file on a fuse fs can't restore the fd directly
>> (instead of opening a new file) ? If that's the case, that would mean,
>> userland has to take very special actions in order to get it. Right ?
> Yes.

Then, it's not at all what I'm looking for :(

> Oh, nop, that is not how the current RFC works. I see two gaps:
> 1. /dev/fuse is not accessible to all processes by default

it shouldn't necessary at all - in my use case.

> 2. open() syscall doesn't take enough arguments to tell the kernel
> which file's fd it wants.

open() only works on a path name - that's exactly what I need.

Could you please tell more what your use case is actually about ?
Still struggling what you're actually going to achieve.

Just keeping fd's open while a server restarts ?
If that's what you want, I see much wider use far outside of fuse,
and that might call for some more generic approach - something like
Plan9's /srv filesystem.

> It seems that a proper solution to your use case is to:
> 1. extend the open() syscall to take a flag like FOPEN_FUSE_OPEN_FD (I
> agree it's a bad name;)

But that would still require changes in my userland. Something I do not
want per definition - it should work transparently. The application just
knows some file name (it might be even expecting common device names,
but put inside its own mount ns), nothing more, and no need to change
the application itself.

> 2. FUSE kernel passes such a flag to fuse daemon
> 3. FUSE userspace daemon opens the file in the underlying file system,
> store it to a kernel FD store, then return its IDR in the reply to
> FUSE_OPEN API
> 4. FUSE kernel looks up underlying FD with the IDR, install it in the
> calling process FD table, and return the new FD to the application

Does FUSE actually manipulate the process' fd table directly, while
in the open() callback ?


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
