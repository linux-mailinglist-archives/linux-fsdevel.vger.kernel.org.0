Return-Path: <linux-fsdevel+bounces-16712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1EA68A1C3E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 19:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AF5B1C21F8A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 17:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA25215B974;
	Thu, 11 Apr 2024 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="pjdyPIsi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8C243171;
	Thu, 11 Apr 2024 16:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712852032; cv=none; b=ftMFbRxq77UckKF3XO1ESlm1HX5BF4/xd5Z9EAVBHQoSF/8iHg1cgxQcfetg4q6pptzpax6NM6fyCS+mqimoCuDQT9K0PuGDu2st+7AOFHdxrN/gDK9dJYC8LEyl46sINp3jWpfwssdIHjQWp8ahotUkXvNY4a181xDypMkz/EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712852032; c=relaxed/simple;
	bh=evtsIG6x6Yz6zeuupS4HiOT3wfAwZTOiHxGTCrmvKw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XNuZ5QmSxsD0GhNYW7OBF2bPBhv5+HaQ8qJdGlBdoz5mzHJLb2PChrqDhiPQt7M4/KcdG5Q5rxgmIZdSbrdf9oOvgHVLPokJzSqburUgP6VeX6cKy5DJNQYjXhRoQSCvqUJuAa55CjWCErNSU/+Rpyb9Skud98qGt6g4fzPCDPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=pjdyPIsi; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712852025; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=i28s5n6Wi5wy2FzpIgLktF1Mrc755I0vQ0l4zk5yxBI=;
	b=pjdyPIsi86ySuz4iqFOxMv9ZMQN2S9ni8goTD6AN2wtUNaV6jMrrvA3zhSpLy/7s6DFMm+qdGFAUR1AM/2Qekjioz2yxPoAzTfNu8EQL+/ShxJ9IaLJOjZ4/FIWTfyW6IPS3XCPkjXOxCRnCkVpiKzJckNnAzLGm5TleywQ3RcU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4LiTJx_1712852023;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W4LiTJx_1712852023)
          by smtp.aliyun-inc.com;
          Fri, 12 Apr 2024 00:13:44 +0800
Message-ID: <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
Date: Fri, 12 Apr 2024 00:13:42 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs.all 08/26] erofs: prevent direct access of bd_inode
To: Al Viro <viro@zeniv.linux.org.uk>, Yu Kuai <yukuai1@huaweicloud.com>
Cc: jack@suse.cz, hch@lst.de, brauner@kernel.org, axboe@kernel.dk,
 linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240407040531.GA1791215@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Al,

On 2024/4/7 12:05, Al Viro wrote:
> On Sat, Apr 06, 2024 at 05:09:12PM +0800, Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> Now that all filesystems stash the bdev file, it's ok to get inode
>> for the file.
> 
> Looking at the only user of erofs_buf->inode (erofs_bread())...  We
> use the inode for two things there - block size calculation (to get
> from block number to position in bytes) and access to page cache.
> We read in full pages anyway.  And frankly, looking at the callers,
> we really would be better off if we passed position in bytes instead
> of block number.  IOW, it smells like erofs_bread() having wrong type.
> 
> Look at the callers.  With 3 exceptions it's
> fs/erofs/super.c:135:   ptr = erofs_bread(buf, erofs_blknr(sb, *offset), EROFS_KMAP);
> fs/erofs/super.c:151:           ptr = erofs_bread(buf, erofs_blknr(sb, *offset), EROFS_KMAP);
> fs/erofs/xattr.c:84:    it.kaddr = erofs_bread(&it.buf, erofs_blknr(sb, it.pos), EROFS_KMAP);
> fs/erofs/xattr.c:105:           it.kaddr = erofs_bread(&it.buf, erofs_blknr(sb, it.pos),
> fs/erofs/xattr.c:188:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
> fs/erofs/xattr.c:294:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
> fs/erofs/xattr.c:339:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(it->sb, it->pos),
> fs/erofs/xattr.c:378:           it->kaddr = erofs_bread(&it->buf, erofs_blknr(sb, it->pos),
> fs/erofs/zdata.c:943:           src = erofs_bread(&buf, erofs_blknr(sb, pos), EROFS_KMAP);
> 
> and all of them actually want the return value + erofs_offset(...).  IOW,
> we take a linear position (in bytes).  Divide it by block size (from sb).
> Pass the factor to erofs_bread(), where we multiply that by block size
> (from inode), see which page will that be in, get that page and return a
> pointer *into* that page.  Then we again divide the same position
> by block size (from sb) and add the remainder to the pointer returned
> by erofs_bread().
> 
> IOW, it would be much easier to pass the position directly and to hell
> with block size logics.  Three exceptions to that pattern:
> 
> fs/erofs/data.c:80:     return erofs_bread(buf, blkaddr, type);
> fs/erofs/dir.c:66:              de = erofs_bread(&buf, i, EROFS_KMAP);
> fs/erofs/namei.c:103:           de = erofs_bread(&buf, mid, EROFS_KMAP);
> 
> Those could bloody well multiply the argument by block size;
> the first one (erofs_read_metabuf()) is also interesting - its
> callers themselves follow the similar pattern.  So it might be
> worth passing it a position in bytes as well...
> 
> In any case, all 3 have superblock reference, so they can convert
> from blocks to bytes conveniently.  Which means that erofs_bread()
> doesn't need to mess with block size considerations at all.
> 
> IOW, it might make sense to replace erofs_buf->inode with
> pointer to address space.  And use file_mapping() instead of
> file_inode() in that patch...

Just saw this again by chance, which is unexpected.

Yeah, I think that is a good idea.  The story is that erofs_bread()
was derived from a page-based interface:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/data.c?h=v5.10#n35

so it was once a page index number.  I think a byte offset will be
a better interface to clean up these, thanks for your time and work
on this!

BTW, sightly off the topic:

I'm little confused why I'm not be looped for this version this time
even:

  1) I explicitly asked to Cc the mailing list so that I could find
     the latest discussion and respond in time:
      https://lore.kernel.org/r/5e04a86d-8bbd-41da-95f6-cf1562ed04f9@linux.alibaba.com

  2) I sent my r-v-b tag on RFC v4 (and the tag was added on this
     version) but I didn't receive this new version.

Thanks,
Gao Xiang

