Return-Path: <linux-fsdevel+bounces-34421-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0339C529C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 11:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20401B2685B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81D4820E314;
	Tue, 12 Nov 2024 09:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="bxE3XTOU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1E520CCE9;
	Tue, 12 Nov 2024 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731404990; cv=none; b=uWfz3gRqQfFlnJgD1/nHVwbwhf0SDLCd/iwQom64pSwdlgkngPH67fOhj/qQPOGKYGnQi6klBRKjVkgpoxn4hxiEZmUZUk/v98C6b2wPcvMxr65E1oNv73okmwGVBesVv+nk/iU0/Hir6Dp8XV/22jkHgM73MZ7ZuxRVgN4u5gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731404990; c=relaxed/simple;
	bh=2Xz3/5UBzjG9E2T5qRaLZwW2h3Omo4UO0rF/gdvx0zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cm5lPnTkx7xKHGssAq6gIWCfc47mZYTEWoL7yzG0y7hqA9NvTZ6/r1pWNQKNzQzGNjvZ4HkxtV7i7Ixdqh6cL0vc8nI0FgtPfrjWJ0ycGFKPjski84sMeqa8jVIn7MZ0tD7GYnmkaekBXgVQLwD2NqvuXYGyfUbLiYyXd5cLtNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=bxE3XTOU; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id ACB9742118;
	Tue, 12 Nov 2024 09:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1731404987;
	bh=2Xz3/5UBzjG9E2T5qRaLZwW2h3Omo4UO0rF/gdvx0zg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bxE3XTOUk3F7yeLfYKEs5fE5Iu92erW3q1CzBaUQOJbedmvr5IYKKdU15GsuW+FiT
	 bwJa7Q2HfKQMosUQvXpAIPkLVGmtR/W5bUDHS09nWDRxlGLVd2gwBxpMjII7t6evWc
	 4xLhqO0NvumLvy1JSc6xHjDTMlySdckJR9K8lz62u74sE7pRNL8EbDEi+zIdeLX8LJ
	 FrJxUXiReMrWbLF3VJWe1aLCQhfRvkinkSkZ+7uIGUkW4mkcluI7GAG8u45paGVjTg
	 zjz4fDpVtq1whMNYu9gE+P4M9mOMnKCP0He1lKPZawi+7jlE/HPRzTZdVjGvTAXIxY
	 YjFfVt5SlVDEg==
Message-ID: <a6866a71-dde9-44a2-8b0e-d6d3c4c702f8@asahilina.net>
Date: Tue, 12 Nov 2024 18:49:46 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
To: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Sergio Lopez Pascual
 <slp@redhat.com>, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
 <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
 <ZylHyD7Z+ApaiS5g@dread.disaster.area>
 <21f921b3-6601-4fc4-873f-7ef8358113bb@asahilina.net>
 <20241106121255.yfvlzcomf7yvrvm7@quack3>
 <672bcab0911a2_10bc62943f@dwillia2-xfh.jf.intel.com.notmuch>
 <20241107100105.tktkxs5qhkjwkckg@quack3>
 <28308919-7e47-49e4-a821-bcd32f73eecb@asahilina.net>
 <20241108121641.jz3qdk2qez262zw2@quack3>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <20241108121641.jz3qdk2qez262zw2@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/8/24 9:16 PM, Jan Kara wrote:
