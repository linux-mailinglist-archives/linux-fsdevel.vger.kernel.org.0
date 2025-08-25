Return-Path: <linux-fsdevel+bounces-58958-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F73DB336B7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 08:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E8B018957BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6868628688C;
	Mon, 25 Aug 2025 06:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iJVhe7Ek"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557B285C9D;
	Mon, 25 Aug 2025 06:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104583; cv=none; b=Yvdfm/w8upzuJ9hQgs9VSDMXuPJbb0ABqFZjEBI5jyl1Ad5W83l2h6vZ0o4CIpKxgfx/RBgsoxENxSglMGe/mgscXvJzxvxuI+2G7kR+M2JAuPlHNBnVS9Hg0YdL1tQYje21kbT9rwayRYoh4Q5L6F2AfvoQujNykCmQ1OB16XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104583; c=relaxed/simple;
	bh=M86Jo2PYFFnxiVLjRD3/z4/leNvS3NHdWxrjhnhgyK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=REHtEqGeO61TGB7Jg3MmwSI3iWcyvFccMu1LAXbCG7yYQrwypNJliXlL9UcDI3DSZMnOx8mG384BLt9MvScWAUU2Q2l9AsGPwgIx8iX6Aabhnn0OJypsmrGjcaYVXUqTeaxvTK2OlFa9IPRq/hQZIHllVVdLU1Z2rNkv8TB8ZV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iJVhe7Ek; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7rgbHry8CsED6NN8pj2Gof0Dnk9pZPfECo312uCHp3Q=; b=iJVhe7Ek5d3k+k0koWDYcyBrFW
	TZvY8ZwXtBVcw1+WMLxdN+IVqw3ksmHaRjbLdjjSxPn5Inlffq7dcLlG2i4nqPL+lhNynqTfqoq2u
	hNAHEVk7TNxwPMhSPv5mje3+fZkJTUFxA2eE1oeY3I8S9ZvbBaYMkxfltzDaSQpO8I+cVEyH8mD32
	WL8kPYF1egWzuQxuQuNVLOaOlOI/cwnywN8/92FJh+T74AUKphNUItgwOzo2Afj6FrOKOdWhfj6ou
	YTBkjDWdwBvN/rAZwFJpat97zV4p1occr5xnoOznIPnJdCSJoksCEzF6UB4kwuk1m5cMVYPih19gR
	dxn9St+g==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqR1Q-000000074Hr-1fAe;
	Mon, 25 Aug 2025 06:49:40 +0000
Message-ID: <063b6127-57d9-4a5d-a1c9-971a0ae3f7c6@infradead.org>
Date: Sun, 24 Aug 2025 23:49:39 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uapi/fcntl: conditionally define AT_RENAME* macros
To: Amir Goldstein <amir73il@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>
Cc: Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
References: <20250824221055.86110-1-rdunlap@infradead.org>
 <aKuedOXEIapocQ8l@casper.infradead.org>
 <9b2c8fe2-cf17-445b-abd7-a1ed44812a73@infradead.org>
 <CAOQ4uxiShq5gPCsRh5ZDNXbG4AGH5XpfHx0HXDWTS+5Y95hieQ@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOQ4uxiShq5gPCsRh5ZDNXbG4AGH5XpfHx0HXDWTS+5Y95hieQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Amir,


