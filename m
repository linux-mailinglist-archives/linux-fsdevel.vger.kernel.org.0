Return-Path: <linux-fsdevel+bounces-19496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A0F8C5FD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 06:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEBB1C21F8C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 04:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF819381B9;
	Wed, 15 May 2024 04:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClUVt4S2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B27E20314
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 04:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748466; cv=none; b=aU1P+GMVX/WDm3AfRW9hPY1uzxfAu9TINuBid8GWKH6QWwD7sWEH4YD2Y82X19k55Gs7r7NxxiRfQLqvqqXk7Ai44VEcFegNqN/56oZSovEHYdfOx+7uRm6jHBu81GUVLnPO44N9piGxLZ3t20UITcI4kPJRMvrCvvUAdNq6f4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748466; c=relaxed/simple;
	bh=6fUckgxwLLzf0rniCYbyyFgTJIFLissZPXLhjw/kRvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kE1Nzm4M+5kFAkw38y2vPTD11hVDGiEJ229Gd8sFp9LB9vNC5eQCbhP0HlMONatPAr1XH+1kra5zCgf7eGPO/mVsFGgc9srVXHV2he/cYbUduQjOXYOpdhC1Fk8oMnp9eivvaK/a8LImp5I6zrAMQKLZrKnTFQmK5moxUkdMePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClUVt4S2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1802C116B1;
	Wed, 15 May 2024 04:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715748465;
	bh=6fUckgxwLLzf0rniCYbyyFgTJIFLissZPXLhjw/kRvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ClUVt4S2XoG1SwiZ8pXPXIjAYveaooXldPxrnXX8fl8BP9ME7xDM2D4LdkKzcPp2I
	 IicKZNejEKXU/pC2J/LEjzL8jvoszQ3zvIkZW+s4fTmwGTCBdJ0hCDPn9qwGvAfc+3
	 YKrnXJJsnhepW/1qjk78OcWlThKEMhcCJZpTD3przuVFOLnz+tYCenn6zCdOGQ0v7R
	 GoSnAwH/OjVZgxc4KodbrBfiS3Mr1hp6Zqsa7RTbkSPMDDYZRgU0BW6y9eCnjXBNJv
	 Nr6GVgIoGxllXR5mLt1mDf5u0IpkZyfAasdLO8ekdLZfHTpE3mjkg4iHoIidcnCqpY
	 4s3vfdBF4Az0g==
Date: Tue, 14 May 2024 21:47:45 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: page-flags.rst
Message-ID: <20240515044745.GE360898@frogsfrogsfrogs>
References: <ZkOu4yXP-sGGtwc4@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkOu4yXP-sGGtwc4@casper.infradead.org>

On Tue, May 14, 2024 at 07:35:15PM +0100, Matthew Wilcox wrote:
> As encouraged by my lively audience / collaborators, here is the
> typos-and-all result of the LSFMM session which just finished.
> 
> Please don't respond to point out the typos; trust that I will fix them.

May I bikeshed starting sentences on a new line for better diffability,
then?

Arbitrary incoherent comments follow:

> ==========
> Page flags
> ==========
> 
> Struct page includes a 'flags' word.  Despite its name, various other
> things are also stored in this word, including the page's node, zone,
> section, and last_cpupid.  See include/linux/page-flags-layout.h for
> details.
> 
> Locked
> ======
> 
> This flag is per-folio.  If you attempt to lock a page, you will lock
> the entire folio.  The folio lock is used for many purposes.  In the page
> cache, folios are locked before reads are started and unlocked once the
> read has completed.  The folio is also locked before writeback starts;
> see the writeback flag for more detail.  The truncation path takes the
> folio lock, and folios are also locked while being inserted into page
> tables in order to prevent races between truncation and page fault.

If you drop the lock of a pagecache folio and relock it, you have to
revalidate mapping and index of the head, right?

> ... more detail here please ...
> 
> Writeback
> =========
> 
> Per-folio
> This is kind of a lock
> We downgrade to it having taken the lock flag
> Rekeased after wrut4back completes, but lock flag may be released any time after writeback flag set.  Deopends on filesystem whether needs to do more between

more between...? /me doesn't understand the sentence.

