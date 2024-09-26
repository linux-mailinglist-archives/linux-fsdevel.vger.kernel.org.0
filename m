Return-Path: <linux-fsdevel+bounces-30144-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F5A986F0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 10:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13781F25CB2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Sep 2024 08:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3303B1C6A3;
	Thu, 26 Sep 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="hrHH6bZn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B538318C336
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Sep 2024 08:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727339929; cv=none; b=tlTwNFSUEBD8tFFnO27nKgx43Ja8/FGqcZABX2PF6YvINrt/JcPjnsKzH6CN5b61vmM6oGclygckcele5tU6yJVn3hrOo8R2iD7OfBoYdUHevWPhpJeI8mP0gCmtXHYKfFFdj43S3WPQzypiS6krKpjXc9Lw7Ghi6uuHOW1Nma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727339929; c=relaxed/simple;
	bh=4yRNZPSp6RtSXiwFpjyyViCm/zXfQdY0VfTiBe1cO8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rplE9fE45DxuIxXmfENBVmQ6dJcw0igUXJ88i4rBoIjwcJZmrMtkqgtxv9sURqyKwWGDVBlp1cfJvFh0bMmZ3AfoGVRb5k1farcHUmBLIaWctcD9fYUUqsB0DHgD3ZncKx+zPEA52zBjM8PnZq64o7ilvXP9zSJ7FreNAlU2Rz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=hrHH6bZn; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4XDn7L52fXz9vQl;
	Thu, 26 Sep 2024 10:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1727339918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TB5UJEtCsm4P4G++Jl8aN3PaUQKcMcrma/AP9vjcE68=;
	b=hrHH6bZn0W+C/K+0vaSjpaGIrNJP6owsJIFnk3KdZ+Xa03lO/hX2HhaXTOF2uopzegA9G0
	XAGcv4kbY0dAPJXEp6Xu9rzt7ub78J6U+Tx679BUugcVEFBTUWVjQOxwlWrLSxnTc+6+dX
	kOHLx+5+oXln8pR+sQLsnmofsGY18ruLylp+/pM7GJduP4u5Q9ugi43d6U2j05JscON3UH
	R0SKpSxbYh7245uZqZBB19elFTAnJu2cAQyBl25ttSJc2ZaW3O8wtQYVZCy128HnfVW61S
	e/Eix+qqE/0p5sCgWHdBIDvxHolE9MJjujmHc5k3/IP8h/EsCKsdDLUCsnXcpA==
Date: Thu, 26 Sep 2024 10:38:34 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Anna Schumaker <Anna.Schumaker@netapp.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>
Subject: Re: Re: [PATCH v2] tmpfs: fault in smaller chunks if large folio
 allocation not allowed
Message-ID: <nhnpbkyxbbvjl2wg77x2f7gx3b3wj7jujfkucc33tih3d4jnpx@5dg757r4go64>
References: <20240914140613.2334139-1-wangkefeng.wang@huawei.com>
 <20240920143654.1008756-1-wangkefeng.wang@huawei.com>
 <Zu9mbBHzI-MyRoHa@casper.infradead.org>
 <1d4f98aa-f57d-4801-8510-5c44e027c4e4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d4f98aa-f57d-4801-8510-5c44e027c4e4@huawei.com>

On Mon, Sep 23, 2024 at 09:39:07AM +0800, Kefeng Wang wrote:
> 
> 
> On 2024/9/22 8:35, Matthew Wilcox wrote:
> > On Fri, Sep 20, 2024 at 10:36:54PM +0800, Kefeng Wang wrote:
> > > The tmpfs supports large folio, but there is some configurable options
> > > to enable/disable large folio allocation, and for huge=within_size,
> > > large folio only allowabled if it fully within i_size, so there is
> > > performance issue when perform write without large folio, the issue is
> > > similar to commit 4e527d5841e2 ("iomap: fault in smaller chunks for
> > > non-large folio mappings").
> > 
> > No.  What's wrong with my earlier suggestion?
> > 
> 
> The tempfs has mount options(never/always/within_size/madvise) for large
> folio, also has sysfs file /sys/kernel/mm/transparent_hugepage/shmem_enabled
> to deny/force large folio at runtime, as replied in v1, I think it
> breaks the rules of mapping_set_folio_order_range(),
> 
>   "Do not tune it based on, eg, i_size."
>   --- for tmpfs, it does choose large folio or not based on the i_size
> 
>   "Context: This should not be called while the inode is active as it is
> non-atomic."
>   --- during perform write, the inode is active
> 
> So this is why I don't use mapping_set_folio_order_range() here, but
> correct me if I am wrong.

Yeah, the inode is active here as the max folio size is decided based on
the write size, so probably mapping_set_folio_order_range() will not be
a safe option.

