Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D726D3ACC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 00:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDBWWJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Apr 2023 18:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDBWWI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Apr 2023 18:22:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC62B74B
        for <linux-fsdevel@vger.kernel.org>; Sun,  2 Apr 2023 15:22:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id r7-20020a17090b050700b002404be7920aso26632964pjz.5
        for <linux-fsdevel@vger.kernel.org>; Sun, 02 Apr 2023 15:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680474127; x=1683066127;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hdG+oDpQ7Y98KcZVeHhldc4hSlPT2CTaiSVJuf3KDV4=;
        b=5r1zvREdpHsVXnMinBtfUOqLwfMNY3oGgC/NUbUjjlwRVSDgqM6s1htrXjEoaC3REM
         69DJNZ9eR8LNvQ82BwG4xonP+I8OehZy2rPSpbCZNhFziUFPQykpkoE+7WZLar4LyLlb
         DTpWniTWoIByC04FuILbOF++qKf9xsIJD5k3LMLeeELTDd+QSYGydiLSQoa8uMFd70Sa
         tWIc9nBWLWtFz0kF1anEg0MEQ/vyXqlG/vWtG3bkFmPRRvPJ6T2vuhb2lfOVjOEx6An+
         2r9DyZdvLw/SHmC9NkqKjvu3EACuVDW+LSMiICFhzl58Nss5P9vFJ0j5mQ3BvpfmG1/9
         uJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680474127; x=1683066127;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hdG+oDpQ7Y98KcZVeHhldc4hSlPT2CTaiSVJuf3KDV4=;
        b=yApDrtIBzUE6ai4sIUWbTzf+7rwbl7mjKi9krBlTPyTGt1KIPYALFaj+5Zd8xS3QlV
         XoN9hEQrSdTGN5D5TKqfWbnrTqOmIOMWFamoAyG2kyH/3go2nfZ3lbo3M5s0Xh+OiiPE
         HHEQm77FsM89VqTT9qMZbW+khvFg6XtO80LD3+3SFQQ7uck0kGZh0YNDfMTUALAtPvWq
         lVO3IHtXtOHjiMtB6IreVGSf2kAiKih44YWr+BZMS0qNepsNKyzsn9TVCh9KC4l8HlpB
         BuI2RkSH2op4tdON8wPlhynv9iArpwLKXvk7NVyVNF1NhNDrtoIlWng7sgfI6841pRZU
         OhLw==
X-Gm-Message-State: AAQBX9cGk9MChL51VdT0Op9Gbl+TfXiO5G6f5oCLv+j/2pkQdh3N5Tm4
        7GjKkQ0UPqPxyYUa1Mmb23y8vg==
X-Google-Smtp-Source: AKy350bs+LSkSIACt2FFWw+3p6KcdWr1t8SxmHFSosYwoVECOwGXgUp4/xXW6HXH3wMzFid3XulPWw==
X-Received: by 2002:a17:90a:eb12:b0:23b:4bce:97de with SMTP id j18-20020a17090aeb1200b0023b4bce97demr11156467pjz.4.1680474126921;
        Sun, 02 Apr 2023 15:22:06 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090ac24400b002407750c3c3sm4856133pjx.37.2023.04.02.15.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 15:22:06 -0700 (PDT)
Message-ID: <d2447c57-efa0-8f52-e1f5-fd32f4322823@kernel.dk>
Date:   Sun, 2 Apr 2023 16:22:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCHSET v6b 0/11] Turn single segment imports into ITER_UBUF
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-fsdevel@vger.kernel.org, brauner@kernel.org,
        viro@zeniv.linux.org.uk
References: <20230330164702.1647898-1-axboe@kernel.dk>
 <CAHk-=wgmGBCO9QnBhheQDOHu+6k+OGHGCjHyHm4J=snowkSupQ@mail.gmail.com>
 <de35d11d-bce7-e976-7372-1f2caf417103@kernel.dk>
 <CAHk-=wiC5OBj36LFKYRONF_B19iyuEjK2WQFJpyZ+-w39mEN-w@mail.gmail.com>
 <df0f88e5-c0af-5d50-bdd5-b273218861bf@kernel.dk>
In-Reply-To: <df0f88e5-c0af-5d50-bdd5-b273218861bf@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/30/23 4:18 PM, Jens Axboe wrote:
> On 3/30/23 3:53 PM, Linus Torvalds wrote:
>> On Thu, Mar 30, 2023 at 10:33 AM Jens Axboe <axboe@kernel.dk> wrote:
>>>
>>> That said, there might be things to improve here. But that's a task
>>> for another time.
>>
>> So I ended up looking at this, and funnily enough, the *compat*
>> version of the "copy iovec from user" is actually written to be a lot
>> more efficient than the "native" version.
>>
>> The reason is that the compat version has to load the data one field
>> at a time anyway to do the conversion, so it open-codes the loop. And
>> it does it all using the efficient "user_access_begin()" etc, so it
>> generates good code.
>>
>> In contrast, the native version just does a "copy_from_user()" and
>> then loops over the result to verify it. And that's actually pretty
>> horrid. Doing the open-coded loop that fetches and verifies the iov
>> entries one at a time should be much better.
>>
>> I dunno. That's my gut feel, at least. And it may explain why your
>> "readv()" benchmark has "_copy_from_user()" much higher up than the
>> "read()" case.
>>
>> Something like the attached *may* help.
>>
>> Untested - I only checked the generated assembly to see that it seems
>> to be sane, but I might have done something stupid. I basically copied
>> the compat code, fixed it up for non-compat types, and then massaged
>> it a bit more.
> 
> That's a nice improvement - about 6% better for the single vec case,
> And that's the full "benchmark". Here are the numbers in usec for
> the read-zero. Lower is better, obviously.

Linus, are you going to turn this into a proper patch? This is too
good to not pursue.


-- 
Jens Axboe


