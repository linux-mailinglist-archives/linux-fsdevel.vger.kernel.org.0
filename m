Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6B97982B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 20:24:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbfHUSYP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 14:24:15 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:11858 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbfHUSYP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:24:15 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d5d8c4d0000>; Wed, 21 Aug 2019 11:24:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 21 Aug 2019 11:24:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 21 Aug 2019 11:24:13 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 18:24:12 +0000
Received: from [10.2.161.131] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 21 Aug
 2019 18:24:12 +0000
Subject: Re: [RFC PATCH v2 00/19] RDMA/FS DAX truncate proposal V1,000,002 ;-)
To:     Jason Gunthorpe <jgg@ziepe.ca>, Ira Weiny <ira.weiny@intel.com>
CC:     Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Michal Hocko <mhocko@suse.com>,
        <linux-xfs@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-nvdimm@lists.01.org>, <linux-ext4@vger.kernel.org>,
        <linux-mm@kvack.org>
References: <20190814180848.GB31490@iweiny-DESK2.sc.intel.com>
 <20190815130558.GF14313@quack2.suse.cz>
 <20190816190528.GB371@iweiny-DESK2.sc.intel.com>
 <20190817022603.GW6129@dread.disaster.area>
 <20190819063412.GA20455@quack2.suse.cz>
 <20190819092409.GM7777@dread.disaster.area> <20190819123841.GC5058@ziepe.ca>
 <20190820011210.GP7777@dread.disaster.area> <20190820115515.GA29246@ziepe.ca>
 <20190821180200.GA5965@iweiny-DESK2.sc.intel.com>
 <20190821181343.GH8653@ziepe.ca>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <50905b73-b64a-2b02-f5d5-f66ba0d912ab@nvidia.com>
Date:   Wed, 21 Aug 2019 11:22:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821181343.GH8653@ziepe.ca>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566411853; bh=CfqY8aJja8VV7vQdQwO0ArJP7UGyxBQ9FeuFR1zQxF4=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=FVubjkvptshBNnluMQjtoEMnrXaPNCHMPCZ0L8jnjc9nEOnq6dqKhOe+TvOOP7K04
         6I4vM3+3IHlNz4bj4WEE6vv6H1xbLRU22hJWsYyts0CsqEAEIR1/WJf1Lql9ZCrDWW
         MJ6OCMA4rAS3PDporQJNy9PmW155jIzLu7SYKrtMZTMsGKDQqST56iTQpBp5eYgrOH
         blDrmpTbHWZKLDV2Mk2gFjrXf8+pUhWMvIfMwlN+z/T6aNEBdOocUohhXbkxa9euoz
         OtGAYEgIWVXbfAYV4A5vvnkWCH3bW4Gx4cxWy4g+M/67D1nmfmJlD3HcEd6W5ifcdA
         KEmZJENkYkOOg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 8/21/19 11:13 AM, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2019 at 11:02:00AM -0700, Ira Weiny wrote:
>> On Tue, Aug 20, 2019 at 08:55:15AM -0300, Jason Gunthorpe wrote:
>>> On Tue, Aug 20, 2019 at 11:12:10AM +1000, Dave Chinner wrote:
>>>> On Mon, Aug 19, 2019 at 09:38:41AM -0300, Jason Gunthorpe wrote:
>>>>> On Mon, Aug 19, 2019 at 07:24:09PM +1000, Dave Chinner wrote:
>>>>>
>>>>>> So that leaves just the normal close() syscall exit case, where the
>>>>>> application has full control of the order in which resources are
>>>>>> released. We've already established that we can block in this
>>>>>> context.  Blocking in an interruptible state will allow fatal signal
>>>>>> delivery to wake us, and then we fall into the
>>>>>> fatal_signal_pending() case if we get a SIGKILL while blocking.
>>>>>
>>>>> The major problem with RDMA is that it doesn't always wait on close() for the
>>>>> MR holding the page pins to be destoyed. This is done to avoid a
>>>>> deadlock of the form:
>>>>>
>>>>>     uverbs_destroy_ufile_hw()
>>>>>        mutex_lock()
>>>>>         [..]
>>>>>          mmput()
>>>>>           exit_mmap()
>>>>>            remove_vma()
>>>>>             fput();
>>>>>              file_operations->release()
>>>>
>>>> I think this is wrong, and I'm pretty sure it's an example of why
>>>> the final __fput() call is moved out of line.
>>>
>>> Yes, I think so too, all I can say is this *used* to happen, as we
>>> have special code avoiding it, which is the code that is messing up
>>> Ira's lifetime model.
>>>
>>> Ira, you could try unraveling the special locking, that solves your
>>> lifetime issues?
>>
>> Yes I will try to prove this out...  But I'm still not sure this fully solves
>> the problem.
>>
>> This only ensures that the process which has the RDMA context (RDMA FD) is safe
>> with regard to hanging the close for the "data file FD" (the file which has
>> pinned pages) in that _same_ process.  But what about the scenario.
> 
> Oh, I didn't think we were talking about that. Hanging the close of
> the datafile fd contingent on some other FD's closure is a recipe for
> deadlock..
> 
> IMHO the pin refcnt is held by the driver char dev FD, that is the
> object you need to make it visible against.


If you do that, it might make it a lot simpler to add lease support
to drivers like XDP, which is otherwise looking pretty difficult to
set up with an fd. (It's socket-based, and not immediately clear where
to connect up the fd.)


thanks,
-- 
John Hubbard
NVIDIA

> 
> Why not just have a single table someplace of all the layout leases
> with the file they are held on and the FD/socket/etc that is holding
> the pin? Make it independent of processes and FDs?
> 
> Jason
> 
