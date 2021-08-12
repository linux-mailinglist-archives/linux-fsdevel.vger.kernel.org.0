Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FF23EAD30
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 00:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238288AbhHLWco (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Aug 2021 18:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbhHLWcn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Aug 2021 18:32:43 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E3C061756;
        Thu, 12 Aug 2021 15:32:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a8so12313503pjk.4;
        Thu, 12 Aug 2021 15:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zp/Nu1LAn/XaXn+xRvyj50vtQNNKFYSlvk+KUuxDY/s=;
        b=V2n2+nFPhssWpCrvcty6gMGdM25fYZwPJZ7z59ttqSdVrsllum+d+YsA+kcJn0V2CS
         llNmgS39mTtQcFlvqOSBlv04WRJ5xfbRQrZPNi9rwKbTLwJTwJHWjACM2qoH9MYg8S/7
         QK9h0x2kkh65TtM27XnlBT7Dj9IZ3zwY+mxd4Pcxug9rmP9Nt1OgsgqSqdXMXTuK5YYB
         V6mbgys4IQ1Otc14pXItEI+CTt+eeFQMyNdQCZtqGbUOgaF39A8wNbhhfBNfiwpUOpAN
         x6Qc6LAzzN2qvFoyf7SaGIcysgYMBfb9oOmHwmpO1FxbgzFPUtV2+D/YlzirJ/zXov1x
         4kSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zp/Nu1LAn/XaXn+xRvyj50vtQNNKFYSlvk+KUuxDY/s=;
        b=fFYOQkO+f2to6EPSAaBl2KpLz4ybwUh8V3Nm6MnrJ7acZoHw15/DGVXbPzhECTw15b
         DAt+Zj5hytimS9ZXpt5qzGmy/NnKIgiO/whtGdHhQa5WhnI8DC79jjVAENi44FMJbspx
         8d3n4b/cWO6m7KDPTyNxxYRSiZyD3rEyFgYDjwuoFkOHUlldWbgBmOunJ+5rv18O3Bn/
         OxPYtKthswVEqvuBbYb/5bv/fpkneeDN/mFb3B94sYVqxOyMlE/asMkRwUlAWdN/51BL
         QNTfzGCF4eriRQoOMVJACQCxUxKXtdvI8PWs7TD9aToi9L7l54Q/CyK99jyR/uyMyUx3
         hWfw==
X-Gm-Message-State: AOAM532NQ8L3yfxvOs0q0rG/2mtUHEqnq4/9orU1kE4kY4rCTi3K425T
        jTdLomcoN4KyNaRznYuShH4=
X-Google-Smtp-Source: ABdhPJwzjP00qTgEN2zu69i939n05bXEqD4vw4Ds+VJAT5xY0msyPJzmbTnPHmIeoAtA1cZ3rpjSAg==
X-Received: by 2002:a62:fb0b:0:b029:3ca:1345:9fd8 with SMTP id x11-20020a62fb0b0000b02903ca13459fd8mr6170274pfm.14.1628807537598;
        Thu, 12 Aug 2021 15:32:17 -0700 (PDT)
Received: from [192.168.1.71] (122-61-176-117-fibre.sparkbb.co.nz. [122.61.176.117])
        by smtp.gmail.com with ESMTPSA id x20sm4552303pfh.188.2021.08.12.15.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 15:32:16 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Alejandro Colomar <alx.manpages@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: Questions re the new mount_setattr(2) manual page
To:     Christian Brauner <christian.brauner@ubuntu.com>
References: <b58e2537-03f4-6f6c-4e1b-8ddd989624cc@gmail.com>
 <20210810143255.2tjdskubryir2prp@wittgenstein>
 <95c7683e-957a-5a78-6b81-2cb8e756315c@gmail.com>
 <20210811100711.i3wwoc3bhrf7bvle@wittgenstein>
 <ea2e81b7-10e1-88f3-bfcb-e36afc5567d6@gmail.com>
 <20210812090805.qkwjxnjitgaihlep@wittgenstein>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <37a0c459-86f7-9686-4ae5-03316198d1cc@gmail.com>
Date:   Fri, 13 Aug 2021 00:32:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210812090805.qkwjxnjitgaihlep@wittgenstein>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christian,

[...]

Thanks for checking the various wordinfs.

[...]

>>>>>>>           int fd_tree = open_tree(-EBADF, source,
>>>>>>>                        OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC |
>>>>>>>                        AT_EMPTY_PATH | (recursive ? AT_RECURSIVE : 0));
>>>>>>
>>>>>> ???
>>>>>> What is the significance of -EBADF here? As far as I can tell, it
>>>>>> is not meaningful to open_tree()?
>>>>>
>>>>> I always pass -EBADF for similar reasons to [2]. Feel free to just use -1.
>>>>
>>>> ????
>>>> But here, both -EBADF and -1 seem to be wrong. This argument 
>>>> is a dirfd, and so should either be a file descriptor or the
>>>> value AT_FDCWD, right?
>>>
>>> [1]: In this code "source" is expected to be absolute. If it's not
>>>      absolute we should fail. This can be achieved by passing -1/-EBADF,
>>>      afaict.
>>
>> D'oh! Okay. I hadn't considered that use case for an invalid dirfd.
>> (And now I've done some adjustments to openat(2),which contains a
>> rationale for the *at() functions.)
>>
>> So, now I understand your purpose, but still the code is obscure,
>> since
>>
>> * You use a magic value (-EBADF) rather than (say) -1.
>> * There's no explanation (comment about) of the fact that you want
>>   to prevent relative pathnames.
>>
>> So, I've changed the code to use -1, not -EBADF, and I've added some
>> comments to explain that the intent is to prevent relative pathnames.
>> Okay?
> 
> Sounds good.
> 
>>
>> But, there is still the meta question: what's the problem with using
>> a relative pathname?
> 
> Nothing per se. Ok, you asked so it's your fault:
> When writing programs I like to never use relative paths with AT_FDCWD
> because. Because making assumptions about the current working directory
> of the calling process is just too easy to get wrong; especially when
> pivot_root() or chroot() are in play.
> My absolut preference (joke intended) is to open a well-known starting
> point with an absolute path to get a dirfd and then scope all future
> operations beneath that dirfd. This already works with old-style
> openat() and _very_ cautious programming but openat2() and its
> resolve-flag space have made this **chef's kiss**.
> If I can't operate based on a well-known dirfd I use absolute paths with
> a -EBADF dirfd passed to *at() functions.

Thanks for the clarification. I've noted your rationale in a 
comment in the manual page source so that future maintainers 
will not be puzzled!

Cheers,

Michael



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
