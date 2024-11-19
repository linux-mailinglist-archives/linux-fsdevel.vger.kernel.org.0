Return-Path: <linux-fsdevel+bounces-35242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317289D2E9B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 20:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE7F2819AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Nov 2024 19:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B81D0F68;
	Tue, 19 Nov 2024 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nWSITlMo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA361448DC;
	Tue, 19 Nov 2024 19:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732043540; cv=none; b=WN/wwGhJwpcMEWCs3SwDNH6jH56CTlvnuLILlSZ2bpsvLM7ft3ydblP6yF8cPoDPuiq2Tma9OhuONVuD4jBY9xyIItsZEDkEc7AUDdNV2MLwCr6GOcKRE2i6z+oTHD6AxFIl5TWt9kvZP4fVt9YtNiJ1K7K1coqMJGVcbe3m+GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732043540; c=relaxed/simple;
	bh=PqfdJbkclH3sWW7J2i8AKGm1cQ4UHORYFooL+J3Xwho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MZk9J7BBFtWeGMkIZ+pgrE3A9YSMxU2KqrH1FK4K726mwypgyTRkgYoiVZHIe5aDu56TwHshJNAFtD1CTmo2yucNuCFsQu6rYNLAz6HuChhlhm8l1RLq5vZMVL3SS8Zgu1yYDv7a8eksJCVwfybvL47b12yJ2Whz8Kj0YzP0134=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nWSITlMo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=pDGNE8Z2xlaZVgQg6nHGAmJ5/EaTAUvi8/lSgQCT6y4=; b=nWSITlMo3BGnELVf3RoWkT7Zl5
	zjhD9twZeACTfaBJBe/tU6HnQ4xnPa+jP1tJc5BE7lRstBkOD1+OhdE4iAZgsXIKZMqXe3V4mlXwE
	exrKVSYaOdlbsXwBOfE/rl/D9KL4jVt1ib7r0LxKod3oxk4FoJ80InhIrZhY5Krr3Kg/Mc7dagRah
	a72x/f9mcWfw9cV6ifQsekQ8yOl3CwtCICt0EnQGhE5rOoni+8ljyOwAVauF1vPjIXeipgJda/JH+
	8dqeq9rGIzxTIeRETLtCvQ+X0ah5MN5vHnrpzwLG2hx4UYLow8ES70j2tcr07KxYMCBXvarX3YsDR
	XGUDjNZg==;
Received: from [50.53.2.24] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tDTe2-00000004QbE-0XcM;
	Tue, 19 Nov 2024 19:12:15 +0000
Message-ID: <93ddc006-2b23-4f9a-b959-7ed418ca7c80@infradead.org>
Date: Tue, 19 Nov 2024 11:12:10 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fiemap: use kernel-doc includes in fiemap docbook
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
 Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
References: <20241119185507.102454-1-rdunlap@infradead.org>
 <ZzzhR3QXRBtNJwJb@casper.infradead.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <ZzzhR3QXRBtNJwJb@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/19/24 11:04 AM, Matthew Wilcox wrote:
> On Tue, Nov 19, 2024 at 10:55:07AM -0800, Randy Dunlap wrote:
>> Add some kernel-doc notation to structs in fiemap header files
>> then pull that into Documentation/filesystems/fiemap.rst
>> instead of duplicating the header file structs in fiemap.rst.
>> This helps to future-proof fiemap.rst against struct changes.
> 
> Thanks!  This is great.  Feels free to ignore every suggestion I'm about
> to make.
> 
>> +/**
>> + * struct fiemap_extent - description of one fiemap extent
>> + * @fe_logical: logical offset in bytes for the start of the extent
>> + *	from the beginning of the file
> 
>  * @fe_logical: Byte offset of extent in the file.
> 
>> + * @fe_physical: physical offset in bytes for the start of the extent
>> + *	from the beginning of the disk
> 
>  * @fe_physical: Byte offset of extent on disk.
> 
>> +/**
>> + * struct fiemap - file extent mappings
>> + * @fm_start: logical offset (inclusive) at
>> + *	which to start mapping (in)
> 
> Do we want to say "Byte offset"?
> 
>>  
>> +/* flags used in fm_flags: */
>>  #define FIEMAP_FLAG_SYNC	0x00000001 /* sync file data before map */
>>  #define FIEMAP_FLAG_XATTR	0x00000002 /* map extended attribute tree */
>>  #define FIEMAP_FLAG_CACHE	0x00000004 /* request caching of the extents */
>>  
>>  #define FIEMAP_FLAGS_COMPAT	(FIEMAP_FLAG_SYNC | FIEMAP_FLAG_XATTR)
> 
> Do we want to turn this into an enum so it can be kernel-doc?
> 
>> +/* flags used in fe_flags: */
>>  #define FIEMAP_EXTENT_LAST		0x00000001 /* Last extent in file. */
>>  #define FIEMAP_EXTENT_UNKNOWN		0x00000002 /* Data location unknown. */
>>  #define FIEMAP_EXTENT_DELALLOC		0x00000004 /* Location still pending.
> 
> Likewise

I did consider that. I can do it but it probably involves some fs testing
that I don't plan to get into.

-- 
~Randy


