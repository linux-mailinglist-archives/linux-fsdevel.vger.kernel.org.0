Return-Path: <linux-fsdevel+bounces-10851-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE2684EB30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3737B286E5A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06734F894;
	Thu,  8 Feb 2024 22:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="XSCnIsVi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F54F5EA;
	Thu,  8 Feb 2024 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707430032; cv=none; b=hEAdrRDA4SaadUpFVRqU4DDVgbvgxA4pm3g9TNd9t05Wdx65Fm3WV+Tjc38HWAjJunwEG10xYUodmleUrhc2dJjvXD33Mxw5nLzZ8WJHmqwUvO1rrXL84UnDnPbhmydsd+wZw7VBk4oDcsQiusW3+o9pFKAGfkVxCudkrjoqgkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707430032; c=relaxed/simple;
	bh=92zdymWBorEcREsjLvytVG2j1+C/vMQZspD2t9Fgjek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uYuA3pnHtoAztCT2V6bjnhk2eeCuPfbZoGkol7jw3MET/0fEHLvcFXahpD/ihA5Qse8A54n9vbv1jOBsNa1RALCmmakh835eLespf6HVYLZUjKsegZbKuT8R4sNkkpqiCMK7p1Jzezwkx6oSXg7SEoK/esCqGtxqNLOLuHFpqxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=XSCnIsVi; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707430029;
	bh=92zdymWBorEcREsjLvytVG2j1+C/vMQZspD2t9Fgjek=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XSCnIsViF75EWel0lnYbPeaM//N+aw2inHEoC0Gvjx+GA2rcjy1oIRP4XYCUGzWFC
	 +Wfoz/nrUqlXI5gpo4mbukfNJ7C1NZMmt4vVtSlOQ1/5bNmwsHmDuMaKHFF0LCCloU
	 oGxSETGFpggEmINJcnxVxV8tv6KcbXa6RsWUsr22BAvXZASnBA+2fHxz2lu392ilc0
	 cwLFqsYtT/E5g7HHZ0+VCgDDH5SgevkM1WIjiPNeikO/GsbYH0Hr053lTs+Xs8aQQK
	 Oze/+mF0fwhHTJcab6rQ4x9Tt56F2q9G0H+uVqMGLQGIVgNb3G2I4tkNRVTdqblEao
	 WSJHJVjET15dw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TWB0s1w3hzXtJ;
	Thu,  8 Feb 2024 17:07:09 -0500 (EST)
Message-ID: <0159001c-6d4a-4aab-a46a-d160673c21e4@efficios.com>
Date: Thu, 8 Feb 2024 17:07:15 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] nvdimm/pmem: Treat alloc_dax() -EOPNOTSUPP
 failure as non-fatal
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-3-mathieu.desnoyers@efficios.com>
 <65c5487174fbd_afa4294e7@dwillia2-xfh.jf.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65c5487174fbd_afa4294e7@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-08 16:32, Dan Williams wrote:
> Mathieu Desnoyers wrote:
>> In preparation for checking whether the architecture has data cache
>> aliasing within alloc_dax(), modify the error handling of nvdimm/pmem
>> pmem_attach_disk() to treat alloc_dax() -EOPNOTSUPP failure as non-fatal.
>>
>> For the transition, consider that alloc_dax() returning NULL is the
>> same as returning -EOPNOTSUPP.
>>
>> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Alasdair Kergon <agk@redhat.com>
>> Cc: Mike Snitzer <snitzer@kernel.org>
>> Cc: Mikulas Patocka <mpatocka@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-cxl@vger.kernel.org
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-xfs@vger.kernel.org
>> Cc: dm-devel@lists.linux.dev
>> Cc: nvdimm@lists.linux.dev
>> ---
>>   drivers/nvdimm/pmem.c | 26 ++++++++++++++------------
>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
>> index 9fe358090720..f1d9f5c6dbac 100644
>> --- a/drivers/nvdimm/pmem.c
>> +++ b/drivers/nvdimm/pmem.c
>> @@ -558,19 +558,21 @@ static int pmem_attach_disk(struct device *dev,
>>   	disk->bb = &pmem->bb;
>>   
>>   	dax_dev = alloc_dax(pmem, &pmem_dax_ops);
>> -	if (IS_ERR(dax_dev)) {
>> -		rc = PTR_ERR(dax_dev);
>> -		goto out;
>> +	if (IS_ERR_OR_NULL(dax_dev)) {
> 
> alloc_dax() should never return NULL. I.e. the lead in before this patch
> should fix this misunderstanding:
> 
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index b463502b16e1..df2d52b8a245 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -86,11 +86,7 @@ static inline void *dax_holder(struct dax_device *dax_dev)
>   static inline struct dax_device *alloc_dax(void *private,
>                  const struct dax_operations *ops)
>   {
> -       /*
> -        * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
> -        * NULL is an error or expected.
> -        */
> -       return NULL;
> +       return ERR_PTR(-EOPNOTSUPP);
>   }
>   static inline void put_dax(struct dax_device *dax_dev)
>   {
> 
>> +		rc = IS_ERR(dax_dev) ? PTR_ERR(dax_dev) : -EOPNOTSUPP;
> 
> Then this ternary can be replaced with just a check of which PTR_ERR()
> value is being returned.

As you noted, I've introduced this as cleanups in later patches. I don't
mind folding these into their respective per-driver commits and moving
the alloc_dax() hunk earlier in the series.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


