Return-Path: <linux-fsdevel+bounces-16090-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2570897D28
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 02:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 707A3B2ABD8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 00:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645C211718;
	Thu,  4 Apr 2024 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QKbDMANo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF8DDA3;
	Thu,  4 Apr 2024 00:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712191420; cv=none; b=uC1sPfpaLX9hY1G1FH9gdymmz73zyT5b71+hO/encfBhI2jA9QpUIJAeXRxUEYHcBZUbV9QjdkFLomBbLZb1N49YCN+TkpSB6MOJoRKS6M/LP7YDtwVxbN1dfuOZUwWtKFtDgVBaA0P7vilr9jZ6TBPo10OsnLAeogPB6+EZBQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712191420; c=relaxed/simple;
	bh=RkkOt127jRNBsyC6/SJ5S0q4ZCbfv408pXMS9DOdvf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SZcDETqenSs+qzYSaZxUmluyxViAaiaLKHX9Zf7jsJ/AwY8L69Sd1lBPM1bXhVA+9LROqVrn72SfUkUEvHm9Jq22X5qTUodx1qvhRYjQoErvj1DFdZyQyjM6Ljo9nuYMKbrUfR4L6Yo1K52g+A7+TU6gZUzHrIl+Da3o7pYU1eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QKbDMANo; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712191414; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=WpGECF9etbyajJ44AaV6qklkz1QRbKFBVu7gebo66/o=;
	b=QKbDMANoCLoY3VVtW1NmQ+cBzAtpoTZy++IhzuVib/V//+CSyLw16Gmb+rDYbQhhlGbiNwhjmKOtg4Hn3KVGezK3j4E/+LD3I8YVJ+rbGK0cEhL17OIXWU9FaPgOfMkp/ugQI5vg3DncqnIlKMJr3fMsY4d5WjgbK0uVNrAnvq0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0W3t.vBW_1712191411;
Received: from 192.168.2.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W3t.vBW_1712191411)
          by smtp.aliyun-inc.com;
          Thu, 04 Apr 2024 08:43:33 +0800
Message-ID: <ad7ebace-9146-4824-85fb-d65416ad8895@linux.alibaba.com>
Date: Thu, 4 Apr 2024 08:43:31 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/13] fiemap extension for more physical information
To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>,
 Jonathan Corbet <corbet@lwn.net>, Kent Overstreet
 <kent.overstreet@linux.dev>, Brian Foster <bfoster@redhat.com>,
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-bcachefs@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 kernel-team@meta.com
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
 <dce83785-af96-4ff8-9552-56d73b5daf98@linux.alibaba.com>
 <2896ee5a-b381-45eb-abc0-54e914605e46@dorminy.me>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2896ee5a-b381-45eb-abc0-54e914605e46@dorminy.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 2024/4/3 23:11, Sweet Tea Dorminy wrote:
> 
>>
>> I'm not sure why here iomap was excluded technically or I'm missing some
>> previous comments?
>>
>>
>> Could you also make iomap support new FIEMAP physical extent information?
>> since compressed EROFS uses iomap FIEMAP interface to report compressed
>> extents ("z_erofs_iomap_report_ops") but there is no way to return
>> correct compressed lengths, that is unexpected.
>>
> 
> I'll add iomap support in v4, I'd skipped it since I was worried it'd be an expansive additional part not necessary initially. Thank you for noting it!

Thanks, I think just fiemap report for iomap seems straight-forward.
Thanks for your work!

Thanks,
Gao Xiang

> 
> Sweet Tea

