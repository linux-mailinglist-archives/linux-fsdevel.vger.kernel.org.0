Return-Path: <linux-fsdevel+bounces-45717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29724A7B750
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 07:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEFC518855E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 05:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA53166F1A;
	Fri,  4 Apr 2025 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Q9kDdsYy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5A72E62C0;
	Fri,  4 Apr 2025 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743744702; cv=none; b=ExgHfS1++KRJJiuBOrmfYrTQmRMEatR0nnNOhRFTtCF/Xhqunme6jR6d1vEWm7+skdr1S/AGapyNUqE4z5JSvDUq3z8ssCkQisTbknI+RuaUct8H1jKyoilBjzcXX0r9GdQHZ5cdscI6IeTn2me6hxqQAgsNpDmLiU5FNZ33Trw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743744702; c=relaxed/simple;
	bh=BvmulAeaabO85X4ftFXFh02y82mIVRxbrUS0v/w2564=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h+/hF+RAhYcGRaYHxEVhuDf8V+d5MHXQMP97Yj/F8KSG4LRn5PJ299jqWXe0U6AIXQuoWXRsdcsLM8QAU69ucY4prlbMLSnESntDCWdDjOoMDCCW3wEGn3tamcJEfZrBNH0XiOagIfYMaGE25lt8w9eNUZmRqNux0v2arBgde8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Q9kDdsYy; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=m0feoZm9sH9aLLi6evQGqxqekCHH6wsr0FesFAZnxp4=; b=Q9kDdsYyKLrg2ePBI8QxjnP7KP
	GOYdGm5/f7zZ9ffUbfAV7N69r5XFuMhC0InQJnxVvTa/PfYKsiQRphAmszK5f5NB/1nTNjxKg8I36
	85ajkImalrnc+KtkGTFiEwriI/+NKUzAvxV9hHZrH8L78oN2JIktMfZKPA3/BaiiF6zarJzhKCJds
	hV6i9URQjew2dz59SGm+BKyxl68ginscXCoyWXF+X224TiObOnGYGbKpCkewaHMiDuyWbsdKNlGy5
	ZTx3qWo+X9YOhDJIonXIKRLzeJi6eso0wFUH0Md/m9vj6RJFbFv37WzZTOtfGr+AfVuG+vjd79dAo
	fXZTxY2A==;
Received: from [223.233.74.223] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1u0Ze9-00BBxp-Gj; Fri, 04 Apr 2025 07:31:17 +0200
Message-ID: <daa87c96-546d-c3c1-ef45-9213959ae629@igalia.com>
Date: Fri, 4 Apr 2025 11:01:09 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] exec: Dynamically allocate memory to store task's
 full name
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Bhupesh <bhupesh@igalia.com>
Cc: akpm@linux-foundation.org, kernel-dev@igalia.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, oliver.sang@intel.com, lkp@intel.com,
 laoar.shao@gmail.com, pmladek@suse.com, rostedt@goodmis.org,
 mathieu.desnoyers@efficios.com, arnaldo.melo@gmail.com,
 alexei.starovoitov@gmail.com, andrii.nakryiko@gmail.com,
 mirq-linux@rere.qmqm.pl, peterz@infradead.org, willy@infradead.org,
 david@redhat.com, viro@zeniv.linux.org.uk, keescook@chromium.org,
 ebiederm@xmission.com, brauner@kernel.org, jack@suse.cz, mingo@redhat.com,
 juri.lelli@redhat.com, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com
