Return-Path: <linux-fsdevel+bounces-34794-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C08AA9C8CCF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 15:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FB021F22F0B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 14:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F2A3C6BA;
	Thu, 14 Nov 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="cD3wmupX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08AFF9E6;
	Thu, 14 Nov 2024 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594381; cv=none; b=QKCn170VnJHV6uOqy5c2fLs2xGIucmFHHACHg0XiIq7u0OvlhNTrWnpyLXrGGznJdKgIFTkou1+lc3OfckLyNUbHeEMr0uAws26Hj1a4LHIr0lRUShfApqD+ZF+DcQt9jDy8b6KpZq4EO0kk37mCVtFYNyCobQ2VQLxDkDKv3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594381; c=relaxed/simple;
	bh=X67V1xjPx8h+tSm9+06VK7LjjJn3e1u215jRbqrzvjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfeHzOAW/gC9lEWexTbT/VnguWoCVUY5vYYD2lWxvJ3KzQdLLszDnUppKvd6OfIyNKTVgh1dBzCKRtHWMBRNnWmwnAXTSCB1tZtPBySOBmnxyeCAwprZG+JFyaQwPi5UMUHRRoB0dhbaqbG+k8CP0aOzhRKAnek3YpT4jNN6VGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=cD3wmupX; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14D3B60007;
	Thu, 14 Nov 2024 14:25:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1731594370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vA7tfGBEgNX6EndwaQ8kIuuNkGQyzJxfZT7/8TI0Oog=;
	b=cD3wmupX5VV+Aw8Fnnwvh/qnGMpnsueFCYK3UMiHHpYKFOH8Olw1CHG39RDOvlCrLattMT
	1kRbuveEwx0BMRyWnIlo9Rd/G3dK91G/OcOVAc/j+bK6UyIWMfjXogK26KkwfDPdsr+5wX
	IKJ+0aYy9LooHHB10TugfZWGgZgUi0x3AJmQ5XAjzxqiF/rbx92mXfRHZEcVjqX3O2hFmc
	bu5wTVkzQkNzqMLT6P+SM3o7vgS06337cFHRToiiJCCJkeD1JiGSyKh8j4avd2c8dkFhKy
	J00dapgBHfXV3Rc5NUZqcVszgx2AmGVY7OmCqsY158obZ1AD0CzzClcqPyvbQw==
Message-ID: <040b7d4a-3967-444d-b166-e75df43e1a0c@clip-os.org>
Date: Thu, 14 Nov 2024 15:25:56 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] coredump: Fixes core_pipe_limit sysctl proc_handler
To: Lin Feng <linf@wangsu.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>,
 Joel Granados <j.granados@samsung.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Neil Horman <nhorman@tuxdriver.com>, Theodore Ts'o <tytso@mit.edu>
References: <20241112131357.49582-1-nicolas.bouchinet@clip-os.org>
 <20241112131357.49582-2-nicolas.bouchinet@clip-os.org>
 <af2a2a7e-1604-4e24-bee6-f31498e0b25d@wangsu.com>
 <f616c1aa-65e7-44e8-90ac-5be8e3f88927@clip-os.org>
 <7454ba19-6c78-4318-8164-21d4b14bee08@wangsu.com>
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <7454ba19-6c78-4318-8164-21d4b14bee08@wangsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org


On 11/14/24 02:34, Lin Feng wrote:
> Hi,
>
> On 11/13/24 22:15, Nicolas Bouchinet wrote:
>> Hi Lin,
>>
>> Thanks for your review.
>>
>> On 11/13/24 03:35, Lin Feng wrote:
>>> Hi,
>>>
>>> see comments below please.
>>>
>>> On 11/12/24 21:13, nicolas.bouchinet@clip-os.org wrote:
>>>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>>>
>>>> proc_dointvec converts a string to a vector of signed int, which is
>>>> stored in the unsigned int .data core_pipe_limit.
>>>> It was thus authorized to write a negative value to core_pipe_limit
>>>> sysctl which once stored in core_pipe_limit, leads to the signed int
>>>> dump_count check against core_pipe_limit never be true. The same can be
>>>> achieved with core_pipe_limit set to INT_MAX.
>>>>
>>>> Any negative write or >= to INT_MAX in core_pipe_limit sysctl would
>>>> hypothetically allow a user to create very high load on the system by
>>>> running processes that produces a coredump in case the core_pattern
>>>> sysctl is configured to pipe core files to user space helper.
>>>> Memory or PID exhaustion should happen before but it anyway breaks the
>>>> core_pipe_limit semantic
>>>>
>>>> This commit fixes this by changing core_pipe_limit sysctl's proc_handler
>>>> to proc_dointvec_minmax and bound checking between SYSCTL_ZERO and
>>>> SYSCTL_INT_MAX.
>>>>
>>>> Fixes: a293980c2e26 ("exec: let do_coredump() limit the number of concurrent dumps to pipes")
>>>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>>> ---
>>>>    fs/coredump.c | 7 +++++--
>>>>    1 file changed, 5 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/coredump.c b/fs/coredump.c
>>>> index 7f12ff6ad1d3e..8ea5896e518dd 100644
>>>> --- a/fs/coredump.c
>>>> +++ b/fs/coredump.c
>>>> @@ -616,7 +616,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>>>    		cprm.limit = RLIM_INFINITY;
>>>>    
>>>>    		dump_count = atomic_inc_return(&core_dump_count);
>>>> -		if (core_pipe_limit && (core_pipe_limit < dump_count)) {
>>>> +		if ((core_pipe_limit && (core_pipe_limit < dump_count)) ||
>>>> +		    (core_pipe_limit && dump_count == INT_MAX)) {
>>> While comparing between 'unsigned int' and 'signed int', C deems them both
>>> to 'unsigned int', so as an insane user sets core_pipe_limit to INT_MAX,
>>> and dump_count(signed int) does overflow INT_MAX, checking for
>>> 'core_pipe_limit < dump_count' is passed, thus codes skips core dump.
>>>
>>> So IMO it's enough after changing proc_handler to proc_dointvec_minmax.
>> Indeed, but the dump_count == INT_MAX is not here to catch overflow but
>> if both dump_count
>> and core_pipe_limit are equal to INT_MAX. core_pipe_limit will not be
>> inferior to dump_count.
>> Or maybe I am missing something ?
>>
> Extracted from man core:
>         Since Linux 2.6.32, the /proc/sys/kernel/core_pipe_limit can be used to
>         defend against this possibility.  The value in this  file  defines  how
>         many  concurrent crashing processes may be piped to user-space programs
>         in parallel.  If this value is exceeded, then those crashing  processes
>         above  this  value are noted in the kernel log and their core dumps are
>         skipped.
>
> Since no spinlock protecting us, due to the concurrent running of
> atomic_inc_return(&core_dump_count), even with the changing above
> it's not guaranteed that core_dump_count can't exceed core_pipe_limit).
> As you said, suppose both of them are equal to INT_MAX(0x7fffffff),
> and before any dummping thread drops core_dump_count, one new thread
> comes in then hits atomic_inc_return(&core_dump_count) and now
> (unsigned int)core_dump_count is 0x80000000, but original codes checking
> for core_pipe_limit still works as expected.

You are absolutely right about this. Moreover, as stated in my commit
message, pid or memory exhaustion should occur before reaching this
scenario.

Thank's for your comment and review. I'll fix and push a v2.

>
> Please correct me if I'm wrong :)
>
> Thanks,
> linfeng
>
>

