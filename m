Return-Path: <linux-fsdevel+bounces-56878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0334DB1CC3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 20:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28D8156619B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 18:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B31829E118;
	Wed,  6 Aug 2025 18:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sbNFfut8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2D21E834E;
	Wed,  6 Aug 2025 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754506670; cv=none; b=Ije0/JGF9+neO/rijVe8o+E+0BjuejV7bhMi0Di+/xADozrjqUMK6d9qyQ/nh6MP4JL3R24Gw0GOi8vrRzg1PzGboJsS4OY89q6gOxaHM6nD6c+ekf/Q6cfKZNnwC7BGpoWmWG7iFlKoAcZIwo+5ILTJh40ybyGbTmfs57EcsgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754506670; c=relaxed/simple;
	bh=Z2K44BDv8iYtioBJw82pfmKLTw/D0OBAOM+CsDmQydU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H6ZTUX63hFxagfhd/RAEnjSyxrVxZFRXIxrOUeCz3n/Xp8swqzmkUrhIOPUzgS63gCC9SzJsq3VRWZR7C6fdL2vd3boiiJKk9iUZWUvyMJJE5mNRtcTkSJ9hJwghynmsUuUapQQD9EXkWagVoJeT6wTxxiRGNpEtrMw0cEz1wu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sbNFfut8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=hzq0vb/yvUU3QbvwPK4scAkP5mr8qU5DJOgyJY7yIlM=; b=sbNFfut8rqy1hdfW/leJn9f/Mf
	cfbhFoDmOnw0rwsdOyFgb0fWp0zUslkXicnn5nYw0vzJZ+ZfIfQ3r1vyZ9Y9v8Diknno3KxftnSyA
	2PD2UlQMQUY2qFg546bxsdSXs/zjLOnREg5bTHmLhndzsu2/uw2QUBBdHzNujstdUUGF2X1eIj/+5
	OwjdxuHMgVxSkaxFzT22HEp0HZzkbegje5DiNp1/3c4jzTzhQKskuBOQEvMB9hCovykO7YftUY3e8
	dCsSXT0EAHP0w6n/nFJp+TLwNtQe/TZmrI7w5w804DkHdKJG2Qg2jdWVAN9L1/sKQf+2ccayBMD/X
	2L0nM9vA==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujjKY-0000000G8fK-3YMG;
	Wed, 06 Aug 2025 18:57:42 +0000
Message-ID: <1ea6f1d9-550d-4b81-bade-1a0ca14c27c6@infradead.org>
Date: Wed, 6 Aug 2025 11:57:42 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
 <20250805-procfs-pidns-api-v4-3-705f984940e7@cyphar.com>
 <9027aa89-b3b2-46c8-8338-6c37f1c5b97a@infradead.org>
 <2025-08-06.1754503216-vulgar-pinch-more-tasks-meager-grader-93KeQn@cyphar.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <2025-08-06.1754503216-vulgar-pinch-more-tasks-meager-grader-93KeQn@cyphar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/6/25 11:02 AM, Aleksa Sarai wrote:
> On 2025-08-05, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>> On 8/4/25 10:45 PM, Aleksa Sarai wrote:
>>> /proc has historically had very opaque semantics about PID namespaces,
>>> which is a little unfortunate for container runtimes and other programs
>>> that deal with switching namespaces very often. One common issue is that
>>> of converting between PIDs in the process's namespace and PIDs in the
>>> namespace of /proc.
>>>
>>> In principle, it is possible to do this today by opening a pidfd with
>>> pidfd_open(2) and then looking at /proc/self/fdinfo/$n (which will
>>> contain a PID value translated to the pid namespace associated with that
>>> procfs superblock). However, allocating a new file for each PID to be
>>> converted is less than ideal for programs that may need to scan procfs,
>>> and it is generally useful for userspace to be able to finally get this
>>> information from procfs.
>>>
>>> So, add a new API to get the pid namespace of a procfs instance, in the
>>> form of an ioctl(2) you can call on the root directory of said procfs.
>>> The returned file descriptor will have O_CLOEXEC set. This acts as a
>>> sister feature to the new "pidns" mount option, finally allowing
>>> userspace full control of the pid namespaces associated with procfs
>>> instances.
>>>
>>> The permission model for this is a bit looser than that of the "pidns"
>>> mount option (and also setns(2)) because /proc/1/ns/pid provides the
>>> same information, so as long as you have access to that magic-link (or
>>> something equivalently reasonable such as being in an ancestor pid
>>> namespace) it makes sense to allow userspace to grab a handle. Ideally
>>> we would check for ptrace-read access against all processes in the pidns
>>> (which is very likely to be true for at least one process, as
>>> SUID_DUMP_DISABLE is cleared on exec(2) and is rarely set by most
>>> programs), but this would obviously not scale.
>>>
>>> setns(2) will still have their own permission checks, so being able to
>>> open a pidns handle doesn't really provide too many other capabilities.
>>>
>>> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
>>> ---
>>>  Documentation/filesystems/proc.rst |  4 +++
>>>  fs/proc/root.c                     | 68 ++++++++++++++++++++++++++++++++++++--
>>>  include/uapi/linux/fs.h            |  4 +++
>>>  3 files changed, 74 insertions(+), 2 deletions(-)
>>>
>>
>>
>>> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
>>> index 0bd678a4a10e..68e65e6d7d6b 100644
>>> --- a/include/uapi/linux/fs.h
>>> +++ b/include/uapi/linux/fs.h
>>> @@ -435,8 +435,12 @@ typedef int __bitwise __kernel_rwf_t;
>>>  			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
>>>  			 RWF_DONTCACHE)
>>>  
>>> +/* This matches XSDFEC_MAGIC, so we need to allocate subvalues carefully. */
>>>  #define PROCFS_IOCTL_MAGIC 'f'
>>>  
>>> +/* procfs root ioctls */
>>> +#define PROCFS_GET_PID_NAMESPACE	_IO(PROCFS_IOCTL_MAGIC, 32)
>>
>> Since the _IO() nr here is 32, Documentation/userspace-api/ioctl/ioctl-number.rst
>> should be updated like:
>>
>> -'f'   00-0F  linux/fs.h                                                conflict!
>> +'f'   00-1F  linux/fs.h                                                conflict!
> 
> Should this be 00-20 (or 00-2F) instead?

Oops, yes, it should be one of those. Thanks.

> Also, is there a better value to use for this new ioctl? I'm not quite
> sure what is the best practice to handle these kinds of conflicts...

I wouldn't worry about it. We have *many* conflicts.
(unless Al or Christian are concerned)

>> (17 is already used for PROCFS_IOCTL_MAGIC somewhere else, so that probably should
>> have update the Doc/rst file.)
>>
>>> +
>>>  /* Pagemap ioctl */
>>>  #define PAGEMAP_SCAN	_IOWR(PROCFS_IOCTL_MAGIC, 16, struct pm_scan_arg)

-- 
~Randy


