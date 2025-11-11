Return-Path: <linux-fsdevel+bounces-67922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DA0C4DCFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 13:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47FFE3A9206
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Nov 2025 12:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3DE35A126;
	Tue, 11 Nov 2025 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="h21gR9aU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="homK9s+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6963587B8;
	Tue, 11 Nov 2025 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762864072; cv=none; b=WJ1FcvtqOZdLFacyoKd74AdYK0EiIHnzUzH2H5y8hlsyqSgHgRC3RpG6TVSykl4z5qMTKaYOifr05o2vhd1ZkgNeRcYnKYL6zSYpgebzux98Yd5218xEgUsjvNFXgDgLzQw3txQjVg09h9bP3wiOAReXOSa7DdEt0yRKloF8KCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762864072; c=relaxed/simple;
	bh=9BI5n61qLiP4hmzl3oxkvSzARLyEY3ntDVuVCOxRJ6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAwuMlI38vO5aZlMk19ffdmY9PHQ6SWPhUbktrVb+508UZ9DINIpv+l0svxlVsuNGEHVc2cOpDHiSmPMOWDNqEfLZjikhOQRLccj2h8MGHmgs+boKkggkOinD4dwifo/iHg5B5wnYht9XKPyLvPAiggqysvRW/XWDb5JDqFs8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=h21gR9aU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=homK9s+4; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C470C14001D9;
	Tue, 11 Nov 2025 07:27:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 11 Nov 2025 07:27:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1762864068;
	 x=1762950468; bh=odCvzHzflLTAc8B/UiMMglkBWYTEtUU7jHdHxgB3fu8=; b=
	h21gR9aUOjzrDzAhSZHB7JQQ+BsTGhFXXEzoBZ5s7/flcm0VWAf+PzOtW/HJCAAO
	Uqn18ITg0JbKiLcbuA4MYBSyTEu2yel106bMnSDYzNRk1zIlxLeRRlrugtY0wqjx
	pFwVwflzl7QuyGR4MfGXOEGae44I/m+QZWU699e8AM/rzjKeOOKBMdKWo6ObCgve
	Sa9zaIgu7ZF+btnPbayXxz7EibphXSUpJtRHMxlHKZ1kxx7VxF+1q8O2ly0mbUzx
	1GxoeV6lt6G6sRAchwqOlLZPSpig4bj4h02diKgtg6qw9QzhFe9joRDSBYErCAna
	Fu9swYJFkKtQCX+VWfq7ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1762864068; x=
	1762950468; bh=odCvzHzflLTAc8B/UiMMglkBWYTEtUU7jHdHxgB3fu8=; b=h
	omK9s+4cw843BfJ15NlcQmt1hTjPuTJMtjylCmmXyNW/TVxjvpth7xn5OqCHhGnU
	j78yDG9O0vZPj8KyjSCjEHVIiOGjCeYtfVsQBTtYKpebg5Y6PSJi+cBMzhOEKtAa
	jOMOppcZHLdZV3fudg7zLyY8UwRROCR0nlBdjCbppF+UZzoIxoeZIfiTJeyJ/675
	UnVaQqDO6hqgiwQm//ZEZWYoW9NJ0NVY8pEf0uyX+eW7A3Ufef2r4OBBY8FmniWq
	fG2RDvlaIuWsfGao6jLLYr16IV5qvue4W4onQXY6ZcWo2byS7tWyYtkaphcxSEOJ
	/Xq32TVFASmOaB97K6R7Q==
X-ME-Sender: <xms:xCsTaZ2hZStZuDiLGavtSkYgB3ucdUSzfqZ8a7g4treYvYx9LxGnLg>
    <xme:xCsTaZZNItA3yn9Au_LvAbT8IArlLEgWX2gVEK3erYL0EVHGCPMP-4EzosTMMNbVD
    XScEcukpOqtTrXH0ZIe-7RNlo8gSCtcS4aMtX3WfePjPA64-g>
