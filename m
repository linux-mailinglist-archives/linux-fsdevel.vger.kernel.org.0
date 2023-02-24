Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2946A16D8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Feb 2023 08:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjBXHBr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 24 Feb 2023 02:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBXHBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 24 Feb 2023 02:01:46 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C2A60D48
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Feb 2023 23:01:44 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PNLR54pwfz4f3lwh
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Feb 2023 15:01:37 +0800 (CST)
Received: from [10.174.176.34] (unknown [10.174.176.34])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rHSYPhjdvjdEA--.43719S3;
        Fri, 24 Feb 2023 15:01:39 +0800 (CST)
Subject: Re: LSF/MM/BPF 2023 IOMAP conversion status update
To:     Luis Chamberlain <mcgrof@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Cc:     lsf-pc@lists.linux-foundation.org,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "kbus @imap.suse.de>> Keith Busch" <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        yi.zhang@huawei.com, guohanjun@huawei.com
References: <20230129044645.3cb2ayyxwxvxzhah@garbanzo>
 <Y9X+5wu8AjjPYxTC@casper.infradead.org>
 <20230208160422.m4d4rx6kg57xm5xk@quack3>
From:   Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <b1dec5c2-0437-de15-b2f4-13609b4378f0@huaweicloud.com>
Date:   Fri, 24 Feb 2023 15:01:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230208160422.m4d4rx6kg57xm5xk@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: gCh0CgBH_rHSYPhjdvjdEA--.43719S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCw18Xr1DXw17CryUAF4DXFb_yoWrAw1xpF
        WagFnrKr1ktF48Zrn7ua1xtFWIya909345Xr90qry5Aa45GrnagFZrtayqyFyqgryfu3Wa
        vr4jvFyUuF9FvrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/2/9 0:04, Jan Kara wrote:
> On Sun 29-01-23 05:06:47, Matthew Wilcox wrote:
>> On Sat, Jan 28, 2023 at 08:46:45PM -0800, Luis Chamberlain wrote:
>>> I'm hoping this *might* be useful to some, but I fear it may leave quite
>>> a bit of folks with more questions than answers as it did for me. And
>>> hence I figured that *this aspect of this topic* perhaps might be a good
>>> topic for LSF.  The end goal would hopefully then be finally enabling us
>>> to document IOMAP API properly and helping with the whole conversion
>>> effort.
>>
>> +1 from me.
>>
>> I've made a couple of abortive efforts to try and convert a "trivial"
>> filesystem like ext2/ufs/sysv/jfs to iomap, and I always get hung up on
>> what the semantics are for get_block_t and iomap_begin().
> 
> Yeah, I'd be also interested in this discussion. In particular as a
> maintainer of part of these legacy filesystems (ext2, udf, isofs).
> 
>>> Perhaps fs/buffers.c could be converted to folios only, and be done
>>> with it. But would we be loosing out on something? What would that be?
>>
>> buffer_heads are inefficient for multi-page folios because some of the
>> algorthims are O(n^2) for n being the number of buffers in a folio.
>> It's fine for 8x 512b buffers in a 4k page, but for 512x 4kb buffers in
>> a 2MB folio, it's pretty sticky.  Things like "Read I/O has completed on
>> this buffer, can I mark the folio as Uptodate now?"  For iomap, that's a
>> scan of a 64 byte bitmap up to 512 times; for BHs, it's a loop over 512
>> allocations, looking at one bit in each BH before moving on to the next.
>> Similarly for writeback, iirc.
>>
>> So +1 from me for a "How do we convert 35-ish block based filesystems
>> from BHs to iomap for their buffered & direct IO paths".  There's maybe a
>> separate discussion to be had for "What should the API be for filesystems
>> to access metadata on the block device" because I don't believe the
>> page-cache based APIs are easy for fs authors to use.
> 
> Yeah, so the actual data paths should be relatively easy for these old
> filesystems as they usually don't do anything special (those that do - like
> reiserfs - are deprecated and to be removed). But for metadata we do need
> some convenience functions like - give me block of metadata at this block
> number, make it dirty / clean / uptodate (block granularity dirtying &
> uptodate state is absolute must for metadata, otherwise we'll have data
> corruption issues). From the more complex functionality we need stuff like:
> lock particular block of metadata (equivalent of buffer lock), track that
> this block is metadata for given inode so that it can be written on
> fsync(2). Then more fancy filesystems like ext4 also need to attach more
> private state to each metadata block but that needs to be dealt with on
> case-by-case basis anyway.
> 

Hello, all.

I also interested in this topic, especially for the ext4 filesystem iomap
conversion of buffered IO paths. And also for the discussion of the metadata APIs,
current buffer_heads could lead to many potential problems and brings a lot of
quality challenges to our products. I look forward to more discussion if I can
attend offline.

Thanks,
Yi.

>> Maybe some related topics are
>> "What testing should we require for some of these ancient filesystems?"
>> "Whose job is it to convert these 35 filesystems anyway, can we just
>> delete some of them?"
> 
> I would not certainly miss some more filesystems - like minix, sysv, ...
> But before really treatening to remove some of these ancient and long
> untouched filesystems, we should convert at least those we do care about.
> When there's precedent how simple filesystem conversion looks like, it is
> easier to argue about what to do with the ones we don't care about so much.
> 
>> "Is there a lower-performance but easier-to-implement API than iomap
>> for old filesystems that only exist for compatibiity reasons?"
> 
> As I wrote above, for metadata there ought to be something as otherwise it
> will be real pain (and no gain really). But I guess the concrete API only
> matterializes once we attempt a conversion of some filesystem like ext2.
> I'll try to have a look into that, at least the obvious preparatory steps
> like converting the data paths to iomap.
> 
> 								Honza
> 

