Return-Path: <linux-fsdevel+bounces-34654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDE19C7344
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 15:16:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95B061F22836
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 14:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34BC1FF7BD;
	Wed, 13 Nov 2024 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b="EAHfmF6+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5DF282ED;
	Wed, 13 Nov 2024 14:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507337; cv=none; b=oBf/xWukP///0uYnhOAnZVp7ycLxmMQzbb6oBEkXJ+29SXl8qAzYTR0BqA9X3vIyHxTixlGpeDpwg+YQhK8Obhmva5sXwk0SFOhMSnyCexwWo8q5fyP1nFzpp3ZkZhNwULYk3L+1W79yaQ2ni68FKPxGr6pqYj70HlmUH4pzKNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507337; c=relaxed/simple;
	bh=7bz1ZkCIXCTeCZ66UcbnuOpr52mVq/zPBK//duEynWo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6xac8XK4Ko6x75yAudmQDZDcdhKtay5H9iRmPs3ooBV0WfAtiCeW0WQQQSjuxIB+eFLQii1rrITIC+bq2eyCCzda8VmMZA8kZT40HvvtDepVOIn4J5YesJ+BXD44wzJY5LT7faaPKBTzvyQ/JD4TYMxovl06R5a4PfXWTjq6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org; spf=pass smtp.mailfrom=clip-os.org; dkim=pass (2048-bit key) header.d=clip-os.org header.i=@clip-os.org header.b=EAHfmF6+; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=clip-os.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clip-os.org
Received: by mail.gandi.net (Postfix) with ESMTPSA id B9FF31BF20D;
	Wed, 13 Nov 2024 14:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=clip-os.org; s=gm1;
	t=1731507332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAq2o06namGsLDTq7nlV6jW6jaGMlKlDc8EB/0EBouM=;
	b=EAHfmF6+QLYqonprBmJRtq/92+JLr1DYUYQtuMmN67gNCWEqadnqK5D0PVljjN3PVUSGRc
	rtF/95MzineQ2WV1wkDnLMpQ9w0q/VRn4cy4FP3Epx10W2iipi5hvzIeffU1M7Swd02EJB
	2REHIvaJke6s3OtT4e1RtkUqOk8LKL1gE8CtuKB+5noeRkN4E0+8gibl/cuqgCJVpRIwW0
	F8k2Eq9n5VOs1rgvh4GMoPSA30iRnqTgu8PmoKV6mNWeLB+egPqTBK+UjV6g+4nRIlstnx
	q7zUC3+b+xc3akxPQrPCIJ9kqV3mTfp+h8i0rhWOH/4DMDQpF4w/5XzzY+5PBA==
Message-ID: <f616c1aa-65e7-44e8-90ac-5be8e3f88927@clip-os.org>
Date: Wed, 13 Nov 2024 15:15:29 +0100
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
Content-Language: en-US
From: Nicolas Bouchinet <nicolas.bouchinet@clip-os.org>
In-Reply-To: <af2a2a7e-1604-4e24-bee6-f31498e0b25d@wangsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: nicolas.bouchinet@clip-os.org

Hi Lin,

Thanks for your review.

On 11/13/24 03:35, Lin Feng wrote:
> Hi,
>
> see comments below please.
>
> On 11/12/24 21:13, nicolas.bouchinet@clip-os.org wrote:
>> From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>>
>> proc_dointvec converts a string to a vector of signed int, which is
>> stored in the unsigned int .data core_pipe_limit.
>> It was thus authorized to write a negative value to core_pipe_limit
>> sysctl which once stored in core_pipe_limit, leads to the signed int
>> dump_count check against core_pipe_limit never be true. The same can be
>> achieved with core_pipe_limit set to INT_MAX.
>>
>> Any negative write or >= to INT_MAX in core_pipe_limit sysctl would
>> hypothetically allow a user to create very high load on the system by
>> running processes that produces a coredump in case the core_pattern
>> sysctl is configured to pipe core files to user space helper.
>> Memory or PID exhaustion should happen before but it anyway breaks the
>> core_pipe_limit semantic
>>
>> This commit fixes this by changing core_pipe_limit sysctl's proc_handler
>> to proc_dointvec_minmax and bound checking between SYSCTL_ZERO and
>> SYSCTL_INT_MAX.
>>
>> Fixes: a293980c2e26 ("exec: let do_coredump() limit the number of concurrent dumps to pipes")
>> Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
>> ---
>>   fs/coredump.c | 7 +++++--
>>   1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/coredump.c b/fs/coredump.c
>> index 7f12ff6ad1d3e..8ea5896e518dd 100644
>> --- a/fs/coredump.c
>> +++ b/fs/coredump.c
>> @@ -616,7 +616,8 @@ void do_coredump(const kernel_siginfo_t *siginfo)
>>   		cprm.limit = RLIM_INFINITY;
>>   
>>   		dump_count = atomic_inc_return(&core_dump_count);
>> -		if (core_pipe_limit && (core_pipe_limit < dump_count)) {
>> +		if ((core_pipe_limit && (core_pipe_limit < dump_count)) ||
>> +		    (core_pipe_limit && dump_count == INT_MAX)) {
> While comparing between 'unsigned int' and 'signed int', C deems them both
> to 'unsigned int', so as an insane user sets core_pipe_limit to INT_MAX,
> and dump_count(signed int) does overflow INT_MAX, checking for
> 'core_pipe_limit < dump_count' is passed, thus codes skips core dump.
>
> So IMO it's enough after changing proc_handler to proc_dointvec_minmax.

Indeed, but the dump_count == INT_MAX is not here to catch overflow but 
if both dump_count
and core_pipe_limit are equal to INT_MAX. core_pipe_limit will not be 
inferior to dump_count.
Or maybe I am missing something ?

I should factorize the test though, this is kind of ugly.

>
> Others in this patch:
> Reviewed-by: Lin Feng <linf@wangsu.com>
>
>>   			printk(KERN_WARNING "Pid %d(%s) over core_pipe_limit\n",
>>   			       task_tgid_vnr(current), current->comm);
>>   			printk(KERN_WARNING "Skipping core dump\n");
>> @@ -1024,7 +1025,9 @@ static struct ctl_table coredump_sysctls[] = {
>>   		.data		= &core_pipe_limit,
>>   		.maxlen		= sizeof(unsigned int),
>>   		.mode		= 0644,
>> -		.proc_handler	= proc_dointvec,
>> +		.proc_handler	= proc_dointvec_minmax,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= SYSCTL_INT_MAX,
>>   	},
>>   	{
>>   		.procname       = "core_file_note_size_limit",
>

