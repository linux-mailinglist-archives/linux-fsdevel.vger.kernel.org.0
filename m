Return-Path: <linux-fsdevel+bounces-9129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C640483E5C2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D392889FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F95C4F8A6;
	Fri, 26 Jan 2024 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Ysu05diR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C91DA2E;
	Fri, 26 Jan 2024 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308868; cv=none; b=IjywPTllqpFGi+fH0I4lrPOSF/eR0rJMPcjaiImCzo2HBMbxxwFbEjXLanBkYuMt/8Ega68IpiYDdZBv2ZxsoN0iYYQzJaEREPPkkzpFKD01/7RZfacE9w02AuPqcakFI9o44MKCQEcezJb3IT6oWuNQQ9Am7/KZBOjIxXf6tsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308868; c=relaxed/simple;
	bh=QD1uun/DHxhpFTTJ8gigtXcRCDDv24VnfNEFqI2ZKHw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TkHaqJSQVYrjqgcqxbyBzSRqH1O2Zp11JJd85pxxB6gDT/AAd3PbSXcK4dwMMbTWKK8/D2mtMR68AwVs0FZIeJ/Qq+a5h79IxddV5cV1vpsqhRKrzPs3DtDnX3bE6piCBzd3yCTq37A2cYMxRnv4MhUE8LIddqC+u14CFGyPSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Ysu05diR; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706308865;
	bh=QD1uun/DHxhpFTTJ8gigtXcRCDDv24VnfNEFqI2ZKHw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ysu05diRuwrrgUeNFwZvMuIPU/ttjsd2HGydFAYM4fF3L/dKakJ5G1Lx1cSqY0+bX
	 PLuhGj+esMRK19Z8JvjXOG0PABcLVcbTj6jDDh7g73PTtT/5woQn2oGRwPCYNAqsZF
	 vuSMR+Toru5lAtM4bsT4/vDr0zhg81Ypiyeu2oUvw5fi/t8A77s93fGEAvWJUnaM/4
	 EJ9yzUfFjO+JR0iwXL7uBP8FbvdiqpUB2QAijZlLcI0NmJ5I4mfMfHurCSmS2p1vKl
	 EQHhInXZPUKVByupjLc/r75hp6vn4PsLcmcYKbK+bXoJTeZI/yu+bO0EUUpTlN78JQ
	 cHVQdWQUA648w==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TMCN12vytzVQ6;
	Fri, 26 Jan 2024 17:41:05 -0500 (EST)
Message-ID: <29be300d-00c4-4759-b614-2523864c074b@efficios.com>
Date: Fri, 26 Jan 2024 17:41:05 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Christian Brauner <brauner@kernel.org>, Ajay Kaher
 <ajay.kaher@broadcom.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>
References: <20240126150209.367ff402@gandalf.local.home>
 <CAHk-=wgZEHwFRgp2Q8_-OtpCtobbuFPBmPTZ68qN3MitU-ub=Q@mail.gmail.com>
 <20240126162626.31d90da9@gandalf.local.home>
 <CAHk-=wj8WygQNgoHerp-aKyCwFxHeyKMguQszVKyJfi-=Yfadw@mail.gmail.com>
 <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
 <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
 <CAHk-=whAG6TM6PgH0YnsRe6U=RzL+JMvCi=_f0Bhw+q_7SSZuw@mail.gmail.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=whAG6TM6PgH0YnsRe6U=RzL+JMvCi=_f0Bhw+q_7SSZuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-01-26 17:29, Linus Torvalds wrote:
> On Fri, 26 Jan 2024 at 14:14, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> I do however have a concern with the approach of using the same
>> inode number for various files on the same filesystem: AFAIU it
>> breaks userspace ABI expectations.
> 
> Virtual filesystems have always done that in various ways.
> 
> Look at the whole discussion about the size of the file. Then look at /proc.

Yes, there is even a note about stat.st_size in inode(7) explaining
this:

NOTES
        For pseudofiles that are autogenerated by the  kernel,  the  file  size
        (stat.st_size;  statx.stx_size) reported by the kernel is not accurate.
        For example, the value 0 is returned for many files under the /proc di‐
        rectory,  while  various  files under /sys report a size of 4096 bytes,
        even though the file content is smaller.  For such  files,  one  should
        simply  try  to  read as many bytes as possible (and append '\0' to the
        returned buffer if it is to be interpreted as a string).

But having a pseudo-filesystem entirely consisting of duplicated inodes
which are not hard links to the same file is something new/unexpected.

> And honestly, eventfs needs to be simplified. It's a mess. It's less
> of a mess than it used to be, but people should *NOT* think that it's
> a real filesystem.

I agree with simplifying it, but would rather not introduce userspace ABI
regressions in the process, which will cause yet another kind of mess.

> Don't use some POSIX standard as an expectation for things like /proc,
> /sys or tracefs.

If those filesystems choose to do things differently from POSIX, then it
should be documented with the relevant ABIs, because userspace should be
able to know (rather than guess) what it can expect.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


