Return-Path: <linux-fsdevel+bounces-51051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BF1AD23C3
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 18:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF1618813D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jun 2025 16:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D71215766;
	Mon,  9 Jun 2025 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="liblACo/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6761547D2;
	Mon,  9 Jun 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486273; cv=none; b=WJoZW6FTK39TubvSslOv0og1K9R3b3vMXAdqw0LCLsnssk9Xh4lpZb7Jca79LnmGZcv/c679EtQpznhTvg3sW+DEWmNmrXbKDStCqCzxou6ctG4huOAtoYdRZoI1oqEeTf4sUNzSuIqfhwODwYzkZUuEnYWSoRuaYSM1I3thRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486273; c=relaxed/simple;
	bh=hWLr32D3s7pBx9w975kBFatpanu45P5mHljDbthGdlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juJwpEWs+ftuFWbwFShzBKqnEOxVOPiosL9wDRxTiVjNd4WNFFYt1nkvsFbtp1vYe3Nk/LB26Si2Af8KCB3WSIkG8eS4KVcClo77UGJSCr+KoDfw/kaNdUwDMFy0eNWwVc5vtgLcviMUi8xf4mPPfRFxaEkwwBgytDG4cG6KOyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=liblACo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C8FC4CEEB;
	Mon,  9 Jun 2025 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749486272;
	bh=hWLr32D3s7pBx9w975kBFatpanu45P5mHljDbthGdlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=liblACo/gATNT5Exk0fL76aMH/NnquB8L3VgKqyyUEf5d1X20j8LxRnHiCo0MdsdE
	 L7qKH2OyY9B/WrvDKWQvevMFlMUDRVZUhD6CR/NByYp7f5Rn1ZKeKGiZnRMUT4X10h
	 YlRx41GERJwiJczu/d4AchypheForiTg67AQqUL8JraSpkSwx4yK6xMsN7S7/Jn0rI
	 dizCmviwWfn2yjKG3UyHUAuohahmCq84SE5nuIqDPqXNCX8fw2ywuPtcYnvjVu0Eck
	 Hl05bromDcl0tG15mRoCF7kenuRi1teqRRB3KZqO6MWhGrTj+t/vR++Nn8PZ3ayUaM
	 gV5Wed9pjBP3w==
Date: Mon, 9 Jun 2025 09:24:32 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, bernd.schubert@fastmail.fm,
	kernel-team@meta.com
Subject: Re: [PATCH v1 2/8] iomap: add IOMAP_IN_MEM iomap type
Message-ID: <20250609162432.GI6156@frogsfrogsfrogs>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606233803.1421259-3-joannelkoong@gmail.com>

On Fri, Jun 06, 2025 at 04:37:57PM -0700, Joanne Koong wrote:
> Add a new iomap type, IOMAP_IN_MEM, that represents data that resides in
> memory and does not map to or depend on the block layer and is not
> embedded inline in an inode. This will be used for example by filesystems
> such as FUSE where the data is in memory or needs to be fetched from a
> server and is not coupled with the block layer. This lets these
> filesystems use some of the internal features in iomaps such as
> granular dirty tracking for large folios.

How does this differ from using IOMAP_INLINE and setting
iomap::inline_data = kmap_local_folio(...)?  Is the situation here that
FUSE already /has/ a folio from the mapping, so all you really need
iomap to do is manage the folio's uptodate/dirty state?

--D

> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/linux/iomap.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iomap.h b/include/linux/iomap.h
> index 68416b135151..dbbf217eb03f 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
> @@ -30,6 +30,7 @@ struct vm_fault;
>  #define IOMAP_MAPPED	2	/* blocks allocated at @addr */
>  #define IOMAP_UNWRITTEN	3	/* blocks allocated at @addr in unwritten state */
>  #define IOMAP_INLINE	4	/* data inline in the inode */
> +#define IOMAP_IN_MEM	5       /* data in memory, does not map to blocks */
>  
>  /*
>   * Flags reported by the file system from iomap_begin:
> -- 
> 2.47.1
> 
> 

