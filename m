Return-Path: <linux-fsdevel+bounces-20204-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A83A8CF868
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 06:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43B51F21782
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 04:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B329DFBFD;
	Mon, 27 May 2024 04:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7vorj9w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227D2E560
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 May 2024 04:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716784502; cv=none; b=OpITrOhC4s8yFSBB/AdYTNj8rnFvBaRiFwE587uEyznUUtDc3Tb4rAOmCcdmHBpfBI7ZZV98wgcSa7coIopNuFgU4vdMXm1BbiuI+6IDBLZ6IZvvj2xL12ynsHCswNRwt7mXJ0gOeaBvweI+YhcyJPsfF2Ua2jb4lwtxKQOpngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716784502; c=relaxed/simple;
	bh=pWZEwmGO8+zO3h/Y6Pgl3dWoKj15o6LckpahmD7Ce4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uD+K1dJY60odJthL6L7EsRo8Q3lbpIO59RLVmOltUL3bAeYShLI8uKWwM9YNGwUfcslsmmSv1Am8j5BY9IX/PNMGcYB58kDRPdVRFl6tecEWwV8kDZW22vMpt+kxPfgR9mof2Puqc6lvAq7q4z39UpomwUHRU8nvHwD2XdrpMKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7vorj9w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F0BC2BBFC;
	Mon, 27 May 2024 04:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716784501;
	bh=pWZEwmGO8+zO3h/Y6Pgl3dWoKj15o6LckpahmD7Ce4g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y7vorj9wxJsvSdlux37yNahRDAc/cr6l9a3+eOewLYYPiqkzTfpJjkrSCclQkCC+M
	 kaaBPTs2a8bnAZd4RF4n1EtZ1fEP0vX6BynqRlYnWp329Nfc0ll4o3TF+d6/LPuAEN
	 2qwnl+UdppHFyG8+ou/git+wyz2ZZdDw9ouN43foODXcr/KP+gtZeVU7paeMcSDgiO
	 hafP74QHKwU1jTokrPOS7jM7xOcpqNckwQ+SFwMm3VeDaqWUpldOnvJZ5+JgmQdTtq
	 ViEHGKt191OLq2pANXKSnzOuir25DFpqJqK+bVURPMw8qpTmT+SVjaD1UW3kKcy3pL
	 JI0qTNE3ZGhNA==
Message-ID: <f547825d-45e2-4272-9d98-44d0c0bec331@kernel.org>
Date: Mon, 27 May 2024 13:35:00 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zonefs: enable support for large folios
To: Johannes Thumshirn <jth@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20240513223718.29657-1-jth@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240513223718.29657-1-jth@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/24 7:37 AM, Johannes Thumshirn wrote:
> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> 
> Enable large folio support on zonefs.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>

Applied to for-6.11. Thanks !

-- 
Damien Le Moal
Western Digital Research


