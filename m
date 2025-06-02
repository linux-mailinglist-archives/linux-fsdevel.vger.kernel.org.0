Return-Path: <linux-fsdevel+bounces-50368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD18ACB8EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 17:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F464941E1C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Jun 2025 15:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB67220F41;
	Mon,  2 Jun 2025 15:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="JYHa/G6Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52912523A;
	Mon,  2 Jun 2025 15:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748878490; cv=none; b=Vn0IByxeEnc4K5sdfLpaoXequbmvzyfrMSf9U2XeD7e7asH8rF3Ffs7KJr4Rr4gxLB5LbRRQf8TXHTIQE7rQ7MnmEMIiNATI1JlmbggIVDqisAyPeqvJk6VRV9xzy171dGeYQGneYtlmElkTtbVANZmRAPW8341GNzn3Y39JAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748878490; c=relaxed/simple;
	bh=rxSgjePRrDqocTR5PEa49E0emUGdPLDuFJFOaU0vyCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q6SzKM84FVu6bYCSdo5mNV5wLE333vdzhNtDAWDXGwjWWE26eZvL92T99ci0AbwKKeSD/UjEsN7YFnL5o1UE5BnsYXC6Tgr8rZR0yl3divld0MAQrFKobmNNwyRdsH36DNPJ0JC7OryVUlm/YxNkXduPkvmDX+rOSCbRfAnz6WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=JYHa/G6Z; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b9yZP6Tt5z9spq;
	Mon,  2 Jun 2025 17:34:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1748878477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RSWKa5jRWKpvNy5AYCWfE+HSpjMQwSPIzI/OGLplaVE=;
	b=JYHa/G6ZeQB0yAIfVULn7KaHNi4u8pvPNXSitQ8sgxqIlk+aajfX3BD9W0hQ+kbsx9N+9W
	4+YpGSR1x/9Gh9Fl4RfwNNQ4F7DMRNJrQ257cm5pEKfOP75SlHLUx0rz4jX2wokT972Hue
	g/QuoCL9k1F1+UyaQbPWltOLes749bUQfmviBmHvr18Kj9mKw1JygJQklQr7s8ja9pvnm1
	I/+nRbIjRkCvi6lKJE/Gow/dROVAa1ZqEi/Hc6vgRPJA8MqqiPwY82gJeMLdhQoXKpiyvC
	ypkNLWhdS2u6RYhoqxkjev30NqlJyBmCOU/r87fIZlVKDRmSrJCbbi/cmjMS1A==
Message-ID: <2acfe69f-f542-4f74-b671-d5a952d5b205@pankajraghav.com>
Date: Mon, 2 Jun 2025 17:34:27 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC 3/3] block: use mm_huge_zero_folio in
 __blkdev_issue_zero_pages()
To: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Vlastimil Babka <vbabka@suse.cz>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
 Dev Jain <dev.jain@arm.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-block@vger.kernel.org, willy@infradead.org,
 x86@kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com
References: <20250527050452.817674-1-p.raghav@samsung.com>
 <20250527050452.817674-4-p.raghav@samsung.com>
 <20250602050514.GD21716@lst.de>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20250602050514.GD21716@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4b9yZP6Tt5z9spq

On 6/2/25 07:05, Christoph Hellwig wrote:
> On Tue, May 27, 2025 at 07:04:52AM +0200, Pankaj Raghav wrote:
>> Noticed a 4% increase in performance on a commercial NVMe SSD which does
>> not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
>> gains might be bigger if the device supports bigger MDTS.
> 
> Impressive gain on the one hand - on the other hand what is the macro
> workload that does a lot of zeroing on an SSD, because avoiding that
> should yield even better result while reducing wear..
> 

Absolutely. I think it is better to use either WRITE_ZEROES or DISCARD. But I wanted
to have some measurable workload to show the benefits of using a huge page to zero out.

Interestingly, I have seen many client SSDs not implementing WRITE_ZEROES.

>> +			unsigned int len, added = 0;
>>  
>> +			len = min_t(sector_t, folio_size(zero_folio),
>> +				    nr_sects << SECTOR_SHIFT);
>> +			if (bio_add_folio(bio, zero_folio, len, 0))
>> +				added = len;
>>  			if (added < len)
>>  				break;
>>  			nr_sects -= added >> SECTOR_SHIFT;
> 
> Unless I'm missing something the added variable can go away now, and
> the code using it can simply use len.
> 

Yes. This should do it.

if (!bio_add_folio(bio, zero_folio, len, 0))
    break;

nr_sects -= len >> SECTOR_SHIFT;

--
Pankaj

