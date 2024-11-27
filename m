Return-Path: <linux-fsdevel+bounces-35946-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3429DA040
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 02:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE3A9B23578
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Nov 2024 01:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6C88BE5;
	Wed, 27 Nov 2024 01:26:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B82128E8
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Nov 2024 01:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732670813; cv=none; b=GLPJjCdbEQZZWG23W4P10+r2SQshgGCDcczNMmmsSHoDuFAeaDEc4XRhefWvFn+8m6YwRRG93satx0PmYmeAhlYDyu/ISL0x66vqMfpYs5tn1NWFAsQVRgOdCL4IoQmdlRfDTsfL7cwRNLs3d7+1je8dBK13pkjwQAo427R9Yes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732670813; c=relaxed/simple;
	bh=wXhRyaXuEh5tcfbqXPqnwZ1CuLfEQ6gk9lbWRFMDyF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AcJROrkSioul7FtScUoyqKnbY1LZ0+wcHWitexZFi4pqM7awZO3u91u03YWOjZxq6C4F2YfHVVZmqO3Wz/UAqn0RiFkkRWIzSZ1pfAc3EwR3E/RfSNok+p1PUQxfh7cDK0d6DxK3K77LQsMaSMBT9QkzqeOnxFOx6fbmDKhw+ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XyhYF11t4zPptQ;
	Wed, 27 Nov 2024 09:24:01 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 966C71800F2;
	Wed, 27 Nov 2024 09:26:47 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 27 Nov 2024 09:26:47 +0800
Message-ID: <5e5e465e-0380-4fbf-915d-69be5a8e0b65@huawei.com>
Date: Wed, 27 Nov 2024 09:26:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML mount failure with Linux 6.11
To: Johannes Berg <johannes@sipsolutions.net>, Karel Zak <kzak@redhat.com>
CC: <linux-um@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>,
	<rrs@debian.org>
References: <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
 <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
 <b0acfbdf-339b-4f7b-9fbd-8d864217366b@huawei.com>
 <buizu3navazyzdg23dsphmdi26iuf5mothe3l4ods4rbqwqfnh@rgnqbq7n4j4g>
 <9f56df34-68d4-4cb1-9b47-b8669b16ed28@huawei.com>
 <3d5e772c-7f13-4557-82ff-73e29a501466@huawei.com>
 <ykwlncqgbsv7xilipxjs2xoxjpkdhss4gb5tssah7pjd76iqxf@o2vkkrjh2mgd>
 <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <6e6ccc76005d8c53370d8bdcb0e520e10b2b7193.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/11/26 21:50, Johannes Berg wrote:
> On Mon, 2024-11-25 at 18:43 +0100, Karel Zak wrote:
>>
>> The long-term solution would be to clean up hostfs and use named
>> variables, such as "mount -t hostfs none -o 'path="/home/hostfs"'.
> 
> That's what Hongbo's commit *did*, afaict, but it is a regression.
> 
> Now most of the regression is that with fsconfig() call it was no longer
> possible to specify a bare folder, and then we got discussing what
> happens if the folder name actually contains a comma...
> 
> But this is still a regression, so we need to figure out what to do
> short term?
> 
So for short term, even long term, can we consider handling the hostfs 
situation specially within libmount? Such as treat the whole option as 
one key(also may be with comma, even with equal), in this case, libmount 
will use it as FSCONFIG_SET_FLAG. We can do that because for hostfs, it 
only has one mount option, and no need for extension.

Thanks,
Hongbo

> Ignoring the "path with comma" issue, because we can't even fix that in
> the kernel given what you describe changed in userspace, we can probably
> only
> 
>   1) revert the hostfs conversion to the new API, or
>   2) somehow not require the hostfs= key?
> 
> I don't know if either of those are even possible
> 
> 
> Fixing the regression fully (including for paths containing commas)
> probably also requires userspace changes. If you don't want to make
> those we can only point to your workarounds instead, since we can't do
> anything on the kernel side.
> 
> I don't know the fsconfig() API, is it possible to have key-less or
> value-less calls? What does happen
> 
> johannes
> 

