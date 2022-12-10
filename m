Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D2B64901D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Dec 2022 19:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiLJSLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 10 Dec 2022 13:11:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLJSLP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 10 Dec 2022 13:11:15 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0070140CB
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:11:13 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id 21so5886929pfw.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 10 Dec 2022 10:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RlUxN8rmgSvzDdy4LRfL2aONForfQ9cF+TFfBfJcQUA=;
        b=LwfcbQMpRlZC7N0r/jsvz0Xy+pxtjBqjXQ0YMdqIwK3J54OG/W1ylzMxoHNTU3kSEw
         uI5RyAnXqPe56Lsgwbqjf/IUtavjvIOhhDh3w/7S29Df9Gwm8R9j2H1utFgpncLD3rak
         SpgBZb4IDb6P6dZpRZGpWet8o14iBIAUpzBNx7+srfNYZT6Z6onLsh6mEmP2wtmTX/AK
         UiTg70hSWKUjIPloDn1M4s8Vc3hzOFxe/YeQXjDbyPfA2kQnKEFs1JuFiqJpbf3zfpo1
         SSqOKNgkDC9DThW9DamzrnHhLSB/82PMNwhylhl1jDxpukKJ00B1qXvE7Y2XlFNscIz9
         gG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RlUxN8rmgSvzDdy4LRfL2aONForfQ9cF+TFfBfJcQUA=;
        b=3DcDgInUMjES/RtHNKffhNFJcwfutAJoTm9XwO+qV50Q5dix/CAkPedcDdZzr5Acyh
         p893AlM4nUy0nK14LtGGChzxy4u93oHRzppYiCqRiClJHr1zR720vToRXW/THrjGlXIs
         0aTPCqjWdsxe/UaSqcNlN3HIORp87SF2/xXtunEcoQpcbb8ndrb1DFYnLdxsK1N3yKcM
         oyUPhRpkcPdnCzp3fBQ3sS+x7FYbK8BcJCsNaMXD8GaT9cZbpstdbBmkRu/VJ0PYgn2t
         MDJYmOMmN+SY0pvjUIkfkQNvF9DQYGWT6/dpi3az0dtp8SDvsgfJqeQlaE+b73NkpWZL
         jmig==
X-Gm-Message-State: ANoB5pkIa8CsUwhkbLLaz6JOWhtsbAwLYg4jCFkuNpiPGXjahLn5YLq7
        zpCwdKV406M8CluXpiSdnhUeBKcHcEypEjaBato=
X-Google-Smtp-Source: AA0mqf6L3+JFsfwaXBtr0T+rwzDdd6a0AQJpez9a77nsT3Kc8k7dmSuwi5ZzKpQUJbHT3J5Zf3S4/w==
X-Received: by 2002:a62:86c1:0:b0:577:2a9:7d9f with SMTP id x184-20020a6286c1000000b0057702a97d9fmr2340441pfd.3.1670695873152;
        Sat, 10 Dec 2022 10:11:13 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n14-20020aa7984e000000b0056bcb102e7bsm3029878pfq.68.2022.12.10.10.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Dec 2022 10:11:12 -0800 (PST)
Message-ID: <b2785384-dfc3-a073-523f-4cbf5610f005@kernel.dk>
Date:   Sat, 10 Dec 2022 11:11:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] Writeback fix
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <9f6a8d1a-aa05-626d-6764-99c376722ed7@kernel.dk>
 <CAHk-=wgqkWVi3nm6HJvOOy+GUVmPt9Wun+_ZVp47wZU43FET9w@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wgqkWVi3nm6HJvOOy+GUVmPt9Wun+_ZVp47wZU43FET9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/10/22 10:44?AM, Linus Torvalds wrote:
> On Sat, Dec 10, 2022 at 7:36 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> Just a single writeback fix from Jan, for sanity checking adding freed
>> inodes to lists.
> 
> That's what the commit message says too, but that's not what the patch
> actually *does*.
> 
> It also does that unexplained
> 
> +       if (inode->i_state & I_FREEING) {
> +               list_del_init(&inode->i_io_list);
> +               wb_io_lists_depopulated(wb);
> +               return;
> +       }
> 
> that is new.
> 
> And yes, it has a link: in the commit message. And yes, I followed the
> link in case it had some background.
> 
> And dammit, it's ANOTHER of those stupid pointless and worthless links
> that just links to the patch submission, and has NO ADDITIONAL
> INFORMATION.

I agree that sometimes they are useless, but sometimes there's
discussion on the patch as well in that link. And ideally the patch
itself, when sent to the list, should include the link to the report, if
any. Then you'd get both.

> Those links are actively detrimental. Stop it. I just wasted time
> hoping that there would be some information about why the patch was
> sent to me this late in the game. Instead, I just wated time on it.
> 
> I pulled this and then unpulled it. I'm very very annoyed. This patch
> has an actively misleading commit message, has no explanation for why
> it's so critical that it needs to be sent, and has a useless link to
> garbage.

Just to be clear, this was deliberately held for the 6.2 merge window,
but I can also see that I completely missed that in the pull request.
Sorry about that, that should've been clear.

> Fix the damn explanation to actually match the change. Fix the damn
> link to point to something *useful* like the error report or
> something.

I'll let Jan resubmit this one, just disregard this pull request and
we'll send a new one during the merge window.

> And STOP WASTING EVERYBODY'S TIME with these annoying links that I
> keep hoping would explain something and give useful background to the
> change and instead just are a source of constant disappointment.

For me, applying patches is done by using a script, which is why all
patches get the link. I do think it's worth having the link, because
some of them will indeed have useful discussion. Is it worth it to
manually have to deal with that, in case there's nothing there?

-- 
Jens Axboe

