Return-Path: <linux-fsdevel+bounces-9723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CB8844A34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 22:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B48A1C2590A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504FE39FE8;
	Wed, 31 Jan 2024 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fOC//W4u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC139AD5;
	Wed, 31 Jan 2024 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706737205; cv=none; b=SrNvB8ldP369edt93qyE3oAT/GUg/WDVpX3EwcPmeOxadjHTJ44dAbeCiJ6zrI9Q55WzljE6Nimr2ZDbjVtjV19avWg2ut+oxErPoNdamm8H14ZlqWGY1OX/jrbYnpAnBa8vXtSafZTrMXi5V2bLDFN52SIG7sHrjSI1jxPH8JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706737205; c=relaxed/simple;
	bh=mE6IlMP08TpBgXOVDJUm71vva4w7+fEDZV65jtPKtXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwibD+Z+/v1bs6uMmkTlD4gvfntMN3EWbrldjhl2MraId/jE7SbsyOepiqb0C1WOSgVg3m0zjpmya7SahKwVedFlMY0N/Vv1yHKnxrx00XqHQKrTRD2IUAp/kKTgGgmRXLy1h4dhvQXz2/qKUfpGh5T+8trIkRDdwL1Fqo52bX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fOC//W4u; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706737197;
	bh=mE6IlMP08TpBgXOVDJUm71vva4w7+fEDZV65jtPKtXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fOC//W4u0F5vbdt+tU+rP15v/l0o/+CnIg+Ydp5bcNwGYw9ud2JP/HNwuD+X2eYWY
	 AXE0QkkFuowfQF/N5KDNWKA1OtehwKwu++g42TntpSKmR0HWSQ8OE00hj0DK1lZL18
	 0noEqFv4pzYCqQ+J9lGKMSW8o44r71joP5nDgCjEpRokBxY0mzIcRAvO9I+M5X6Nje
	 0/WsjNt0cTRRaf74shtLNuDJXD/6td2e/pOr42o6HxQ8MWLaI1gQRslqQNLtk7faOo
	 2+zPZgyGqKquMsySa1E3H6j3vwxgx0Tn5FOmPizhrqqkpYnf8Hg+OKkQ2KbcVBQ7P1
	 HUgiw7TX/NJTg==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TQFn93W8xzX1V;
	Wed, 31 Jan 2024 16:39:57 -0500 (EST)
Message-ID: <0a38176b-c453-4be0-be83-f3e1bb897973@efficios.com>
Date: Wed, 31 Jan 2024 16:39:57 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/4] dax: Check for data cache aliasing at runtime
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Russell King <linux@armlinux.org.uk>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@lists.linux.dev
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
 <65bab567665f3_37ad2943c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65bab567665f3_37ad2943c@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-31 16:02, Dan Williams wrote:
> Mathieu Desnoyers wrote:
>> Replace the following fs/Kconfig:FS_DAX dependency:
>>
>>    depends on !(ARM || MIPS || SPARC)
>>
>> By a runtime check within alloc_dax().
>>
>> This is done in preparation for its use by each filesystem supporting
>> the "dax" mount option to validate whether DAX is indeed supported.
>>
>> This is done in preparation for using cpu_dcache_is_aliasing() in a
>> following change which will properly support architectures which detect
>> data cache aliasing at runtime.
>>
>> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-arch@vger.kernel.org
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: nvdimm@lists.linux.dev
>> Cc: linux-cxl@vger.kernel.org
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: dm-devel@lists.linux.dev
>> ---
>>   drivers/dax/super.c | 6 ++++++
>>   fs/Kconfig          | 1 -
>>   2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dax/super.c b/drivers/dax/super.c
>> index 0da9232ea175..e9f397b8a5a3 100644
>> --- a/drivers/dax/super.c
>> +++ b/drivers/dax/super.c
>> @@ -445,6 +445,12 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
>>   	dev_t devt;
>>   	int minor;
>>   
>> +	/* Unavailable on architectures with virtually aliased data caches. */
>> +	if (IS_ENABLED(CONFIG_ARM) ||
>> +	    IS_ENABLED(CONFIG_MIPS) ||
>> +	    IS_ENABLED(CONFIG_SPARC))
>> +		return NULL;
> 
> This function returns ERR_PTR(), not NULL on failure.

Except that it returns NULL in the CONFIG_DAX=n case as you
noticed below.

> 
> ...and I notice this mistake is also made in include/linux/dax.h in the
> CONFIG_DAX=n case. That function also mentions:
> 
>      static inline struct dax_device *alloc_dax(void *private,
>                      const struct dax_operations *ops)
>      {
>              /*
>               * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
>               * NULL is an error or expected.
>               */
>              return NULL;
>      }
> 
> ...and none of the callers validate the result, but now runtime
> validation is necessary. I.e. it is not enough to check
> IS_ENABLED(CONFIG_DAX) it also needs to check cpu_dcache_is_aliasing().

If the callers select DAX in their Kconfig, then they don't have to
explicitly check for IS_ENABLED(CONFIG_DAX). Things change for the
introduced runtime check though.

> 
> With that, there are a few more fixup places needed, pmem_attach_disk(),
> dcssblk_add_store(), and virtio_fs_setup_dax().

Which approach should we take then ? Should we:

A) Keep returning NULL from alloc_dax() for both
    cpu_dcache_is_aliasing() and CONFIG_DAX=n, and use IS_ERR_OR_NULL()
    in the caller. If we do this, then the callers need to somehow
    translate this NULL into a negative error value, or

B) Replace this NULL return value in both cases by a ERR_PTR() (which
    error value should we return ?).

I would favor approach B) which appears more robust and introduces
fewer changes. If we go for that approach do we still need to change
the callers ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


