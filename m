Return-Path: <linux-fsdevel+bounces-17845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6428B2D8C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Apr 2024 01:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ACD1C21C38
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 23:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E789E156997;
	Thu, 25 Apr 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vzSAlPZl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8559B156655;
	Thu, 25 Apr 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714087349; cv=none; b=sM6553PtVgfgOPf/qMfMVqkdEhLRB79LMWkbsjl+6Rc9orlnP7863ZPoR0FlhrQbUz6gPSPhAfxNqD6HQcFQmY9GAxUQN5h9ky6nnAf3sn8HHuZ++M2qWDE8Xb67c175ILFQRLSv31R9WJYUErgQGuWmbofHL4ZcMnD3CECmLoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714087349; c=relaxed/simple;
	bh=dRp6JaHDxGxz2lxzI2b56sUndPwMeli8MnALnCX8GRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qp/kBXq9X1Nit7Wipm4jEaAFIcLFSMKBAzzrAFylVBGZ6kEUzjOZPJdT40HNhFESPQ8xkdgsFWQV3gEmrBFP43llao8+5e60mkpIjNxYaN6CbuTJg1WJ1EkYjBB2DipQn4BxkPbMr3UZ4TLxBL9aBjTDo7MZQLq3Zbs0jdnpv5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vzSAlPZl; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714087343; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=LNAFLzKfa5asTQif+KQv5a4+XeE0zy0NfPO0NMRW4Jk=;
	b=vzSAlPZlGzlCxbgNpN1w8hscetrlIZ0LTf8uzRBpzWo/PHMzEWFbO29dPXn9NTy5KI8yQxfxXP8e+KztjAJJw+m48aVAu535XyYN4h5hv0AG5PmPNz3lj/RO6i2+sGbaSU1iqq5xCf4nUgnehp7YWQ7soHXDJ7XCxpPgX8ePN6w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5GYu4o_1714087339;
Received: from 30.25.226.163(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5GYu4o_1714087339)
          by smtp.aliyun-inc.com;
          Fri, 26 Apr 2024 07:22:22 +0800
Message-ID: <e2781e10-6d5c-4130-805c-89087c24c131@linux.alibaba.com>
Date: Fri, 26 Apr 2024 07:22:18 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH vfs.all 08/26] erofs: prevent direct access of bd_inode
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yu Kuai <yukuai1@huaweicloud.com>, jack@suse.cz, hch@lst.de,
 brauner@kernel.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
 linux-block@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com,
 yukuai3@huawei.com
References: <20240406090930.2252838-1-yukuai1@huaweicloud.com>
 <20240406090930.2252838-9-yukuai1@huaweicloud.com>
 <20240407040531.GA1791215@ZenIV>
 <a660a238-2b7e-423f-b5aa-6f5777259f4d@linux.alibaba.com>
 <20240425195641.GJ2118490@ZenIV>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240425195641.GJ2118490@ZenIV>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Al,

On 2024/4/26 03:56, Al Viro wrote:
> On Fri, Apr 12, 2024 at 12:13:42AM +0800, Gao Xiang wrote:

...

>>
>> Just saw this again by chance, which is unexpected.
>>
>> Yeah, I think that is a good idea.  The story is that erofs_bread()
>> was derived from a page-based interface:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/erofs/data.c?h=v5.10#n35
>>
>> so it was once a page index number.  I think a byte offset will be
>> a better interface to clean up these, thanks for your time and work
>> on this!
> 
> FWIW, see #misc.erofs and #more.erofs in my tree; the former is the
> minimal conversion of erofs_read_buf() and switch from buf->inode
> to buf->mapping, the latter follows that up with massage for
> erofs_read_metabuf().
> 
> Completely untested; it builds, but that's all I can promise.  Individual
> patches in followups.

Thanks for so much time on this, I will review/test/feedback
these patches by the end of this week since an internal project
for my employer is also ongoing.

Thanks,
Gao Xiang

