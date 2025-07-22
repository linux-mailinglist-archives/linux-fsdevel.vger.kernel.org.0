Return-Path: <linux-fsdevel+bounces-55639-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 846BCB0D1A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965B63B4137
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 06:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9382B28D8F5;
	Tue, 22 Jul 2025 06:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="Rt+E8HhE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A7E4502F;
	Tue, 22 Jul 2025 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164355; cv=pass; b=KoyTRX9jzFT+HuaLgzIrSpEPUB0daIZDaHfAyaXYRWKF3tKh3Vx/lhcGv3xA0Hx8RzPloUw6Oadi2BbvbFLm1FCHraLknIpjP9vtyTPVsSHShLPdpI7wvaGL86E6tH060uHaPru6ol2kpe+mJvGN5LvMDoDZd1mrdVQK0VrwEDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164355; c=relaxed/simple;
	bh=KPfUr5wYd9zf13kzHJ8H0/ZlRGlccEKrGChJr7RLtrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=N0d6A51IjV6CCkCiu/M80ypU57OPxkJttqOIcJm+5XrZWJabCvadgfbQlnPUna2L6IUcsvhx2UGyZOwwiD0tpAHQApMao7uxof03MAgKjfJZn1zQFyMzuwMxiyiRZSXhG7NSO/iBLLCz2EeN1ruypAZg1kC8qUhgSrn1hDZVLFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=Rt+E8HhE; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753164321; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S1oweLJPFegpQ8Q9s6wiaHHEB+455a/vNxaDuWiCOL6lSXH8xXvez64SrZBLqsRjuTlK/Lpr9KVJIwDjbzXcDccu6TXDD4GUAOflS/7WXXsaQR38xli6xLhJUN70yR6K1OyNczVSJI3rqHYeltVLZ6prOOunEXmNmDij9fDhhio=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753164321; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VhCpAJRtyrpO9LNFpOQfttsLoSYxRVIjLuyWcDDI3VE=; 
	b=dFQMGr3VpKrLrMqdLtIVBV8C8J6gbBYxgYncsmElc/R7T8+Gya4MIQBl4ZmLhsKME3vEMcA45GD0xjbRe4+eqxywJGMpH0DHdyNModbjFtKQoAEX29GuMDE3b1PMFtZU8BJdPbPy7gkS7UmyDfIJjiKhsiI1A/ul0NWHrVHbSpk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753164321;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:References:Cc:Cc:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=VhCpAJRtyrpO9LNFpOQfttsLoSYxRVIjLuyWcDDI3VE=;
	b=Rt+E8HhENiewnbQ0DW+A2M0f12nScQFsjJNv8dFuRR0inIhXWZOrNKqF/GqQRTGU
	beoZMjzkcDNjHcf3q8qyjAFdFOodYUreIrk0uvctuH6S+Ff03FJxbDblYR8ngDvvlqh
	YtW+GJRMeZt1C/9zRHCyCVrRMLIp6Q36fN515qCE=
Received: by mx.zohomail.com with SMTPS id 1753164318402568.3670175945726;
	Mon, 21 Jul 2025 23:05:18 -0700 (PDT)
Message-ID: <91fc0c41-6d25-4f60-9de3-23d440fc8e00@collabora.com>
Date: Tue, 22 Jul 2025 11:05:11 +0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Excessive page cache occupies DMA32 memory
To: Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox
 <willy@infradead.org>, Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>
References: <766ef20e-7569-46f3-aa3c-b576e4bab4c6@collabora.com>
 <aH51JnZ8ZAqZ6N5w@casper.infradead.org>
 <2025072238-unplanted-movable-7dfb@gregkh>
Content-Language: en-US
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel@collabora.com,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2025072238-unplanted-movable-7dfb@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Adding ath/mhi and dma API developers to the discussion.

On 7/22/25 10:32 AM, Greg KH wrote:
> On Mon, Jul 21, 2025 at 06:13:10PM +0100, Matthew Wilcox wrote:
>> On Mon, Jul 21, 2025 at 08:03:12PM +0500, Muhammad Usama Anjum wrote:
>>> Hello,
>>>
>>> When 10-12GB our of total 16GB RAM is being used as page cache
>>> (active_file + inactive_file) at suspend time, the drivers fail to allocate
>>> dma memory at resume as dma memory is either occupied by the page cache or
>>> fragmented. Example:
>>>
>>> kworker/u33:5: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
>>
>> Just to be clear, this is not a page cache problem.  The driver is asking
>> us to do a 512kB allocation without doing I/O!  This is a ridiculous
>> request that should be expected to fail.
>>
>> The solution, whatever it may be, is not related to the page cache.
>> I reject your diagnosis.  Almost all of the page cache is clean and
>> could be dropped (as far as I can tell from the output below).
>>
>> Now, I'm not too familiar with how the page allocator chooses to fail
>> this request.  Maybe it should be trying harder to drop bits of the page
>> cache.  Maybe it should be doing some compaction. 
That's very thoughtful. I'll look at the page allocator why isn't it dropping
cache or doing compaction.

>> I am not inclined to
>> go digging on your behalf, because frankly I'm offended by the suggestion
>> that the page cache is at fault.
I apologize—that wasn't my intention.

>>
>> Perhaps somebody else will help you, or you can dig into this yourself.
> 
> I'm with Matthew, this really looks like a driver bug somehow.  If there
> is page cache memory that is "clean", the driver should be able to
> access it just fine if really required.
> 
> What exact driver(s) is having this problem?  What is the exact error,
> and on what lines of code?
The issue occurs on both ath11k and mhi drivers during resume, when
dma_alloc_coherent(GFP_KERNEL) fails and returns -ENOMEM. This failure has
been observed at multiple points in these drivers.

For example, in the mhi driver, the failure is triggered when the
MHI's st_worker gets scheduled-in at resume.

mhi_pm_st_worker()
-> mhi_fw_load_handler()
   -> mhi_load_image_bhi()
      -> mhi_alloc_bhi_buffer()
         -> dma_alloc_coherent(GFP_KERNEL) returns -ENOMEM


Thank you,
- Usama


