Return-Path: <linux-fsdevel+bounces-59413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF96FB388DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 19:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E6C5E87CF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C692D1911;
	Wed, 27 Aug 2025 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jeMmBzT4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54808277C81
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756316851; cv=none; b=Sbgfx/soY5lITIxZIam/piec86wOAsq/qC4BwtjKnjRzbujEtLkkenjSiLKHP/OI2NQ9dzwrxxY7QWC8tZzaswRrbjLoNpm9e1nScA3Dq8xzVyzr5wwWx32pAqCePwoYRKykYovsNWsTpQnvLNEgCs6IG0s55syuiMedO/uGUFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756316851; c=relaxed/simple;
	bh=zS8QfwcVGiIh/gSTg9vPNlTZo2dEjFfiS5I4ZtZOseE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JWndqaK0DeVMGCPgjbYp6hRuPu3DjKT0tEMGdXxIHCnyO95tSToZOQfRqds9ZM/gS1iO3E3Rc/v6+oIjDe2ZrGUXuVZdsvWRP1xhZ3eKw5s3bTHthnwR0rBiAxSnJ9WbAI0BgF/GnrnKVzeu1tMmT/+me+Z1HCZlIVMU7uAzo0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jeMmBzT4; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 27 Aug 2025 10:47:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756316837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ghKfMv5DKOHTE1nvgoIuZHQcli20D7t7I3sG72L8nws=;
	b=jeMmBzT4+Wigtv96A79lYlDKdFkNn8Afum0r3lTu22SX+mmpmfCSZQ3p+4K/Gk9QNxBZj5
	atO/rI/jHoIUCdhPlv4hc3UY3iWvfzuY9VoDN/Qs9JeuSirjMDUBZyhCCBEjmgwfBEdaIK
	EYN0n+T9r58pjyI8koEcmycY8pTrEbs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Boris Burkov <boris@bur.io>, akpm@linux-foundation.org
Cc: akpm@linux-foundation.org, linux-btrfs@vger.kernel.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, kernel-team@fb.com, wqu@suse.com, 
	willy@infradead.org, mhocko@kernel.org, muchun.song@linux.dev, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v4 0/3] introduce kernel file mapped folios
Message-ID: <vo3wqueeianddd7kk2sbhv6bxwkbwhzqaem5v2obxotycqrmug@7rehz4g4igwn>
References: <cover.1755812945.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1755812945.git.boris@bur.io>
X-Migadu-Flow: FLOW_OUT

Hi Andrew, can you please pick this series up (replacing the "introduce
uncharged file mapped folios" series)? I think it is ready for wider
testing.

thanks,
Shakeel


On Thu, Aug 21, 2025 at 02:55:34PM -0700, Boris Burkov wrote:
> I would like to revisit Qu's proposal to not charge btrfs extent_buffer
> allocations to the user's cgroup.
> 
> https://lore.kernel.org/linux-mm/b5fef5372ae454a7b6da4f2f75c427aeab6a07d6.1727498749.git.wqu@suse.com/
> 
> I believe it is detrimental to account these global pages to the cgroup
> using them, basically at random. A bit more justification and explanation
> in the patches themselves.
> 
> ---
> Changelog:
> v4:
> - change the concept from "uncharged" to "kernel_file"
> - no longer violates the invariant that each mapped folio has a memcg
>   when CONFIG_MEMCG=y
> - no longer really tied to memcg conceptually, so simplify build/helpers
> v3:
> - use mod_node_page_state since we will never count cgroup stats
> - include Shakeel's patch that removes a WARNING triggered by this series
> v2:
> - switch from filemap_add_folio_nocharge() to AS_UNCHARGED on the
>   address_space.
> - fix an interrupt safety bug in the vmstat patch.
> - fix some foolish build errors for CONFIG_MEMCG=n
> 
> 
> 
> Boris Burkov (3):
>   mm/filemap: add AS_KERNEL_FILE
>   mm: add vmstat for kernel_file pages
>   btrfs: set AS_KERNEL_FILE on the btree_inode
> 
>  fs/btrfs/disk-io.c      |  1 +
>  include/linux/mmzone.h  |  1 +
>  include/linux/pagemap.h |  2 ++
>  mm/filemap.c            | 13 +++++++++++++
>  mm/vmstat.c             |  1 +
>  5 files changed, 18 insertions(+)
> 
> -- 
> 2.50.1
> 

