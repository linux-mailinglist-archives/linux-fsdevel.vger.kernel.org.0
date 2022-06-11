Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D83A25472C2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Jun 2022 10:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiFKIGY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 11 Jun 2022 04:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFKIGX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:06:23 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DF4C7AE;
        Sat, 11 Jun 2022 01:06:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a15so1231980wrh.2;
        Sat, 11 Jun 2022 01:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PcMyrMkeBq8FtDR9Ah+GKvDRw37wZQSxisNv3VbSxF8=;
        b=VDanKS2aPNxEPD5gHHW3YO7eybeGWHt49VN3wMDZarFEdbZywtZanpzYHolibuSgHo
         txN2heXPtUPZyZBdgRvwXaYcOVqigfgho+MuucKKg8YRX5hRDSDbV2sUsSVGMozHxCez
         cAMPw9hLl6JfXxid1Fm2oOJ1bU7R0pq99NyyOAju9w7veIBu10IusWNm1Ib1mywc3MBN
         JC7wuCDUDwt6aGszDEkUObBsev4hlStTmbJX7Pr9yBfezUDTR7a/S2C3fzxRQW3b/DKV
         vQH6tk3Uxk7jxkep6/tBDg/gRPFIF/MOOWhXzLSF7CZwI2b9+eoXzorlWss0DAbJLMeV
         Z/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PcMyrMkeBq8FtDR9Ah+GKvDRw37wZQSxisNv3VbSxF8=;
        b=d8CjCHsumrQM6LvlUjSG6bKGoVvQQUEXwnRykLijif2NHIjAYEZ1JXXBHbZoEDqZtO
         n/ybvRchep6GCO0hF1xUv8OYYA/tfmlQden4MN8QvNU4D2YmrMADR4XjStY1BIKzQOL2
         6OLW0i5lWUaXhtQtkYi640AODPOlPLwMtuPyJM0WbxwEasrbhTY1d9it5XFh9gmtNvf6
         qDYIo4MFS/o5y/94NM+9OVIccG0XoYrXWqZlMjQhWNNv55CSvxycfpRHkM5rW4Kmkk0X
         Z0pVwO8dN8QuJ2llcPPaLuEJN2/NK4PRCzZJNUNnu7hBGrHXv/j+qWxeSOAvIrkhCBPE
         s4zA==
X-Gm-Message-State: AOAM5325Xt3plpfr7mrNTGhxSTihQrGHIc+ydm74cZnoFtDGtMedPw/H
        rw7JLvt8/6ZR7FT+89HEOiM=
X-Google-Smtp-Source: ABdhPJxOGwCLeulpLrfjSocHTBSjkFkIa8LIlAZvPBEKMl+ZSwhdQvggONhSb/e759HwNYTLN0sK/Q==
X-Received: by 2002:adf:f706:0:b0:20e:6788:c2b6 with SMTP id r6-20020adff706000000b0020e6788c2b6mr47847880wrp.633.1654934780444;
        Sat, 11 Jun 2022 01:06:20 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:285a:43cd:3b2c:3f3c? ([2a02:908:1256:79a0:285a:43cd:3b2c:3f3c])
        by smtp.gmail.com with ESMTPSA id m6-20020adfe0c6000000b0021024f82e01sm1783833wri.16.2022.06.11.01.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 01:06:19 -0700 (PDT)
Message-ID: <288528c3-411e-fb25-2f08-92d4bb9f1f13@gmail.com>
Date:   Sat, 11 Jun 2022 10:06:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 03/13] mm: shmem: provide oom badness for shmem files
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        alexander.deucher@amd.com, daniel@ffwll.ch,
        viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        hughd@google.com, andrey.grodzovsky@amd.com
