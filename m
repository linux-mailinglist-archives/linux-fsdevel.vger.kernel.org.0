Return-Path: <linux-fsdevel+bounces-38626-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F76A05032
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 03:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853083A39ED
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C29B1A726F;
	Wed,  8 Jan 2025 02:08:37 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190271A23B9;
	Wed,  8 Jan 2025 02:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302116; cv=none; b=nf8U4mG584fipYOeBWTHjznS+4kfuCDE1eS1yNjDpakgDT1wccwpEgrsoL8SF1aENshS7NckAmdoUb4OFA6oDLUXE4PlG6DzGWodVgdj1OFlW+0yaaFrhZXK3ySRuKugl8zWmY3QLTl1wVuQyZrpfI2o0yb4JhmqJmVorlzDBQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302116; c=relaxed/simple;
	bh=yV8w28YSWeQK0MzXYTeq8sehGEQp5FF3e60syr5ihrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ceRlqpdfkK8btWirgaIq88Mm9OuJ/R8vtAUtvZSYdXekX8nRltkjJO66BbLIF9hdEezyCjEXIqaisIsBrHq89a4ErnHvw1p/r8yF8M7BEVocHd7f1LI7xTyqeYCfwRx8zbZJ3vZ/yvQghPQ33+zTlUJAb8yKJQ0p+NbfT5xNeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4YSWSx2ZXCz1W3j0;
	Wed,  8 Jan 2025 10:04:49 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id AA6951402D0;
	Wed,  8 Jan 2025 10:08:30 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 8 Jan
 2025 10:08:29 +0800
Message-ID: <05106b71-5119-4b69-9b2f-523e60c31965@huawei.com>
Date: Wed, 8 Jan 2025 10:08:29 +0800
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
 <0acc1709-1349-4dbb-ba3e-ae786c4b5b53@huawei.com>
 <20250107070820.GJ6174@frogsfrogsfrogs>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250107070820.GJ6174@frogsfrogsfrogs>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/1/7 15:08, Darrick J. Wong wrote:
> On Tue, Jan 07, 2025 at 10:01:32AM +0800, Baokun Li wrote:
>> On 2025/1/7 7:49, Darrick J. Wong wrote:
>>> On Sat, Jan 04, 2025 at 10:41:28AM +0800, Baokun Li wrote:
>>>> Hi Ted,
>>>>
>>>> On 2025/1/3 23:54, Theodore Ts'o wrote:
>>>>> On Fri, Jan 03, 2025 at 10:35:17AM -0500, Theodore Ts'o wrote:
>>>>>> I don't see how setting the shutdown flag causes reads to fail.  That
>>>>>> was true in an early version of the ext4 patch which implemented
>>>>>> shutdown support, but one of the XFS developers (I don't remember if
>>>>>> it was Dave or Cristoph) objected because XFS did not cause the
>>>>>> read_pages function to fail.  Are you seeing this with an upstream
>>>>>> kernel, or with a patched kernel?  The upstream kernel does *not* have
>>>>>> the check in ext4_readpages() or ext4_read_folio() (post folio
>>>>>> conversion).
>>>>> OK, that's weird.  Testing on 6.13-rc4, I don't see the problem simulating an ext4 error:
>>>>>
>>>>> root@kvm-xfstests:~# mke2fs -t ext4 -Fq /dev/vdc
>>>>> /dev/vdc contains a ext4 file system
>>>>> 	last mounted on /vdc on Fri Jan  3 10:38:21 2025
>>>>> root@kvm-xfstests:~# mount -t ext4 -o errors=continue /dev/vdc /vdc
>>>> We are discussing "errors=remount-ro," as the title states, not the
>>>> continue mode. The key code leading to the behavior change is as follows,
>>>> therefore the continue mode is not affected.
>>> Hmm.  On the one hand, XFS has generally returned EIO (or ESHUTDOWN in a
>>> couple of specialty cases) when the fs has been shut down.
>> Indeed, this is the intended behavior during shutdown.
>>> OTOH XFS also doesn't have errors=remount-ro; it just dies, which I
>>> think has been its behavior for a long time.
>> Yes. As an aside, is there any way for xfs to determine if -EIO is
>> originating from a hardware error or if the filesystem has been shutdown?
> XFS knows the difference, but nothing above it does.
Okay.
>> Or would you consider it useful to have the mount command display
>> "shutdown" when the file system is being shut down?
> Trouble is, will mount get confused and try to pass ",shutdown" as part
> of a remount operation?
The ",shutdown" string is only displayed by show_options when specific
flags are set; it's not actually parsed by remount. Unless the sysadmin
sees it in the mount command output and then mounts with this option.
> I suppose the fs is dead so what does it
> matter...
Since XFS is typically already shut down when it returns EIO, this prompt
may not be important for xfs. However, it's not as straightforward to
distinguish between EIO and shutdown for file systems that support a
continue mode or allow some operations even after shutdown.
>>> To me, it doesn't sound unreasonable for ext* to allow reads after a
>>> shutdown when errors=remount-ro since it's always had that behavior.
>> Yes, a previous bug fix inadvertently changed the behavior of
>> errors=remount-ro,
>> and the patch to correct this is coming.
>>
>> Additionally, ext4 now allows directory reads even after shutdown, is this
>> expected behavior?
> There's no formal specification for what shutdown means, so ... it's not
> unexpected.  XFS doesn't allow that.
Okay.
>>> Bonus Q: do you want an errors=fail variant to shut things down fast?
>>>
>>> --D
>> In my opinion, I have not yet seen a scenario where the file system needs
>> to be shut down after an error occurs. Therefore, using errors=remount-ro
>> to prevent modifications after an error is sufficient. Of course, if
>> customers have such needs, implementing this mode is also very simple.
> IO errors, sure.  Metadata errors?  No, we want to stop the world
> immediately, either so the sysadmin can go run xfs_repair, or the clod
> manager can just kill the node and deploy another.
>
> --D

The remount-ro mode generally only becomes read-only when metadata errors
occur，too. I think if users have no need to read after an error, there is
basically no difference between read-only and shutdown. In fact,
errors=remount-ro does more; it allows users to back up some potentially
lost data after an error and then exit gracefully. However, reading
corrupted metadata does have some risks, for which we have done a lot of
work.


Regards,
Baokun


