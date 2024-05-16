Return-Path: <linux-fsdevel+bounces-19563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 446528C7157
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 07:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A801C22AD6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 05:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3A519BA6;
	Thu, 16 May 2024 05:28:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCDB14F7A
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2024 05:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715837315; cv=none; b=IB4U1SbCw09MXKyMvw8mACtjn/WixggQmt3CrnW1q3WKLpxIjH/aEFKI+z6UnzUlRwCuLEN3V7GmO5AVkDvNQCI7oNOw8nofFvbt5JVPuD+mQRzm1JGPH0WFPJIVHv1IEosQjLk6/WdK79rq0r97MaR9WM6ZVZ9sM+R0MCCv/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715837315; c=relaxed/simple;
	bh=0l/Q4hPiwOkUM1AWJs0aHZwMNrcP0Ays1z0vfEQxi54=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBddkeetD7b1Q7vmplBb726tVGBiA4zSY89ycpnaMPnjJXMaVc+a3HOZXeNDcbA8mLsbjxFZ/ZydJKgx2mAHAvoBv2IT1IZexMemod67/cxJ6PBpQE/x40+ru2gjXQCXvp9KsjwKd4R+sTeUQTspihRy8HX4LvDkdbEcfAfFOVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5cdd6cfae7so159757866b.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 May 2024 22:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715837312; x=1716442112;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2rtcvkMMqI7rH1ZoseKWyWboFWnWw/EMgm/V1nF2ag=;
        b=b1o5UG7dwd2bYh1CB6REf0nXk34uNMkX/XhqeRR3QPjgtBQ3qJUogHXu0C8IRFbhvQ
         pvwoQ5JZc67jgr0ix/AglIsxMv6ZXuv+CZ3dngQtKPXBrn9xCwXTefzbZPdJouSGxDa+
         N0BnCaoTTRHIttI13g1aUTiTyJo/lWqUY9wWvTAsStK4ymGUcjic8MNToeE24uO4dIaz
         SePe2qj81idQ+jbrSd/JFs1b1GAHEKQLsMNWnmHXww8ByQo/7Cve+yomgVeVU91y/py+
         ydIHDAJojeligwIgA331zGesSIvf4Bc4+u77apx6ZTCAmDchPSz8Cwn3W/4CJmrfDRY3
         w1Cw==
X-Gm-Message-State: AOJu0Yxs/1mheb0Yxqv5zaRKyBY4R5vhviznh4Z6tPGDIBOknQ6o6rG0
	FYw0bQZHM/bHrD0yeyZ3nltNoN9OYLCws1mW20G/9xE5Q944hmnRWEoG5A==
X-Google-Smtp-Source: AGHT+IHUONCw0Oum8EhVGF2AKx9nVbt+CZ2Uzhp4mjelwUyxNq/TT2qT2FU6t3V4OJJqkEasSkTzKA==
X-Received: by 2002:a17:906:da8d:b0:a5a:7a1:5da3 with SMTP id a640c23a62f3a-a5a2d09e4b4mr1769149666b.0.1715837311965;
        Wed, 15 May 2024 22:28:31 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7d92sm950148166b.98.2024.05.15.22.28.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 22:28:31 -0700 (PDT)
Message-ID: <a15b1050-4b52-4740-a122-a4d055c17f11@kernel.org>
Date: Thu, 16 May 2024 07:28:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] pidfd: add pidfdfs
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Seth Forshee
 <sforshee@kernel.org>, Tycho Andersen <tycho@tycho.pizza>
References: <20240213-vfs-pidfd_fs-v1-0-f863f58cfce1@kernel.org>
 <20240213-vfs-pidfd_fs-v1-2-f863f58cfce1@kernel.org>
 <210098f9-1e71-48c9-be08-7e8074ec33c1@kernel.org>
 <20240515-anklopfen-ausgleichen-0d7c220b16f4@brauner>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20240515-anklopfen-ausgleichen-0d7c220b16f4@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15. 05. 24, 18:39, Christian Brauner wrote:
