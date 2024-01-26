Return-Path: <linux-fsdevel+bounces-9122-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5145783E4F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 23:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50821F23148
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 22:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102241C9F;
	Fri, 26 Jan 2024 22:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="cfkipyRs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE9F41C8A;
	Fri, 26 Jan 2024 22:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307263; cv=none; b=NSORupO/Gdr+jpP2lyENO5mpVFV9DZo++gyouCyz3ajHwpUP4yzZ8F/O9xv9BYodJmFGYn65MVEQZ8Xm79qU7yrSdCFYdYPbYOMF9hEN2sjSMFqQBUZzBQXJnHFqlGt5c1HiQhvbZqu89kt/WDCRxDU4s3nX5WOMbO5J7GwhTQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307263; c=relaxed/simple;
	bh=Jdm33v2+FbE+eDx5lDB90ydl/s2iNfckbja6xWCLNck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QGhXEt/u2qGL0o9TNlwT0PY5is6+3V9Zy4xBbIBqnkEY43Gv8KDIe9qEdeQTW7tOsX8PPQInA5pGK5zAkiintIZLP5faRkpQl0pD1c9sTGRBMRFciguHvB3uG/wC7BlNekAeOOOHYUABs5IwMvHX3ZEBOHt5IQgSPNgG6u/ca0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=cfkipyRs; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1706307254;
	bh=Jdm33v2+FbE+eDx5lDB90ydl/s2iNfckbja6xWCLNck=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cfkipyRsu2VHMJxlmbm3pCANQ19TSTz6YQmuyCbVeZ1qFT0OiAuXMZMHv/kCXDYV5
	 Sqt5ASfUbdf9yStQP2jZ6RFX4HNh8fxfb3HAtOr5jq8vRQ8Ca1I6RvCUGN66g4Af3h
	 QjCMbYjnwdMK2ZXud8gbIW9J0KEgQDOY8RRPVoaHnpvbHgtbcO1ZVHZn62GCgWS2+0
	 pQNtpi1wU40f69L+cF/vpnPcRkB/SFSIX/wT6OrP2sIPHDVE/nWEgJ7OCsFERACT32
	 Tlt9hTxL9LDX/6neQw8PeWympIe3TUM7STM9rFv+t0es/J9Ii2HxUmCzU5DJVg4hSq
	 5Phhi3/pPJEog==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4TMBn22rgWzVQ4;
	Fri, 26 Jan 2024 17:14:14 -0500 (EST)
Message-ID: <8547159a-0b28-4d75-af02-47fc450785fa@efficios.com>
Date: Fri, 26 Jan 2024 17:14:12 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] eventfs: Have inodes have unique inode numbers
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
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
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CAHk-=whNfNti-mn6vhL-v-WZnn0i7ZAbwSf_wNULJeyanhPOgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-01-26 16:49, Linus Torvalds wrote:
> On Fri, 26 Jan 2024 at 13:36, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
[...]
> So please try to look at things to *fix* and simplify, not at things
> to mess around with and make more complicated.

Hi Linus,

I'm all aboard with making things as simple as possible and
making sure no complexity is added for the sake of micro-optimization
of slow-paths.

I do however have a concern with the approach of using the same
inode number for various files on the same filesystem: AFAIU it
breaks userspace ABI expectations. See inode(7) for instance:

        Inode number
               stat.st_ino; statx.stx_ino

               Each  file in a filesystem has a unique inode number.  Inode numbers
               are guaranteed to be unique only within a filesystem (i.e., the same
               inode  numbers  may  be  used by different filesystems, which is the
               reason that hard links may not cross filesystem  boundaries).   This
               field contains the file's inode number.

So user-space expecting inode numbers to be unique within a filesystem
is not "legacy" in any way. Userspace is allowed to expect this from the
ABI.

I think that a safe approach to prevent ABI regressions, and just to prevent
adding more ABI-corner cases that userspace will have to work-around, would
be to issue unique numbers to files within eventfs, but in the
simplest/obviously correct implementation possible. It is, after all, a slow
path.

The issue with the atomic_add_return without any kinds of checks is the
scenarios of a userspace loop that would create/delete directories endlessly,
thus causing inode re-use. This approach is simple, but it's unfortunately
not obviously correct. Because eventfs allows userspace to do mkdir/rmdir,
this is unfortunately possible. It would be OK if only the kernel had control
over directory creation/removal, but it's not the case here.

I would suggest this straightforward solution to this:

a) define a EVENTFS_MAX_INODES (e.g. 4096 * 8),

b) keep track of inode allocation in a bitmap (within a single page),

c) disallow allocating more than "EVENTFS_MAX_INODES" in eventfs.

This way even the mkdir/rmdir loop will work fine, but it will prevent
keeping too many inodes alive at any given time. The cost is a single
page (4K) per eventfs instance.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


