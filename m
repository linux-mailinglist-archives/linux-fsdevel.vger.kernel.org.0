Return-Path: <linux-fsdevel+bounces-20769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851148D79FA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 03:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2FD1C20E88
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 01:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1927E4A0C;
	Mon,  3 Jun 2024 01:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vUk+8ysU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFCB3236
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717379618; cv=none; b=Jr6+KU0hymOc+6QDMZQhQq24Fiz0XL8gs5ObfklFV1tEIPEY/jFEvyRjda30l9UMH/4ij4hIHxMyrUjQlEMFSdvKC3hINaApgSa8+9Xx6VTncVuKyeF65e7Vt4Cz383P+489hUnEhTWqOE6/Z+fs1zO3Dc9NkeZs7mAbR3mQ7D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717379618; c=relaxed/simple;
	bh=nOG2xsPbOAqsmamziG+KXb4KAAjIbfN3FjSX4ldHGB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tIrpEmoB9wYU9T4OzBVc4/FSwgg+BA4GmqoJnNQiIqNuvJyb8HHPNv3J6iExZDxrxMGPr2ZJ9ZujETk+/D/TBnaa5B8dbfz1J11GwLgdV/gpr1kS8QosVmcW78Tc/nH7z/mB4CBqyOnmE3DPUSYAAkouEIb/QztLA+DNFS+0nrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vUk+8ysU; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717379608; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pjhhZYwivkjRu8TtHAyTGg6htPAN2KoUorXNi9/3dPI=;
	b=vUk+8ysU96VU4S4jgBlxzyts8k2eotetRzyGrdLchpWWJ8BaK7DdoBCMwi3DR7pP22Ku9KZUK8IPZB2l0k3/DVBCzGrk42/NzJ+UvVwgTLPovKXGCIqliRR6BlmivpexfP4LsAFLOYDrb/uAHYh778dSNE7+lhQrI3JzAw6y/VY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R731e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7fmLHU_1717379606;
Received: from 30.97.48.113(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7fmLHU_1717379606)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 09:53:27 +0800
Message-ID: <80e3f7fd-6a1c-4d88-84de-7c34984a5836@linux.alibaba.com>
Date: Mon, 3 Jun 2024 09:53:26 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] get rid of close_fd() misuse in cachefiles
To: Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>,
 Baokun Li <libaokun1@huawei.com>
Cc: Jeffle Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <20240603001128.GG1629371@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240603001128.GG1629371@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Al,

On 2024/6/3 08:11, Al Viro wrote:
> 	fd_install() can't be undone by close_fd().  Just delay it
> until the last failure exit - have cachefiles_ondemand_get_fd()
> return the file on success (and ERR_PTR() on error) and let the
> caller do fd_install() after successful copy_to_user()
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

It's a straight-forward fix to me, yet it will have a conflict with
https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/fs/cachefiles?h=vfs.fixes&id=4b4391e77a6bf24cba2ef1590e113d9b73b11039
https://lore.kernel.org/all/20240522114308.2402121-10-libaokun@huaweicloud.com/

It also moves fd_install() to the end of the daemon_read() and tends
to fix it for months, does it look good to you?

Thanks,
Ga Xiang

