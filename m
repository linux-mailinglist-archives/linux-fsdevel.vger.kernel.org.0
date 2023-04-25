Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEFF6EE370
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Apr 2023 15:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjDYNrX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Apr 2023 09:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjDYNrT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Apr 2023 09:47:19 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17953146E2
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 06:46:54 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-32ad7e5627bso2564965ab.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Apr 2023 06:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682430412; x=1685022412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sWT4LDDHDTDTan4b4Z+92OYHL+K27mprNFuaNL6WnjA=;
        b=1nJIIQwa9wgF4lHDGz+kxbxwTuUJVltwQAbcKRiVUr8nc8hHbWExkW+1fkx5WoI6fm
         eFzVIleC7/Zrq8d5PBdP9JpT56oymBJ0lFz3jWqiQWsvl5WluanpZI8IxKmAuon7D5eq
         nPkok3e10A3BuOaxgc+pCrme1NFnkcRWIGILWfKpP+L6efrZNSVd5u5iyXCd5BdBGySc
         65mNsVocLP1fATCMVpQx3fnZDTqg91MgBpD4zXqrgdiNXTn+9WTAzSz6HhzuU+o3Y3Ww
         GEBC5J8bcUn5I5dwcnHRuEkLPo4bPVokiBntVfV5N2yK3dbhbQgil5dSx/MvCQ0RmXZ0
         NmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682430412; x=1685022412;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sWT4LDDHDTDTan4b4Z+92OYHL+K27mprNFuaNL6WnjA=;
        b=N+nhZ7/D6BoKyaKGBq3mwN56nXq/ED/AItObkJk/JItQ72sYmE165ozET+SwS2AlXk
         dScXSqbAYv+ls/2++zkUTe+c6NsRFgSikpcHW7aLAowbP8cgAWD8ujGmtibKkN6FUg4i
         pBLHOQvTg2GKDbUI/Iy6TRVuAdV/C6fBCYJgsWQlbP6/ljofLxxCCS1zQhIUHaxGk98X
         7qlLLJhyTxB7NFa0S1TxM1das2taWOybxsH9Q0/vZNOF746w2lANLm0i706Ao8+4+ju7
         UYyCmBs3cIBXSQWNA/4g9KcuzAENdwM82kpOyLlCueB0M0fuSp4anvmDY0Kngx3Oqai4
         IVxw==
X-Gm-Message-State: AAQBX9c8Cjkc7nhoIqExVjgQpgaxXxBS240IOL3jwE9a/SvgxDWLmLOV
        5ehha79iF7E/lcS3AiQ68C/E7A==
X-Google-Smtp-Source: AKy350YTrxS1BtUfMNL2LeuIIK7iBfsRU2g2VBE8kugIz3YHrjtnd8goWvVu4EnYemjGQkYrGBOG2g==
X-Received: by 2002:a05:6e02:17cd:b0:328:2f36:b6bd with SMTP id z13-20020a056e0217cd00b003282f36b6bdmr11283728ilu.1.1682430412341;
        Tue, 25 Apr 2023 06:46:52 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w2-20020a927b02000000b003231580e8e2sm3590068ilc.6.2023.04.25.06.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 06:46:51 -0700 (PDT)
Message-ID: <f9616b01-b185-a2a5-dbc9-a45735ed7e1b@kernel.dk>
Date:   Tue, 25 Apr 2023 07:46:51 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] pipe: nonblocking rw for io_uring
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230421-seilbahn-vorpreschen-bd73ac3c88d7@brauner>
 <CAHk-=wgyL9OujQ72er7oXt_VsMeno4bMKCTydBT1WSaagZ_5CA@mail.gmail.com>
 <6882b74e-874a-c116-62ac-564104c5ad34@kernel.dk>
 <CAHk-=wiQ8g+B0bCPJ9fxZ+Oa0LPAUAyryw9i+-fBUe72LoA+QQ@mail.gmail.com>
 <CAHk-=wgGzwaz2yGO9_PFv4O1ke_uHg25Ab0UndK+G9vJ9V4=hw@mail.gmail.com>
 <2e7d4f63-7ddd-e4a6-e7eb-fd2a305d442e@kernel.dk>
 <69ec222c-1b75-cdc1-ac1b-0e9e504db6cb@kernel.dk>
 <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wiaFUoHpztu6Zf_4pyzH-gzeJhdCU0MYNw9LzVg1-kx8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/24/23 9:16?PM, Linus Torvalds wrote:
> On Mon, Apr 24, 2023 at 3:45?PM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Something like this. Not tested yet, but wanted to get your feedback
>> early to avoid issues down the line.
> 
> Ok, that try_cmpxchg() loop looks odd, but I guess it's the right thing to do.
> 
> That said, you should move the
> 
>         old_fmode = READ_ONCE(file->f_mode);
> 
> to outside the loop, because try_cmpxchg() will then update
> 'old_fmode' to the proper value and it should *not* be done again.
> 
> I also suspect that the READ_ONCE() itself is entirely superfluous,
> because that is very much a value that we should let the compiler
> optimize to *not* have to access more than it needs to.
> 
> So if the compiler had an earlier copy of that value, it should just
> use it, rather than us forcing it to read it again.
> 
> But I suspect in this case it makes no real difference to code
> generation. There's nothing else around it that uses f_mode, afaik,
> and the try_cmpxchg() will reload it properly to fix any possible
> races up.
> 
> The READ_ONCE() would possibly make more sense if we actually expected
> that FMODE_NOWAIT bit to change more than once, but then we'd
> presuably have some ordering rule and it should be a
> smp_load_acquire() or whatever.
> 
> As it is, if we ever see it clear, we don't care any more, and the
> real value consistency guarantee is in the try_cmpxchg itself. There
> are no possible races ot mis-readings that could matter.
> 
> So I think it could/should just be something like
> 
>     void pipe_clear_nowait(struct file *file)
>     {
>         fmode_t fmode = file->f_mode;
>         do {
>             if (!(fmode & FMODE_NOWAIT))
>                 break;
>         } while (!try_cmpxchg(&file->f_mode, &fmode, fmode & ~FMODE_NOWAIT));
>     }
> 
> which sadly generates that big constant just because FMODE_NOWAIT is
> up in the high bits and with the 'try_cmpxchg()', the compiler has no
> choice but to get the full 32-bit value anyway.

I'll go with this, it's definitely simpler. I suspected the important
bit was just doing the cmpxchg sanely and that the READ_ONCE() was
superflous given how it's used, and dropping the old_fmode is cleaner.

FWIW, I don't see any difference in code generation here on arm64 or
x86-64 if FMODE_NOWAIT is in the lower bits, as we could've just moved
it. We could make it the sign bit which might make the first compare
faster in general, but honestly don't think we really care that deeply
about that.

Updated the branch, it's:

https://git.kernel.dk/cgit/linux/log/?h=pipe-nonblock.2

It's just the cmpxchg patch now and the same "set FMODE_NOWAIT on pipes
unconditionally" from before.

-- 
Jens Axboe

