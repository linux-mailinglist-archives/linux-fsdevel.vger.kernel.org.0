Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7AA910DC35
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Nov 2019 03:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727225AbfK3CxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Nov 2019 21:53:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36971 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727200AbfK3CxW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Nov 2019 21:53:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id s18so1378713pfm.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Nov 2019 18:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TFNXTUbKkQdsHGg8rEPwlJHNNcDiA6+VrC+v3kUz144=;
        b=lfOifZixgeluiqt9HgkCHU543gbPmc7BLDzlBbbWKA1ABiSYw6UL8lLaPRaOjShWv1
         JG8osba32bC9HTKN7Ztjtz0cEo5l25YLNy4X5NMHl9chdBgF5R81Uj+k60bJsyREy+J0
         z+s5Zm3jLaCHp8vzVfJKAAgkSdAHMfh55hOrLI9OBZt1XCfdG2drmEbiY2OtluNUJl+2
         ug9cwtTW2nSgBfaMjA+FfPl6oTD6H5c5AjqfOILuQc8+XxkRp9hIZGkxDES1+3OXmHG0
         j7JuAJPV01wxz/PLlFvW9qtEDHnL7shZgGzWQQIbqRs5RXT4w40XGIZMUWmTpAgkXojD
         djaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TFNXTUbKkQdsHGg8rEPwlJHNNcDiA6+VrC+v3kUz144=;
        b=UY2zVllGzQOS8+7NXAx65f2KsDhqzRVdG0KFiGHYePTflD/K7roBWHOUopQovwk/aa
         AL/al+Yp9VC+d4HqDKKPWjO90lbdGdYgFFXLXXTPDYmxRSLoLTbmLui3wgROGuvYc5TJ
         CQP/dGMFh9LvHzxPeEvt8Jp5ai1QnvzF1wPVvplnGkfjsjlDKfBdpgwKIrHJSk1wBe3O
         lNsUxn3QP6Fh41MmMjPduBZqqHAdY9rsT8zxgHiaW123UgpcZf/LSxJHlaSn7jP/dFWF
         ze8Baqg3JZqq1lavp0MdHy27UtuKcpuXMxnG4sz45p+rYUfHt2HQ/m1fJSdD+nTBJMLr
         srhA==
X-Gm-Message-State: APjAAAVXI5rf8uuiRM/fkKzu08tFYCGew8S+fFzOHrkYKPxwxtgPalBE
        xFYEuRsA9PyviaHPhtngMXoR4Q==
X-Google-Smtp-Source: APXvYqyMx7MPL9ozDuQ/RDhHO1RF6Kj5cbHzID7wRax8WbQ7SuKgEtc14qT2e+/uyQnCoyp/y/U+Cw==
X-Received: by 2002:a63:ff1e:: with SMTP id k30mr19533259pgi.273.1575082400382;
        Fri, 29 Nov 2019 18:53:20 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:9062:6a04:387d:c19c? ([2605:e000:100e:8c61:9062:6a04:387d:c19c])
        by smtp.gmail.com with ESMTPSA id a26sm25056083pff.155.2019.11.29.18.53.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2019 18:53:19 -0800 (PST)
Subject: Re: [PATCH -next] io_uring: Add missing include <linux/highmem.h>
To:     YueHaibing <yuehaibing@huawei.com>, viro@zeniv.linux.org.uk,
        asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191130015042.17020-1-yuehaibing@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <70275fde-dbf8-4142-87bf-8d2e43564a45@kernel.dk>
Date:   Fri, 29 Nov 2019 18:53:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130015042.17020-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/29/19 5:50 PM, YueHaibing wrote:
> Fix build error:
> 
> fs/io_uring.c:1628:21: error: implicit declaration of function 'kmap' [-Werror=implicit-function-declaration]
> fs/io_uring.c:1643:4: error: implicit declaration of function 'kunmap' [-Werror=implicit-function-declaration]
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 311ae9e159d8 ("io_uring: fix dead-hung for non-iter fixed rw")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   fs/io_uring.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/fs/io_uring.c b/fs/io_uring.c
> index 2c2e8c2..745eb00 100644
> --- a/fs/io_uring.c
> +++ b/fs/io_uring.c
> @@ -69,6 +69,7 @@
>   #include <linux/nospec.h>
>   #include <linux/sizes.h>
>   #include <linux/hugetlb.h>
> +#include <linux/highmem.h>
>   
>   #define CREATE_TRACE_POINTS
>   #include <trace/events/io_uring.h>

Fix for this is already queued up, and now sent to Linus as well:

https://git.kernel.dk/cgit/linux-block/commit/?h=for-linus&id=aa4c3967756c6c576a38a23ac511be211462a6b7

-- 
Jens Axboe

