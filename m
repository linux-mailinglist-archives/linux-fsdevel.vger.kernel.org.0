Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C930E17980E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 19:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730243AbgCDShs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Mar 2020 13:37:48 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43308 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbgCDShs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Mar 2020 13:37:48 -0500
Received: by mail-io1-f65.google.com with SMTP id n21so3507855ioo.10
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Mar 2020 10:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wh0qFjW/qHneQSqg+QQx1XFOZYzFNeLir404hhmmk8A=;
        b=iB6D5KmyEc3L8QegN7XRaZrSaz+3zxQkc9SriWcXcKD5qmINgB237OLXeEG3VIIufZ
         FvcVyrcvqBEKHtgKJcOPxk0q0ghNUJPqL6gHXxeQS+vZsIYY1oT2XqA8KYFBZgY7xzlt
         QzDuoRgNtzNN14mC1S1RlEXMdj7luaqoLjH9jbn033e2Yg7yKPLpYDUQ68orP1GLOokD
         HAaRyA4w3EhgOHVDb8fzIQbNZEIKGKas0uXpvco/6TWXkYyYAn4/WQr+1trfzaAyM4Xv
         5UraL+b08FmBCu5kqtheb1dGuTsE8WJEUNQixqV6yuvc4jdNKDeXf+OZVhlQyPtyx8pb
         JkpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wh0qFjW/qHneQSqg+QQx1XFOZYzFNeLir404hhmmk8A=;
        b=WkHgK6g32RGYQqeNh2duOdLC4NECcBbzQIEcRemq6oV/y8mteWs2OmhA7MBPOpRAeM
         xH1aI125ZDfNwXElv28oQcfspJNMVZGo3KNmpa23kY36rBvEoiJrxWaRY5wx2EaCUNx1
         z80gHMgrG5VFfW1cLcdr7iBdI4C97mNkRUhEjg8PL7Uv/AoWeTDQmabl+jT0v73T7jgm
         +5d1k8OC5+znnOBBO4/YfSDNO4NfYPMya1QM8s057dFcHs/TDIY3rB51mp28Mjrt+Lmy
         /p7iUkrcx8oAl6Lrto5vioq4t8BYJU0LuBEA4IH7O25q1v9RGW+YVFvgQY17hQzZi7pv
         JQCQ==
X-Gm-Message-State: ANhLgQ05TydxRsGW3Xzs5KrGuRRJB8agXqrAZhg+5SOYQDTOwQIkix3t
        DUwztX92Ae3oz3OmqtZhjcpXUQ==
X-Google-Smtp-Source: ADFU+vsarnSkFGccdJ+tjh1uW/LPY+9/izVSa2ywAEhv/Y2brEmeYq0uF0XYMk03CKqAXA5hAXDoOg==
X-Received: by 2002:a02:780f:: with SMTP id p15mr3875002jac.91.1583347066713;
        Wed, 04 Mar 2020 10:37:46 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id h14sm2049272iow.23.2020.03.04.10.37.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 10:37:46 -0800 (PST)
Subject: Re: [PATCH -next] io_uring: Fix unused function warnings
To:     Stefano Garzarella <sgarzare@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Cc:     viro@zeniv.linux.org.uk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200304075352.31132-1-yuehaibing@huawei.com>
 <20200304164806.3bsr2v7cvpq7sw5e@steredhat>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5a1c612a-9efa-1fc8-e264-1a064d4a4435@kernel.dk>
Date:   Wed, 4 Mar 2020 11:37:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304164806.3bsr2v7cvpq7sw5e@steredhat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/4/20 9:48 AM, Stefano Garzarella wrote:
> On Wed, Mar 04, 2020 at 03:53:52PM +0800, YueHaibing wrote:
>> If CONFIG_NET is not set, gcc warns:
>>
>> fs/io_uring.c:3110:12: warning: io_setup_async_msg defined but not used [-Wunused-function]
>>  static int io_setup_async_msg(struct io_kiocb *req,
>>             ^~~~~~~~~~~~~~~~~~
>>
>> There are many funcions wraped by CONFIG_NET, move them
>> together to simplify code, also fix this warning.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  fs/io_uring.c | 98 ++++++++++++++++++++++++++++++++++-------------------------
>>  1 file changed, 57 insertions(+), 41 deletions(-)
>>
> 
> Since the code under the ifdef/else/endif blocks now are huge, would it make
> sense to add some comments for better readability?
> 
> I mean something like this:
> 
> #if defined(CONFIG_NET)
> ...
> #else /* !CONFIG_NET */
> ...
> #endif /* CONFIG_NET */

I applied it with that addition. Also had to adapt it quite a bit, as
the prototypes changed. I'm guessing the branch used was a few days
old?

-- 
Jens Axboe

