Return-Path: <linux-fsdevel+bounces-10661-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3936F84D24A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 20:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18E81F24A55
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A16D82D97;
	Wed,  7 Feb 2024 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="dmVV8f1U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FE684FBD;
	Wed,  7 Feb 2024 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707334730; cv=none; b=A932BlsTe1TM6VA/ICB2W4nqzWvlb43vpkyX1OtgpjFiJ6L0L9F6Kk+3MaSyLr0fS9eY7X2dR22nEgffcWKvEBiMyZBMLFmvgStJowKkOhqIYfS0+lb6OTkwlGdpoEknQbfPq3+RkYZ/Fa1y8k2VLPUSrAIcWsqbV5i5X7S6a8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707334730; c=relaxed/simple;
	bh=++MTL3pXaFGkwTrZ2UX9O8w73zELvOw8YOi00AODvIQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYjveUd1dUhbhrLMvrsuXMhxqtlxGWG6/FeSkIjO/qzu0q+JC8ad4EsF+x3mkq0Yad1dQ3lCop8+Pq3gqfMZmSDFySpvh9fYJ7JZcAlu/JeO3fdzJJdYhNui4JEdmFA0uBM6lEbaLNwTHOdG+WfQ+RT3hbinoToiZfJ8Bx+ysAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=dmVV8f1U; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 4187B5CCFF8;
	Wed,  7 Feb 2024 13:30:00 -0600 (CST)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 4187B5CCFF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1707334200;
	bh=ZW6Ze3ip8h0vhzwPBz1EamxDDep6suZbxAI9Ob6xCl4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dmVV8f1UphyEfiMVNtX+QL9fxRfNlyF/1ggx7ulJqu1eP4JD/dWHJIOqmdE3gqAam
	 TyHQnNy/GKv0xbtH1ilvzag6xfkVFsp+WWlhYGx0qxL33ljRKBVbF29T92sTdLUJNi
	 1c0E+MXl31o3TwXElyERC/sGZNPIUlwKHjziJssxHixoWUNyZIWMkSwLgdzpkSGahZ
	 1kD2IkeZejecGEc6UIz8Nh+81hqHdJj68BlwF73XEmv3jScAcZDTIf4IBOuAvZfeZd
	 Gjl1Ho5GsKN0lM2KFRdd3zXMP40C2q6LkV0ty7txHgmlbcZhaQTDKnXqvzH+jGP2Lu
	 4c5ySs6tiKokw==
Message-ID: <9f9a740f-3db5-4078-8135-0ec224b26a90@sandeen.net>
Date: Wed, 7 Feb 2024 13:29:59 -0600
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] tracing the source of errors
Content-Language: en-US
To: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Cc: lsf-pc <lsf-pc@lists.linux-foundation.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAJfpegtw0-88qLjy0QDLyYFZEM7PJCG3R-mBMa9s8TNSVZmJTA@mail.gmail.com>
 <20240207110041.fwypjtzsgrcdhalv@quack3>
 <CAJfpegvkP5dic7CXB=ZtwTF4ZhRth1xyUY36svoM9c1pcx=f+A@mail.gmail.com>
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <CAJfpegvkP5dic7CXB=ZtwTF4ZhRth1xyUY36svoM9c1pcx=f+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/7/24 5:23 AM, Miklos Szeredi wrote:
> On Wed, 7 Feb 2024 at 12:00, Jan Kara <jack@suse.cz> wrote:
> 
>> The problem always has been how to implement this functionality in a
>> transparent way so the code does not become a mess. So if you have some
>> idea, I'd say go for it :)
> 
> My first idea would be to wrap all instances of E* (e.g. ERR(E*)).
> But this could be made completely transparent by renaming current
> definition of E* to _E* and defining E* to be the wrapped ones.
> There's probably a catch (or several catches) somewhere, though.
> 
> Thanks,
> Miklos
> 

Just FWIW, XFS has kind of been there and back again on wrapping error returns
with macros.

Long ago, we had an XFS_ERROR() macro, i.e.

 	if (error)
		return -XFS_ERROR(error);

sprinkled (randomly) throughout the code.

(it didn't make it out through strace, and was pretty clunky but could printk or
BUG based on which error you were looking for, IIRC.)

In 2014(!) I removed it, pointing out that systemtap could essentially do the
same thing, and do it more flexibly (see: [PATCH 2/2] xfs: Nuke XFS_ERROR macro):

# probe module("xfs").function("xfs_*").return { if (@defined($return) &&
$return == VALUE) { ... } }

hch pointed out that systemtap was not a viable option for many, and further
discussion turned up a slightly kludgey way to use kprobes:

-- from dchinner --
#!/bin/bash

TRACEDIR=/sys/kernel/debug/tracing

grep -i 't xfs_' /proc/kallsyms | awk '{print $3}' ; while read F; do
	echo "r:ret_$F $F \$retval" >> $TRACEDIR/kprobe_events
done

for E in $TRACEDIR/events/kprobes/ret_xfs_*/enable; do
	echo 1 > $E
done;

echo 'arg1 > 0xffffffffffffff00' > $TRACEDIR/events/kprobes/filter

for T in $TRACEDIR/events/kprobes/ret_xfs_*/trigger; do
	echo 'traceoff if arg1 > 0xffffffffffffff00' > $T
done
--------

which yields i.e.:

# dd if=/dev/zero of=/mnt/scratch/newfile bs=513 oflag=direct
dd: error writing ¿/mnt/scratch/newfile¿: Invalid argument
1+0 records in
0+0 records out
0 bytes (0 B) copied, 0.000259882 s, 0.0 kB/s
root@test4:~# cat /sys/kernel/debug/tracing/trace
# tracer: nop
#
# entries-in-buffer/entries-written: 1/1   #P:16
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
           <...>-8073  [006] d... 145740.460546: ret_xfs_file_dio_aio_write:
(xfs_file_aio_write+0x170/0x180 <- xfs_file_dio_aio_write) arg1=0xffffffffffffffea

where that last negative number is the errno.

Not the prettiest thing but something that works today and could maybe be improved?

-Eric

