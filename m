Return-Path: <linux-fsdevel+bounces-56735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45ED0B1B275
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 13:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745DC170BD3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Aug 2025 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E192441A6;
	Tue,  5 Aug 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KAG0nDb2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6723CB;
	Tue,  5 Aug 2025 11:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754392462; cv=none; b=n+0Z/I8rQ/WyJp69pSzobpKfVv+vUE4/9a68xsGN24FTuO/o9XGMD0q5bjSMlGsH+XlJ2fuKkizrN2vOQt/K6oismRbZuzqNAy6chGsI3Ijxt6oZNYVmdubqSjvkBs4vkNod02o80eJ3CD8E6BNhjmICI8B8+Bsl6AdqlMCPRhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754392462; c=relaxed/simple;
	bh=rm/Zpfn+FKLaib+yqyr0neGJy/bgYTsz03ta2Ugg3WI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5hmHc9CzaMtcnu2nMfz8nnlbPJBa5axa3qMj4uM8jloJrZ0V2lzEUH9pKwYfkw9zwobA5x2+1W2dfhNIJjEs5XkpvlqFrDyyi+3CXT+OYE/k1Wx8z5SPnnPb5WCkuhBYLs5qQGW43cz6D9obpjJNmyysdxBA5WsEGCeWojVsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KAG0nDb2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bgVI/REEX1RcSxnDg5Q8C5uv8j4eEiN9+bNJh7WkDrE=; b=KAG0nDb2y1oP1WiWoj0oaxb99a
	OQadSf83hX7TeXKy+bACaAQJjKdOpPXnB0oICAPokwy7Nrm0AIuA2cjpyI0SWTHd81y0FNe7z16e9
	LU2R+YSHOyVvYwFWmh147QSFpaCHcyxW0KlDYmmeYp3fRIll47oo5vowhHj4KVWioO4qYm/FyifQT
	cQtrV0dEUJcf/63kTcEzJzrHXj/ql6JFBmiUFDVemTTvSmyHTyDFFljKXzERQlGP4rvZIY+nkFi7u
	1KvCLSvSn991ikuYFq0KavSzT9Akddcniwec8tFG992e0qsdnGC4Io3X6ctd97FRFLdbCZfp9FzCr
	IwjGnzlQ==;
Received: from [223.233.65.189] (helo=[192.168.1.12])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1ujFcO-009f93-3s; Tue, 05 Aug 2025 13:14:08 +0200
Message-ID: <dfdc2c2c-1486-a84d-9ca2-3b48b68773ce@igalia.com>
Date: Tue, 5 Aug 2025 16:43:58 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 2/3] treewide: Switch memcpy() users of 'task->comm' to
 a more safer implementation
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <kees@kernel.org>
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
 linux-trace-kernel@vger.kernel.org
References: <20250724123612.206110-1-bhupesh@igalia.com>
 <20250724123612.206110-3-bhupesh@igalia.com>
 <202507241640.572BF86C70@keescook>
 <CAHk-=wi5c=_-FBGo_88CowJd_F-Gi6Ud9d=TALm65ReN7YjrMw@mail.gmail.com>
 <B9C50D0B-DCD9-41A2-895D-4899728AF605@kernel.org>
 <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
Content-Language: en-US
From: Bhupesh Sharma <bhsharma@igalia.com>
In-Reply-To: <CAHk-=wixR7ZR+aebFsWX4qWZ84tMTmyNWLUPmTy3YvaNJGqd-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/27/25 5:07 AM, Linus Torvalds wrote:
> On Sat, 26 Jul 2025 at 16:19, Kees Cook <kees@kernel.org> wrote:
>> That works for me! I just get twitchy around seeing memcpy used for strings. :) if we're gonna NUL after the memcpy, just use strscpy_pad().
> I do worry a tiny bit about performance.
>
> Because 'memcpy+set last byte to NUL' really is just a couple of
> instructions when we're talking small constant-sized arrays.
>
> strscpy_pad() isn't horrible, but it's still at another level. And
> most of the cost is that "return the length" which people often don't
> care about.
>
> Dang, I wish we had some compiler trick to say "if the value isn't
> used, do X, if it _is_ used do Y".
>
> It's such a trivial thing in the compiler itself, and the information
> is there, but I don't think it is exposed in any useful way.
>
> In fact, it *is* exposed in one way I can think of:
>
>     __attribute__((__warn_unused_result__))
>
> but not in a useful form for actually generating different code.
>
> Some kind of "__builtin_if_used(x,y)" where it picks 'x' if the value
> is used, and 'y' if it isn't would be lovely for this.
>
> Then you could do things like
>
>      #define my_helper(x) \
>          __builtin_if_used( \
>                  full_semantics(x), \
>                  simpler_version(x))
>
> when having a return value means extra work and most people don't care.
>
> Maybe it exists in some form that I haven't thought of?
>
> Any compiler people around?
>

Sorry for the delay in reply, but I was checking with some *compiler* 
folks and unfortunately couldn't find an equivalent of the above 
*helper* support.
I am not a compiler expert though and relied mostly on my digging of the 
'gcc' code and advise from folks working in compiler world.

In case there are no new suggestions, I think we can go ahead with 
"strscpy_pad()" or "get_task_array()" in place of "get_task_comm()" 
which is implement in the following manner:

    static __always_inline void
        __cstr_array_copy(char *dst,
             const char *src, __kernel_size_t size)
    {
         memcpy(dst, src, size);
         dst[size] = 0;
    }

    #define get_task_array(a,b) \
       __cstr_array_copy(dst, src, __must_be_array(dst))

Please let me know.

Thanks,
Bhupesh


