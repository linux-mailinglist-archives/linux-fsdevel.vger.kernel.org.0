Return-Path: <linux-fsdevel+bounces-7953-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EE382DD27
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 17:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07892B210FA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 16:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D3F17BA8;
	Mon, 15 Jan 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="urzpWqcI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EFF17BA0
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 16:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-28bae84fc2eso1731104a91.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jan 2024 08:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705335295; x=1705940095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4kiRN6Zngv5HWSujDb3NLYbta4ZHn9slrxd4FROLXI4=;
        b=urzpWqcIZDnV6bfhF3c2SsTXXiyCWzn92zXoIRS6TaGxCDH7iovIsSaB9VUFLz8/26
         pJKewd0xaYlHXtGMUmw8KbHogHuw7sgsCgwC4QXvB9FYbEO3zGuEox3aqSC+tJDAf5m6
         jp2yfLIBtpEKjr7P1IMwDxnwr/VhTFskFdfTDlXDtbJdE/vrOsmctALUKpuUzZY4e/m2
         djvyeReEB+z2B8hihl0XdlbDeBj7tKPTtu9TSVuBz6inXkz5nURVyfjvXubQrLPZPjJS
         mZ7GLNHPUW81rqyIUFgTBjSR+5skhKR93MhPAxDrr11iCdAE7a1CiDYthmY32p+Pdk9Q
         LXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705335295; x=1705940095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4kiRN6Zngv5HWSujDb3NLYbta4ZHn9slrxd4FROLXI4=;
        b=QYw57RIDS5YZgabG/KHulCGtib2mu6InotkcVI2ZYyRKWYQwYEglAMZuSMcAZca5s3
         1pmlOiH9It4sa3cxx6qKcHyFCIomfYPyrnW0usEXDRkQ7AMvb71bCwFN60CVSyOL5L+G
         lyUeFiqe37inoNd1ZzapMGl+VoLPRjDWqIvWsjV3qHba0U4sxVbc3Ebax3wiD/KmSsUW
         MXi6KvvKFZHwFbXeIEIRBYuw+yImxylH+m+r+tlnMn80A2k2ucjtvo47zDNGnzd4hAi4
         U4NEl2MIBgw34hmCxSrw2HRtCd+QEBvFV3mTxSNDm7dTRML06KrQtjZh1aYrpEDT1YRr
         Yp1w==
X-Gm-Message-State: AOJu0YyHnoDAJbce2gsGgELJ8KQ9wqz7PZ2VsFn/6u8f4A/A1Kl0jsPl
	hso6EKqXWNr1ibFTn8NQ+V/EqTkkIyECKfxxg/18UhbnNk1Odg==
X-Google-Smtp-Source: AGHT+IG+UUdAjiLftFpjC3Wz0kUHmOLuj3hqE4eV8G5Kq2AJwyrAgH65kKEjnZF28GWOLtnG9HxtDA==
X-Received: by 2002:a17:90b:4b92:b0:28e:6d77:d601 with SMTP id lr18-20020a17090b4b9200b0028e6d77d601mr197119pjb.2.1705335294865;
        Mon, 15 Jan 2024 08:14:54 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id qn8-20020a17090b3d4800b0028c72951de9sm9955708pjb.20.2024.01.15.08.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 08:14:53 -0800 (PST)
Message-ID: <a7a8cc63-9c8e-411c-b6bc-9d53f3c0838d@kernel.dk>
Date: Mon, 15 Jan 2024 09:14:52 -0700
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
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
References: <20240111152233.352912-1-amir73il@gmail.com>
 <20240112110936.ibz4s42x75mjzhlv@quack3>
 <CAOQ4uxgAGpBTeEyqJTSGn5OvqaxsVP3yXR6zuS-G9QWnTjoV9w@mail.gmail.com>
 <ec5c6dde-e8dd-4778-a488-886deaf72c89@kernel.dk>
 <4a35c78e-98d4-4edb-b7bf-8a6d1df3c554@kernel.dk>
 <20240115161137.35xta2j4llszyweu@quack3>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240115161137.35xta2j4llszyweu@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/15/24 9:11 AM, Jan Kara wrote:
