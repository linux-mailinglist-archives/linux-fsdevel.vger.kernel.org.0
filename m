Return-Path: <linux-fsdevel+bounces-11425-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1489853B7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 20:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69113B28471
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Feb 2024 19:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413B66089F;
	Tue, 13 Feb 2024 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="FdhVOZwn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D14360DC2;
	Tue, 13 Feb 2024 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853577; cv=none; b=aIttM3m1+kc3iT88OoEFgQ0U8UouADl54ujP7HddjUe/HCghPFd5T24T7PBhVQIjxRtfGvBYeQ30AVGdX6bOCXkJONiAd/9hXzs2gFaj56Bs6TdcVZa7ZCOTg+X1v9KDUfzYYaYG7QvkT75qLXFyovZNTEUY7tBWLUB4adMbbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853577; c=relaxed/simple;
	bh=91fMcwc23t/9Ue36JL2amNbWqAs6AjesdadtoLuKu0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw2v3f/n35s4vkq05zMvRyifsJtQYSdxOaCOdaRISvYL61cwJIUnLKNlk4HKCPHG4epS7/PkZdxtQedRf5s+LZV6WW8xBHGVCSbUCd7MExx1yCItKIv3FxNCYVNZZGG6K3vtr1wRvSG0m6BxDoUw8BMJgj+RjgARKcyRPtYFeQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=FdhVOZwn; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1707853565;
	bh=91fMcwc23t/9Ue36JL2amNbWqAs6AjesdadtoLuKu0M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FdhVOZwnEphOvwoVCm/OLjFElpH0U2cr0/fOq2wMSCpthaCO33T56W6XQ4mQiOUhe
	 SX2qxP+8yLW9KYYxyqxWi2J5VQv5bfpYrsWxwzfnaWwWiEDDvXarA+Z3spkl8GOhfv
	 gAZmKFyTk31OtlM/cGs+Z7j1P4Xl3jrfRgoxV6XSbAucQ1qdmLAqfJqL9h7n2igwRv
	 /lv+D8Nm6bI+wjjfL4io04GN7Lo4fU8FOJ2Lo2uJXk2jSd5rRT+vE8/aZlO2nbuffk
	 az9OgSu5jDtvYnxfk832jOr2vqOKLTK/ZQQ/Zqpmopd4D0XQTwtqTOtI41nj3XlSFR
	 Sj1mzC+AAMlZQ==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TZBdn2yXnzYPf;
	Tue, 13 Feb 2024 14:46:05 -0500 (EST)
Message-ID: <c0a08e00-e7b5-48ac-a152-3068ab0c9e15@efficios.com>
Date: Tue, 13 Feb 2024 14:46:05 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/8] virtio: Treat alloc_dax() -EOPNOTSUPP failure as
 non-fatal
Content-Language: en-US
To: Lukas Wunner <lukas@wunner.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-xfs@vger.kernel.org, dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
 linux-s390@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>
References: <20240212163101.19614-1-mathieu.desnoyers@efficios.com>
 <20240212163101.19614-6-mathieu.desnoyers@efficios.com>
 <20240213062559.GA27364@wunner.de>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240213062559.GA27364@wunner.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-13 01:25, Lukas Wunner wrote:
> On Mon, Feb 12, 2024 at 11:30:58AM -0500, Mathieu Desnoyers wrote:
>> In preparation for checking whether the architecture has data cache
>> aliasing within alloc_dax(), modify the error handling of virtio
>> virtio_fs_setup_dax() to treat alloc_dax() -EOPNOTSUPP failure as
>> non-fatal.
>>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Fixes: d92576f1167c ("dax: does not work correctly with virtual aliasing caches")
> 
> That's a v4.0 commit, yet this patch uses DEFINE_FREE() which is
> only available in v6.6 but not any earlier stable kernels.

I asked this question to Greg KH before creating this patch, and his
answer was to implement my fix for master, and stable kernels would take
care of backporting all the required dependencies.

Now if I look at latest 6.1, 5.15, 5.10, 5.4, 4.19 stable kernels,
none seem to have include/linux/cleanup.h today. But I suspect that
sooner or later relevant master branch fixes will require stable
kernels to backport cleanup.h, so why not do it now ?

Thanks,

Mathieu


> 
> So the Fixes tag feels a bit weird.
> 
> Apart from that,
> Reviewed-by: Lukas Wunner <lukas@wunner.de>

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


