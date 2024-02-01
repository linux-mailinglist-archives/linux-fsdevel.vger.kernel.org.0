Return-Path: <linux-fsdevel+bounces-9859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 418598455BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 11:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75C31F22CDC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 10:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D084F15B975;
	Thu,  1 Feb 2024 10:47:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6714415B969;
	Thu,  1 Feb 2024 10:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784428; cv=none; b=eAX5WoGfgxjEb9+RDA4nnLcvnZEzdGLszn8r0r2wy34KHe/GXUocjDugWr3kb6y+09FgDCLCrxBiUvRoAM0Foo/nFHZ25E1ROfuyY6EYeNrET/7BCWPBJTnlfY7/cNHkIaWHj1w23UgQPow3t5yfbjl7HDoD9myb3wjkxKLumWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784428; c=relaxed/simple;
	bh=kw+Mml9tKYD5/MBGDcOdd7+s+r8727WzA8VTInU+Dgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bxpXfGBt9yfukMtQfy8HglUsaMVAEvuanCMFDWjPpDIX+s46fKalSUkOgMiF8nIwLokfd88NhgF0GVf0XN9e+iGNW5wbhsYmRXEz+nnV9SyAGGuwl38avy+X7lwrVIT+M5s6QmkHwUAp5P4+2y2CZ8NOoOdceYuc3dZzYwROMfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rVUb1-0007vf-0a; Thu, 01 Feb 2024 11:47:03 +0100
Message-ID: <95eae92a-ecad-4e0e-b381-5835f370a9e7@leemhuis.info>
Date: Thu, 1 Feb 2024 11:47:02 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: Recent-ish changes in binfmt_elf made my program segfault
Content-Language: en-US, de-DE
To: Kees Cook <keescook@chromium.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Jan Bujak <j@exia.io>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk, brauner@kernel.org, linux-fsdevel@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <c7209e19-89c4-446a-b364-83100e30cc00@exia.io>
 <874jf5co8g.fsf@email.froward.int.ebiederm.org>
 <202401221226.DAFA58B78@keescook>
 <87v87laxrh.fsf@email.froward.int.ebiederm.org>
 <202401221339.85DBD3931@keescook>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <202401221339.85DBD3931@keescook>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706784426;339156dc;
X-HE-SMSGID: 1rVUb1-0007vf-0a

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Eric, what's the status wrt. to this regression? Things from here look
stalled, but I might be missing something.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

