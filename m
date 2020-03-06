Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 143C317BC54
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 13:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCFMHt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 07:07:49 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:60345 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFMHt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:07:49 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MpUEO-1jiMP11Elg-00pqcq; Fri, 06 Mar 2020 13:07:39 +0100
To:     YunQiang Su <syq@debian.org>, Florian Weimer <fw@deneb.enyo.de>
Cc:     torvalds@linux-foundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, Al Viro <viro@zeniv.linux.org.uk>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
References: <20200306080905.173466-1-syq@debian.org>
 <87r1y53npd.fsf@mid.deneb.enyo.de>
 <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu>
 <87mu8t3mlw.fsf@mid.deneb.enyo.de>
 <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu>
 <CAKcpw6WEO5Rmsv+WFkOMrkH+0jwtFKKy7b2n3U9xgv-xGC0UUQ@mail.gmail.com>
 <87v9nhzp6w.fsf@mid.deneb.enyo.de>
 <CAKcpw6VF1N2gTVXeWLU4aVOuARf5oN6yPg9O=RCzgkMrjXmxYQ@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
Message-ID: <fded1845-98db-f0fb-9320-842c9fdc30dc@vivier.eu>
Date:   Fri, 6 Mar 2020 13:07:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAKcpw6VF1N2gTVXeWLU4aVOuARf5oN6yPg9O=RCzgkMrjXmxYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sS0pEc3oZIyEzau4kLZy+OvT/6DVlshFGx7QYjKMvNLMnN8vtWW
 0Pl/Ty8JQPjf6lKH/g8otWFCeEfw5ZhVJz42tGy7+MsujAZbsH09NGdxNpgMvHc4s6wUeZh
 e9I1+47tgNWIbb4R9aLhYWe+6hglEEs366lKO3YycGJQ7sCUN32cj+OpGrLs3g6Qx3uesqK
 h9zavz6MrxQQj26kHFErg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:5kvOibS7td0=:DA8VhOfFP9IY3CqSMmaG4/
 KWlnd8QpDfMF8fB4H758KjsXJMMYrFm9wG8ukjgzv243ofFP/bsEV8UozaImwIW2f+rOSe9T8
 D7BSL3hvglSbLptc7npvNDFJs8dPWYelSv1PknSp3rpl3Aqtr2W0Iykb/oZyEGaLT73k4X+Gw
 aqGRtFSxd5hWCZ0slnXGNfp9fvA76tlgID/nzn2Dhe4S3q95WvoWEM3NSvyzEuwGkHXmmvtiK
 A0xKXBVdSsBQ25neI5qJyW2W+l3Ot7EgUKUM5F+pr/TfZ3qS9b/Jg+sx4uajOhlfMxKVG0HMm
 quzxlv39I5qD2wPE3R5bYap2KHsCYR7OQE+wJko2Q6dbJ8IeV5xGGEI2QU135BZz+3I9taXtR
 nBlYYJYDGq/y9KW1bz/MQHE39nNu8ZByOazAb8fyaXwdGeiKYEBVFiK/83miH+YGB/9LL/TYY
 GEwwPqYYY4tQQkg7loQzWot9e4hLMLdFNqflFegGq7gN6lwbGo3aSHhqt0nw4G4zu2/UQ4Cc+
 okrKB8uSycaZiQH9yTz8yWk9POHBfSgaPXsS9OSWEJa+rLmnBQHHWWY+u9CdamasyGPwgK0hV
 VA4QY+N/7falBwlO/ceqAFN4T2z8Jr7CVk78n/XSpoCd87HN/X5QJAZNzux7d2l6GfdiCxOe9
 TloG6fwQDAPqWMLNw/9NayNNV18mck/FYl2nCXgxuC6EUVJ+KIYEdCvrXpYInxtampiLHvwqd
 2UKgVfLxLaBpBS6tcY07Zsnp6D2663IVTpFaBFe28hY0/Kgoa9LvgCRP/q/AIKxYZ6eMKEgyj
 dKscbDuPw0ilsO8yJoUzWd5sgCW+pbly5MRRIUih+YKBpl9O4IMMPBOV7ALOFZx1Vb4wtZI
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 06/03/2020 à 12:48, YunQiang Su a écrit :
> Florian Weimer <fw@deneb.enyo.de> 于2020年3月6日周五 下午7:42写道：
>>
>> * YunQiang Su:
>>
>>> AT_* only has 32 slot and now. I was afraid that maybe we shouldn't take one.
>>>    /* AT_* values 18 through 22 are reserved */
>>>    27,28,29,30 are not used now.
>>> Which should we use?
>>
>> Where does this limit of 32 tags come from?  I don't see it from a
>> userspace perspective.
> 
> Sorry it is my mistake: In linux/auxvec.h, I saw
> 
> #define AT_RANDOM 25    /* address of 16 random bytes */
> #define AT_HWCAP2 26    /* extension of AT_HWCAP */
> 
> #define AT_EXECFN  31   /* filename of program */
> 
> The number jump to 31 from 26.
> 
> It is my fault: in x86_64-linux-gnu/bits/auxv.h, the max number is 47 now.
> 

Numbers starting from 32 are arch specific.
18 to 22 are also reserved (and used by some archs).
(linux/arch/*/include/uapi/asm/auxvec.h)

So there is only 4 entries available (27 to 30)
(linux/include/uapi/linux/auxvec.h)
Do we want to waste one more entry whereas we can use an unused one?

Thanks,
Laurent
