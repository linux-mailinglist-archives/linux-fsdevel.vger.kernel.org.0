Return-Path: <linux-fsdevel+bounces-59153-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27868B3518C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 04:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D9E244CEF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 02:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8391F131A;
	Tue, 26 Aug 2025 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b="lpSyLA/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q+DhBAvv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AAD61FCE;
	Tue, 26 Aug 2025 02:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756174931; cv=none; b=Pztv4JcjVfjQ6LP9EUUWW2rqztyFnCQprtqyKaS09XttILnyHJ8CXVcBNjzyelIYxjaemOTHblGLwVbb/pi9QXz7VlE84oi4crL3yz1777ecXpTglxMcbfc72FSuppfptOX7XQDBPqfvglzfFcwfrq09VcQjs6eWImFQqzp3rnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756174931; c=relaxed/simple;
	bh=4DisX/0+xAhmuwOzqh9mzJ7havIlGj9BYenoKo1eLuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTDM/VZVojI/8PnyYJnOBr2/IKr4wLXdDmxl2NPpQaKiy6+mzjs8FC4rJQ+1YA+ZwoRhTdFKrfV2n8wCgLE6aMjBbecR6loBePwhM7ZHCmJwPxjKkz56imuvTvOc8TPkdWEspgBCzJ9+dogrzr+iIo5/YaQRdy7EDsprKAEnkLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net; spf=pass smtp.mailfrom=themaw.net; dkim=pass (2048-bit key) header.d=themaw.net header.i=@themaw.net header.b=lpSyLA/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q+DhBAvv; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=themaw.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=themaw.net
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4ECD614001B5;
	Mon, 25 Aug 2025 22:22:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 25 Aug 2025 22:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1756174927;
	 x=1756261327; bh=6+KKvThnHGiZN9NiGPmzI6no1FAXTq2guIHPygvxlbY=; b=
	lpSyLA/n5kiHcGfvyxW33Ovucy5s6fOMz7EPdrEdXFwwrHPUwe4zuYkNz/WrS63j
	SQMENmsT7SqOfl5bNHMk+OTmtCcWf/moJQHjKLhwaT9btCuQ1eA6nrlGxnj8pSNz
	hIVGcTkiYxXPQq4CiA00wRwlV1HqfvEbZvJ6po+9VDXFOIayeY80v8FtYUSGWJ5x
	MUoK1bndOS3Oqpm5gIknjCzx8LMnUoqe+tFVFnRSXnUkcaHi7eYA8ovJWzgTRUDX
	oAHb22I2R7ti7GgxsaLbFs/65C4/X/6RQuuruvdhEN9z8pLprVT+e4bmBypmB9Fd
	StMTJD/hkBwd9vxcM/ygIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756174927; x=
	1756261327; bh=6+KKvThnHGiZN9NiGPmzI6no1FAXTq2guIHPygvxlbY=; b=Q
	+DhBAvv9cVw4jlkxAwq8QFpk2heceFoLh+fqvp/tsFc0QnqCiDnq9JgqeNDHI3AV
	3oNgq+tRV49Lcg/Nq8Jd8qmmmySZiOvCqyS5ivUjVsogOn/aaUPLc8BcCi/jFs+i
	QTtdqutPvrY/q26KD7qeU4GbqkAhG3x1JBADQNPwXgtZm9v9b5u4L8+0EUIexhou
	LX/TJi/paHx9IWfZDiQyDf6BdoJ9x+VHTUy1+HnRuvskNCVGNButFjF2hfoD3B7L
	y8gGbX0hsTcBjtaHJu0ZqPbF7d3eJXyuIa7TxSdhP//5gdv9PPl2meh2U9DKXjAm
	c7WEruqIkwTQXtIHh6xAQ==
X-ME-Sender: <xms:ThqtaJRJuH-SKobZIFpDQ1j8Qcj4E_67dipv8TLCX9zihN8rlwiNwQ>
    <xme:ThqtaAUoRgtymKcSMNV1cd3xM9b-BQOyEgTbVBIyZjkjBCpBqd4II0V2cnlqu5aUC
    9Rq7PfBkPb_>
