Return-Path: <linux-fsdevel+bounces-44314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86335A672E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 12:39:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B764189F155
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 11:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE6020B1F5;
	Tue, 18 Mar 2025 11:39:03 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B381C8602
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Mar 2025 11:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742297943; cv=none; b=hjsGRxwtg7OdunrBD+5h0I8aRVpD+CtKqzhJDiZMZrQWivux9WCcFrk/UnpyqNTG+JxEkuEiNfpjecIBI21UVuftffDvICS+3JsA7ztxm9GMvPrjqy7MiBudMaaRIxIr6L73weMnn/GWL7qJBVSn8K8ODDER97bU2AsTkFVxZGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742297943; c=relaxed/simple;
	bh=NXhTXNeS6X4VXETJY0bJqrdIgdHMNRCYJROGkb+B97I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:CC:
	 In-Reply-To:Content-Type; b=OdrUZrrCWbUqhJp+XIxzI3ymWosEeRm4N7TfSDHIltkceehHhrhTxkmO/mGcSG+bbA5smr+NpQRs7Xm+xx1Pef2DiGrz9oFb8liw59FnhaxcvYyIZ67zLGCYU4xo7upUC/vHj2yuKZeg/sjJY+PYrcpeJzlgjaDcO31IKsqcth0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZH8sp4MR8zHrDB;
	Tue, 18 Mar 2025 19:35:42 +0800 (CST)
