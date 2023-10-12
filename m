Return-Path: <linux-fsdevel+bounces-207-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4447C7942
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Oct 2023 00:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5660A282C61
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 22:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BF13FB30;
	Thu, 12 Oct 2023 22:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Lvn7N9uv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161F13B28A
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 22:07:51 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C8AE0
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:07:49 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6bc9353be9bso212141a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 15:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1697148468; x=1697753268; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BX2/UVo10WOnZMCSNHexte/JXK8qu4Upt2chvVFA7x8=;
        b=Lvn7N9uv69OZ121AzsqYZ2McrKtiTMN2tMUBLVvOksqkKLDH+drXyGVEVaXdxKGXTx
         Phb21hBcMMvtmC913ArKg86TM83fNUWdt7laSTB8IF6uWHxQDsC81Z5o+GS5GA42AWv8
         mPXjVN/rkqLLJCTzlddx52AtBxdiwEArOLdZWa1CJhdFKijFmJcAjZcqeHeiUhoDGI/x
         qnOlMa53ZqH+u6HjpAlgHTBUhKnKOvVYHFOmkHvFDrsn7TnjTn2+1tz6R3C7C1KOTuui
         KO5Ki88kPktgoJHCceTHiKrtkqZk1F5mT0lg48Jn0EfRFlmvai8eqdVUgHdM2CKRt8VO
         DZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697148468; x=1697753268;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BX2/UVo10WOnZMCSNHexte/JXK8qu4Upt2chvVFA7x8=;
        b=U5Wfq2F+vsNOUQ0QMhCTNkeVHvOu/ZS46npSZOuEiNuLTPCD/0iMXfcrpk+jxR6TV/
         xmPPs9xpVF364a5vVzSNszsKnMh52KR2SNxupZavE5aPNLOBYsEQrRB7+ji837/GUKws
         zQPbQ+rwkNLsfw5iU7szGztyHAL0tnwoPEBnZSt41lV5L5EN5nH/qYqZGxRSqYJe9qnL
         PB2ey6ckfu+k2F//Yh0zW0sxgX0OAEmawHW5gEsFKyho+AexMWQNoM4/7ftnjCHWt1iJ
         0UwieHf1sWoWx7CDjk2CDrggcSAo4C3Spgc5CVBJTNbR5clqUDmnycbV9dCYDTVmOAZy
         iTcQ==
X-Gm-Message-State: AOJu0Yy7uj1/XNIf1wEho1zhAttecTQbmegOwe8Y5+uKHCpuPrUUHro1
	0YFVUKzUg3YWuSMHg1ssHo1Gsw==
X-Google-Smtp-Source: AGHT+IE69wm+LfM1P9hVAjNQFO/fTOBepgHbSEMYy1IVhm+plv/9fJIRwOYYZ4z6oxAD4V9Qyp04lg==
X-Received: by 2002:a9d:51cb:0:b0:6bf:5010:9d35 with SMTP id d11-20020a9d51cb000000b006bf50109d35mr25251752oth.3.1697148468435;
        Thu, 12 Oct 2023 15:07:48 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id o10-20020a056a001bca00b0068c670afe30sm7442663pfw.124.2023.10.12.15.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Oct 2023 15:07:47 -0700 (PDT)
Message-ID: <eb150179-c328-4058-80e3-f517d45310c4@kernel.dk>
Date: Thu, 12 Oct 2023 16:07:46 -0600
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
To: Dan Clash <daclash@linux.microsoft.com>, audit@vger.kernel.org,
 io-uring@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, paul@paul-moore.com,
 linux-fsdevel@vger.kernel.org, brauner@kernel.org, dan.clash@microsoft.com
References: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231012215518.GA4048@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/12/23 3:55 PM, Dan Clash wrote:
> An io_uring openat operation can update an audit reference count
> from multiple threads resulting in the call trace below.
> 
> A call to io_uring_submit() with a single openat op with a flag of
> IOSQE_ASYNC results in the following reference count updates.
> 
> These first part of the system call performs two increments that do not race.
> 
> do_syscall_64()
>   __do_sys_io_uring_enter()
>     io_submit_sqes()
>       io_openat_prep()
>         __io_openat_prep()
>           getname()
>             getname_flags()       /* update 1 (increment) */
>               __audit_getname()   /* update 2 (increment) */
> 
> The openat op is queued to an io_uring worker thread which starts the
> opportunity for a race.  The system call exit performs one decrement.
> 
> do_syscall_64()
>   syscall_exit_to_user_mode()
>     syscall_exit_to_user_mode_prepare()
>       __audit_syscall_exit()
>         audit_reset_context()
>            putname()              /* update 3 (decrement) */
> 
> The io_uring worker thread performs one increment and two decrements.
> These updates can race with the system call decrement.
> 
> io_wqe_worker()
>   io_worker_handle_work()
>     io_wq_submit_work()
>       io_issue_sqe()
>         io_openat()
>           io_openat2()
>             do_filp_open()
>               path_openat()
>                 __audit_inode()   /* update 4 (increment) */
>             putname()             /* update 5 (decrement) */
>         __audit_uring_exit()
>           audit_reset_context()
>             putname()             /* update 6 (decrement) */
> 
> The fix is to change the refcnt member of struct audit_names
> from int to atomic_t.
> 
> kernel BUG at fs/namei.c:262!
> Call Trace:
> ...
>  ? putname+0x68/0x70
>  audit_reset_context.part.0.constprop.0+0xe1/0x300
>  __audit_uring_exit+0xda/0x1c0
>  io_issue_sqe+0x1f3/0x450
>  ? lock_timer_base+0x3b/0xd0
>  io_wq_submit_work+0x8d/0x2b0
>  ? __try_to_del_timer_sync+0x67/0xa0
>  io_worker_handle_work+0x17c/0x2b0
>  io_wqe_worker+0x10a/0x350
> 
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/lkml/MW2PR2101MB1033FFF044A258F84AEAA584F1C9A@MW2PR2101MB1033.namprd21.prod.outlook.com/
> Fixes: 5bd2182d58e9 ("audit,io_uring,io-wq: add some basic audit support to io_uring")
> Signed-off-by: Dan Clash <daclash@linux.microsoft.com>

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



