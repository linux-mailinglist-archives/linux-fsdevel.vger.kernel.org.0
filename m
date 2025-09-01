Return-Path: <linux-fsdevel+bounces-59739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53133B3D8C4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 07:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4D916FD7D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 05:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318323D283;
	Mon,  1 Sep 2025 05:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="glE3PBsn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AC21FF44;
	Mon,  1 Sep 2025 05:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704525; cv=none; b=shxF8iWdWtCSDmrML03BQMWz4vDhwMtZR/LNpkw3iyTHRMtSqL9OSdsnVRSNyN4uCVMiETeqKdDtkngGNDimGVlzPXDmaoUEIXrIwUn2+qknOy1nuA8QH7/9a5mfqvBfaY+Gx1GOum3fQTQcZDBl6LBpc9+wIGzTGM0RFm1/0og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704525; c=relaxed/simple;
	bh=VH+6KCioF7nPyFiaGHvYI106SEQk852VC3TqE8gkjzk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BxBcMMgzxR1k4kt4S4XEJUO62kSUoLPB7L1XrecpLWWaPFRtR248PpYjpV7dekSbWan8VxvYWYSLOzzz9Qat9r3KkLG7VYXUWfsXKay0p73wRJKdE1lsAcpzlAv4hEGOIfN2RSL8xw7cpvfIXTRrJ41pdNWuf0ckdUm1jmIgrbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=glE3PBsn; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0RpMW/QmoSWZmxGRn2TYP438jGsUybJgguDX0wk4nWE=; b=glE3PBsns+8CeBPeVzCFehbg3A
	bMwdEcHS+cK1l3/Fc4rZ1OAItsxMPvqRHYMbGl6VrP+hIgyv7CFXmlPJWM3uqsfyIYzqUt8mgaHk2
	d46b/jEBJaSXRtzq9ztcRdmzDF+qT5XOM/ReU481SKEL7cDJkixL0z816Hv6o3ALJfD80FFLxsmqM
	u1Y65lk+Lu00QeqFa8Ou3mZWqx4aJ56egqx0mw1aYaP4niRoPBzz/Tooz9afPJ3DveEQ9XzUM3oRE
	Sm4KLe95n+KMsuXO73IoFIW8NQtxR6X5Io/DBLV7Gj8/n1Wm1VkYH4rzOF5pREspa0sOB2CxduujR
	nkasc42A==;
Received: from [223.233.71.70] (helo=[192.168.1.8])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1usx5f-0058MA-4e; Mon, 01 Sep 2025 07:28:27 +0200
Message-ID: <d48f66cf-9843-1575-bcf0-5117a5527004@igalia.com>
Date: Mon, 1 Sep 2025 10:58:17 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From: Bhupesh Sharma <bhsharma@igalia.com>
Subject: Re: [PATCH v8 4/5] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Kees Cook <kees@kernel.org>, Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, ebiederm@xmission.com,
 brauner@kernel.org, jack@suse.cz, mingo@redhat.com, juri.lelli@redhat.com,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-trace-kernel@vger.kernel.org, torvalds@linux-foundation.org
References: <20250821102152.323367-1-bhupesh@igalia.com>
 <20250821102152.323367-5-bhupesh@igalia.com> <202508250656.9D56526@keescook>
Content-Language: en-US
In-Reply-To: <202508250656.9D56526@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Kees,

