Return-Path: <linux-fsdevel+bounces-10605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46ACB84CBDF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 14:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84341F23D9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 13:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713CF77F3F;
	Wed,  7 Feb 2024 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DMvqdSz+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9CE7C6EE
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.199.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707313473; cv=none; b=twU4xw0gCfEpo4Zl5/DKgwdCSrBh6VnkVhyn3l0kLWfmjUVCnI+kVok++VnXYi1dpeB48ukG1bOzY1wbrkctzvnN8J0WLC5yl8wTB/SzBWsE33L9/TxwZAT8wgCXMH6TuXi0Yp8gSR9lPT6TzSCGlbONaljArz1QvzjzZo2p6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707313473; c=relaxed/simple;
	bh=ALrdGiWuRblgHxayGiWbLQ2jwsNwQdkP062Ojh8DUpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sn4XZCFz/2fgeW20J2gp0zfkbGGrZXiEJwl423pjuTuKd3h5zGmhDvXImYYAk3fuYz7ip8CSsWtm7Akdep3FCrg8Bzg2NJezuQ9F2fMevRPp0Ax5R37bpeiG0szdhiPnmt688kcKmMymzxGQnP7APnk+jrB+zUWTmZsWUgGAJLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DMvqdSz+; arc=none smtp.client-ip=47.90.199.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1707313454; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=/imwQolNhedsBSOVvwIXGFXYVZ6ftRG5kBY7x9BLVuQ=;
	b=DMvqdSz+tB5DGxSNrnSolFUXzzr96K8o7yUG6Qza0HH4W+BmFKhlCHGfxpArYB9J1dJnUfrOXBdplx1bMqek5FRTlBg+Jq6wPhjBiXXmpXmUgaxn9S5NzSfc55nau/bxLOnxGCp+UnL0l2ejEBJAuycuQ/PBlgnrvpMjkKhOYlI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W0GouTm_1707313452;
Received: from 192.168.31.58(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0W0GouTm_1707313452)
          by smtp.aliyun-inc.com;
          Wed, 07 Feb 2024 21:44:13 +0800
Message-ID: <f365c731-9cc5-4340-9c1e-f6f5ab422140@linux.alibaba.com>
Date: Wed, 7 Feb 2024 21:44:12 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fuse: Create helper function if DIO write needs
 exclusive lock
Content-Language: en-US
To: Bernd Schubert <bernd.schubert@fastmail.fm>,
 Bernd Schubert <bschubert@ddn.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, dsingh@ddn.com,
 Amir Goldstein <amir73il@gmail.com>
References: <20240131230827.207552-1-bschubert@ddn.com>
 <20240131230827.207552-3-bschubert@ddn.com>
 <2d0d6581-14de-46c4-a664-f6e193ab2518@linux.alibaba.com>
 <b9308f8b-cda3-486f-be23-6e84cc0c8b6d@fastmail.fm>
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <b9308f8b-cda3-486f-be23-6e84cc0c8b6d@fastmail.fm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/7/24 9:38 PM, Bernd Schubert wrote:
> 
> 
> On 2/6/24 10:20, Jingbo Xu wrote:
>>
>>
>> On 2/1/24 7:08 AM, Bernd Schubert wrote:
>>> @@ -1591,10 +1616,10 @@ static ssize_t fuse_direct_write_iter(struct kiocb *iocb, struct iov_iter *from)
>>>  	else {
>>>  		inode_lock_shared(inode);
>>>  
>>> -		/* A race with truncate might have come up as the decision for
>>> -		 * the lock type was done without holding the lock, check again.
>>> +		/*
>>> +		 * Previous check was without any lock and might have raced.
>>>  		 */


>>> -		if (fuse_direct_write_extending_i_size(iocb, from)) {
>>> +		if (fuse_dio_wr_exclusive_lock(iocb, from)) {
>> 			^

I mean, in patch 2/5

> -		if (fuse_direct_write_extending_i_size(iocb, from)) {
> +		if (fuse_io_past_eof(iocb, from)) {

is better, otherwise it's not an equivalent change.


Thanks,
Jingbo

