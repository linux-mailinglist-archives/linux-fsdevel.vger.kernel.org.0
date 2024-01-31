Return-Path: <linux-fsdevel+bounces-9632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51358843838
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 08:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA2B28A176
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 07:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4855C2A;
	Wed, 31 Jan 2024 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dp4Twq6P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C254BD8;
	Wed, 31 Jan 2024 07:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706687297; cv=none; b=d3VTJKiksDm1q4BQhPFfca1uEpaTU2S7FzyUUtT7iAXhFuFNfNSs/S+eFQ5nbzTo9bRnmjPreifSObmthE3RC7Ae7Jam7qaXH9nAT1Muhm4xb3y1DhaIoaN5SSZB+snlcwPGGCgez5y3khKzOQ/YVdBx8JD0EOECa2szIaVq5Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706687297; c=relaxed/simple;
	bh=06WGDoLX8yDITF7a8+fQgdkm7H3ULEhjqhrhgumMIs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jk7Ab13bNSm4PVG+MrcVvyQX1EKkBUYrIT2v97bvVVPx9zeGjNesRol+hShISXPUoO2egVsxDQOYLyebOInD4Rxa0ypyHfnCc22bTzQRmBZhdIq0YL2FI7qPm2ihDi8HunNMuLEwBNPdnLGussfEnGa5Em6E8DM6Gw/81Z7CEVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dp4Twq6P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312CDC433C7;
	Wed, 31 Jan 2024 07:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706687297;
	bh=06WGDoLX8yDITF7a8+fQgdkm7H3ULEhjqhrhgumMIs4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dp4Twq6PrCD2QPM1fsvZ+XzJeS1xy6EFoG+wOWNPCjAJWJI4Hm3e3k2fzh4LXDMas
	 mcRky2AgRS/m976rgTRb8BjmpyIkT6Y2wZRkAwhKGOg0jJxeXUd5gsrDtxztNFQ4ny
	 OX/7QYTKFlWbdhg1+diNDCbjwGfyRkCaYY3Bd/SNzdw7tRwCYJVQ5ppLkum4UruP9j
	 9bUH1KDoP9WVVJRlWiagfoVFP7rx16WzWPm+Q8QitWWH7W0I0kyEBVRQzyGRbU0H0k
	 bT+kGK3oMusqRhpBrDZAV/7oMODrAlDg9kXTTFAebYhieDYD+QTuHXLMi23gqjWnT0
	 6YGriombf4yOQ==
Message-ID: <d521c9fa-5c03-4706-a8f5-badc9b18fbf4@kernel.org>
Date: Wed, 31 Jan 2024 15:48:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 04/19] fs: Move enum rw_hint into a new header file
Content-Language: en-US
To: Bart Van Assche <bvanassche@acm.org>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Daejun Park <daejun7.park@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
References: <20240130214911.1863909-1-bvanassche@acm.org>
 <20240130214911.1863909-5-bvanassche@acm.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240130214911.1863909-5-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/1/31 5:48, Bart Van Assche wrote:
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 65294e3b0bef..01fde6d44bf6 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -24,6 +24,7 @@
>   #include <linux/blkdev.h>
>   #include <linux/quotaops.h>
>   #include <linux/part_stat.h>
> +#include <linux/rw_hint.h>
>   #include <crypto/hash.h>

For f2fs part,

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