On 8/25/25 7:31 PM, Kees Cook wrote:
> On Thu, Aug 21, 2025 at 03:51:51PM +0530, Bhupesh wrote:
>> As Linus mentioned in [1], currently we have several memcpy() use-cases
>> which use 'current->comm' to copy the task name over to local copies.
>> For an example:
>>
>>   ...
>>   char comm[TASK_COMM_LEN];
>>   memcpy(comm, current->comm, TASK_COMM_LEN);
>>   ...
>>
>> These should be rather calling a wrappper like "get_task_array()",
>> which is implemented as:
>>
>>     static __always_inline void
>>         __cstr_array_copy(char *dst,
>>              const char *src, __kernel_size_t size)
>>     {
>>          memcpy(dst, src, size);
>>          dst[size] = 0;
>>     }
>>
>>     #define get_task_array(dst,src) \
>>        __cstr_array_copy(dst, src, __must_be_array(dst))
>>
>> The relevant 'memcpy()' users were identified using the following search
>> pattern:
>>   $ git grep 'memcpy.*->comm\>'
>>
>> Link:https://lore.kernel.org/all/CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com/  #1
>>
>> Signed-off-by: Bhupesh<bhupesh@igalia.com>
>> ---
>>   include/linux/coredump.h                      |  2 +-
>>   include/linux/sched.h                         | 32 +++++++++++++++++++
>>   include/linux/tracepoint.h                    |  4 +--
>>   include/trace/events/block.h                  | 10 +++---
>>   include/trace/events/oom.h                    |  2 +-
>>   include/trace/events/osnoise.h                |  2 +-
>>   include/trace/events/sched.h                  | 13 ++++----
>>   include/trace/events/signal.h                 |  2 +-
>>   include/trace/events/task.h                   |  4 +--
>>   tools/bpf/bpftool/pids.c                      |  6 ++--
>>   .../bpf/test_kmods/bpf_testmod-events.h       |  2 +-
>>   11 files changed, 54 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/linux/coredump.h b/include/linux/coredump.h
>> index 68861da4cf7c..bcee0afc5eaf 100644
>> --- a/include/linux/coredump.h
>> +++ b/include/linux/coredump.h
>> @@ -54,7 +54,7 @@ extern void vfs_coredump(const kernel_siginfo_t *siginfo);
>>   	do {	\
>>   		char comm[TASK_COMM_LEN];	\
>>   		/* This will always be NUL terminated. */ \
>> -		memcpy(comm, current->comm, sizeof(comm)); \
>> +		get_task_array(comm, current->comm); \
>>   		printk_ratelimited(Level "coredump: %d(%*pE): " Format "\n",	\
>>   			task_tgid_vnr(current), (int)strlen(comm), comm, ##__VA_ARGS__);	\
>>   	} while (0)	\
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 5a58c1270474..d26d1dfb9904 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1960,12 +1960,44 @@ extern void wake_up_new_task(struct task_struct *tsk);
>>   
>>   extern void kick_process(struct task_struct *tsk);
>>   
>> +/*
>> + * - Why not use task_lock()?
>> + *   User space can randomly change their names anyway, so locking for readers
>> + *   doesn't make sense. For writers, locking is probably necessary, as a race
>> + *   condition could lead to long-term mixed results.
>> + *   The logic inside __set_task_comm() should ensure that the task comm is
>> + *   always NUL-terminated and zero-padded. Therefore the race condition between
>> + *   reader and writer is not an issue.
>> + */
>> +
>>   extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec);
>>   #define set_task_comm(tsk, from) ({			\
>>   	BUILD_BUG_ON(sizeof(from) < TASK_COMM_LEN);	\
>>   	__set_task_comm(tsk, from, false);		\
>>   })
>>   
>> +/*
>> + * 'get_task_array' can be 'data-racy' in the destination and
>> + * should not be used for cases where a 'stable NUL at the end'
>> + * is needed. Its better to use strscpy and friends for such
>> + * use-cases.
>> + *
>> + * It is suited mainly for a 'just copy comm to a constant-sized
>> + * array' case - especially in performance sensitive use-cases,
>> + * like tracing.
>> + */
>> +
>> +static __always_inline void
>> +	__cstr_array_copy(char *dst, const char *src,
>> +			  __kernel_size_t size)
>> +{
>> +	memcpy(dst, src, size);
>> +	dst[size] = 0;
>> +}
> Please don't reinvent the wheel. :) We already have memtostr, please use
> that (or memtostr_pad).

Sure, but wouldn't we get a static assertion failure: "must be array" 
for memtostr() usage, because of the following:

#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + 
__must_be_array(arr))

I think it would be easier just to set:

   memcpy(dst, src, size);
   dst[size -1] = 0;

instead as Linus and Steven suggested.

Thanks,
Bhupesh

>> +
>> +#define get_task_array(dst, src) \
>> +	__cstr_array_copy(dst, src, __must_be_array(dst))
> Uh, __must_be_array(dst) returns 0 on success. :P Are you sure you
> tested this?
>