References: <20250331121820.455916-1-bhupesh@igalia.com>
 <20250331121820.455916-2-bhupesh@igalia.com> <Z-tlVsM2Dq70gC4r@harry>
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <Z-tlVsM2Dq70gC4r@harry>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/1/25 9:32 AM, Harry Yoo wrote:
> On Mon, Mar 31, 2025 at 05:48:18PM +0530, Bhupesh wrote:
>> Provide a parallel implementation for get_task_comm() called
>> get_task_full_name() which allows the dynamically allocated
>> and filled-in task's full name to be passed to interested
>> users such as 'gdb'.
>>
>> Currently while running 'gdb', the 'task->comm' value of a long
>> task name is truncated due to the limitation of TASK_COMM_LEN.
>>
>> For example using gdb to debug a simple app currently which generate
>> threads with long task names:
>>    # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>>    # cat log
>>
>>    NameThatIsTooLo
>>
>> This patch does not touch 'TASK_COMM_LEN' at all, i.e.
>> 'TASK_COMM_LEN' and the 16-byte design remains untouched. Which means
>> that all the legacy / existing ABI, continue to work as before using
>> '/proc/$pid/task/$tid/comm'.
>>
>> This patch only adds a parallel, dynamically-allocated
>> 'task->full_name' which can be used by interested users
>> via '/proc/$pid/task/$tid/full_name'.
>>
>> After this change, gdb is able to show full name of the task:
>>    # gdb ./threadnames -ex "run info thread" -ex "detach" -ex "quit" > log
>>    # cat log
>>
>>    NameThatIsTooLongForComm[4662]
>>
>> Signed-off-by: Bhupesh <bhupesh@igalia.com>
>> ---
>>   fs/exec.c             | 21 ++++++++++++++++++---
>>   include/linux/sched.h |  9 +++++++++
>>   2 files changed, 27 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index f45859ad13ac..4219d77a519c 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1208,6 +1208,9 @@ int begin_new_exec(struct linux_binprm * bprm)
>>   {
>>   	struct task_struct *me = current;
>>   	int retval;
>> +	va_list args;
>> +	char *name;
>> +	const char *fmt;
>>   
>>   	/* Once we are committed compute the creds */
>>   	retval = bprm_creds_from_file(bprm);
>> @@ -1348,11 +1351,22 @@ int begin_new_exec(struct linux_binprm * bprm)
>>   		 * detecting a concurrent rename and just want a terminated name.
>>   		 */
>>   		rcu_read_lock();
>> -		__set_task_comm(me, smp_load_acquire(&bprm->file->f_path.dentry->d_name.name),
>> -				true);
>> +		fmt = smp_load_acquire(&bprm->file->f_path.dentry->d_name.name);
>> +		name = kvasprintf(GFP_KERNEL, fmt, args);
>> +		if (!name)
>> +			return -ENOMEM;
> Is it safe to return error here, instead of jumping to 'out_unlock' label
> and then releasing locks?

Ok, let me modify this in v3 to ensure that locks are released properly.

>> +		me->full_name = name;
>> +		__set_task_comm(me, fmt, true);
>>   		rcu_read_unlock();
>>   	} else {
>> -		__set_task_comm(me, kbasename(bprm->filename), true);
>> +		fmt = kbasename(bprm->filename);
>> +		name = kvasprintf(GFP_KERNEL, fmt, args);
>> +		if (!name)
>> +			return -ENOMEM;
>> +
>> +		me->full_name = name;
>> +		__set_task_comm(me, fmt, true);
>>   	}
>>   
>>   	/* An exec changes our domain. We are no longer part of the thread
>> @@ -1399,6 +1413,7 @@ int begin_new_exec(struct linux_binprm * bprm)
>>   	return 0;
>>   
>>   out_unlock:
>> +	kfree(me->full_name);
>>   	up_write(&me->signal->exec_update_lock);
>>   	if (!bprm->cred)
>>   		mutex_unlock(&me->signal->cred_guard_mutex);
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 56ddeb37b5cd..053b52606652 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -1166,6 +1166,9 @@ struct task_struct {
>>   	 */
>>   	char				comm[TASK_COMM_LEN];
>>   
>> +	/* To store the full name if task comm is truncated. */
>> +	char				*full_name;
>> +
>>   	struct nameidata		*nameidata;
>>   
>>   #ifdef CONFIG_SYSVIPC
>> @@ -2007,6 +2010,12 @@ extern void __set_task_comm(struct task_struct *tsk, const char *from, bool exec
>>   	buf;						\
>>   })
>>   
>> +#define get_task_full_name(buf, buf_size, tsk) ({	\
>> +	BUILD_BUG_ON(sizeof(buf) < TASK_COMM_LEN);	\
>> +	strscpy_pad(buf, (tsk)->full_name, buf_size);	\
>> +	buf;						\
>> +})
>> +
>>   #ifdef CONFIG_SMP
>>   static __always_inline void scheduler_ipi(void)
>>   {
>> -- 
>> 2.38.1
>>
>>

Thanks.

