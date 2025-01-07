Return-Path: <linux-fsdevel+bounces-38510-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED10A034D4
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 03:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 109101641F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jan 2025 02:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6BC078F32;
	Tue,  7 Jan 2025 02:01:40 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62625ECC;
	Tue,  7 Jan 2025 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736215300; cv=none; b=c2er1fDxF5ScmNYY9uGnDAWU+K+7s3HzYCTTLyC0JpN2YHDxujtpMXNKN18HxSzLO2mKJRVT/eEug8HSvR2iw0vyeTPF0d2dLxsoQTj/CMxc2NVLAgPVAbZ2EqaBpCLDU8HLE59F98fZfkD9Hfez58KokFYjH4IjNzty+X2ivn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736215300; c=relaxed/simple;
	bh=FPu22WdP7+WPBiYHzN11L5F2QUPfxQ+hvw/96Y2we+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EGwR494OhMgkz88yokP6nOgy21W3ri4N2A5JDJ7Mnj2rVNWWS0eC1zvZ0Hzf6U9w9UKUU8d9G2roWy7SOGh95iDFrAA6x5CoxWlH8dMTMrKwFjPswKvtEAWOfRtYdUan8hpYwBJE7pKERH7H+rN9l85zDqK+Z9Se/n8L/+v4Amw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YRvMQ21G4z1W3Vq;
	Tue,  7 Jan 2025 09:57:54 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D8D21402DA;
	Tue,  7 Jan 2025 10:01:34 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 7 Jan
 2025 10:01:33 +0800
Message-ID: <0acc1709-1349-4dbb-ba3e-ae786c4b5b53@huawei.com>
Date: Tue, 7 Jan 2025 10:01:32 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?B?UmU6IFtCVUcgUkVQT1JUXSBleHQ0OiDigJxlcnJvcnM9cmVtb3VudC1y?=
 =?UTF-8?B?b+KAnSBoYXMgYmVjb21lIOKAnGVycm9ycz1zaHV0ZG93buKAnT8=?=
To: "Darrick J. Wong" <djwong@kernel.org>
CC: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, Christian Brauner
	<brauner@kernel.org>, <sunyongjian1@huawei.com>, Yang Erkun
	<yangerkun@huawei.com>, <linux-fsdevel@vger.kernel.org>,
	<linux-xfs@vger.kernel.org>, Baokun Li <libaokun1@huawei.com>
References: <22d652f6-cb3c-43f5-b2fe-0a4bb6516a04@huawei.com>
 <z52ea53du2k66du24ju4yetqm72e6pvtcbwkrjf4oomw2feffq@355vymdndrxn>
 <17108cad-efa8-46b4-a320-70d7b696f75b@huawei.com>
 <umpsdxhd2dz6kgdttpm27tigrb3ytvpf3y3v73ugavgh4b5cuj@dnacioqwq4qq>
 <20250103153517.GB1284777@mit.edu> <20250103155406.GC1284777@mit.edu>
 <5eb2ad64-c6ea-45f8-9ba1-7de5c68d59aa@huawei.com>
 <20250106234956.GM6174@frogsfrogsfrogs>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250106234956.GM6174@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/7 7:49, Darrick J. Wong wrote:
> On Sat, Jan 04, 2025 at 10:41:28AM +0800, Baokun Li wrote:
>> Hi Ted,
>>
>> On 2025/1/3 23:54, Theodore Ts'o wrote:
>>> On Fri, Jan 03, 2025 at 10:35:17AM -0500, Theodore Ts'o wrote:
>>>> I don't see how setting the shutdown flag causes reads to fail.  That
>>>> was true in an early version of the ext4 patch which implemented
>>>> shutdown support, but one of the XFS developers (I don't remember if
>>>> it was Dave or Cristoph) objected because XFS did not cause the
>>>> read_pages function to fail.  Are you seeing this with an upstream
>>>> kernel, or with a patched kernel?  The upstream kernel does *not* have
>>>> the check in ext4_readpages() or ext4_read_folio() (post folio
>>>> conversion).
>>> OK, that's weird.  Testing on 6.13-rc4, I don't see the problem simulating an ext4 error:
>>>
>>> root@kvm-xfstests:~# mke2fs -t ext4 -Fq /dev/vdc
>>> /dev/vdc contains a ext4 file system
>>> 	last mounted on /vdc on Fri Jan  3 10:38:21 2025
>>> root@kvm-xfstests:~# mount -t ext4 -o errors=continue /dev/vdc /vdc
>> We are discussing "errors=remount-ro," as the title states, not the
>> continue mode. The key code leading to the behavior change is as follows,
>> therefore the continue mode is not affected.
> Hmm.  On the one hand, XFS has generally returned EIO (or ESHUTDOWN in a
> couple of specialty cases) when the fs has been shut down.
Indeed, this is the intended behavior during shutdown.
>
> OTOH XFS also doesn't have errors=remount-ro; it just dies, which I
> think has been its behavior for a long time.
Yes. As an aside, is there any way for xfs to determine if -EIO is
originating from a hardware error or if the filesystem has been shutdown?

Or would you consider it useful to have the mount command display
"shutdown" when the file system is being shut down?
> To me, it doesn't sound unreasonable for ext* to allow reads after a
> shutdown when errors=remount-ro since it's always had that behavior.
Yes, a previous bug fix inadvertently changed the behavior of 
errors=remount-ro,
and the patch to correct this is coming.

Additionally, ext4 now allows directory reads even after shutdown, is this
expected behavior?
> Bonus Q: do you want an errors=fail variant to shut things down fast?
>
> --D

In my opinion, I have not yet seen a scenario where the file system needs
to be shut down after an error occurs. Therefore, using errors=remount-ro
to prevent modifications after an error is sufficient. Of course, if
customers have such needs, implementing this mode is also very simple.


Thanks,
Baokun


