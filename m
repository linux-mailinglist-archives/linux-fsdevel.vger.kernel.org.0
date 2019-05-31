Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7FA3108F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 16:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbfEaOs6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 10:48:58 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46622 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfEaOs6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 10:48:58 -0400
Received: by mail-pf1-f194.google.com with SMTP id y11so6324120pfm.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2019 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Z5bSUHwSp4kpRmBsObia1lPUPGkJpwlRslF3MX8yr4=;
        b=dstu5uV6I8AZe1524Xs0LsRfPvVcQuuv2QrR+O6sWM+CesRTgkjlrgYji8Ex3/oTlQ
         I5Hbtxk91nrpksAsXjsYs5ldKMmfxdd2GI3Fo7AzkVj/Z6uN+CbGN4XJxqjaciRJLfwk
         YQbMnw02uYLEkHOUcjgJYHojn7/LBppxV9nq10ta/kF5QQnRkdoTmngZFdeHrxDJAJJW
         ZzGoJD+4B8fUJ9BHDUSMskIHWlgySUg2ma5SWe9QNt+3mWfzT9rZwYPNP6Vmb4zUIlv3
         GJkyqJZtS58jDZSsAsN5XjxjsldHj92SYzQKBIyLhnymsmQZrGXsXwspCkGPXVVeUB/p
         /7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Z5bSUHwSp4kpRmBsObia1lPUPGkJpwlRslF3MX8yr4=;
        b=FOTNnrxl+UX8rsyhVMrCW4DOwDP0VfWUbbp3kWDOM8bEfqLJefVMbFH+fABRGh6mHq
         Opr9qqNhRFr3Ck94RBDdGitURSLr+rV0Se+cRXdVjfJDY8w3cKORk0juyN4YbIgGhuyM
         hc6KyekKPnBI7iDos5YUxnuZZj5qKWIrFaRgQZNipHbOIpoU55hAxRzfSJGw/LLG0ICw
         cee72M1kaBgJPGTBXROwecP1vre68XU68VULlVGZ0nyEpkGDg50G9o0E/nWnOFAZ7pyz
         4Yz4oc8yCzcf0n3aiqEiJzFTLzHUhcPZav1hDIKRS6LIriS5w9Nm6MP/u4rQf1k8Iole
         fBng==
X-Gm-Message-State: APjAAAWUk3LYzD/++74y/PfE8152YKe+/50XiuTn2EMZAhJLuZgBGrJR
        lEPw2LgxzuPzXGJ5NKX4EOvrKA==
X-Google-Smtp-Source: APXvYqz43tBFILk/WNZBIPGBMolxWR2qz6wU98xoMLQPkqwbymeGztI5Belv8i1MUcfaLTEOWZdsOQ==
X-Received: by 2002:a63:cc4b:: with SMTP id q11mr9747244pgi.43.1559314137820;
        Fri, 31 May 2019 07:48:57 -0700 (PDT)
Received: from [192.168.1.158] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k2sm5746164pjl.23.2019.05.31.07.48.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 07:48:56 -0700 (PDT)
Subject: Re: [PATCH v3 00/13] epoll: support pollable epoll from userspace
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190516085810.31077-1-rpenyaev@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a2a88f4f-d104-f565-4d6e-1dddc7f79a05@kernel.dk>
Date:   Fri, 31 May 2019 08:48:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190516085810.31077-1-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/16/19 2:57 AM, Roman Penyaev wrote:
> Hi all,
> 
> This is v3 which introduces pollable epoll from userspace.
> 
> v3:
>   - Measurements made, represented below.
> 
>   - Fix alignment for epoll_uitem structure on all 64-bit archs except
>     x86-64. epoll_uitem should be always 16 bit, proper BUILD_BUG_ON
>     is added. (Linus)
> 
>   - Check pollflags explicitly on 0 inside work callback, and do nothing
>     if 0.
> 
> v2:
>   - No reallocations, the max number of items (thus size of the user ring)
>     is specified by the caller.
> 
>   - Interface is simplified: -ENOSPC is returned on attempt to add a new
>     epoll item if number is reached the max, nothing more.
> 
>   - Alloced pages are accounted using user->locked_vm and limited to
>     RLIMIT_MEMLOCK value.
> 
>   - EPOLLONESHOT is handled.
> 
> This series introduces pollable epoll from userspace, i.e. user creates
> epfd with a new EPOLL_USERPOLL flag, mmaps epoll descriptor, gets header
> and ring pointers and then consumes ready events from a ring, avoiding
> epoll_wait() call.  When ring is empty, user has to call epoll_wait()
> in order to wait for new events.  epoll_wait() returns -ESTALE if user
> ring has events in the ring (kind of indication, that user has to consume
> events from the user ring first, I could not invent anything better than
> returning -ESTALE).
> 
> For user header and user ring allocation I used vmalloc_user().  I found
> that it is much easy to reuse remap_vmalloc_range_partial() instead of
> dealing with page cache (like aio.c does).  What is also nice is that
> virtual address is properly aligned on SHMLBA, thus there should not be
> any d-cache aliasing problems on archs with vivt or vipt caches.

Why aren't we just adding support to io_uring for this instead? Then we
don't need yet another entirely new ring, that's is just a little
different from what we have.

I haven't looked into the details of your implementation, just curious
if there's anything that makes using io_uring a non-starter for this
purpose?

-- 
Jens Axboe

