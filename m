Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5B251D745
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 May 2022 14:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391631AbiEFMH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 May 2022 08:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391635AbiEFMH1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 May 2022 08:07:27 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A905E64BF6
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 05:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651838622; x=1683374622;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VI8qxjFLlheDkNAyy6X02rzmG9+33ng0L25cSxgfA30=;
  b=TgGSj2n9EMbdBceYgA3YI1R+me2hF0hJ6s5AXDeetRi4Eo4/Fp5LU8J4
   Ya2x35BNx0bX/0GVVT7xbdMIGocHDKbI7L9mVURne+hCSNRb7Fo9q9W1n
   WQtfGqzDw++ZJBzQQdG7SKz9dvHMPrTzbIz616DHml6ee+mqfiOdxUnAr
   dkw5TSpMl9CTZvL7bJxfU9N11ns9okp9GCKrSkgDpsktGvpjaaTtRl8E0
   ar/XOEM56AbrTFppfrjvoSnKBU8ENzTOElZM+ujr5XSp245jago2yMmLp
   miJ29DpsGD1IpgZ4E2QGeITZ48/DrjGwkiLO80m2xC1QKceZzj37sxCql
   g==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647273600"; 
   d="scan'208";a="199687223"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 May 2022 20:03:42 +0800
IronPort-SDR: a7o6g+jOBsP7Egx96XZbFsq0WHsxCoIrV9KvMwOn+aYXSqf8ez5sAPL12k+jzirbR1XLOg2o/Q
 F9NAC6lSMaa1Ex1wAPNPZUEU16Rc7rH+fkL3+nQYA5q9r7FGCRgxP7BrIXmB2etsCyl9DSJUZM
 z5vlmNcZxlSboyEDW77WUbghLj2uujjFyTCdQ6wJzvKFp2StkV5yLfW5OYb62U7+ecN2Zq/L4y
 qk1viaOlo56T3aiUCbWvbASNaIELgbAyKWPF0lvwn2uVgT+DwHOVtkiQ25QwB8DNTkUF3IZH3o
 Ub8MryoxKqN7fdJe/Va9Pzyo
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2022 04:33:20 -0700
IronPort-SDR: Kfn4Lv5JDZ957j7XtyXTuGindAGNBfsPsAtKduyooCh4cT+Wxr1XJzTSMzcqIeKlI9OunCJsXC
 IdH+yYA/s00MYPonXKCJV7cx5cF3ABZYODo+q6SXk6NSN//NKv5S7EVQN2IKJu/xfqQ6tB9oB1
 EUM817JJTpWKRkxLfajZmcFDNVKvO6MTS1+PpP94iUaBGR+8oV60ADm9o1EqE9ypO+WhzFBeKJ
 RhyTCXLP9LO4cJNMNdWBdoh897FE+I9CgimoyCFRiaLibkjJdv5NxIM4nOPC5iyN84Lr9nT6uj
 /mQ=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 May 2022 05:03:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kvq3L3ryFz1Rwrw
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 May 2022 05:03:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651838621; x=1654430622; bh=VI8qxjFLlheDkNAyy6X02rzmG9+33ng0L25
        cSxgfA30=; b=ubA8/2JkOQw0IAO4JgjiWSy6V4TmySyE+9LjrvaP1oAk51yiV/u
        YRcO1grm10Z5cMFFDoGfQRBWVvfcFZsxDT+VbOlqnbOH4kMXmSmsMCMWStKGBoue
        Y9KpfyIkrlRcaNXps8ItMtQcrm1QoNRtxYgkKVcWsT5F+WxiemiLYv1o8vBoFV+d
        +syn6zwXWf5VwF0sUcRYJsqI48oulubgcVsP64vi6mYnDhXcSamOAGRqlCjHWSMv
        wwCkFrNgbSsauDxeP06737/sg8b9xro2ZkCVXov2XleP/TilHfDsQnExP06wJq2S
        PEPdiReULFvWnjMQsWeJzJpBsb6K1EtO3QQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bRGV54Br7-ud for <linux-fsdevel@vger.kernel.org>;
        Fri,  6 May 2022 05:03:41 -0700 (PDT)
Received: from [10.225.103.215] (hn9j2j3.ad.shared [10.225.103.215])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kvq3J6P8Kz1Rvlc;
        Fri,  6 May 2022 05:03:40 -0700 (PDT)
Message-ID: <6aeb8359-a31c-0832-61fe-ff6dc18b30c5@opensource.wdc.com>
Date:   Fri, 6 May 2022 21:03:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [RFC PATCH 00/10] Make O_SYNC writethrough
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>
References: <20220503064008.3682332-1-willy@infradead.org>
 <20220505045821.GA1949718@dread.disaster.area>
 <YnNbf9dPhJ3FiHzH@casper.infradead.org>
 <20220505070534.GB1949718@dread.disaster.area>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220505070534.GB1949718@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/05/05 16:05, Dave Chinner wrote:
