Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2712F3EB693
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 16:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhHMOMk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 10:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbhHMOMh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 10:12:37 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33ADC061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Aug 2021 07:12:10 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id a8so15405820pjk.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Aug 2021 07:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sM9iZQWOpgXtCBxdiAH87a4w4pD1Hwf0Q/waRT60trY=;
        b=L4fbcQ/XtI8L4Dwr6IgeN+D/hs24frS3q4t7H7qlyDb7LBWVIjTli59tuqeZ0bVK+I
         +m4RqhoDbSfmXaOlRVCvuoUArFRgWaDPl+DlYdW/RnQ1WW8YDGIRBECQrWLsj6vZx2aI
         yQ9y7XQ+Heop80RAY0Oz0LRfdNPE4f2Bf1fT5V06dbG1vYHHjJFLJ0ztMRKkQX5IFyNo
         g3rP4zcxGVj0yUQbM38kAvfemHMN5DPL09kdgJK/TB0uNl9GWYc+J9DLEmf87nr2vh/a
         Y1ehh2KRphTB4BGJeMGwU56uPGPlcNYGPsHNAu9Pb6XPp5klfdTcRvdTlGN3bf1w+ZXC
         50Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sM9iZQWOpgXtCBxdiAH87a4w4pD1Hwf0Q/waRT60trY=;
        b=lUnPKL21hshDuz37LkoUV/sAM9XbDH56kLPyRrykiB5v15Lj++0LX3BgPqU7+ADxOk
         icR7jznMcdYwPj9m9hfNw2yG4sgRI90AYQ8N0sYJanGDfr4eJAAO0FokSoY6dWJQzNr4
         6FbaDoFKSwCIU3MoUQxrAI3aAbVS2SAuT9fWtQoedX6WRr4Lxux0BJj19FjopcaRkpCA
         GLnY+/unFZQxwFBTcj60/ogUKQl6qf873f7jlobC9MSIvbjDQR39BqXyErzyr5fagKTW
         S6UaJLTKPjUc3r5oITh+rQzBhKH4g9QNTKGBOis+Ya3IwgGVD85YPaOLDIJvZPqA1XHz
         IdvA==
X-Gm-Message-State: AOAM533mfoa5OSoiCZ2DBHk0xOtPvq/vf7D6ZZM6VH+M5I8j09cWN+8e
        8sSXlPOCzLDtTFV0vnU6xtiHlA==
X-Google-Smtp-Source: ABdhPJxk/6mubsgRh4KoiPUmDR+lqAmlG7SCS2sNtmMzaLRGB7vL6TfeFPyTxgoPtBChlKsE0Q5Utg==
X-Received: by 2002:a17:902:e851:b029:12c:9284:8c2b with SMTP id t17-20020a170902e851b029012c92848c2bmr2099685plg.57.1628863930374;
        Fri, 13 Aug 2021 07:12:10 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id z15sm2982341pgc.13.2021.08.13.07.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Aug 2021 07:12:09 -0700 (PDT)
Subject: Re: [PATCH v9 00/11] io_uring: add mkdir and [sym]linkat support
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
References: <20210708063447.3556403-1-dkadashev@gmail.com>
 <CAHk-=wjMFZ98ERV7V5u6R4FbYi3vRRf8_Uev493qeYCa1vqV3Q@mail.gmail.com>
 <cbddca99-d9b1-d545-e2eb-a243ce38270b@kernel.dk>
 <CAOKbgA5jHtR=tLAYS_rs77QppRm37HV1bqSLQEMv8GusQNDrAg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <506f544a-cb0b-68a2-f107-c77d9f7f34ed@kernel.dk>
Date:   Fri, 13 Aug 2021 08:12:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOKbgA5jHtR=tLAYS_rs77QppRm37HV1bqSLQEMv8GusQNDrAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/13/21 3:32 AM, Dmitry Kadashev wrote:
> On Fri, Jul 9, 2021 at 2:25 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 7/8/21 12:34 PM, Linus Torvalds wrote:
>>> On Wed, Jul 7, 2021 at 11:35 PM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>>>>
>>>> v9:
>>>> - reorder commits to keep io_uring ones nicely grouped at the end
>>>> - change 'fs:' to 'namei:' in related commit subjects, since this is
>>>>   what seems to be usually used in such cases
>>>
>>> Ok, ack from me on this series, and as far as I'm concerned it can go
>>> through the io_uring branch.
>>
>> I'll queue it up in a separate branch. I'm assuming we're talking 5.15
>> at this point.
> 
> Is this going to be merged into 5.15? I'm still working on the follow-up
> patch (well, right at this moment I'm actually on vacation, but will be
> working on it when I'm back), but hopefully it does not have to be
> merged in the same merge window / version? Especially given the fact
> that Al prefers it to be a bigger refactoring of the ESTALE retries
> rather than just moving bits and pieces to helper functions to simplify
> the flow, see here:
> 
> https://lore.kernel.org/io-uring/20210715103600.3570667-1-dkadashev@gmail.com/

I added this to the for-5.15/io_uring-vfs branch:

https://git.kernel.dk/cgit/linux-block/log/?h=for-5.15/io_uring-vfs

had one namei.c conflict, set_nameidata() taking one more parameter, and
just a trivial conflict in each io_uring patch at the end. Can you double
check them?

-- 
Jens Axboe

