Return-Path: <linux-fsdevel+bounces-60305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545D4B448D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 23:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A65DBA45140
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 21:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662632C08D4;
	Thu,  4 Sep 2025 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UUpTNMay"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2680920E00B;
	Thu,  4 Sep 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757022677; cv=none; b=MUZaDUXpV0nIjTAwF8ipv4zUSp+LiDnkZ7jr+pTtQTr4MZtBItLBiDACo3F7C7vG6u9lh87JsrAIO5dKctNB3FYVEP92AEN5P0nQt1yi2AEs7001/nHoxfAgBP1KS5pqJsTxUprL8wymQexqJr3N4s9A2UxMY0vaO7yjXOLN5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757022677; c=relaxed/simple;
	bh=yUt30tm/rAimEdQOM1BOt7p8Mk9NoytGn6VouJeAd8c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyFN5nQveoydYu2k/B3H99cd5aUy0FKsZTbvAZrXHmYlYN+ElTLKc2Eb4xcC/Hmhf3VeVIt+bvm9of6oeCkjUw2d87nmRJg0T4iHFuhH2OCCSnBSokvHbz1shXYKaJzW1WhQR90eaSTDGL8/nD40vC6BuE8CCKsmhrlldrES90s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UUpTNMay; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=etyybXyPjxqJwmCMzpP6Wc2EQMSXhTJ2YInyCkwJSd4=; b=UUpTNMayF5LFDM2rrQR7vpIVid
	CWS901KeVFsEgKUUjjXMlHf7o0GQohBESkzI6JLqyQteMTnpScDGTG/j9JX7KQPTUAQHuxKtmY4rl
	ze2IXgafRrYrB9b1gi0DmWqWN0dbKj7bODe1W7Q8iMPhvnUxor3i43fz7yY7j/wPum7smikix32qN
	KPR5PcxB2oeue3CYfc6x2E47HWbewrBXyFQEwrcqCdBX0AkE1yQc9DlaJYUlJi6EzuU05nZ4JR5Fi
	n9kVToG6WKCUcagxKKBgUm5CO1F4mITcJ0BktmJVD4B8jpU/gmIjp9hNEOyPtzwc8yl+QqdoaPVP1
	OxClVffw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uuHrO-0000000EfZ4-3fML;
	Thu, 04 Sep 2025 21:51:14 +0000
Message-ID: <3e8add9c-7686-4661-b7b2-0f31e01bc6b3@infradead.org>
Date: Thu, 4 Sep 2025 14:51:14 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] uapi/linux/fcntl: remove AT_RENAME* macros
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
 Alexander Aring <alex.aring@gmail.com>, Josef Bacik <josef@toxicpanda.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Matthew Wilcox
 <willy@infradead.org>, David Howells <dhowells@redhat.com>,
 linux-api@vger.kernel.org
References: <20250904062215.2362311-1-rdunlap@infradead.org>
 <CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAOQ4uxiJibbq_MX3HkNaFb3GXGsZ0nNehk+MNODxXxy_khSwEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/4/25 11:17 AM, Amir Goldstein wrote:
> On Thu, Sep 4, 2025 at 8:22 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Don't define the AT_RENAME_* macros at all since the kernel does not
>> use them nor does the kernel need to provide them for userspace.
>> Leave them as comments in <uapi/linux/fcntl.h> only as an example.
>>
>> The AT_RENAME_* macros have recently been added to glibc's <stdio.h>.
>> For a kernel allmodconfig build, this made the macros be defined
>> differently in 2 places (same values but different macro text),
>> causing build errors/warnings (duplicate definitions) in both
>> samples/watch_queue/watch_test.c and samples/vfs/test-statx.c.
>> (<linux/fcntl.h> is included indirecty in both programs above.)
>>
>> Fixes: b4fef22c2fb9 ("uapi: explain how per-syscall AT_* flags should be allocated")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Amir Goldstein <amir73il@gmail.com>
>> Cc: Jeff Layton <jlayton@kernel.org>
>> Cc: Chuck Lever <chuck.lever@oracle.com>
>> Cc: Alexander Aring <alex.aring@gmail.com>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: David Howells <dhowells@redhat.com>
>> CC: linux-api@vger.kernel.org
>> To: linux-fsdevel@vger.kernel.org
>> ---
>>  include/uapi/linux/fcntl.h |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> --- linux-next-20250819.orig/include/uapi/linux/fcntl.h
>> +++ linux-next-20250819/include/uapi/linux/fcntl.h
>> @@ -155,10 +155,16 @@
>>   * as possible, so we can use them for generic bits in the future if necessary.
>>   */
>>
>> +/*
>> + * Note: This is an example of how the AT_RENAME_* flags could be defined,
>> + * but the kernel has no need to define them, so leave them as comments.
>> + */
>>  /* Flags for renameat2(2) (must match legacy RENAME_* flags). */
>> +/*
>>  #define AT_RENAME_NOREPLACE    0x0001
>>  #define AT_RENAME_EXCHANGE     0x0002
>>  #define AT_RENAME_WHITEOUT     0x0004
>> +*/
>>
> 
> I find this end result a bit odd, but I don't want to suggest another variant
> I already proposed one in v2 review [1] that maybe you did not like.
> It's fine.

Yes, I replied to that with another problem.

> I'll let Aleksa and Christian chime in to decide on if and how they want this
> comment to look or if we should just delete these definitions and be done with
> this episode.

Sure, I'm ready to just throw my hands up (give up).

> 
> Thanks,
> Amir.
> 
> [1] https://lore.kernel.org/r/CAOQ4uxjXvYBsW1Nb2HKaoUg1qi8Pkq1XKtQEbnAvMUGcp7LrZA@mail.gmail.com/
thanks.
-- 
~Randy


