Return-Path: <linux-fsdevel+bounces-56803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A38B1BDDB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 02:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51E5183176
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 00:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA0764A8F;
	Wed,  6 Aug 2025 00:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H8R01tOn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3F7171C9;
	Wed,  6 Aug 2025 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754439924; cv=none; b=I6hi5Mhfv53sX/A9F5n5bytarsGAaCH6EL3JHr67NMwTc/g2aNY7k/azPOxGVwneZ0kqt3Y7tMsnd4xlBv/OQedAZ+aI+0AMxW9v+1K3KckIugIiM0cx99n1vdsrtA4o/F8QaZZeQxyWd+Bfw9F33XkAzXetGqvVPP6RpSG3xEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754439924; c=relaxed/simple;
	bh=Xa8K2I92uLyO484B0qkAfsO5WwTjl3NToPDEdFw7lcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wjtwq6tBw5ge/E46UTDs6102S5txoXSxpQZtN9IorDsfI3dkdDFVOeUGpOi5v2tYq7tT2/qP+dRhc7BykzPbcCI/7KAfM2nRs0T/Cv+zfgokHGDSS2HVBpUOGxK/Uyy3J/3zMw5MYs9g6MxVh+zq31vEj4QwP+9gYhI3ZkIM4EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H8R01tOn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=zYA8n4MidVExydv3/JxDVqPaTJImy9qKxpLFRRwzZo0=; b=H8R01tOndR7j5SuRFu/C4Cwen/
	qLz3YG25lqRLqoW6M+4RKs+nHpyWcdKTRyr0ZP5nxnd3D6HmKyoWDxmWXgRHGOUc1FW46lewgrfJ0
	LSEMLCNC/IH9zpuV4kFdU5ByyPyffXWewCwvfb1ebK7EiQWMyfPZCLw9Yip1A6yH/v00SuK/Aqs9r
	yWWWVYTuX6LZ/bobuRQDVZ5+aXzrH98yhIA2PePmC4XhJOeiyU8kpCGxyxKyfzMP+fo/jovz2+9tZ
	lUUp2RUxQXVNT8j9kIlvm2bvsq+hkYJm/litTEgfQNXMZfHmBjQ/e3Ua0f38lvrIVRUjZ3fUNdyg0
	clkeqPxw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujRy4-0000000E3ZF-3ciz;
	Wed, 06 Aug 2025 00:25:20 +0000
Message-ID: <9027aa89-b3b2-46c8-8338-6c37f1c5b97a@infradead.org>
Date: Tue, 5 Aug 2025 17:25:19 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] procfs: add PROCFS_GET_PID_NAMESPACE ioctl
To: Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
 <20250805-procfs-pidns-api-v4-3-705f984940e7@cyphar.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250805-procfs-pidns-api-v4-3-705f984940e7@cyphar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/4/25 10:45 PM, Aleksa Sarai wrote:
> /proc has historically had very opaque semantics about PID namespaces,
> which is a little unfortunate for container runtimes and other programs
> that deal with switching namespaces very often. One common issue is that
> of converting between PIDs in the process's namespace and PIDs in the
> namespace of /proc.
> 
> In principle, it is possible to do this today by opening a pidfd with
> pidfd_open(2) and then looking at /proc/self/fdinfo/$n (which will
> contain a PID value translated to the pid namespace associated with that
> procfs superblock). However, allocating a new file for each PID to be
> converted is less than ideal for programs that may need to scan procfs,
> and it is generally useful for userspace to be able to finally get this
> information from procfs.
> 
> So, add a new API to get the pid namespace of a procfs instance, in the
> form of an ioctl(2) you can call on the root directory of said procfs.
> The returned file descriptor will have O_CLOEXEC set. This acts as a
> sister feature to the new "pidns" mount option, finally allowing
> userspace full control of the pid namespaces associated with procfs
> instances.
> 
> The permission model for this is a bit looser than that of the "pidns"
> mount option (and also setns(2)) because /proc/1/ns/pid provides the
> same information, so as long as you have access to that magic-link (or
> something equivalently reasonable such as being in an ancestor pid
> namespace) it makes sense to allow userspace to grab a handle. Ideally
> we would check for ptrace-read access against all processes in the pidns
> (which is very likely to be true for at least one process, as
> SUID_DUMP_DISABLE is cleared on exec(2) and is rarely set by most
> programs), but this would obviously not scale.
> 
> setns(2) will still have their own permission checks, so being able to
> open a pidns handle doesn't really provide too many other capabilities.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  Documentation/filesystems/proc.rst |  4 +++
>  fs/proc/root.c                     | 68 ++++++++++++++++++++++++++++++++++++--
>  include/uapi/linux/fs.h            |  4 +++
>  3 files changed, 74 insertions(+), 2 deletions(-)
> 


> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index 0bd678a4a10e..68e65e6d7d6b 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -435,8 +435,12 @@ typedef int __bitwise __kernel_rwf_t;
>  			 RWF_APPEND | RWF_NOAPPEND | RWF_ATOMIC |\
>  			 RWF_DONTCACHE)
>  
> +/* This matches XSDFEC_MAGIC, so we need to allocate subvalues carefully. */
>  #define PROCFS_IOCTL_MAGIC 'f'
>  
> +/* procfs root ioctls */
> +#define PROCFS_GET_PID_NAMESPACE	_IO(PROCFS_IOCTL_MAGIC, 32)

Since the _IO() nr here is 32, Documentation/userspace-api/ioctl/ioctl-number.rst
should be updated like:

-'f'   00-0F  linux/fs.h                                                conflict!
+'f'   00-1F  linux/fs.h                                                conflict!

(17 is already used for PROCFS_IOCTL_MAGIC somewhere else, so that probably should
have update the Doc/rst file.)

> +
>  /* Pagemap ioctl */
>  #define PAGEMAP_SCAN	_IOWR(PROCFS_IOCTL_MAGIC, 16, struct pm_scan_arg)
>  
> 
Thanks.
-- 
~Randy


