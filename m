Return-Path: <linux-fsdevel+bounces-32195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449EA9A23DD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 15:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 761D01C20896
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Oct 2024 13:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AF61DE2B0;
	Thu, 17 Oct 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcDP70MA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390151DDC09
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Oct 2024 13:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729171985; cv=none; b=mCl6wKXrMzkC9lq5g0plo4e2BZY8K9iOMU7/1ECH5K+KQFxvu3pXINQ2NKOFTdssLuhXGEL+jDrniXVldXoQoVf2URPrHuIqmXWGMvhSr2AZObDe1+Z0rbeU6zD5Du1DIBumMvBKlNGU1T0j75B+8G8bAbyHZVwurhCq/DhFvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729171985; c=relaxed/simple;
	bh=SpMdb8CcesCzpNfQXBxWjT5TBQqD7fI09HUBmX5BChg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCOIRKJhVLACtndCFhLWO6VWqYmeAN5EjB2LWyXXPkeRnBdd0/FYoRTplbrMB0NkOxUHAps7NLlGU77TN/XzSRUAj806GC+7nXOmt6eH5DHE5E55SKK8XdkpbSQN9Vt4qPXb8TZQ+kb9mRz3AGWKo1LS2+lNhWAv/j0jKG6MRa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcDP70MA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22988C4CEC3;
	Thu, 17 Oct 2024 13:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729171985;
	bh=SpMdb8CcesCzpNfQXBxWjT5TBQqD7fI09HUBmX5BChg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcDP70MAW3JLhM16NxHxE00kwfIkuGUoGQ2kxp3ex1QPQx1UDxlWtScinpWGXUUlF
	 AVWqF37ju2DoZ/OtQqMKSnngWkaYsdoSU4NVTaicJQQZ6dmQ8bbnjWKQiNFbQ9VqO5
	 V3quyGA45ZhoAxCLQgbYmMNNIvTJaK7BxgNBXz6lbM+3+SV75IOe04CzXVwkyBS0eQ
	 Ae9bk9LFruzfQUBa9zz6sTHvjwx+35JPRWL0q5kqlP6BzdHkam0cx6HtQvqwpKSF5f
	 n8XtAB8ljbpRrzFlDUF3LBkniZqv1NpR2n7umATBd8lh2Jrv4Qhm0G1WRqqaq82FDh
	 cPzn0V5/mx7Bg==
Date: Thu, 17 Oct 2024 15:33:01 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: Dropping of reiserfs
Message-ID: <20241017-zuckt-ortsnamen-8914ef3a0aab@brauner>
References: <20241017105927.qdyztpmo5zfoy7fd@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241017105927.qdyztpmo5zfoy7fd@quack3>

On Thu, Oct 17, 2024 at 12:59:27PM +0200, Jan Kara wrote:
> Hello,
> 
> Since reiserfs deprecation period is ending, it is time to prepare a patch
> to remove it from the kernel. I guess there's no point in spamming this
> list with huge removal patch but it's now sitting in my tree [1] if anybody
> wants to have a look. Unless I hear some well founded complaints I'll send
> it to Linus during the next merge window in mid-November.

Ack.

