Return-Path: <linux-fsdevel+bounces-20771-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B0E8D7A17
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 04:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F405E1F2180E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 02:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFDF46AF;
	Mon,  3 Jun 2024 02:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GSG8U6F+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD47BB64B
	for <linux-fsdevel@vger.kernel.org>; Mon,  3 Jun 2024 02:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717382025; cv=none; b=m+t4wG/GZpR8Sm4NbcXwJg3MZd+FlRRZyOq7d1sbXjs/PN+ojcDbOufbc0mZAn7GSC16rc+yQ0BPHayF0OrMLsc1S9/Mrh+K6yZ+jwQT/rBVHD5H1RYrwK2g+p4c2g2jCOg71OgkyvhuE13oflf6JBV6Q0SJZHRmwHKJvddDqio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717382025; c=relaxed/simple;
	bh=BP4NW2opTyAbUPlo92AtzqCxpqbL3Z23qXtpki6HmCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tI1y5pOCeQvj0EkuJDkl7HIHld0AYb5Hy14GZGsqQhHKfI3U4j7qn3G7WjqnRGxJEDnT+zHTDjD8vFm+qgF/6Ssdu/7sYTXfYFvzCP63Dabl2dgnzdyx3m/WGKxvZmX4kd75h3lz2JTjeIuU5XQSbyuqwRl2ok97a4PDwdjgQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GSG8U6F+; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717382020; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AsUB/xjwHQK0EuulmLU9C1IXmpORl+ep1cLz5q1MGH0=;
	b=GSG8U6F+CHYuCAi3BwQnkxFjSebx/eR6hIfofZgDrWa4e8t0OVszDlXxkcWV3yxB8lyde1b/f9hog8xeYDAk8QzHHyqcoQElGi8RRNsvgbcMKhpOX7OLIdpz0LDgy/oZyh34/71AgxGnEPUjs8SG61XKOzBfUqW+92SoweuKKB4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W7g-u1p_1717382019;
Received: from 30.97.48.113(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W7g-u1p_1717382019)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 10:33:40 +0800
Message-ID: <49210e35-1cca-4d5a-a099-5a2d7b0390d0@linux.alibaba.com>
Date: Mon, 3 Jun 2024 10:33:38 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] get rid of close_fd() misuse in cachefiles
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Baokun Li <libaokun1@huawei.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, netfs@lists.linux.dev,
 linux-fsdevel@vger.kernel.org
References: <20240603001128.GG1629371@ZenIV>
 <80e3f7fd-6a1c-4d88-84de-7c34984a5836@linux.alibaba.com>
 <20240603022129.GH1629371@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240603022129.GH1629371@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Al,

On 2024/6/3 10:21, Al Viro wrote:
> On Mon, Jun 03, 2024 at 09:53:26AM +0800, Gao Xiang wrote:
>> Hi Al,
>>
>> On 2024/6/3 08:11, Al Viro wrote:
>>> 	fd_install() can't be undone by close_fd().  Just delay it
>>> until the last failure exit - have cachefiles_ondemand_get_fd()
>>> return the file on success (and ERR_PTR() on error) and let the
>>> caller do fd_install() after successful copy_to_user()
>>>
>>> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
>>
>> It's a straight-forward fix to me, yet it will have a conflict with
>> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git/commit/fs/cachefiles?h=vfs.fixes&id=4b4391e77a6bf24cba2ef1590e113d9b73b11039
>> https://lore.kernel.org/all/20240522114308.2402121-10-libaokun@huaweicloud.com/
>>
>> It also moves fd_install() to the end of the daemon_read() and tends
>> to fix it for months, does it look good to you?
> 
> Looks sane (and my variant lacks put_unused_fd(), so it leaks the
> descriptor).  OTOH, I suspect that my variant of calling conventions
> makes for less churn - fd is available anyway, so you just need error
> or file reference, and for that struct file * with ERR_PTR() for
> errors works fine.

Yes, I agree with that, but since these patches are already
in the -next queue.  We could clean up these later with
your idea later, otherwise I'm not sure if some other
implicit inter-dependencies show up..

> 
> Anyway, your variant seems to be correct; feel free to slap my
> ACKed-by on it.

Hi Christian, would you mind take Al's ack for this, and
hopefully upstream these patches? Many thanks!

Thanks,
Gao Xiang

