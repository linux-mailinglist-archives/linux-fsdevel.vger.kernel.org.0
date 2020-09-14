Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C51269658
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Sep 2020 22:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgINUXS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 16:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgINUVs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:21:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27104C061788
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 13:21:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so947659wrm.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Sep 2020 13:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K7MtII+9UVBbc4MWSUMa9tMOVUjvppbzTQKND+2IRGY=;
        b=QMWTsqoxxDOoK8xdKVyHbn5nYOZldwgSP/AMuFtHHBeeKuGwTEYYliJNqyFdLtf6nL
         i/4KIpY+lIamkxU25m3O3rTroHQIuwQDdEnXpUwP8I91UsOy4Kc1ZnjH0/jkdKp//Uao
         dkKdZVD7nN5Qnywd7o5oWmkaiXc7zuOhM7Lizfk34mV0HnZcBpsunsO75E9csAAFXg7j
         TfP0CVINRdmOR/nyYYcs4lXvD/ljjqYXon3ASE47oi1te8xxF62vHq7kFPW5cAsA45Cq
         Hd6GbAoQu1PtujKO+aiLI3v72/E7PwUBcw3FTju6W86VPFXMZTF0WgoqABrlKvT8EPAN
         yklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7MtII+9UVBbc4MWSUMa9tMOVUjvppbzTQKND+2IRGY=;
        b=ulAFoXtdUsN/kwIl2ilANDPPuCyp2TSKxyE0EZBcvboytH9zGxfEXT/Id/k9UW9G95
         cNC6GrDnPrNEYZBp9SOti01A4TKX7N4go3Y8ARLOLBExNr2UcEfnfBiIgtQ5MMT8Dsg3
         x1nCS2hIpLGzBuJInCEhttVZj0bI+lmMjEe7dTgI5LjTRWNYJ4Ju97rMFmmt3i0kG8o/
         GqvRfW1FvAQ5/JmpDxF5nDzo97L8VFahmNi53uXoGmLRhKNj8l+Dosz4SjM7IGXhw2Kz
         tHW2FR3xmytcUKIsMcIu2/6ClAFdqugXdJoXiWE0JK6uW/odYums2xTIOCtoMY8LIw0L
         4ydA==
X-Gm-Message-State: AOAM5319aSRY3Y3POuVzvaiHGf3F16SRX7gSeMY1zOtnabLGtJmmBfHy
        KY5oXbLFTBJ0UoXDv6b9oRCU8Da0lPYPtSY9
X-Google-Smtp-Source: ABdhPJxGvCx59w5r4saIP+xsUbPihNTuDXNr2z+i5guYCJ2VHqXTw/3ybrHUyRlqauctHgVLMRKJdQ==
X-Received: by 2002:a5d:5306:: with SMTP id e6mr18276903wrv.156.1600114904387;
        Mon, 14 Sep 2020 13:21:44 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([2a02:578:85b0:e00:21bd:4887:6b93:136b])
        by smtp.gmail.com with ESMTPSA id m185sm21851166wmf.5.2020.09.14.13.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 13:21:43 -0700 (PDT)
Subject: Re: Kernel Benchmarking
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Larabel <Michael@michaellarabel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
 <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com>
 <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <c560a38d-8313-51fb-b1ec-e904bd8836bc@tessares.net>
Date:   Mon, 14 Sep 2020 22:21:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello everyone,

On 14/09/2020 19:47, Linus Torvalds wrote:
> Michael et al,
>   Ok, I redid my failed "hybrid mode" patch from scratch (original
> patch never sent out, I never got it to a working point).
> 
> Having learnt from my mistake, this time instead of trying to mix the
> old and the new code, instead I just extended the new code, and wrote
> a _lot_ of comments about it.
> 
> I also made it configurable, using a "page_lock_unfairness" knob,
> which this patch defaults to 1000 (which is basically infinite).
> That's just a value that says how many times we'll try the old unfair
> case, so "1000" means "we'll re-queue up to a thousand times before we
> say enough is enough" and zero is the fair mode that shows the
> performance problems.

Thank you for the new patch and all the work around from everybody!

Sorry to jump in this thread but I wanted to share my issue, also linked 
to the same commit:

     2a9127fcf229 ("mm: rewrite wait_on_page_bit_common() logic")

I have a simple test environment[1] using Docker and virtme[2] almost 
with the default kernel config and validating some tests for the MPTCP 
Upstream project[3]. Some of these tests are using a modified version of 
packetdrill[4].

Recently, some of these packetdrill tests have been failing after 2 
minutes (timeout) instead of being executed in a few seconds (~6 
seconds). No packets are even exchanged during these two minutes.

I did a git bisect and it also pointed me to 2a9127fcf229.

I can run the same test 10 times without any issue with the parent 
commit (v5.8 tag) but with 2a9127fcf229, I have a timeout most of the time.

Of course, when I try to add some debug info on the userspace or 
kernelspace side, I can no longer reproduce the timeout issue. But 
without debug, it is easy for me to validate if the issue is there or 
not. My issue doesn't seem to be linked to a small file that needs to be 
read multiple of times on a FS. Only a few bytes should be transferred 
with packetdrill but when there is a timeout, it is even before that 
because I don't see any transferred packets in case of issue. I don't 
think a lot of IO is used by Packetdrill before transferring a few 
packets to a "tun" interface but I didn't analyse further.

With your new patch and the default value, I no longer have the issue.

> I've only (lightly) tested those two extremes, I think the interesting
> range is likely in the 1-5 range.
> 
> So you can do
> 
>      echo 0 > /proc/sys/vm/page_lock_unfairness
>      .. run test ..
> 
> and you should get the same numbers as without this patch (within
> noise, of course).

On my side, I have the issue with 0. So it seems good because expected!

> Or do
> 
>      echo 5 > /proc/sys/vm/page_lock_unfairness
>      .. run test ..
> 
> and get numbers for "we accept some unfairness, but if we have to
> requeue more than five times, we force the fair mode".

Already with 1, it is fine on my side: no more timeout! Same with 5. I 
am not checking the performances but only the fact I can run packetdrill 
without timeout. With 1 and 5, tests finish in a normal time, that's 
really good. I didn't have any timeout in 10 runs, each of them started 
from a fresh VM. Patch tested with success!

I would be glad to help by validating new modifications or providing new 
info. My setup is also easy to put in place: a Docker image is built 
with all required tools to start the same VM just like the one I have. 
All scripts are on a public repository[1].

Please tell me if I can help!

Cheers,
Matt

[1] 
https://github.com/multipath-tcp/mptcp_net-next/blob/scripts/ci/virtme.sh and 
https://github.com/multipath-tcp/mptcp_net-next/blob/scripts/ci/Dockerfile.virtme.sh
[2] https://git.kernel.org/pub/scm/utils/kernel/virtme/virtme.git
[3] https://github.com/multipath-tcp/mptcp_net-next/wiki
[4] https://github.com/multipath-tcp/packetdrill
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
