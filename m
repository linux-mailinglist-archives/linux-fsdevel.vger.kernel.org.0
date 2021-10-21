Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01331436C4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 22:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhJUUnm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhJUUnj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 16:43:39 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F64C061764
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 13:41:22 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bk18so2409283oib.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zYu/XzE61dMqHf6uR2/QbWx7gRoKrMaZmUU9f8DAHPw=;
        b=erpsMOJBVRPBocX2r8KaI4qmlq/SX4EgdaY+ZtYkEOqWmQjRam1maiyODvwQ/EtQ5B
         RUMsgnsOU2i2/BfyrDhrk1RaYKjPiuZW1gsPJPFgb+t7yywAscRsuOxbj2k1ZXV10PmU
         cQBFM7KocDa+jfucuBba+3g5b892mE/mGIXkIUNzbEhRwcKMMuAZ0kfFfgxWrt7x83cJ
         vlo77Lh+T+jvS7ziAuCBL9hLJddJxdss5f3+1gdelFU9QBvGb4ZJwftlUBvws/4iP93A
         P9Tx43hQlhVXWcD7ls+YeKHuWbc8YcN8BQG6MlzK0jdj2Vq+37Ti0v5VLMfnSi4L0Gz5
         x1mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zYu/XzE61dMqHf6uR2/QbWx7gRoKrMaZmUU9f8DAHPw=;
        b=dJCR3XSee96sOrzwpzGqgQFDMXZnCKnAL/5HdvcRZmir6r5tEqPrIP5rf95Wacs6JX
         H9Lbz0E2ItJvihVZHWyS6S3asW8SqFyVIZv+zeBBJLhLAoeAMntsi3Wj7UdvmldwBYe1
         k+7VFJMs9ZugW1KA8jL9+oxEru5TQ5GWQDKTsHSNhzoOf17MvrN1IZAcb3A5BlDNiSvT
         Fccyv07OfT+uOrpmdrGoSs4n+8YoEhqwYgydBFFWSmKoHmPHH5LrtjVSdlxSros/2O4r
         rKOayJJqLsUDsC2LJw0qyV/hMzoeIaMdNHHUSd2bRX0NVOfQsyLLzEyai4M1iOQUcHhZ
         YcrA==
X-Gm-Message-State: AOAM531LitBH6IOO1wqUQeLqI98FMFocPusRNOAfsxew4QyuV6AP22Ry
        37HlBVzojzqyIkuhx//Qh0bDQw==
X-Google-Smtp-Source: ABdhPJxJ+1j42/Jy6Bxk7qm9NcJnUowtZbUgd82CjGbt8EHDWpJAunp0atGG7AaHRM89xSb2ARyc0Q==
X-Received: by 2002:aca:3e86:: with SMTP id l128mr6050189oia.111.1634848882316;
        Thu, 21 Oct 2021 13:41:22 -0700 (PDT)
Received: from [172.20.15.86] (rrcs-24-173-18-66.sw.biz.rr.com. [24.173.18.66])
        by smtp.gmail.com with ESMTPSA id q15sm1228625otk.81.2021.10.21.13.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 13:41:21 -0700 (PDT)
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments with
 a single argument
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
 <YXElk52IsvCchbOx@infradead.org> <YXFHgy85MpdHpHBE@infradead.org>
 <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
 <YXF8X3RgRfZpL3Cb@infradead.org>
 <b7b6e63e-8787-f24c-2028-e147b91c4576@kernel.dk>
 <x49ee8ev21s.fsf@segfault.boston.devel.redhat.com>
 <6338ba2b-cd71-f66d-d596-629c2812c332@kernel.dk>
 <x497de6uubq.fsf@segfault.boston.devel.redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7a697483-8e44-6dc3-361e-ae7b62b82074@kernel.dk>
Date:   Thu, 21 Oct 2021 14:41:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <x497de6uubq.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/21/21 12:05 PM, Jeff Moyer wrote:
> 
>>> I'll follow up if there are issues.
> 
> s390 (big endian, 64 bit) is failing libaio test 21:
> 
> # harness/cases/21.p
> Expected -EAGAIN, got 4294967285
> 
> If I print out both res and res2 using %lx, you'll see what happened:
> 
> Expected -EAGAIN, got fffffff5,ffffffff
> 
> The sign extension is being split up.

Funky, does it work if you apply this on top?

diff --git a/fs/aio.c b/fs/aio.c
index 3674abc43788..c56437908339 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1442,8 +1442,8 @@ static void aio_complete_rw(struct kiocb *kiocb, u64 res)
 	 * 32-bits of value at most for either value, bundle these up and
 	 * pass them in one u64 value.
 	 */
-	iocb->ki_res.res = lower_32_bits(res);
-	iocb->ki_res.res2 = upper_32_bits(res);
+	iocb->ki_res.res = (long) (res & 0xffffffff);
+	iocb->ki_res.res2 = (long) (res >> 32);
 	iocb_put(iocb);
 }
 

-- 
Jens Axboe

