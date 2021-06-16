Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C61793A9B44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Jun 2021 14:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhFPM6v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Jun 2021 08:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41442 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232550AbhFPM6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623848204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRdZ54HD2Y71Mzeckrvw4hXodqyFRR35GmYM5eMm8B0=;
        b=L9rJClLKegKis89Uu55RwiyoXtdx5Oz6tmRDGbV+VZFm+bMRpCXnPem030SJH+0GtvELP1
        cJAZYYgE1WWKzUC7V5A+eOnS3qWeWotbjHb76lcq/DeYR3VBxSb1wIWKee98uq8nhynRYV
        DqpriUdVnTfrmM4LdNS6R1u5mo7QseY=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-Z2-zcaV-OGakR_uikd2YaQ-1; Wed, 16 Jun 2021 08:56:43 -0400
X-MC-Unique: Z2-zcaV-OGakR_uikd2YaQ-1
Received: by mail-ot1-f71.google.com with SMTP id i25-20020a9d4a990000b0290304f00e3e3aso1507483otf.15
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Jun 2021 05:56:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=aRdZ54HD2Y71Mzeckrvw4hXodqyFRR35GmYM5eMm8B0=;
        b=nDdL+grbFK/tWmvKtTYvNW0JnqSxZWxfy7y0+P2XC9NnTJ/M+u7vBxAOpPTw5GdI4O
         P8MAO4Nw1A7uTiLd3seJPP6uLL5WUHLBU5Y21heXik03Je4IKqw70gA54IbyXjEGi89K
         sDgJrvfULN+WWXlq0bdpPzRJHTYyp5/LfzPiiaC71QuxDERPanq2M+3H7Up5Ipq0b6Df
         toVkR6u+kdVRqxuWQQPzetvHmSde+JyOucn+1pi0DDypvRsA241QYvwCsK1/PqfZ5OvU
         eYgZfsQpvYV81q/cfkYc9XxD+G5zy2O1nudBZfRSnH27fYJ4Zf8hOalB2ckCOMd9QU7K
         a9tw==
X-Gm-Message-State: AOAM530KSdACkCnMccDTDcMsO1IXyPhsVVvOxozwoGdVfVgOdXw9a2HN
        5Zryy1ZOBcsrdbYivuwkKb0r6cg7b8Wijc8qpRhVXShwLL5s4dAR7QIV6O3WQHAVsHVrBrPCWk4
        zlaG2puVpWP9dDBojAgcu3p890g==
X-Received: by 2002:a4a:4c8f:: with SMTP id a137mr3994308oob.65.1623848202310;
        Wed, 16 Jun 2021 05:56:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6JWTdaVQacHIa8wCDgx4/hnjT3TG9g6RLUBCUnn8ZqT8XseLbYFYF/WMm26MLJJerXPTPRQ==
X-Received: by 2002:a4a:4c8f:: with SMTP id a137mr3994292oob.65.1623848202112;
        Wed, 16 Jun 2021 05:56:42 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p10sm522032otf.45.2021.06.16.05.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 05:56:41 -0700 (PDT)
Subject: Re: [PATCH] afs: fix no return statement in function returning
 non-void
To:     Zheng Zengkai <zhengzengkai@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Hulk Robot <hulkci@huawei.com>, linux-afs@lists.infradead.org,
        Marc Dionne <marc.dionne@auristor.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <162375813191.653958.11993495571264748407.stgit@warthog.procyon.org.uk>
 <CAHk-=whARK9gtk0BPo8Y0EQqASNG9SfpF1MRqjxf43OO9F0vag@mail.gmail.com>
 <f2764b10-dd0d-cabf-0264-131ea5829fed@infradead.org>
 <CAHk-=whPPWYXKQv6YjaPQgQCf+78S+0HmAtyzO1cFMdcqQp5-A@mail.gmail.com>
 <c2002123-795c-20ae-677c-a35ba0e361af@infradead.org>
 <051421e0-afe8-c6ca-95cd-4dc8cd20a43e@huawei.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <200ea6f7-0182-9da1-734c-c49102663ccc@redhat.com>
Date:   Wed, 16 Jun 2021 05:56:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <051421e0-afe8-c6ca-95cd-4dc8cd20a43e@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 6/15/21 8:15 PM, Zheng Zengkai wrote:
> Oops, Sorry for the late reply and missing the compilation details.
>
>> On 6/15/21 5:32 PM, Linus Torvalds wrote:
>>> On Tue, Jun 15, 2021 at 4:58 PM Randy Dunlap <rdunlap@infradead.org> 
>>> wrote:
>>>> Some implementations of BUG() are macros, not functions,
>>> Not "some", I think. Most.
>>>
>>>> so "unreachable" is not applicable AFAIK.
>>> Sure it is. One common pattern is the x86 one:
>>>
>>>    #define BUG()                                                   \
>>>    do {                                                            \
>>> instrumentation_begin();                                \
>>>            _BUG_FLAGS(ASM_UD2, 0);                                 \
>>> unreachable();                                          \
>>>    } while (0)
>> duh.
>>
>>> and that "unreachable()" is exactly what I'm talking about.
>>>
>>> So I repeat: what completely broken compiler / config / architecture
>>> is it that needs that "return 0" after a BUG() statement?
>> I have seen it on ia64 -- most likely GCC 9.3.0, but I'll have to
>> double check that.
>
> Actually we build the kernel with the following compiler, config and 
> architecture :
>
> powerpc64-linux-gnu-gcc --version
> powerpc64-linux-gnu-gcc (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0
> Copyright (C) 2019 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions. There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR 
> PURPOSE.
>
> CONFIG_AFS_FS=y
> # CONFIG_AFS_DEBUG is not set
> CONFIG_AFS_DEBUG_CURSOR=y
>
> make ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu- -j64
>
> ...
>
> fs/afs/dir.c: In function ‘afs_dir_set_page_dirty’:
> fs/afs/dir.c:51:1: error: no return statement in function returning 
> non-void [-Werror=return-type]
>    51 | }
>       | ^
> cc1: some warnings being treated as errors
>
powerpc64 gcc 10.3.1 is what I used to find this problem.

A fix is to use the __noreturn attribute on this function and not add a 
return like this

-static int afs_dir_set_page_dirty(struct page *page)
+static int __noreturn afs_dir_set_page_dirty(struct page *page)

and to the set of ~300 similar functions in these files.

$ grep -r -P "^\tBUG\(\)" .

If folks are ok with this, I'll get that set started.

Tom

>>> Because that environment is broken, and the warning is bogus and wrong.
>>>
>>> It might not be the compiler. It might be some architecture that does
>>> this wrong. It might be some very particular configuration that does
>>> something bad and makes the "unreachable()" not work (or not exist).
>>>
>>> But *that* is the bug that should be fixed. Not adding a pointless and
>>> incorrect line that makes no sense, just to hide the real bug.
>> .
>>
>

