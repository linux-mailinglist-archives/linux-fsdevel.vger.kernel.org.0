Return-Path: <linux-fsdevel+bounces-22741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 104F291B855
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 09:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8AEA1F224D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 07:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDE13F43A;
	Fri, 28 Jun 2024 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Nb8OWQLg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5D12D05E;
	Fri, 28 Jun 2024 07:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719559842; cv=none; b=WK4/VT6YTAS6TmV3z8QLjqArLjSS0wb5AMh2JNuxvpglRhv93RtkDcz3CuJgkq9EEz8oBth2aqCzey9t7WgET5/rZK/sGko7X+iX7dPLIp6zc/oSeg3QFSf4PA0uRcKJlso/wDkem5I5IjV0X/hsONgbQYcA97tH/ypVTFnZQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719559842; c=relaxed/simple;
	bh=9DjJsXx99iqs0CwhlzUJW8Y4ZcRpPL1NAmZ/+KNhQn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPHvbteXs5rn6LcDnk/xUeoR3B0haxbsT56EXz6jqw9AIw5Qxu0oTdRBmUihyQky5wyQKvqqjYbHillmx0UlbUrLKXPkp4PNGKd361HGPrvY8Tlb+2dchD7GnSrZvmSAxvtwILSeseQWPd1GukfeWIvoSv6nvDpiZmtKyO0XSQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Nb8OWQLg; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719559837; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eyQs0tMPU81R2eg4ZErSJAcR3SHyXy5n22wLWs/5v64=;
	b=Nb8OWQLguMXl+MDHpJ/x0yyIJANIepdj6E/cKQL4N1LPEmrlkzW2i+USMs5CmbtfqnQnBExHfAmdGcWEwDeP8ldVxuM5mNl28VszkGJ1rKOr+z0bQrov6S8yw1bl2HLKEvFbGYpzD17lj1wHMOIbdyyzXxG2rjpAmUHnU9N7LEU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W9PYgHp_1719559835;
Received: from 30.97.48.160(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9PYgHp_1719559835)
          by smtp.aliyun-inc.com;
          Fri, 28 Jun 2024 15:30:36 +0800
Message-ID: <47a91a45-7e36-45e0-891f-475adca77f59@linux.alibaba.com>
Date: Fri, 28 Jun 2024 15:30:35 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] cachefiles: propagate errors from vfs_getxattr()
 to avoid infinite loop
To: libaokun@huaweicloud.com, netfs@lists.linux.dev, dhowells@redhat.com,
 jlayton@kernel.org
Cc: jefflexu@linux.alibaba.com, zhujia.zj@bytedance.com,
 linux-erofs@lists.ozlabs.org, brauner@kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yangerkun@huawei.com, houtao1@huawei.com, yukuai3@huawei.com,
 wozizhi@huawei.com, Baokun Li <libaokun1@huawei.com>
References: <20240628062930.2467993-1-libaokun@huaweicloud.com>
 <20240628062930.2467993-5-libaokun@huaweicloud.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240628062930.2467993-5-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/6/28 14:29, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In cachefiles_check_volume_xattr(), the error returned by vfs_getxattr()
> is not passed to ret, so it ends up returning -ESTALE, which leads to an
> endless loop as follows:
> 
> cachefiles_acquire_volume
> retry:
>    ret = cachefiles_check_volume_xattr
>      ret = -ESTALE
>      xlen = vfs_getxattr // return -EIO
>      // The ret is not updated when xlen < 0, so -ESTALE is returned.
>      return ret
>    // Supposed to jump out of the loop at this judgement.
>    if (ret != -ESTALE)
>        goto error_dir;
>    cachefiles_bury_object
>      //  EIO causes rename failure
>    goto retry;
> 
> Hence propagate the error returned by vfs_getxattr() to avoid the above
> issue. Do the same in cachefiles_check_auxdata().
> 
> Fixes: 32e150037dce ("fscache, cachefiles: Store the volume coherency data")
> Fixes: 72b957856b0c ("cachefiles: Implement metadata/coherency data storage in xattrs")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

It looks good to me,
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

