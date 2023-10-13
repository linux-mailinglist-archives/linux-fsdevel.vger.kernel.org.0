Return-Path: <linux-fsdevel+bounces-261-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AF97C87BD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 16:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 888CB1C2118D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A269B19BD6;
	Fri, 13 Oct 2023 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WCGALqVN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5B218E38
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 14:21:36 +0000 (UTC)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24B9CE
	for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 07:21:34 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7a2874d2820so29494539f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Oct 2023 07:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697206894; x=1697811694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AScjHWZao3JWzSTjB5/ohVC8e3iHyB9Wq7OFyIrmWB0=;
        b=WCGALqVN6mIgNUe82QIUlKXjiDAF+udqOQd+aF8rspE47C0XKATFIS8ziQs+tixtjA
         CJ782Aq0TzYOQJeEIlL5YfYGNho8XfdO1t3CZ0u0EpJPj+m9cYHwBOAjXlCoSErSFxWo
         zyp4zSeIpeIbDLh5Z8Sn6ULZQueU3uAkn5X3zdq3V3slt67B9T2kdBGYihHIzKdQmuNN
         EEf6zWndS32dUbW8+B+YzwpUo5/HbFc+1wi3DfDMTU3pcKiDLOlOrEeum2ubvMzwmepj
         kYRIv4OFl6nsPEv0GWaGcPiMiDbmZ04oiRdf892Wh++9vUU/sJ4CEcsgtgOKlGC7Pkvo
         GG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697206894; x=1697811694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AScjHWZao3JWzSTjB5/ohVC8e3iHyB9Wq7OFyIrmWB0=;
        b=CQOT/eddPLcn5P0GQKaSUP++iiHDYuCCJWgfb4gHsU1yZKyS8oLK1fc51YqGXtpmbs
         zjjZBZDimdt3+yEOz/bwlvAzOX2oEZI86OJImALjvTk97LqP48Cpo+ADX9QeDBkisF9U
         8d3o8IxodRiskLrVbVVIFZ5E16xp0eSxJUtHZf35U/bCd2UMuJR+TQ/yXpGTZ9883aUS
         vi2zU7/Lu/i41VGR442zw4sSJdbNGK0v0bLkw4VvYvjglkMAqnYIC+wJqovRKPmQ86c9
         eb5ngOBWtvPbqB1zxc958Vzd6Aq3EWMD8UE0XYBuKeFFeJW2CvUwGFcTyqIfT/H0Jgdw
         mhnQ==
X-Gm-Message-State: AOJu0YxbmMz95ommdmokzcoQtyiyVaZPKmiRn2AHe1iqZAgAH9bG/EP7
	B0FZNwXiFnIiawyAknhMzdLyNuOQ4XaAOwfybb563A==
X-Google-Smtp-Source: AGHT+IG4Rtj3NyiZvBnrsWw8vZbB/oOVwWkg1O+QaRYX/lm7eF3rhFGao8bunVUuyXcTNCS5dZmTBg==
X-Received: by 2002:a6b:5a0a:0:b0:790:958e:a667 with SMTP id o10-20020a6b5a0a000000b00790958ea667mr25742740iob.2.1697206894059;
        Fri, 13 Oct 2023 07:21:34 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i13-20020a02b68d000000b004290fd3a68dsm4549709jam.1.2023.10.13.07.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 07:21:33 -0700 (PDT)
