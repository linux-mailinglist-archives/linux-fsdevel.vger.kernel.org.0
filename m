Return-Path: <linux-fsdevel+bounces-17994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFFA8B4956
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 05:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52C8EB21222
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Apr 2024 03:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5DD23BB;
	Sun, 28 Apr 2024 03:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSE1W0ug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666AC15A4;
	Sun, 28 Apr 2024 03:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714274267; cv=none; b=cP9md6zaa0CJuDNOyD+pEaPz7iGY4/XKMPfrFmoHsBInvqbZejPCazvq8WuMzKXFjzLZMcRuVfpDzM/022KNSnPbA5CxplQexOp5GKKpR3jjEOsz2EgCzmOOwu+f9MuVTsWmR1Fp1XiX2z/pY2QG1NyXo08DkRI78TCGndys7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714274267; c=relaxed/simple;
	bh=Stf6RD+wk0dcrnB98wXmtvpPzh3y/7iTC6dGDf6CG6E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dOhPdt927EMgfc0qosSs1xvSCEYtFT0DdWcYt0j3xeKiml+hJJtnNVpX23w/0GhUKOGypkWzHuXXbCuc7AU0uVbEEUD6av2SPxA2nWozZN9O3I5V/Im/JGtVb27rMwzF6ncNxo/Psr5bApU+2fQDwyEUpZLDC/AE6a4JdteQXxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSE1W0ug; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53A4C4AF17;
	Sun, 28 Apr 2024 03:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714274265;
	bh=Stf6RD+wk0dcrnB98wXmtvpPzh3y/7iTC6dGDf6CG6E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eSE1W0uggxKHMhGrafLiJ1MoFp6jqU0EtHhmTgaE7FD4rgDGhvXvwpgtHYv7X7tv9
	 IUyXlgs2qZyH77BpEWVg91SzUXwOMH+0G6jiV5pKwep68UypOG9Y6DaiiKLz6Mkczc
	 kma9smBLp1ZgQZvjYGPIXrgitC0pyJTSmmtX+w8nYqWqXEF9r8q8iTzLjvTlhwNUAQ
	 3avnbxMudfJ/zwx0/ZETQql4MRxSBH0e9dBBPqGsHAXBLDeBw6UUwMm0qJOCmWdveF
	 nIsER7Q+8JoeGWomOi6vvyBFi69Rk0dKnLglCYpQe70Ux/uu/E9KY2+EUcikN9uZuI
	 semwXapexl8aA==
Message-ID: <e635105f-829d-457d-a2ff-4672ec7a42fe@kernel.org>
Date: Sun, 28 Apr 2024 11:17:37 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] f2fs: drop usage of page_index
To: Matthew Wilcox <willy@infradead.org>, Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
 Barry Song <v-songbaohua@oppo.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Neil Brown <neilb@suse.de>, Minchan Kim <minchan@kernel.org>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
References: <20240423170339.54131-1-ryncsn@gmail.com>
 <20240423170339.54131-4-ryncsn@gmail.com>
 <Zig9JCrhky9JieRS@casper.infradead.org>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Zig9JCrhky9JieRS@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/24 6:58, Matthew Wilcox wrote:
> On Wed, Apr 24, 2024 at 01:03:34AM +0800, Kairui Song wrote:
>> @@ -4086,8 +4086,7 @@ void f2fs_clear_page_cache_dirty_tag(struct page *page)
>>   	unsigned long flags;
>>   
>>   	xa_lock_irqsave(&mapping->i_pages, flags);
>> -	__xa_clear_mark(&mapping->i_pages, page_index(page),
>> -						PAGECACHE_TAG_DIRTY);
>> +	__xa_clear_mark(&mapping->i_pages, page->index, PAGECACHE_TAG_DIRTY);
>>   	xa_unlock_irqrestore(&mapping->i_pages, flags);
>>   }
> 
> I just sent a patch which is going to conflict with this:
> 
> https://lore.kernel.org/linux-mm/20240423225552.4113447-3-willy@infradead.org/
> 
> Chao Yu, Jaegeuk Kim; what are your plans for converting f2fs to use

Hi Matthew,

I've converted .read_folio and .readahead of f2fs to use folio w/ below patchset,
and let me take a look how to support and enable large folio...

https://lore.kernel.org/linux-f2fs-devel/20240422062417.2421616-1-chao@kernel.org/

Thanks,

> folios?  This is getting quite urgent.

