Return-Path: <linux-fsdevel+bounces-33612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F86B9BB909
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 16:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB07DB21A59
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Nov 2024 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AE91C07CC;
	Mon,  4 Nov 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b="ZWWgIc7N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511B51C07C1;
	Mon,  4 Nov 2024 15:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730734298; cv=none; b=fOIwqBebIXu3CQ9i4LjWrFXMMsFrot26wOSzNDfY27sf2jmS3WSyt1oeK3nUPsVQ7I07+hHw44jR+ArnkN3yqpk+53sSdm40H3K8nEZab8MAOVEt5cBNBJdRKA0w6DSyQCtJJEnNppS4nCT+Au27G2lK37eXnbefzPA9+U+Sbe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730734298; c=relaxed/simple;
	bh=KvWORfAAduulvHOi0GqFEH2kCQ/zjWYELxtQcI9MPq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DmV+JF/Bd8bCCHxcZVCstDOaoVW/1xgvtY61kQDvtcIHwT27MTkcfVPW8espKKf7AWwK+IlYViNVmUoHVWSTJtIAzCuEHUmREpOTAgfS9JezTrRGK3sz5lYQl5VpAtut4WPN/IloCG/ZxBF2MrwK2ljpiAD0u1CyAfInUQ5oeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net; spf=pass smtp.mailfrom=asahilina.net; dkim=pass (2048-bit key) header.d=asahilina.net header.i=@asahilina.net header.b=ZWWgIc7N; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asahilina.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asahilina.net
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: lina@asahilina.net)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 4BB8C43584;
	Mon,  4 Nov 2024 15:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
	s=default; t=1730734285;
	bh=KvWORfAAduulvHOi0GqFEH2kCQ/zjWYELxtQcI9MPq8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZWWgIc7NB3PXUSzkvEcsJ4jGgKT0AFCzpWryG2zkSBS7gQPM2u8jhB2YdGSGm6GnP
	 Q9F2klvCzvMU9a9qX6sLNEGmCD8FF8U3nAhRdSdP/LMlecZivQVE09F04jCrrZhWpy
	 v+k/a2m3s5vEHoNheVAPDjJ9snTkOJ71RmBRC1LMHnKA1oNu/1X5Q0y7SWhHNKwOL3
	 CbDehLERPeIpFcaIQxMYtVgUMVieRBHPioNWuS8Al/Sq/0bFGyUj+5g66kL46xPiwU
	 NR26KsoEST5ZfGLeq7uGFuWtrlPpYIVt8bD0lGtGHyGj9+4nc+fG63rbVwYCvQDGjS
	 sl2Y3wrS5nFmA==
Message-ID: <7f0c0a15-8847-4266-974e-c3567df1c25a@asahilina.net>
Date: Tue, 5 Nov 2024 00:31:22 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dax: Allow block size > PAGE_SIZE
To: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>,
 Matthew Wilcox <willy@infradead.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Sergio Lopez Pascual
 <slp@redhat.com>, linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20241101-dax-page-size-v1-1-eedbd0c6b08f@asahilina.net>
 <20241104105711.mqk4of6frmsllarn@quack3>
Content-Language: en-US
From: Asahi Lina <lina@asahilina.net>
In-Reply-To: <20241104105711.mqk4of6frmsllarn@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/24 7:57 PM, Jan Kara wrote:
> On Fri 01-11-24 21:22:31, Asahi Lina wrote:
>> For virtio-dax, the file/FS blocksize is irrelevant. FUSE always uses
>> large DAX blocks (2MiB), which will work with all host page sizes. Since
>> we are mapping files into the DAX window on the host, the underlying
>> block size of the filesystem and its block device (if any) are
>> meaningless.
>>
>> For real devices with DAX, the only requirement should be that the FS
>> block size is *at least* as large as PAGE_SIZE, to ensure that at least
>> whole pages can be mapped out of the device contiguously.
>>
>> Fixes warning when using virtio-dax on a 4K guest with a 16K host,
>> backed by tmpfs (which sets blksz == PAGE_SIZE on the host).
>>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
>>  fs/dax.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Well, I don't quite understand how just relaxing the check is enough. I
> guess it may work with virtiofs (I don't know enough about virtiofs to
> really tell either way) but for ordinary DAX filesystem it would be
> seriously wrong if DAX was used with blocksize > pagesize as multiple
> mapping entries could be pointing to the same PFN which is going to have
> weird results.

Isn't that generally possible by just mapping the same file multiple
times? Why would that be an issue?

Of course having a block size smaller than the page size is never going
to work because you would not be able to map single blocks out of files
directly. But I don't see why a larger block size would cause any
issues. You'd just use several pages to map a single filesystem block.
For example, if the block size is 16K and the page size is 4K, then a
single file block would be DAX mapped as four contiguous 4K pages in
both physical and virtual memory.

> If virtiofs can actually map 4k subpages out of 16k page on
> host (and generally perform 4k granular tracking etc.), it would seem more
> appropriate if virtiofs actually exposed the filesystem 4k block size instead
> of 16k blocksize? Or am I missing something?

virtiofs itself on the guest does 2MiB mappings into the SHM region, and
then the guest is free to map blocks out of those mappings. So as long
as the guest page size is less than 2MiB, it doesn't matter, since all
files will be aligned in physical memory to that block size. It behaves
as if the filesystem block size is 2MiB from the point of view of the
guest regardless of the actual block size. For example, if the host page
size is 16K, the guest will request a 2MiB mapping of a file, which the
VMM will satisfy by mmapping 128 16K pages from its page cache (at
arbitrary physical memory addresses) into guest "physical" memory as one
contiguous block. Then the guest will see the whole 2MiB mapping as
contiguous, even though it isn't in physical RAM, and it can use any
page granularity it wants (that is supported by the architecture) to map
it to a userland process.

> 
> 								Honza
> 
>> diff --git a/fs/dax.c b/fs/dax.c
>> index c62acd2812f8d4981aaba82acfeaf972f555362a..406fb75bdbe9d17a6e4bf3d4cb92683e90f05910 100644
>> --- a/fs/dax.c
>> +++ b/fs/dax.c
>> @@ -1032,7 +1032,7 @@ int dax_writeback_mapping_range(struct address_space *mapping,
>>  	int ret = 0;
>>  	unsigned int scanned = 0;
>>  
>> -	if (WARN_ON_ONCE(inode->i_blkbits != PAGE_SHIFT))
>> +	if (WARN_ON_ONCE(inode->i_blkbits < PAGE_SHIFT))
>>  		return -EIO;
>>  
>>  	if (mapping_empty(mapping) || wbc->sync_mode != WB_SYNC_ALL)
>>
>> ---
>> base-commit: 81983758430957d9a5cb3333fe324fd70cf63e7e
>> change-id: 20241101-dax-page-size-83a1073b4e1b
>>
>> Cheers,
>> ~~ Lina
>>

~~ Lina


