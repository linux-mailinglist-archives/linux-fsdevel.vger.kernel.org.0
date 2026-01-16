Return-Path: <linux-fsdevel+bounces-74183-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A4BD33824
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 17:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 888EC3022336
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 16:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7AF397AC5;
	Fri, 16 Jan 2026 16:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="E0bRkO8D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CB1395D9B;
	Fri, 16 Jan 2026 16:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581015; cv=none; b=r1Qr8LsQl3AIJwU8+jL0D5sV9oix4Yhb1PICpLElqk0MP+ixxoKhk3/f3+mOa/WjadRpAPmdH2AqIqK9oIJi2SNyYcv/QQ2zWu2xcP8rqI5o6cn820tTPcNsohIvZEouU+/P5WsMVVLVVMAvHjNSEjnqgK/WQPa7UjOiHWmP9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581015; c=relaxed/simple;
	bh=k/EyYJ9Vb0MNwftdscpvJYKnWctiUeCgtItI9briY4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oem2kUP4BVzk3xchK/4evdLhRnaZBmHPE0A8+ju27C6W2pIp3pjhVggyqKFOVUOs7uU7CqZRkBh1NIAqYWe6CZqBoudGj6Fy+cSmedgV6Z8YaIqrjkonbe8/keTCLmP9ba3SkIJjdwH8VVQk2Hnb0JgQ5JEGZocmBijWvzXjgeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=E0bRkO8D; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768581009; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RFWiI0wOR2yk+5/0dINJESRV12gsa36QcDUdOJgcoEs=;
	b=E0bRkO8D9duVab45yVLKAIo+ThDdPzzJaxt+590M9j34SQMyS9t9urh8zFpFLgSGbtsuiEOQU5t5Heo4+GC0y46SAEvBFUWGP/kG21wBQTjgDABylRYeSOiYz8mdI7PU+GQKB4HhGMTgjdpUPoa/4xdipEnJsbKE3LB/lte1WsI=
Received: from 30.180.182.138(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxAgrWL_1768581008 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 17 Jan 2026 00:30:09 +0800
Message-ID: <96353e77-6118-4272-be8f-ae1ece5b57a4@linux.alibaba.com>
Date: Sat, 17 Jan 2026 00:30:08 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 0/9] erofs: Introduce page cache sharing feature
To: Christoph Hellwig <hch@lst.de>, Hongbo Li <lihongbo22@huawei.com>
Cc: chao@kernel.org, brauner@kernel.org, djwong@kernel.org,
 amir73il@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20260116095550.627082-1-lihongbo22@huawei.com>
 <20260116153656.GA21174@lst.de>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260116153656.GA21174@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/1/16 23:36, Christoph Hellwig wrote:
> Sorry, just getting to this from my overful inbox by now.
> 
> On Fri, Jan 16, 2026 at 09:55:41AM +0000, Hongbo Li wrote:
>> 2.1. file open & close
>> ----------------------
>> When the file is opened, the ->private_data field of file A or file B is
>> set to point to an internal deduplicated file. When the actual read
>> occurs, the page cache of this deduplicated file will be accessed.
> 
> So the first opener wins and others point to it?  That would lead to
> some really annoying life time rules.  Or you allocate a hidden backing
> file and have everyone point to it (the backing_file related subject
> kinda hints at that), which would be much more sensible, but then the
> above descriptions would not be correct.

Your latter thought is correct, I think the words above
are ambiguous.

> 
>>
>> When the file is opened, if the corresponding erofs inode is newly
>> created, then perform the following actions:
>> 1. add the erofs inode to the backing list of the deduplicated inode;
>> 2. increase the reference count of the deduplicated inode.
> 
> This on the other hand suggests the fist opener is used approach again?

Not quite sure about this part, assuming you read the
patches, it's just similar to the backing_file approach.

> 
>> Assuming the deduplication inode's page cache is PGCache_dedup, there
> 
> What is PGCache_dedup?

Maybe it's just an outdated expression from the older versions
from Hongzhen.  I think just ignore this part.

> 
>> Iomap and the layers below will involve disk I/O operations. As
>> described in 2.1, the deduplicated inode itself is not bound to a
>> specific device. The deduplicated inode will select an erofs inode from
>> the backing list (by default, the first one) to complete the
>> corresponding iomap operation.
> 
> What happens for mmap I/O where folio->mapping is kinda important?

`folio->mapping` will just get the anon inode, but
(meta)data I/Os will submit to one of the real
filesystem (that is why a real inode is needed to
pass into iomap), and use the data to fill the
anon inode page cache, and the anon inode is like
backing_file, and vma->vm_file will point to the
hidden backing file backed by the anon inode .

Thanks,
Gao Xiang

> 
> Also do you have a git tree for the whole feature?


