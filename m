Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F30BA138489
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Jan 2020 03:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbgALCQs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jan 2020 21:16:48 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34330 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731948AbgALCQs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jan 2020 21:16:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so198230plq.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jan 2020 18:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vGIDhMkgk6Yxk9hwcJUbeiuGdVTEJQSdVtxa8Ksgq0I=;
        b=VKTp20o6e1570ly+OroArEs2yK8TRc8zTn1AM6UonyvsiELOT9JRoatzH/zDEmSSMm
         cZnrNwagysbC84XUWOWPzvMrktG1nStCemX63kEVM3lp/r+rJBZCGlgHLKcu875h3DiQ
         R7jIoghHxClJEGkWH9X/+Q6ZdWgrqmlo5TzSLZAOzwyU1pOpWeWL8QnXbLCppCyr9Pky
         UK80Lo90j88hbqJs+KdVCEtw0qt1j0GVrybB6Wwf0CfzgrZwOLcgry2h1+6UtgOwZODv
         Kkz7eS0klJasPiUkf2w89ct2lqGatlEw8nLm4Y1lzhB/zTi0hXC47ttMVtI0yVLjwZEu
         xN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vGIDhMkgk6Yxk9hwcJUbeiuGdVTEJQSdVtxa8Ksgq0I=;
        b=ZYWhK0zP8pUkjsURzST6ZIXtk8FSVbSK1jIKD4FsHJ3slADQlWVFnddCn65KgJrEgX
         /SsgUK+GYrMEdfWglx174liO5c5Af6LdbH06+CT9s+K5RHaK8ScC0GM7sm7IccNFVtcL
         B6hMs3fyC7To+jLf29uE9V+8QuMdzIMInKGDQvWON+Lm6UlM4DMmCRrTuZNaM7bSNNjs
         BZK3OBxngHWScD4jYf7+4g7Uh+HqYoRl+WhDoypZJskKMTNhcWo0TPjcw9/oMS3PWTy7
         wCKiQ91PB71nIvjUIhrI4jRePH7d9wyctx/RfRqZ0BpHRHOyT9jb8lcWKBdWzUZG5m+J
         WyJw==
X-Gm-Message-State: APjAAAUiFa4Hoaoy3nciOhF+0YJT08C4OYiTp5X9IAhg3ZXZMTW+IsH9
        Y8fg9Z+lqu0FP0mcAFDVzh2bb4gpZ0c=
X-Google-Smtp-Source: APXvYqyv1LeI+xjOOHaKKiHuxN7/X39asnC3k5SnqhpCRcLo0rDk59XFNfJqk0XKBHd6prsa49uoxQ==
X-Received: by 2002:a17:90a:ead3:: with SMTP id ev19mr15035309pjb.80.1578795407788;
        Sat, 11 Jan 2020 18:16:47 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id x22sm8389504pgc.2.2020.01.11.18.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2020 18:16:47 -0800 (PST)
Subject: Re: [PATCH 3/3] io_uring: add IORING_OP_MADVISE
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20200110154739.2119-1-axboe@kernel.dk>
 <20200110154739.2119-4-axboe@kernel.dk> <20200111231014.bmpxdg2juw3mxiwr@box>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cea0337c-0ce7-b390-44ab-9f064894ca3d@kernel.dk>
Date:   Sat, 11 Jan 2020 19:16:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200111231014.bmpxdg2juw3mxiwr@box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/11/20 4:10 PM, Kirill A. Shutemov wrote:
> On Fri, Jan 10, 2020 at 08:47:39AM -0700, Jens Axboe wrote:
>> This adds support for doing madvise(2) through io_uring. We assume that
>> any operation can block, and hence punt everything async. This could be
>> improved, but hard to make bullet proof. The async punt ensures it's
>> safe.
>>
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> How capability checks work with io_uring?
> 
> MADV_HWPOISON requires CAP_SYS_ADMIN and I just want to make sure it will
> not open a way around.

There are two ways the request can get invoked from io_uring:

1) Inline from the system call, personality is the application (of course)
   in that case.

2) Async helper, personality (creds, mm, etc) are inherited from the ring.

So it should be totally safe, and madvise is no different than the other
system calls supported in that regard.

-- 
Jens Axboe

