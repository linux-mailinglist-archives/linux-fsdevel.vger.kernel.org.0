Return-Path: <linux-fsdevel+bounces-56802-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D27AB1BDD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 02:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE21A18A0BC9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 00:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9754654;
	Wed,  6 Aug 2025 00:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TUPNyQX3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95F19A;
	Wed,  6 Aug 2025 00:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754439596; cv=none; b=OyDNdH+Xy4lqVeBVG2Q/8lbB45U3i/29CEEBPNDGUk7boAo3yBrUKSmF7Jm/38OplFrjcHvu8qZCHGpXr2HP+x3C0cxhTChvFpbdVQYz9VRtKQJSt8dL2OISMGJD4iYOJj4yAxsPnmzCOCzMAwpM9cmtAI+OdBuNb5LCXz/tAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754439596; c=relaxed/simple;
	bh=OT3f/U4DpV8q91l9jRxEsTYFN/WOPBcjG9NXESoXWrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pUQVGmjIJ4fuJx935Pi1E3V10FYxJ4zdVotbKbE+SkWEJhWTmFNDiu6yNakesvLhW7nX1iAHKPK5a/3j6GApCrG0QXO+u4sq3xAqwjA4CSFVbfliN883PMJ5JuMS66GeM9zjSVI3LWRGUKqKRzz3u2UDTHiVbBumCXrMxNoYOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TUPNyQX3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=nZYwsKOptSUZO0neyK/l0Qf2ovJ/CTbLtLm7FCTYX5s=; b=TUPNyQX3WyRtkdwpmO7RZqOyAo
	WQMlt77Ff95hM004vnyaI6qjzqGPl4GufiP6o/4tEvS3XUVJpvn1kO3pzYRrWjSO5E454b802yoZm
	oLiEUgEeQFUAfH+Pb7xC96Rgq5E9Wx16sY6NCvNtF9Dm+INNGPVRg18tqRZjXlPt9VkBEO3O6U104
	7p52IsEO327eDPsZRW7D2bWUzGX0QaNELvDyH6K51qMbioYWFqMKZwqQRAJcXDQSc4GAYffRKF9wA
	M5oQClEteyQL5XTcf/4PUe23ScgeDO2AcEtong/vrPmTCq4Ufml+0F0WbT0oK11ZJxjFXPOlzRkFc
	07v8Ka0w==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujRsg-0000000E3K1-3O8k;
	Wed, 06 Aug 2025 00:19:46 +0000
Message-ID: <c1ba0f8d-6b3c-4c2b-863c-2ce374df723c@infradead.org>
Date: Tue, 5 Aug 2025 17:19:45 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
To: Aleksa Sarai <cyphar@cyphar.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250805-procfs-pidns-api-v4-0-705f984940e7@cyphar.com>
 <20250805-procfs-pidns-api-v4-2-705f984940e7@cyphar.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250805-procfs-pidns-api-v4-2-705f984940e7@cyphar.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/4/25 10:45 PM, Aleksa Sarai wrote:
> Since the introduction of pid namespaces, their interaction with procfs
> has been entirely implicit in ways that require a lot of dancing around
> by programs that need to construct sandboxes with different PID
> namespaces.
> 
> Being able to explicitly specify the pid namespace to use when
> constructing a procfs super block will allow programs to no longer need
> to fork off a process which does then does unshare(2) / setns(2) and
> forks again in order to construct a procfs in a pidns.
> 
> So, provide a "pidns" mount option which allows such users to just
> explicitly state which pid namespace they want that procfs instance to
> use. This interface can be used with fsconfig(2) either with a file
> descriptor or a path:
> 
>   fsconfig(procfd, FSCONFIG_SET_FD, "pidns", NULL, nsfd);
>   fsconfig(procfd, FSCONFIG_SET_STRING, "pidns", "/proc/self/ns/pid", 0);
> 
> or with classic mount(2) / mount(8):
> 
>   // mount -t proc -o pidns=/proc/self/ns/pid proc /tmp/proc
>   mount("proc", "/tmp/proc", "proc", MS_..., "pidns=/proc/self/ns/pid");
> 
> As this new API is effectively shorthand for setns(2) followed by
> mount(2), the permission model for this mirrors pidns_install() to avoid
> opening up new attack surfaces by loosening the existing permission
> model.
> 
> In order to avoid having to RCU-protect all users of proc_pid_ns() (to
> avoid UAFs), attempting to reconfigure an existing procfs instance's pid
> namespace will error out with -EBUSY. Creating new procfs instances is
> quite cheap, so this should not be an impediment to most users, and lets
> us avoid a lot of churn in fs/proc/* for a feature that it seems
> unlikely userspace would use.
> 
> Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
> ---
>  Documentation/filesystems/proc.rst |  8 ++++
>  fs/proc/root.c                     | 98 +++++++++++++++++++++++++++++++++++---
>  2 files changed, 100 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 5236cb52e357..5a157dadea0b 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -2360,6 +2360,7 @@ The following mount options are supported:
>  	hidepid=	Set /proc/<pid>/ access mode.
>  	gid=		Set the group authorized to learn processes information.
>  	subset=		Show only the specified subset of procfs.
> +	pidns=		Specify a the namespace used by this procfs.

			drop ^^ a

>  	=========	========================================================
>  
>  hidepid=off or hidepid=0 means classic mode - everybody may access all
> @@ -2392,6 +2393,13 @@ information about processes information, just add identd to this group.
>  subset=pid hides all top level files and directories in the procfs that
>  are not related to tasks.
>  
> +pidns= specifies a pid namespace (either as a string path to something like
> +`/proc/$pid/ns/pid`, or a file descriptor when using `FSCONFIG_SET_FD`) that
> +will be used by the procfs instance when translating pids. By default, procfs
> +will use the calling process's active pid namespace. Note that the pid
> +namespace of an existing procfs instance cannot be modified (attempting to do
> +so will give an `-EBUSY` error).
> +
>  Chapter 5: Filesystem behavior
>  ==============================
>  
-- 
~Randy


