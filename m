Return-Path: <linux-fsdevel+bounces-10123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF09C8483EC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 06:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B462B213C6
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Feb 2024 05:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5C610A1C;
	Sat,  3 Feb 2024 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uxo97TB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A29110A09;
	Sat,  3 Feb 2024 05:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706937248; cv=none; b=t30Q4YJJx6b99ox3Ke0WJZrPxzYo9KJeIN8oEizac1pVU6jS4GtGcRFTZ1dCnEci3oKFlUijKLEIM6IVlZrubsgmm6hz++Z70boyaQ9s/lYiF5IxUrZr9R5m4a+8qwzqv7Y/7rTVzYvHFCJcFVAjj9O2Ha3c5ZP3GmuKJdbhMtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706937248; c=relaxed/simple;
	bh=v25sxvay8N5e2/0Wwh7sc0SdxRqWAPgUZnyU+HdR1PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEzOI1si00nrnwAcvwqENIDApmRkz18q49Py+KN39UHGqf7F1LrJT7+eXiRT3AK+ty4busA97J8C+AAnl9D8cg9y11qw8a7mCqkOl6/JJyNZXqQcpYoYdNGkO8zEacf0mhT/CciMAXs+2YolwmUy6Z25YmufENJorjf1L0RZwt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uxo97TB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D1CC433C7;
	Sat,  3 Feb 2024 05:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706937247;
	bh=v25sxvay8N5e2/0Wwh7sc0SdxRqWAPgUZnyU+HdR1PE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uxo97TB4tOt7X3Yk1UgLdnbvOvrzeWM3tu68rXKSOpcvkED8g9GQ995duk/A6H2tc
	 NCBVXsXDlwURcMA89UfEEwq/lAaxhjlvnvW9y1yOF9GePdk8Y4k7rXGwbtgpTE14+z
	 xaX3haOxI/48bPdPKDo1h2JSHFDncyJHajKTJD094l20F8fo3k094kIErDHD9LSZ2k
	 2sBvAwRtYJw1R9g/aESi6ILszrP6Qc+a8AIcUJOXFeobFsyoyOWUoQ4td/t9ZOQhyp
	 Ac0tJdTYJazT03uGnoNoex39SOY9riBigfiL/2u6jB0DxPN9TxPfugSPVhtFjKrD/A
	 DQaJ2WSlUTl1g==
Date: Sat, 3 Feb 2024 13:13:57 +0800
From: Gao Xiang <xiang@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: lsf-pc@lists.linux-foundation.org, Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [LSF/MM/BPF TOPIC] Large folios, swap and fscache
Message-ID: <Zb3Llc+dHxu4eggS@debian>
Mail-Followup-To: David Howells <dhowells@redhat.com>,
	lsf-pc@lists.linux-foundation.org,
	Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <2701740.1706864989@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2701740.1706864989@warthog.procyon.org.uk>

Hi David,

On Fri, Feb 02, 2024 at 09:09:49AM +0000, David Howells wrote:
> Hi,
> 
> The topic came up in a recent discussion about how to deal with large folios
> when it comes to swap as a swap device is normally considered a simple array
> of PAGE_SIZE-sized elements that can be indexed by a single integer.
> 
> With the advent of large folios, however, we might need to change this in
> order to be better able to swap out a compound page efficiently.  Swap
> fragmentation raises its head, as does the need to potentially save multiple
> indices per folio.  Does swap need to grow more filesystem features?
> 
> Further to this, we have at least two ways to cache data on disk/flash/etc. -
> swap and fscache - and both want to set aside disk space for their operation.
> Might it be possible to combine the two?
> 
> One thing I want to look at for fscache is the possibility of switching from a
> file-per-object-based approach to a tagged cache more akin to the way OpenAFS
> does things.  In OpenAFS, you have a whole bunch of small files, each
> containing a single block (e.g. 256K) of data, and an index that maps a
> particular {volume,file,version,block} to one of these files in the cache.
> 
> Now, I could also consider holding all the data blocks in a single file (or
> blockdev) - and this might work for swap.  For fscache, I do, however, need to
> have some sort of integrity across reboots that swap does not require.

If my understanding is correct, I think the old swapfile approach just
works with pinned local fs extents, which means it looks up extents in
advance and it doesn't expect these extents will be moved so the real
swap data I/O paths always work without fses involved.  I don't look
into the new SWP_FS_OPS/.swap_rw way and it seems only some network
fses use it but IMHO it might have some deadlock risk if swapout
triggers local fs block allocation.  But overall I think it's a good
idea to combine the two.

Just slight off the topic: Recently I had another rough thought. As
you said, even a single fscache block or called a single fscache chunk is like
256K or whatever.

Is it possible to implement an _optional_ partial cached data uptodate
like fscache chunk vs fsblock?  For example a bitmap can be attached to
each 256K or 1M chunk. That would be much helpful.

Thanks,
Gao Xiang

> 
> David
> 

