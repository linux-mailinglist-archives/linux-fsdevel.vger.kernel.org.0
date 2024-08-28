Return-Path: <linux-fsdevel+bounces-27621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DEB962DCB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 18:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F651F22215
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 16:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5431A3BBB;
	Wed, 28 Aug 2024 16:36:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B157836130;
	Wed, 28 Aug 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724863001; cv=none; b=s7nKCCoZwqO1WINq9aredUS2XrUOzvduKhlek406bdgcwoTjkCjgZSm2rCFJaInCuI9mo6bkWq2RZ4e3+Yxbm723c/9PF1lT/UEyhSH6VN0mTNhOJM/COfR5mxbENA02BZvc+A2OIl3nv/hltBZpwiI/9VEteHVKnpu1Kye4APg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724863001; c=relaxed/simple;
	bh=BI4boLvkYhdBiX2NYg+StuUOJ2NruKhdBY2j/SKS3Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eMX2/woK2hpkbbqGk9bu03g5t1rxsC/vtrsCnN3w/yLmYvs0+SZlqyPPAorbqj//r8AfIXhvV1AURYTQMMAKVf/iC+dRYA+Q0j9HFuSAg7gk+QwXqBohjTu/4E2oApdIswqZx+QfdVhtAHBYl+qjyHknvkfSKo8hSrUI6jikj14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tavianator.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5d5b22f97b7so7006526eaf.2;
        Wed, 28 Aug 2024 09:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724862999; x=1725467799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnPR6A7kMsAB/qzHhmhyNP2hIbWj5sPUdSJEAh4TSw4=;
        b=AvC8Gptzge9se8P5zJgVDlYK3r/QBBXnWpNZr2XMkf5cq4pd5M++YvI0TlRTPqj9LM
         Cw5T6wCHu03ow2MbnyYTaF/l60u3Uz/5GqTO56DnhrNGcNUVaCPDjFMw7kRLgOYkSNhY
         xvfTxEQYwiGSsjRP5dV/Mus06Sulo30CFIC7utm8K+H1rX9fj0iaFCy8iuOTnmJuqcUq
         +ckn+cSDPY39AIpmaE6pv1pmROxzMElmiEwLRUC7y3xpP/d63o5SEE3nlFgEjsYWcu44
         93AMsFx0Vn/cwKpZWCAeLSsMkMmpooMhS38+LvSCqxWENzf8Xob472SlZ16kQOs1dkFY
         X62A==
X-Forwarded-Encrypted: i=1; AJvYcCV+8jpeq6kI/EG2CAeBWIRQK84tCAWAD8gm4EaCan9aGcAwhj77PGAVTK6yNm9Bv7JNsn57ZskITPvN1/XJ@vger.kernel.org, AJvYcCWN4RXDCfr9xg5j2JbWnQh2yIDxAS7PC76Hlfn+1gTNcLiVr7PpwYa3vyg51uzlWOGohBWXub9oeZXQi04Jzb4rjUMoLo3j@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5MAWtWSRzj0FVc57m8OurVkOWnb873WLUyOLCZkP50QRcPAJ6
	FbCurgS8FYyJFffAhVyUrXQW1Q3jiysWw2X0uoeX4Ztgwxochrfv
X-Google-Smtp-Source: AGHT+IGdRrlSxrygiDaJfhUdUXWHKiub8mle3Y49ZZmtQ3zDPqU+W9871M7/FI52F+hz2slKiEy1DQ==
X-Received: by 2002:a05:6870:c0c4:b0:25e:940:e934 with SMTP id 586e51a60fabf-27790321256mr133140fac.47.1724862998608;
        Wed, 28 Aug 2024 09:36:38 -0700 (PDT)
Received: from tachyon.tail92c87.ts.net ([192.159.180.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3bb381sm653705285a.85.2024.08.28.09.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:36:38 -0700 (PDT)
From: Tavian Barnes <tavianator@tavianator.com>
To: lihongbo22@huawei.com
Cc: brauner@kernel.org,
	gnoack@google.com,
	jack@suse.cz,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	mic@digikod.net,
	viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH] fs: obtain the inode generation number from vfs directly
Date: Wed, 28 Aug 2024 12:36:37 -0400
Message-ID: <20240828163637.637445-1-tavianator@tavianator.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827014108.222719-1-lihongbo22@huawei.com>
References: <20240827014108.222719-1-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 Aug 2024 01:41:08 +0000, Hongbo Li wrote:
> Many mainstream file systems already support the GETVERSION ioctl,
> and their implementations are completely the same, essentially
> just obtain the value of i_generation. We think this ioctl can be
> implemented at the VFS layer, so the file systems do not need to
> implement it individually.
>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  fs/ioctl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 64776891120c..dff887ec52c4 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -878,6 +878,9 @@ static int do_vfs_ioctl(struct file *filp, unsigned int fd,
>  	case FS_IOC_GETFSUUID:
>  		return ioctl_getfsuuid(filp, argp);
>  
> +	case FS_IOC_GETVERSION:
> +		return put_user(inode->i_generation, (int __user *)argp);
> +
>  	case FS_IOC_GETFSSYSFSPATH:
>  		return ioctl_get_fs_sysfs_path(filp, argp);
>  
> @@ -992,6 +995,9 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
>  		cmd = (cmd == FS_IOC32_GETFLAGS) ?
>  			FS_IOC_GETFLAGS : FS_IOC_SETFLAGS;
>  		fallthrough;

The above case falls through...

> +	case FS_IOC32_GETVERSION:
> +		cmd = FS_IOC_GETVERSION;

... to this new case, which clobbers cmd, breaking FS_IOC32_[GS]ETFLAGS.

> +		fallthrough;
>  	/*
>  	 * everything else in do_vfs_ioctl() takes either a compatible
>  	 * pointer argument or no argument -- call it with a modified