> We can wait for writeback to complete by waiting on this flag
> Folio put to tail of LRU for faster reclaim
> 
> Can prevent tearing write is filesystem needs stable folios

If the filesystem or the block device (e.g. T10 PI/RAID5) need stable
folios.

> Truncate will wait for flag to clear
> 
> 
> Referenced
> ==========
> 
> Per-folio flag.  At least one page table entry has a accessed bit set for this folio
> We set this during scan.  Also set during buffered IO.  Referenced first time, Accessed second time.
> Used during reclaim to determine dispotition (activate, reclaim, etc)
> 
> Uptodate
> ========
> 
> Every byte of the folio contents is at least as new as the contents of disk
> implicit write bbarrier
> 
> 
> Dirty
> =====
>   Also set during buffered IO.  Referenced first time, Accessed second time.
>   Used during reclaim to determine dispotition (activate, reclaim, etc)
> At least one byte of the folio contents is newer than on disk and the writeback flag is not yet set
> folios may be both dirty and not uptodate
> lazyfree pages can drop the dirty bit
> dirty flag clear for file folios when we start writeback
> set dirty flag when removed from swapcache
> if already dirty, folios can be mapped writable without notifying filesystem
> complicated interfaces to set easy to get wrong
> redirty_for_writeback
> 
> 
> 
> LRU
> ===
> 
> FOlio has been added to the LRU and is no longer in percpu folio_batch
> 
> 
> Head
> ====
> 
> This folio is a large folio.  It is not set on order-0 folios.

Is it not set on the non-head pages as well?

> 
> Waiters
> =======
> 
> Page has waiters, check its waitqueue.
> Only used by core code.  Don't touch.
> 
> Active
> ======
> 
> On the active LRU list.
> Can be set in advance to tell kernel to put it on the right list
> 
> Workingset
> ==========
> 
> Set on folios in pagecache once readahead pages actually accessed
> Set on LRU pages that were activated have been deactivated, treat refault as thrashing
> refault handler also sets it on folios that were hot before reclaimed
> used by PSI computation
> 
> Owner_Priv_1
> ============
> 
> Owner use. If pagecache, fs may use
> 
> Used as Checked flag by many filesystems.
> Used as SwapBacked flag by swap code.
> 
> Arch_1
> ======
> 
> Many different uses depending on architecture.  Oftern used as a "dcache clean" or, comfusingly as "dcache dirty".  Check with your architecture.
> 
> s390 uses it for basically everything.
> 
> Historicalkly was used on a per page basis.  Think we've eliminated all per-page uses now so should only be set on folios.
> 
> Reserved
> ========
> 
> 
> 
> Private
> =======
> 
> If pagecache, has fs-private data
> 
> Private_2
> =========
> 
> If pagecache, has fs aux data
> 
> Mapped_to_disk
> ==============
> 
> Has blocks allocated on-disk
> 
> Reclaim
> =======
> 
> To be reclaimed asap
> 
> Swap_backed
> ===========
> 
> Page is backed by RAM/swap
> 
> Unevictable
> ===========
> 
> Page is "unevictable"
> 
> Mlocked
> =======
> 
> Page is vma mlocked
> 
> Uncached
> ========
> 
> Page has been mapped as uncached
> 
> HWPoison
> ========
> 
> hardware poisoned page. Don't touch

I forgot the results of our expedition into why shmem.c checks
PageHWPoison so much vs checking for EIO on the file/inode/etc.
My hazy recollection is that poisoning a pagecache folio also sets
AS_EIO too?  If that's true, maybe we should mention that.

--D

> Young
> =====
> 
> Idle
> ====
> 
> Arch 2
> ======
> 
> Arch 3
> ======
> 
> Readahead
> =========
> 
> Aliases with Reclaim as they are usually never set on the same folio, and
> if they are the consequences are a minor performance loss.
> 
> Anon_Exclusive
> ==============
> 
> Aliases with Mapped_To_Disk as that flag can never be set on anonymous folios.
> 
> Isolated
> ========
> 
> Shared with Reclaim flag, only valid for folios with LRU flag clear.
> 
> Reported
> ========
> 
> Only valid for buddy pages. Used to track pages that are reported
> 
> Has_HWPoisoned
> ==============
> 
> Large_Rmappable
> ===============
> 
> 
> 

