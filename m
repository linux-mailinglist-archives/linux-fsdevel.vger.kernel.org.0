Return-Path: <linux-fsdevel+bounces-25272-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7350C94A5C5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 12:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F39F2826A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 10:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A12C1DE865;
	Wed,  7 Aug 2024 10:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtMDhtAq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F541D174E;
	Wed,  7 Aug 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027145; cv=none; b=bdve5o6Dr96jynwkMnlPTbwP29egPXT4Pt92LVjITSZLtsz+NxkHqrtJD1T1Xa1+hN6pR1ti0WCZrD2Fh8KPaXPROTrsUIgXazey+ZYBrHjbPGU8hH6mF5v44XIZSMv2hsx7azgMqrkTYGV/fZ9324sCPUZrmVMnwprL8HwL6VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027145; c=relaxed/simple;
	bh=jL7GKmmxJf4NXkvf5qY4FgEveAyHwXoFw9NdywFs14A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEG8Jbp298UKMPSRMZ9zPmIKL8C7oZieNFDIVF8Xk/G8g5CNrOMLbmHLh1wFoJbiWu4Tn2HUGeHUXOQTxxfSTSYriFjRHgRMAECrIDod4AYlujJK3DoVqQdQ0MF3Vy0wKPrwpDzifgJLjRyMabsHh2j7YGTk+8a8674jU3ij6zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtMDhtAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB2DC32782;
	Wed,  7 Aug 2024 10:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723027145;
	bh=jL7GKmmxJf4NXkvf5qY4FgEveAyHwXoFw9NdywFs14A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MtMDhtAqMsdCxK/q5EI6L9pNfNS/0Z6kuBctaFK6DgiBKMMfMdL6wFQZuCHNBB+hF
	 /ovmxuXcAKR/VTa3YaWUQNftwFCoz4NIL9XV24H7PBzNOMaufag4ILaqBZMH6O3mua
	 XN7ijHZ7Npj3hWhOg+j3aDWC9MEBL1IbG/ELlp/4hz6FDTwYInfPteUdLFVeM56yzY
	 NbjuErbQdcKZ9M6PI7Q8jiDlWBn7ziR4ooxkjh4MYW9EbGK099Lo2L+hVx57KSeIWV
	 ZCzBqGG495RI4tFECA1/G3trs1K01eN5jBZa0gJIwvtB5tDM21P2RIGkRF11/dMobA
	 B+eSxZDNv9Ztw==
Date: Wed, 7 Aug 2024 12:39:00 +0200
From: Christian Brauner <brauner@kernel.org>
To: viro@kernel.org
Cc: linux-fsdevel@vger.kernel.org, amir73il@gmail.com, bpf@vger.kernel.org, 
	cgroups@vger.kernel.org, kvm@vger.kernel.org, netdev@vger.kernel.org, 
	torvalds@linux-foundation.org
Subject: Re: [PATCH 24/39] fdget(), more trivial conversions
Message-ID: <20240807-jurymitglied-labil-a5b1a8911d52@brauner>
References: <20240730050927.GC5334@ZenIV>
 <20240730051625.14349-1-viro@kernel.org>
 <20240730051625.14349-24-viro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730051625.14349-24-viro@kernel.org>

On Tue, Jul 30, 2024 at 01:16:10AM GMT, viro@kernel.org wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> all failure exits prior to fdget() leave the scope, all matching fdput()
> are immediately followed by leaving the scope.
> 
> [trivial conflicts in fs/fsopen.c and kernel/bpf/syscall.c]
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>

