Return-Path: <linux-fsdevel+bounces-64929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 484FCBF6C32
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 15:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10823504ADC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 13:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446713370F6;
	Tue, 21 Oct 2025 13:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3Elnn/5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00D8334C38
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Oct 2025 13:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053176; cv=none; b=imi6hLVhhIqL7r59ZaxvlExvt2V04dZfVJ/JxRTA3DIgUUlDQwRD0JM+21NGkhOpiXfLgkSspSYYu/09uAaPSUiiMkiWHnu2H4Nqt5W5dvKt5xL+4ehjJFgTxCzcyEBh13Hs4Oj+rT9FCM0ACB/14SBXmpSy7WEJy+gS38kFGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053176; c=relaxed/simple;
	bh=FmxFedcQLaCu9wc1pUpck2LtzTvRDec5m+R5LJo/qOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jq2e9prmbTIkyNAwYLA5OcU63OplJ/MrhlOYwJD+8OQZB0HhiiD78zWF6aMvJt2I3UEl95r3dWyoPmO4XOAC3+1/iVpAY4qW77QIm214mJYPEwcUE6eaTHCoFAeYVJq7ktfPu2D4OeBXg1NrCswpMeR8KDZdYtW2u3Dyv8kKvJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3Elnn/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8F4C4CEF1;
	Tue, 21 Oct 2025 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761053176;
	bh=FmxFedcQLaCu9wc1pUpck2LtzTvRDec5m+R5LJo/qOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3Elnn/51XYwZCEn8WhmxL4T/shuRqaw/ExVpKC+Y/ozWYHhPuLGk8EdBTLNTbT7o
	 XW/pbv9OiBhETK7s8DcnFgzsgm9uFDWvNiO8HVxjKR9OSGFebLzR595Cpvi9/LMlhC
	 3ZsI7kFCuuVRSbHssNgpsvI9zgBRq+N9frWVRNG14omp+5niecWH0eZnkKFOVWykWG
	 kh7dkOPqlgrp9rP6b05ERV0slHhBAtYE9PYiLIM0utrsSsW+LgLz3D32cweCv2HR3G
	 wSjUKOzjHBCjol9HYKAmurZC/B4b3gDDLKUf1zUQF6jeg3E0XQ1apKcWCXjrbgA/DJ
	 7G4DVr46iLidg==
Date: Tue, 21 Oct 2025 15:26:12 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Amir Goldstein <amir73il@gmail.com>, Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 01/14] debugfs: rename end_creating() to
 debugfs_end_creating()
Message-ID: <20251021-weltgegenden-falschaussagen-d8b2f8545d65@brauner>
References: <20251015014756.2073439-1-neilb@ownmail.net>
 <20251015014756.2073439-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015014756.2073439-2-neilb@ownmail.net>

On Wed, Oct 15, 2025 at 12:46:53PM +1100, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> By not using the generic end_creating() name here we are free to use it
> more globally for a more generic function.
> This should have been done when start_creating() was renamed.
> 
> For consistency, also rename failed_creating().
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: NeilBrown <neil@brown.name>
> ---

Makes a lot of sense, thanks.
I'll spare slapping my RvBs onto everything because it'll carry my SoB
anyway.