> On Wed, May 15, 2024 at 01:10:49PM +0200, Jiri Slaby wrote:
>> On 13. 02. 24, 17:45, Christian Brauner wrote:
>>> This moves pidfds from the anonymous inode infrastructure to a tiny
>>> pseudo filesystem. This has been on my todo for quite a while as it will
>>> unblock further work that we weren't able to do simply because of the
>>> very justified limitations of anonymous inodes. Moving pidfds to a tiny
>>> pseudo filesystem allows:
>>>
>>> * statx() on pidfds becomes useful for the first time.
>>> * pidfds can be compared simply via statx() and then comparing inode
>>>     numbers.
>>> * pidfds have unique inode numbers for the system lifetime.
>>> * struct pid is now stashed in inode->i_private instead of
>>>     file->private_data. This means it is now possible to introduce
>>>     concepts that operate on a process once all file descriptors have been
>>>     closed. A concrete example is kill-on-last-close.
>>> * file->private_data is freed up for per-file options for pidfds.
>>> * Each struct pid will refer to a different inode but the same struct
>>>     pid will refer to the same inode if it's opened multiple times. In
>>>     contrast to now where each struct pid refers to the same inode. Even
>>>     if we were to move to anon_inode_create_getfile() which creates new
>>>     inodes we'd still be associating the same struct pid with multiple
>>>     different inodes.
>>> * Pidfds now go through the regular dentry_open() path which means that
>>>     all security hooks are called unblocking proper LSM management for
>>>     pidfds. In addition fsnotify hooks are called and allow for listening
>>>     to open events on pidfds.
>>>
>>> The tiny pseudo filesystem is not visible anywhere in userspace exactly
>>> like e.g., pipefs and sockfs. There's no lookup, there's no complex
>>> inode operations, nothing. Dentries and inodes are always deleted when
>>> the last pidfd is closed.
>>
>> This breaks lsof and util-linux.
>>
>> Without the commit, lsof shows:
>> systemd      ... 59 [pidfd:899]
>>
>>
>> With the commit:
>> systemd      ... 1187 pidfd
>>
>>
>> And that user-visible change breaks a lot of stuff, incl. lsof tests.
>>
>> For util-linux, its test fail with:
>>
>>> [  125s] --- tests/expected/lsfd/column-name-pidfd	2024-05-06 07:20:54.655845940 +0000
>>> [  125s] +++ tests/output/lsfd/column-name-pidfd	2024-05-15 01:04:15.406666666 +0000
>>> [  125s] @@ -1,2 +1,2 @@
>>> [  125s] -3 anon_inode:[pidfd] pid=1 comm= nspid=1
>>> [  125s] +3 pidfd:[INODENUM] pidfd:[INODENUM]
>>> [  125s]  pidfd:ASSOC,KNAME,NAME: 0
>>> [  125s]          lsfd: NAME and KNAME column: [02] pidfd             ... FAILED (lsfd/column-name-pidfd)
>>
>> And:
>>> [  125s] --- tests/expected/lsfd/column-type-pidfd	2024-05-06 07:20:54.655845940 +0000
>>> [  125s] +++ tests/output/lsfd/column-type-pidfd	2024-05-15 01:04:15.573333333 +0000
>>> [  125s] @@ -1,2 +1,2 @@
>>> [  125s] -3 UNKN pidfd
>>> [  125s] +3 REG REG
>>> [  125s]  pidfd:ASSOC,STTYPE,TYPE: 0
>>> [  125s]          lsfd: TYPE and STTYPE column: [02] pidfd            ... FAILED (lsfd/column-type-pidfd)
>>
>> Any ideas?
> 
> util-linux upstream is already handling that correctly now but it seems that
> lsof is not. To fix this in the kernel we'll need something like. If you could
> test this it'd be great as I'm currently traveling:
> 
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index a63d5d24aa02..3da848a8a95e 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -201,10 +201,8 @@ static const struct super_operations pidfs_sops = {
> 
>   static char *pidfs_dname(struct dentry *dentry, char *buffer, int buflen)
>   {
> -       struct inode *inode = d_inode(dentry);
> -       struct pid *pid = inode->i_private;
> -
> -       return dynamic_dname(buffer, buflen, "pidfd:[%llu]", pid->ino);
> +       /* Fake the old name as some userspace seems to rely on this. */
> +       return dynamic_dname(buffer, buflen, "anon_inode:[pidfd]");

No, the lsof test runs "lsof -p $pid -a -d $fd -F pfn" and expects:
"p${pid} f${fd} n[pidfd:$pid]"

But it gets now:
p959 f3 nanon_inode

I.e. "anon_inode" instead of "n[pidfd:959]".

Did you intend to fix by the patch the lsfd's (util-linux) 
column-name-pidfd test by this instead (the above)?

thanks,
-- 
js
suse labs


