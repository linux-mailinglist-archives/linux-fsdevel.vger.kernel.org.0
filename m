Return-Path: <linux-fsdevel+bounces-47685-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01513AA3FC2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 02:48:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68D85166203
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 00:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E779A933;
	Wed, 30 Apr 2025 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUPS0qe+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F781BA36;
	Wed, 30 Apr 2025 00:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974079; cv=none; b=l3ToKQY5Yv76maEg19+vDyhAJPBM/GY/95L6teIXrLu0Hlwim0XNhlB4dBBkIISknOjmLdhwYWYhKFYmKk4RgVE27+MZ17KUN5hLYsIyRqXS5YwHR7H3i8Nnu4cgYHk64+Gppq1Q5j6EYGwrUXda2knf1PCHjIbXrVhmdl3O3DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974079; c=relaxed/simple;
	bh=hBSadbP7nj7FT5C28fQId9ayVrOGTRXS27Zvb2Wblqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Izq0MvOTFG902+lDGsHRJqtwt2RZPWwR70HpcpJELX4MWR5EpjhwXQYpOhdkfNh9eUqe4sbdyMOi2FoStEcdZc1Dz1LH/g4vAw2R+Fpwu6lrg48re/rZsLeveY6PoyhJfdyd6ARpNwN0gO2Qa53MVQGojHnRZn2AcrORJ4B2TEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUPS0qe+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF311C4CEE3;
	Wed, 30 Apr 2025 00:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745974079;
	bh=hBSadbP7nj7FT5C28fQId9ayVrOGTRXS27Zvb2Wblqo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUPS0qe+JA/yCZC0wShHeICptWuj3iHXSby2yVwAjpgpaaPkR3CJywruoicsFRu9/
	 slxM45I3WO02K5jJH8r/c0G16b/KhQfNtHAjZUY47PXJEUOqUulVAqK6NpXJL4WQ1n
	 xlzL7Vp9CyNtDpytPfzXOLIz+TuyhqWr43LZ1c/1R3X2p+lhKbS65eC+rYgAXdQxKb
	 UGqNHbORrloT99fE9s8G9tkH8cYg2evpHgWZZuH0ZhtkghLQlALu0LlJI46QES+0Q8
	 1ASl59zpfbPu5XqpQ/7bPK5S+A+cUs+EUrHkYRcPb9WqG3jUCaRFQI9otOO5xDETPA
	 NJsVv91jNMcmg==
Date: Tue, 29 Apr 2025 17:47:57 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>, Jan Kara <jack@suse.cz>,
	kdevops@lists.linux.dev, Christian Brauner <brauner@kernel.org>,
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.14 26/39] fs/buffer: split locking for
 pagecache lookups
Message-ID: <aBFzPSBJAgOuCMnr@bombadil.infradead.org>
References: <20250429235006.536648-1-sashal@kernel.org>
 <20250429235006.536648-26-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429235006.536648-26-sashal@kernel.org>

On Tue, Apr 29, 2025 at 07:49:53PM -0400, Sasha Levin wrote:
> From: Davidlohr Bueso <dave@stgolabs.net>
> 
> [ Upstream commit 7ffe3de53a885dbb5836541c2178bd07d1bad7df ]
> 
> Callers of __find_get_block() may or may not allow for blocking
> semantics, and is currently assumed that it will not. Layout
> two paths based on this. The the private_lock scheme will
> continued to be used for atomic contexts. Otherwise take the
> folio lock instead, which protects the buffers, such as
> vs migration and try_to_free_buffers().
> 
> Per the "hack idea", the latter can alleviate contention on
> the private_lock for bdev mappings. For reasons of determinism
> and avoid making bugs hard to reproduce, the trylocking is not
> attempted.
> 
> No change in semantics. All lookup users still take the spinlock.

This is pushing it. I would not expect this to go to stable. At all.

BTW you had mentioned the code for auto-sel would be published a while
ago, is it available anywhere?

  Luis

