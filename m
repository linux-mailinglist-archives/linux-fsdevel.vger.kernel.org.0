Return-Path: <linux-fsdevel+bounces-53309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1ABAED671
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 10:01:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62CBB3B9E25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 08:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C4244186;
	Mon, 30 Jun 2025 07:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pnOwMpet"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57CA1D88D0;
	Mon, 30 Jun 2025 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751270336; cv=none; b=IVzKGUkM4+zpgt6TG/Kq5blqog887Nsi4BEsxE9oHD8W1f3MiRDaAN8ksqEhOtSJ63+xsOfMbWKkFN/iOwSc7tmXXT6JfsXyAZWQ+4S5YpgtxC91R4N0xJuaRx9DWeM27RoM8XzMVC+mH0mvowF+hsYgMNe4kpfvskPD+2F9Uy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751270336; c=relaxed/simple;
	bh=c+CfIeR3TNcRMMP6tiiP+MQjARsYgeMn+NkhiW3l6jw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EUb4vKRy5z0HZlXjDgNwwkvAEYJIjvjQIm6OJcVnVhK9boQj+GpRHsCDXfrDaYrI4lMAWScipW/3vCVLeG+qHP3BV4CsM++239flIYSse9KX27yXKjPcYhnMs25odTWswT7qI3eKEg1G1mLO/E4EtnQ+Fi5JgQI08O+GsF72+Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pnOwMpet; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qd6nlFnG074iKvcvvBFSCkzEyxCQmvambP47KCg+krI=; b=pnOwMpetoLhGQsMp+XPhrwgE4A
	LkW7SqPS1MN9oE9UZwTFUc3L0SjeNyy9+CULklt/CwDZrQhxI5oGYMxzOmeRZ8F5PVLdDfU+UBpxR
	7ILkpEWZQoeoXbyfkXKzDoG29JYlJqm6b1ZeIqCqc09xG9X5IdWBCsbM1YhtS20mQLkkN0+IBaQsK
	b1V8sjvjlyHZI1oE1rzfQDFqhZ4JiVaW+RCln4YWKxTZRm0NUkAZbpAqiWs5jCSIVFt5PRTbJuVNf
	APwPjXH/HYHykFTwKQBNdsOB6b10jxUiMjeecXJL9jLKEAV26uvuhjD3/vVFHZZ1CdPanEKhbdZ94
	BD7uWUJg==;
Received: from [43.224.128.131] (helo=[10.5.50.117])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uW9PO-00ANeX-Ob; Mon, 30 Jun 2025 09:58:34 +0200
Message-ID: <ba4ddf27-91e7-0ecc-95d5-c139f6978812@igalia.com>
Date: Mon, 30 Jun 2025 13:28:25 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v4 3/3] exec: Add support for 64 byte 'tsk->comm_ext'
From: Bhupesh Sharma <bhsharma@igalia.com>
To: Kees Cook <kees@kernel.org>
Cc: Bhupesh <bhupesh@igalia.com>, akpm@linux-foundation.org,
 kernel-dev@igalia.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org
References: <20250521062337.53262-1-bhupesh@igalia.com>
 <20250521062337.53262-4-bhupesh@igalia.com>
 <202505222041.B639D482FB@keescook>
 <a7c323fe-6d11-4a21-a203-bd60acbfd831@igalia.com>
 <202505231346.52F291C54@keescook>
 <1bc43d6c-2650-0670-8c2a-25e8d36cfb7c@igalia.com>
