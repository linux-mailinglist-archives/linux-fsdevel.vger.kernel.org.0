Return-Path: <linux-fsdevel+bounces-17382-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5F58AC7B5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 10:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C692822B9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 08:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F4524A5;
	Mon, 22 Apr 2024 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnjEFwCE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4E25FB94;
	Mon, 22 Apr 2024 08:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775733; cv=none; b=PXBXc+G2rVJedr1+VaUf9PRxpnKGST/XoEuj5LwaI5p63Gh1E8N8P0bJDob2jVcttIlTPDSc/oc4L/PsTQF5OYqkFz9z54EQKxvh/Zms8EbFQdQGyUNHvEQu7eu4yzZkPXzOZwtjf6ya9N742pjhrfrPiZoOHufPXXfYIvntXrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775733; c=relaxed/simple;
	bh=OP4Ps8Qa3zvE8Pn2z8Xkk4oqd6WcU+QQfhEsY+wYsn0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=jfJ/yRli8vjyXfY6oIvUw8bjW9Xmx5vWoI8+s2tJ4kGJKOsbOUzL3SsxpeN6+giQ92f9tTFyVjNAOO+j07s108EK5/7hqWXm61n8ZNMhbFPScb3/vAOPD+0uMBCwjQ8KvQ2mXJ7JIGuiBZJF4SNsr/QLMobBZkxzpy/e3QOhPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnjEFwCE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BBD4C4AF07;
	Mon, 22 Apr 2024 08:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713775732;
	bh=OP4Ps8Qa3zvE8Pn2z8Xkk4oqd6WcU+QQfhEsY+wYsn0=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:From;
	b=fnjEFwCE+gX0vcY5s6ycmKqPR8HDBb1IiKxd0XB1zUCyXIQsAnOw8ajLs8ELdp8TA
	 zgBj1ZQEIuC6Z3QaWh4IUyzDG+vRHF7l46JBtRxjopNnp6WC3VHEW1fDqk99JNEi3i
	 Tjt7v54kw/orCMqxHzrtk2bEi5XJxb58IVP3HjGBLURuQjvKHIG4xEeciQSEJ++NZh
	 UuNtmqdNUfDjGa4MpjARYu/KfNWajQ1rcVt0sAQ1l6l4L5/S59oL7TDSr9+W8d8LL9
	 +g8+tUOGhSt5yoVyreyjGIedURwI3uvB1KINbgzD1Mrsjds8IxzzHn6hqj2OGVUSzG
	 0nzLts1pT2RWA==
References: <87jzkqlzbr.fsf@debian-BULLSEYE-live-builder-AMD64>
 <20240422055512.GA2486@lst.de>
User-agent: mu4e 1.10.8; emacs 29.2
From: Chandan Babu R <chandanbabu@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Dave Chinner <dchinner@redhat.com>, abaci@linux.alibaba.com,
 allison.henderson@oracle.com, catherine.hoang@oracle.com,
 dan.carpenter@linaro.org, djwong@kernel.org,
 jiapeng.chong@linux.alibaba.com, linux-fsdevel@vger.kernel.org,
 linux-xfs@vger.kernel.org, thorsten.blum@toblux.com
Subject: Re: [ANNOUNCE] xfs-linux: for-next updated to c414a87ff750
Date: Mon, 22 Apr 2024 14:17:20 +0530
In-reply-to: <20240422055512.GA2486@lst.de>
Message-ID: <87cyqhn5ot.fsf@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Apr 22, 2024 at 07:55:12 AM +0200, Christoph Hellwig wrote:
> On Mon, Apr 22, 2024 at 11:16:13AM +0530, Chandan Babu R wrote:
>> Christoph, Can you please rebase and re-post the following patchsets on top of
>> xfs-linux's updated for-next branch,
>> 1. xfs: compile out v4 support if disabled
>> 2. spring cleaning for xfs_extent_busy_clear
>> 3. bring back RT delalloc support
>
> Can you please drop this one first:
>
>>       [6279a2050c8b] xfs: fix sparse warning in xfs_extent_busy_clear
>
> befoere I resend series 2 above?
>
> It is the inital hack for the sparse warnings and extent busy sparse
> warnings, which just causes a lot of churn.

I have now dropped the above patch which fixes a sparse warning and applied
"spring cleaning for xfs_extent_busy_clear" patchset. I should be able to
update for-next tomorrow.

-- 
Chandan

