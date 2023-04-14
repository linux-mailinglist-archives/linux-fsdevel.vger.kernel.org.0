Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3586E2B46
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Apr 2023 22:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjDNUrp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Apr 2023 16:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjDNUro (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:47:44 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2981B30D8
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Apr 2023 13:47:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 55E94320024A;
        Fri, 14 Apr 2023 16:47:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 14 Apr 2023 16:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1681505261; x=1681591661; bh=qMW0SdtJhp6yzgDZfkC4LhSYXOnwr8epq1J
        DN68nykc=; b=ikTxL2C0oQdZ7wOCHGPKsSEAo3mE6aRT42rsZatMpqORXxWS+m9
        FPesR89/urodHgwt0Qip6AyYzxjCfYBn+Uph9Al0K1YUk57x+tVsuV+0LEwamj85
        /S5zQY/M3VzybOOLz8yZYXUh0RJ9hrcxCEKzxcxmttkVlmGetGaX71CAO6yup71X
        yXeO3sFNeXg0PFLvzF7s4ZMDYBFGYbit3y4G3syPDMGf72UjvAqonCwdY3zXKRvh
        aMA5FTBqnF7pgPDf/RP5z1ogZSi7xjlGWOyLcMavEgyiZ7uzGSnqAmD6klX8DA5D
        X5dsll5Gp4+wPKy/eBi+495APUafLQNjEFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681505261; x=1681591661; bh=qMW0SdtJhp6yzgDZfkC4LhSYXOnwr8epq1J
        DN68nykc=; b=ake9xZjbMFzcdG+I7zT8KaZtDFBk2ujvJqjxssJ70W+PpqlcOVw
        tGwNwf5d9rWQxWDMNDVMxvnU+/z8XmBFXU8Mp3FmVcrNei5aHkjQsi9buDCUcwrF
        HTStcagjQvILQTl8iilLTcXViZbLUPDF9OoKXEvlwn+EF+9kVIIuyQlRoaA+VpGT
        E7jHOhd05osLv7tcpQNsVEK4gPbl52e3IfIkTAfLZPALYPeJAYj+d2+anM4gU9Oa
        FoLeWGoqTGijn5W1xdlYp9SDRpzPshibq9OpuGT11WAsfWvWk8m2MuCvc5tktl31
        asuW0UZQFhDdn56rn73J9dyonvsJE6OyCFQ==
X-ME-Sender: <xms:7bs5ZPBYqgj7u9FZ92kWTNR2ls_ABzSHjO5TQPU4md9dxFoA8jdLzA>
    <xme:7bs5ZFiapSGUbA7B866fzfI9_z-XUofByMGhUK0HelKMSMAlWuJWyAlfEVv7f1BXO
    8lcx_qFEKBmGqqh>
X-ME-Received: <xmr:7bs5ZKkfrqyBQ6b7Dm2TdxhIK7lrceGg-YkibdSqLuI2Mclt0natq5imLpnNvxsSR1pY1B36ECC04Pers7fGy9Sj_l5LwzPrwpEzdwbew2p7rKvjDxQ2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuhffvvehfjggtgfesthekredttdefjeenucfhrhhomhepuegv
    rhhnugcuufgthhhusggvrhhtuceosggvrhhnugdrshgthhhusggvrhhtsehfrghsthhmrg
    hilhdrfhhmqeenucggtffrrghtthgvrhhnpeduteejuedtvddtudfffeduudehvddvhfeg
    leehteevgfekhfelgefhfffgtedutdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsvghrnhgurdhstghhuhgsvghrthesfhgrshhtmhgrihhl
    rdhfmh
X-ME-Proxy: <xmx:7bs5ZBy9RPk-xBZDOuw1JmkLJDcBOnG34wnkMVw-4TwkM1zQF26r4A>
    <xmx:7bs5ZERxP75Q2Ia1m2W7sC4n_-js4KqLZBgnJo7qxuU-oOwiXG6uQw>
    <xmx:7bs5ZEbuXOT_eS6jRM05JJBKTK1Lds6dB3PeYU9PS9wOCi21Ek--cw>
    <xmx:7bs5ZKeWvvcvi-S3ovfQ4XUqRvf0lAwJ38ME_mwLbxh-_twicLPxfA>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 16:47:40 -0400 (EDT)
Message-ID: <c59e54f9-6eae-3c35-bce8-ac03af84b3ed@fastmail.fm>
Date:   Fri, 14 Apr 2023 22:47:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: sequential 1MB mmap read ends in 1 page sync read-ahead
Content-Language: en-US, de-DE
From:   Bernd Schubert <bernd.schubert@fastmail.fm>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <aae918da-833f-7ec5-ac8a-115d66d80d0e@fastmail.fm>
 <df5c4698-46e1-cbfe-b1f6-cc054b12f6fe@fastmail.fm>
 <ZDjRayNGU1zYn1pw@casper.infradead.org>
 <1e88b8ed-5f17-c42e-9646-6a97efd9f99c@fastmail.fm>
 <b8afbfba-a58d-807d-1bbc-3be4b5b08710@fastmail.fm>
In-Reply-To: <b8afbfba-a58d-807d-1bbc-3be4b5b08710@fastmail.fm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 4/14/23 21:52, Bernd Schubert wrote:
> 
> 
> On 4/14/23 17:05, Bernd Schubert wrote:
>>
>>
>> On 4/14/23 06:07, Matthew Wilcox wrote:
>>> On Thu, Apr 13, 2023 at 11:33:09PM +0200, Bernd Schubert wrote:
>>>> Sorry, forgot to add Andrew and linux-mm into CC.
>>>>
>>>> On 4/13/23 23:27, Bernd Schubert wrote:
>>>>> Hello,
>>>>>
>>>>> I found a weird mmap read behavior while benchmarking the fuse-uring
>>>>> patches.
>>>>> I did not verify yet, but it does not look fuse specific.
>>>>> Basically, I started to check because fio results were much lower
>>>>> than expected (better with the new code, though)
>>>>>
>>>>> fio cmd line:
>>>>> fio --size=1G --numjobs=1 --ioengine=mmap --output-format=normal,terse
>>>>> --directory=/scratch/dest/ --rw=read multi-file.fio
>>>>>
>>>>>
>>>>> bernd@squeeze1 test2>cat multi-file.fio
>>>>> [global]
>>>>> group_reporting
>>>>> bs=1M
>>>>> runtime=300
>>>>>
>>>>> [test]
>>>>>
>>>>> This sequential fio sets POSIX_MADV_SEQUENTIAL and then does memcpy
>>>>> beginning at offset 0 in 1MB steps (verified with additional
>>>>> logging in fios engines/mmap.c).
>>>>>
>>>>> And additional log in fuse_readahead() gives
>>>>>
>>>>> [ 1396.215084] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64
>>>>> index=0
>>>>> [ 1396.237466] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64
>>>>> index=255
>>>>> [ 1396.263175] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1
>>>>> index=254
>>>>> [ 1396.282055] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1
>>>>> index=253
>>>>> ... <count is always 1 page>
>>>>> [ 1496.353745] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1
>>>>> index=64
>>>>> [ 1496.381105] fuse: 000000003fdec504 inode=00000000be0f29d3 count=64
>>>>> index=511
>>>>> [ 1496.397487] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1
>>>>> index=510
>>>>> [ 1496.416385] fuse: 000000003fdec504 inode=00000000be0f29d3 count=1
>>>>> index=509
>>>>> ... <count is always 1 page>
>>>>>
>>>>> Logging in do_sync_mmap_readahead()
>>>>>
>>>>> [ 1493.130764] do_sync_mmap_readahead:3015 ino=132 index=0 count=0
>>>>> ras_start=0 ras_size=0 ras_async=0 ras_ra_pages=64 ras_mmap_miss=0
>>>>> ras_prev_pos=-1
>>>>> [ 1493.147173] do_sync_mmap_readahead:3015 ino=132 index=255 count=0
>>>>> ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0
>>>>> ras_prev_pos=-1
>>>>> [ 1493.165952] do_sync_mmap_readahead:3015 ino=132 index=254 count=0
>>>>> ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0
>>>>> ras_prev_pos=-1
>>>>> [ 1493.185566] do_sync_mmap_readahead:3015 ino=132 index=253 count=0
>>>>> ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0
>>>>> ras_prev_pos=-1
>>>>> ...
>>>>> [ 1496.341890] do_sync_mmap_readahead:3015 ino=132 index=64 count=0
>>>>> ras_start=0 ras_size=64 ras_async=32 ras_ra_pages=64 ras_mmap_miss=0
>>>>> ras_prev_pos=-1
>>>>> [ 1496.361385] do_sync_mmap_readahead:3015 ino=132 index=511 count=0
>>>>> ras_start=96 ras_size=64 ras_async=64 ras_ra_pages=64 ras_mmap_miss=0
>>>>> ras_prev_pos=-1
>>>>>
>>>>>
>>>>> So we can see from fuse that it starts to read at page index 0, wants
>>>>> 64 pages (which is actually the double of bdi read_ahead_kb), then
>>>>> skips index 64...254) and immediately goes to index 255. For the 
>>>>> mmaped
>>>>> memcpy pages are missing and then it goes back in 1 page steps to get
>>>>> these.
>>>>>
>>>>> A workaround here is to set read_ahead_kb in the bdi to a larger
>>>>> value, another workaround might be (untested) to increase the 
>>>>> read-ahead
>>>>> window. Either of these two seem to be workarounds for the index order
>>>>> above.
>>>>>
>>>>> I understand that read-ahead gets limited by the bdi value (although
>>>>> exceeded above), but why does it go back in 1 page steps? My 
>>>>> expectation
>>>>> would have been
>>>>>
>>>>> index=0  count=32 (128kb read-head)
>>>>> index=32 count=32
>>>>> index=64 count=32
>>>
>>> What I see with XFS is:
>>>
>>>               fio-27518   [005] .....   276.565025: 
>>> mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x23a8c ofs=0 order=2
> 
> ...
> 
>>> mm_filemap_add_to_page_cache: dev 8:32 ino 44 pfn=0x15e40 ofs=786432 
>>> order=6
>>>
>>> ... it then gets "stuck" at order-6, which is expected for a 256kB
>>> readahead window.
>>>
>>> This is produced by:
>>>
>>> echo 1 
>>> >/sys/kernel/tracing/events/filemap/mm_filemap_add_to_page_cache/enable
>>> fio --size=1G --numjobs=1 --ioengine=mmap 
>>> --output-format=normal,terse --directory=/mnt/scratch/ --rw=read 
>>> multi-file.fio
>>> echo 0 
>>> >/sys/kernel/tracing/events/filemap/mm_filemap_add_to_page_cache/enable
>>> less /sys/kernel/tracing/trace
>>>
>>
>> Thanks for looking at it Matthew!
>>
>> I see the same as on fuse on xfs - same output as I initially
>> posted (except the fuse logging, of course).
>>
>> With tracing and reduced file size to 2M
>>
> 
> ...
> 
>>               fio-3459    [011] ..... 65055.436534: 
>> mm_filemap_add_to_page_cache: dev 252:16 ino 84 pfn=0x12cfb5 
>> ofs=1052672 order=0
>>
>> And then it is stuck at order=0
>>
> 
> When I reduce bs to 4K I get similar results as you
> 
> fio --size=10M --numjobs=1 --ioengine=mmap --output-format=normal,terse 
> --directory=/scratch/source/ --rw=read multi-file.fio --bs=4K 
> --group_reporting
> 
> (so bs set to 4K)
> 
> and a basically empty job file
> 
> bernd@squeeze1 test2>cat multi-file.fio
> [global]
> 
> [test]
> 
> 
> 
> Up to bs=512K it works fine, 1M (and for what it matters
> already 768K) introduce the order=0 issue.

Hmm, I replaced memcpy with dumb version, that copies byte by byte - 
problem gone. Is it possible that the optimized memcpy causes caused 
kind of random memory access and confuses mm / readahead?
And somehow your memcpy or system is not doing that?


Thanks,
Bernd