> On Thu, May 05, 2022 at 06:07:11AM +0100, Matthew Wilcox wrote:
>> On Thu, May 05, 2022 at 02:58:21PM +1000, Dave Chinner wrote:
>>> On Tue, May 03, 2022 at 07:39:58AM +0100, Matthew Wilcox (Oracle) wrote:
>>>> This is very much in development and basically untested, but Damian
>>>> started describing to me something that he wanted, and I told him he
>>>> was asking for the wrong thing, and I already had this patch series
>>>> in progress.  If someone wants to pick it up and make it mergable,
>>>> that'd be grand.
>>>
>>> That've very non-descriptive. Saying "someone wanted something, I said it's
>>> wrong, so here's a patch series about something else" doesn't tell me anything
>>> about the problem that Damien was trying to solve.
>>
>> Sorry about that.  I was a bit jet-lagged when I wrote it.
>>
>>>> The idea is that an O_SYNC write is always going to want to write, and
>>>> we know that at the time we're storing into the page cache.  So for an
>>>> otherwise clean folio, we can skip the part where we dirty the folio,
>>>> find the dirty folios and wait for their writeback.
>>>
>>> What exactly is this shortcut trying to optimise away? A bit of CPU
>>> time?
>>>
>>> O_SYNC is already a write-through operation - we just call
>>> filemap_write_and_wait_range() once we've copied the data into the
>>> page cache and dirtied the page. What does skipping the dirty page
>>> step gain us?
>>
>> Two things; the original reason I was doing this, and Damien's reason.
>>
>> My reason: a small write to a large folio will cause the entire folio to
>> be dirtied and written.
> 
> If that's a problem, then shouldn't we track sub-folio dirty
> regions? Because normal non-O_SYNC buffered writes will still cause
> this to happen...
> 
>> This is unnecessary with O_SYNC; we're about
>> to force the write anyway; we may as well do the write of the part of
>> the folio which is modified, and skip the whole dirtying step.
> 
> What happens when another part of the folio is concurrently dirtied?
> 
> What happens if the folio already has other parts of it under
> writeback? How do we avoid and/or resolve concurent "partial folio
> writeback" race conditions?
> 
>> Damien's reason: It's racy.  Somebody else (... even vmscan) could cause
>> folios to be written out of order.  This matters for ZoneFS because
>> writing a file out of order is Not Allowed.  He was looking at relaxing
>> O_DIRECT, but I think what he really wants is a writethrough page cache.
> 
> Zonefs has other mechanisms to solve this. It already has the
> inode_lock() to serialise all dio writes to a zone because they must
> be append IOs. i.e. new writes must be located at the write pointer,
> and the write pointer does not get incremented until the IO
> has been submitted (for DIO+AIO) or completed (for non-AIO).
> 
> Hence for buffered writes, we have the same situation: once we have
> sampled the zone write pointer to get the offset, we cannot start
> another write until the current IO has been submitted.
> 
> Further, for zonefs, we cannot get another write to that page cache
> page *ever*; we can only get reads from it. Hence page state really
> doesn't matter at all - once there is data in the page cache page,
> all that can happen is it can be invalidated but it cannot change
> (ah, the beauties of write-once media!). Hence the dirty state is
> completely meaningless from a coherency and integrity POV, as is the
> writeback state.
> 
> IOWs, for zonefs we can already ignore the page dirtying and
> writeback mechanisms fairly safely. Hence we could do something like
> this in the zonefs buffered write path:
> 
> - lock the inode
> - sample the write pointer to get the file offset
> - instantiate a page cache folio at the given offset
> - copy the data into the folio, mark it up to date.
> - mark it as under writeback or lock the folio to keep reclaim away
> - add the page cache folio to an iter_iov
> - pass the iter_iov to the direct IO write path to submit the IO and
>   wait for completion.
> - clear the folio writeback state.
> - move the write pointer
> - unlock the inode

That was my initial idea. When I talked about it with Matthew, he mentioned his
write-through work and posted it. For my use case, I do like what he has done
since that would avoid the need to add most of the above machinery to zonefs.
But if there are no benefits anywhere else, adding this as a zonefs only thing
is fine with me.

> and that gets us writethrough O_SYNC buffered writes. In fact, I
> think it may even work with async writes, too, just like the DIO
> write path seems to work with AIO.

Yes, I think this all works for AIOs too since we use the "soft" write pointer
position updated on BIO submit, not completion.

> The best part about the above mechanism is that there is
> almost no new iomap, page cache or direct IO functionality required
> to do this. All the magic is all in the zonefs sequential zone write
> path. Hence I don't see needing to substantially modify the iomap
> buffered write path to do zonefs write-through....

Indeed. The only additional constraint is that zonefs must still ensure that
writes are physical block aligned to avoid iomap attempting to do a
read-modify-rewrite of the last written sector of a zone. Just need to think
about potential corner cases when the page size is larger than the device block
size. Could the partially filled last page of a file ever end-up needing a
read-modify-write ? I do not think so, but need to check.

