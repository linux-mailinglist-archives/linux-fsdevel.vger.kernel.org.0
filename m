Return-Path: <linux-fsdevel+bounces-13067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0093B86AC62
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 11:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F01C2210D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 10:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B487712BEAB;
	Wed, 28 Feb 2024 10:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="JBD0lrdE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CCF1F608
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 10:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117419; cv=none; b=nho8Qb2c7b2gmXSyejP/5R0EjmGINaT+HHoyRAxiMQHhRdsydoCFZYU11KVD4YJBTHzMNbnp7Bj1FkSJBLDUPoKIT5EC0ARBSS1R38zJej8r+KDASpmifx8+vGocp8fOEa3NpOsjWkJGHmFTk8Y/quku2eSdGLBCDw2yo4KKsB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117419; c=relaxed/simple;
	bh=+Yd5/7mfx2pIxhEIYX0pVffp6DYHAHwcpSgcAmTueUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u9cFyilXMOM6RlqgxJ4AU9o+/i5R98+5J2wLBjIMZMZv6HetsAQpEitSW+M1rWdaYFBqnkd4iY7pqEjgn5U3y3CFkbQwV5vdjJ9fOJT5HCPelQmKzWZSsYLwnuKnnjTmBWRt+xP1XpoURYUk0XUHUX6hJ6o7iQIoJfvaiIrHIzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=JBD0lrdE; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709117408; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XMv6jSQcyNCByRIaTyUh8VG14rrVMpUGdpmCQP4IWFA=;
	b=JBD0lrdEUUhXWXEJWcX10pu40PiRAzsHFxRRayDcNrGrdO7+CPPIbEakJgfD0kCVcBm8n2R3OIGbXXcgJyqATck2NrIROs5ASGWxd7POL6GF630U/1+RVYMNWrY7tSJmjfrj4yyJWK4STUCBxrBsVh+HlEFgicerImfvqyhCyc0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W1PjCxT_1709117406;
Received: from 30.221.148.87(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W1PjCxT_1709117406)
          by smtp.aliyun-inc.com;
          Wed, 28 Feb 2024 18:50:07 +0800
Message-ID: <450d8b2d-c1d0-4d53-b998-74495e9eca3f@linux.alibaba.com>
Date: Wed, 28 Feb 2024 18:50:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 3/9] fuse: implement ioctls to manage backing files
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
 linux-fsdevel@vger.kernel.org, Alessio Balsini <balsini@android.com>
References: <20240206142453.1906268-1-amir73il@gmail.com>
 <20240206142453.1906268-4-amir73il@gmail.com>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20240206142453.1906268-4-amir73il@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Amir,

On 2/6/24 10:24 PM, Amir Goldstein wrote:
> FUSE server calls the FUSE_DEV_IOC_BACKING_OPEN ioctl with a backing file
> descriptor.  If the call succeeds, a backing file identifier is returned.
> 
> A later change will be using this backing file id in a reply to OPEN
> request with the flag FOPEN_PASSTHROUGH to setup passthrough of file
> operations on the open FUSE file to the backing file.
> 
> The FUSE server should call FUSE_DEV_IOC_BACKING_CLOSE ioctl to close the
> backing file by its id.
> 
> This can be done at any time, but if an open reply with FOPEN_PASSTHROUGH
> flag is still in progress, the open may fail if the backing file is
> closed before the fuse file was opened.
> 
> Setting up backing files requires a server with CAP_SYS_ADMIN privileges.
> For the backing file to be successfully setup, the backing file must
> implement both read_iter and write_iter file operations.
> 
> The limitation on the level of filesystem stacking allowed for the
> backing file is enforced before setting up the backing file.
> 
> Signed-off-by: Alessio Balsini <balsini@android.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

[...]

> +int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> +{
> +	struct fuse_backing *fb = NULL;
> +	int err;
> +
> +	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
> +
> +	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
> +	err = -EPERM;
> +	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +		goto out;

Sorry for the late comment as I started reading this series these days.

I don't understand why CAP_SYS_ADMIN is required for the fuse server,
though I can understand it's a security constraint.  I can only find
that this constraint is newly added since v14, but failed to find any
related discussion or hint.

Besides, is there any chance relaxing the constraint to
ns_capable(CAP_SYS_ADMIN), as FUSE supports FS_USERNS_MOUNT, i.e.
support passthrough mode in user namespace?



-- 
Thanks,
Jingbo

