Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3014026323D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 18:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbgIIQh7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 12:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731232AbgIIQhn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:37:43 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140D6C06135B
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2020 07:03:35 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l4so2431243ilq.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2020 07:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kCsxeCMw67opcoElUs8hZzWLlvUYaz8JdahayB2RUI4=;
        b=y8KsdU2xS4h9wwHh/xYDwErwKAwdbag1RHnw+sM66m/fustnVCcke5hzrzLLhpqjyI
         gAKCWN9X6Ps6x4mAijLqE21trmg9mvsJQ6ZXE0ar9XW5AIXWCAZTNu+/gqEJ6wq0O0gL
         AzlVewdt+lb/VWNKuLkTogy0q7/FP96IucjOTs0oY3gRRxpBURUZKYXuGXdIarA/8MZG
         bVbuGmOJ4V48/zvhddDGTpiR5+vFcOkBtV4tQZyGNtf7K6xTmUEgpvSiEmEAXSDc32oN
         uTt5aC7e2b47Bf/C77XLGczztZb6xRGZ3YIqp8kpjfAi8rNQJ7u+jP0IMx/wbKphG5W1
         NfiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kCsxeCMw67opcoElUs8hZzWLlvUYaz8JdahayB2RUI4=;
        b=txFJgEKdhXbcLYM/QSD62Qyr8YmjWlMxa8wopRpUTcnXGWXGY3sQjf2C5TKEtvCZcL
         +iH4zZVoNSX/IcKBEU6753WkXQpoEX3V5o7tv365sgI0jLcyfSzAEtI+LLsI9EsFL1gQ
         E116PtIc9mTVWUs+VPxbNvTODk33QFw5G8smZDB8Bh4ut755QmZ9XrCZ0dkG0CBIAS7P
         FUCDet9CM8KInRpzfuVHHx/d2apGclGGQ/MiESNZTd59dyqjR2rkZMpxVmx9dNux0ppN
         Rp2NNonoHfDzLkEOhXngBYpRwmMVNJVcciTGHVy6XzlfyjQ1Cj5pNoI5hC81gKvWI+Ju
         4pig==
X-Gm-Message-State: AOAM530sx+MW2CGq9I5XqDJ4Q1cRb9K5/m5OJPYR1Q6TYrpcnwywXtUR
        JcmbU931JZa+/c7+FZPCAVywtA==
X-Google-Smtp-Source: ABdhPJywiqVd3crHHoKQ2WPdED4AxcZSebQ/f1P0yVO+Jydm2uWgdHboDeu9R4fZh5S89cAdslOriA==
X-Received: by 2002:a92:985a:: with SMTP id l87mr3668939ili.2.1599660214146;
        Wed, 09 Sep 2020 07:03:34 -0700 (PDT)
Received: from [192.168.1.10] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c2sm1464286ilo.7.2020.09.09.07.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 07:03:33 -0700 (PDT)
Subject: Re: INFO: task hung in io_sq_thread_stop
To:     Stefano Garzarella <sgarzare@redhat.com>,
        syzbot <syzbot+3c23789ea938faaef049@syzkaller.appspotmail.com>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <00000000000030a45905aedd879d@google.com>
 <20200909100355.ibz4jc5ctnwbmy5v@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <fa8f11bf-d0e6-42b9-0a2e-2bb4c8679b99@kernel.dk>
Date:   Wed, 9 Sep 2020 08:03:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909100355.ibz4jc5ctnwbmy5v@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/9/20 4:03 AM, Stefano Garzarella wrote:
> On Wed, Sep 09, 2020 at 01:49:22AM -0700, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    dff9f829 Add linux-next specific files for 20200908
>> git tree:       linux-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=112f880d900000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=37b3426c77bda44c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3c23789ea938faaef049
>> compiler:       gcc (GCC) 10.1.0-syz 20200507
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c082a5900000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1474f5f9900000
>>
>> Bisection is inconclusive: the first bad commit could be any of:
>>
>> d730b1a2 io_uring: add IOURING_REGISTER_RESTRICTIONS opcode
>> 7ec3d1dd io_uring: allow disabling rings during the creation
> 
> I'm not sure it is related, but while rebasing I forgot to update the
> right label in the error path.
> 
> Since the check of ring state is after the increase of ctx refcount, we
> need to decrease it jumping to 'out' label instead of 'out_fput':
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index d00eb6bf6ce9..f35da516095a 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -8649,7 +8649,7 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned int, fd, u32, to_submit,
>                 goto out_fput;
> 
>         if (ctx->flags & IORING_SETUP_R_DISABLED)
> -               goto out_fput;
> +               goto out;
> 
>         /*
>          * For SQ polling, the thread will do all submissions and completions.
> 
> I'll send a patch ASAP and check if it solves this issue.

I think that's a separate bug, it's definitely a bug. So please do send
the fix, thanks.

-- 
Jens Axboe

