Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9CE17BB4D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 12:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgCFLOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 06:14:00 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:60699 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFLOA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:14:00 -0500
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MbAxU-1jlifD0RGy-00bcww; Fri, 06 Mar 2020 12:13:47 +0100
Subject: Re: [PATCH] binfmt_misc: pass binfmt_misc P flag to the interpreter
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     YunQiang Su <syq@debian.org>, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, James.Bottomley@hansenpartnership.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        libc-alpha@sourceware.org
References: <20200306080905.173466-1-syq@debian.org>
 <87r1y53npd.fsf@mid.deneb.enyo.de>
 <8441f497-61eb-5c14-bf1e-c90a464105a7@vivier.eu>
 <87mu8t3mlw.fsf@mid.deneb.enyo.de>
From:   Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <40da389d-4e74-2644-2e7c-04d988fcc26f@vivier.eu>
Date:   Fri, 6 Mar 2020 12:13:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87mu8t3mlw.fsf@mid.deneb.enyo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nDVU3gbXMhuIHaWA6igwrvEm8+DoLfcyUuAw6APtA6KC4CXvzZc
 mThvkbG1chNbalJyZBbfQFD6bzb0fnAUfRs2TjSkh4JedOUTSEgnNghcgMgcNOkJuhk8K/D
 XV4FLlD0T2izOYEIvVi93q8JxjD8KlzIcbgDzaeVira78hSbzV9i53kIn46/jiajZhvfV8/
 eiPLejg6uHRZpmttJj4zA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EvOmeNnvFrE=:MK7GqCIo1Ebv4pKEb9p1xI
 lay5dwr9KxVVz6Xl53xfEybnhKSD/asTsPBOP1BBx5vUpOyULIRezBM31DOpzTm8E8t1mKP7E
 y1AbzSRmdgCv73fzswdhn3XR1K6erIf+sryz6Pmn2jYVq38fo05I9CU16TNdUuHLOc+ygcT2s
 odtaZFsb97gAbRoVZ0RCqfFvF3FfGAuuMwkJmqIKaUo2iLBsl5/JSZQTbZ/x1IARcaA7BTWF9
 4tu5riMi7+s0NZmcqGzF/gqsUqSRsz7/sHdylIh40QkqecmDPzxOZCnrbmXVJgEazJc07vArZ
 RclAKUi96liaJNxZaQKNIxlrwaRzcJKG6C/WcDt/MhZi+dGikJReYq6lSiPL0UlzO3I96KjKy
 nWmx4L2KL5Z1i1hBh+x1jss6fZnrsTEsADXm3TPbaZ8XETgHAu/a0tmddz3LIA+omKHP0JR/w
 m9YSf4cYy6zLsKPhNsysEbD9C2jJZX1t7V9GIqCAnGOHEQwAShg/zj/njVN6zBXlZCrU7SM3/
 DWi4K+N05r7Da6YIYpgAJWBh+v9mhrCZ/ypHmAZPGSt02ajbtmAp4NfWNKsvV8pnD9u1h4Lm8
 G+rE+URBQwmzhGuNMY3gnuvf1rlk8CSfuCyvGAkORC1M/hojYxGRYGWqXSlY0qQitRNjc9gUD
 FjgzPKLVVfN3j6Vi8esHtu/dDIGEaFlYmm4f8vv+Uw92fQHJhDPbM80NTewbjZw+FvOTZHfFM
 1SmGNnpBAG79WZbpnVQWZCGKw8fwOglLY68at9D9eo7oHiuE7Qh1fUKjYU3yYaHTxp/4RrRuS
 vf+4dCz1XAp1EkhPi8R6usvt6o76uTvgeEz5tXOqx5bk4BdJbc1aUrDBm58xKd/vEdXC6JQ
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Le 06/03/2020 à 09:37, Florian Weimer a écrit :
> * Laurent Vivier:
> 
>> Le 06/03/2020 à 09:13, Florian Weimer a écrit :
>>> * YunQiang Su:
>>>
>>>> +	if (bprm->interp_flags & BINPRM_FLAGS_PRESERVE_ARGV0)
>>>> +		flags |= AT_FLAGS_PRESERVE_ARGV0;
>>>> +	NEW_AUX_ENT(AT_FLAGS, flags);
>>>
>>> Is it necessary to reuse AT_FLAGS?  I think it's cleaner to define a
>>> separate AT_ tag dedicated to binfmt_misc.
>>
>> Not necessary, but it seemed simpler and cleaner to re-use a flag that
>> is marked as unused and with a name matching the new role. It avoids to
>> patch other packages (like glibc) to add it as it is already defined.
> 
> You still need to define AT_FLAGS_PRESERVE_ARGV0.  At that point, you
> might as well define AT_BINFMT and AT_BINFMT_PRESERVE_ARGV0.
> 

Yes, you're right.

But is there any reason to not reuse AT_FLAGS?

Thanks,
Laurent
