Return-Path: <linux-fsdevel+bounces-54156-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF29AFBA29
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 19:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E6C3A5F83
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 17:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8CB263C8F;
	Mon,  7 Jul 2025 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sa/y7kEq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A14288A2
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 17:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751910816; cv=none; b=TZbkIxW/v/ce4pAe0Asbmahro1dGUMMyKn2TGP4D5UqL0uFiATcOioqpY2IUewXjsj4B4GURKPt1HRtSNVImrXv53zKzBZfP9nUr5orxb78T0YSG0CX22BUbqpexu3rqF/vZUle2J6UiJqyeIpF+pkdEaq9O4rzMi2qekXjt4kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751910816; c=relaxed/simple;
	bh=PJCUxndDyy9aKoL7TqeI0FjfwhSH8f/NYHniHwJOEvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HnY5izk+srmoMEmU3LplSNwHL67K8QJKLGO/rYDZ+NxHofeqh4pHNJLTfBG8+v1jeLizRZk1EEJczv1FjQjsCWLMXNmq4LkRPhKXPVWWjQTyYjhkDqvfKB0o/fC+nEBHtM4T5SBbQTCVfffroi21GWO2K0x1HWheEbzoWKM5A0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sa/y7kEq; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <74ae6eb2-cea7-4e3e-82eb-72978dd0f101@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751910812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQHayfYIL+d6HS8rf76iOroTc9ml4KgNSGNH0xgeoG4=;
	b=sa/y7kEq3NvAVMCZWcAKa8HALGKl+Ftu6Y9Le6CVHE2UAFzNqMkOaw3FJDpPYTfvRTZzV6
	NQbTd7RS/k/2lIMK5rIeu8b8VQZjq87jud6HPv7Z6uL8hpftsT0Vuxj3lAG0ewOurVToDl
	QINEbvKN4Tnwr0RgYmfV/P9vHIcP000=
Date: Mon, 7 Jul 2025 10:53:24 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 bpf-next 1/5] namei: Introduce new helper function
 path_walk_parent()
Content-Language: en-GB
To: Song Liu <songliubraving@meta.com>
Cc: Song Liu <song@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, Kernel Team <kernel-team@meta.com>,
 "andrii@kernel.org" <andrii@kernel.org>,
 "eddyz87@gmail.com" <eddyz87@gmail.com>, "ast@kernel.org" <ast@kernel.org>,
 "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "brauner@kernel.org" <brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
 "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>,
 "m@maowtm.org" <m@maowtm.org>, "neil@brown.name" <neil@brown.name>
References: <20250617061116.3681325-1-song@kernel.org>
 <20250617061116.3681325-2-song@kernel.org>
 <2459c10e-d74c-4118-9b6d-c37d05ecec02@linux.dev>
 <58FB95C4-1499-4865-8FA7-3E1F64EB5EDE@meta.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <58FB95C4-1499-4865-8FA7-3E1F64EB5EDE@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/6/25 4:54 PM, Song Liu wrote:
