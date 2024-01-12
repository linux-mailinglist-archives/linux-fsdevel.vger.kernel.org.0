Return-Path: <linux-fsdevel+bounces-7874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FC82C13A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 14:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C7D41F266D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 13:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5086D1D7;
	Fri, 12 Jan 2024 13:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="TaJx3yzz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A646D1BA
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5ce99e1d807so590308a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 05:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705067911; x=1705672711; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gtnh0vx06omQ8I4nRzSF0ORlzJ60LZ+YwlcxFIbG2kU=;
        b=TaJx3yzz+SIL74cYpRbzABudSk9itgYQ/F1HpHACkcbYO1UIRSoc6WAaMO1Miey1BH
         FYMqnl2qosaNCAGMxuSGwW+EbCVpq+I8/rbnqt3m+cH1uglFeLd16SVKGshuGgaFs3yG
         0mtyd9CxbOx7q4cP2gcCklGu7a3AZs2viS5lwcKVkbvxUJKqXSiq3vH/NT2ie9l/Pxc8
         dxum2p8UuKHc+vnE4PSeyLxLOLO2/qvwBSwoiAwIkv6GcZqdFDktoEIBaNa/ZFjBWe52
         3kMDApMft2O/1A8eNICCz2xNYvA9E3bVi77COYFxQxWlyZ9UJ0/oRo1JOSHJNmxfTZYE
         CKmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705067911; x=1705672711;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gtnh0vx06omQ8I4nRzSF0ORlzJ60LZ+YwlcxFIbG2kU=;
        b=n/KSrgZiUjGBgfaGpwNXkjt00NevXREtQa6L0odfGAYtYqgId3oB3aSemCXJOjjAmq
         HVABMA4+A8Hw7fxF0tAFha3wsmRWziWjenOxAisyAaBTQdorOQtmH8V7NjH9ILAGu1qU
         drNeMip72fK+gCWr/Sc+/YrdkHYjA2wBPIJYm9eXoC9XIx4PS0nfSxLXjaOUEsJhEazI
         cB7ZGAXonuw1DxQfjxKpbrZlVY6oTVrufoQHmTu/eleUho+9+7DMK0W0YzISBLBWMNZy
         pezRp24UbmwINp6TN0HBlcfJ73IPy86cskcR0q/WfJder8wUaRWlk9l4Hjnwx/uGta42
         SUWQ==
X-Gm-Message-State: AOJu0YxS14DuTfYYSdweD8WM78JSvBMI0t8rt8yTOTUp+KwWerqrLG7Z
	wcAD1jC6A7QAX+a6Sc/RDhlFSaucSYwt7w==
X-Google-Smtp-Source: AGHT+IHzHIANsMLmXt4nBCitOtHY8nwKNE4gXsBJvPfTJCO3xsviPkXmjJaHf3YYjxICSJI4hSjr6A==
X-Received: by 2002:a05:6a20:a084:b0:199:bbca:35ee with SMTP id r4-20020a056a20a08400b00199bbca35eemr2629930pzj.0.1705067910561;
        Fri, 12 Jan 2024 05:58:30 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id r9-20020a170903014900b001d3e5271459sm3195414plc.55.2024.01.12.05.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 05:58:29 -0800 (PST)
Message-ID: <ec5c6dde-e8dd-4778-a488-886deaf72c89@kernel.dk>
Date: Fri, 12 Jan 2024 06:58:28 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v2] fsnotify: optimize the case of no content event
 watchers
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20240111152233.352912-1-amir73il@gmail.com>
 <20240112110936.ibz4s42x75mjzhlv@quack3>
 <CAOQ4uxgAGpBTeEyqJTSGn5OvqaxsVP3yXR6zuS-G9QWnTjoV9w@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAOQ4uxgAGpBTeEyqJTSGn5OvqaxsVP3yXR6zuS-G9QWnTjoV9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 6:00 AM, Amir Goldstein wrote:
