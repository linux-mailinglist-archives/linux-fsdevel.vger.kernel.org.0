Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CED626B711
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgIPAQd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:16:33 -0400
Received: from rome.phoronix.com ([192.211.48.82]:21960 "EHLO
        rome.phoronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgIOOXT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:23:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=michaellarabel.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=XymnMjvixbSg/wyzUbikYFRHo0ahESdSNbbVdySFW3E=; b=pZgU5rBnoPS8lhZgOpUMIQEXKQ
        pEaZ+S0p+1P26ml/mLzaumQvp6FGGZ6VAqRU0lQ4zSR1WuwPOBiN9SWBswbGHcAclZPax4qJLZXlb
        rnoNzTwwdH/NFhJZO27mKS+eDh/QEg210VwbuP3PtXbGAOt526l9JFNl5xeWW/q07xQZS59QawvuE
        t9lAhQ8cxQ6mUpZVNH1i2moOf4MBiP+CX6XLbpntKcHYqqZWToUxpy+LXT8RsYChOvZ7nyC8Ovg4d
        UFL5L1II9rWlZOI4XL+V3jsKjQprvtw660ZrqTrf0XepiO5a+vGVvBok5mEFE4rNAujC2VD32srEP
        dz6FNcbw==;
Received: from c-73-176-63-28.hsd1.in.comcast.net ([73.176.63.28]:53674 helo=[192.168.86.21])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <Michael@MichaelLarabel.com>)
        id 1kIBqJ-0007xH-0q; Tue, 15 Sep 2020 10:21:59 -0400
Subject: Re: Kernel Benchmarking
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
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
From:   Michael Larabel <Michael@MichaelLarabel.com>
Message-ID: <ed8442fd-6f54-dd84-cd4a-941e8b7ee603@MichaelLarabel.com>
Date:   Tue, 15 Sep 2020 09:21:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - rome.phoronix.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - MichaelLarabel.com
X-Get-Message-Sender-Via: rome.phoronix.com: authenticated_id: michael@michaellarabel.com
X-Authenticated-Sender: rome.phoronix.com: michael@michaellarabel.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/14/20 12:47 PM, Linus Torvalds wrote:
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
>
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
>
> Or do
>
>      echo 5 > /proc/sys/vm/page_lock_unfairness
>      .. run test ..
>
> and get numbers for "we accept some unfairness, but if we have to
> requeue more than five times, we force the fair mode".
>
> Again, the default is 1000, which is ludicrously high (it's not a
> "this many retries per page" count, it's a "for each waiter" count). I
> made it that high just because I have *not* run any numbers for that
> interesting range, I just checked the extreme cases, and I wanted to
> make sure that Michael sees the old performance (modulo other changes
> to 5.9, of course).
>
> Comments? The patch really has a fair amount of comments in it, in
> fact the code changes are reasonably small, most of the changes really
> are about new and updated comments about what is going on.
>
> I was burnt by making a mess of this the first time, so I proceeded
> more thoughtfully this time. Hopefullyt the end result is also better.
>
> (Note that it's a commit and has a SHA1, but it's from my "throw-away
> tree for testing", so it doesn't have my sign-off or any real commit
> message yet: I'll do that once it gets actual testing and comments).
>
>                   Linus


Still running more benchmarks and on more systems, but so far at least 
as the Apache test is concerned this patch does seem to largely address 
the issue. The performance with the default 1000 page_lock_unfairness 
was yielding results more similar to 5.8 and in some cases tweaking the 
value did help improve the performance. A PLU value of 4~5 seems to 
yield the best performance.

The results though with Hackbench and Redis that exhibited similar drops 
from the commit in question remained mixed. Overview of the Apache 
metrics below, the other tests and system details @ 
https://openbenchmarking.org/result/2009154-FI-LINUX58CO57 For the other 
systems still testing, so far it's looking like similar relative impact 
to these results.

Apache Siege 2.4.29
Concurrent Users: 1
Transactions Per Second > Higher Is Better
v5.8 ............. 7684.81 
|=================================================
v5.9 Git ......... 7390.86 |===============================================
Default PLU 1000 . 7579.49 
|=================================================
PLU 0 ............ 7937.84 
|===================================================
PLU 1 ............ 7464.61 |================================================
PLU 2 ............ 7552.61 
|=================================================
PLU 3 ............ 7475.96 |================================================
PLU 4 ............ 7638.69 
|=================================================
PLU 5 ............ 7735.75 
|==================================================


Apache Siege 2.4.29
Concurrent Users: 50
Transactions Per Second > Higher Is Better
v5.8 ............. 39280.51 |===============================================
v5.9 Git ......... 28240.71 |==================================
Default PLU 1000 . 39708.30 |===============================================
PLU 0 ............ 26645.15 |================================
PLU 1 ............ 38709.95 |==============================================
PLU 2 ............ 39712.82 |===============================================
PLU 3 ............ 41959.67 
|==================================================
PLU 4 ............ 38870.90 |==============================================
PLU 5 ............ 41301.97 
|=================================================


Apache Siege 2.4.29
Concurrent Users: 100
Transactions Per Second > Higher Is Better
v5.8 ............. 51255.73 |=============================================
v5.9 Git ......... 21926.62 |===================
Default PLU 1000 . 42001.86 |=====================================
PLU 0 ............ 21528.43 |===================
PLU 1 ............ 37138.49 |=================================
PLU 2 ............ 38086.58 |==================================
PLU 3 ............ 38057.72 |==================================
PLU 4 ............ 56350.51 
|==================================================
PLU 5 ............ 37868.57 |==================================


Apache Siege 2.4.29
Concurrent Users: 200
Transactions Per Second > Higher Is Better
v5.8 ............. 47825.12 |===================================
v5.9 Git ......... 20174.78 |===============
Default PLU 1000 . 48190.05 |===================================
PLU 0 ............ 20095.10 |===============
PLU 1 ............ 48524.44 |====================================
PLU 2 ............ 47823.09 |===================================
PLU 3 ............ 47751.02 |===================================
PLU 4 ............ 68286.02 
|==================================================
PLU 5 ............ 47662.08 |===================================


Apache Siege 2.4.29
Concurrent Users: 250
Transactions Per Second > Higher Is Better
v5.8 ............. 55279.65 |=====================================
v5.9 Git ......... 20282.62 |==============
Default PLU 1000 . 67639.46 |=============================================
PLU 0 ............ 20181.98 |==============
PLU 1 ............ 40505.37 |===========================
PLU 2 ............ 56914.07 |======================================
PLU 3 ............ 55285.35 |=====================================
PLU 4 ............ 55499.25 |=====================================
PLU 5 ............ 74347.77 
|==================================================

