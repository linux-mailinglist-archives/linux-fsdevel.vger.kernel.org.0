Return-Path: <linux-fsdevel+bounces-73918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D06AD2472F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 13:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6DC7230B4723
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 12:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FF339525A;
	Thu, 15 Jan 2026 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfaZBxEd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3488A38A9AB
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 12:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479831; cv=none; b=jx58NRsxCVM5VcIKKbCXTL0NJSrUSu85z3pDcimT4DX5ff0CUiEFCcUKk6z/eqItzyOuiboZ107x4GhHF5HdAtTxr7AVghUbH41Xb3UDEQqp4AiOeBqhF3YWhuEywsvZ8lTxgkGJzRpy1vHjyrDbVOdyH2qM7PgpTn3A9rRKdn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479831; c=relaxed/simple;
	bh=YFlZi3jstUpTBbnPJHTzHfT6rNDin50tP0aHOiJ210Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gItTXcPyB3Yl3MT4kzf7FOk9EhlOQ3jPEatSN0v7HxgNhhfcRMoiMuDEjznAkAbHuxyxKiMBsexuyPkoV4FnONjR448mR89dKN+Au02Dj7QOrE0m/ezj1yn5g7G2oG1YzzaXAXkRhGXFetnQ4iZ+s4RYZmB0TS/VkKkg40R0ISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfaZBxEd; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-64b921d9e67so1370672a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Jan 2026 04:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768479826; x=1769084626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Jg8Pr84HZTwL4Chvghj+kThuTRFhOG//CjvHWmAwzw=;
        b=GfaZBxEd/gUuVrW+fp77GklUDJkMIlFzrqKs+kg1gSTs0b1+nI1PWyWzWGPSoEoJmY
         9LH0LnGX0p6P8b70F+bOFUIRoywYFp+VQRpIBifQ8iOxTM2coJjlkrgZ/LaBiYQiiNgN
         jeC9xiXq9irLUd89egEAoK+2ncMVk7MUq4XwvSzlZ5j9dXW+abdZB6Inbf2nbKzH+xFo
         tu0XAJtq+8USWplZxpvdUWsgeIgHaiM5qcbILRCPS5CUtdJZGxjWSLPS4+LgtrFvzzBl
         cEpgQ1iJbhqByzkPQnWAf4KPblHHpWpTT+jpnPujr5N31x6codIwR6HIGSfgfmwTV6Ke
         cVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479826; x=1769084626;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Jg8Pr84HZTwL4Chvghj+kThuTRFhOG//CjvHWmAwzw=;
        b=LYu4WCbR66e0CiZzquHjypHiM56mA9Dtv6z4I7DWbgcfpMgz4tnfbLzu1/442GMopC
         pK22XNNq0JfqvWZrgOQ2T7VOZiJfB5juBbiZYxO+DuW6kz9ouyMkr68L/K1No494iSVR
         p4MjtaT1sUSfWqWiy+jUFL1pOop06HO3XNV9Jxf06gqP7Z1BHKKuujSwZb1E2dSqC3GP
         cPwCFexLBLg37wpl4G6P9g0JgeJuVxLRDNqd6mI1uu0+epEssrtpSJ8VQjAasRouluGZ
         C5TM6Qj8rxX4Dy0+8S0rMtE7bHoWCyms+0C7GoBRBr9mModxEyX1OR3aWGWK8QuHz2sV
         FNuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCFupAx2aYgKkcDyBmv5V4rEhcZERSLD+iEHDfcWfqMPb+qbueJxKwBD8c+lFkQVGZB8RDJZEVuLEQWd+L@vger.kernel.org
X-Gm-Message-State: AOJu0YxPEFyAnRILRW+v1eTnWDNZm2qlb5keacFZPQkqP4W/SJPgCq3m
	cKCCENKZ37wXpKjuv1rW47YhVXnWIB3SINBC9Zm5OUG8x+eVFJ24NGOg
