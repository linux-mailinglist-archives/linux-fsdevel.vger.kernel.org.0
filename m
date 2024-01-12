Return-Path: <linux-fsdevel+bounces-7875-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E8082C163
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 15:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAEF2862BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jan 2024 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820B26D1DA;
	Fri, 12 Jan 2024 14:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WO1q8fIC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2264AAA
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9ab48faeaso1100401b3a.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jan 2024 06:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705068704; x=1705673504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHrMtEZ8o3LrAnwVMnXOVdf/hgZQzOmJRfK9dMEjlbQ=;
        b=WO1q8fICxDHvO1BEFOJyB7oTrgJmEWYSYGOCuPyZ6hLCPBC7D7dHR+8yFSYHMNM8l1
         ETQR62XZCfD1tW9R23cAiKGPb6S4cCWr8tyTBVf5ui0mZCAXJSa6vRPA8IMHtoeztQtf
         oz63Q0zuNjuueDS2NXbVL9yDltKARHSpaIGx7I/RGg2mx5H0ggWJr2NGb62HUqz/TmA2
         oFRdOXz0ZIp1VhMa9I4ImTpZ6FAdc2ch7wZi7FeVJ0d6ZaR0Cp/WVg5Rj2+alHSVgJQK
         0+nBkMzdGwWNPMxWKktBgpntR7mxV/tpQ2ltGDKBw9iHRr6u0qmX7aWPuMkC9RhPIBO/
         YTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705068704; x=1705673504;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gHrMtEZ8o3LrAnwVMnXOVdf/hgZQzOmJRfK9dMEjlbQ=;
        b=l8m6PtkX6EBrdNYCJw4WiqIP64mGjPb8q+PoVy2AFiBPVgi2m4Jt4qWXuNLyyRY8q0
         WYYfFzc3PP/9Zgn3IBi3DEvwUq4jiBZLUx+e1vbwZ4V6Etg4N1r9saizFpRhK5OtQNw0
         O6WsljkoeQjc50RFFHnVw8Csd8L1SS4kvcd3viS/Ux3FIyLIbYZww/5ADkoWkKDyxyDZ
         jeSDgq44SfcpKzfjGru5ALQUUbXKMlmJ+soe2s5kvdBj/L/70IAZQDWUZ+/gbJ72HkRc
         bbgG6tCGtvBFDXdzhm7MH9ePV4RcYYKlw7+Wc20mlvTKK8LAjD2GzMYKTUB31y9ZCV4B
         GvHg==
X-Gm-Message-State: AOJu0YyinbORn+doSpnkEbPGs6/RpJAQaXYATTN2qlQtSov+pUZBC3xH
	ATDkppsN0Dvywz1sE9eJDAAbTyDvQSviEw==
X-Google-Smtp-Source: AGHT+IFQSss8Z5wST3ovAX77pMOHAFj3CCrWa6jtcHPMpSA+t6/u2ZhJf9dJWR7cIDzh50bah6SabA==
X-Received: by 2002:aa7:8e9b:0:b0:6da:838f:b004 with SMTP id a27-20020aa78e9b000000b006da838fb004mr2002247pfr.1.1705068704260;
        Fri, 12 Jan 2024 06:11:44 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78083000000b006d9b4303f9csm3218949pff.71.2024.01.12.06.11.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 06:11:43 -0800 (PST)
Message-ID: <4a35c78e-98d4-4edb-b7bf-8a6d1df3c554@kernel.dk>
Date: Fri, 12 Jan 2024 07:11:42 -0700
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
From: Jens Axboe <axboe@kernel.dk>
To: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20240111152233.352912-1-amir73il@gmail.com>
 <20240112110936.ibz4s42x75mjzhlv@quack3>
 <CAOQ4uxgAGpBTeEyqJTSGn5OvqaxsVP3yXR6zuS-G9QWnTjoV9w@mail.gmail.com>
 <ec5c6dde-e8dd-4778-a488-886deaf72c89@kernel.dk>
