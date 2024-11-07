Return-Path: <linux-fsdevel+bounces-33919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB9B9C0B08
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 17:13:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E245B2343B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713E72185B6;
	Thu,  7 Nov 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="aDXIj9hg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF1F216A2C;
	Thu,  7 Nov 2024 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995808; cv=none; b=P1Zh1LVVLLDd0Rp2bklEv3IVWIsuv1qnIKBJ0QW07uEyneVmqFORvH4NQdSFZdLG7cGqEs7pGRFFeZkA7kIPlatOhKaV2LJnuR5Q/O5d4L8NAE6RfFc67waRwYfrzzU3VyGJekUgvbGK/pv5NB19cEc5BY8PcM3TeSxW8qe3w1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995808; c=relaxed/simple;
	bh=bQz6/FZvMynqNz7pri7XLl1TMOY9sqbE9V7VCPdO+fQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uma5bg4crBxHkIi1tdPI4vkNmIc3PWsV4K0qHev/fpyyQVV76vq21yng8Ctj1QKVcCpfeh3JQvdmUnBKdHTpyUPKV0IOR/xE47rQM6oAr0RusbMaiyNiGZZ72vg0+mZc0cQcVtt8q1cnBRdVOmFXws7DDQq4Xh5p78QX41SvmxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=aDXIj9hg; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 2074841A48;
	Thu,  7 Nov 2024 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1730995796;
	bh=bQz6/FZvMynqNz7pri7XLl1TMOY9sqbE9V7VCPdO+fQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aDXIj9hgkaCTiWlDRpvCgN2CPunlkqvjXB+oFMRipx9estnAof3MZeq70K8pP5e0f
	 At/EC3KUYXkpAmMe/ow/gVlpBBaNA7bKNPMRi90KIspEWCYTyB7cpPTdByyp27cQQX
	 Jt4Slw6RJeMsxjdKZjqx/r+uV1T0dcrrjMrZoVumNzzmdn4FhPm8/WcqlG2mASLbco
	 LSh+wbpZpr4//TTV3MWo7NbrTUn5bx7tqhEiEnNF1kdwXVgMVGRv0M2//gX700njzh
	 uZ1u+G2g6PL4EqfKnk4OR6AbN4tR9/rf32LH4tdL1haVgUE8dOiELedFVXBpmJizNY
	 SrO6+uVija92g==
Message-ID: <28308919-7e47-49e4-a821-bcd32f73eecb@asahilina.net>
Date: Fri, 8 Nov 2024 01:09:54 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
To: Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>
Cc: Dave Chinner <david@fromorbit.com>, Matthew Wilcox <willy@infradead.org>,
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
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <20241107100105.tktkxs5qhkjwkckg@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/7/24 7:01 PM, Jan Kara wrote:
> On Wed 06-11-24 11:59:44, Dan Williams wrote:
>> Jan Kara wrote:
>> [..]
>>>> This WARN still feels like the wrong thing, though. Right now it is the
>>>> only thing in DAX code complaining on a page size/block size mismatch
>>>> (at least for virtiofs). If this is so important, I feel like there
>>>> should be a higher level check elsewhere, like something happening at
>>>> mount time or on file open. It should actually cause the operations to
>>>> fail cleanly.
>>>
>>> That's a fair point. Currently filesystems supporting DAX check for this in
>>> their mount code because there isn't really a DAX code that would get
>>> called during mount and would have enough information to perform the check.
>>> I'm not sure adding a new call just for this check makes a lot of sense.
>>> But if you have some good place in mind, please tell me.
>>
>> Is not the reason that dax_writeback_mapping_range() the only thing
>> checking ->i_blkbits because 'struct writeback_control' does writeback
>> in terms of page-index ranges?
> 
> To be fair, I don't remember why we've put the assertion specifically into
> dax_writeback_mapping_range(). But as Dave explained there's much more to
> this blocksize == pagesize limitation in DAX than just doing writeback in
> terms of page-index ranges. The whole DAX entry tracking in xarray would
> have to be modified to properly support other entry sizes than just PTE &
> PMD sizes because otherwise the entry locking just doesn't provide the
> guarantees that are expected from filesystems (e.g. you could have parallel
> modifications happening to a single fs block in pagesize < blocksize case).
> 
>> All other dax entry points are filesystem controlled that know the
>> block-to-pfn-to-mapping relationship.
>>
>> Recall that dax_writeback_mapping_range() is historically for pmem
>> persistence guarantees to make sure that applications write through CPU
>> cache to media.
> 
> Correct.
> 
>> Presumably there are no cache coherency concerns with fuse and dax
>> writes from the guest side are not a risk of being stranded in CPU
>> cache. Host side filesystem writeback will take care of them when / if
>> the guest triggers a storage device cache flush, not a guest page cache
>> writeback.
> 
> I'm not so sure. When you call fsync(2) in the guest on virtiofs file, it
> should provide persistency guarantees on the file contents even in case of
> *host* power failure. So if the guest is directly mapping host's page cache
> pages through virtiofs, filemap_fdatawrite() call in the guest must result
> in fsync(2) on the host to persist those pages. And as far as I vaguely
> remember that happens by KVM catching the arch_wb_cache_pmem() calls and
> issuing fsync(2) on the host. But I could be totally wrong here.

I don't think that's how it actually works, at least on arm64.
arch_wb_cache_pmem() calls dcache_clean_pop() which is either dc cvap or
dc cvac. Those are trapped by HCR_EL2<TPC>, and that is never set by KVM.

There was some discussion of this here:
https://lore.kernel.org/all/20190702055937.3ffpwph7anvohmxu@US-160370MP2.local/

But I'm not sure that all really made sense then.

msync() and fsync() should already provide persistence. Those end up
calling vfs_fsync_range(), which becomes a FUSE fsync(), which fsyncs
(or fdatasyncs) the whole file. What I'm not so sure is whether there
are any other codepaths that also need to provide those guarantees which
*don't* end up calling fsync on the VFS. For example, the manpages kind
of imply munmap() syncs, though as far as I can tell that's not actually
the case. If there are missing sync paths, then I think those might just
be broken right now...

~~ Lina