X-ME-Received: <xmr:xCsTaRKcDXEImi27sN60Fo4ZJqzZmHvwzC-6VfhE3gpdE1UidP8FEd1kTpp0F_OTayABvowlhOXE--nl8e8qPEuhst4uK1fvo4NCJLwcpg3UeLCHsv8JL-s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdduudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    ekhfegieegteelffegleetjeekuddvhfehjefhheeuiedtheeuhfekueekffehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvghtpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvih
    hrohesiigvnhhivhdrlhhinhhugidrohhrghdruhhkpdhrtghpthhtoheplhhinhhugidq
    khgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghuthhofh
    hssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggv
    vhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xCsTaYG-y2h-kozUbttnhTpRY9rFAM5tX7IoEoUxdeEpPp-IRNIMqg>
    <xmx:xCsTaYt53DaTaCAgoabxYzX8txS4o2HaS37qTar8osSBBohk8CrdMQ>
    <xmx:xCsTaXumBAYW8PPVSeoFF32V3RiS3mCZTKCNWiXnjvi_OELvhZjcEw>
    <xmx:xCsTaWBANcwvItT1cvjIUz4lZaaXixuaxbDDNqQV1TgNLKo38JLUOg>
    <xmx:xCsTaXhY5wdpZLNuruvlKeUNSrPkeljlpaVztqMCBMvsUCWGEuMZ-up1>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Nov 2025 07:27:46 -0500 (EST)
Message-ID: <bd4fc8ce-ca3f-4e0f-86c0-f9aaa931a066@themaw.net>
Date: Tue, 11 Nov 2025 20:27:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] autofs: dont trigger mount if it cant succeed
To: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
 autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20251111060439.19593-1-raven@themaw.net>
 <20251111060439.19593-3-raven@themaw.net>
 <20251111-zunahm-endeffekt-c8fb3f90a365@brauner>
 <20251111102435.GW2441659@ZenIV>
 <20251111-ortseinfahrt-lithium-21455428ab30@brauner>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <20251111-ortseinfahrt-lithium-21455428ab30@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/11/25 18:55, Christian Brauner wrote:
> On Tue, Nov 11, 2025 at 10:24:35AM +0000, Al Viro wrote:
>> On Tue, Nov 11, 2025 at 11:19:59AM +0100, Christian Brauner wrote:
>>
>>>> +	sbi->owner = current->nsproxy->mnt_ns;
>>> ns_ref_get()
>>> Can be called directly on the mount namespace.
>> ... and would leak all mounts in the mount tree, unless I'm missing
>> something subtle.
> Right, I thought you actually wanted to pin it.
> Anyway, you could take a passive reference but I think that's nonsense
> as well. The following should do it:

Right, I'll need to think about this for a little while, I did think

of using an id for the comparison but I diverged down the wrong path so

this is a very welcome suggestion. There's still the handling of where

the daemon goes away (crash or SIGKILL, yes people deliberately do this

at times, think simulated disaster recovery) which I've missed in this

revision.


Al, thoughts please?


>
> UNTESTED, UNCOMPILED

I'll give it a whirl, ;)