>
>> On Jul 4, 2025, at 10:40 AM, Yonghong Song <yonghong.song@linux.dev> wrote:
> [...]
>>> +static struct dentry *__path_walk_parent(struct path *path, const struct path *root, int flags)
>>>   {
>>> - struct dentry *parent;
>>> -
>>> - if (path_equal(&nd->path, &nd->root))
>>> + if (path_equal(path, root))
>>>    goto in_root;
>>> - if (unlikely(nd->path.dentry == nd->path.mnt->mnt_root)) {
>>> - struct path path;
>>> + if (unlikely(path->dentry == path->mnt->mnt_root)) {
>>> + struct path new_path;
>>>   - if (!choose_mountpoint(real_mount(nd->path.mnt),
>>> -       &nd->root, &path))
>>> + if (!choose_mountpoint(real_mount(path->mnt),
>>> +       root, &new_path))
>>>    goto in_root;
>>> - path_put(&nd->path);
>>> - nd->path = path;
>>> - nd->inode = path.dentry->d_inode;
>>> - if (unlikely(nd->flags & LOOKUP_NO_XDEV))
>>> + path_put(path);
>>> + *path = new_path;
>>> + if (unlikely(flags & LOOKUP_NO_XDEV))
>>>    return ERR_PTR(-EXDEV);
>>>    }
>>>    /* rare case of legitimate dget_parent()... */
>>> - parent = dget_parent(nd->path.dentry);
>>> + return dget_parent(path->dentry);
>> I have some confusion with this patch when crossing mount boundary.
>>
>> In d_path.c, we have
>>
>> static int __prepend_path(const struct dentry *dentry, const struct mount *mnt,
>>                           const struct path *root, struct prepend_buffer *p)
>> {
>>         while (dentry != root->dentry || &mnt->mnt != root->mnt) {
>>                 const struct dentry *parent = READ_ONCE(dentry->d_parent);
>>
>>                 if (dentry == mnt->mnt.mnt_root) {
>>                         struct mount *m = READ_ONCE(mnt->mnt_parent);
>>                         struct mnt_namespace *mnt_ns;
>>
>>                         if (likely(mnt != m)) {
>>                                 dentry = READ_ONCE(mnt->mnt_mountpoint);
>>                                 mnt = m;
>>                                 continue;
>>                         }
>>                         /* Global root */
>>                         mnt_ns = READ_ONCE(mnt->mnt_ns);
>>                         /* open-coded is_mounted() to use local mnt_ns */
>>                         if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
>>                                 return 1;       // absolute root
>>                         else
>>                                 return 2;       // detached or not attached yet
>>                 }
>>
>>                 if (unlikely(dentry == parent))
>>                         /* Escaped? */
>>                         return 3;
>>
>>                 prefetch(parent);
>>                 if (!prepend_name(p, &dentry->d_name))
>>                         break;
>>                 dentry = parent;
>>         }
>>         return 0;
>> }
>>
>> At the mount boundary and not at root mount, the code has
>> dentry = READ_ONCE(mnt->mnt_mountpoint);
>> mnt = m; /* 'mnt' will be parent mount */
>> continue;
>>
>> After that, we have
>> const struct dentry *parent = READ_ONCE(dentry->d_parent);
>> if (dentry == mnt->mnt.mnt_root) {
>> /* assume this is false */
>> }
>> ...
>> prefetch(parent);
>>         if (!prepend_name(p, &dentry->d_name))
>>                 break;
>>         dentry = parent;
>>
>> So the prepend_name(p, &dentry->d_name) is actually from mnt->mnt_mountpoint.
> I am not quite following the question. In the code below:
>
>                 if (dentry == mnt->mnt.mnt_root) {
>                         struct mount *m = READ_ONCE(mnt->mnt_parent);
>                         struct mnt_namespace *mnt_ns;
>
>                         if (likely(mnt != m)) {
>                                 dentry = READ_ONCE(mnt->mnt_mountpoint);
>                                 mnt = m;
>                                 continue;
> /* We either continue, here */
>
>                         }
>                         /* Global root */
>                         mnt_ns = READ_ONCE(mnt->mnt_ns);
>                         /* open-coded is_mounted() to use local mnt_ns */
>                         if (!IS_ERR_OR_NULL(mnt_ns) && !is_anon_ns(mnt_ns))
>                                 return 1;       // absolute root
>                         else
>                                 return 2;       // detached or not attached yet
> /* Or return here */
>                 }
>
> So we will not hit prepend_name(). Does this answer the
> question?
>
>> In your above code, maybe we should return path->dentry in the below if statement?
>>
>>         if (unlikely(path->dentry == path->mnt->mnt_root)) {
>>                 struct path new_path;
>>
>>                 if (!choose_mountpoint(real_mount(path->mnt),
>>                                        root, &new_path))
>>                         goto in_root;
>>                 path_put(path);
>>                 *path = new_path;
>>                 if (unlikely(flags & LOOKUP_NO_XDEV))
>>                         return ERR_PTR(-EXDEV);
>> + return path->dentry;
>>         }
>>         /* rare case of legitimate dget_parent()... */
>>         return dget_parent(path->dentry);
>>
>> Also, could you add some selftests cross mount points? This will
>> have more coverages with __path_walk_parent().

Looks like __path_walk_parent() works for the root of mounted fs.
If this is the case, the implementation is correct. It could be
good to add some comments to clarify.

> Yeah, I will try to add more tests in the next revision.
>
> Thanks,
> Song
>


