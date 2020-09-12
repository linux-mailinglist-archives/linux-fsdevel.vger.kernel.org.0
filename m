Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330DB2679A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Sep 2020 12:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725838AbgILKwj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Sep 2020 06:52:39 -0400
Received: from rome.phoronix.com ([192.211.48.82]:38912 "EHLO
        rome.phoronix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgILKwi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Sep 2020 06:52:38 -0400
X-Greylist: delayed 1222 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Sep 2020 06:52:37 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=michaellarabel.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0Re5+qk4fPozZIGwGfFUki2QMmgZ5uk3gPbaUAI1EHI=; b=hQyNQohVdKCUeaZ3AqE04Z8pek
        c/iETH9KDxCy3ulJ2SKTj6BKeiDE07OFyi2ZwSA/c52Eb3uWhS76Zbj1r7RayNqMGeArooclF2pu5
        44CM2YBd/x0aXYgeBCisXmdNXwIpdslftzNZTJ3uwuzWKJacxx1Ef4eLZDu2+VanrCp7/P4jFwsgv
        /9A9FYMxmGt0QEjJ3gJVLcgYdMG4K2ogDkxEfvdl+B8lNrBbfz1ZvZQSI1Il13kP/IQsEFzB1ATt+
        i8a574gRFW59KSRZXaJt4mxD3BNvIyP4rle9CKVH3+teHPpUDkCQnNFN76Xl6N5zUX0Na0qBAIfwn
        LYVg+QgA==;
Received: from c-73-176-63-28.hsd1.in.comcast.net ([73.176.63.28]:38468 helo=[192.168.86.21])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <Michael@MichaelLarabel.com>)
        id 1kH2pJ-0000MY-01; Sat, 12 Sep 2020 06:32:13 -0400
Subject: Re: Kernel Benchmarking
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ted Ts'o <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
 <e24ef34d-7b1d-dd99-082d-28ca285a79ff@MichaelLarabel.com>
 <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
 <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com>
 <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
 <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com>
 <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
 <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
 <8bb582d2-2841-94eb-8862-91d1225d5ebc@MichaelLarabel.com>
 <CAHk-=wjqE_a6bpZyDQ4DCrvj_Dv2RwQoY7wN91kj8y-tZFRvEA@mail.gmail.com>
 <0cbc959e-1b8d-8d7e-1dc6-672cf5b3899a@MichaelLarabel.com>
 <CAHk-=whP-7Uw9WgWgjRgF1mCg+NnkOPpWjVw+a9M3F9C52DrVg@mail.gmail.com>
 <CAHk-=wjfw3U5eTGWLaisPHg1+jXsCX=xLZgqPx4KJeHhEqRnEQ@mail.gmail.com>
 <a2369108-7103-278c-9f10-6309a0a9dc3b@MichaelLarabel.com>
 <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
From:   Michael Larabel <Michael@MichaelLarabel.com>
Message-ID: <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com>
Date:   Sat, 12 Sep 2020 05:32:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
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

On 9/12/20 2:28 AM, Amir Goldstein wrote:
> On Sat, Sep 12, 2020 at 1:40 AM Michael Larabel
> <Michael@michaellarabel.com> wrote:
>> On 9/11/20 5:07 PM, Linus Torvalds wrote:
>>> On Fri, Sep 11, 2020 at 9:19 AM Linus Torvalds
>>> <torvalds@linux-foundation.org> wrote:
>>>> Ok, it's probably simply that fairness is really bad for performance
>>>> here in general, and that special case is just that - a special case,
>>>> not the main issue.
>>> Ahh. It turns out that I should have looked more at the fault path
>>> after all. It was higher up in the profile, but I ignored it because I
>>> found that lock-unlock-lock pattern lower down.
>>>
>>> The main contention point is actually filemap_fault(). Your apache
>>> test accesses the 'test.html' file that is mmap'ed into memory, and
>>> all the threads hammer on that one single file concurrently and that
>>> seems to be the main page lock contention.
>>>
>>> Which is really sad - the page lock there isn't really all that
>>> interesting, and the normal "read()" path doesn't even take it. But
>>> faulting the page in does so because the page will have a long-term
>>> existence in the page tables, and so there's a worry about racing with
>>> truncate.
>>>
>>> Interesting, but also very annoying.
>>>
>>> Anyway, I don't have a solution for it, but thought I'd let you know
>>> that I'm still looking at this.
>>>
>>>                   Linus
>> I've been running your EXT4 patch on more systems and with some
>> additional workloads today. While not the original problem, the patch
>> does seem to help a fair amount for the MariaDB database sever. This
>> wasn't one of the workloads regressing on 5.9 but at least with the
>> systems tried so far the patch does make a meaningful improvement to the
>> performance. I haven't run into any apparent issues with that patch so
>> continuing to try it out on more systems and other database/server
>> workloads.
>>
> Michael,
>
> Can you please add a reference to the original problem report and
> to the offending commit? This conversation appeared on the list without
> this information.
>
> Are filesystems other than ext4 also affected by this performance
> regression?
>
> Thanks,
> Amir.

On Linux 5.9 Git, Apache HTTPD, Redis, Nginx, and Hackbench appear to be 
the main workloads that are running measurably slower than on Linux 5.8 
and prior on multiple systems.

The issue was bisected to 2a9127fcf2296674d58024f83981f40b128fffea. The 
Kernel Test Robot also previously was triggered by the commit in 
question with mixed Hackbench results. In looking at the problem Linus 
had a hunch when looking at the perf data that it may have had an 
adverse reaction with the EXT4 locking behavior to which he sent out 
that patch. That EXT4 patch didn't end up addressing the performance 
issue with the original workloads in question (though in testing other 
workloads it seems to have benefit for MariaDB at least depending upon 
the system there can be slightly better performance).

Michael