Content-Language: en-US
In-Reply-To: <1bc43d6c-2650-0670-8c2a-25e8d36cfb7c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/26/25 4:43 PM, Bhupesh Sharma wrote:
> Hi Kees,
>
> On 5/24/25 2:25 AM, Kees Cook wrote:
>> On Fri, May 23, 2025 at 06:01:41PM +0530, Bhupesh Sharma wrote:
>>> 2. %s usage: I checked this at multiple places and can confirm that 
>>> %s usage
>>> to print out 'tsk->comm' (as a string), get the longer
>>>      new "extended comm".
>> As an example of why I don't like this union is that this is now lying
>> to the compiler. e.g. a %s of an object with a known size (sizeof(comm))
>> may now run off the end of comm without finding a %NUL character... this
>> is "safe" in the sense that the "extended comm" is %NUL terminated, but
>> it makes the string length ambiguous for the compiler (and any
>> associated security hardening).
>
> Right.
>
>>
>>> 3. users who do 'sizeof(->comm)' will continue to get the old value 
>>> because
>>> of the union.
>> Right -- this is exactly where I think it can get very very wrong,
>> leaving things unterminated.
>>
>>> The problem with having two separate comms: tsk->comm and 
>>> tsk->ext_comm,
>>> instead of a union is two fold:
>>> (a). If we keep two separate statically allocated comms: tsk->comm and
>>> tsk->ext_comm in struct task_struct, we need to basically keep 
>>> supporting
>>> backward compatibility / ABI via tsk->comm and ask new user-land 
>>> users to
>>> move to tsk->ext_comm.
>>>
>>> (b). If we keep one statically allocated comm: tsk->comm and one 
>>> dynamically allocated tsk->ext_comm in struct task_struct, then we 
>>> have the problem of allocating the tsk->ext_comm which _may_ be in 
>>> the exec()  hot path.
>>>
>>> I think the discussion between Linus and Yafang (see [1]), was more 
>>> towards avoiding the approach in 3(a).
>>>
>>> Also we discussed the 3(b) approach, during the review of v2 of this 
>>> series, where there was a apprehensions around: adding another field 
>>> to store the task name and allocating tsk->ext_comm dynamically in 
>>> the exec() hot path (see [2]).
>> Right -- I agree we need them statically allocated. But I think a union
>> is going to be really error-prone.
>>
>> How about this: rename task->comm to something else (task->comm_str?),
>> increase its size and then add ABI-keeping wrappers for everything that
>> _must_ have the old length.
>>
>> Doing this guarantees we won't miss anything (since "comm" got renamed),
>> and during the refactoring all the places where the old length is 
>> required
>> will be glaringly obvious. (i.e. it will be harder to make mistakes
>> about leaving things unterminated.)
>>
>
> Ok, I got your point. Let me explore then how best a ABI-keeping 
> wrapper can be introduced.
> I am thinking of something like:
>
> abi_wrapper_get_task_comm {
>
>     if (requested_comm_length <= 16)
>         return 16byte comm with NUL terminator; // old comm (16-bytes)
>     else
>         return 64byte comm with NUL terminator; // extended comm 
> (64-bytes)
>     ....
> }
>
> Please let me know if this looks better. Accordingly I will start with 
> v5 changes.

Hi Everyone, sorry for the delay but I wanted the revive this discussion 
after the -rc1 and my PTO.

I am looking for suggestions on how to implement v5 for this series. 
Here is some background of the version (and related discussions so far):

In the v4, the implementation for tsk->comm handling (for supporting 
long 64byte task names) looked at handling the possible use-cases as 
follows:

1. memcpy() users: Handled by [PATCH 2/3] of this series, where we 
identify existing users using the following search
     pattern:
        $ git grep 'memcpy.*->comm\>'

2. %s usage: I checked this at multiple places and can confirm that %s 
usage to print out 'tsk->comm' (as a string), get the longer
     new "extended comm".

3. users who do 'sizeof(->comm)' will continue to get the old value 
because of the union.

The above points were taken to address the points discussed earlier 
between Linus and Yafang (see [1])

As Kees, suggested in the v4 review (see [2]):
1. Let's rename task->comm to something else (task->comm_str?) and 
increase its size, and

2. Then add ABI-keeping wrappers for everything that  _must_ have the 
old length.

I am thinking of implementing it with something like:

abi_wrapper_get_task_comm {

     if (requested_comm_length <= 16)
         return 16byte comm with NUL terminator; // old comm (16-bytes)
     else
         return 64byte comm with NUL terminator; // extended comm 
(64-bytes)
     ....
}

Kindly let me know your views on the above approach(es).

[1]. 
https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/
[2]. https://lore.kernel.org/all/202505231346.52F291C54@keescook/

Thanks.