X-ME-Received: <xmr:ThqtaFT2Hp6-3Rt_Fgc5doUCgo7nSLcIOei3jf8l3xxVmpGXNmnR3kGPCe-W7dEhICwipNN4nRKwXyh_eT_Bz6apm6L0_xANBylQ4h5v-bL6kncom2nTbeY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeegtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepud
    fhffevfedugfevgedvveekheffkeegteduudduffefffevtdetffdtveekffffnecuffho
    mhgrihhnpegsohhothhlihhnrdgtohhmpdhthihpvghsrdhplhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidr
    nhgvthdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshgrfhhinhgrshhkrghrseiiohhhohhmrghilhdrtghomhdprhgtphhtthhopegruhht
    ohhfshesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptgihphhhrghr
    segthihphhgrrhdrtghomhdprhgtphhtthhopehvihhrohesiigvnhhivhdrlhhinhhugi
    drohhrghdruhhkpdhrtghpthhtohepnhgvihhlsegsrhhofihnrdhnrghmvg
X-ME-Proxy: <xmx:ThqtaCkuo1ld6NZl6VLyM3v3XI1jS_qe3P-M-3gGiG7IbCesFI-eMA>
    <xmx:ThqtaD7dDDRvc53WoWWxW7KYAZ9od6SGPTug1Rjg-Z2B-O-orXjOwg>
    <xmx:ThqtaAhDQuVcGkSHRfuhg420pN8jwv43F1l8eG3qP_CdwArwWGWMww>
    <xmx:ThqtaIG1OG_JsspuVXIiKi86xWOvHzJJ2EJ3_QbipAzRQf6K6Mblag>
    <xmx:TxqtaPVyHhsDfYIujEnyQ8KQBX7mBJff_zhVeQRHYWBZrznCWN7cKipx>
Feedback-ID: i31e841b0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 22:22:04 -0400 (EDT)
Message-ID: <56423903-7978-404e-af32-a683c9efac72@themaw.net>
Date: Tue, 26 Aug 2025 10:22:01 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Serious error in autofs docs, which has design implications
To: Askar Safin <safinaskar@zohomail.com>
Cc: autofs mailing list <autofs@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, cyphar <cyphar@cyphar.com>,
 viro <viro@zeniv.linux.org.uk>, NeilBrown <neil@brown.name>
References: <198cb9ecb3f.11d0829dd84663.7100887892816504587@zohomail.com>
 <f83491c4-e535-4ee2-a2a8-935ccebec292@themaw.net>
 <198e1aa84a6.fad5ff4026331.4114043174169557399@zohomail.com>
Content-Language: en-AU
From: Ian Kent <raven@themaw.net>
Autocrypt: addr=raven@themaw.net;
 keydata= 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
In-Reply-To: <198e1aa84a6.fad5ff4026331.4114043174169557399@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/8/25 22:38, Askar Safin wrote:
>   ---- On Fri, 22 Aug 2025 16:31:46 +0400  Ian Kent <raven@themaw.net> wrote ---
>   > On 21/8/25 15:53, Askar Safin wrote:
>   > > autofs.rst says:
>   > >> mounting onto a directory is considered to be "beyond a `stat`"
>   > > in https://elixir.bootlin.com/linux/v6.17-rc2/source/Documentation/filesystems/autofs.rst#L109
>   > >
>   > > This is not true. Mounting does not trigger automounts.
>   >
>   > I don't understand that statement either, it's been many years
>
> Let me explain.

I do understand what your saying but without more information about

the meaning and intent of the text your concerned about I don't think

anything can be done about this right now.


I guess that I should also apologise to you as I'm pretty sure I

reviewed this at the time it was posted and didn't question this

at the time. But I most likely didn't see this as a problem because,