> On Fri 12-01-24 07:11:42, Jens Axboe wrote:
>> On 1/12/24 6:58 AM, Jens Axboe wrote:
>>> On 1/12/24 6:00 AM, Amir Goldstein wrote:
>>>> On Fri, Jan 12, 2024 at 1:09?PM Jan Kara <jack@suse.cz> wrote:
>>>>>
>>>>> On Thu 11-01-24 17:22:33, Amir Goldstein wrote:
>>>>>> Commit e43de7f0862b ("fsnotify: optimize the case of no marks of any type")
>>>>>> optimized the case where there are no fsnotify watchers on any of the
>>>>>> filesystem's objects.
>>>>>>
>>>>>> It is quite common for a system to have a single local filesystem and
>>>>>> it is quite common for the system to have some inotify watches on some
>>>>>> config files or directories, so the optimization of no marks at all is
>>>>>> often not in effect.
>>>>>>
>>>>>> Content event (i.e. access,modify) watchers on sb/mount more rare, so
>>>>>> optimizing the case of no sb/mount marks with content events can improve
>>>>>> performance for more systems, especially for performance sensitive io
>>>>>> workloads.
>>>>>>
>>>>>> Set a per-sb flag SB_I_CONTENT_WATCHED if sb/mount marks with content
>>>>>> events in their mask exist and use that flag to optimize out the call to
>>>>>> __fsnotify_parent() and fsnotify() in fsnotify access/modify hooks.
>>>>>>
>>>>>> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
>>>>>
>>>>> ...
>>>>>
>>>>>> -static inline int fsnotify_file(struct file *file, __u32 mask)
>>>>>> +static inline int fsnotify_path(const struct path *path, __u32 mask)
>>>>>>  {
>>>>>> -     const struct path *path;
>>>>>> +     struct dentry *dentry = path->dentry;
>>>>>>
>>>>>> -     if (file->f_mode & FMODE_NONOTIFY)
>>>>>> +     if (!fsnotify_sb_has_watchers(dentry->d_sb))
>>>>>>               return 0;
>>>>>>
>>>>>> -     path = &file->f_path;
>>>>>> +     /* Optimize the likely case of sb/mount/parent not watching content */
>>>>>> +     if (mask & FSNOTIFY_CONTENT_EVENTS &&
>>>>>> +         likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED)) &&
>>>>>> +         likely(!(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED))) {
>>>>>> +             /*
>>>>>> +              * XXX: if SB_I_CONTENT_WATCHED is not set, checking for content
>>>>>> +              * events in s_fsnotify_mask is redundant, but it will be needed
>>>>>> +              * if we use the flag FS_MNT_CONTENT_WATCHED to indicate the
>>>>>> +              * existence of only mount content event watchers.
>>>>>> +              */
>>>>>> +             __u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
>>>>>> +                                dentry->d_sb->s_fsnotify_mask;
>>>>>> +
>>>>>> +             if (!(mask & marks_mask))
>>>>>> +                     return 0;
>>>>>> +     }
>>>>>
>>>>> So I'm probably missing something but how is all this patch different from:
>>>>>
>>>>>         if (likely(!(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED))) {
>>>>>                 __u32 marks_mask = d_inode(dentry)->i_fsnotify_mask |
>>>>>                         path->mnt->mnt_fsnotify_mask |
>>>>
>>>> It's actually:
>>>>
>>>>                           real_mount(path->mnt)->mnt_fsnotify_mask
>>>>
>>>> and this requires including "internal/mount.h" in all the call sites.
>>>>
>>>>>                         dentry->d_sb->s_fsnotify_mask;
>>>>>                 if (!(mask & marks_mask))
>>>>>                         return 0;
>>>>>         }
>>>>>
>>>>> I mean (mask & FSNOTIFY_CONTENT_EVENTS) is true for the frequent events
>>>>> (read & write) we care about. In Jens' case
>>>>>
>>>>>         !(dentry->d_flags & DCACHE_FSNOTIFY_PARENT_WATCHED) &&
>>>>>         !(dentry->d_sb->s_iflags & SB_I_CONTENT_WATCHED)
>>>>>
>>>>> is true as otherwise we'd go right to fsnotify_parent() and so Jens
>>>>> wouldn't see the performance benefit. But then with your patch you fetch
>>>>> i_fsnotify_mask and s_fsnotify_mask anyway for the test so the only
>>>>> difference to what I suggest above is the path->mnt->mnt_fsnotify_mask
>>>>> fetch but that is equivalent to sb->s_iflags (or wherever we store that
>>>>> bit) fetch?
>>>>>
>>>>> So that would confirm that the parent handling costs in fsnotify_parent()
>>>>> is what's really making the difference and just avoiding that by checking
>>>>> masks early should be enough?
>>>>
>>>> Can't the benefit be also related to saving a function call?
>>>>
>>>> Only one way to find out...
>>>>
>>>> Jens,
>>>>
>>>> Can you please test attached v3 with a non-inlined fsnotify_path() helper?
>>>
>>> I can run it since it doesn't take much to do that, but there's no way
>>> parallel universe where saving a function call would yield those kinds
>>> of wins (or have that much cost).
>>
>> Ran this patch, and it's better than mainline for sure, but it does have
>> additional overhead that the previous version did not:
>>
>>                +1.46%  [kernel.vmlinux]  [k] fsnotify_path
> 
> So did you see any effect in IOPS or just this difference in perf profile?
> Because Amir's patch took a bunch of code that was previously inlined
> (thus its cost was blended with the cost of the rest of the read/write
> code) and moved it to this new fsnotify_path() function so its cost is now
> visible...

These tests are CPU bound, but I don't recall for this one as there's a
bit of a mixup with the previously reported regression for 6.8-git where
we now do an extra fsnotify call per mem import.

-- 
Jens Axboe


