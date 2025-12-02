Return-Path: <linux-fsdevel+bounces-70417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2A0C99BCA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 02 Dec 2025 02:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADB683A4EDA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Dec 2025 01:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682631D618E;
	Tue,  2 Dec 2025 01:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ek/eJKLu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3BA79CF;
	Tue,  2 Dec 2025 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638802; cv=none; b=uiEo4u6Omq3ijN8db3hV3R2jXmvdQ9Fz66T5TygnT+gzKFpY3ulbM9rkeZ86vYJEbGA1MEOiT16V6Rj8IclsLACRX2sA8dPyLA+8IZP00iE2PdjBJ0pVbcE9ZjMTvM516ZHsNi9PBI4S/blyEIwQYEE3ErFctwy9w6GIUydnjs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638802; c=relaxed/simple;
	bh=LfP14txAo2u9M1rldCt/j4n4Q1SC5sM4HinS3I5MYaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzEVQvn4oUtWrYQ5w6oyf5CzRwv8J2QJbPvbGTeGsCvYeBuObynkpgs70pTxEooaX61eWsgBlF15xCBhBGsJYzB4lcAcZaaVpI5n1UDKXwH5FM6UDu1idiMsBmqHrixW//B8WKbmlQYtR/UpaQL+FDqYnYp2A6mR6rdfzB73Aq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ek/eJKLu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD4CC4CEF1;
	Tue,  2 Dec 2025 01:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764638802;
	bh=LfP14txAo2u9M1rldCt/j4n4Q1SC5sM4HinS3I5MYaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ek/eJKLuk1qAMsRhcRaRepW8CBL1NgBN/M2qiGgVzkm+3HOvcdDrHbXEGs8uf1JrL
	 X1/kjDY719XWNedy0ZDj0us1CYPjLKJND1LbELUuhTJoCkJD4FhVXyk/1vCR1Xj0XV
	 uDc3Yl2zPBY2XrT3r2GtdbPZpjn+thk8InIZFBckfZ87ohISqw+4AXxa8wXY605vnl
	 mAtxGXrPlJQkBLkcjHP+j8+WXhxF0L2m6vlwkoGF5U5cEtc5YT51RPcPmiX+y5Wunm
	 5WumBs219tUSMzgREFV4QrMOIDkxE5V6ytPzXj243vrIVMXnH3pV80CJpIFAC6CqAx
	 gme5mQJproPxA==
Date: Mon, 1 Dec 2025 20:26:35 -0500
From: Sasha Levin <sashal@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Mike Snitzer <snitzer@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 08/17 for v6.19] cred guards
Message-ID: <aS5AS-rzQfFeK94L@laps>
References: <20251128-vfs-v619-77cd88166806@brauner>
 <20251128-kernel-cred-guards-v619-92c5a929779c@brauner>
 <CAHk-=wjZsdKQVkVNZ3XP2UncbYdyF0BDZpM5dLgN6PksTcfAXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wjZsdKQVkVNZ3XP2UncbYdyF0BDZpM5dLgN6PksTcfAXQ@mail.gmail.com>

On Mon, Dec 01, 2025 at 01:53:02PM -0800, Linus Torvalds wrote:
>On Fri, 28 Nov 2025 at 08:51, Christian Brauner <brauner@kernel.org> wrote:
>>
>> Merge conflicts with mainline
>>
>> diff --cc fs/nfs/localio.c
>
>So I ended up merging this very differently from  how you did it.
>
>I just wrapped 'nfs_local_call_read()' for the cred guarding the same
>way the 'nfs_local_call_write()' side had been done.
>
>That made it much easier to see that the changes by Mike were carried
>over, and seems cleaner anyway.
>
>But it would be good if people double-checked my change. It looks
>"ObviouslyCorrect(tm)" to me, but...

A minor nit:

	+ static void nfs_local_call_write(struct work_struct *work)
	+ {
	+       struct nfs_local_kiocb *iocb =
	+               container_of(work, struct nfs_local_kiocb, work);
	+       struct file *filp = iocb->kiocb.ki_filp;
	+       unsigned long old_flags = current->flags;
	+       ssize_t status;
	+ 
	+       current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
	+ 
	+       scoped_with_creds(filp->f_cred)
	+               status = do_nfs_local_call_write(iocb, filp);
	+ 
	        current->flags = old_flags;
	 -
	 -      if (status != -EIOCBQUEUED) {
	 -              nfs_local_write_done(iocb, status);
	 -              nfs_local_vfs_getattr(iocb);
	 -              nfs_local_pgio_release(iocb);
	 -      }
	  }

With the change above, `status` should have been dropped altogether.

I'll send a patch...

-- 
Thanks,
Sasha

