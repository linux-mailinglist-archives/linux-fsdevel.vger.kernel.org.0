Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A53373B0F01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 22:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbhFVUyQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Jun 2021 16:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhFVUyP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:54:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB56C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 13:51:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c7so561687edn.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Jun 2021 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZY3YaHE10SpvWGlFOYAiGNFzyBoBoxG7r17DT+vqrXQ=;
        b=Lkkzz8xgvR4WijuDgBCSmNfFcjiHP1ZaGCOPnAYe06FmobkuzmkXtqFUhxHgxT8y8a
         s1e8UekMvWi4xMuXwtVNTsCjRDv+ZvIcJ/sAUbcjE4pCaFOmcM2dvYClmlB/fadIxAUP
         ooLWq5/OVVj4Jl2ULqLpOazUlV7XgDMzD+j8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZY3YaHE10SpvWGlFOYAiGNFzyBoBoxG7r17DT+vqrXQ=;
        b=hEtXU08C0KqX1qXoPBhT1cAz+A7I/dAI1ikUzS0D3WBviiy+wV5Qodi1Cv6T3n1uM/
         sFiJ+Cd44+iGk4Mfr+wGM1rEf8vmf3ldpyCNaWIuhWCWX0Hw1tkzyz+QPFar4WDf8aco
         xP2N06C7YP0Zdclx+zCvZUxIWeWXa22x2uCbnd38uZcXc/AguyVyGGkc/BJNoxNc8EEW
         k1TEVNjCxtPpK9QioQTv34qMb9uSe7P3UsBEKoMqp8PcN8iWi/W5S2Atyc+o8SvbZg0q
         gfkTlKW4pVq74OuqvKUB8A7A/mBZVREm7dVzJPEQjjP/E5SSDuOgPzWlJxF5vyS85WV7
         ZdLw==
X-Gm-Message-State: AOAM530EAByJ1vjsU4ZFHZ0dQDv2Ryv5EG45oAtX0ocdLqjqZpB87tKr
        00onJtD+/yD2Js8UKnk6Z7lsKg==
X-Google-Smtp-Source: ABdhPJx9zQm41CmxJvLsDsSorsOThIixs2MfsXafuymEJPCWCUufv3lIBA9vynUopa82psJxXTYfFA==
X-Received: by 2002:a05:6402:34c6:: with SMTP id w6mr7851532edc.174.1624395117905;
        Tue, 22 Jun 2021 13:51:57 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id g16sm6356357ejh.92.2021.06.22.13.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 13:51:57 -0700 (PDT)
Subject: Re: [PATCH v5 4/4] lib/test_printf.c: add test cases for '%pD'
To:     Jia He <justin.he@arm.com>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>, nd@arm.com
References: <20210622140634.2436-1-justin.he@arm.com>
 <20210622140634.2436-5-justin.he@arm.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <03f59e85-bba3-2e2c-ebaa-48daa93d6fec@rasmusvillemoes.dk>
Date:   Tue, 22 Jun 2021 22:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210622140634.2436-5-justin.he@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/06/2021 16.06, Jia He wrote:
> After the behaviour of specifier '%pD' is changed to print the full path
> of struct file, the related test cases are also updated.
> 
> Given the full path string of '%pD' is prepended from the end of the scratch
> buffer, the check of "wrote beyond the nul-terminator" should be skipped
> for '%pD'.
> 
> Parameterize the new using_scratch_space in __test, do_test to skip the
> test case mentioned above,

I actually prefer the first suggestion of just having a file-global bool.

If and when we get other checks that need to be done selectively [e.g.
"snprintf into a too short buffer produces a prefix of the full string",
which also came up during this discussion but was ultimately kept]
depending on the %<whatever> being exercised, we can add a "u32 nocheck"
with a bunch of bits saying what to elide.

Not insisting either way, just my $0.02.

Rasmus