In-Reply-To: <ec5c6dde-e8dd-4778-a488-886deaf72c89@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/12/24 6:58 AM, Jens Axboe wrote:
> On 1/12/24 6:00 AM, Amir Goldstein wrote:
>> On Fri, Jan 12, 2024 at 1:09?PM Jan Kara <jack@suse.cz> wrote:
>>>
>>> On Thu 11-01-24 17:22:33, Amir Goldstein wrote:
>>>> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
>>>> optimized the case where there are no fsnotify watchers on any of the
>>>> filesystem's objects.
>>>>
>>>> It is quite common for a system to have a single local filesystem and
>>>> it is quite common for the system to have some inotify watches on some
>>>> config files or directories, so the optimization of no marks at all is
>>>> often not in effect.
>>>>
>>>> Content event (i.e. access,modify) watchers on sb/mount more rare, so
>>>> optimizing the case of no sb/mount marks with content events can improve
>>>> performance for more systems, especially for performance sensitive io
>>>> workloads.
>>>>
>>>> Set a per-sb flag SB_I_CONTENT_WATCHED if sb/mount marks with content
>>>> events in their mask exist and use that flag to optimize out the call to
>>>> __fsnotify_parent() and fsnotify() in fsnotify access/modify hooks.
>>>>
>>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>>
>>> ...
>>>
>>>> -static inline int fsnotify_file(struct file *file, __u32 mask)
>>>> +static inline int fsnotify_path(const struct path *path, __u32 mask)
>>>>  {
>>>> -     const struct path *path;
>>>> +     struct dentry *dentry = path->dentry;
>>>>
>>>> -     if (file->f_mode & FMODE_NONOTIFY)
>>>> +     if (!fsnotify_sb_has_watchers(dentry->d_sb))
>>>>               return 0;
>>>>
>>>> -     path = &file->f_path;
>>>> +     /* Optimize the likely case of sb/mount/parent not watching content */
>>>> +     if (mask & FSNOTIFY_CONTENT_EVENTS &&
>>>> +         likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)) &&
>>>> +         likely(!(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED))) {
>>>> +             /*
>>>> +              * XXX: if SB_I_CONTENT_WATCHED is not set, checking for content
>>>> +              * events in s_fsnotify_mask is redundant, but it will be needed
>>>> +              * if we use the flag FS_MNT_CONTENT_WATCHED to indicate the
>>>> +              * existence of only mount content event watchers.
>>>> +              */
>>>> +             __u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
>>>> +                                dentry->d_sb->s_fsnotify_mask;
>>>> +
>>>> +             if (!(mask & marks_mask))
>>>> +                     return 0;
>>>> +     }
>>>
>>> So I'm probably missing something but how is all this patch different from:
>>>
>>>         if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))) {
>>>                 __u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
>>>                         path->mnt->mnt_fsnotify_mask |
>>
>> It's actually:
>>
>>                           real_mount(path->mnt)->mnt_fsnotify_mask
>>
>> and this requires including "internal/mount.h" in all the call sites.
>>
>>>                         dentry->d_sb->s_fsnotify_mask;
>>>                 if (!(mask & marks_mask))
>>>                         return 0;
>>>         }
>>>
>>> I mean (mask & FSNOTIFY_CONTENT_EVENTS) is true for the frequent events
>>> (read & write) we care about. In Jens' case
>>>
>>>         !(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
>>>         !(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED)
>>>
>>> is true as otherwise we'd go right to fsnotify_parent() and so Jens
>>> wouldn't see the performance benefit. But then with your patch you fetch
>>> i_fsnotify_mask and s_fsnotify_mask anyway for the test so the only
>>> difference to what I suggest above is the path->mnt->mnt_fsnotify_mask
>>> fetch but that is equivalent to sb->s_iflags (or wherever we store that
>>> bit) fetch?
>>>
>>> So that would confirm that the parent handling costs in fsnotify_parent()
>>> is what's really making the difference and just avoiding that by checking
>>> masks early should be enough?
>>
>> Can't the benefit be also related to saving a function call?
>>
>> Only one way to find out...
>>
>> Jens,
>>
>> Can you please test attached v3 with a non-inlined fsnotify_path() helper?
> 
> I can run it since it doesn't take much to do that, but there's no way
> parallel universe where saving a function call would yield those kinds
> of wins (or have that much cost).

Ran this patch, and it's better than mainline for sure, but it does have
additional overhead that the previous version did not:

               +1.46%  [kernel.vmlinux]  [k] fsnotify_path

-- 
Jens Axboe