On 22.01.24 23:12, Kees Cook wrote:
> On Mon, Jan 22, 2024 at 03:01:06PM -0600, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>>
>>> On Mon, Jan 22, 2024 at 10:43:59AM -0600, Eric W. Biederman wrote:
>>>> Jan Bujak <j@exia.io> writes:
>>>>
>>>>> Hi.
>>>>>
>>>>> I recently updated my kernel and one of my programs started segfaulting.
>>>>>
>>>>> The issue seems to be related to how the kernel interprets PT_LOAD headers;
>>>>> consider the following program headers (from 'readelf' of my reproduction):
>>>>>
>>>>> Program Headers:
>>>>>   Type  Offset   VirtAddr  PhysAddr  FileSiz  MemSiz   Flg Align
>>>>>   LOAD  0x001000 0x10000   0x10000   0x000010 0x000010 R   0x1000
>>>>>   LOAD  0x002000 0x11000   0x11000   0x000010 0x000010 RW  0x1000
>>>>>   LOAD  0x002010 0x11010   0x11010   0x000000 0x000004 RW  0x1000
>>>>>   LOAD  0x003000 0x12000   0x12000   0x0000d2 0x0000d2 R E 0x1000
>>>>>   LOAD  0x004000 0x20000   0x20000   0x000004 0x000004 RW  0x1000
>>>>>
>>>>> Old kernels load this ELF file in the following way ('/proc/self/maps'):
>>>>>
>>>>> 00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
>>>>> 00011000-00012000 rw-p 00002000 00:02 131  ./bug-reproduction
>>>>> 00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
>>>>> 00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction
>>>>>
>>>>> And new kernels do it like this:
>>>>>
>>>>> 00010000-00011000 r--p 00001000 00:02 131  ./bug-reproduction
>>>>> 00011000-00012000 rw-p 00000000 00:00 0
>>>>> 00012000-00013000 r-xp 00003000 00:02 131  ./bug-reproduction
>>>>> 00020000-00021000 rw-p 00004000 00:02 131  ./bug-reproduction
>>>>>
>>>>> That map between 0x11000 and 0x12000 is the program's '.data' and '.bss'
>>>>> sections to which it tries to write to, and since the kernel doesn't map
>>>>> them anymore it crashes.
>>>>>
>>>>> I bisected the issue to the following commit:
>>>>>
>>>>> commit 585a018627b4d7ed37387211f667916840b5c5ea
>>>>> Author: Eric W. Biederman <ebiederm@xmission.com>
>>>>> Date:   Thu Sep 28 20:24:29 2023 -0700
>>>>>
>>>>>     binfmt_elf: Support segments with 0 filesz and misaligned starts
>>>>>
>>>>> I can confirm that with this commit the issue reproduces, and with it
>>>>> reverted it doesn't.
>>>>>
>>>>> I have prepared a minimal reproduction of the problem available here,
>>>>> along with all of the scripts I used for bisecting:
>>>>>
>>>>> https://github.com/koute/linux-elf-loading-bug
>>>>>
>>>>> You can either compile it from source (requires Rust and LLD), or there's
>>>>> a prebuilt binary in 'bin/bug-reproduction` which you can run. (It's tiny,
>>>>> so you can easily check with 'objdump -d' that it isn't malicious).
>>>>>
>>>>> On old kernels this will run fine, and on new kernels it will
>>>>> segfault.
>>>>
>>>> Frankly your ELF binary is buggy, and probably the best fix would be to
>>>> fix the linker script that is used to generate your binary.
>>>>
>>>> The problem is the SYSV ABI defines everything in terms of pages and so
>>>> placing two ELF segments on the same page results in undefined behavior.
>>>>
>>>> The code was fixed to honor your .bss segment and now your .data segment
>>>> is being stomped, because you defined them to overlap.
>>>>
>>>> Ideally your linker script would place both your .data and .bss in
>>>> the same segment.  That would both fix the issue and give you a more
>>>> compact elf binary, while not changing the generated code at all.
>>>>
>>>>
>>>> That said regressions suck and it would be good if we could update the
>>>> code to do something reasonable in this case.
>>>>
>>>> We can perhaps we can update the .bss segment to just memset an existing
>>>> page if one has already been mapped.  Which would cleanly handle a case
>>>> like yours.  I need to think about that for a moment to see what the
>>>> code would look like to do that.
>>>
>>> It's the "if one has already been mapped" part which might
>>> become expensive...
>>
>> I am wondering if perhaps we can add MAP_FIXED_NOREPLACE and take
>> some appropriate action if there is already a mapping there.
> 
> Yeah, in the general case we had to back out MAP_FIXED_NOREPLACE usage
> for individual LOADs because there were so many cases of overlapping
> LOADs. :( Currently it's only used during the initial mapping (when
> "total_size" is set), to avoid colliding with the stack.
> 
> But, as you suggest, if we only use it for filesz==0, it could work.
> 
>> Such as printing a warning and skipping the action entirely for
>> a pure bss segment.  That would essentially replicate the previous
>> behavior.
> 
> Instead of failing, perhaps we just fallback to not using
> MAP_FIXED_NOREPLACE and do the memset? (And maybe pr_warn_once?)
> 
>> At a minimum adding MAP_FIXED_NOREPLACE should allow us to
>> deterministically detect and warn about problems, making it easier
>> for people to understand why their binary won't run.
> 
> Yeah, it seems like it's the vm_brk_flags() that is clobber the mapping,
> so we have to skip that for the MAP_FIXED_NOREPLACE fails on a filesz==0
> case?
> 

