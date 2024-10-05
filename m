Return-Path: <linux-fsdevel+bounces-31059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 617B499176D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 16:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF61FB21A02
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Oct 2024 14:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404DB1547C9;
	Sat,  5 Oct 2024 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xh6bJIAw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C781ACA
	for <linux-fsdevel@vger.kernel.org>; Sat,  5 Oct 2024 14:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728139282; cv=none; b=P9rYChRwWWbgiZNksYo/gBUfRGEHvjkK8VAwl2bmn5nx+EPe2Ua4F+xqK2EP16MIcguDZwRQvrQk9rWvXOqRxNJDw2Zzlv0PvznjX6+FqewYgW8eQDY+hFozGC+vM9mFXKOg/CFm2fvV2+AN7ZmHZHEN/dKZNTDXBmSQCzQD4S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728139282; c=relaxed/simple;
	bh=zdN3odiCeMpuSGQyeQ6wHY/zmVuF8mJGsZkKnkIQvHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=D6XYvM3A8CZRkjgunOpKDiHTM2dZ50et44qguiSolj4GZ4wRYSLYsDocwnirF9GBX15TQP2RI9U9pwq1MGHEhrbYJDW66ciR43uvte289snLEihRbA12VHtinfbOOB/VfFFF64sn4PnOWhX2rLovzNN+rxiyLO6I+hdW8a6oDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xh6bJIAw; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728139272; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=gCbXyy0cblcXk7UDUVtGH5kGEQ3mspdwjmhYqK8wCyo=;
	b=xh6bJIAwCVUQFsumCqQfi7fJMpG80qSkYZF3noqzWcXFXWXDjPFGJu+M88pFBRpJ/sZVb7oRqRLBeunLilz2quxpPi37r8k0jYck8vmlbOCe/sZMjFM4AsbHquLaLTIlI65P8N2vMEqw7Koa8HX9yJdt+9TygYnsTBiDAtIy9d4=
Received: from 192.168.2.29(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGHfK9X_1728139270)
          by smtp.aliyun-inc.com;
          Sat, 05 Oct 2024 22:41:11 +0800
Message-ID: <bb781cf6-1baf-4a98-94a5-f261a556d492@linux.alibaba.com>
Date: Sat, 5 Oct 2024 22:41:10 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incorrect error message from erofs "backed by file" in 6.12-rc
To: Allison Karlitskaya <allison.karlitskaya@redhat.com>,
 Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
References: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Allison,

(try to +Cc Christian)

On 2024/10/2 20:58, Allison Karlitskaya wrote:
> hi,
> 
> In context of my work on composefs/bootc I've been testing the new support for directly mounting files with erofs (ie: without a loopback device) and it's working well.  Thanks for adding this feature --- it's a huge quality of life improvement for us.
> 
> I've observed a strange behaviour, though: when mounting a file as an erofs, if you read() the filesystem context fd, you always get the following error message reported: Can't lookup blockdev.
> 
> That's caused by the code in erofs_fc_get_tree() trying to call get_tree_bdev() and recovering from the error in case it was ENOTBLK and CONFIG_EROFS_FS_BACKED_BY_FILE.  Unfortunately, get_tree_bdev() logs the error directly on the fs_context, so you get the error message even on successful mounts.
> > It looks something like this at the syscall level:
> 
> fsopen("erofs", FSOPEN_CLOEXEC)         = 3
> fsconfig(3, FSCONFIG_SET_FLAG, "ro", NULL, 0) = 0
> fsconfig(3, FSCONFIG_SET_STRING, "source", "/home/lis/src/mountcfs/cfs", 0) = 0
> fsconfig(3, FSCONFIG_CMD_CREATE, NULL, NULL, 0) = 0
> fsmount(3, FSMOUNT_CLOEXEC, 0)          = 5
> move_mount(5, "", AT_FDCWD, "/tmp/composefs.upper.KuT5aV", MOVE_MOUNT_F_EMPTY_PATH) = 0
> read(3, "e /home/lis/src/mountcfs/cfs: Can't lookup blockdev\n", 1024) = 52
> 
> This is kernel 6.12.0-0.rc0.20240926git11a299a7933e.13.fc42.x86_64 from Fedora Rawhide.
> 
> It's a pretty minor issue, but it sent me on a wild goose chase for an hour or two, so probably it should get fixed before the final release.
> 

Sorry for late response. I'm on vacation recently.

Yes, I also observed this message, but I'm not sure
how to handle it better.  Indeed, the message itself
is out of get_tree_bdev() as you said.

Yet I tend to avoid unnecessary extra lookup_bdev()
likewise to confirm the type of the source in advance,
since the majority mount type of EROFS is still
bdev-based instead file-based so I tend to make
file-based mount as a fallback...

Hi Christian, if possible, could you give some other
idea to handle this case better? Many thanks!

Thanks,
Gao Xiang

> Thanks again for this awesome feature!
> 
> Allison Karlitskaya


