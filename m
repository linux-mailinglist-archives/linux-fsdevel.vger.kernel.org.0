Return-Path: <linux-fsdevel+bounces-55723-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0222CB0E3F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 21:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15739548075
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 19:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF2B284B25;
	Tue, 22 Jul 2025 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gxWj4jDA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D65288D2;
	Tue, 22 Jul 2025 19:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753211636; cv=none; b=p9giZ2WnlkB2zq1uk8j/fryIPmxVwglPz9gxn0TLh4vk5Qv4C6Q6nxasMxC94ueHgyPYzPHEXddVskM1FSXOGJ39qDSWtMqMQfYEKIR3RkP/tq7krpVoyfcoLethDv7J8CenfhHhw6UWeGkL2ZXyOV6DxM7LtqYc2qTkN6uZWqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753211636; c=relaxed/simple;
	bh=0EuugrkrBlpRqCWS7McbxPFzDZQsPFsRD6mdCH+rCGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmsuHEf/6r5BuOr7u5JpD9hNSzbnbSjH0hH6ZJwLfUCX+cXYcZF7qK2vMd1CAiy7U52sfUFeOTN420ugp2a0Lq9yqFsF13pQYJ90eHHWdlSTr1fL2po2SoyMi/e5b+DOhEfbmTxQvAD2PbGZHJzyhGzdoKQQqYNmR02ifeSiY2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gxWj4jDA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=/216nD51ISG76vJeyhe0hrxPDFgEf0wLEtVdTj/HHE0=; b=gxWj4jDAeHzLCIHCxYpm2OJb4i
	5WOPwnXyb5Z9q4wS0IL8NS04SiIoIVqt7k95cFBvSjuZCKGJv/MePSJaWeuuXf4H3/uFhSSm4GeXr
	9/8TAF8F1FlYQsKlH71IcdfEuiXyTyCC4NVmBGy3FXGRaSW9TggQUuCCuoq0cQXmVJgE5nR/a1X6t
	Nb/rl+JpvFTnTPZY+OxCe0q+hJABZIgkQ4R1hrnq2mjEzN+jH2r+IptZmCkiapbf/E1H/jAKKW7en
	9A44cAOxBj31fbJfp9DvtIaKRhRxGsaSC9JVV7FcZ3fuHQdZMeQGGseoRlvka/+mp15hDHNQs6MAa
	JPGx8Hyw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ueIQy-00000003KH3-3RsA;
	Tue, 22 Jul 2025 19:13:52 +0000
Message-ID: <a27c7d56-4446-458f-962d-699a52d464c3@infradead.org>
Date: Tue, 22 Jul 2025 12:13:52 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eventpoll: fix sphinx documentation build warning
To: Jann Horn <jannh@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 kernel test robot <lkp@intel.com>
References: <20250721-epoll-sphinx-fix-v1-1-b695c92bf009@google.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250721-epoll-sphinx-fix-v1-1-b695c92bf009@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/21/25 10:09 AM, Jann Horn wrote:
> Sphinx complains that ep_get_upwards_depth_proc() has a kerneldoc-style
> comment without documenting its parameters.
> This is an internal function that was not meant to show up in kernel
> documentation, so fix the warning by changing the comment to a
> non-kerneldoc one.
> 
> Fixes: 22bacca48a17 ("epoll: prevent creating circular epoll structures")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/r/20250717173655.10ecdce6@canb.auug.org.au
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202507171958.aMcW08Cn-lkp@intel.com/
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> This should go on the vfs misc branch. (Feel free to squash it or not,
> idk how you do that in the VFS tree.)


Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  fs/eventpoll.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 44648cc09250..02ac05322b1b 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2192,9 +2192,7 @@ static int ep_loop_check_proc(struct eventpoll *ep, int depth)
>  	return result;
>  }
>  
> -/**
> - * ep_get_upwards_depth_proc - determine depth of @ep when traversed upwards
> - */
> +/* ep_get_upwards_depth_proc - determine depth of @ep when traversed upwards */
>  static int ep_get_upwards_depth_proc(struct eventpoll *ep, int depth)
>  {
>  	int result = 0;
> 
> ---
> base-commit: 981569a06f704ac9c4eed249f47426e1be1a5636
> change-id: 20250721-epoll-sphinx-fix-9716e46a52e6
> 

-- 
~Randy

