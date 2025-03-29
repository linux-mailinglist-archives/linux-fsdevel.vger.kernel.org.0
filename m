Return-Path: <linux-fsdevel+bounces-45264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EBAA75570
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 10:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BFDB189206C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Mar 2025 09:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C541A1AB50D;
	Sat, 29 Mar 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sO2UC6fT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-66.smtpout.orange.fr [80.12.242.66])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690D2AD2A;
	Sat, 29 Mar 2025 09:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743240589; cv=none; b=N/7pQXvzgdqwwge6/yi3J5J3ssapvsPugcJvyArg2S7J9KZKjB4ohflGS1JEyO0LtgFkfMxOoDE+QcsXToEsaBJtkGCYlt7eMll+BSqynKeYgu/jlbSHkmv5g/ylDswthgAIfuk9OTWVoTSiaAE3MHDNNZdVBjxAMKXDdNVwPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743240589; c=relaxed/simple;
	bh=hzQhOPNqE60R1qkBlg61xzswVm5bJ0iiYEc707dhqi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mv1HyuDQN7/VFYr5WTIlhYKaD0GiLXE27paRWhioKW2jKbOdbkyxoas1Ci4cMaNA2i7+iO9MV/GLPE4MLVvQQj9ifgIlok+vEzJCrBx6MUZ1Z4enUHZEMw5Rr8drnbzYbK4kq3Ph1HvBRmeupLC2TePSxVzxsR+EWTAyOarzlhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sO2UC6fT; arc=none smtp.client-ip=80.12.242.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id ySMrtFJFBkHP7ySMutS03L; Sat, 29 Mar 2025 10:20:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1743240046;
	bh=4gKjuoqKQNe9FB94aEC2wTPWEJscygTofIdbbOSUWHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=sO2UC6fTd8Dg3vSzZrTefyMvYX2q5Lac2yYQHSuSDIUvjFwmI1nqgDXRG8Sk7FE+J
	 PG8Io1viZwSclEF+MXNuiamTY1UuynmpfqDvF21oPMRvw3dSIq25OD147J6uLcRBzF
	 0GGz6bZJmaBu76xQ2Yy7iNTuvmFw8rJTMot2na3GCMLsUPM+WYocx6KzNkgyENganB
	 qfx5PqwuxUWOOfOYgM/c6yAY8tricdhGQnqDNypVcehNoIRCQNXhboown4KPgdFAX/
	 TUGRouwPeGDhWI0g4Nj0MMmdLvTua+J3FsBWd8macfz8idQWjW7t7X0l2Ih9GXvAF+
	 58DHZ7FidJtuA==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 29 Mar 2025 10:20:46 +0100
X-ME-IP: 90.11.132.44
Message-ID: <b1baac64-f56d-4d0f-92f1-d7bb808a151b@wanadoo.fr>
Date: Sat, 29 Mar 2025 10:20:40 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs: Supply dir_context.count as readdir buffer size
 hint
To: Jaco Kroon <jaco@uls.co.za>
Cc: bernd.schubert@fastmail.fm, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, miklos@szeredi.hu, rdunlap@infradead.org,
 trapexit@spawn.link
References: <20230727081237.18217-1-jaco@uls.co.za>
 <20250314221701.12509-1-jaco@uls.co.za>
 <20250314221701.12509-2-jaco@uls.co.za>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20250314221701.12509-2-jaco@uls.co.za>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

a few nitpicks below to reduce the diffpatch with unrelated changes. 
(trainling spaces)


Le 14/03/2025 à 23:16, Jaco Kroon a écrit :
> This was provided by Miklos <miklos@szeredi.hu> via LKML on 2023/07/27
> subject "Re: [PATCH] fuse: enable larger read buffers for readdir.".
> 
> This is thus preperation for an improved fuse readdir() patch.  The

s/preperation/preparation/

> description he provided:
> 
> "The best strategy would be to find the optimal buffer size based on the size of
> the userspace buffer.  Putting that info into struct dir_context doesn't sound
> too complicated...
> 
> "Here's a patch.  It doesn't touch readdir.  Simply setting the fuse buffer size
> to the userspace buffer size should work, the record sizes are similar (fuse's
> is slightly larger than libc's, so no overflow should ever happen)."

...

> @@ -239,7 +240,7 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
>   
>   /*
>    * New, all-improved, singing, dancing, iBCS2-compliant getdents()
> - * interface.
> + * interface.

Unrelated change.

>    */
>   struct linux_dirent {
>   	unsigned long	d_ino;

...

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 2788df98080f..1e426e2b5999 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -308,7 +308,7 @@ struct iattr {
>    */
>   #define FILESYSTEM_MAX_STACK_DEPTH 2
>   
> -/**
> +/**

Unrelated change.

>    * enum positive_aop_returns - aop return codes with specific semantics
>    *
>    * @AOP_WRITEPAGE_ACTIVATE: Informs the caller that page writeback has
> @@ -318,7 +318,7 @@ struct iattr {
>    * 			    be a candidate for writeback again in the near
>    * 			    future.  Other callers must be careful to unlock
>    * 			    the page if they get this return.  Returned by
> - * 			    writepage();
> + * 			    writepage();

Unrelated change.

>    *
>    * @AOP_TRUNCATED_PAGE: The AOP method that was handed a locked page has
>    *  			unlocked it and the page might have been truncated.
> @@ -1151,8 +1151,8 @@ struct file *get_file_active(struct file **f);
>   
>   #define	MAX_NON_LFS	((1UL<<31) - 1)
>   
> -/* Page cache limit. The filesystems should put that into their s_maxbytes
> -   limits, otherwise bad things can happen in VM. */
> +/* Page cache limit. The filesystems should put that into their s_maxbytes
> +   limits, otherwise bad things can happen in VM. */

Unrelated change.

>   #if BITS_PER_LONG==32
>   #define MAX_LFS_FILESIZE	((loff_t)ULONG_MAX << PAGE_SHIFT)
>   #elif BITS_PER_LONG==64
> @@ -2073,6 +2073,13 @@ typedef bool (*filldir_t)(struct dir_context *, const char *, int, loff_t, u64,
>   struct dir_context {
>   	filldir_t actor;
>   	loff_t pos;
> +	/*
> +	 * Filesystems MUST NOT MODIFY count, but may use as a hint:
> +	 * 0	    unknown
> +	 * > 0      space in buffer (assume at least one entry)
> +	 * INT_MAX  unlimited
> +	 */
> +	int count;
>   };
>   
>   /*
> @@ -2609,7 +2616,7 @@ int sync_inode_metadata(struct inode *inode, int wait);
>   struct file_system_type {
>   	const char *name;
>   	int fs_flags;
> -#define FS_REQUIRES_DEV		1
> +#define FS_REQUIRES_DEV		1

Unrelated change.

>   #define FS_BINARY_MOUNTDATA	2
>   #define FS_HAS_SUBTYPE		4
>   #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
> @@ -3189,7 +3196,7 @@ ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
>   extern ssize_t kernel_write(struct file *, const void *, size_t, loff_t *);
>   extern ssize_t __kernel_write(struct file *, const void *, size_t, loff_t *);
>   extern struct file * open_exec(const char *);
> -
> +

Unrelated change.

>   /* fs/dcache.c -- generic fs support functions */
>   extern bool is_subdir(struct dentry *, struct dentry *);
>   extern bool path_is_under(const struct path *, const struct path *);


