Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 055C13A7821
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 09:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbhFOHmq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 03:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhFOHmq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 03:42:46 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58C4C0617AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 00:40:41 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d7so1722305edx.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 00:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bD5A1f3b7vRrP0UeIDZmZfmfv9DJp+EPhy9/duz0b6I=;
        b=N26Llwd8SrRempOpdtcKBAmy1pvmFxIeRjrv7uJBq+fyQnnstQ8pnLT/Wzbxadlx4G
         zeWAQ5IOgSsL06m56/+u/nLsoAki7f8EMVhSFqDFiF4VMn3hRC8dt4ldaoqFORGc36i0
         iaPTXBs9otzBIcyw+VGYCJsDK+XLBaYX3pW4Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bD5A1f3b7vRrP0UeIDZmZfmfv9DJp+EPhy9/duz0b6I=;
        b=bUl/YRlFsrqbd78Kr1OABU/H3HLAx30VMS/d5vZ6JNUhzmnk7eA6Yz2eevjy9KCgx6
         ajf5B8zExCRD1L4d1u9vmRVOKpCgxs/CrAAV8wRpC5FYKoAZprWoF1vS0VQEvKxHhECu
         ud5fKhRwE8Iv6hP2R5w32F5KCYULRzsBxOP3wAWYvxbTgI6lsoGlzvlR74DVljLTzc7o
         wLm1X/k04tRZ2iFSzkG6FOailmG3zFulCJ4oNY5OYVGkZgSE8htzhkFppZlFjEw+UWNa
         7cFfJxSkky1hyxqz+Jx54bb20SbIvLfcdEUwB8rd66cHsEb5d4LZh6BPs0fQnXgz3wcO
         ejyA==
X-Gm-Message-State: AOAM533UEEu38giA4Jf6K5m8//aowUdlkFleCGTP4FDME2v0xXz5BvLt
        NpkRwDXo7LLq9Qu1DsOuXmFIlimt2BvdfxgN
X-Google-Smtp-Source: ABdhPJx2vjhd4LwV0XJVM8XQYgW0VgiMdJ+UIchUf/VZ/J2jXsl5B8hBYZ+9Ap7cJYyGZUpqL4jFTA==
X-Received: by 2002:aa7:c983:: with SMTP id c3mr21227017edt.58.1623742840170;
        Tue, 15 Jun 2021 00:40:40 -0700 (PDT)
Received: from [192.168.1.149] ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id ci4sm402545ejc.110.2021.06.15.00.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jun 2021 00:40:39 -0700 (PDT)
Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
To:     Justin He <Justin.He@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20210611155953.3010-1-justin.he@arm.com>
 <20210611155953.3010-4-justin.he@arm.com>
 <4fe3621f-f4a0-2a74-e831-dad9e046f392@rasmusvillemoes.dk>
 <AM6PR08MB4376C7D2EEAF19F4CA636369F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <54b259f2-1dcd-8792-1432-14cd44abb6a5@rasmusvillemoes.dk>
Date:   Tue, 15 Jun 2021 09:40:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <AM6PR08MB4376C7D2EEAF19F4CA636369F7309@AM6PR08MB4376.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 15/06/2021 09.06, Justin He wrote:
> Hi Rasmus
> 
>> -----Original Message-----
>> From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> Sent: Saturday, June 12, 2021 5:40 AM
>> To: Justin He <Justin.He@arm.com>; Petr Mladek <pmladek@suse.com>; Steven
>> Rostedt <rostedt@goodmis.org>; Sergey Senozhatsky
>> <senozhatsky@chromium.org>; Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com>; Jonathan Corbet <corbet@lwn.net>;
>> Alexander Viro <viro@zeniv.linux.org.uk>; Linus Torvalds <torvalds@linux-
>> foundation.org>
>> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>; Eric Biggers
>> <ebiggers@google.com>; Ahmed S. Darwish <a.darwish@linutronix.de>; linux-
>> doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> fsdevel@vger.kernel.org
>> Subject: Re: [PATCH RFCv3 3/3] lib/test_printf: add test cases for '%pD'
>>
>> On 11/06/2021 17.59, Jia He wrote:
>>> After the behaviour of specifier '%pD' is changed to print full path
>>> of struct file, the related test cases are also updated.
>>>
>>> Given the string is prepended from the end of the buffer, the check
>>> of "wrote beyond the nul-terminator" should be skipped.
>>
>> Sorry, that is far from enough justification.
>>
>> I should probably have split the "wrote beyond nul-terminator" check in two:
>>
>> One that checks whether any memory beyond the buffer given to
>> vsnprintf() was touched (including all the padding, but possibly more
>> for the cases where we pass a known-too-short buffer), symmetric to the
>> "wrote before buffer" check.
>>
>> And then another that checks the area between the '\0' and the end of
>> the given buffer - I suppose that it's fair game for vsnprintf to use
>> all of that as scratch space, and for that it could be ok to add that
>> boolean knob.
>>
> Sorry, I could have thought sth like "write beyond the buffer" had been checked by
> old test cases, but seems not.

It does. Before each (sub)test, we have (assume PAD_SIZE=4, BUF_SIZE=12)


|    <- alloced_buffer ->    |
|  PAD |  test_buffer | PAD  |
| **** | ************ | **** |

Then after snprintf(buf, 10, "pizza") we have

|    <- alloced_buffer ->    |
|  PAD |  test_buffer | PAD  |
| **** | pizza0****** | **** |
A      B       C   D         E

(with 0 being the nul character). Then

        if (memchr_inv(alloced_buffer, FILL_CHAR, PAD_SIZE)) {

checks whether snprint wrote anything between A and B, while

        if (memchr_inv(test_buffer + written + 1, FILL_CHAR, BUF_SIZE +
PAD_SIZE - (written + 1))) {

checks whether there was a write between C and E.

What I'm saying is that I can see it being reasonable for (some helper
inside) snprintf to actually write something beyond C, but certainly
never beyond D. So the "wrote beyond" test could be split up, with the
first half possibly being allowed to be opt-out for certain test cases.

> I will split the "wrote beyond nul-terminator" check into 2 parts. One for
> Non-%pD case, the other for %pD.
> 
> For %pD, it needs to check whether the space beyond test_buffer[] is written

No, that's not the right way to do this. Let me cook up a patch you can
include in your series.

Rasmus