On 8/24/25 10:58 PM, Amir Goldstein wrote:
> On Mon, Aug 25, 2025 at 1:54 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 8/24/25 4:21 PM, Matthew Wilcox wrote:
>>> On Sun, Aug 24, 2025 at 03:10:55PM -0700, Randy Dunlap wrote:
>>>> Don't define the AT_RENAME_* macros when __USE_GNU is defined since
>>>> /usr/include/stdio.h defines them in that case (i.e. when _GNU_SOURCE
>>>> is defined, which causes __USE_GNU to be defined).
>>>>
>>>> Having them defined in 2 places causes build warnings (duplicate
>>>> definitions) in both samples/watch_queue/watch_test.c and
>>>> samples/vfs/test-statx.c.
>>>
>>> It does?  What flags?
>>>
>>
>> for samples/vfs/test-statx.c:
>>
>> In file included from ../samples/vfs/test-statx.c:23:
>> usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
>>   159 | #define AT_RENAME_NOREPLACE     0x0001
>> In file included from ../samples/vfs/test-statx.c:13:
>> /usr/include/stdio.h:171:10: note: this is the location of the previous definition
>>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
>> usr/include/linux/fcntl.h:160:9: warning: ‘AT_RENAME_EXCHANGE’ redefined
>>   160 | #define AT_RENAME_EXCHANGE      0x0002
>> /usr/include/stdio.h:173:10: note: this is the location of the previous definition
>>   173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
>> usr/include/linux/fcntl.h:161:9: warning: ‘AT_RENAME_WHITEOUT’ redefined
>>   161 | #define AT_RENAME_WHITEOUT      0x0004
>> /usr/include/stdio.h:175:10: note: this is the location of the previous definition
>>   175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>>
>> for samples/watch_queue/watch_test.c:
>>
>> In file included from usr/include/linux/watch_queue.h:6,
>>                  from ../samples/watch_queue/watch_test.c:19:
>> usr/include/linux/fcntl.h:159:9: warning: ‘AT_RENAME_NOREPLACE’ redefined
>>   159 | #define AT_RENAME_NOREPLACE     0x0001
>> In file included from ../samples/watch_queue/watch_test.c:11:
>> /usr/include/stdio.h:171:10: note: this is the location of the previous definition
>>   171 | # define AT_RENAME_NOREPLACE RENAME_NOREPLACE
>> usr/include/linux/fcntl.h:160:9: warning: ‘AT_RENAME_EXCHANGE’ redefined
>>   160 | #define AT_RENAME_EXCHANGE      0x0002
>> /usr/include/stdio.h:173:10: note: this is the location of the previous definition
>>   173 | # define AT_RENAME_EXCHANGE RENAME_EXCHANGE
>> usr/include/linux/fcntl.h:161:9: warning: ‘AT_RENAME_WHITEOUT’ redefined
>>   161 | #define AT_RENAME_WHITEOUT      0x0004
>> /usr/include/stdio.h:175:10: note: this is the location of the previous definition
>>   175 | # define AT_RENAME_WHITEOUT RENAME_WHITEOUT
>>

>>>
>>> I'm pretty sure C says that duplicate definitions are fine as long
>>> as they're identical.
>> The vales are identical but the strings are not identical.
>>
>> We can't fix stdio.h, but we could just change uapi/linux/fcntl.h
>> to match stdio.h. I suppose.
> 
> I do not specifically object to a patch like this (assuming that is works?):
> 
> --- a/include/uapi/linux/fcntl.h
> +++ b/include/uapi/linux/fcntl.h
> @@ -156,9 +156,9 @@
>   */
> 
>  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
> -#define AT_RENAME_NOREPLACE    0x0001
> -#define AT_RENAME_EXCHANGE     0x0002
> -#define AT_RENAME_WHITEOUT     0x0004
> +#define AT_RENAME_NOREPLACE    RENAME_NOREPLACE
> +#define AT_RENAME_EXCHANGE     RENAME_EXCHANGE
> +#define AT_RENAME_WHITEOUT     RENAME_WHITEOUT
> 

I'll test that.

> 
> But to be clear, this is a regression introduced by glibc that is likely
> to break many other builds, not only the kernel samples
> and even if we fix linux uapi to conform to its downstream
> copy of definitions, it won't help those users whose programs
> build was broken until they install kernel headers, so feels like you
> should report this regression to glibc and they'd better not "fix" the
> regression by copying the current definition string as that may change as per
> the patch above.
> 

I'll look into that also.

> Why would a library copy definitions from kernel uapi without
> wrapping them with #ifndef or #undef?

To me it looks like they stuck them into the wrong file - stdio.h
instead of fcntl.h.

thanks.
-- 
~Randy