Message-ID: <672d257e-e28f-42bc-8ac7-253d20fe187c@kernel.dk>
Date: Fri, 13 Oct 2023 08:21:32 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] audit,io_uring: io_uring openat triggers audit reference
 count underflow
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 Dan Clash <daclash@linux.microsoft.com>
Cc: audit@vger.kernel.org, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org, paul@paul-moore.com,
 linux-fsdevel@vger.kernel.org, dan.clash@microsoft.com
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20231013-insofern-gegolten-75ca48b24cf5@brauner>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231013-insofern-gegolten-75ca48b24cf5@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/13/23 2:24 AM, Christian Brauner wrote:
> On Thu, Oct 12, 2023 at 02:55:18PM -0700, Dan Clash wrote:
>> An io_uring openat operation can update an audit reference count
>> from multiple threads resulting in the call trace below.
>>
>> A call to io_uring_submit() with a single openat op with a flag of
>> IOSQE_ASYNC results in the following reference count updates.
>>
>> These first part of the system call performs two increments that do not race.
>>
>> do_syscall_64()
>>   __do_sys_io_uring_enter()
>>     io_submit_sqes()
>>       io_openat_prep()
>>         __io_openat_prep()
>>           getname()
>>             getname_flags()       /* update 1 (increment) */
>>               __audit_getname()   /* update 2 (increment) */
>>
>> The openat op is queued to an io_uring worker thread which starts the
>> opportunity for a race.  The system call exit performs one decrement.
>>
>> do_syscall_64()
>>   syscall_exit_to_user_mode()
>>     syscall_exit_to_user_mode_prepare()
>>       __audit_syscall_exit()
>>         audit_reset_context()
>>            putname()              /* update 3 (decrement) */
>>
>> The io_uring worker thread performs one increment and two decrements.
>> These updates can race with the system call decrement.
>>
>> io_wqe_worker()
>>   io_worker_handle_work()
>>     io_wq_submit_work()
>>       io_issue_sqe()
>>         io_openat()
>>           io_openat2()
>>             do_filp_open()
>>               path_openat()
>>                 __audit_inode()   /* update 4 (increment) */
>>             putname()             /* update 5 (decrement) */
>>         __audit_uring_exit()
>>           audit_reset_context()
>>             putname()             /* update 6 (decrement) */
>>
>> The fix is to change the refcnt member of struct audit_names
>> from int to atomic_t.
>>
>> kernel BUG at fs/namei.c:262!
>> Call Trace:
>> ...
>>  ? putname+0x68/0x70
>>  audit_reset_context.part.0.constprop.0+0xe1/0x300
>>  __audit_uring_exit+0xda/0x1c0
>>  io_issue_sqe+0x1f3/0x450
>>  ? lock_timer_base+0x3b/0xd0
>>  io_wq_submit_work+0x8d/0x2b0
>>  ? __try_to_del_timer_sync+0x67/0xa0
>>  io_worker_handle_work+0x17c/0x2b0
>>  io_wqe_worker+0x10a/0x350
>>
>> Cc: <stable@vger.kernel.org>
>> Link: https://lore.kernel.org/lkml/MW2PR2101MB1033FFF044A258F84AEAA584F1C9A@MW2PR2101MB1033.namprd21.prod.outlook.com/
>> Fixes: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
>> Signed-off-by: Dan Clash <daclash@linux.microsoft.com>
>> ---
>>  fs/namei.c         | 9 +++++----
>>  include/linux/fs.h | 2 +-
>>  kernel/auditsc.c   | 8 ++++----
>>  3 files changed, 10 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 567ee547492b..94565bd7e73f 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -188,7 +188,7 @@ getname_flags(const char __user *filename, int flags, int *empty)
>>  		}
>>  	}
>>  
>> -	result->refcnt = 1;
>> +	atomic_set(&result->refcnt, 1);
>>  	/* The empty path is special. */
>>  	if (unlikely(!len)) {
>>  		if (empty)
>> @@ -249,7 +249,7 @@ getname_kernel(const char * filename)
>>  	memcpy((char *)result->name, filename, len);
>>  	result->uptr = NULL;
>>  	result->aname = NULL;
>> -	result->refcnt = 1;
>> +	atomic_set(&result->refcnt, 1);
>>  	audit_getname(result);
>>  
>>  	return result;
>> @@ -261,9 +261,10 @@ void putname(struct filename *name)
>>  	if (IS_ERR(name))
>>  		return;
>>  
>> -	BUG_ON(name->refcnt <= 0);
>> +	if (WARN_ON_ONCE(!atomic_read(&name->refcnt)))
>> +		return;
>>  
>> -	if (--name->refcnt > 0)
>> +	if (!atomic_dec_and_test(&name->refcnt))
>>  		return;
> 
> Fine by me. I'd write this as:
> 
> count = atomic_dec_if_positive(&name->refcnt);
> if (WARN_ON_ONCE(unlikely(count < 0))
> 	return;
> if (count > 0)
> 	return;

Would be fine too, my suspicion was that most archs don't implement a
primitive for that, and hence it might be more expensive than
atomic_read()/atomic_dec_and_test() which do. But I haven't looked at
the code generation. The dec_if_positive degenerates to a atomic cmpxchg
for most cases.

-- 
Jens Axboe