References: <YqG67sox6L64E6wV@dhcp22.suse.cz>
 <77b99722-fc13-e5c5-c9be-7d4f3830859c@amd.com>
 <YqHuH5brYFQUfW8l@dhcp22.suse.cz>
 <26d3e1c7-d73c-cc95-54ef-58b2c9055f0c@gmail.com>
 <YqIB0bavUeU8Abwl@dhcp22.suse.cz>
 <d4a19481-7a9f-19bf-c270-d89baa0970fc@amd.com>
 <YqIMmK18mb/+s5de@dhcp22.suse.cz>
 <3f7d3d96-0858-fb6d-07a3-4c18964f888e@gmail.com>
 <YqMuq/ZrV8loC3jE@dhcp22.suse.cz>
 <2e7e050e-04eb-0c0a-0675-d7f1c3ae7aed@amd.com>
 <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YqNSSFQELx/LeEHR@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am 10.06.22 um 16:16 schrieb Michal Hocko:
> [...]
>>> The primary question is whether it actually helps much or what kind of
>>> scenarios it can help with and whether we can actually do better for
>>> those.
>> Well, it does help massively with a standard Linux desktop and GPU workloads
>> (e.g. games).
>>
>> See what currently happens is that when games allocate for example textures
>> the memory for that is not accounted against that game. Instead it's usually
>> the display server (X or Wayland) which most of the shared resources
>> accounts to because it needs to compose a desktop from it and usually also
>> mmaps it for fallback CPU operations.
> Let me try to understand some more. So the game (or the entity to be
> responsible for the resource) doesn't really allocate the memory but it
> relies on somebody else (from memcg perspective living in a different
> resource domain - i.e. a different memcg) to do that on its behalf.
> Correct? If that is the case then that is certainly not fitting into the
> memcg model then.

More or less: yes, that is one possible use case.  But we could leave 
that one out since it is not the primary use case.

What happens more is that 99% of the resources are only allocated per 
process, but around 1% are shared with somebody else.

But see two comments below of a better description of the problem I'm 
facing.

> I am not really sure there is any reasonable model where you cannot
> really tell who is responsible for the resource.

Well it would be fine with me to leave out those 1% of resources shared 
with different memcgs.

What breaks my neck are those 99% which are allocated by a game and 
could potentially be shared but are most of the time not.

>> So what happens when a games over allocates texture resources is that your
>> whole desktop restarts because the compositor is killed. This obviously also
>> kills the game, but it would be much nice if we would be more selective
>> here.
>>
>> For hardware rendering DMA-buf and GPU drivers are used, but for the
>> software fallback shmem files is what is used under the hood as far as I
>> know. And the underlying problem is the same for both.
> For shmem files the end user of the buffer can preallocate and so own
> the buffer and be accounted for it.

The problem is just that it can easily happen that one process is 
allocating the resource and a different one freeing it.

So just imaging the following example: Process opens X window, get 
reference to the handle of the buffer backing this window for drawing, 
tells X to close the window again and then a bit later closes the buffer 
handle.

In this example the X server would be charged allocating the buffer and 
the client (which is most likely in a different memcg group) is charged 
freeing it.

I could of course add something to struct page to track which memcg (or 
process) it was charged against, but extending struct page is most 
likely a no-go.

Alternative I could try to track the "owner" of a buffer (e.g. a shmem 
file), but then it can happen that one processes creates the object and 
another one is writing to it and actually allocating the memory.

>>> Also do not forget that shared file memory is not the only thing
>>> to care about. What about the kernel memory used on behalf of processes?
>> Yeah, I'm aware of that as well. But at least inside the GPU drivers we try
>> to keep that in a reasonable ratio.
>>
>>> Just consider the above mentioned memcg driven model. It doesn't really
>>> require to chase specific files and do some arbitrary math to share the
>>> responsibility. It has a clear accounting and responsibility model.
>> Ok, how does that work then?
> The memory is accounted to whoever faults that memory in or to the
> allocating context if that is a kernel memory (in most situations).

That's what I had in mind as well. Problem with this approach is that 
file descriptors are currently not informed that they are shared between 
processes.

So to make this work we would need something like attach/detach to 
process in struct file_operations.

And as I noted, this happens rather often. For example a game which 
renders 120 frames per second needs to transfer 120 buffers per second 
between client and X.

So this is not something which could take a lot of time and the file 
descriptor tracking structures in the Linux kernel are not made for this 
either.

I think for now I will try something like this specific for DRM drivers. 
That doesn't solve the shmem file problem, but it at least gives me 
something at hand for the accelerated Linux desktop case.

Regards,
Christian.
