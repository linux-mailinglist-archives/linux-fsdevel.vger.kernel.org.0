Return-Path: <linux-fsdevel+bounces-71019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BDBCB095A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 17:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C914F30D5215
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF3C32824B;
	Tue,  9 Dec 2025 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="AAPu8M59"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78C43271F9;
	Tue,  9 Dec 2025 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765298052; cv=none; b=VxNAZWfNqCeuekv+ILXI1eMqhmOu0L/B1x18Tu4DSzLjaiXXRBsa0AD0UDDNbBBTU9CSvCLv2ko33hHLUFBEmKhhSggM+iEUsy1PXfYAq+Z1CQokvv3B2x8+ZQD+PDKKq47QSxewYJXc0xEznnICZG9+o2TKoaJ9K4EVyf2KxBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765298052; c=relaxed/simple;
	bh=IKImrdud3ISZXX4PDltZ9Nu85pmtH1q2qV3uh8ad2PY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iSDjZASKjKDuChNXy6MYbguPq+Or3TN0z/l1m0ZMjTOtYfuCqMgGynzxB4utjbErhmOIjWoeAL8zFkEEl/2ok4jLGdwxmDoL8Lm1F6+jLgZlKL5v7BTjSwBk0WJEYgTcodUa+neW6M99gZeGwNXHXoCccguNZujKr9IIQwGaozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=AAPu8M59; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dQkvF0Gq5z9v7T;
	Tue,  9 Dec 2025 17:34:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1765298041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n9/LnpcEgxl44nJ3KI8H+Y8yvy+C1IYBZbso1/35huI=;
	b=AAPu8M59AtZ4i6+FO0b3qagpHrfFsulku/cwvAn+/eSMjQD9lEjCmjVP0ZwsyAvh5TxAel
	OrE/Q5+4ckViAx+k8+FPTR+69Gn07nw23AsosKdJTsHAe6C5wjxxKsZMYBJK0wYgsYELo6
	YH7GbEf5dM5hxjhuLan7f1LRkyDUw+xqFRbvGULoaP1ShD27mTODqaixkSkhFGNh/PD+ff
	0d4S6kYPNnsOp+MmDG4W3DWOKbh8Tchg/Q+zWnaWeWyrt8oDQxxGuYK/0Dfw7yymoIwPE+
	BCZIeMkybZ90iPP6Nzlz3S+Nggi2NmInHCHs2MGB7oY81+/odna/5brbrbBi8w==
Message-ID: <3ced3736-81e8-4bc3-b5a3-50ac4af3536c@pankajraghav.com>
Date: Tue, 9 Dec 2025 22:03:40 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC v2 1/3] filemap: set max order to be min order if THP is
 disabled
To: Hannes Reinecke <hare@suse.de>, Pankaj Raghav <p.raghav@samsung.com>,
 Suren Baghdasaryan <surenb@google.com>, Mike Rapoport <rppt@kernel.org>,
 David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Michal Hocko <mhocko@suse.com>, Lance Yang <lance.yang@linux.dev>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 mcgrof@kernel.org, gost.dev@samsung.com, tytso@mit.edu
References: <20251206030858.1418814-1-p.raghav@samsung.com>
 <20251206030858.1418814-2-p.raghav@samsung.com>
 <d395cf62-2066-4965-87e6-823a7bbde775@suse.de>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <d395cf62-2066-4965-87e6-823a7bbde775@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/25 13:15, Hannes Reinecke wrote:
> On 12/6/25 04:08, Pankaj Raghav wrote:
>> Large folios in the page cache depend on the splitting infrastructure from
>> THP. To remove the dependency between large folios and
>> CONFIG_TRANSPARENT_HUGEPAGE, set the min order == max order if THP is
>> disabled. This will make sure the splitting code will not be required
>> when THP is disabled, therefore, removing the dependency between large
>> folios and THP.
>>
> The description is actually misleading.
> It's not that you remove the dependency from THP for large folios
> _in general_ (the CONFIG_THP is retained in this patch).
> Rather you remove the dependency for large folios _for the block layer_.
> And that should be make explicit in the description, otherwise the
> description and the patch doesn't match.
> 

Hmm, that is not what I am doing. This has nothing to do with the block layer directly.
I mentioned this in the cover letter but I can reiterate it again.

Large folios depended on THP infrastructure when it was introduced. When we added added LBS support
to the block layer, we introduced an indirect dependency on CONFIG_THP. When we disabled config_THP
and had a block device logical block size > page size, we ran into a panic.

That was fixed here[1].

If this patch is upstreamed, then we can disable THP but still have a LBS drive attached without any
issues.

Baolin added another CONFIG_THP block in ext4 [2]. With this support, we don't need to sprinkle THP
where file backed large folios are used.

Happy to discuss this in LPC (if you are attending)!


[1] https://lore.kernel.org/all/20250704092134.289491-1-p.raghav@samsung.com/
[2] https://lwn.net/ml/all/20251121090654.631996-25-libaokun@huaweicloud.com/


--
Pankaj

