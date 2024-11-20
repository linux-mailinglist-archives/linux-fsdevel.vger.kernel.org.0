Return-Path: <linux-fsdevel+bounces-35283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5409D35FC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 09:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76C67B23761
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2024 08:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66CF1865E5;
	Wed, 20 Nov 2024 08:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4HOON5g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00E15B0EE;
	Wed, 20 Nov 2024 08:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732092852; cv=none; b=HFnbhKHn+H3lhWzT1g49g9FUIX7z2RqH2hDpcIUUcK+NhRSbPxHoxGBdPLSeU2wHG2lrzO0WQ4w9B8xaTCn3De85c3bHXUohfpXrxOh1dOeLLB7ygcs0m8zAVC2At1m6NLGgNR4znoWlca45Bv0alVLN1XOWPKDmqdzpYoOyLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732092852; c=relaxed/simple;
	bh=XGBGHJ1UrQTa4nLheK/M4FsN7lw4iA53sAEYC2MpFe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsvHgX2QgIADpV1zMnxJjdQ8i7GIZ0S0G1nrjOqo7Txu6ci2w9AaCDtmHLd6fzH7DH5ZUB/r81Ou03WRj7cikNZ4Um3gX7ekkREa9+iqZ1t/a4SXTsNEkim/hQoEqDRZgNYVcJz73lMoTLwIIZtNtSzeqK8JR8W4pg1J/KV8Toc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4HOON5g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458BEC4CECD;
	Wed, 20 Nov 2024 08:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732092851;
	bh=XGBGHJ1UrQTa4nLheK/M4FsN7lw4iA53sAEYC2MpFe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z4HOON5gcw8ibSmu12PZAr6y10tAigi2d3qTzAQAwOV9S8ICHFdqPppJQET7mK9Bf
	 eh+HvzaPFPl8N9waCrT13mIRkIexTLUz5+ej+BvRpGaSnRQFUOG7VmPb/9cMV7RAmA
	 FFQ5NHK65fBXBV23W/Z9VeTyDOwWAI2v5WkR4rgn7ZR0xWvMTWIHPwL2UwY1lUG21G
	 EO0IEFLp1GzqXMqzj2NiwyeKo8hvSh1lZipp5cVMOHv0K3GDLFA18vDNosQqwHY2SY
	 Ch5eeq3DtRh9vbT2NH8W32727Qaqi2MzML9ouUuItvdd0IXVhI1qYkKMwgX12SOzVH
	 kVPQe6xlF7R4Q==
Date: Wed, 20 Nov 2024 09:54:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs tmpfs
Message-ID: <20241120-annahme-tilgen-cfa206be31ce@brauner>
References: <20241115-vfs-tmpfs-d443d413eb26@brauner>
 <CAHk-=wgqUNhk8awrnf+WaJQc9henwvXsYTyLbF2UFSL7vCuVyg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgqUNhk8awrnf+WaJQc9henwvXsYTyLbF2UFSL7vCuVyg@mail.gmail.com>

On Mon, Nov 18, 2024 at 11:26:12AM -0800, Linus Torvalds wrote:
> On Fri, 15 Nov 2024 at 06:07, Christian Brauner <brauner@kernel.org> wrote:
> >
> > This adds case-insensitive support for tmpfs.
> 
> Ugh.
> 
> I've pulled this, but I don't love it.
> 
> This pattern:
> 
>     if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
>         d_add(dentry, inode);
>     else
>         d_instantiate(dentry, inode);
> 
> needs an explanation, and probably a helper.

I think we had this discussion before where we decided to move all the
checks inline. But yes, this could probably be refactored to be easier
to understand.

> 
> And
> 
> >  include/linux/shmem_fs.h            |   6 +-
> >  mm/shmem.c                          | 265 ++++++++++++++++++++++++++++++++++--
> 
> I'm starting to think this should be renamed and/or possibly split up
> a bit. The actual path component handling functions should be moved
> out of mm/shmem.c.
> 
> The whole "mm/shmem.c" thing made sense back in the days when this was
> mainly about memory management functions with some thing wrappers for
> exposing them as a filesystem, and tmpfs was kind of an odd special
> case.
> 
> Those thin wrappers aren't very thin any more, and "shmem" is becoming
> something of a misnomer with the actual filesystem being called
> "tmpfs".
> 
> We also actually have *two* different implementations of "tmpfs" -
> both in that same file - which is really annoying. The other one is
> based on the ramfs code.
> 
> Would it be possible to try to make this a bit saner?

So one possibility would be to move tmpfs into fs and have fs/tmpfs/ (or
mm/tmpfs/) which would also be nice because mm/shmem.c is actively
confusing when you're looking for the tmpfs code. And then it could
simply be split up. I'm all for it.

