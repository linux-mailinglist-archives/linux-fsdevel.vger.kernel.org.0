Return-Path: <linux-fsdevel+bounces-50508-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C131FACCC81
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 19:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7ECCF18919B3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CBD1E8356;
	Tue,  3 Jun 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X0ud+K1O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05421B414A;
	Tue,  3 Jun 2025 17:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748973081; cv=none; b=nXbPxwq6f/aoVY5NE8h7IAcHiBA+bJeiU3Tc9tghxw301HlpPCjphlLHewVmiztTWQx0bXpaBKb8CLqYvfjbUT7bRrCssFmJg+M52vUrBjVT/o6qxAkXtr9M/6tKWZwMrTb9jQ1Javsgmefrl6fRF9B1HFfumr8nWhGLh2w/Ow0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748973081; c=relaxed/simple;
	bh=T1yBpxkEeKTkbxh3nl7K4IOHkcNT1Kd9NXHCRN7clqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qO7EloFxSsQBW4Hcn6zIswid6i3PyXmlxIMgy6dUB8YBKuPVmG6elcex9Lj9J3nZS+DEYnr5nHyoOMF4vTWPfEvyMD4PyPORrBXov8dgDo6yhB3am2+JaU8kzh3noVCLb9CFj7SQ9YsaEugKpGFG9kB8XoslhYnRIZdaJeoLsLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=X0ud+K1O; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPV6:2601:646:8081:9482:7211:64cb:5036:d2b9] ([IPv6:2601:646:8081:9482:7211:64cb:5036:d2b9])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 553Hne8u3926666
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 3 Jun 2025 10:49:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 553Hne8u3926666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2025052101; t=1748972985;
	bh=WjcKG8tapzY+DwZpr1CTpwzaMFTYG50aHolFcfHdfs4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X0ud+K1ObXeIOmkFYd4oZPi19mpm7QhPbViuLKFsUdAnzO94VI+3AnlPSbZSzijQ8
	 WPu1ufL6nvVHW04XF/MECy3aNKi3jUpR7gB3qLvkIAsXFjT3uJB9nj8bCMwgirEiTv
	 +siS7X5E4aWy3AvIjRgGHvnJdLXTnNTzRUku1MJMx7dwPGQNfOv0GQDGD6NMP23knP
	 PBfWAvUzbpsj+VnpW3bwW4CwOter3tKgFuoXD9kQ8q1FiHLU9CXsjMSwLRGdYFCyLB
	 IBs3jDqdc3fSs4hgdxuQ93k0Sl/119q0UB7t4c36TPeDCm6b4p5tM9+XKqRyIqD23t
	 riIZ13jyEUqHw==
Message-ID: <380a64b9-e796-4345-a9a0-cf70d0f6c26f@zytor.com>
Date: Tue, 3 Jun 2025 10:49:35 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 00/35] optimize cost of inter-process communication
To: Bo Li <libo.gcs85@bytedance.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        luto@kernel.org, kees@kernel.org, akpm@linux-foundation.org,
        david@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org
Cc: dietmar.eggemann@arm.com, acme@kernel.org, namhyung@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, jannh@google.com, pfalcato@suse.de,
        riel@surriel.com, harry.yoo@oracle.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        yinhongbo@bytedance.com, dengliang.1214@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        songmuchun@bytedance.com, yuanzhu@bytedance.com,
        chengguozhu@bytedance.com, sunjiadong.lff@bytedance.com
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
Content-Language: en-US
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <cover.1748594840.git.libo.gcs85@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/25 02:27, Bo Li wrote:
> Changelog:
> 
> v2:
> - Port the RPAL functions to the latest v6.15 kernel.
> - Add a supplementary introduction to the application scenarios and
>   security considerations of RPAL.
> 
> link to v1:
> https://lore.kernel.org/lkml/CAP2HCOmAkRVTci0ObtyW=3v6GFOrt9zCn2NwLUbZ+Di49xkBiw@mail.gmail.com/
> 

Okay,

First of all, I agree with most of the other reviewers that this is
insane. Second of all, calling this "optimize cost of inter-process
communication" is *extremely* misleading, to the point that one could
worry about it being malicious.

What you are doing is attempting to provide isolation between threads
running in the same memory space. *By definition* those are not processes.

Secondly, doing function calls from one thread to another in the same
memory space isn't really IPC at all, as the scheduler is not involved.

Third, this is something that should be possible to do entirely in user
space (mostly in a modified libc). Most of the facilities that you seem
to implement already have equivalents (/dev/shm, ET_DYN, ld.so, ...)

This isn't a new idea; this is where the microkernel people eventually
ended up when they tried to get performant. It didn't work well for the
same reason -- without involving the kernel (or dedicated hardware
facilities; x86 segments and MPK are *not* designed for this), the
isolation *can't* be enforced. You can, of course, have a kernel
interface to switch the address space around -- and you have just
(re)invented processes.

From what I can see, a saner version of this would probably be something
like a sched_yield_to(X) system call, basically a request to the
scheduler "if possible, give the rest of my time slice to process/thread
<X>, as if I had been continuing to run." The rest of the communication
can be done with shared memory.

The other option is that if you actually are OK with your workloads
living in the same privilege domain to simply use threads.

If this somehow isn't what you're doing, and I (and others) have somehow
misread the intentions entirely, we will need a whole lot of additional
explanations.

	-hpa


	-hpa


