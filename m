Return-Path: <linux-fsdevel+bounces-71009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAAECAF453
	for <lists+linux-fsdevel@lfdr.de>; Tue, 09 Dec 2025 09:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55A55302BA81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Dec 2025 08:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD59B241663;
	Tue,  9 Dec 2025 08:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NelE4Ik/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B0F223DD4
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Dec 2025 08:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268547; cv=none; b=HdEmroCJl1BbVAMvOCtiLhFL7RT0OJe1W4m19Zv2Raqk8/CaKdSFaDKGQxOdf9ZahVBDatvmdsDPt1dmKx+taTbSXA25qhWTvrQpmmG7sP3h544LA94Temk1z4yebQ8jnne74yNBNruabJeX28YtEUSosYwz1WnuqYBn8rTTU9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268547; c=relaxed/simple;
	bh=m8rAK2sGLKSUfcikExD+0h/G3ii59vVBq316dCqsPBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jLd6KPF0dbpzSvDVgxgt8597jE7biZM1i7XgNnxvUbJTBWgj0vVJXOn3d4OhCHPSwRqwuwHi393yKgwf13rjRXodn1iwnixU4DS61GM1einhcuFht2kKwUrk4+MUz2RCvfxeO7sMM1XRgob14ryvIr9c6SkR6zX0aEnB/91XdUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NelE4Ik/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b735e278fa1so902845766b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Dec 2025 00:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765268544; x=1765873344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fimG7EUbly/WUwljyphW/JFdJh4kklZTK2GR/3AFZ2I=;
        b=NelE4Ik/y72V0Jpyji0hYE0VgP461unGstXGUr81Lx2px4SD5aFpKemPfVHVJVPXwI
         CvatqfkhsANQyCCA6lojk46Et/N++bUuNX+2S4Fvjk9eJBmKnIIpqzmSXyyLNSKm5+6k
         8BwX3mKG64JFyDevO/IOGic6VrRH8kbIpEXqX1zkIFqX5XieaFAgiKfIc3X/q/gULVMx
         d/mdXquUdKVJAtH+bpjme0a0LfciuFLEspjOLQhcXFkAwWniLrjW++TteW6ncHcj0aSq
         Ax8B4NgNJXowVOKvCK1fgfuPAFZUO1er+WuJhifyQ4vmQ1KqYFV7driRS2ypv5CVSkRk
         cunw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765268544; x=1765873344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fimG7EUbly/WUwljyphW/JFdJh4kklZTK2GR/3AFZ2I=;
        b=m9CbiXXH+MgA/kSjcBgM9pD+/D32/bQ75u1Xhyy9fjBG9TXt8QTIvek4ptzb3Dg8eZ
         dmnkTtH2o5eNWsJTOuwwSVqR4Np8BfeiQ4W2tm/I4XABR+4nw7Q6BNNysgGLXNUda86E
         1sGpjA2ZC+twfzMb0t3Jg1Rvq0LNIw0p8GFqja1TrQVMnwQ+G2VYfwi4UBTtidj06Ceu
         QmSc3N395Q19wPnaol1baP7kmCpumuacqN61/hoOF2LqXtlsZkAVlCWKhFIMJv4Qlq/y
         RkvXkCCISRKxwM7ULMQBxDjSUI0Y+5U3bMSfh9OG5tTjDTTEEr3ocRo4ZK7dpC+ZxTY6
         vQpA==
X-Forwarded-Encrypted: i=1; AJvYcCUID7Sqjy3wbdWg90RP0gCVY1ILycecDQ//ATY8yi9TvJM2pwohbeaixqqrf7mgZk0dtbiVcoxO7hclOiWh@vger.kernel.org
X-Gm-Message-State: AOJu0YxCe3qzNlnZ5R2fCkA8193gGz/n/zOSuRlOuuCQvufJ9FCmSatE
	4ddeFNM+Hv3Z1YNqLTJJrmbFprmUMLb0CkA6KRrfpH3qX9t9mkgI5hgs
