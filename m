Return-Path: <linux-fsdevel+bounces-11521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBCF8543FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 09:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E51971F26091
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 08:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6658F12B6F;
	Wed, 14 Feb 2024 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHQHSt6D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345412B61;
	Wed, 14 Feb 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898987; cv=none; b=DAwwNIHLZIDYXBJ8CkL9rNKAbJltX4bRSFPXIoGFgGHN5hDfsjn18gEtIv060izQhOL23YJFau3sML35V+azwc/g9+ziJC6d7/MgIeJJKcGAyZeLCtq33tN78ERFl6bBGqYPvHeaVPAhlXkZVQhBjiu1FDDTytJibxv+Ul3lEN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898987; c=relaxed/simple;
	bh=hyXtn3CIoHnvKwBpA2Vs5EI7MGrXCDUwPhvYKxWJI6E=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=ME7HCuIRDgsyZ3fpUTpKF6vDgqtkWTdjlvj+15cUd2ZoTRekTV0dIpRr9QSugOk46ctyBTUMwGyoQkxBRBzO8kGwTLdafxpCaMa03QwppuHjOmmdHqjJ6ovAz1+Ha7x7d49esu4dJH30HNaBWQi51lFgbKUaUtJiQpX0iB8exnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHQHSt6D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA094C433C7;
	Wed, 14 Feb 2024 08:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707898987;
	bh=hyXtn3CIoHnvKwBpA2Vs5EI7MGrXCDUwPhvYKxWJI6E=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=AHQHSt6DodIKddWn62BVtvjKS4XOAVsKfMv7anjSjwE4hZcVGEPIFc+YNLelheMvN
	 kbXES9hY+PFCS4pb0Fz2hv4iYRfg4AAXm4q8t6JiGXCdcLZGvN+PtKwMweEt0cu1LX
	 LByTM4ASnHP9vLxVmN750BpcG/5SDncKWbOQNiYwlInpP8DLawqmwB42QoMiHosT6z
	 /lAb4QAA83jTx3JVg/ZPhkxYaK7ax2iRqUjx9POfC1fwWKSblVd+0ElMf5oNlYhgpx
	 MtlbL7ZA/NScOc+BfQWPQAQ8o9hW+Dn9Zz6hTwniBer3EN1dQEDT4ccFzzsxCS+skb
	 Hxel3e/wg4nXA==
References: <87frxva65g.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240214080305.GA10568@lst.de>
User-agent: mu4e 1.10.8; emacs 27.1
From: Chandan Babu R <chandanbabu@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org, Hugh Dickins
 <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
Subject: Re: shmem patches headsup: Re: [ANNOUNCE] xfs-linux: for-next
 updated to 9ee85f235efe
Date: Wed, 14 Feb 2024 13:51:42 +0530
In-reply-to: <20240214080305.GA10568@lst.de>
Message-ID: <877cj7a1zw.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Feb 14, 2024 at 09:03:05 AM +0100, Christoph Hellwig wrote:
> On Wed, Feb 14, 2024 at 12:18:41PM +0530, Chandan Babu R wrote:
>> The for-next branch of the xfs-linux repository at:
>> 
>> 	https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git
>> 
>> has just been updated.
>
> <snip>
>
>> Christoph Hellwig (17):
>>       [f23e079e024c] mm: move mapping_set_update out of <linux/swap.h>
>>       [604ee858a8c8] shmem: move shmem_mapping out of line
>>       [8481cd645af6] shmem: set a_ops earlier in shmem_symlink
>>       [9b4ec2cf0154] shmem: move the shmem_mapping assert into shmem_get_folio_gfp
>>       [36e3263c623a] shmem: export shmem_get_folio
>>       [74f6fd19195a] shmem: export shmem_kernel_file_setup
>>       [eb84b86441e3] shmem: document how to "persist" data when using shmem_*file_setup
>
> I would have prefer an ACK or even a shared branch in the MM tree
> for these.  But as it's been impossible to get any feedback from
> the shmem and mm maintainer maybe this is the right thing to do.
>

I am sorry. I completely forgot about the requirement for an ack from the MM
maintainers. Thanks for bringing it to notice.

-- 
Chandan