>>>> The biggest problem with all this is that iomap doesn't have the necessary
>>>> information to cause extent allocation, so if you do an O_SYNC write
>>>> to an extent which is HOLE or DELALLOC, we can't do this optimisation.
>>>> Maybe that doesn't really matter for interesting applications.  I suspect
>>>> it doesn't matter for ZoneFS.
>>>
>>> This seems like a lot of complexity for only partial support. It
>>> introduces races with page dirtying and cleaning, it likely has
>>> interesting issues with all the VM dirty/writeback accounting
>>> (because this series is using a completion path that expects the
>>> submission path has done it's side of the accounting) and it only
>>> works in certain preconditions are met.
>>
>> If we want to have better O_SYNC support, I think we can improve those
>> conditions.  For example, XFS could preallocate the blocks before calling
>> into iomap.  Since it's an O_SYNC write, everything is already terrible.
> 
> Ugh, that's even worse.
> 
> Quite frankly, designing pure O_SYNC writethrough is a classic case
> of not seeing the forest for the trees.  What we actually need is
> *async* page cache write-through.
> 
> Ever wondered why you can only get 60-70k write IOPS out of buffered
> writes? e.g untarring really large tarballs of small files always
> end up at 60-70k write IOPS regardless of filesystem, how many
> threads you break the writes up into, etc? io_uring buffered writes
> won't save us here, either, because it's not the data ingest side
> that limits performance. Yeah, it's the writeback side that limits
> us.
> 
> There's a simple reason for that: the flusher thread becomes CPU
> bound doing the writeback of hundreds of thousands of dirty inodes.
> 
> Writeback caching is a major bottleneck on high performance storage;
> when your storage can do 6.5GB/s and buffered writes can only copy
> into the page cache and flush to disk at 2GB/s (typically lower than
> this!), writeback caching is robbing us of major amounts of
> performance.
> 
> It's even worse with small files - the flusher thread becomes CPU
> bound at 60-80k IOPS on XFS, ext4 and btrfs because block allocation
> is an expensive operation. On a device with a couple of million IOPS
> available, having the kernel top out at under 5% of it's capacity is
> pretty bad.
> 
> However, if I do a hacky "writethrough" of small writes by calling
> filemap_flush() in ->release() (i.e. when close is called after the
> write), then multithreaded small file write workloads can push
> *several hundred thousand* write IOPS to disk before I run out of
> CPU.
> 
> Write-through enables submission concurrency for small IOs. It
> avoids lots of page state management overehad for high data
> throughput IO. That's where all the performance wins with high end
> storage are - keeping the pipes full. Buffered writes stopped being
> able to do that years ago, and modern PCIe4 SSDs have only made that
> gulf wider again.
> 
> IOWs, what we actually need is a clean page cache write-through
> model that doesn't have any nasty quirks or side effects. IOWs, I
> think you are on the right conceptual path, just the wrong
> architectural path.
> 
> My preference would be for the page cache write-through mode to be a
> thin shim over the DIO write path. The DIO write path is a highly
> concurrent async IO engine - it's designed to handle everything
> AIO and io_uring can throw at it. Forget about "direct IO", just
> treat it as a high concurrency, high throughput async IO engine.
> 
> Hence for page cache write-through, all we do is instantiate the
> page cache page, lock it, copy the data into it and then pass it to
> the direct IO write implementation to submit it and then unlock it
> on completion.  There's nothing else we really need to do - the DIO
> path already handles everything else.

Yes ! And the special case for zonefs would actually implement almost exactly
this, modulo the additional requirement of the write alignment that is purely
due to zonefs/device constraint.

> 
> And if we use page/folio locking for concurrency synchronisation of
> write-through mode instead of an exclusive inode lock, the model
> allows for concurrent, non-overlapping buffered writes to a single
> inode, just like we have for direct IO. It also allows us to avoid
> all dirty and writeback page cache and VM state/accounting
> manipulations. ANd by using the page/folio lock we avoid racing
> state transitions until the write-through op is complete.
> 
> Sure, if there is an existing dirty folio in the page cache, then
> punt it down the existing buffered IO path - something else is
> already using write-back caching for this folio (e.g. mmap), so we
> don't want to deal with trying to change modes.
> 
> But otherwise, we don't want to go near the normal buffered write
> paths - they are all optimised for *write back* caching.  From an IO
> and filesystem allocation optimisation perspective, page-cache
> write-through IO is exactly the same as direct IO writes.  Hence we
> ireally want page cache write-through to use the same allocator
> paths and optimisations as the direct IO path, not the existing
> buffered write path.
> 
> This sort of setup will get write-through buffered writes close to
> the throughput of what direct IO is capable of on modern storage. It
> won't quite match it, because DIO is zero copy and buffered IO is
> copy-once, but it'll get a *lot* closer than it does now....
> 
> Cheers,
> 
> Dave.


-- 
Damien Le Moal
Western Digital Research
