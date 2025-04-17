Return-Path: <linux-fsdevel+bounces-46611-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4800A9163E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 10:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5023B7A55DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Apr 2025 08:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041B22DFA6;
	Thu, 17 Apr 2025 08:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6RdHQHs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DC722DF84;
	Thu, 17 Apr 2025 08:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877604; cv=none; b=BhJ3qs2p7lbNCqMmp3XqffQZmDlskHEbqPU1RSaxzoHfpMv8R7vxryuqGosiD1zGMMSGHcja7DQAlvVuIjQcSf7jF3dO1JeCtSgA06WjlSWljw09RPSG2mCj776dKL+Dk4J1D+HF9n/Xn8YILSWchB2NS5sQoj28wyxd/3MsJg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877604; c=relaxed/simple;
	bh=CHAl3JBt1yOlpKjj35Z2bMWZDjqGaRtbDrjhbfts9qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CS1OLE2XoUfQNz2uScM6PsFMFcVaVJVMg+8dvAbphl5rR7Xk/zA6lJzuXB/pmA6e2F7gIaC1z+V60hUE9cqTdtqIPOrCLx+6hxTUB7shzKuIvoeKLeWI19qZ/Aou/MCE5U6P3l4hL7KIJKsRW5YEeAQvkR3VIpNslO51aqG1ilE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6RdHQHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4228C4CEE4;
	Thu, 17 Apr 2025 08:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744877603;
	bh=CHAl3JBt1yOlpKjj35Z2bMWZDjqGaRtbDrjhbfts9qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6RdHQHs67OcU45gcliq0t7Qkgx44RfjUBzCwyIh0NsamBXn6JI5nH0xwnh14i7V/
	 UF3H7A8vR0wCSZFMxAT5AVjyFvGfOoPsnHqMWWU/m7b1t5uZ7O8a9NLpeB/I81qxRw
	 REelFLA7cP9mtwOaXJCWtXrFQP6ZTteA71t96RM3b7EO5gl57Os4jlRis5xeZEkB4D
	 qjl3nGqyq4GoGPZdO2NO868KpiqCUug655N8KG3jSagz7Hx5ssjdeT+1qyHzhfeVjT
	 mXkoip08Mpu5m7im1sWW2tFBnrG0pgp0bD4EfPGiqZPDqH7FeKSAiknr9Jwmf7/BhA
	 fLXLMlZKV1YGw==
Date: Thu, 17 Apr 2025 10:13:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] two nits for path lookup
Message-ID: <20250417-sandplatz-hemmen-b357ce10b367@brauner>
References: <20250416221626.2710239-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250416221626.2710239-1-mjguzik@gmail.com>

On Thu, Apr 17, 2025 at 12:16:24AM +0200, Mateusz Guzik wrote:
> since path looku is being looked at, two extra nits from me:
> 
> 1. some trivial jump avoidance in inode_permission()
> 
> 2. but more importantly avoiding a memory access which is most likely a
> cache miss when descending into devcgroup_inode_permission()

Serge did maintain this for a while. But honestly it is an absolute
legacy eyesore from the cgroup v1 days. Somehow it was decided that
device permission management is a good fit for cgroups. Idk, I have
ranted about this in other places at length. No use warming that back
up.

They later decided to reimplement device access management as a
dedicated bpf program type. That imho is another bad design decision.

What should've happend is that device access management should've just
been implemented through the bpf-LSM infrastructure. That way all this
stuff would've gone through security_inode_permission() instead of us
having to have two separate calls in inode_permission().

I would love to kill this call. And cgroup v1 is deprecated and systemd
has dropped any support for it last year as well.

> 
> the file seems to have no maintainer fwiw
> 
> anyhow I'm confident the way forward is to add IOP_FAST_MAY_EXEC (or
> similar) to elide inode_permission() in the common case to begin with.
> There are quite a few branches which straight up don't need execute.

Yes.

> On top of that btrfs has a permission hook only to check for MAY_WRITE,
> which in case of path lookup is not set. With the above flag the call
> will be avoided.
> 
> Mateusz Guzik (2):
>   fs: touch up predicts in inode_permission()
>   device_cgroup: avoid access to ->i_rdev in the common case in
>     devcgroup_inode_permission()
> 
>  fs/namei.c                    | 10 +++++-----
>  include/linux/device_cgroup.h |  7 ++++---
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> -- 
> 2.48.1
> 

