Return-Path: <linux-fsdevel+bounces-10087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309B7847A65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE47329065C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BEE81742;
	Fri,  2 Feb 2024 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="j0YbsdI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB578062E;
	Fri,  2 Feb 2024 20:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706905119; cv=none; b=d49LNG+8uzbVwouRZSquhxnfRxL6+Ghqyme4OJwoeqcAM2Y5BoBbEtS5ErchDTSpdI7NcBzeSsaP6SexgKdOgSWp2yR3OUkEaJwILPaRCqQor/wkrQMbFxY0WWgyLeEmxXjHDtAn/H5sngKSd190gNidxnNCB9Zf2iDA+q3IuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706905119; c=relaxed/simple;
	bh=mh+mo38fsEQgb9l3Kuwv1eN4wevPn1ndoe/G9f1R3Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uHn5/lGzD9U37WtlaMGvwzelWDLRrcQIDnJCfepOltQ5rDb4MJuMAFXwkM6HC1hBrW3/ilGHEthFcS5qF3tjFjMM2i3q5Q6q4gwR3kQ3qWEjDdyGhmKdu8UdXe2mmHMRIMExcx3ve0dHOyWy0idtQje/U2h/bfGF1aDqWggLwwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=j0YbsdI3; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706905115;
	bh=mh+mo38fsEQgb9l3Kuwv1eN4wevPn1ndoe/G9f1R3Wg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j0YbsdI3y6vCPgWvcLlBfSENnF1fM18wQKlrQ47Z6vS/Lu+5uXdTUXoJtf3p1E10p
	 20YTd4Yysds9Fc8+0b6V+OsfbT17mhbkv37sH0RogmtvLcyJvkNXvcbLGe74TWbrhS
	 HUx5JRvOie7xZ1Qqhc3oXMoE8WJJLhi/VkVjuI8CQ7qNhPK+No8OaIzt+DQfEKdgYt
	 woV0Cd/riDC8CadDDjBDCpwxlRatUyiNLEwFXzLL03k+hlFBnEBK1c1gytA7iBfe3e
	 AMPZTBIMrqrQGCYQEWxcSx259uC6FjHPECXXrtL/pbBU/8IJthIyCDSvplBrQc2OEO
	 hD2B6tCO0gM5A==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TRRtM1f6yzXBq;
	Fri,  2 Feb 2024 15:18:35 -0500 (EST)
Message-ID: <f3ec50a5-ff5e-41ae-ab2f-7319a18381e2@efficios.com>
Date: Fri, 2 Feb 2024 15:18:36 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 2/4] dax: Check for data cache aliasing at runtime
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, Arnd Bergmann <arnd@arndb.de>,
 Dave Chinner <david@fromorbit.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
 Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>,
 Russell King <linux@armlinux.org.uk>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 dm-devel@lists.linux.dev
References: <20240131162533.247710-1-mathieu.desnoyers@efficios.com>
 <20240131162533.247710-3-mathieu.desnoyers@efficios.com>
 <65bab567665f3_37ad2943c@dwillia2-xfh.jf.intel.com.notmuch>
 <0a38176b-c453-4be0-be83-f3e1bb897973@efficios.com>
 <65bac71a9659b_37ad29428@dwillia2-xfh.jf.intel.com.notmuch>
 <f1d14941-2d22-452a-99e6-42db806b6d7f@efficios.com>
 <65bd284165177_2d43c29443@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6bdf6085-101d-47ef-86f4-87936622345a@efficios.com>
 <65bd457460fb1_719322942@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <5e838147-524c-40e5-b106-e388bf4e549b@efficios.com>
 <65bd4d18cab98_7193229421@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <65bd4d18cab98_7193229421@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-02-02 15:14, Dan Williams wrote:
> Mathieu Desnoyers wrote:
> [..]
>>> Thanks for that. All of those need to be done before the fs goes live
>>> later in virtio_device_ready(), but before that point nothing should be
>>> calling into virtio_fs_dax_ops, so as far as I can see it is safe to
>>> change the order.
>>
>> Sounds good, I'll do that.
>>
>> I will soon be ready to send out a RFC v4, which is still only
>> compiled-tested. Do you happen to have some kind of test suite
>> you can use to automate some of the runtime testing ?
> 
> There is a test suite for the pmem, dm, and dax changes
> (https://github.com/pmem/ndctl?tab=readme-ov-file#unit-tests), but not
> automated unfortunately. The NVDIMM maintainer team will run that before
> pushing patches out to the fixes branch if you just want to lean on
> that. For the rest I think we will need to depend on tested-by's from
> s390 + virtio_fs folks, and / or sufficient soak time in linux-next.

I suspect this will be necessary. There are just so many combinations
of architectures, drivers and filesystems involved here that I don't
think it is realistic to try to do all this testing manually on my own.

I prefer to voice this up front, so there are no misplaced expectations
about testing.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


