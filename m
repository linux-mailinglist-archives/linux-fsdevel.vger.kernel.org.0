Return-Path: <linux-fsdevel+bounces-48460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DA0AAF588
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 10:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12F53175C88
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156042288D3;
	Thu,  8 May 2025 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rTr5kv4J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0A422172E;
	Thu,  8 May 2025 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746692537; cv=none; b=EceprA29wwAZWrsToCnXHuRkrRF2ExErmgSk0ylb41zRyi7+QwuuHN3Gbe1F6rDz6fvvKCv6cdFl2i96blIFuAo3srDGb9kbF/pRfduyei9HgttUZXbL4jhuWeUpWwBPmbVhcsrjuQEIrWvVr6Q++qB7C05W3tliVi8q02og27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746692537; c=relaxed/simple;
	bh=9Wc/hLynfq4stOHrbHVfhr0OWMN4PjXj493SenRBBxQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OwkZvO0aG0g0G8jKHXW90EQWt9KA6Q1kzkKj5Vt2Ht+E2mIRfmYj1cAQWZN/aUpQKWSuuICpQBBlR9Yl/Hh7/BtznFrREubCrvkX1WLwEk99r+L3Lmrs/gHpx/VZwi1kUaRg1PSsYJhvsz0NUB7NBt0OQ/kEuJ7SwfGt0Pj8s0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rTr5kv4J; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=CyA4fdewJCdynAxXbxpGy2pyASTRxTov0Q5FFYV+koE=; b=rTr5kv4JM8lEQaje0SpZ81EMpa
	nRCOclH0h/mS3Slv643F5s7Zh1JSj1cHELrJHIxEBWvURQEG7RzjkcbEh181emB5FXRBKRG4ya3NK
	6j0yG8NI4d4wVCP996ls4W3PBCWOLw2QNJXb8lXRY8/zYxCBQ/L9XjWZHJAGiwj7GBND0BYpSwthn
	da7zvwhLD0EKJ0X255mQ+INCtR1FSzu/WJNnv59pDCHVNMfn9SlJsDoUXYWnqHdz6NwW1Rcf8Mz77
	vaICt2hUCVUPyuthiCK4DTM8CclIrFCkN8OospG9kIyIVlj9I46f72ZwLzymXToqc+BBBfBvYox8h
	21bbeKPw==;
Received: from [223.233.71.203] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1uCwS4-0056VN-LH; Thu, 08 May 2025 10:22:08 +0200
Message-ID: <3fd1dd03-ce1c-37e5-98aa-a91ab5d210b3@igalia.com>
Date: Thu, 8 May 2025 13:52:01 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
Content-Language: en-US
From: Bhupesh Sharma <bhsharma@igalia.com>
To: Petr Mladek <pmladek@suse.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 arnaldo.melo@gmail.com, alexei.starovoitov@gmail.com,
 andrii.nakryiko@gmail.com, mirq-linux@rere.qmqm.pl, peterz@infradead.org,
 willy@infradead.org, david@redhat.com, viro@zeniv.linux.org.uk,
 keescook@chromium.org, ebiederm@xmission.com, brauner@kernel.org,
 jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com
References: <20250507110444.963779-1-bhupesh@igalia.com>
 <20250507110444.963779-3-bhupesh@igalia.com>
 <aBtSK5dFmtFXUaOE@pathway.suse.cz>
 <4af48ad5-1aa7-46d0-bfca-7779294e355c@igalia.com>
In-Reply-To: <4af48ad5-1aa7-46d0-bfca-7779294e355c@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 5/8/25 1:47 PM, Bhupesh Sharma wrote:
> Hi Petr,
>
> On 5/7/25 5:59 PM, Petr Mladek wrote:
>> On Wed 2025-05-07 16:34:43, Bhupesh wrote:
>>> As Linus mentioned in [1], currently we have several memcpy() use-cases
>>> which use 'current->comm' to copy the task name over to local copies.
>>> For an example:
>>>
>>>   ...
>>>   char comm[TASK_COMM_LEN];
>>>   memcpy(comm, current->comm, TASK_COMM_LEN);
>>>   ...
>>>
>>> These should be modified so that we can later implement approaches
>>> to handle the task->comm's 16-byte length limitation (TASK_COMM_LEN)
>>> is a more modular way (follow-up patches do the same):
>>>
>>>   ...
>>>   char comm[TASK_COMM_LEN];
>>>   memcpy(comm, current->comm, TASK_COMM_LEN);
>>>   comm[TASK_COMM_LEN - 1] = 0;
>>>   ...
>>>
>>> The relevant 'memcpy()' users were identified using the following 
>>> search
>>> pattern:
>>>   $ git grep 'memcpy.*->comm\>'
>>>
>>> [1]. 
>>> https://lore.kernel.org/all/CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com/
>>>
>>> --- a/include/linux/coredump.h
>>> +++ b/include/linux/coredump.h
>>> @@ -53,7 +53,8 @@ extern void do_coredump(const kernel_siginfo_t 
>>> *siginfo);
>>>       do {    \
>>>           char comm[TASK_COMM_LEN];    \
>>>           /* This will always be NUL terminated. */ \
>>> -        memcpy(comm, current->comm, sizeof(comm)); \
>>> +        memcpy(comm, current->comm, TASK_COMM_LEN); \
>>> +        comm[TASK_COMM_LEN] = '\0'; \
>> I would expect that we replace this with a helper function/macro
>> which would do the right thing.
>>
>> Why is get_task_comm() not used here, please?
>>
>>>           printk_ratelimited(Level "coredump: %d(%*pE): " Format 
>>> "\n",    \
>> Also the name seems to be used for printing a debug information.
>> I would expect that we could use the bigger buffer here and print
>> the "full" name. Is this planed, please?
>>
>>>               task_tgid_vnr(current), (int)strlen(comm), comm, 
>>> ##__VA_ARGS__);    \
>>>       } while (0)    \
>>> diff --git a/include/trace/events/block.h 
>>> b/include/trace/events/block.h
>>> index bd0ea07338eb..94a941ac2034 100644
>>> --- a/include/trace/events/block.h
>>> +++ b/include/trace/events/block.h
>>> @@ -214,6 +214,7 @@ DECLARE_EVENT_CLASS(block_rq,
>>>           blk_fill_rwbs(__entry->rwbs, rq->cmd_flags);
>>>           __get_str(cmd)[0] = '\0';
>>>           memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
>>> +        __entry->comm[TASK_COMM_LEN - 1] = '\0';
>> Same for all other callers.
>>
>> That said, I am not sure if the larger buffer is save in all situations.
>>
>>>       ),
>>
>
> Thanks for the review, I agree on using the helper / wrapper function 
> to replace this open-coded memcpy + set last entry as '\0'.
>
> However I see that Steven has already shared a RFC approach (see [1]), 
> to use __string() instead of fixed lengths for 'task->comm' for 
> tracing events.
> I plan to  rebase my v4 on top of his RFC, which might mean that this 
> patch would no longer be needed in the v4.
>
> [1]. 
> https://lore.kernel.org/linux-trace-kernel/20250507133458.51bafd95@gandalf.local.home/
>

Sorry, pressed the send button too quickly :D

I instead meant - "I plan to  rebase my v4 on top of Steven's RFC, which 
might mean that this patch would no longer need to address the trace 
events, but would still need to handle other places where tsk->comm 
directly in memcpy() and replace it with 'get_task_comm()' instead".

Thanks.

