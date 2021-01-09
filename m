Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C1F2F03C8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Jan 2021 22:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbhAIVXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Jan 2021 16:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbhAIVXi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Jan 2021 16:23:38 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4DAC061786;
        Sat,  9 Jan 2021 13:22:57 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m5so12348673wrx.9;
        Sat, 09 Jan 2021 13:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:autocrypt:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iP6jdSrEIvs6QoMn2cu5NB0UNju0LTAMeY6eTdHyraM=;
        b=u3rrVh0aQFszWoyxflDGE/fvQ6TBIwV04ZSYqY3/jAqcU/YHp3nax0JuI5BV7whtgm
         QKXlKB4oxRNmla6ddJ78xgGqsFqvq0b7jvz9soUH8arxMWuZjj1nucytWSjfmNTAgBcU
         pA/L8fxbsGaaZq47HEwMwvkw9h8AdLFMTK3Mqh2BAOXCzzndgVsdkHPjFtt3gKFYiQdr
         GE8BG3HJ6EnbceaTz0xpBgRcEgDuAYMnqZSAbCmOO1JfDgcxdo3ETdHXn7ik5q5obuat
         wAZh87cYEJu7OuSuWoMV3RaDwNsH5WnwQouttITiBfriOqKtTfu1zwmBMS/zAa5g+Hfj
         2A2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=iP6jdSrEIvs6QoMn2cu5NB0UNju0LTAMeY6eTdHyraM=;
        b=hC3QNEiFZNGD8qG3Yh7yBL7LAW2Ysyog9/ewYpHkHPBNrZkMN5f8ot7mAe/4GFCHeJ
         7Rawu7JD3iX7cZ6MJLSIHZzcTyylGR13yzi4v1L2oJwOE+dpnNzezRTHmwdR7zsr0SJb
         BfzDirwds3V4/Vndkk9MtPr0/twbtcUDgVW6n8r0BHkPX3bGV4KzS+d5GebJlSi/McGB
         K/QAzcJJLpZzZm0SRJEMETXS0dJrnwzOUuDch24RZpSsp9PZrlp4lR5L7VT3sVVpCtPZ
         V+h7F59Lntqguh55zHQFPcJbvstESFJV7yz4/KOVciapaMsmpKMAaogXIlWzkPDEcPBA
         EcJA==
X-Gm-Message-State: AOAM531ZTkyUZpIilqMXW5OGA0VHdZ4ScvW3Fr6cVh5FUdlydEq09j4F
        THELfC6nRpQrbxgtq7dHBwdJMRlXSZ4cuNHZ
X-Google-Smtp-Source: ABdhPJz77c/KhL859B1V6/ReEX20i4IlxS6rvSXhodVoZzycjlbD3JYQlksX5tO6BPFHb3R3jIzF5g==
X-Received: by 2002:adf:a4cf:: with SMTP id h15mr9564817wrb.13.1610227373990;
        Sat, 09 Jan 2021 13:22:53 -0800 (PST)
Received: from [192.168.8.114] ([85.255.237.6])
        by smtp.gmail.com with ESMTPSA id k10sm17492671wrq.38.2021.01.09.13.22.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jan 2021 13:22:53 -0800 (PST)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-kernel@vger.kernel.org
References: <a8cdb781384791c30e30036aced4c027c5dfea86.1605969341.git.asml.silence@gmail.com>
 <6e795064-fdbd-d354-4b01-a4f7409debf5@gmail.com>
 <54cd4d1b-d7ec-a74c-8be0-e48780609d56@gmail.com>
 <20210109170359.GT3579531@ZenIV.linux.org.uk>
From:   Pavel Begunkov <asml.silence@gmail.com>
Autocrypt: addr=asml.silence@gmail.com; prefer-encrypt=mutual; keydata=
 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 bA==
