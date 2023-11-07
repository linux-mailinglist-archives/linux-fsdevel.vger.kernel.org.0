Return-Path: <linux-fsdevel+bounces-2333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A911F7E4C75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Nov 2023 00:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B4928140B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 23:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDFF2A1CF;
	Tue,  7 Nov 2023 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSYt28QZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39F130661
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Nov 2023 23:08:48 +0000 (UTC)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4534D10C8;
	Tue,  7 Nov 2023 15:08:48 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-5842c251d7cso3328643eaf.1;
        Tue, 07 Nov 2023 15:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699398527; x=1700003327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xdszqg8GuNrbv2D5/m8sAm5VRvjmMoJFaLE7yW2b4M0=;
        b=nSYt28QZoCWOc/07oMh7Ifv2yJx7eOlv4tZvh/KXJyFxJwTzNG+mT5sIPppEyfdFGe
         WcZTf0Xcu+OfgHLeTnLsbg6GaYxlQJwgTt5XkOe4fIqNZzLnPtq8bzIOntnpJtg9/cPK
         68CHnd8G4LS4MBXxrXTlK4i8D84Z2gxSo6xwQVMFbg6Cymh+jvNqBIz+yq86ED3QFnPU
         ajE4+8s8NrZxHacknkbRHQiMmJ4lpS05uhfFmnMm5iVTbFDSum5/SAdJsJekQ/Kupr0L
         p6K063vzAEEuwgBunOqtxjrq24p0jI4HdPaLan2WLgB57ZTGh5pAWgy0Kn9OtA+VNsnw
         j9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699398527; x=1700003327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xdszqg8GuNrbv2D5/m8sAm5VRvjmMoJFaLE7yW2b4M0=;
        b=LsDi8/PxoMhhBMkH5Jt0K8MZYYiK9nwHMKul2pr3FkkWI7OHzAFrsvD834frI+A8Ip
         a42y96LLtU0a4MOHCRo6LNLYmgPsVtl+UOfYrDuRlehh575uK0UQ15DdMtWvmx+kmLQX
         qLhMhKjcGmL18TyAnJcvqUFliPf+BFDkOnp65+Zj+DamXYCMRDfRM8m0VNdXkg8VUWA3
         pJU9jnoHh0Hx1VNGC7cKa11/rkbxBb3XkSyTPm/wSNYuRwi5exDUBisP0qS1dtlnp7wx
         3WTl4npOAch+PT2mkhtEquwvnCjKlFENxT8pB9fvusfw2IdrL1Z9PKzyMHw2DC77ufjM
         w8kA==
X-Gm-Message-State: AOJu0Yz5URsZr0mJVvs1OGo+MlFHYZS1q/iLAjAudvwXI2LhK36sDzg6
	xLHS0ROGh8vOQ2C2QuJHM3KGeQCp8L7cYKAGEVb3Lrxz
X-Google-Smtp-Source: AGHT+IHsp0JJKejPgiujjZaFuuv8e9Qy38owaFGrdM72IJx+emIxMLP+QGs0DogjaSs1V4wz96473ZBZbE9tYUFVT8M=
X-Received: by 2002:a4a:3152:0:b0:587:9928:a0f1 with SMTP id
 v18-20020a4a3152000000b005879928a0f1mr264895oog.0.1699398527593; Tue, 07 Nov
 2023 15:08:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:a8a:158f:0:b0:4f0:1250:dd51 with HTTP; Tue, 7 Nov 2023
 15:08:47 -0800 (PST)
In-Reply-To: <202311071445.53E5D72C@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook> <20231107205151.qkwlw7aarjvkyrqs@f>
 <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com> <202311071445.53E5D72C@keescook>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 8 Nov 2023 00:08:47 +0100
Message-ID: <CAGudoHF5mYFWtzrv539W8Uc1aO_u6+UJOoDqWY0pePc+cofziw@mail.gmail.com>
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search before
 allocating mm
To: Kees Cook <keescook@chromium.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 11/7/23, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Nov 07, 2023 at 10:23:16PM +0100, Mateusz Guzik wrote:
>> If the patch which dodges second lookup still somehow appears slower a
>> flamegraph or other profile would be nice. I can volunteer to take a
>> look at what's going on provided above measurements will be done and
>> show funkyness.
>
> When I looked at this last, it seemed like all the work done in
> do_filp_open() (my patch, which moved the lookup earlier) was heavier
> than the duplicate filename_lookup().
>
> What I didn't test was moving the sched_exec() before the mm creation,
> which Peter confirmed shouldn't be a problem, but I think that might be
> only a tiny benefit, if at all.
>
> If you can do some comparisons, that would be great; it always takes me
> a fair bit of time to get set up for flame graph generation, etc. :)
>

So I spawned *one* process executing one statocally linked binary in a
loop, test case from http://apollo.backplane.com/DFlyMisc/doexec.c .

The profile is definitely not what I expected:
   5.85%  [kernel]           [k] asm_exc_page_fault
   5.84%  [kernel]           [k] __pv_queued_spin_lock_slowpath
[snip]

I'm going to have to recompile with lock profiling, meanwhile
according to bpftrace
(bpftrace -e 'kprobe:__pv_queued_spin_lock_slowpath { @[kstack()] = count(); }')
top hits would be:

@[
    __pv_queued_spin_lock_slowpath+1
    _raw_spin_lock+37
    __schedule+192
    schedule_idle+38
    do_idle+366
    cpu_startup_entry+38
    start_secondary+282
    secondary_startup_64_no_verify+381
]: 181
@[
    __pv_queued_spin_lock_slowpath+1
    _raw_spin_lock_irq+43
    wait_for_completion+141
    stop_one_cpu+127
    sched_exec+165
    bprm_execve+328
    do_execveat_common.isra.0+429
    __x64_sys_execve+50
    do_syscall_64+46
    entry_SYSCALL_64_after_hwframe+110
]: 206

I did not see this coming for sure. I'll poke around maybe this weekend.

-- 
Mateusz Guzik <mjguzik gmail.com>

