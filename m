Return-Path: <linux-fsdevel+bounces-35565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D829D9D5E10
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 12:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F221F22431
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2024 11:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295F91DE3DF;
	Fri, 22 Nov 2024 11:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="AyOtV3CT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AEC10A3E;
	Fri, 22 Nov 2024 11:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275081; cv=none; b=GdO/qmmdn0pqoyDMcJjyzb1IvsXVNyE49bfbzFr1nLQfw/sBWBr70nwCyjdQPwUkBqVAzreSNj+u1ux10A/PGaVQiNzv/S0pUyrqV79NJbPLBdj/pwjeFssH9guPKXx5wiWX1XPYGF1EbY1NjoNoEhXn0b4i2Fy7ynqprpMMDtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275081; c=relaxed/simple;
	bh=y0hhf2LTWZz9j36e7RyKaFdzM1AasEDPdlCXTLDDnus=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=M+r0883OL+IfSQLn4vdi0jXgT8tPWxw0R/zO8h5ujuZ2/NZiuhvHbO6UDw7XEOQ+jbKO+evX6wPk0wLjJIyhcgEsng9emZ6+QWe+B1G3w5j8cbSnpAC4qrYYf0hZsyRZNeVvn/juOBqu9OgauzsyWTPiIlmEjA6Wxe8Kr8tging=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=AyOtV3CT; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 628E243637;
	Fri, 22 Nov 2024 11:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1732275068;
	bh=y0hhf2LTWZz9j36e7RyKaFdzM1AasEDPdlCXTLDDnus=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=AyOtV3CTbTB99lDa4R3qMM1iCM3Me0becYoN72kESrfuAoXrAniJee0IaptcGn3FQ
	 Q/9mYsJ5z2Kle3VHYPa7LpZ64KKP9kfZYm9Jl2z79OG1wiw1zhbqhLBxPj0DBI+CRl
	 bIQmxUj1iLAZ45unVPAsdOyuU3gqbmYqMYtvz5a5FHpySExVFC/V3Rj4oJR6nm36d6
	 ZDUlCv8TDjycY9nIrqcM2vifoaD5qYbBfyQ7B+FX2mnbLcjiMYDHJm5dFJFQuyPQ15
	 Gsx5mtqi0uTgOARawGua3LDxC7qqRGRbfw0O07IQ/Ki5ahNFZK9etd+gT9eKUrUfwT
	 RbccsimhNFL4g==
Message-ID: <d41be32e-4d17-40b2-9dc1-950cdfe32556@asahilina.net>
Date: Fri, 22 Nov 2024 20:31:06 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: dax: No-op writepages callback
From: Asahi Lina <lina@asahilina.net>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Sergio Lopez Pascual <slp@redhat.com>,
 asahi@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>,
 linux-mips@vger.kernel.org
References: <20241113-dax-no-writeback-v1-1-ee2c3a8d9f84@asahilina.net>
 <CAJfpeguawgi_Hnn2BwieNntbOCB1ghyijEtUOh4QyOrPis--dw@mail.gmail.com>
 <185be5a4-7bc7-41c1-bdfb-5384fd307a15@asahilina.net>
Content-Language: en-US
In-Reply-To: <185be5a4-7bc7-41c1-bdfb-5384fd307a15@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/24 12:17 AM, Asahi Lina wrote:
> 
> 
> On 11/13/24 7:48 PM, Miklos Szeredi wrote:
>> On Tue, 12 Nov 2024 at 20:55, Asahi Lina <lina@asahilina.net> wrote:
>>>
>>> When using FUSE DAX with virtiofs, cache coherency is managed by the
>>> host. Disk persistence is handled via fsync() and friends, which are
>>> passed directly via the FUSE layer to the host. Therefore, there's no
>>> need to do dax_writeback_mapping_range(). All that ends up doing is a
>>> cache flush operation, which is not caught by KVM and doesn't do much,
>>> since the host and guest are already cache-coherent.
>>
>> The conclusion seems convincing.  But adding Vivek, who originally
>> added this in commit 9483e7d5809a ("virtiofs: define dax address space
>> operations").
>>
>> What I'm not clearly seeing is how virtually aliased CPU caches
>> interact with this.  In mm/filemap.c I see the flush_dcache_folio()
>> calls which deal with the kernel mapping of a page being in a
>> different cacheline as the user mapping.  How does that work in the
>> virt environment?
>>
> 
> Oof, I forgot those architectures existed...
> 
> The only architecture that has both a KVM implementation and selects
> ARCH_HAS_CPU_CACHE_ALIASING is mips. Is it possible that no MIPS
> implementations with virtualization also have cache aliasing, and we can
> just not care about this?

I think this either isn't a problem, or it's already broken anyway. The
way Linux deals with cache aliasing for mmap is by using page coloring,
which forces mmap virtual addresses to keep a fixed color relationship
to avoid aliasing at the userspace map. Since virtiofs uses aligned 2MiB
blocks (larger than any L1 dcache size), *as long as* the SHM window is
suitably aligned by the host VMM it should map without aliasing in
guest-physical space (if it isn't aligned the mmap will fail in the host
anyway). Making sure the alignment is sufficient would be the
responsibility of the host VMM (qemu/libkrun/whatever). That ensures
coherency between host userspace and guest kernel mappings (there is no
coherency with host kernel mappings since the direct map addresses won't
be colored properly, but that is what the flush_dcache_folio() stuff in
the host kernel takes care of).

As long as the cache info is passed to the guest properly, the guest
should in turn do the right alignment for mmap. That makes userspace on
the guest and userspace on the host coherent.

Put another way: If this doesn't work without flushing it's already
broken. The architecture to deal with dcache aliasing in Linux assumes
all userspace mappings are coherent, and the kernel only needs to deal
with coherency between its own direct-map view and userspace mappings.
If it's a DAX mapping and arbitrary processes *outside* the guest can
have maps of the page and mutate them under the guest kernel, if it's
not coherent, it's already broken. There's no possible codepath for the
guest kernel to request flushing the dcache for userspace processes on
the host. Indeed, since it's supposed to be coherent and userspace
reads/writes on host and guest (or other guests) cannot be controlled to
introduce cache maintenance, no cache-flushing solution can work at all.

CCing linux-mips in case they know more.

~~ Lina


