Return-Path: <linux-fsdevel+bounces-43712-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F758A5C316
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 14:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 881E0166867
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D867254851;
	Tue, 11 Mar 2025 13:55:53 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584238F9C
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701353; cv=none; b=HfxbDk5TBd5vtjSkFWjJpkD9DIkmEiQcY9AfFjIHd3m6R8u2heywsGuy2/w39bZaQkZzcU/j82PJpY5SQCeJAtFuJLn3RHfsRiQ1j6xriqp6pp1DZAm0Emg0i7f0uVgP2ZpIrCyIdA7iwCaH6uXaHldy8NNwDxOzxJadds3AgQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701353; c=relaxed/simple;
	bh=/uVtrH/gL5rE3zySl2Y4YvTvfSbYabVWBzpFX3Iaup8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=I4SaLqebtKQ0klOVemMe7tTHumBjW88hVo5CzFpI7hdYsWYYbjUtO2Fldmy5sbZH3WmfuXu5UwdCRDTh1QrBDE7xTv1z0l456/4anqXDfBwnD2gzNZ/ph2E8S+4jkc2Gbnc5OctZ+8jgfVr941JGV2l5i6xVYLiJUc/6BviRK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZBwJb1Z5Fz1cyqL;
	Tue, 11 Mar 2025 21:55:43 +0800 (CST)
Received: from kwepemo500015.china.huawei.com (unknown [7.202.194.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 9005018010B;
	Tue, 11 Mar 2025 21:55:46 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 kwepemo500015.china.huawei.com (7.202.194.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Mar 2025 21:55:45 +0800
Message-ID: <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
Date: Tue, 11 Mar 2025 21:55:33 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
To: Chuck Lever <chuck.lever@oracle.com>
References: <2025022644-blinked-broadness-c810@gregkh>
 <a7fe0eda-78e4-43bb-822b-c1dfa65ba4dd@oracle.com>
 <2025022621-worshiper-turtle-6eb1@gregkh>
 <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
 <2025022612-stratus-theology-de3c@gregkh>
 <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
 <2025031039-gander-stamina-4bb6@gregkh>
 <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
CC: <linux-fsdevel@vger.kernel.org>, <yangerkun@huawei.com>
From: Sun Yongjian <sunyongjian1@huawei.com>
In-Reply-To: <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500015.china.huawei.com (7.202.194.227)



在 2025/3/11 1:30, Chuck Lever 写道:
> On 3/10/25 12:29 PM, Greg Kroah-Hartman wrote:
>> On Wed, Feb 26, 2025 at 03:33:56PM -0500, Chuck Lever wrote:
>>> On 2/26/25 2:13 PM, Greg Kroah-Hartman wrote:
>>>> On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
>>>>> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
>>>>>> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
>>>>>>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
>>>>>>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
>>>>>>>>
>>>>>>>> There are reports of this commit breaking Chrome's rendering mode.  As
>>>>>>>> no one seems to want to do a root-cause, let's just revert it for now as
>>>>>>>> it is affecting people using the latest release as well as the stable
>>>>>>>> kernels that it has been backported to.
>>>>>>>
>>>>>>> NACK. This re-introduces a CVE.
>>>>>>
>>>>>> As I said elsewhere, when a commit that is assigned a CVE is reverted,
>>>>>> then the CVE gets revoked.  But I don't see this commit being assigned
>>>>>> to a CVE, so what CVE specifically are you referring to?
>>>>>
>>>>> https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>>
>>>> That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory reads
>>>> for offset dir"), which showed up in 6.11 (and only backported to 6.10.7
>>>> (which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
>>>> d_children list to iterate simple_offset directories") is in 6.14-rc1
>>>> and has been backported to 6.6.75, 6.12.12, and 6.13.1.
>>>>
>>>> I don't understand the interaction here, sorry.
>>>
>>> Commit 64a7ce76fb90 is an attempt to fix the infinite loop, but can
>>> not be applied to kernels before 0e4a862174f2 ("libfs: Convert simple
>>> directory offsets to use a Maple Tree"), even though those kernels also
>>> suffer from the looping symptoms described in the CVE.
>>>
>>> There was significant controversy (which you responded to) when Yu Kuai
>>> <yukuai3@huawei.com> attempted a backport of 64a7ce76fb90 to address
>>> this CVE in v6.6 by first applying all upstream mtree patches to v6.6.
>>> That backport was roundly rejected by Liam and Lorenzo.
>>>
>>> Commit b9b588f22a0c is a second attempt to fix the infinite loop problem
>>> that does not depend on having a working Maple tree implementation.
>>> b9b588f22a0c is a fix that can work properly with the older xarray
>>> mechanism that 0e4a862174f2 replaced, so it can be backported (with
>>> certain adjustments) to kernels before 0e4a862174f2.
>>>
>>> Note that as part of the series where b9b588f22a0c was applied,
>>> 64a7ce76fb90 is reverted (v6.10 and forward). Reverting b9b588f22a0c
>>> leaves LTS kernels from v6.6 forward with the infinite loop problem
>>> unfixed entirely because 64a7ce76fb90 has also now been reverted.
>>>
>>>
>>>>> The guideline that "regressions are more important than CVEs" is
>>>>> interesting. I hadn't heard that before.
>>>>
>>>> CVEs should not be relevant for development given that we create 10-11
>>>> of them a day.  Treat them like any other public bug list please.
>>>>
>>>> But again, I don't understand how reverting this commit relates to the
>>>> CVE id you pointed at, what am I missing?
>>>>
>>>>> Still, it seems like we haven't had a chance to actually work on this
>>>>> issue yet. It could be corrected by a simple fix. Reverting seems
>>>>> premature to me.
>>>>
>>>> I'll let that be up to the vfs maintainers, but I'd push for reverting
>>>> first to fix the regression and then taking the time to find the real
>>>> change going forward to make our user's lives easier.  Especially as I
>>>> don't know who is working on that "simple fix" :)
>>>
>>> The issue is that we need the Chrome team to tell us what new system
>>> behavior is causing Chrome to malfunction. None of us have expertise to
>>> examine as complex an application as Chrome to nail the one small change
>>> that is causing the problem. This could even be a latent bug in Chrome.
>>>
>>> As soon as they have reviewed the bug and provided a simple reproducer,
>>> I will start active triage.
>>
>> What ever happened with all of this?
> 
> https://issuetracker.google.com/issues/396434686?pli=1
> 
> The Chrome engineer chased this into the Mesa library, but since then
> progress has slowed. We still don't know why GPU acceleration is not
> being detected on certain devices.
> 
> 
Hello,


I recently conducted an experiment after applying the patch "libfs: Use 
d_children

list to iterate simple_offset directories."  In a directory under tmpfs, 
I created 1026

files using the following commands:
for i in {1..1026}; do
     echo "This is file $i" > /tmp/dir/file$i
done

When I use the ls to read the contents of the dir, I find that glibc 
performs two

rounds of readdir calls due to the large number of files. The first 
readdir populates

dirent with file1026 through file5, and the second readdir populates it 
with file4

through file1, which are then returned to user space.

If an unlink file4 operation is inserted between these two readdir 
calls, the second

readdir will return file5, file3, file2, and file1, causing ls to 
display two instances of

file5. However, if we replace mas_find with mas_find_rev in the 
offset_dir_lookup

function, the results become normal.

I'm not sure whether this experiment could shed light on a potential 
fix. Thank you

for your time and consideration.

Yongjian

