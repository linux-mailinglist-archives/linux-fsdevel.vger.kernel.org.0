Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829E13A4AB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jun 2021 23:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhFKVmL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Jun 2021 17:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbhFKVmK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Jun 2021 17:42:10 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EACDC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 14:40:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r7so24286208edv.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jun 2021 14:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ABviuhyW/gBVQTexifrPt1fY0Rs+xnYdvsKtcFy++I=;
        b=TAqLpamx14JBvqGtI/2jQ2Eo0IVLz9IdRXTnndEV8i5Ld+uo3xauU65J+vvgL6nS72
         KRk3qHuC6bvGvNZZFObgvUk97Bk7WwpnFou11vRM3gzntd2H7PcQMCPdGeeeFClVc2xM
         4D+A1rIJGmpckYp1/xbzfnW4S3yv+FnFJ705Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ABviuhyW/gBVQTexifrPt1fY0Rs+xnYdvsKtcFy++I=;
        b=bktWnf5JPoLDBqmrPHaXFhRnfXmo3m6Rh+df5AWWExugNfZaOU9eeh5OOrPkrfvSls
         MqD/8m/w+Ea8t3Nt6e8Vbye1dNX2kLJmG9gog6hsWRpjZ+WGxUDkN0kwSBfVCw3a+tmS
         pGIgc9Kz+ivFt+3Sue/+ZFqXXx0VhCBzRP9eqp08xeF2eTNtTwBhzpO/WWnFYGBH0XLS
         8NKT/ddwgL05PkrbP4h6mb8RMXedlPNZ2vUIisFQWj7A2ff9+BuJtdmfPUQ7lb1Cr9V+
         teT6Frl5jL0njZLVMjMgP8ihp/3zR8F9VxKkzg+0ol7FRjJ3z4Devw/1hMboSEgBZPL+
         V2uw==
X-Gm-Message-State: AOAM533chRG2Q6r4W9WwaDZn6JH9X5LDBxECe/mlb8YtsIFHnQqQZ93u
        Q3wzCgGqDKQ3U5FDUg422sVSplTQQARRTQ==
X-Google-Smtp-Source: ABdhPJx9Fdu4hX9I8BiaTVaJb1XmF290y13+Vg8YwDR6IXWC/yvFarK1Kxyr972OcXza8etSzJ4lAQ==
X-Received: by 2002:aa7:cf08:: with SMTP id a8mr5735359edy.6.1623447610702;
        Fri, 11 Jun 2021 14:40:10 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id h24sm2467665ejy.35.2021.06.11.14.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 14:40:10 -0700 (PDT)
Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
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
        linux-fsdevel@vger.kernel.org
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-4-justin.he@arm.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <4fe3621f-f4a0-2a74-e831-dad9e046f392@rasmusvillemoes.dk>
Date:   Fri, 11 Jun 2021 23:40:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210611155953.3010-4-justin.he@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/06/2021 17.59, Jia He wrote:
> After the behaviour of specifier '%pD' is changed to print full path
> of struct file, the related test cases are also updated.
> 
> Given the string is prepended from the end of the buffer, the check
> of "wrote beyond the nul-terminator" should be skipped.

Sorry, that is far from enough justification.

I should probably have split the "wrote beyond nul-terminator" check in two:

One that checks whether any memory beyond the buffer given to
vsnprintf() was touched (including all the padding, but possibly more
for the cases where we pass a known-too-short buffer), symmetric to the
"wrote before buffer" check.

And then another that checks the area between the '\0' and the end of
the given buffer - I suppose that it's fair game for vsnprintf to use
all of that as scratch space, and for that it could be ok to add that
boolean knob.

Rasmus
