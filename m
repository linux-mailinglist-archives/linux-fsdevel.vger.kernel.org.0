Return-Path: <linux-fsdevel+bounces-57038-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD60B1E3E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 09:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF5584E122D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 07:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C46A24EABC;
	Fri,  8 Aug 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gcjae70U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B899F23770D;
	Fri,  8 Aug 2025 07:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754639565; cv=none; b=fhhFZgdPpPFc5eoAtASAQKY+/vrOVEamR5KvmSpmMfwO2QWCkj2PWra48k3tJn7Y9Ty1JDsaq5tOhnt5ZaqzGuJ8wVWczCutxps8BfJaHrmrRW+TLcAD2W3IvdOli6rJBcpO4gpIpGxw2BvRMwycLhMayIlzKvhYUp6DvXASXM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754639565; c=relaxed/simple;
	bh=aFZOUjbypyPKl0TFuINBnJc9WdlC2i2xJ38sK2wE14c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pme80Z5Rmqf5cKJIrWNR7blaPFUnFmBPLdPYfKYqwJxtlrE6MOCZXGNoEWFk4l++uaTG4cErkcAEPC5Qr51Ft2jr3WOrtXVvSy5NKRwiv741HzTPAbZsdppLOMIvNsgS0cJBwsejkPT4qnOBFnMOIOoFImdaAGwFYO3ygLfb7ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gcjae70U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E5FC4CEF4;
	Fri,  8 Aug 2025 07:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754639565;
	bh=aFZOUjbypyPKl0TFuINBnJc9WdlC2i2xJ38sK2wE14c=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Gcjae70UxJUnM90h9PPGlfEltQYNTgMu64wWwOR9p1qaYCHOUU72wXbeK/DV/EMOl
	 jfz3QPLP1vE66gpTrxYpjCefdmze+Aii8IOOQ7GBDWwv8vf/X1O6UurUikurcXugzn
	 gtB/Hsk912I8/VWfxyngUK2Z5AyeEOrPZfqhEMlKriF4l0qWlIMmhd+7Yc7XCn+Bqq
	 aa8XTqC9euOBP5nV2DmDXrqDGhr9HPY/ccXyYOlVWkjimExYXxScyThqeJLEEVUh8H
	 VMkOPo2iLb//D8DpnSP2EmrnvQzeK0pBxqeXrI8tySfOcW4UJk1eFe7HrAK7iU3v7x
	 TbHikD1MsWhgg==
Message-ID: <c08243fc-06fd-4d7e-84e3-f231e97fe451@kernel.org>
Date: Fri, 8 Aug 2025 16:50:07 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] zonefs: fix "writen"->"written"
To: Xichao Zhao <zhao.xichao@vivo.com>, Naohiro Aota <naohiro.aota@wdc.com>,
 Johannes Thumshirn <jth@kernel.org>,
 "open list:ZONEFS FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250808071459.174087-1-zhao.xichao@vivo.com>
 <20250808071459.174087-7-zhao.xichao@vivo.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250808071459.174087-7-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/8/25 4:14 PM, Xichao Zhao wrote:
> Trivial fix to spelling mistake in comment text.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Please squash this with patch 5/6. There is no good reason to have 2 patches
for typo fixes.

Also split this into separate patches for each FS. The entire patch series is
not going to be applied in a single tree. The different FS maintainers wil (or
not) take the patches for their FS in their tree.

> ---
>  fs/zonefs/super.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
> index 4dc7f967c861..70be0b3dda49 100644
> --- a/fs/zonefs/super.c
> +++ b/fs/zonefs/super.c
> @@ -268,7 +268,7 @@ static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
>  	 * Check the zone condition: if the zone is not "bad" (offline or
>  	 * read-only), read errors are simply signaled to the IO issuer as long
>  	 * as there is no inconsistency between the inode size and the amount of
> -	 * data writen in the zone (data_size).
> +	 * data written in the zone (data_size).
>  	 */
>  	data_size = zonefs_check_zone_condition(sb, z, zone);
>  	isize = i_size_read(inode);
> @@ -282,7 +282,7 @@ static void zonefs_handle_io_error(struct inode *inode, struct blk_zone *zone,
>  	 * For the latter case, the cause may be a write IO error or an external
>  	 * action on the device. Two error patterns exist:
>  	 * 1) The inode size is lower than the amount of data in the zone:
> -	 *    a write operation partially failed and data was writen at the end
> +	 *    a write operation partially failed and data was written at the end
>  	 *    of the file. This can happen in the case of a large direct IO
>  	 *    needing several BIOs and/or write requests to be processed.
>  	 * 2) The inode size is larger than the amount of data in the zone:


-- 
Damien Le Moal
Western Digital Research

