Return-Path: <linux-fsdevel+bounces-34664-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5CB9C78F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 17:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F8CB39C47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EB816087B;
	Wed, 13 Nov 2024 15:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="HR+BDDqC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254DD13D2B2;
	Wed, 13 Nov 2024 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511049; cv=none; b=o28S0lW1FmkaUR3gN/jYsmtXV4b6Z5oKBFoiqppJKt5uzdbeA00IqOVO3p2IqllgkvlboP8IHKD0HS7lEPDFQyBie+HyjciAVAN9z4WftxqWgOAQdhTBIIAKTDnfN9IXfY1OZRsDMJivVLR0xeO6AnSpX5SXcuUNZpH1ItgmYvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511049; c=relaxed/simple;
	bh=M6Ua2Z81wk5kvIT0yJ2Kgyf9SEEYpRhBz5BAJck28gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6wROccpWvHm1zOHhP1dBPjLEE+UKghZ7zwvfm9IqeRBFobUwFFkd4Iah260ZkanC2fbK9E7UpMu9z8v2zLtNNXS2CPJ3kfOI6l4ChT9aJnnjIY7cfW8Ammjv/Hlotg1kl7ElI0w6sDyPfBlh0VGB0Rwo9KmfmmFEYklJNp546o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=HR+BDDqC; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 5A1AF425C7;
	Wed, 13 Nov 2024 15:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1731511043;
	bh=M6Ua2Z81wk5kvIT0yJ2Kgyf9SEEYpRhBz5BAJck28gw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HR+BDDqC61hcMw5sIXsYzEPfppRFG9ctFYhatX1y/Iri6gVHlVhNknAoEuYvm/69h
	 YwmP4O/+VswwIknIFoZ+LzaEdZMlB0+To03RaX4Z34sxH/u7ej2H0q3ny90CwXgXWQ
	 lXMVbq6JOpnp6cDDlIYuMOdDvZ2LEqeg6JdWJgPOzmQ5KiWvjf3+w40Ger4AZL9/MD
	 pk2v8OneYiwQJZsZ2P2w2sHDpR4uEZsgH1rO0zbkEG31rjLgxG130diSsnZUpZkpV5
	 Or0nXZRCK3tkVYCfdgyeW2u4NSgFd/0p8qDdpMbPxrYs6EsDvUdz8hnYePScSKdqdp
	 u8oUvEFfjRMHQ==
Message-ID: <185be5a4-7bc7-41c1-bdfb-5384fd307a15@asahilina.net>
Date: Thu, 14 Nov 2024 00:17:21 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: dax: No-op writepages callback
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, Sergio Lopez Pascual <slp@redhat.com>,
 asahi@lists.linux.dev, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>
References: <20241113-dax-no-writeback-v1-1-ee2c3a8d9f84@asahilina.net>
 <CAJfpeguawgi_Hnn2BwieNntbOCB1ghyijEtUOh4QyOrPis--dw@mail.gmail.com>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <CAJfpeguawgi_Hnn2BwieNntbOCB1ghyijEtUOh4QyOrPis--dw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/24 7:48 PM, Miklos Szeredi wrote:
> On Tue, 12 Nov 2024 at 20:55, Asahi Lina <lina@asahilina.net> wrote:
>>
>> When using FUSE DAX with virtiofs, cache coherency is managed by the
>> host. Disk persistence is handled via fsync() and friends, which are
>> passed directly via the FUSE layer to the host. Therefore, there's no
>> need to do dax_writeback_mapping_range(). All that ends up doing is a
>> cache flush operation, which is not caught by KVM and doesn't do much,
>> since the host and guest are already cache-coherent.
> 
> The conclusion seems convincing.  But adding Vivek, who originally
> added this in commit 9483e7d5809a ("virtiofs: define dax address space
> operations").
> 
> What I'm not clearly seeing is how virtually aliased CPU caches
> interact with this.  In mm/filemap.c I see the flush_dcache_folio()
> calls which deal with the kernel mapping of a page being in a
> different cacheline as the user mapping.  How does that work in the
> virt environment?
> 

Oof, I forgot those architectures existed...

The only architecture that has both a KVM implementation and selects
ARCH_HAS_CPU_CACHE_ALIASING is mips. Is it possible that no MIPS
implementations with virtualization also have cache aliasing, and we can
just not care about this?

~~ Lina