X-Gm-Gg: AY/fxX5uCykbs+zDgjQBcBPaPD8CvadhtWBulXEy0sBHF7AKrh8K+152WrQgCFK9e/V
	m59XJ9FVlFigCD/uBpyQGBI4nWb/Nz3TX24NJJwH89YVvLvyzLXaQgT+lq6KjTSRf/VeTjUxCZV
	OJ8MYhdoVOT9UVIz64qPd32rBfNS/a4eYSW+5R71i4Ovf9nj1z2q/1Knk1Z7/DX2jtwHeE5yzPK
	XDcqXq6o5c3UvQmJOlX50kKwfIwrWQBsvN822ylNj/VtwsSrzZsHxvaeizUcsfunqQ8TvdWwhCZ
	xWX0HknYrzP66G9YMMKdoBu5LcL1CBByDs4apxPFzbLMZFCL+NZHizx8rwFJVaHtMHJFsLOXZXC
	PLt+8BtweTGAwJilBQs9HN8yvkK2ByhsvDPX/4ocGCAcYL+TJHxpdw5CG+qODhBrZXbRgyzblGE
	82oZxxbB1nQnKl+d7rh1m/nfrtwcdQ5/T5mX8hfjV2m8UAPbJ0E/697PvoA3QsJazKCmtR6hlWC
	YX9OYnpU63aQ3Vg
X-Received: by 2002:a05:6402:210d:b0:64c:584c:556c with SMTP id 4fb4d7f45d1cf-653ec46b3e5mr4990788a12.30.1768479826209;
        Thu, 15 Jan 2026 04:23:46 -0800 (PST)
Received: from localhost (2001-1c00-570d-ee00-7a88-ab31-60c0-33c9.cable.dynamic.v6.ziggo.nl. [2001:1c00:570d:ee00:7a88:ab31:60c0:33c9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6541209ce83sm2328405a12.32.2026.01.15.04.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:23:45 -0800 (PST)
Date: Thu, 15 Jan 2026 13:23:43 +0100
From: Amir Goldstein <amir73il@gmail.com>
To: Chunsheng Luo <luochunsheng@ustc.edu>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] fuse: add close all in passthrough backing close for
 crash recovery
Message-ID: <aWjcT6snaivGXvxq@amir-ThinkPad-T480>
References: <20260115072032.402-1-luochunsheng@ustc.edu>
 <20260115072032.402-2-luochunsheng@ustc.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115072032.402-2-luochunsheng@ustc.edu>

On Thu, Jan 15, 2026 at 03:20:30PM +0800, Chunsheng Luo wrote:
> Simplify FUSE daemon crash recovery by avoiding persistence of
> backing_ids, thereby improving availability and reducing performance
> overhead.
> 
> Non-persistent backing_ids after crash recovery may lead to resource
> leaks if backing file resources are not properly cleaned up during
> daemon restart.
> 
> Add a close_all handler to the backing close operation. This ensures
> comprehensive cleanup of all backing file resources when the FUSE
> daemon restarts, preventing resource leaks while maintaining the
> simplified recovery approach.

Am I correct to assume that you are referring to FUSE server restart
where the /dev/fuse fd is stored in an external fd store and reused by
the new FUSE server instance?

> 
> Signed-off-by: Chunsheng Luo <luochunsheng@ustc.edu>
> ---
>  fs/fuse/backing.c | 14 ++++++++++++++
>  fs/fuse/dev.c     |  5 +++++
>  fs/fuse/fuse_i.h  |  1 +
>  3 files changed, 20 insertions(+)
> 
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index 4afda419dd14..34d0ea62fb9b 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -166,6 +166,20 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
>  	return err;
>  }
>  
> +static int fuse_backing_close_one(int id, void *p, void *data)
> +{
> +	struct fuse_conn *fc = data;
> +
> +	fuse_backing_close(fc, id);
> +
> +	return 0;
> +}
> +
> +void fuse_backing_close_all(struct fuse_conn *fc)
> +{
> +	idr_for_each(&fc->backing_files_map, fuse_backing_close_one, fc);
> +}
> +
>  struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
>  {
>  	struct fuse_backing *fb;
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 6d59cbc877c6..25f6bb58623d 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2651,6 +2651,11 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
>  	if (get_user(backing_id, argp))
>  		return -EFAULT;
>  
> +	if (backing_id == -1) {
> +		fuse_backing_close_all(fud->fc);
> +		return 0;
> +	}
> +

I think that an explicit new ioctl FUSE_DEV_IOC_BACKING_CLOSE_ALL
is called for this very intrusive operation.

Sending FUSE_DEV_IOC_BACKING_CLOSE with backing_id -1 could
just as well happen by mistake.

Thanks,
Amir.

