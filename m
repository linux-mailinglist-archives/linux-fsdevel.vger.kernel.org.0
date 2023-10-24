Return-Path: <linux-fsdevel+bounces-969-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B33E7D44F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 03:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBB4CB209DE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Oct 2023 01:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C389A63B1;
	Tue, 24 Oct 2023 01:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d7Nk2X/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CC6568A
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Oct 2023 01:26:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80EA10C0
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Oct 2023 18:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698110798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vq2XxiPaMfNNhYoiNTp4t4HbMspKVC35io247MdFBeE=;
	b=d7Nk2X/ovVFO4Y3KhA0Vq7ISDLxtsbCCx2I1eZ9qmqDlLi/oh0bPXwvmdY1n1IkedZEv18
	oxXnEwX5GuSKbO6TyoCQE1Y0kmCBYuoE4qX+Aw5ZKAvdhOhpXyW4tnv2WMljBKLIFc5mXb
	u7+h+7KxZrsdVTPEVLel+hmUA2Zwg8A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-odKU-i64N6SMrp57C7EpdQ-1; Mon,
 23 Oct 2023 21:26:34 -0400
X-MC-Unique: odKU-i64N6SMrp57C7EpdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A41053813F2B;
	Tue, 24 Oct 2023 01:26:32 +0000 (UTC)
Received: from [10.22.8.176] (unknown [10.22.8.176])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2B6C98C0A;
	Tue, 24 Oct 2023 01:26:32 +0000 (UTC)
Message-ID: <bffabf0a-36e9-46c6-a52e-4ac9f47e6d3f@redhat.com>
Date: Mon, 23 Oct 2023 21:26:31 -0400
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] XArray: Make xa_lock_init macro
Content-Language: en-US
To: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>
References: <20231002082535.1516405-1-stanislaw.gruszka@linux.intel.com>
 <20231023084943.GE704032@linux.intel.com>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20231023084943.GE704032@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5


On 10/23/23 04:49, Stanislaw Gruszka wrote:
> On Mon, Oct 02, 2023 at 10:25:35AM +0200, Stanislaw Gruszka wrote:
>> Make xa_init_flags() macro to avoid false positive lockdep splats.
>
> Friendly ping. The subject should be changed to mention xa_init_flags(),
> but anything else should be done here to get it apply ?
>
> Regards
> Stanislaw
>
>
>> When spin_lock_init() is used inside initialization function (like
>> in xa_init_flags()) which can be called many times, lockdep assign
>> the same key to different locks.
>>
>> For example this splat is seen with intel_vpu driver which uses
>> two xarrays and has two separate xa_init_flags() calls:
>>
>> [ 1139.148679] WARNING: inconsistent lock state
>> [ 1139.152941] 6.6.0-hardening.1+ #2 Tainted: G           OE
>> [ 1139.158758] --------------------------------
>> [ 1139.163024] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
>> [ 1139.169018] kworker/10:1/109 [HC1[1]:SC0[0]:HE0:SE1] takes:
>> [ 1139.174576] ffff888137237150 (&xa->xa_lock#18){?.+.}-{2:2}, at: ivpu_mmu_user_context_mark_invalid+0x1c/0x80 [intel_vpu]
>> [ 1139.185438] {HARDIRQ-ON-W} state was registered at:
>> [ 1139.190305]   lock_acquire+0x1a3/0x4a0
>> [ 1139.194055]   _raw_spin_lock+0x2c/0x40
>> [ 1139.197800]   ivpu_submit_ioctl+0xf0b/0x3520 [intel_vpu]
>> [ 1139.203114]   drm_ioctl_kernel+0x201/0x3f0 [drm]
>> [ 1139.207791]   drm_ioctl+0x47d/0xa20 [drm]
>> [ 1139.211846]   __x64_sys_ioctl+0x12e/0x1a0
>> [ 1139.215849]   do_syscall_64+0x59/0x90
>> [ 1139.219509]   entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>> [ 1139.224636] irq event stamp: 45500
>> [ 1139.228037] hardirqs last  enabled at (45499): [<ffffffff92ef0314>] _raw_spin_unlock_irq+0x24/0x50
>> [ 1139.236961] hardirqs last disabled at (45500): [<ffffffff92eadf8f>] common_interrupt+0xf/0x90
>> [ 1139.245457] softirqs last  enabled at (44956): [<ffffffff92ef3430>] __do_softirq+0x4c0/0x712
>> [ 1139.253862] softirqs last disabled at (44461): [<ffffffff907df310>] irq_exit_rcu+0xa0/0xd0
>> [ 1139.262098]
>>                 other info that might help us debug this:
>> [ 1139.268604]  Possible unsafe locking scenario:
>>
>> [ 1139.274505]        CPU0
>> [ 1139.276955]        ----
>> [ 1139.279403]   lock(&xa->xa_lock#18);
>> [ 1139.282978]   <Interrupt>
>> [ 1139.285601]     lock(&xa->xa_lock#18);
>> [ 1139.289345]
>>                  *** DEADLOCK ***
>>
>> Lockdep falsely identified xa_lock from two different xarrays as the same
>> lock and report deadlock. More detailed description of the problem
>> is provided in commit c21f11d182c2 ("drm: fix drmm_mutex_init()")
>>
>> Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
>> ---
>>   include/linux/xarray.h | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>> index cb571dfcf4b1..409d9d739ee9 100644
>> --- a/include/linux/xarray.h
>> +++ b/include/linux/xarray.h
>> @@ -375,12 +375,12 @@ void xa_destroy(struct xarray *);
>>    *
>>    * Context: Any context.
>>    */
>> -static inline void xa_init_flags(struct xarray *xa, gfp_t flags)
>> -{
>> -	spin_lock_init(&xa->xa_lock);
>> -	xa->xa_flags = flags;
>> -	xa->xa_head = NULL;
>> -}
>> +#define xa_init_flags(_xa, _flags)	\
>> +do {					\
>> +	spin_lock_init(&(_xa)->xa_lock);\
>> +	(_xa)->xa_flags = (_flags);	\
>> +	(_xa)->xa_head = NULL;		\
>> +} while (0)
>>   
>>   /**
>>    * xa_init() - Initialise an empty XArray.
>> @@ -390,10 +390,7 @@ static inline void xa_init_flags(struct xarray *xa, gfp_t flags)
>>    *
>>    * Context: Any context.
>>    */
>> -static inline void xa_init(struct xarray *xa)
>> -{
>> -	xa_init_flags(xa, 0);
>> -}
>> +#define xa_init(xa) xa_init_flags(xa, 0)
>>   
>>   /**
>>    * xa_empty() - Determine if an array has any present entries.
>> -- 
>> 2.25.1
>>
LGTM. However, it is up to Matthew to take it or not as he is the XArray 
maintainer.

Acked-by: Waiman Long <longman@redhat.com>


