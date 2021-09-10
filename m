Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC909407090
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 19:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhIJRdn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 13:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231137AbhIJRdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:33:41 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2675C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 10:32:30 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id h20so1884192ilj.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 10:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f2dLcPzX7cfQUaVCs15ea8SZuZgriTIC7Sx2pMINImo=;
        b=lxKG7dCsVsIRT3WhD1ltjaCzU3IouFtkfz322POaURYR56JVHdi3jaV+mNenJrMAoO
         0S9cNvEUcNm54FnlTJuf4/qRgoO3zj0fuLfoO730BCXdhJQbd/GFJgQXJcrLbAt/Rywe
         oaI30prUcl/0lgKvwBCSXaT5qFjSbWw3gH0VX3kuAaBhR+1XYA5xKyMp5FfOvKFRI1w0
         leQCiVdEZBiG/t+MxFVb+bmyGCXrjS9/s06K1ubLpsvybARPMtDseXIvh1PEDOsoZMbD
         wfsYPr8EZa0WIFJs1K3SJLfff8mVh4byI9ijH2URXVjMgcFKVsGp/sqYsc0lopRwHoCI
         wlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f2dLcPzX7cfQUaVCs15ea8SZuZgriTIC7Sx2pMINImo=;
        b=A0Gyt6wORj1SCSxVPXKd3mQpjCkw9SFvZBBL7pxqfEjVAIrnX4DfPb5Qc6pE0amGGq
         y7rqf5K8PT99q9Kl/MvccYIh2PEOhPVlRZjB1wviovivTC1z/0G6l5GamjQwMFhcwY24
         Dqm/M1gwagNBOEgZAjsULx8RPjECPqpPV24tdBbmLLg5Z6704YDPRsFIDEHutbnGhrt0
         OUytBbOX+aFo8TQbRF2d5y3aYa4+LbPqLEniEF48BZv6+/MYcA3NJNkUk7q03Q9N2usi
         u3M9xW4fg9ay44qZ/QsMBMnpHMKmLJyOye27igF/eQ291pUxXQnCkhk2OVWI9o4xIjFT
         l0Uw==
X-Gm-Message-State: AOAM531Rw/s7OiVD2U2fwki3pbSsdUliXMspJ3sDEq5M1ryexP7Lc7zd
        hY0jYZCnZlISRoU8X23riBU/xPJZvQUbvdK/BjQ=
X-Google-Smtp-Source: ABdhPJxFWU8gqCBBryXuxzlo/F8fVDK17G6WpdOf0SxaOP/bOrZ2G8UndlhT+g5ZEv0m1OGKDJZGtA==
X-Received: by 2002:a05:6e02:1888:: with SMTP id o8mr7489223ilu.124.1631295145252;
        Fri, 10 Sep 2021 10:32:25 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id n11sm2722887ilq.21.2021.09.10.10.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 10:32:24 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
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
 <4b26d8cd-c3fa-8536-a295-850ecf052ecd@kernel.dk>
 <1a61c333-680d-71a0-3849-5bfef555a49f@kernel.dk>
 <YTuOPAFvGpayTBpp@zeniv-ca.linux.org.uk>
 <CAHk-=wiPEZypYDnoDF7mRE=u1y6E_etmCTuOx3v2v6a_Wj=z3g@mail.gmail.com>
 <b1944570-0e72-fd64-a453-45f17e7c1e56@kernel.dk>
 <CAHk-=wjWQtXmtOK9nMdM68CKavejv=p-0B81WazbjxaD-e3JXw@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cfe9e6d6-dd1c-a500-b3b0-a92d0b66c3c0@kernel.dk>
Date:   Fri, 10 Sep 2021 11:32:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjWQtXmtOK9nMdM68CKavejv=p-0B81WazbjxaD-e3JXw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/21 11:31 AM, Linus Torvalds wrote:
> On Fri, Sep 10, 2021 at 10:26 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 9/10/21 10:58 AM, Linus Torvalds wrote:
>>> On Fri, Sep 10, 2021 at 9:56 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>>>>
>>>> What's the point of all those contortions, anyway?  You only need it for
>>>> iovec case; don't mix doing that and turning it into flavour-independent
>>>> primitive.
>>>
>>> Good point, making it specific to iovec only gets rid of a lot of
>>> special cases and worries.
>>>
>>> This is fairly specialized, no need to always cater to every possible case.
>>
>> Alright, split into three patches:
>>
>> https://git.kernel.dk/cgit/linux-block/log/?h=iov_iter
> 
> That looks sane to me.
> 
> Please add some comment about how that
> 
>         i->iov -= state->nr_segs - i->nr_segs;
> 
> actually is the right thing for all the three cases (iow how 'iov',
> 'kvec' and 'bvec' all end up having a union member that acts the same
> way).

Good idea, I'll add that right now.

> But yeah, I like how the io_uring.c code looks better this way too.

Me too :-)

-- 
Jens Axboe

