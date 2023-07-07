Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B8F74B788
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jul 2023 21:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjGGT5P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jul 2023 15:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGGT5O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:57:14 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771E31FEE
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jul 2023 12:57:08 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34637e55d9dso2560375ab.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 07 Jul 2023 12:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688759828; x=1691351828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgLH4x6SYCM3FO+eSHQqZ04OTA4A5LMIJOwD5iZGGk8=;
        b=cAhHHR31cXZokqKFqFUU6LpiBxlJylyjK9v28qKYzx6+AzyKuhMfsw097GTDBDySuU
         nZSPnwCOpTx84jS/jzqemPck6uTOrYjRiLH6PqGIzbuplG74B9PvL0gZ/lbJsGkc/Qmg
         v95XSITioq9vER0belBMjKUyd4+6OgLDn7GXUQ3DB7eoPEUG/idT2dwk11+P0T+b+C+v
         18W52rDVmcdWknEXzsdEwN4jrFXy5hwPt6WJvR2Ig2GFBRgYDG7aX+adZeDVFVA6Xf6l
         i0gyB/47Uxd5hTQMemH1ImSN3E4JKvptKPOnagts19kEX2M4xqy1ui41tfEXLp/RfSN4
         JkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688759828; x=1691351828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgLH4x6SYCM3FO+eSHQqZ04OTA4A5LMIJOwD5iZGGk8=;
        b=e0YiPiVeFOyXcAi48TL/lAC+ACkpgaau6LMNW8n/ucHlw6MMuSOVQ7ImjlFXh5bvg5
         FL1QIC+V9RzGEuygZPRTThn7XSNvdiPiqGHefSovTfOF6eLUpiPCFZ8EUo6sVZaCmb75
         IGAWdlGGbGoDh4IatnlI6107ZP5YQH3F++s7RAUl/d+HB4YkyKMpFoW2RtYwJUsZ2wOQ
         g27JKk0RSaDg5qViB66nnFFfR9FQL0pPg3HipTWP7IwvbODcE6ui+beuQ3siXI47WGsF
         W9JEFBpwIaFH8tnMgs+JTOCyjiiExwHMh53BHYn56fe5T8mB2l6i08WCj0413v80ESFl
         R+wA==
X-Gm-Message-State: ABy/qLYbNL78eKxcNGxEPt4KF8dix6JqW7Sn363gEMtoBtzl270TGKGY
        kFotjYWTTiPmTdzOsEpnAEitZL8UmUHvwTnR4eA=
X-Google-Smtp-Source: APBJJlG9mOrjG7Jm5uecyJPocz/Abk/1Gj8yaswJkv16M++bqWqAr+rWaqErxmKgB8rkhKCWxaHyTg==
X-Received: by 2002:a05:6602:3993:b0:780:c6bb:ad8d with SMTP id bw19-20020a056602399300b00780c6bbad8dmr8772671iob.0.1688759827735;
        Fri, 07 Jul 2023 12:57:07 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u16-20020a02c950000000b0042b85d6e125sm900567jao.24.2023.07.07.12.57.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 12:57:07 -0700 (PDT)
Message-ID: <42294e31-9cc8-3c5a-c28f-cfa3854fbe69@kernel.dk>
Date:   Fri, 7 Jul 2023 13:57:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Pending splice(file -> FIFO) excludes all other FIFO operations
 forever (was: ... always blocks read(FIFO), regardless of O_NONBLOCK on read
 side?)
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     =?UTF-8?Q?Ahelenia_Ziemia=c5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <qk6hjuam54khlaikf2ssom6custxf5is2ekkaequf4hvode3ls@zgf7j5j4ubvw>
 <20230626-vorverlegen-setzen-c7f96e10df34@brauner>
 <4sdy3yn462gdvubecjp4u7wj7hl5aah4kgsxslxlyqfnv67i72@euauz57cr3ex>
 <20230626-fazit-campen-d54e428aa4d6@brauner>
 <qyohloajo5pvnql3iadez4fzgiuztmx7hgokizp546lrqw3axt@ui5s6kfizj3j>
 <CAHk-=wgmLd78uSLU9A9NspXyTM9s6C23OVDiN2YjA-d8_S0zRg@mail.gmail.com>
 <20230707-konsens-ruckartig-211a4fb24e27@brauner>
 <CAHk-=whHXogGiPkGFwQQBtn364M4caVNcBTs7hLNfa_X67ouzA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=whHXogGiPkGFwQQBtn364M4caVNcBTs7hLNfa_X67ouzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/7/23 1:10?PM, Linus Torvalds wrote:
> On Fri, 7 Jul 2023 at 10:21, Christian Brauner <brauner@kernel.org> wrote:
>>
>> Forgot to say, fwiw, I've been running this through the LTP splice,
>> pipe, and ipc tests without issues. A hanging reader can be signaled
>> away cleanly with this.
> 
> So that patch still has a couple of "wait for this" cases remaining.
> 
> In particular, when we do a read, and we do have pipe buffers, both
> the read() system call and a number of internal splice functions will
> go "Ahh, I have data", and then do pipe_buf_confirm() and read it.
> 
> Which then results in pipe_buf_confirm() blocking. It now blocks
> interruptibly, which is much nicer, but several of these users *could*
> just do a non-blocking confirmation instead, and wait for pipe
> readability.
> 
> HOWEVER, that's slightly less trivial than you'd expect, because the
> "wait for readability" needs to be done without the pipe lock held -
> so you can't actually check the pipe buffer state at that point (since
> you need the pipe lock to look up the buffer).
> 
> That's true even of "trivial" cases like actual user-space "read()
> with O_NONBLOCK and poll()" situations.
> 
> Now, the solution to all this is *fairly* straightforward:
> 
>  (a) don't use "!pipe_empty()" for a readability check.
> 
>      We already have "pipe_readable()", but it's hidden in fs/pipe.c,
> so all the splice() code ended up writing the "does this pipe have
> data" using "!pipe_empty()" instead.
> 
>  (b) make "pipe_buf_confirm()" take a "non-blocking" boolean argument,
> and if it is non-blocking but hits one of those blocked pages, set
> "pipe->not_ready", and return -EAGAIN.
> 
>      This is ok, because "pipe_buf_confirm()" is always under the pipe
> lock, and we'll just clear "pipe->not_ready" under the pipe lock after
> finalizing all those pages (and before waking up readers)
> 
>  (c) make "pipe_wait_readable()" and "poll()" know about this all, so
> that we wait properly for a pipe that was not ready to become ready
> 
> This all makes *most* users deal properly with these blocking events.
> In particular, things like splice_to_socket() can now do the whole
> proper "wait without holding the pipe lock" sequence, even when the
> pipe is not empty, just in this blocked state.
> 
> This *may* also make all the cases Jens had with io_uring and splicing
> JustWork(tm).

Exactly! I was reading this thread with excitement just now, would be
nice to get rid of that kludge.

> NOTE! NOTE! NOTE! Once more, this "feels right to me", and I'd argue
> that the basic approach is fairly straightfoward. The patch is also
> not horrendous. It all makes a fair amount of sense. BUT! I haven't
> tested this, and like the previous patch, I really would want people
> to think about this a lot.
> 
> Comments? Jens?

I'll take a closer look at this, but won't be until Monday most likely.
But the approach seems sane, and going in a more idiomatic direction
than before. So seems promising.

-- 
Jens Axboe

