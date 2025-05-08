Return-Path: <linux-fsdevel+bounces-48443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DC0AAF2D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 07:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8151BA54DD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 05:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31282135A4;
	Thu,  8 May 2025 05:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkKcndVC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54649212B31
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681876; cv=none; b=E0R4tyGE0FHCnoe0ya+4i3J6PnQc+hTJnapPpgkukeS742d0Ydmspp2xd11/je/OZKCJLkRort3uj2ajigBVgiWMOl+r81SyiYD1V3ErvzEQlxhURa+V1SsDSwKL/1x/hHaNNS5zsIurr3WNhcXXT5swIlCCt2K3EL/xC3txH9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681876; c=relaxed/simple;
	bh=3sYe3SmDr32t4jdhPdpNaRqMy/gCrEWYAFqENM23+Ck=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qbUOgj0uAvIBsvGiybyk8qRTLpiFyqkFgC45jIGdvHFoCIH7XC9q/Pd3EeWB4ffQS0hWg5sW9vRx0zkY+v6CRQams/t7jb3hLvmSTlXUDmthDyncYcI/kFUFBuibm+UKNOJ8RhhfSpfsii2aeSotemYNDeNO/BVuzeVKF6sdQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkKcndVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD5EC4CEEB;
	Thu,  8 May 2025 05:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746681875;
	bh=3sYe3SmDr32t4jdhPdpNaRqMy/gCrEWYAFqENM23+Ck=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=nkKcndVCogLG2QFxCShVKwWUcJz8xGvEWSYkRNmvM4xLuumnKVyoxdK0n+bRWaOHH
	 69NynTzXm41IkDnHNnGz4Hiv8U94iEXY+/TL9GE8OXBVfoS0AiqGVjy/k1C9SwNiS9
	 0Mxov+V4kN/yu32FWbBq7Y0ixBYSkQ+4onq5ojritBQ2tKziBviyCXqgLQl0vqrkxg
	 /JsUXuDhXTf5kmJbGpcr8Dsb8rqy4435zWlWKgVrbmAomXWqthsC5IqEPoMvCkUK8J
	 Pb/5yQ7R/fFvuPslzaF7UrSSVWOXh/skb3Xrc5mZ47V0MVuGPPG+rSQ81TAY9kGZJC
	 +TSa50/mAXxKg==
Message-ID: <d747da62-d8ea-4e92-854d-50e8c849cb11@kernel.org>
Date: Thu, 8 May 2025 13:24:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 lihongbo22@huawei.com
Subject: Re: [PATCH V3 1/7] f2fs: Add fs parameter specifications for mount
 options
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250423170926.76007-1-sandeen@redhat.com>
 <20250423170926.76007-2-sandeen@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250423170926.76007-2-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/24/25 01:08, Eric Sandeen wrote:
> From: Hongbo Li <lihongbo22@huawei.com>
> 
> Use an array of `fs_parameter_spec` called f2fs_param_specs to
> hold the mount option specifications for the new mount api.
> 
> Add constant_table structures for several options to facilitate
> parsing.
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> [sandeen: forward port, minor fixes and updates, more fsparam_enum]
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

