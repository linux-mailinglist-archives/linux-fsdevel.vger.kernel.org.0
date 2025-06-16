Return-Path: <linux-fsdevel+bounces-51719-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A632ADAB5A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 11:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A003170FE8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 09:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587A627056D;
	Mon, 16 Jun 2025 09:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="OqlXNCcq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D553213B7AE;
	Mon, 16 Jun 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064441; cv=none; b=aHdoSqvUadbMSg+/Bpcd+vhn7Wbsh7be1bgdNUQjzJXc8hSqIhhQ4ViBPEktLQBL1q4l1zDZzCU3E2KjOUq7jj44TbiY8PbUmb/r65lmX9zIL99OuyPs5B07LMepUj+c05AoSxMM81UXSSe7qrIiFu9+esHh+6CiGairbBJzyrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064441; c=relaxed/simple;
	bh=Twhxm9i9eQ6EcYvXRHiKqWBNcMUl5h9BDTHkxOKskFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APBcjoNqUFt9Og0AX6SpyGd3If+U+4YWyCQrANOaizDt86ogcTHhKtX+08r44DkVab0iNA1K0VeEL2tKu3WryHzWEXHVDWEEpQ3ZOmCSWhh7UjTV2zXMw3YB8Eohl59/w7QJ1TYeS82FXtbjafyhukAhMhlF9XjX8fBeeGSPM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=OqlXNCcq; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bLP9B2tMfz9t8h;
	Mon, 16 Jun 2025 11:00:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1750064430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sw2JUl1JyK0AiB+kHg6y3aGB9TupL2wuBZlKDT9xIUM=;
	b=OqlXNCcq5xwQy/VyRXIHl3E2kCchNOQE7Dcl6aMs2EakarUOioTLwx8VFqjfOqz7kgfEZ7
	GuZvoL9nRscZG80pgL1sgWi95/LI+DlmGUUmQojySyi+LJaKo9VkbXCzmi1ZhAClUReZor
	tQVowIrwk81n99mpgOz7CZkobuQTUSEdP5LPGs2dHuTerloJEKwEGek2t6UNW1FIs76TXw
	ic4jejg2YfKwqNPryd3k6RH/pAZgDL9Uk7fTtFeUNZCmnV0K/bHej1AynSaRw5eJHYLTK8
	FSZeL3FwRTkoabpCfXFZDzspd79fdfGDquAtihhCE4QzgrVRoaUSEXlzWtcL7g==
Message-ID: <9de7fbb6-63de-40eb-b2c0-cbf9fb084bee@pankajraghav.com>
Date: Mon, 16 Jun 2025 11:00:19 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/5] add STATIC_PMD_ZERO_PAGE config option
To: Christoph Hellwig <hch@lst.de>, Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
 Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>, Borislav Petkov <bp@alien8.de>,
 Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>,
 Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, willy@infradead.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com
References: <20250612105100.59144-1-p.raghav@samsung.com>
 <20250616054034.GA1559@lst.de>
Content-Language: en-US
From: Pankaj Raghav <kernel@pankajraghav.com>
In-Reply-To: <20250616054034.GA1559@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4bLP9B2tMfz9t8h


On 6/16/25 07:40, Christoph Hellwig wrote:
> Just curious: why doesn't this series get rid of the iomap zero_page,
> which would be really low hanging fruit?
> 

I did the conversion in my first RFC series [1]. But the implementation and API for the zero
page was still under heavy discussion. So I decided to focus on that instead and leave the
conversion for later as I mentioned in the cover letter. I included blkdev_issue_zero_pages() as it
is a more straight forward conversion.

--
Pankaj


[1] https://lore.kernel.org/linux-mm/20250516101054.676046-4-p.raghav@samsung.com/

