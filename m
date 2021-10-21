Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAADD43645D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhJUOg7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 10:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUOg5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:36:57 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1E6C0613B9
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 07:34:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id b4-20020a9d7544000000b00552ab826e3aso674931otl.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 Oct 2021 07:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lted8rTnav+M5zSo68ko98JSPN5Kt6zcFl/bn4volRk=;
        b=zfUbmvXIijzXY0ryVQlIPFta6+IJAZgdlnf90i82jJytxvopSHmVsqJwA05xD4r/9q
         FH1ZaOeVSa5vMHsybKUfYUOZF6rb6FlG5bXAci9EbAT4n+rauief0AWf+GadcWWontB2
         mvMLtcQwCvyNmTfUttN/KqT79IW0JFE5etv4ch2zZG1sO5qZBaneVUqMdnDpzWHByfTr
         ILsCGsizY7UUhI1fyw4gBy2euhkd1Hc8n5pd/+qua3wBbLkyum08QnQ6RwOv0agDoTlt
         EMvx6XVz7GpmA8CmxnErTd2BUEdxw5E7Sek3a/j3px/GOzxCyffc+JyudT7Nd+lggEuf
         ASgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lted8rTnav+M5zSo68ko98JSPN5Kt6zcFl/bn4volRk=;
        b=gMVdork7GBItlT1aL3frmy+U2zvGU1u2QzpM/dVlYfPiEjYFq83n7fHaplBO/KG1To
         H1J429S04boqOWTDQRA8aSxFt8oHT6E75MzfFGaIFuFhVYrm92yCCKF0fZ2IoygxRgYz
         S7GzGjgnI6qMO9OTqkzjBakeQDFqUXm6asqKcuhEnHxTGE3FqRZ6aTIqPN6OmLQIuYHM
         +CtIdSCGNHqPKiF51VALWdR+zoLPRreLPzam3m+GYnd3nKma9Fn6skiQonpAWqqvErAZ
         fqQbrjYeZgU2YaT7Bt56zVJOzKmWWmK6x7UdXkpQy9auZKJK0XOTFl2X6kjgEtIbvyhJ
         EjqQ==
X-Gm-Message-State: AOAM533HGw5AxpbLE3EUjOLzsg2Hdy8KIr1Ee+0wh0txfdNxQhhGJi8h
        6XQqYLgANLgCPBX1VtkEI+FjxgzwLHNsVXdp
X-Google-Smtp-Source: ABdhPJy7pEpESXAk37CePNxuy2jMbL6q33sChnT4zUVv5XZXX+0mb1XOW1yUniVxv2ItJ/lNQqK8gQ==
X-Received: by 2002:a9d:17c5:: with SMTP id j63mr5314540otj.191.1634826880557;
        Thu, 21 Oct 2021 07:34:40 -0700 (PDT)
Received: from ?IPv6:2600:380:783a:c43c:af64:c142:4db7:63ac? ([2600:380:783a:c43c:af64:c142:4db7:63ac])
        by smtp.gmail.com with ESMTPSA id k9sm1062185otr.66.2021.10.21.07.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 07:34:40 -0700 (PDT)
Subject: Re: [PATCH v2] fs: replace the ki_complete two integer arguments with
 a single argument
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-aio@kvack.org, linux-usb@vger.kernel.org
References: <4d409f23-2235-9fa6-4028-4d6c8ed749f8@kernel.dk>
 <YXElk52IsvCchbOx@infradead.org> <YXFHgy85MpdHpHBE@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4d3c5a73-889c-2e2c-9bb2-9572acdd11b7@kernel.dk>
Date:   Thu, 21 Oct 2021 08:34:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YXFHgy85MpdHpHBE@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/21/21 4:57 AM, Christoph Hellwig wrote:
> On Thu, Oct 21, 2021 at 01:32:19AM -0700, Christoph Hellwig wrote:
>>> @@ -1436,8 +1436,8 @@ static void aio_complete_rw(struct kiocb *kiocb, long res, long res2)
>>>  		file_end_write(kiocb->ki_filp);
>>>  	}
>>>  
>>> -	iocb->ki_res.res = res;
>>> -	iocb->ki_res.res2 = res2;
>>> +	iocb->ki_res.res = res & 0xffffffff;
>>> +	iocb->ki_res.res2 = res >> 32;
>>
>> This needs a big fat comments explaining the historic context.
> 
> Oh, and please use the upper_32_bits / lower_32_bits helpers.

Incremental, are you happy with that comment?

diff --git a/fs/aio.c b/fs/aio.c
index e39c61dccf37..3674abc43788 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1436,8 +1436,14 @@ static void aio_complete_rw(struct kiocb *kiocb, u64 res)
 		file_end_write(kiocb->ki_filp);
 	}
 
-	iocb->ki_res.res = res & 0xffffffff;
-	iocb->ki_res.res2 = res >> 32;
+	/*
+	 * Historically we've only had one real user of res2, the USB
+	 * gadget code, everybody else just passes back zero. As we pass
+	 * 32-bits of value at most for either value, bundle these up and
+	 * pass them in one u64 value.
+	 */
+	iocb->ki_res.res = lower_32_bits(res);
+	iocb->ki_res.res2 = upper_32_bits(res);
 	iocb_put(iocb);
 }
 
-- 
Jens Axboe