> On Fri, Jan 12, 2024 at 1:09?PM Jan Kara <jack@suse.cz> wrote:
>>
>> On Thu 11-01-24 17:22:33, Amir Goldstein wrote:
>>> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
>>> optimized the case where there are no fsnotify watchers on any of the
>>> filesystem's objects.
>>>
>>> It is quite common for a system to have a single local filesystem and
>>> it is quite common for the system to have some inotify watches on some
>>> config files or directories, so the optimization of no marks at all is
>>> often not in effect.
>>>
>>> Content event (i.e. access,modify) watchers on sb/mount more rare, so
>>> optimizing the case of no sb/mount marks with content events can improve
>>> performance for more systems, especially for performance sensitive io
>>> workloads.
>>>
>>> Set a per-sb flag SB_I_CONTENT_WATCHED if sb/mount marks with content
>>> events in their mask exist and use that flag to optimize out the call to
>>> __fsnotify_parent() and fsnotify() in fsnotify access/modify hooks.
>>>
>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>
>> ...
>>
>>> -static inline int fsnotify_file(struct file *file, __u32 mask)
>>> +static inline int fsnotify_path(const struct path *path, __u32 mask)
>>>  {
>>> -     const struct path *path;
>>> +     struct dentry *dentry = path->dentry;
>>>
>>> -     if (file->f_mode & FMODE_NONOTIFY)
>>> +     if (!fsnotify_sb_has_watchers(dentry->d_sb))
>>>               return 0;
>>>
>>> -     path = &file->f_path;
>>> +     /* Optimize the likely case of sb/mount/parent not watching content */
>>> +     if (mask & FSNOTIFY_CONTENT_EVENTS &&
>>> +         likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)) &&
>>> +         likely(!(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED))) {
>>> +             /*
>>> +              * XXX: if SB_I_CONTENT_WATCHED is not set, checking for content
>>> +              * events in s_fsnotify_mask is redundant, but it will be needed
>>> +              * if we use the flag FS_MNT_CONTENT_WATCHED to indicate the
>>> +              * existence of only mount content event watchers.
>>> +              */
>>> +             __u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
>>> +                                dentry->d_sb->s_fsnotify_mask;
>>> +
>>> +             if (!(mask & marks_mask))
>>> +                     return 0;
>>> +     }
>>
>> So I'm probably missing something but how is all this patch different from:
>>
>>         if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))) {
>>                 __u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
>>                         path->mnt->mnt_fsnotify_mask |
> 
> It's actually:
> 
>                           real_mount(path->mnt)->mnt_fsnotify_mask
> 
> and this requires including "internal/mount.h" in all the call sites.
> 
>>                         dentry->d_sb->s_fsnotify_mask;
>>                 if (!(mask & marks_mask))
>>                         return 0;
>>         }
>>
>> I mean (mask & FSNOTIFY_CONTENT_EVENTS) is true for the frequent events
>> (read & write) we care about. In Jens' case
>>
>>         !(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
>>         !(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED)
>>
>> is true as otherwise we'd go right to fsnotify_parent() and so Jens
>> wouldn't see the performance benefit. But then with your patch you fetch
>> i_fsnotify_mask and s_fsnotify_mask anyway for the test so the only
>> difference to what I suggest above is the path->mnt->mnt_fsnotify_mask
>> fetch but that is equivalent to sb->s_iflags (or wherever we store that
>> bit) fetch?
>>
>> So that would confirm that the parent handling costs in fsnotify_parent()
>> is what's really making the difference and just avoiding that by checking
>> masks early should be enough?
> 
> Can't the benefit be also related to saving a function call?
> 
> Only one way to find out...
> 
> Jens,
> 
> Can you please test attached v3 with a non-inlined fsnotify_path() helper?

I can run it since it doesn't take much to do that, but there's no way
parallel universe where saving a function call would yield those kinds
of wins (or have that much cost).

-- 
Jens Axboe


