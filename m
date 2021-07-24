Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2783A3D4A80
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Jul 2021 00:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbhGXWE2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 24 Jul 2021 18:04:28 -0400
Received: from rome.phoronix.com ([192.211.48.82]:8272 "EHLO rome.phoronix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229588AbhGXWE2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 24 Jul 2021 18:04:28 -0400
X-Greylist: delayed 1285 seconds by postgrey-1.27 at vger.kernel.org; Sat, 24 Jul 2021 18:04:28 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=michaellarabel.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=v15tJ2HW76/73pqT/Le2YOylxGKz5JEzbw/tmVjFExE=; b=k+VJcRQ5Y8jvR4ceEM6LSG0S8V
        H3jgGf9cDnSEqK11uI4Oa5jDZ8dE0O4GcAg3lMb6KVGeWzTVGJqqkI9tcxUA36ZtqcIgZmTpG78bF
        pFU4D8lUv5BuDzDwssWQvQHxA9dYic/hMPmT9HEy6ghHB0pLCURoDO7k7qrvE69pLmdF8/k5kFvuJ
        38QLQWSJGuCCCAF0cMX8/HTqUawql82S3rlqmHNS6qan1lBzhea3XkWygQQLFZv51NdxCRjsBQn3l
        onX9eheu7P5zz2J6b6CeHs/hOKPnTJa+Y0E92YUDLPX+e0ExiYWcC0bJWaoQeu0iFdX0+QRmGC36r
        +SmJUdew==;
Received: from c-73-176-63-28.hsd1.il.comcast.net ([73.176.63.28]:57014 helo=[192.168.86.57])
        by rome.phoronix.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <Michael@MichaelLarabel.com>)
        id 1m7Q3S-00063Q-5I; Sat, 24 Jul 2021 18:23:29 -0400
Subject: Re: Folios give an 80% performance win
To:     Andres Freund <andres@anarazel.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>
References: <20210715033704.692967-1-willy@infradead.org>
 <YPxNkRYMuWmuRnA5@casper.infradead.org>
 <1e48f7edcb6d9a67e8b78823660939007e14bae1.camel@HansenPartnership.com>
 <YPxYdhEirWL0XExY@casper.infradead.org>
 <b12f95c9f817f05e91ecd1aec81316afa1da1e42.camel@HansenPartnership.com>
 <17a9d8bf-cd52-4e6c-9b3e-2fbc1e4592d9@www.fastmail.com>
 <YPxjbopzwFYJw9hV@casper.infradead.org>
 <4c634d08-c658-44cf-ac92-92097eeb8532@www.fastmail.com>
 <20210724214413.fqsbjxhhodfzchs6@alap3.anarazel.de>
From:   Michael Larabel <Michael@MichaelLarabel.com>
Message-ID: <4ab2f8c4-38ce-3860-1465-e04dea4017b2@MichaelLarabel.com>
Date:   Sat, 24 Jul 2021 17:23:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210724214413.fqsbjxhhodfzchs6@alap3.anarazel.de>
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
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 7/24/21 4:44 PM, Andres Freund wrote:
> Hi,
>
> On 2021-07-24 12:12:36 -0700, Andres Freund wrote:
>> On Sat, Jul 24, 2021, at 12:01, Matthew Wilcox wrote:
>>> On Sat, Jul 24, 2021 at 11:45:26AM -0700, Andres Freund wrote:
>>> It's always possible I just broke something.  The xfstests aren't
>>> exhaustive, and no regressions doesn't mean no problems.
>>>
>>> Can you guide Michael towards parameters for pgbench that might give
>>> an indication of performance on a more realistic workload that doesn't
>>> entirely fit in memory?
>> Fitting in memory isn't bad - that's a large post of real workloads. It just makes it hard to believe the performance improvement, given that we expect to be bound by disk sync speed...
> I just tried to compare folio-14 vs its baseline, testing commit 8096acd7442e
> against 480552d0322d. In a VM however (but at least with its memory being
> backed by huge pages and storage being passed through).  I got about 7%
> improvement with just some baseline tuning of postgres applied. I think a 1-2%
> of that is potentially runtime variance (I saw slightly different timings
> leading around checkpointing that lead to a bit "unfair" advantage to the
> folio run).
>
> That's a *nice* win!
>
> WRT the ~70% improvement:
>
>> Michael, where do I find more details about the codification used during the
>> run?
> After some digging I found https://github.com/phoronix-test-suite/phoronix-test-suite/blob/94562dd4a808637be526b639d220c7cd937e2aa1/ob-cache/test-profiles/pts/pgbench-1.10.1/install.sh
> For one the test says its done on ext4, while I used xfs. But I think the
> bigger thing is the following:

Yes that is the run/setup script used. The additional pgbench arguments 
passed at run-time are outlined in

https://github.com/phoronix-test-suite/phoronix-test-suite/blob/94562dd4a808637be526b639d220c7cd937e2aa1/ob-cache/test-profiles/pts/pgbench-1.10.1/test-definition.xml

Though in this case is quite straight-forward in corresponding to the 
relevant -s, -c options for pgbench and what is shown in turn on the 
pgbench graphs.

I have been running some more PostgreSQL tests on other hardware as well 
as via HammerDB and other databases. Will send that over when wrapped up 
likely tomorrow.

Michael


>
> The phoronix test uses postgres with only one relevant setting adjusted
> (increasing the max connection count). That will end up using a buffer pool of
> 128MB, no huge pages, and importantly is configured to aim for not more than
> 1GB for postgres' journal, which will lead to constant checkpointing. The test
> also only runs for 15 seconds, which likely isn't even enough to "warm up"
> (the creation of the data set here will take longer than the run).
>
> Given that the dataset phoronix is using is about ~16GB of data (excluding
> WAL), and uses 256 concurrent clients running full tilt, using that limited
> postgres settings doesn't end up measuring something particularly interesting
> in my opinion.
>
> Without changing the filesystem, using a configuration more similar to
> phoronix', I do get a bigger win. But the run-to-run variance is so high
> (largely due to the short test duration) that I don't trust those results
> much.
>
> It does look like there's a less slowdown due to checkpoints (i.e. fsyncing
> all data files postgres modified since the last checkpoints) on the folio
> branch, which does make some sense to me and would be a welcome improvement.
>
> Greetings,
>
> Andres Freund