X-Gm-Gg: ASbGncs4F8ZXvBVu40291irbyTjhGNtV0U4Du/UdfBlrhoi/P2E+/OXMdt7Ab6zrvKi
	7qKTDV4irCdKf9mYmCqH5/mi2Eby+EONRHZ1uINAJk50XSKJK0X+MTlicUukCTQRIoUt375V1qX
	FvAJjeC0QyU7ogSVjwXiepKR6uxr/uf+Yl4WZzLlBnU8CUVRj0LqRRlkvJkkB9rxFh/rKAIFuaZ
	fRjytHVzCE5uC/NQ/9W36I/AxvNXcoJ7M/WJA5lSdfz3UE4eZjRekE4Jn8gFN7DB8s8zVNtiUbf
	XhZDAkyWd9VvmAuemA2ohNcRR4VSwsEjYTquA8sEkKL5KOg3NE0eSku7nb86ANW6qNbr2cH2ETO
	h7IocDQ5ncIsAcDX/dkR563NuEmXJTCUKF6o5r3+7kQx6rKpHsQjg/PBaYVLn377uUHRt0CvdK/
	kJLgr0OKLcWu8aChJNjT+UEtXYWIjDax0FZ9sjjoNEGmRclWVOnwGjAB/m
X-Google-Smtp-Source: AGHT+IGyEYt6MFLpPBTDrhxQ34rHeZ/+6rnj0Pplvp+x9ISQW6UcbtjrIYah0DXraN2FohVIK4at3g==
X-Received: by 2002:a17:907:3c93:b0:b73:5936:77fc with SMTP id a640c23a62f3a-b7a242d4a9dmr1031948466b.13.1765268543652;
        Tue, 09 Dec 2025 00:22:23 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b79f44d3db6sm1333051766b.29.2025.12.09.00.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 00:22:22 -0800 (PST)
Date: Tue, 9 Dec 2025 09:22:10 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] file: Call security_file_alloc() after initializing the
 filp
Message-ID: <dpuld3qyyl6kan2jsigftmuhrqee2htjfmlytvnr55x37wy3eb@jkutc2k4zkfm>
References: <20251209075347.31161-1-tianjia.zhang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251209075347.31161-1-tianjia.zhang@linux.alibaba.com>

On Tue, Dec 09, 2025 at 03:53:47PM +0800, Tianjia Zhang wrote:
> When developing a dedicated LSM module, we need to operate on the
> file object within the LSM function, such as retrieving the path.
> However, in `security_file_alloc()`, the passed-in `filp` is
> only a valid pointer; the content of `filp` is completely
> uninitialized and entirely random, which confuses the LSM function.
> 

I take it you have some underlying routine called by other hooks as well
which ends up looking at ->f_path.

Given that f_path *is not valid* to begin with, memsetted or not, your
file_alloc_security hoook should not be looking at it to begin with.

So I don't think this patch has merit.

> Therefore, it is necessary to call `security_file_alloc()` only
> after the main fields of the `filp` object have been initialized.
> This patch only moves the call to `security_file_alloc()` to the
> end of the `init_file()` function.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  fs/file_table.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/file_table.c b/fs/file_table.c
> index 81c72576e548..e66531a629aa 100644
> --- a/fs/file_table.c
> +++ b/fs/file_table.c
> @@ -156,11 +156,6 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>  	int error;
>  
>  	f->f_cred = get_cred(cred);
> -	error = security_file_alloc(f);
> -	if (unlikely(error)) {
> -		put_cred(f->f_cred);
> -		return error;
> -	}
>  
>  	spin_lock_init(&f->f_lock);
>  	/*
> @@ -202,6 +197,14 @@ static int init_file(struct file *f, int flags, const struct cred *cred)
>  	 * They may be enabled later by fsnotify_open_perm_and_set_mode().
>  	 */
>  	file_set_fsnotify_mode(f, FMODE_NONOTIFY_PERM);
> +
> +	error = security_file_alloc(f);
> +	if (unlikely(error)) {
> +		mutex_destroy(&f->f_pos_lock);
> +		put_cred(f->f_cred);
> +		return error;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.39.5 (Apple Git-154)
> 

