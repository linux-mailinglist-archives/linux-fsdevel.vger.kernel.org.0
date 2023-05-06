Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C746F94C2
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 May 2023 00:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjEFW20 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 6 May 2023 18:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEFW2Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 6 May 2023 18:28:25 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27C714348
        for <linux-fsdevel@vger.kernel.org>; Sat,  6 May 2023 15:28:23 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-ba1ddf79e4eso374349276.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 06 May 2023 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1683412103; x=1686004103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PNtuRTNF7GqPddA849m36EOAEkX/j0itEuTgY2OGns=;
        b=ymLgs23pGn0y31E1zv0R6T1pdESTKoNHL6sWfZ1tjEZhu6a/Q8HGG8Izn1Ndu47urg
         QGNOryjeFW1fQcFbBxEY2uLjXDVeP3ZTIWgdHb4GwNGbgD75f3G57WjG5LPBe39gQkuI
         7ap146VNBVcX67Qqq/fJtYTeD/Jww9zxdiCtZ0VFNEUBc53GyqXPxxBbu0U30AU9Qxfi
         96w9jt/cW//cs5pB9oPF46MoFAPw6IQ0ij1ANmFYI9UKCux5jmCkQJZjyxgTPURiPYWX
         WlwcoBp5w2F1x6UZ61G1bYvWWT3Fw+GjVldDko4ANde/rFSPMMivfQs0kzElXHf8QIkX
         WHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683412103; x=1686004103;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PNtuRTNF7GqPddA849m36EOAEkX/j0itEuTgY2OGns=;
        b=KR0ebFxjhdBHJ0MvR/heKC7oUxibTVyhfa16qXd7O+pFimnTZGHIBj2fZLp8DEdFM5
         hdOdONe59BULGAGsezYhlQhMCWGV+Gzo4RbPQbBb1VoShSANASFr1iY/MJXrvbBcBiwe
         prrLZHtvDK/tvWNbNQ+vqmq4M/sYhN475Plfm9iAIKkD0C++lj0f8zYNr6bOTXIlj9F9
         ndFf/94Mxwf+6hbZH9DpAVLqPSb94PXi6khOpnbHl+eH3BKIOS8hlPf+4CxrelIBxGKW
         QfOysiIEVVeGz8I+3fj2RoJuJenMC55iTLtHeDhGtaZKhgm5Uq+6dzGouh0nJQBlv5EV
         w1ig==
X-Gm-Message-State: AC+VfDyeg14CPBv8YmVMwjHj8+XNEQL5K6fnjL+zoKtdLbBPw/f4esd8
        HJhqMBvSMKtsnwjgDmI2h1sTi0HsuHfo6jFfcvE=
X-Google-Smtp-Source: ACHHUZ6IKH5ve5oYE+iYKdrfQG7SgCNq9Ctlt7/21fA4us2kQOtR8diWs/j6A9dlM18qj+W/RtPB9Q==
X-Received: by 2002:a81:1e52:0:b0:55d:9ad7:87a4 with SMTP id e79-20020a811e52000000b0055d9ad787a4mr5697287ywe.2.1683412103083;
        Sat, 06 May 2023 15:28:23 -0700 (PDT)
Received: from [172.20.2.186] ([12.153.103.3])
        by smtp.gmail.com with ESMTPSA id y1-20020a81a101000000b0055a07585a91sm1440675ywg.11.2023.05.06.15.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 15:28:21 -0700 (PDT)
Message-ID: <6be969d0-e941-c8fa-aca7-c6c96f2c1ba2@kernel.dk>
Date:   Sat, 6 May 2023 16:28:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] Pipe FMODE_NOWAIT support
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <26aba1b5-8393-a20a-3ce9-f82425673f4d@kernel.dk>
 <CAHk-=wj=LwLDYrjHpMM+QnE2T+u4P9-UXhXGkAMXiyfGjGnNEA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wj=LwLDYrjHpMM+QnE2T+u4P9-UXhXGkAMXiyfGjGnNEA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/6/23 9:27?AM, Linus Torvalds wrote:
> On Sat, May 6, 2023 at 3:33?AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Here's the revised edition of the FMODE_NOWAIT support for pipes, in
>> which we just flag it as such supporting FMODE_NOWAIT unconditionally,
>> but clear it if we ever end up using splice/vmsplice on the pipe. The
>> pipe read/write side is perfectly fine for nonblocking IO, however
>> splice and vmsplice can potentially wait for IO with the pipe lock held.
> 
> Ok, pulled.
> 
> It does strike me that one of the (few) users is the io_uring
> __io_file_supports_nowait() thing, and that thing is *disgusting*.

Hah yes, will not claim that's a thing of beauty. It has been getting
better though, at least.

> Wouldn't it be much nicer if FMODE_NOWAIT ended up working
> automatically on a block file descriptor too? You did all this "make
> pipes set FMODE_NOWAIT", but then that io_uring code does
> 
>         if (S_ISBLK(mode)) {
>                 if (IS_ENABLED(CONFIG_BLOCK) &&
>                     io_bdev_nowait(I_BDEV(file->f_mapping->host)))
>                         return true;
>                 return false;
>         }
> 
> rather than just rely on FMODE_NOWAIT for block devices too...
> 
> And it's a bit odd in other ways, because the kiocb code for
> RWF_NOWAIT - which is the other user of FMODE_NOWAIT - does *not* seem
> to do any of those bdev games. So that other user does seem to just
> rely on the file mode bit having been set up by open.
> 
> In fact, I see 'blkdev_open()' doing
> 
>         filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
> 
> so I really don't see why __io_file_supports_nowait() then does that
> special check for S_ISBLK().

I need to double check if we can just do the io_bdev_nowait() check
early and in the block code, so we cn make FMODE_NOWAIT reliable there.
With that, yeah we could totally get rid of that odd checking and move
it to the slower open path instead which would obviously be better.

We should just set it for socket as well and just ultimately end up
with:

static bool __io_file_supports_nowait(struct file *file)
{
	if (file->f_flags & O_NONBLOCK)
		return true;
	return file->f_mode & FMODE_NOWAIT;
}

and be done with it. Then we could also stop caching this state in the
io_kiocb flags.

> Something is very rotten in the state of Denmark.

It's the Norwegians, always troublesome.

> But that's all independent of this pipe side, which now looks fine to me.

Thanks, I'll give the nowait side a once-over for the next kernel
release and we can get that looking better too.

-- 
Jens Axboe

