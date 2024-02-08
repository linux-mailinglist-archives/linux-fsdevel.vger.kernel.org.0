Return-Path: <linux-fsdevel+bounces-10862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C76E84EBD0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 23:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5771F245CB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Feb 2024 22:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BDE50272;
	Thu,  8 Feb 2024 22:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="AeGeX7kQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0DC482F2;
	Thu,  8 Feb 2024 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707432139; cv=none; b=OUmwGJbsDQ89bvrd6EFNCmVk7zdNjpg1fm3fB0lf4xEarjtfk0/YOaJCRIdRFsuHnizbgZjZBURcWhO2UJcoMv7B2fQeIOgYirIR3g5YSGCN9BQ2+9LyA8Q/h6IYJiaxdntQHwwoCFFgwENP1umUKBgcqhlM/XdOOIn+5O/5k8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707432139; c=relaxed/simple;
	bh=NhfI9CxiogmvQ0tMHv4XKQ/4Wsf7q5uvmw1GU45BQKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kJcViq5/bfi/HucI4awXnzsUEGCzhRM5ca/3+JjSaXWC6jhugpogsWHkqCDC87qtMlOv06WkGhu+Mk18P8jHABhdGxSLoi2vGWynIUAZnaRWWoa0zxflu5ALzLtk552zjH3oKJTYTmhBfn/JoLOUiO13W4ibim0fnbXShEpBoME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=AeGeX7kQ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707432135;
	bh=NhfI9CxiogmvQ0tMHv4XKQ/4Wsf7q5uvmw1GU45BQKQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AeGeX7kQ49yC5AcFerxBLe7y0eJHatSpT7NcXeuTVU3oluYj8errrXmqswmseoPDt
	 D3ah1MieEHfNwBYykfLwXfXMMJbWeH5Zqo33eaidaJZ1q+zAH9sZN2YmfxvMKEjwHu
	 5j2FukA0KclYpCmLbg7kz7Wjwu5xKanWlKr6Bk8cW+OSlDRriqz7L6zshIVtQRAyp9
	 ZO2cU55CX/E18xCLyVCPeykZB4Mg1jf69kP7nxVaPDwcPX1LiA+FTLz4/TivoHzyJo
	 3vmVzcWJiVPjogNnn1zBLhuRHyDt53WwNUxVQ31iSPU5xO5LMeNLKZljKT5OBcmDB6
	 j43QH2gh7IKEQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TWBnM0z5GzY2Z;
	Thu,  8 Feb 2024 17:42:15 -0500 (EST)
Message-ID: <5328e7f0-0864-4626-aa6c-fef5f3f62dc8@efficios.com>
Date: Thu, 8 Feb 2024 17:42:21 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/12] dax: Check for data cache aliasing at runtime
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org
References: <20240208184913.484340-1-mathieu.desnoyers@efficios.com>
 <20240208184913.484340-7-mathieu.desnoyers@efficios.com>
 <65c54a13c52e_afa429444@dwillia2-xfh.jf.intel.com.notmuch>
 <0e6792eb-7504-464a-aefd-d2a803adb440@efficios.com>
 <65c557a2e77f7_afa429490@dwillia2-xfh.jf.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65c557a2e77f7_afa429490@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-08 17:37, Dan Williams wrote:
> Mathieu Desnoyers wrote:
>> On 2024-02-08 16:39, Dan Williams wrote:
>> [...]
>>>
>>> So per other feedback on earlier patches, I think this hunk deserves to
>>> be moved to its own patch earlier in the series as a standalone fixup.
>>
>> Done.
>>
>>>
>>> Rest of this patch looks good to me.
>>
>> Adding your Acked-by to what is left of this patch if OK with you.
> 
> You can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> 
> ...after that re-org.

Just to make sure: are you OK with me adding your Reviewed-by
only for what is left of this patch, or also to the other driver
patches after integrating your requested changes ?

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