to my thinking, what follows explains what it's needed for rather

than the earlier statement justifying it.


To be clear, in my previous reply I said two things, first I also

find the statement you are concerned about unclear, perhaps even

misleading (but I would need to understand the statement original

intent to interpret that, which I don't) and second, the ->d_namage()

callback is most definitely needed for the function of the user space

daemon, automount(8) (via the autofs file system).


Ian

>
> Some syscalls follow (and trigger) automounts in last
> component of path, and some - not.
>
> stat(2) is one of syscalls, which don't follow
> automounts in last component of supplied path.
>
> Many other syscalls do follow automounts.
>
> autofs.rst calls syscalls, which follow automounts,
> as "beyond a stat".
>
> Notably mount(2) doesn't follow automounts in second argument
> (i. e. mountpoint). I know this, because I closely did read the code.
> Also I did experiment (see source in the end of this letter).
> Experiment was on 6.17-rc1.
>
> But "autofs.rst" says:
>> mounting onto a directory is considered to be "beyond a `stat`"
> I. e. "autofs.rst" says that mount(2) does follow automounts.
>
> This is wrong, as I explained above. (Again: I did experiment,
> so I'm totally sure that this "autofs.rst" sentence is wrong.)
>
> Moreover, then "autofs.rst" proceeds to explain why
> DCACHE_MANAGE_TRANSIT was introduced, based on this wrong fact.
>
> So it is possible that DCACHE_MANAGE_TRANSIT is in fact, not needed.
>
> I'm not asking for removal of DCACHE_MANAGE_TRANSIT.
>
> I merely point error in autofs.rst file and ask for fix.
>
> And if in process of fixing autofs.rst you will notice that
> DCACHE_MANAGE_TRANSIT is indeed not needed, then,
> of course, it should be removed.
>
> --
> Askar Safin
> https://types.pl/@safinaskar
>
> ====
>
> // This code is public domain
> // You should be root in initial user namespace
>
> #define _GNU_SOURCE
>
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdbool.h>
> #include <string.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sched.h>
> #include <errno.h>
> #include <sys/stat.h>
> #include <sys/mount.h>
> #include <sys/syscall.h>
> #include <sys/vfs.h>
> #include <sys/sysmacros.h>
> #include <sys/statvfs.h>
> #include <sys/wait.h>
> #include <linux/openat2.h>
> #include <linux/nsfs.h>
>
> #define MY_ASSERT(cond) do { \
>      if (!(cond)) { \
>          fprintf (stderr, "%d: %s: assertion failed\n", __LINE__, #cond); \
>          exit (1); \
>      } \
> } while (0)
>
> #define MY_ASSERT_ERRNO(cond) do { \
>      if (!(cond)) { \
>          fprintf (stderr, "%d: %s: %m\n", __LINE__, #cond); \
>          exit (1); \
>      } \
> } while (0)
>
> static void
> mount_debugfs (void)
> {
>      if (mount (NULL, "/tmp/debugfs", "debugfs", 0, NULL) != 0)
>          {
>              perror ("mount debugfs");
>              exit (1);
>          }
> }
>
> int
> main (void)
> {
>      MY_ASSERT_ERRNO (chdir ("/") == 0);
>      MY_ASSERT_ERRNO (unshare (CLONE_NEWNS) == 0);
>      MY_ASSERT_ERRNO (mount (NULL, "/", NULL, MS_PRIVATE | MS_REC, NULL) == 0);
>      MY_ASSERT_ERRNO (mount (NULL, "/tmp", "tmpfs", 0, NULL) == 0);
>      MY_ASSERT_ERRNO (mkdir ("/tmp/debugfs", 0777) == 0);
>      mount_debugfs ();
>      MY_ASSERT_ERRNO (mount (NULL, "/tmp/debugfs/tracing", "tmpfs", 0, NULL) == 0);
>      execlp ("/bin/busybox", "sh", NULL);
>      MY_ASSERT (false);
> }
>

