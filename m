Return-Path: <linux-fsdevel+bounces-70094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D0C0C907B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 02:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B1E24E1520
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Nov 2025 01:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5252E224B0E;
	Fri, 28 Nov 2025 01:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eIxrH2zN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764942236E9
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Nov 2025 01:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764292934; cv=none; b=JeLERTKyvTEWmJ6gbwjU9ksMhRAiLBbS4y+TTdkm494NgVMOeUnQ/dBsD1fjAbhzZz/Mf9LBm65OcM2cgftxG3JAtnvdlN6FyBrbToY1bmrOmtS05KRywmgu4yqMnXGd1U/milbax3/1ti1Of8FCqa4hEdZTPthyiiGmNuY2OgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764292934; c=relaxed/simple;
	bh=BZPI4SRVS9+alTizkwRrZo81IAHx6uyydJUiRte/BWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DgRZPPKWcDgroruRBI/a1k0qyQkdPo3a4Y7569uUi1LT8UdNFiAfNhf/MZLTbMBZwr9SKuNYCM8INgFYAV82p3Cu5OME9g1LNjFJ1Dx9lsbCq9koOTZlPDAASgNLS9N+Z0SPgCQ4qlcR7erl2mjF+6jf64uq9K74EZQj3t8RGMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eIxrH2zN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=92MlZniQWGNmpk8DnB4Rgd3OSLzlP91hQmY+T34Ms3w=; b=eIxrH2zNwodSSMJJwZfwSi2zlD
	V2KKpz4eqY7mCd0mxAGgDPJdacXmVFfRArAMya2ZYjy1lKgcugEg/4UtcqXLqwRREPDyoNZeeLjmR
	z+KedZ6/x20QXUxnuid4+N1HIumduZBzntrU9V9UNZA+a8hgYwf2HbdP4EE6Ky0MkW+1+1jz/qCbs
	UuETZU8bnPZuGNfk0pKNyIoB7E4FIvxUEQRcdwz9mlu0An/QyhCt1iWyb4rrK5IVTvnG3im04AKkX
	cG18Nge6nkG441M5tH5D02VX2PROAZGoj648mwzTd/WIdKz10NeqU6g9OKseBZjZKhjg2Qr3TKkn5
	/TQ/aIZg==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOnBb-0000000HOHZ-1kON;
	Fri, 28 Nov 2025 01:22:11 +0000
Message-ID: <b59202f5-3292-4ca9-be23-c134524d0418@infradead.org>
Date: Thu, 27 Nov 2025 17:22:11 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] VFS: namei: fix __start_dirop() kernel-doc warnings
To: NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
References: <20251128002841.487891-1-rdunlap@infradead.org>
 <176429230388.634289.16874615606207992509@noble.neil.brown.name>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <176429230388.634289.16874615606207992509@noble.neil.brown.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/27/25 5:11 PM, NeilBrown wrote:
> On Fri, 28 Nov 2025, Randy Dunlap wrote:
>> Use the correct function name and add description for the @state
>> parameter to avoid these kernel-doc warnings:
>>
>> Warning: fs/namei.c:2853 function parameter 'state' not described
>>  in '__start_dirop'
>> WARNING: fs/namei.c:2853 expecting prototype for start_dirop().
>>  Prototype was for __start_dirop() instead
>>
>> Fixes: ff7c4ea11a05 ("VFS: add start_creating_killable() and start_removing_killable()")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: NeilBrown <neil@brown.name>
>> Cc: Christian Brauner <brauner@kernel.org>
>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
>> Cc: Jan Kara <jack@suse.cz>
>> ---
>>  fs/namei.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> --- linux-next-20251127.orig/fs/namei.c
>> +++ linux-next-20251127/fs/namei.c
>> @@ -2836,10 +2836,11 @@ static int filename_parentat(int dfd, st
>>  }
>>  
>>  /**
>> - * start_dirop - begin a create or remove dirop, performing locking and lookup
>> + * __start_dirop - begin a create or remove dirop, performing locking and lookup
>>   * @parent:       the dentry of the parent in which the operation will occur
>>   * @name:         a qstr holding the name within that parent
>>   * @lookup_flags: intent and other lookup flags.
>> + * @state:        target task state
>>   *
>>   * The lookup is performed and necessary locks are taken so that, on success,
>>   * the returned dentry can be operated on safely.
>>
> 
> Thanks - but I would rather the doc comment were moved down to be
> immediately before start_dirop().

Sounds good.

> If we were to document __start_dirop (as well?) we would need to
> actually say what @state is used for.
-- 
~Randy


