Return-Path: <linux-fsdevel+bounces-72571-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F15CFBC91
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 03:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FF013032707
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E40F24886A;
	Wed,  7 Jan 2026 02:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CduNltpJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A451A704B
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Jan 2026 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754508; cv=none; b=I64OxY8k3sTmi56Nd4z1j++qz2N5YXsWnJVYwZO2F3oZKpJ+XGojbaRJTNxbdnmpgBujmKUfEYFco7dHbrdknrOYpfNtwKaAiHxXk1rFiEmSPEcUKisv/JQmy+c4fR/O/BZwpR53CUQU+bceay7rSr5vBw+dcZPDISu7bXadrSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754508; c=relaxed/simple;
	bh=aUsE/cySTAqHBXdGLbIOVcIc2KukrYR3EeDQBGWjTYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=btDyNE1i72sSiZLK5AvCwJIaB1E1CuBfTbL8QjopiWRCCmtzcsxHO7Txfv1ZO3YU+eGdclOK4NgFnCLbeG609C82FLREW6QzdfEF0c6ObMgL8idIzKQdD51aTo1CtTpmce6ON59YytKyG/etLfkxXNZ8Yr8k2hecTGL/lOMiXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CduNltpJ; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767754501; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KQDFGf2ptcUk6k9pSkqPNxqXotAWUhdnptVixlDEIdM=;
	b=CduNltpJxOBUxer2sY0KLgvG09h43JV4bjqKM+AnGGh1JRZSyezmvE9i/gGmYl5kbCWD5Om/P9HTrNRZ8i157LLLiU8iKAsiwQkY3F3QkY/vCNvN5kOaNlgSJCODKOlwIoqVTOPanQ/3EENq8MazrNVjwW7WWkzkPYDOle3oYWQ=
Received: from 30.221.132.240(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwXAho7_1767754500 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 07 Jan 2026 10:55:00 +0800
Message-ID: <d35e8a13-a7e8-4562-9e26-e340d8afe631@linux.alibaba.com>
Date: Wed, 7 Jan 2026 10:55:00 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] fs: add immutable rootfs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Lennart Poettering <lennart@poettering.net>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 Josef Bacik <josef@toxicpanda.com>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
 <20260102-work-immutable-rootfs-v1-3-f2073b2d1602@kernel.org>
 <f6bef901-b9a6-4882-83d1-9c5c34402351@linux.alibaba.com>
 <20260107024727.GM1712166@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260107024727.GM1712166@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/7 10:47, Al Viro wrote:
> On Wed, Jan 07, 2026 at 10:28:23AM +0800, Gao Xiang wrote:
> 
>> Just one random suggestion.  Regardless of Al's comments,
>> if we really would like to expose a new visible type to
>> userspace,   how about giving it a meaningful name like
>> emptyfs or nullfs (I know it could have other meanings
>> in other OSes) from its tree hierarchy to avoid the
>> ambiguous "rootfs" naming, especially if it may be
>> considered for mounting by users in future potential use
>> cases?
> 
> *boggle*
> 
> _what_ potential use cases?  "This here directory is empty and
> it'll stay empty and anyone trying to create stuff in it will
> get an error; oh, and we want it to be a mount boundary, for
> some reason"?
> 
> IDGI...

My concern is that "rootfs" naming is already (ab)used in various
ways, although kernel folks know what happens here by checking
the kernel code for example, but making it visible to users I'm
afraid that userspace folks already get various concepts out of
the word "root" (it's absolutely not "chroot" but for a mount
namespace?).

Thanks,
Gao Xiang