> On Fri 08-11-24 01:09:54, Asahi Lina wrote:
>> On 11/7/24 7:01 PM, Jan Kara wrote:
>>> On Wed 06-11-24 11:59:44, Dan Williams wrote:
>>>> Jan Kara wrote:
>>>> [..]
>>>>>> This WARN still feels like the wrong thing, though. Right now it is the
>>>>>> only thing in DAX code complaining on a page size/block size mismatch
>>>>>> (at least for virtiofs). If this is so important, I feel like there
>>>>>> should be a higher level check elsewhere, like something happening at
>>>>>> mount time or on file open. It should actually cause the operations to
>>>>>> fail cleanly.
>>>>>
>>>>> That's a fair point. Currently filesystems supporting DAX check for this in
>>>>> their mount code because there isn't really a DAX code that would get
>>>>> called during mount and would have enough information to perform the check.
>>>>> I'm not sure adding a new call just for this check makes a lot of sense.
>>>>> But if you have some good place in mind, please tell me.
>>>>
>>>> Is not the reason that dax_writeback_mapping_range() the only thing
>>>> checking ->i_blkbits because 'struct writeback_control' does writeback
>>>> in terms of page-index ranges?
>>>
>>> To be fair, I don't remember why we've put the assertion specifically into
>>> dax_writeback_mapping_range(). But as Dave explained there's much more to
>>> this blocksize == pagesize limitation in DAX than just doing writeback in
>>> terms of page-index ranges. The whole DAX entry tracking in xarray would
>>> have to be modified to properly support other entry sizes than just PTE &
>>> PMD sizes because otherwise the entry locking just doesn't provide the
>>> guarantees that are expected from filesystems (e.g. you could have parallel
>>> modifications happening to a single fs block in pagesize < blocksize case).
>>>
>>>> All other dax entry points are filesystem controlled that know the
>>>> block-to-pfn-to-mapping relationship.
>>>>
>>>> Recall that dax_writeback_mapping_range() is historically for pmem
>>>> persistence guarantees to make sure that applications write through CPU
>>>> cache to media.
>>>
>>> Correct.
>>>
>>>> Presumably there are no cache coherency concerns with fuse and dax
>>>> writes from the guest side are not a risk of being stranded in CPU
>>>> cache. Host side filesystem writeback will take care of them when / if
>>>> the guest triggers a storage device cache flush, not a guest page cache
>>>> writeback.
>>>
>>> I'm not so sure. When you call fsync(2) in the guest on virtiofs file, it
>>> should provide persistency guarantees on the file contents even in case of
>>> *host* power failure. So if the guest is directly mapping host's page cache
>>> pages through virtiofs, filemap_fdatawrite() call in the guest must result
>>> in fsync(2) on the host to persist those pages. And as far as I vaguely
>>> remember that happens by KVM catching the arch_wb_cache_pmem() calls and
>>> issuing fsync(2) on the host. But I could be totally wrong here.
>>
>> I don't think that's how it actually works, at least on arm64.
>> arch_wb_cache_pmem() calls dcache_clean_pop() which is either dc cvap or
>> dc cvac. Those are trapped by HCR_EL2<TPC>, and that is never set by KVM.
>>
>> There was some discussion of this here:
>> https://lore.kernel.org/all/20190702055937.3ffpwph7anvohmxu@US-160370MP2.local/
> 
> I see. Thanks for correcting me.
> 
>> But I'm not sure that all really made sense then.
>>
>> msync() and fsync() should already provide persistence. Those end up
>> calling vfs_fsync_range(), which becomes a FUSE fsync(), which fsyncs
>> (or fdatasyncs) the whole file. What I'm not so sure is whether there
>> are any other codepaths that also need to provide those guarantees which
>> *don't* end up calling fsync on the VFS. For example, the manpages kind
>> of imply munmap() syncs, though as far as I can tell that's not actually
>> the case. If there are missing sync paths, then I think those might just
>> be broken right now...
> 
> munmap(2) is not an issue because that has no persistency guarantees in
> case of power failure attached to it. Thinking about it some more I agree
> that just dropping dax_writeback_mapping_range() from virtiofs should be
> safe. The modifications are going to be persisted by the host eventually
> (so writeback as such isn't needed) and all crash-safe guarantees are
> revolving around calls like fsync(2), sync(2), sync_fs(2) which get passed
> by fuse and hopefully acted upon on the host. I'm quite confident with this
> because even standard filesystems such as ext4 flush disk caches only in
> response to operations like these (plus some in journalling code but that's
> a separate story).
> 
> 								Honza

I think we should go with that then. Should I send it as Suggested-by:
Dan or do you want to send it?

~~ Lina


