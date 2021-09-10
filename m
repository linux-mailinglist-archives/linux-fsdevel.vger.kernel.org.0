Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293DB406DF8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Sep 2021 17:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234154AbhIJPJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Sep 2021 11:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234270AbhIJPJQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Sep 2021 11:09:16 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B461C061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 08:08:06 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id b8so617172ilh.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Sep 2021 08:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BrxzTCRXFeWgHCONUvuL7grava4MVAVW3Zocp6vU7jo=;
        b=my+xizXrJkbSt6xkUqSxuB8Jm0KThrQH0s5xj6MBSAfvx+JU7850qyZgWajaZpDFrT
         WmFxjKFRXLPGGQ76Q1lwASuTMVAkaHSizZtI2EfNKV6d4iZNjJYZ85U1gVeHVglkkkza
         JKC0ruBtS2gPVXi8FMRiZjAQ3u0ysMjMA3GaGwsESADei7dpcuDw18KOcdygZtHcVTNU
         eWOy8ESo4T2oNCniSNpkBg1ID2kcP6DlSVzRIKs9bKmdpBk+BSUiMCZMSaAkDpoyI+ti
         tytk1h9R2QNkiwz1AsCjQSLQMFBrPL6N6wNULWFWD9LS239T6cXJIAjGUEMFnORQe8tG
         CRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BrxzTCRXFeWgHCONUvuL7grava4MVAVW3Zocp6vU7jo=;
        b=M0nMFjQ9xd0UJOjJRdDtfV25NYt6dIKpvK7qvb4VFlHgOYgmGgQ7POasaXpiNdQpwS
         kWNsFgcok+rhfy6wwLlgIhOCcVOHi4qJBWGl8FyV6KovDlyrDl2KYPazC5aw+Det/TWu
         YmXvjoO4uMXvns/9m5J7aR25f1lTGQOG2DVL02fpPZy/jT7oNwhlVlGySoruM69uIFEA
         n+9QuhXF7aR4rOEahe26F+hIZAOmvvmT+qt6TtNqDbpw/aET+TjPrA8kHE/ievytcMNa
         guTaMSDBaeMj3zeQxLVuVET43AoWtqjZPs21EBkoQZjAIEujD/WhJ7Vy09eHKYJOAeJd
         SasQ==
X-Gm-Message-State: AOAM5329XxeR8wrUqtvjhMmYYpq6QThk0zFwav2/4YNbiWQWQ2LHZ1jr
        3FNVMxDR0QjlVhK+5jbgECoTQ4cH6GoksJS4Sy4=
X-Google-Smtp-Source: ABdhPJxKSMqljOv4kq4sT7iCXHFFs4i40ciAQ4hNIZSI59SAfmiS7XM4mhBu6+bVF974ULWxJcFAuw==
X-Received: by 2002:a05:6e02:68a:: with SMTP id o10mr6969504ils.72.1631286484904;
        Fri, 10 Sep 2021 08:08:04 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id z16sm2660078ile.72.2021.09.10.08.08.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Sep 2021 08:08:03 -0700 (PDT)
Subject: Re: [git pull] iov_iter fixes
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAHk-=wiacKV4Gh-MYjteU0LwNBSGpWrK-Ov25HdqB1ewinrFPg@mail.gmail.com>
 <5971af96-78b7-8304-3e25-00dc2da3c538@kernel.dk>
 <YTrJsrXPbu1jXKDZ@zeniv-ca.linux.org.uk>
 <b8786a7e-5616-ce83-c2f2-53a4754bf5a4@kernel.dk>
 <YTrM130S32ymVhXT@zeniv-ca.linux.org.uk>
 <9ae5f07f-f4c5-69eb-bcb1-8bcbc15cbd09@kernel.dk>
 <YTrQuvqvJHd9IObe@zeniv-ca.linux.org.uk>
 <f02eae7c-f636-c057-4140-2e688393f79d@kernel.dk>
 <YTrSqvkaWWn61Mzi@zeniv-ca.linux.org.uk>
 <9855f69b-e67e-f7d9-88b8-8941666ab02f@kernel.dk>
 <YTtu1V1c1emiYII9@zeniv-ca.linux.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <75caf6d6-26d4-7146-c497-ed89b713d878@kernel.dk>
Date:   Fri, 10 Sep 2021 09:08:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YTtu1V1c1emiYII9@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/10/21 8:42 AM, Al Viro wrote:
> On Fri, Sep 10, 2021 at 07:57:49AM -0600, Jens Axboe wrote:
> 
>> It was just a quick hack, might very well be too eager to go through
>> those motions. But pondering this instead of sleeping, we don't need to
>> copy all of iov_iter in order to restore the state, and we can use the
>> same advance after restoring. So something like this may be more
>> palatable. Caveat - again untested, and I haven't tested the performance
>> impact of this at all.
> 
> You actually can cut it down even more - nr_segs + iov remains constant
> all along, so you could get away with just 3 words here...  I would be

Mmm, the iov pointer remains constant? Maybe I'm missing your point, but
the various advance functions are quite happy to increment iter->iov or
iter->bvec, so we need to restore them. From a quick look, looks like
iter->nr_segs is modified for advancing too.

What am I missing?

> surprised if extra memory traffic had shown up - it's well within the
> noise from register spills, (un)inlining, etc.  We are talking about
> 3 (or 4, with your variant) extra words on one stack frame (and that'd
> be further offset by removal of ->truncated); I'd still like to see the
> profiling data, but concerns about extra memory traffic due to that
> are, IMO, misplaced.

See other email that was just sent out, it is measurable but pretty
minimal. But that's also down to about 1/3rd of copying the whole
thing blindly, so definitely a better case.

-- 
Jens Axboe

