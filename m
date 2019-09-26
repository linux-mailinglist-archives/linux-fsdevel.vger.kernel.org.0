Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408FDBF1E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2019 13:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfIZLmO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Sep 2019 07:42:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55369 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbfIZLmN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Sep 2019 07:42:13 -0400
Received: by mail-wm1-f66.google.com with SMTP id a6so2355835wma.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2019 04:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xonFLYW+K9R2/V+E4nxIJtaZUYsUbdcdHfLF2kKtcoo=;
        b=Ps5n17nT4qWciZsC9oJ6IGnJHFHbWG4ZlXnBU/vo5CoFtTTcFz1daOUpKD/ipU4JTw
         ihs76iwMZ80RxUQMFVHFi5rvs5M1rcujs9NFUDyQiF6XVkF7SXmgG5B5WQ8wviB0n/0h
         viAE+GuDsrSXXAsyoxOa/u6wTXedWKEzGWG5iTpCje/HyXMDQP1QKsdJjeT8SaTNVvM9
         i5p1PVAP4pUIcDVmmC2qPUG+ZcG/GbmHpma7NTM9SxfdP5B5FUU7xlF/mHrARsTiCPop
         zVz4CSRj4Q1mP/877rHOBVyN5jMUa4ylMJrwXwyxxRAIiR9nZ+CFHeifrJsIveeE+ygL
         45Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xonFLYW+K9R2/V+E4nxIJtaZUYsUbdcdHfLF2kKtcoo=;
        b=ZO5usb1F1q72aP2bD3ye6wWkO3hIFtckl1mQxWa9jHSQxMuKg+aiFWUL7PeibWkZwQ
         5os3dKV/HcEUtPvLOje2iywNfYGQRqqdxxaROTdFRO+yvrzy224xI9DhtXuqekIqBdNF
         UoRiGamTzD0J5luI8nSPpyw9gUAfkVClbjzVfKgzZcVf9Iq9gNsiXSNTg9neCrwVUD8k
         ZOODrGhSYGqW6baDHsSy5VavkE41nwkBbkTZUzuAsAj/KRFngflFingbG+l0xUOUXKhw
         /1Q3Z++gpI1IqsocR/QNh28n1zad56nYDLW+1/7FHPPNohtWka8dfBiQ/hFzpe/u9M4H
         Nihg==
X-Gm-Message-State: APjAAAVNJUeXT0kN3W6/Xz8ZbuBkFqoTWs3EgeGNJ2ZVVyeiFfJ3tHTu
        pzzX2Hs2gOwh6P2E3iKmR9FGSg==
X-Google-Smtp-Source: APXvYqxnyNJu0dpuhkbD8V2MUn3DG+U46V6RIU4ma0y5/B8D4fyvBCvbpFOmizCk0WSq3Se6YEHEdw==
X-Received: by 2002:a1c:1981:: with SMTP id 123mr2593496wmz.88.1569498129864;
        Thu, 26 Sep 2019 04:42:09 -0700 (PDT)
Received: from [192.168.1.145] ([65.39.69.237])
        by smtp.gmail.com with ESMTPSA id s12sm5719744wra.82.2019.09.26.04.42.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 04:42:09 -0700 (PDT)
Subject: Re: [PATCH][next] io_uring: ensure variable ret is initialized to
 zero
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Colin King <colin.king@canonical.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190926095012.31826-1-colin.king@canonical.com>
 <3aa821ea-3041-fb56-2458-ec643963c511@kernel.dk>
 <20190926113329.GE27389@kadam>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <04262621-68fd-a4bb-ab0c-83954c03fbb0@kernel.dk>
Date:   Thu, 26 Sep 2019 13:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926113329.GE27389@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/26/19 1:33 PM, Dan Carpenter wrote:
> On Thu, Sep 26, 2019 at 11:56:30AM +0200, Jens Axboe wrote:
>> On 9/26/19 11:50 AM, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> In the case where sig is NULL the error variable ret is not initialized
>>> and may contain a garbage value on the final checks to see if ret is
>>> -ERESTARTSYS.  Best to initialize ret to zero before the do loop to
>>> ensure the ret does not accidentially contain -ERESTARTSYS before the
>>> loop.
>>
>> Oops, weird it didn't complain. I've folded in this fix, as that commit
>> isn't upstream yet. Thanks!
> 
> There is a bug in GCC where at certain optimization levels, instead of
> complaining, it initializes it to zero.

That's awfully nice of it ;-)

Tried with -O0 and still didn't complain for me.

$ gcc --version
gcc (Ubuntu 9.1.0-2ubuntu2~18.04) 9.1.0

Tried gcc 5/6/7/8 as well. Might have to go look at what code it's
generating.

-- 
Jens Axboe

