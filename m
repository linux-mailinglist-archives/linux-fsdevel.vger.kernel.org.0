Return-Path: <linux-fsdevel+bounces-25712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 511F594F655
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 20:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D90A282695
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 18:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CCF7189B90;
	Mon, 12 Aug 2024 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7D9ZS0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CD1189901;
	Mon, 12 Aug 2024 18:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723486267; cv=none; b=TM/OdZ7RtHX/z1KP0u8ulF79FLO7Esbb/11z9AuyIuzCbQzBdA2SvtdfdRrhM2BNVkVELZTb5SV/f42jgBqkVA2VdN08eaBL16itOnkmtJBzerKjKAIQBGrccKDzkGnMmbgmmkn5PEpGWbyUge+U5/jasgJ1PIBiNGpLIDdKNzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723486267; c=relaxed/simple;
	bh=ZVRPl+oUbUeZNFYGsYvw6NQV6Ujil4pDrcbEjyfW6+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sJsCcuctIkfYap6MHaNy+vXvHN5jhcQDKhjt114H93d0V6HPDB+biAjiRZ18hMtCNLmI6HVMA6JSahpUfLwdQCZTvv1gqNa3afkaFhrgHJY7MlX/DIlCZFmpsh+XeCwKlQOhH2LRpnGBZWjZY2adIdvex3OVuGWR4Rriajcw/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7D9ZS0D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A9FC4AF09;
	Mon, 12 Aug 2024 18:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723486267;
	bh=ZVRPl+oUbUeZNFYGsYvw6NQV6Ujil4pDrcbEjyfW6+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T7D9ZS0DAxfqCywK9pY471dRmTVqG9b4x/AXpEQXoyTBSfhwkvG7qNHVQkknGMhER
	 aGu2pGoxX1DCaqMWoQv1FIn7jhDsvqdlHoIK2AnU/Op5ry6T9/fdFYGoNjwla8zjS4
	 T8vvGxInWKWbwDST1AU4RvDeNu2mEKE8QwvgvvbPVGDIVsfPgvuZGgpH3nlIMLCKMe
	 VctzfoTQJeFsEvUbP2WZ9XwhOOEqf5vZW6juntg4rnn7M/lqKwiOo19pf3vpeq8apG
	 3g1ESTYY05cynUjshVDPhxd33qk3bMxOGXDaZ/gCs42LNNkcgXDcCIROOpDpnP7lQ4
	 utuXnFekH/JXg==
Date: Mon, 12 Aug 2024 11:11:06 -0700
From: Kees Cook <kees@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Joel Granados <j.granados@samsung.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: update comments to new registration APIs
Message-ID: <202408121110.C3838E62@keescook>
References: <20240810-sysctl-procname-null-comment-v1-1-816cd335de1b@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240810-sysctl-procname-null-comment-v1-1-816cd335de1b@weissschuh.net>

On Sat, Aug 10, 2024 at 07:00:35PM +0200, Thomas Weiﬂschuh wrote:
> The sysctl registration APIs do not need a terminating table entry
> anymore and with commit acc154691fc7 ("sysctl: Warn on an empty procname element")
> even emit warnings if such a sentinel entry is supplied.
> 
> While at it also remove the mention of "table->de" which was removed in
> commit 3fbfa98112fc ("[PATCH] sysctl: remove the proc_dir_entry member for the sysctl tables")
> back in 2007.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Thanks!

Reviewed-by: Kees Cook <kees@kernel.org>

If you're already poking around at these things, it might also be nice
to add full kern-doc for these APIs and structs.

-- 
Kees Cook

