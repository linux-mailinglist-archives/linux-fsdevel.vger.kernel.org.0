Return-Path: <linux-fsdevel+bounces-14228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B08879B34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ACF61F22482
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Mar 2024 18:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4801139574;
	Tue, 12 Mar 2024 18:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b="tSLgXOdq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from box.fidei.email (box.fidei.email [71.19.144.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970213958E
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Mar 2024 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.19.144.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267533; cv=none; b=ImKhD8o/xVGlVh3e8xFaABw1RXJtF5qxmYFRDwa/d08haeZrqNXPkkYl4R2fcsgj1/H4x7ZmdIajnpmXbZVzE1UJZc/9U/9gZq6A6pPqE2yc/TTlBfc5BB1vOF5dICdHjCZHgSb8Y2CfjagFGMaj8LXeXQORG89t90QT9AO0GHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267533; c=relaxed/simple;
	bh=FVI3Z/Sn68gd6SyV1Hm/Nkq8n0hhFJsGW02lMKd9bSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=shOX+mel2AatKx4WLoyzVhRCnvMs4E5gJA05eja89Z5aBi8hBncW74QAbmt4k8cM8u9uTaMFTIqkhhuieJ43uFUGiZoANgZUpXBvOG+8e/ZxYarUxA+HJ3hCS6VhevgOm35oe0jfhPZv+pMnZzFqbM9r+eBNuugJijqTN231olg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me; spf=pass smtp.mailfrom=dorminy.me; dkim=pass (2048-bit key) header.d=dorminy.me header.i=@dorminy.me header.b=tSLgXOdq; arc=none smtp.client-ip=71.19.144.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dorminy.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dorminy.me
Received: from authenticated-user (box.fidei.email [71.19.144.250])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by box.fidei.email (Postfix) with ESMTPSA id E1DE881199;
	Tue, 12 Mar 2024 14:18:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
	t=1710267525; bh=FVI3Z/Sn68gd6SyV1Hm/Nkq8n0hhFJsGW02lMKd9bSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tSLgXOdqzaxTgrCd6ubk1FYTgTtnQimeTARZSaQesGgh6nzd2vSFLr40ogPtCMqJM
	 cAIQ+ROxrjqwJIEul965bOm+V/BHFG0zLbf4FU4+FexLuhzkMEu5zZLrOPcrhddd8k
	 pYlfMeDV+d90G9BUCA6I729QFoNF1DIY6lpHsQfK9bR8GxoNh0y0WFgPTyHvHIPwG7
	 yoY4pZLEzK9SSM3e8Q1JRpAHu01vTuJMzBaLL3E2yYiVD9B9C9/go6RsuZoXDr1NDh
	 0ZxB5gH8/6kAFIe7FAzaw2TRFRkm6R0hsTujt6ApRKBsnx1UYfx0KyHzLFLkLtlL/U
	 xSNvlADiG9/jA==
Message-ID: <4911426f-cf12-44f4-aef1-1000668ad3a0@dorminy.me>
Date: Tue, 12 Mar 2024 14:18:43 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] fuse: update size attr before doing IO
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
 josef@toxicpanda.com, amir73il@gmail.com
References: <9d71a4fd1f1d8d4cfc28480f01e5fe3dc5a7e3f0.1709821568.git.sweettea-kernel@dorminy.me>
 <CAJfpeguHZCkkY2MZjJJZ2HhvhQuMhmwqnqGoxV-+wjsKwijX6w@mail.gmail.com>
From: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
In-Reply-To: <CAJfpeguHZCkkY2MZjJJZ2HhvhQuMhmwqnqGoxV-+wjsKwijX6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/24 06:01, Miklos Szeredi wrote:
> On Thu, 7 Mar 2024 at 16:10, Sweet Tea Dorminy
> <sweettea-kernel@dorminy.me> wrote:
>>
>> All calls into generic vfs functions need to make sure that the inode
>> attributes used by those functions are up to date, by calling
>> fuse_update_attributes() as appropriate.
>>
>> generic_write_checks() accesses inode size in order to get the
>> appropriate file offset for files opened with O_APPEND. Currently, in
>> some cases, fuse_update_attributes() is not called before
>> generic_write_checks(), potentially resulting in corruption/overwrite of
>> previously appended data if i_size is out of date in the cached inode.
> 
> While this all sounds good, I don't think it makes sense.
> 
> Why?  Because doing cached O_APPEND writes without any sort of
> exclusion with remote writes is just not going to work.
> 
> Either the server ignores the current size and writes at the offset
> that the kernel supplied (which will be the cached size of the file)
> and executes the write at that position, or it appends the write to
> the current EOF.  In the former case the cache will be consistent, but
> append semantics are not observed, while in the latter case the append
> semantics are observed, but the cache will be inconsistent.
> 
> Solution: either exclude remote writes or don't use the cache.
> 
> Updating the file size before the write does not prevent the race,
> only makes the window smaller.

Definitely agree with you.

The usecase at hand is a sort of NFS-like network filesystem, where 
there's exclusion of remote writes while the file is open, but no 
problem with remote writes while the file is closed.

The alternative we considered was to add a fuse_update_attributes() call 
to open.

We thought about doing so during d_revalidate/lookup_fast(). But as far 
as I understand, lookup_fast() is not just called during open, and will 
use the cached inode if the dentry timeout hasn't expired. We tried 
setting dentry timeout to 0, but that lost too much performance. So that 
didn't seem to work.

But updating attributes after giving the filesystem a chance to 
invalidate them during open() would work, I think?

That would also conveniently fix the issue where copy_file_range() 
currently checks the size before calling into fuse at all, which I'd 
been building a more elaborate changeset for.

How does that sound?

Thanks!

Sweet Tea

