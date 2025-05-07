Return-Path: <linux-fsdevel+bounces-48339-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB6AADBEA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 11:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7950B18958A3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 09:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAF3202C26;
	Wed,  7 May 2025 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGnUVN6m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16076142E77
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611662; cv=none; b=WTypYHIBsggrfOOQp1F5VCe8bGP0Uq8IwkmmcpOQBmJBEYQamXFi82cWdhr3RcF+1ZYUI+5Gt5yqR8Bu/X1LQMgyLHVg2gWaf3xs/LSH5/xw0AMA5RWsq35cB+LKJt+wFbA+sVHKZ1d/WqbMyzkXpydbth8X+ajnE9m/HV2PsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611662; c=relaxed/simple;
	bh=L2Qq1OqoTTdxJFZxrpMedyp1KS/00lHhR1Hf9y1xqwg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZVU/8jgAxVwjZstey77JMkV0/FN7hobg3sGBmdw40AIHii7MbwsC7ewY6QAO1y7aLq6ArKit51L/Geo3ZDOebipACdAxuHWyZZAMoUFYsp8jfu1QQHnsarI7vfX7oIFICDzq5gIdypIqLevOJGZ1NoXELCN3JLJw5iGxEQZeT0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGnUVN6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DBAC4CEEB;
	Wed,  7 May 2025 09:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746611661;
	bh=L2Qq1OqoTTdxJFZxrpMedyp1KS/00lHhR1Hf9y1xqwg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YGnUVN6mZxuGKasTKmatgpnUtGBAqMamaDXGKkUiw3hN/gAZkoL1fyWM4wO7DRz60
	 i6k0BdHcVy30wUrzmw/eDu0n7Amwxvvqu8Wjeju/PvoNhrvPHJpymvS74mvOx2vzFe
	 ftLRSB9s4WXxFQdlAdN4wtNIf5hcg1FPVGcKbkii5Bv6ipPVEmgAJ3xFtfmkt4f9/H
	 bbagiaseM1b5Uw1Lm2XmDydAG+YVOYTYe2Y5y08n7L2K9LyfNj2lz8LlI2P8lf3QgS
	 FeoOarkVpYByP9MC8XHZvAUeix7fbM43UtpoDfwVgysYoUphukY0QZeuNUxqsi/BjT
	 j+B98uG2p9y4Q==
Message-ID: <04099a70-c0b0-4bd5-92be-07694d9a1741@kernel.org>
Date: Wed, 7 May 2025 17:54:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 lihongbo22@huawei.com
Subject: Re: [PATCH 1/7] f2fs: Add fs parameter specifications for mount
 options
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250420154647.1233033-1-sandeen@redhat.com>
 <20250420154647.1233033-2-sandeen@redhat.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20250420154647.1233033-2-sandeen@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/25 23:25, Eric Sandeen wrote:
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

