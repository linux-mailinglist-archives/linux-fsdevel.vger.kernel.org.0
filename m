Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C47C6406E43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 17:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhIJPhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 11:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhIJPhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:37:19 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B947C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 08:36:08 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id b7so2847353iob.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 08:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gyzTKbWVdKw+duqrxX3upWkRtBAW8/OkSW9a+m+CMLc=;
        b=gcdu5td+Rm0+7hdaU82rZ/4mqpy4DsK/VK8JXp6rJ4R8/arEGTp8iE3/wJS75uGwFx
         1/Iz3YN1Yd4+mr6xjfsOfXrL6IKKeTJe5q0p1cnXB9vMeQh7MBA/16j2DFQUCilF+Uby
         lhapYk6cbBMvoRvl12V0oZSf5V1zKQ6YyVnOtl+T6CICiLCfKESi71f8IkTlkXCdKdX1
         MvIN48iC0tgFzOLJD8itI3UyteVO3VxDPZQt9Ptzm/Gs9SJvz4rqr836b55MDkHHh9OP
         z7CAn8pSrtMgE7jscAbo5QA+dFYxwnB9aVARuG9xYjVIM62ZbjkGKP9sKzR0XLF2AAWa
         H0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gyzTKbWVdKw+duqrxX3upWkRtBAW8/OkSW9a+m+CMLc=;
        b=LhgnnjaEP4e4KWRtXlwrVF+6ppujNSXHVZh3XX7f38QJp+O+uLrDZrRE7xclB+bCuk
         YPl3x3r6BiDzIDEUCaqdTEdypvEYEHK+kQXC6ak2kHti3r+dY09jS6bnX8QNVbwfAJDY
         mAT0aPJjNwb9ADD7BXnpY5+mFxITsqZohGyY1ujlIZj/TxWoBEzONVpHnohIIVbiN8oo
         KgmlNv/JwVuHNwnAZQWk8BGmN1pA/WF8MRVl+qlEDTu4M+CuOTOQQ7sHpJAVRo3W7ApD
         R4oeJ7nYT9nqT0jpAaL3rSanQZTR9eGMDdzlqw9z+EGCnzaTUMTVjmTwh5oxdqSYa5Hu
         fuYQ==
X-Gm-Message-State: AOAM531grTB8dBPW49yJt55xlWJIj8PPgcHxv8G/+jBf/6zrUApVh5hC
        FRTfc2vawkHEXFfJviDXHH6D6h49VlLKQ8z9TeA=
X-Google-Smtp-Source: ABdhPJz6rNfdCnQQEzMAqjS2AiGV/MUfaB3YhG2ed0Uleegau3IugJcQUoW/aWSd2BxTfzab/jrhlQ==
X-Received: by 2002:a5e:da01:: with SMTP id x1mr7823595ioj.43.1631288167484;
        Fri, 10 Sep 2021 08:36:07 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t14sm2613590ilu.67.2021.09.10.08.36.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 08:36:06 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <YTtu1V1c1emiYII9@zeniv-ca.linux.org.uk>
 <75caf6d6-26d4-7146-c497-ed89b713d878@kernel.dk>
 <YTt6l9gDX+kXwtBW@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <565e8aa7-27e7-4c3c-1a84-4181194c74d8@kernel.dk>
Date:   Fri, 10 Sep 2021 09:36:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTt6l9gDX+kXwtBW@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/21 9:32 AM, Al Viro wrote:
> On Fri, Sep 10, 2021 at 09:08:02AM -0600, Jens Axboe wrote:
> 
>>> You actually can cut it down even more - nr_segs + iov remains constant
>>> all along, so you could get away with just 3 words here...  I would be
>>
>> Mmm, the iov pointer remains constant? Maybe I'm missing your point, but
>> the various advance functions are quite happy to increment iter->iov or
>> iter->bvec, so we need to restore them. From a quick look, looks like
>> iter->nr_segs is modified for advancing too.
>>
>> What am I missing?
> 
> i->iov + i->nr_segs does not change - the places incrementing the former
> will decrement the latter by the same amount.  So it's enough to store
> either of those - the other one can be recovered by subtracting the
> saved value from the current i->iov + i->nr_segs.

Ahh, clever. Yes that should work just fine. Let me test that and send
out a proposal. Thanks Al.

-- 
Jens Axboe

