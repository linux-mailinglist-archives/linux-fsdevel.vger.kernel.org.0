Return-Path: <linux-fsdevel+bounces-21925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 089B590F074
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 16:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99D7CB22FFB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 14:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780B71CF8A;
	Wed, 19 Jun 2024 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyyJWt80"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB96C125AC;
	Wed, 19 Jun 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807291; cv=none; b=sxbRvLAuHxATfdREcw10oZ7Mk/7yvy0bcvTlnEGXrDgBAetzcVwAmZ8c6qCXgzB6pppxYjZEImSswztyy42y8ARYkDuWOFp9c2WZm/ZMw79TtoV1VAG3/lYODDI8O7nr0R3cN39jpYbRAiJc7bHKjQahoncFOoOEI8sTbj6VDks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807291; c=relaxed/simple;
	bh=Nq4eUo/iRJU/uyl3ZEzcLHaTIVBPbEBT4zIoehH7PXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lvl2F9Fxi8rCmXU100HGjVxRTYOrbRSp7jZYuuJEJN1Y2aBFQDt0GgtVWgqIAU+vvKjni1z9NIHX2WstuDnPHB2bZyWcCC83hUJU493rKsqHdzQj9m5v8gn6MfbjLsGLlY8dQ78sMDUiOKzhJBHwSNNw98M5c6YxHplKY0Mdr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyyJWt80; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38232C2BBFC;
	Wed, 19 Jun 2024 14:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718807291;
	bh=Nq4eUo/iRJU/uyl3ZEzcLHaTIVBPbEBT4zIoehH7PXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HyyJWt801UJer2LJ9uI7WwcSz98nXOPb0N/1+5+Jj0n2/5gBIMbGxa5fJ0b0WmE88
	 xNvyA+9DYYO6eXDdOBJA8P7rJ8ucqKVsT1lrcFkom3bCi5D38SsIY8rNsgGbhdZ8v0
	 Icu88cenoXZ034mzz6Fp2pAosS6x7x+0ZkWziDBHXrcY0pW5LgFu7I3WZG/T/8xySe
	 CoH0j+Vi4kjenZb6JY1frN/DKjzjw+41EyUiMMF8fQ36L0I5jqGi8vAN2XNmEYWaMy
	 Btfek4OTRHj3ipVhzZsIOhiw5AWfaL+ZbigyMz3eIrQ1UJQHMajnMTj7HpgIHrL+c9
	 i87seUUn0lYow==
Date: Wed, 19 Jun 2024 10:28:09 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Kees Cook <keescook@chromium.org>, y0un9n132@gmail.com,
	viro@zeniv.linux.org.uk, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH AUTOSEL 6.9 12/15] binfmt_elf: Leave a gap between .bss
 and brk
Message-ID: <ZnLq-Z-H4DyW6S_r@sashalap>
References: <20240526094152.3412316-1-sashal@kernel.org>
 <20240526094152.3412316-12-sashal@kernel.org>
 <B4568D76-34A6-40F2-936A-000F29BC42B1@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <B4568D76-34A6-40F2-936A-000F29BC42B1@kernel.org>

On Mon, May 27, 2024 at 09:32:13AM -0700, Kees Cook wrote:
>Hi,
>
>Please don't backport this change. While it has been tested, it's a process memory layout change, and I'd like to be as conservative as possible about it. If there is fall-out, I'd prefer to keep it limited to 6.10+. :)

I'll drop it, thanks!

-- 
Thanks,
Sasha

