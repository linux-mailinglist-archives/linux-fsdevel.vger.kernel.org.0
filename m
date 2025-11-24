Return-Path: <linux-fsdevel+bounces-69649-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88332C7FFDF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 11:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D13B3A6F30
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14C2279918;
	Mon, 24 Nov 2025 10:51:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C582D2741C0
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763981488; cv=none; b=rVOf88Yxn4BMNjvmg+bONzmawebzhMFa0fUWZgW5Yh7w5PD4KSQ8PLHBXtMZbF50qFmwe4ep31CUA2/MIQCbdsXddgf5YpAGDV1OmzZVVR7mgb20GKOEFpyIZoZ0JBAzS2i7jvByGFryuxgGMlsahxvip7P+W3n3pGP2PjjZtPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763981488; c=relaxed/simple;
	bh=oOyKObgVYJ7zXXogeHlJaoCQkExYAWt7psrjkXOau3Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qS7aNH5fZ8R+o5CdsUITPOQPfy09OwBBQcRUPZrI5+lSSxMBsXy42W2ij7tYcgPh17jOLisbY4xZJrCNNhAhidQNKwIN7i2d8NEmFuSBs2QjbL61xfxCsdfDL1TJ9sCOJgjLVZZ2Re+KdF7Pijvq6iPB1rUe37kc8UkLzr/6GLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5AOApH1g032072;
	Mon, 24 Nov 2025 19:51:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5AOAorVL031980
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 24 Nov 2025 19:51:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <6b89bfd8-feb1-47a1-85cb-d3e16f51d9e3@I-love.SAKURA.ne.jp>
Date: Mon, 24 Nov 2025 19:50:52 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sys/linux/filesystem: remove hpfs check=none mount option
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: Mikulas Patocka <mikulas@twibright.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Cc: syzkaller <syzkaller@googlegroups.com>,
        Viacheslav Sablin <sjava1902@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Sasha Levin <sashal@kernel.org>
References: <cb9e2aac-d215-42f5-a7b4-e3e463a7e57a@I-love.SAKURA.ne.jp>
 <CANp29Y70nHpDtn1FAHPx7KccMLUWD272Jztw4SF0yMG4Fs-RbQ@mail.gmail.com>
 <2cc02c92-9f5a-4193-bdc2-df958e7b35e9@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <2cc02c92-9f5a-4193-bdc2-df958e7b35e9@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav204.rs.sakura.ne.jp

Can we move this forward?

Since syzkaller is not the only fuzzer, and syz_execute_func() could still find
check=none option, I prefer disabling dangerous behavior at the kernel config level.
It would be nice if HPFS for check=none case is implemented using FUSE.

On 2025/11/06 7:05, Tetsuo Handa wrote:
> On 2025/11/06 6:16, Aleksandr Nogikh wrote:
>> Hi Tetsuo,
>>
>> Could you please share a link to the original discussion with Mikulas Patocka?
>> It would be great to know a bit more context.
> 
> https://lkml.kernel.org/r/889ee229-8f2f-2bd4-c870-fbd11a3c4098@twibright.com
> https://lkml.kernel.org/r/9ca81125-1c7b-ddaf-09ea-638bc5712632@redhat.com
> 
>>
>> On Thu, Oct 16, 2025 at 2:29 PM Tetsuo Handa
>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>
>>> Mikulas Patocka (the HPFS maintainer) thinks that check=none option
>>> should not be used in fuzz testing.
>>>
>>> Closes https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
>>> ---
>>>  sys/linux/filesystem.txt | 1 -
>>>  1 file changed, 1 deletion(-)
>>
>> FWIW
>>
>> Considering how fuzzers work, it's challenging to prevent them from
>> doing something specific. Removing the descriptions is the necessary
>> first step, but
>> 1) Mounts with check=none are already in the fuzzer corpuses, most
>> likely with multiple mutations on top.
>> 2) Even without descriptions, syzkaller might discover this mount
>> option again in the future.
> 
> Yes, syz_execute_func() (and other fuzzers) would find again.
> That's why I proposed disabling in the kernel config.
> 
>>
>> For cases like this, we unfortunately just keep on stacking the "when
>> mounting filesystem X, remove the substring Y if it's in the mount
>> options" rules in the C implementation of the syz_mount_image
>> pseudo-syscall:
>> https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L3136
>>
> 


