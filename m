Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F82C8C83
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Nov 2020 19:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388081AbgK3SRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 30 Nov 2020 13:17:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388073AbgK3SRw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:17:52 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9E1C061A47
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 10:16:50 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id q10so10966739pfn.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Nov 2020 10:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zNPV/E/GVDzH5U+Ow7xgO0eNGeZXdhdQWf1tOSwgd2w=;
        b=LXkCbQiHy9b9FLU75B9bwVbtlkgp70lmRg7LgcZjq1q3HONk2XsBEHtwpj6x0UbVSd
         tOQt3L5Ms24SfzhJUD2Hh4Hq8ZVbM9tanve70zbm+CZX89/m/wIX2yVJiA9+BucUpm3C
         9RqSEvRyygmwChyFeIbDQGSN7ns3wCXqSMeXzr0gR+VrIdMp25r2rvN2Pbi+L+JW+0ia
         2T5/3SerPn+Ol9W1YrVzOF/kYhFsALcob+aZki6V2Td6e9//wdMdwnOr9vlhPVlqprNq
         1TYugjyeSyrA7YMKffm8wWkrnBUPF4HyAAQJKJPP6qTMzOvWBvXDn9OBBz7U/zwGswxs
         XQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zNPV/E/GVDzH5U+Ow7xgO0eNGeZXdhdQWf1tOSwgd2w=;
        b=EItokF8Xo29qZpPFdr6Rit1siW0NmKJxIoU7Difl3DoOT4IP4uyVNAgqmc9LQ1LMSA
         K1pRUezMkH+g35Ty/BaN5DbRLrcMA8mj7zN3ymISlnUHtOSvTkfnb75ef2b2FrCQ0Nnu
         nnx+eSR5aKsJ567p1cwL/Sw09He8VR8B98ce52BVZ2fC8Yuh5MBM9XNVgkmIMdp9Wwr6
         5eohUQ3KbwybDwatITF0/0vxZMl1tNIoqkzUJvzZwc9YlJX5nJEJfGDDIrTg2LSOgX1x
         ng0ix7MytVah4pOWkU6W5SDCPV0Lp5q4tnUoj3DaWQ2gI/fOFawOtVOJClhiI1Sx62Ye
         HDeg==
X-Gm-Message-State: AOAM530FcpVDntpsqNbKvkKiTm6zwZI+zUA+MK4BRsZIMoA1l8kZIKF3
        0bN6kyWjhmUiT5ua5pWPD9qvnw==
X-Google-Smtp-Source: ABdhPJymUTrvQI6L+Ma2LDfsq54/WMjLfYOrzgM5E18qNr+D1vYk+BsvKUiYgu+E0KDWsE3N5Yun0Q==
X-Received: by 2002:aa7:91c7:0:b029:197:e389:fb26 with SMTP id z7-20020aa791c70000b0290197e389fb26mr20235917pfa.20.1606760210294;
        Mon, 30 Nov 2020 10:16:50 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id a23sm81119pju.31.2020.11.30.10.16.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 10:16:49 -0800 (PST)
Subject: Re: Lockdep warning on io_file_data_ref_zero() with 5.10-rc5
To:     Pavel Begunkov <asml.silence@gmail.com>,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <C3012989-5B09-4A88-B271-542C1ED91ABE@gmail.com>
 <c16232dd-5841-6e87-bbd0-0c18f0fc982b@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <13baf2c4-a403-41fc-87ca-6f5cb7999692@kernel.dk>
Date:   Mon, 30 Nov 2020 11:16:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c16232dd-5841-6e87-bbd0-0c18f0fc982b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/28/20 5:13 PM, Pavel Begunkov wrote:
> On 28/11/2020 23:59, Nadav Amit wrote:
>> Hello Pavel,
>>
>> I got the following lockdep splat while rebasing my work on 5.10-rc5 on the
>> kernel (based on 5.10-rc5+).
>>
>> I did not actually confirm that the problem is triggered without my changes,
>> as my iouring workload requires some kernel changes (not iouring changes),
>> yet IMHO it seems pretty clear that this is a result of your commit
>> e297822b20e7f ("io_uring: order refnode recycling”), that acquires a lock in
>> io_file_data_ref_zero() inside a softirq context.
> 
> Yeah, that's true. It was already reported by syzkaller and fixed by Jens, but
> queued for 5.11. Thanks for letting know anyway!
> 
> https://lore.kernel.org/io-uring/948d2d3b-5f36-034d-28e6-7490343a5b59@kernel.dk/T/#t
> 
> 
> Jens, I think it's for the best to add it for 5.10, at least so that lockdep
> doesn't complain.

Yeah maybe, though it's "just" a lockdep issue, it can't trigger any
deadlocks. I'd rather just keep it in 5.11 and ensure it goes to stable.
This isn't new in this series.

-- 
Jens Axboe