>
> ---
>   fs/autofs/autofs_i.h |  4 ++++
>   fs/autofs/inode.c    |  3 +++
>   fs/autofs/root.c     | 10 ++++++++++
>   fs/namespace.c       |  6 ++++++
>   include/linux/fs.h   |  1 +
>   5 files changed, 24 insertions(+)
>
> diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
> index 23cea74f9933..2b9d2300d351 100644
> --- a/fs/autofs/autofs_i.h
> +++ b/fs/autofs/autofs_i.h
> @@ -16,6 +16,7 @@
>   #include <linux/wait.h>
>   #include <linux/sched.h>
>   #include <linux/sched/signal.h>
> +#include <uapi/linux/mount.h>
>   #include <linux/mount.h>
>   #include <linux/namei.h>
>   #include <linux/uaccess.h>
> @@ -109,11 +110,14 @@ struct autofs_wait_queue {
>   #define AUTOFS_SBI_STRICTEXPIRE 0x0002
>   #define AUTOFS_SBI_IGNORE	0x0004
>   
>   struct autofs_sb_info {
>   	u32 magic;
>   	int pipefd;
>   	struct file *pipe;
>   	struct pid *oz_pgrp;
> +	u64 mnt_ns_id;
>   	int version;
>   	int sub_version;
>   	int min_proto;
> diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
> index f5c16ffba013..247a5784d192 100644
> --- a/fs/autofs/inode.c
> +++ b/fs/autofs/inode.c
> @@ -6,8 +6,10 @@
>   
>   #include <linux/seq_file.h>
>   #include <linux/pagemap.h>
> +#include <linux/ns_common.h>
>   
>   #include "autofs_i.h"
> +#include "../mount.h"

As a module I try really hard to avoid use of non-public definitions.

But if everyone is happy I'm happy too!


>   
>   struct autofs_info *autofs_new_ino(struct autofs_sb_info *sbi)
>   {
> @@ -251,6 +253,7 @@ static struct autofs_sb_info *autofs_alloc_sbi(void)
>   	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
>   	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
>   	sbi->pipefd = -1;
> +	sbi->mnt_ns_id = to_ns_common(current->nsproxy->mnt_ns)->ns_id;
>   
>   	set_autofs_type_indirect(&sbi->type);
>   	mutex_init(&sbi->wq_mutex);
> diff --git a/fs/autofs/root.c b/fs/autofs/root.c
> index 174c7205fee4..f06f62d23e76 100644
> --- a/fs/autofs/root.c
> +++ b/fs/autofs/root.c
> @@ -7,8 +7,10 @@
>   
>   #include <linux/capability.h>
>   #include <linux/compat.h>
> +#include <linux/ns_common.h>
>   
>   #include "autofs_i.h"
> +#include "../mount.h"
>   
>   static int autofs_dir_permission(struct mnt_idmap *, struct inode *, int);
>   static int autofs_dir_symlink(struct mnt_idmap *, struct inode *,
> @@ -341,6 +343,14 @@ static struct vfsmount *autofs_d_automount(struct path *path)
>   	if (autofs_oz_mode(sbi))
>   		return NULL;
>   
> +	/* Refuse to trigger mount if current namespace is not the owner
> +	 * and the mount is propagation private.
> +	 */
> +	if (sbi->mnt_ns_id != to_ns_common(current->nsproxy->mnt_ns)->ns_id) {
> +		if (vfsmount_to_propagation_flags(path->mnt) & MS_PRIVATE)
> +			return ERR_PTR(-EPERM);
> +	}
> +
>   	/*
>   	 * If an expire request is pending everyone must wait.
>   	 * If the expire fails we're still mounted so continue
> diff --git a/fs/namespace.c b/fs/namespace.c
> index d82910f33dc4..27bb12693cba 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -5150,6 +5150,12 @@ static u64 mnt_to_propagation_flags(struct mount *m)
>   	return propagation;
>   }
>   
> +u64 vfsmount_to_propagation_flags(struct vfsmount *mnt)
> +{
> +	return mnt_to_propagation_flags(real_mount(mnt));
> +}
> +EXPORT_SYMBOL_GPL(vfsmount_to_propagation_flags);
> +
>   static void statmount_sb_basic(struct kstatmount *s)
>   {
>   	struct super_block *sb = s->mnt->mnt_sb;
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c895146c1444..a5c2077ce6ed 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3269,6 +3269,7 @@ extern struct file * open_exec(const char *);
>   /* fs/dcache.c -- generic fs support functions */
>   extern bool is_subdir(struct dentry *, struct dentry *);
>   extern bool path_is_under(const struct path *, const struct path *);
> +u64 vfsmount_to_propagation_flags(struct vfsmount *mnt);
>   
>   extern char *file_path(struct file *, char *, int);
>   