Received: from kwepemo500015.china.huawei.com (unknown [7.202.194.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 55DFF180080;
	Tue, 18 Mar 2025 19:38:56 +0800 (CST)
Received: from [10.174.179.92] (10.174.179.92) by
 kwepemo500015.china.huawei.com (7.202.194.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Mar 2025 19:38:55 +0800
Message-ID: <121a6f7f-b923-4ec5-8699-23503841264e@huawei.com>
Date: Tue, 18 Mar 2025 19:38:37 +0800
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
 <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
 <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>
 <82c42c05-8b25-46fe-b855-09043cf4f702@oracle.com>
From: Sun Yongjian <sunyongjian1@huawei.com>
CC: <yangerkun@huawei.com>, <linux-fsdevel@vger.kernel.org>
In-Reply-To: <82c42c05-8b25-46fe-b855-09043cf4f702@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemo500015.china.huawei.com (7.202.194.227)



在 2025/3/13 21:45, Chuck Lever 写道:
> On 3/11/25 11:23 AM, Chuck Lever wrote:
>> On 3/11/25 9:55 AM, Sun Yongjian wrote:
>>>
>>>
>>> 在 2025/3/11 1:30, Chuck Lever 写道:
>>>> On 3/10/25 12:29 PM, Greg Kroah-Hartman wrote:
>>>>> On Wed, Feb 26, 2025 at 03:33:56PM -0500, Chuck Lever wrote:
>>>>>> On 2/26/25 2:13 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
>>>>>>>> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
>>>>>>>>> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
>>>>>>>>>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
>>>>>>>>>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
>>>>>>>>>>>
>>>>>>>>>>> There are reports of this commit breaking Chrome's rendering
>>>>>>>>>>> mode.  As
>>>>>>>>>>> no one seems to want to do a root-cause, let's just revert it
>>>>>>>>>>> for now as
>>>>>>>>>>> it is affecting people using the latest release as well as the
>>>>>>>>>>> stable
>>>>>>>>>>> kernels that it has been backported to.
>>>>>>>>>>
>>>>>>>>>> NACK. This re-introduces a CVE.
>>>>>>>>>
>>>>>>>>> As I said elsewhere, when a commit that is assigned a CVE is
>>>>>>>>> reverted,
>>>>>>>>> then the CVE gets revoked.  But I don't see this commit being
>>>>>>>>> assigned
>>>>>>>>> to a CVE, so what CVE specifically are you referring to?
>>>>>>>>
>>>>>>>> https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>>>>>
>>>>>>> That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory
>>>>>>> reads
>>>>>>> for offset dir"), which showed up in 6.11 (and only backported to
>>>>>>> 6.10.7
>>>>>>> (which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
>>>>>>> d_children list to iterate simple_offset directories") is in 6.14-rc1
>>>>>>> and has been backported to 6.6.75, 6.12.12, and 6.13.1.
>>>>>>>
>>>>>>> I don't understand the interaction here, sorry.
>>>>>>
>>>>>> Commit 64a7ce76fb90 is an attempt to fix the infinite loop, but can
>>>>>> not be applied to kernels before 0e4a862174f2 ("libfs: Convert simple
>>>>>> directory offsets to use a Maple Tree"), even though those kernels also
>>>>>> suffer from the looping symptoms described in the CVE.
>>>>>>
>>>>>> There was significant controversy (which you responded to) when Yu Kuai
>>>>>> <yukuai3@huawei.com> attempted a backport of 64a7ce76fb90 to address
>>>>>> this CVE in v6.6 by first applying all upstream mtree patches to v6.6.
>>>>>> That backport was roundly rejected by Liam and Lorenzo.
>>>>>>
>>>>>> Commit b9b588f22a0c is a second attempt to fix the infinite loop
>>>>>> problem
>>>>>> that does not depend on having a working Maple tree implementation.
>>>>>> b9b588f22a0c is a fix that can work properly with the older xarray
>>>>>> mechanism that 0e4a862174f2 replaced, so it can be backported (with
>>>>>> certain adjustments) to kernels before 0e4a862174f2.
>>>>>>
>>>>>> Note that as part of the series where b9b588f22a0c was applied,
>>>>>> 64a7ce76fb90 is reverted (v6.10 and forward). Reverting b9b588f22a0c
>>>>>> leaves LTS kernels from v6.6 forward with the infinite loop problem
>>>>>> unfixed entirely because 64a7ce76fb90 has also now been reverted.
>>>>>>
>>>>>>
>>>>>>>> The guideline that "regressions are more important than CVEs" is
>>>>>>>> interesting. I hadn't heard that before.
>>>>>>>
>>>>>>> CVEs should not be relevant for development given that we create 10-11
>>>>>>> of them a day.  Treat them like any other public bug list please.
>>>>>>>
>>>>>>> But again, I don't understand how reverting this commit relates to the
>>>>>>> CVE id you pointed at, what am I missing?
>>>>>>>
>>>>>>>> Still, it seems like we haven't had a chance to actually work on this
>>>>>>>> issue yet. It could be corrected by a simple fix. Reverting seems
>>>>>>>> premature to me.
>>>>>>>
>>>>>>> I'll let that be up to the vfs maintainers, but I'd push for reverting
>>>>>>> first to fix the regression and then taking the time to find the real
>>>>>>> change going forward to make our user's lives easier.  Especially as I
>>>>>>> don't know who is working on that "simple fix" :)
>>>>>>
>>>>>> The issue is that we need the Chrome team to tell us what new system
>>>>>> behavior is causing Chrome to malfunction. None of us have expertise to
>>>>>> examine as complex an application as Chrome to nail the one small
>>>>>> change
>>>>>> that is causing the problem. This could even be a latent bug in Chrome.
>>>>>>
>>>>>> As soon as they have reviewed the bug and provided a simple reproducer,
>>>>>> I will start active triage.
>>>>>
>>>>> What ever happened with all of this?
>>>>
>>>> https://issuetracker.google.com/issues/396434686?pli=1
>>>>
>>>> The Chrome engineer chased this into the Mesa library, but since then
>>>> progress has slowed. We still don't know why GPU acceleration is not
>>>> being detected on certain devices.
>>>>
>>>>
>>> Hello,
>>>
>>>
>>> I recently conducted an experiment after applying the patch "libfs: Use
>>> d_children
>>>
>>> list to iterate simple_offset directories."  In a directory under tmpfs,
>>> I created 1026
>>>
>>> files using the following commands:
>>> for i in {1..1026}; do
>>>      echo "This is file $i" > /tmp/dir/file$i
>>> done
>>>
>>> When I use the ls to read the contents of the dir, I find that glibc
>>> performs two
>>>
>>> rounds of readdir calls due to the large number of files. The first
>>> readdir populates
>>>
>>> dirent with file1026 through file5, and the second readdir populates it
>>> with file4
>>>
>>> through file1, which are then returned to user space.
>>>
>>> If an unlink file4 operation is inserted between these two readdir
>>> calls, the second
>>>
>>> readdir will return file5, file3, file2, and file1, causing ls to
>>> display two instances of
>>>
>>> file5. However, if we replace mas_find with mas_find_rev in the
>>> offset_dir_lookup
>>>
>>> function, the results become normal.
>>>
>>> I'm not sure whether this experiment could shed light on a potential
>>> fix.
>>
>> Thanks for the report. Directory contents cached in glibc make this
>> stack more brittle than it needs to be, certainly. Your issue does
>> look like a bug that is related to the commit.
>>
>> We believe the GPU acceleration bug is related to directory order,
>> but I don't think libdrm is removing an entry from /dev/dri, so I
>> am a little skeptical this is the cause of the GPU acceleration issue
>> (could be wrong though).
>>
>> What I recommend you do is:
>>
>>   a. Create a full patch (with S-o-b) that replaces mas_find() with
>>      mas_find_rev() in offset_dir_lookup()
>>
>>   b. Construct a new fstests test that looks for this problem (and
>>      it would be good to investigate fstests to see if it already
>>      looks for this issue, but I bet it does not)
>>
>>   c. Run the full fstests suite against a kernel before and after you
>>      apply a. and confirm that the problem goes away and does not
>>      introduce new test failures when a. is applied
>>
>>   d. If all goes to plan, post a. to linux-fsdevel and linux-mm.
> 
> Hi -
> 
> As an experiment, I applied the following diff to v6.14-rc6:
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8444f5cc4064..dc042a975a56 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -496,7 +496,7 @@ offset_dir_lookup(struct dentry *parent, loff_t offset)
>                  found = find_positive_dentry(parent, NULL, false);
>          else {
>                  rcu_read_lock();
> -               child = mas_find(&mas, DIR_OFFSET_MAX);
> +               child = mas_find_rev(&mas, DIR_OFFSET_MIN);
>                  found = find_positive_dentry(parent, child, false);
>                  rcu_read_unlock();
>          }
> 
> I seem to recall we considered using mas_find_rev() at one point,
> but I've forgotten why I stuck with mas_find().
> 
> I've done some testing, and so far it has not introduced any new
> regressions. I can't comment on whether it addresses the misbehavior
> you found, or whether it addresses the GPU acceleration bug.
> 
Thank you very much for your time! After applying that patch, I ran 
xfstest and all the test cases passed. Everything appears to be in 
perfect order, and I also tested it in my custom scenario, which 
confirms that it indeed fixes the issue I mentioned earlier. However,
I am not sure whether it can also fix the issue reported by the Chrome team.

Since my test scenario requires a test-specific patch to enforce the 
execution order of getdents64 and unlink (to ensure the issue occurs), I 
feel that adding such a test case to xfstest might not be the best option.

I will submit this patch to the community.

Cheers,
Yongjian

