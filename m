Return-Path: <linux-fsdevel+bounces-58065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5B0B28960
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 02:42:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5F317E32D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Aug 2025 00:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811722BB13;
	Sat, 16 Aug 2025 00:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JdKaLCor"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7477FC133
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Aug 2025 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755304919; cv=none; b=AZ/6yVqLpDZ5juV6ViU5og6o8JJsnXBQTxEJyyxjEWNTheDu/V0HjUCy8gsuiJoMxdbJXUgENqSP1mkgunUsMAtQ6HGdmxL3IzjqhnIubmEJd1OtD8lIMDQehmUA3HrT4xj0J8GfHwVu5VtDjqhxlmthqILhe5sCnq51lWsOELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755304919; c=relaxed/simple;
	bh=164dp+hH466rh/+Bn0ORvCdXvyTX9ZNsS8/ddMIsi0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aa8BSuQYvRdxlRoaTxqBxsNysdoGxxQuihhL57DBRpK43XOraxsnyRk9chhze1AKdvcd4oJI/659ZtQigrIsL5lMlAn/I558JF7T0ORoamR/OZoB/M4cjGGrgY2uH+BGP1VK+rthHd6G3IBUy5BmpzZtkzpcrnpfsGhvm7TYRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JdKaLCor; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 15 Aug 2025 17:41:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755304905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ojKgaeOJIavwY5MGBDiYWe4zl4Eo5ALmEoHlqz63x2E=;
	b=JdKaLCorLvM5TlpNcBpEwEodyIeca3CAyVoSJE/vYjtxN+yP2HQK5KYd6NtD+8t1d5CgRa
	bRaeHAoiR7oN/VNxLjFUmVBflP6D+JBIuBpQreljuLdaeiaGI7Q8n9F2y3QN87nUyvdNxI
	wB1SyGP4BFsYJbp3W1+lcpZBb5Q0CAY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kernel-team@fb.com, wqu@suse.com, willy@infradead.org
Subject: Re: [PATCH v2 1/3] mm/filemap: add AS_UNCHARGED
Message-ID: <363p6uyyrx5gruugrlq5kjxwz5gmw762s3nnem5nydkflwbhxy@jpnk4gxbpquj>
References: <cover.1755300815.git.boris@bur.io>
 <38448707b0dfb7fabae28cbebba3481eec6f2f4e.1755300815.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38448707b0dfb7fabae28cbebba3481eec6f2f4e.1755300815.git.boris@bur.io>
X-Migadu-Flow: FLOW_OUT

On Fri, Aug 15, 2025 at 04:40:31PM -0700, Boris Burkov wrote:
> Btrfs currently tracks its metadata pages in the page cache, using a
> fake inode (fs_info->btree_inode) with offsets corresponding to where
> the metadata is stored in the filesystem's full logical address space.
> 
> A consequence of this is that when btrfs uses filemap_add_folio(), this
> usage is charged to the cgroup of whichever task happens to be running
> at the time. These folios don't belong to any particular user cgroup, so
> I don't think it makes much sense for them to be charged in that way.
> Some negative consequences as a result:
> - A task can be holding some important btrfs locks, then need to lookup
>   some metadata and go into reclaim, extending the duration it holds
>   that lock for, and unfairly pushing its own reclaim pain onto other
>   cgroups.
> - If that cgroup goes into reclaim, it might reclaim these folios a
>   different non-reclaiming cgroup might need soon. This is naturally
>   offset by LRU reclaim, but still.
> 
> A very similar proposal to use the root cgroup was previously made by
> Qu, where he eventually proposed the idea of setting it per
> address_space. This makes good sense for the btrfs use case, as the
> uncharged behavior should apply to all use of the address_space, not
> select allocations. I.e., if someone adds another filemap_add_folio()
> call using btrfs's btree_inode, we would almost certainly want the
> uncharged behavior.
> 
> Link: https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
> Suggested-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: Boris Burkov <boris@bur.io>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

