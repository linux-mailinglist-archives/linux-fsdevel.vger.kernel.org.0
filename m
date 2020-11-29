Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBD42C7A5F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Nov 2020 18:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgK2Rsu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Nov 2020 12:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgK2Rst (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Nov 2020 12:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606672043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SrWAJHUZ40Lonyn1Q/nX2kCT++1DHjrIAsCFRqELYdU=;
        b=Cg4+kG8oHvTNl5+X/rRzyjTaTMDx1SKM5lRQ+rgijw4t5Pal2x/8e4+o8olaqkLfu4yVtj
        xuUKeS2eUb6dtPUHKv1Ni428lPWuD0TNzUEKhgvLToJKy17Zh8y5beIokLc6eC0DEdlOBW
        Zg+RkDGfGz2ZIuDTbYZ6+zvhHWYFk+s=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-FOX-lQatOIq5kqB3AdOV0w-1; Sun, 29 Nov 2020 12:47:21 -0500
X-MC-Unique: FOX-lQatOIq5kqB3AdOV0w-1
Received: by mail-qt1-f197.google.com with SMTP id t22so6765801qtq.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 29 Nov 2020 09:47:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=SrWAJHUZ40Lonyn1Q/nX2kCT++1DHjrIAsCFRqELYdU=;
        b=B1sv5bHQbwqXRPOe1GsJIFERBJxCmAIydMCgIFstgkw8IFCiwqmRz3V0B0R+fLar9Y
         flWgiyiFSpeOfJdFpXr1awa2FGrFMJqUrfWw8mQObFjm39a725celNlG2XI4f+M0hUgX
         X8FVHnuegLZHiK+6OLGFDOUZjasfvOkWdCd2AyzDG44ai2/Z0wkfiDf/BurN4uJgLfnG
         XcMVwml9J3EvxRL15uTi6FXmUXgI/iolPmZkbw+0mRma13U0lEuKsaTLPZNq+zEW3/TF
         3uNhsbCJnWYoDm2kfxGmPZZCw/vc+F9smMlq/7j4RhnFIlKZRFZEOsUXExjBQXfZDr4m
         y7Og==
X-Gm-Message-State: AOAM533bjpUMUjHHlWbfdslWDhsrQwAQeJ1ZyhC03WhDSX9/LtYlTNZt
        StgZuqbD2xeUFK9XD3RPgq37Xqe2K/cso/RVcnT9bfSBGhhffC7c6+2b3VWvLOOrCP2F1SC0slc
        S8WZRV7sP5QvdnjEK+1gQLne6Tg==
X-Received: by 2002:a37:d8a:: with SMTP id 132mr18865356qkn.332.1606672040682;
        Sun, 29 Nov 2020 09:47:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzn0xr4NyRhZFuipBRx/ScZBKeoKjxhE39f7KA13T6baPcGbruIJugXlMTwBH68yZ5MAhJD3A==
X-Received: by 2002:a37:d8a:: with SMTP id 132mr18865344qkn.332.1606672040491;
        Sun, 29 Nov 2020 09:47:20 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 14sm1559247qkk.128.2020.11.29.09.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Nov 2020 09:47:19 -0800 (PST)
Subject: Re: [PATCH] locks: remove trailing semicolon in macro definition
To:     Matthew Wilcox <willy@infradead.org>
Cc:     jlayton@kernel.org, bfields@fieldses.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201127190707.2844580-1-trix@redhat.com>
 <20201127195323.GZ4327@casper.infradead.org>
From:   Tom Rix <trix@redhat.com>
Message-ID: <8e7c0d56-64f3-d0b6-c1cf-9f285c59f169@redhat.com>
Date:   Sun, 29 Nov 2020 09:47:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201127195323.GZ4327@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 11/27/20 11:53 AM, Matthew Wilcox wrote:
> On Fri, Nov 27, 2020 at 11:07:07AM -0800, trix@redhat.com wrote:
>> +++ b/fs/fcntl.c
>> @@ -526,7 +526,7 @@ SYSCALL_DEFINE3(fcntl64, unsigned int, fd, unsigned int, cmd,
>>  	(dst)->l_whence = (src)->l_whence;	\
>>  	(dst)->l_start = (src)->l_start;	\
>>  	(dst)->l_len = (src)->l_len;		\
>> -	(dst)->l_pid = (src)->l_pid;
>> +	(dst)->l_pid = (src)->l_pid
> This should be wrapped in a do { } while (0).
>
> Look, this warning is clearly great at finding smelly code, but the
> fixes being generated to shut up the warning are low quality.
>
Multiline macros not following the do {} while (0) pattern are likely a larger problem.

I'll take a look.

Thanks,

Tom