Subject: Re: [PATCH] iov_iter: optimise iter type checking
Message-ID: <93388ab0-abbd-a680-66e0-e1ba77981479@gmail.com>
Date:   Sat, 9 Jan 2021 21:19:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20210109170359.GT3579531@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09/01/2021 17:03, Al Viro wrote:
> On Sat, Jan 09, 2021 at 04:09:08PM +0000, Pavel Begunkov wrote:
>> On 06/12/2020 16:01, Pavel Begunkov wrote:
>>> On 21/11/2020 14:37, Pavel Begunkov wrote:
>>>> The problem here is that iov_iter_is_*() helpers check types for
>>>> equality, but all iterate_* helpers do bitwise ands. This confuses
>>>> compilers, so even if some cases were handled separately with
>>>> iov_iter_is_*(), corresponding ifs in iterate*() right after are not
>>>> eliminated.
>>>>
>>>> E.g. iov_iter_npages() first handles discards, but iterate_all_kinds()
>>>> still checks for discard iter type and generates unreachable code down
>>>> the line.
>>>
>>> Ping. This one should be pretty simple
>>
>> Ping please. Any doubts about this patch?
> 
> Sorry, had been buried in other crap.  I'm really not fond of the
> bitmap use; if anything, I would rather turn iterate_and_advance() et.al.
> into switches...
> 
> How about moving the READ/WRITE part into MSB?  Checking is just as fast
> (if not faster - check for sign vs. checking bit 0).  And turn the
> types into straight (dense) enum.

Didn't realise that approach before, sounds good. Most of it will be
replaced with sign jcc, and the rest will be (t >> 31) or movcc, so it
should not be of concern.

type_mask = 255;
iov_iter_type(i) { return i->type & ~type_mask; }

I hope this stuff won't add much, because the original patch completely
optimises this "&" out. I guess it'll turn into extra

xor m m
notb8 m
and m & type

> 
> Almost all iov_iter_rw() callers have the form (iov_iter_rw(iter) == READ) or
> (iov_iter_rw(iter) == WRITE).  Out of 50-odd callers there are 5 nominal
> exceptions:
> fs/cifs/smbdirect.c:1936:                        iov_iter_rw(&msg->msg_iter));
> fs/exfat/inode.c:442:   int rw = iov_iter_rw(iter);
> fs/f2fs/data.c:3639:    int rw = iov_iter_rw(iter);
> fs/f2fs/f2fs.h:4082:    int rw = iov_iter_rw(iter);
> fs/f2fs/f2fs.h:4092:    int rw = iov_iter_rw(iter);
> 
> The first one is debugging printk
>         if (iov_iter_rw(&msg->msg_iter) == WRITE) {
>                 /* It's a bug in upper layer to get there */
>                 cifs_dbg(VFS, "Invalid msg iter dir %u\n",
>                          iov_iter_rw(&msg->msg_iter));
>                 rc = -EINVAL;
>                 goto out;
>         }
> and if you look at the condition, the quality of message is
> underwhelming - "Data source msg iter passed by caller" would
> be more informative.
> 
> Other 4...  exfat one is
>         if (rw == WRITE) {
> ...
> 	}
> ...
>         if (ret < 0 && (rw & WRITE))
>                 exfat_write_failed(mapping, size);
> IOW, doing
> 	bool is_write = iov_iter_rw(iter) == WRITE;
> would be cleaner.  f2fs.h ones are
> 	int rw = iov_iter_rw(iter);
> 	....
> 	if (.... && rw == WRITE ...
> so they are of the same sort (assuming we want that local
> variable in the first place).
> 
> f2fs/data.c is the least trivial - it includes things like
>                 if (!down_read_trylock(&fi->i_gc_rwsem[rw])) {
> and considering the amount of other stuff done there,
> I would suggest something like
> 	int rw = is_data_source(iter) ? WRITE : READ;
> 
> I'll dig myself from under ->d_revalidate() code review, look
> through the iov_iter-related series and post review, hopefully
> by tonight.

Great, thanks Al. Without it being optimised right my other patches keep
worsening iov_iter, and I obviously want to avoid that.

-- 
Pavel Begunkov
