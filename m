Return-Path: <linux-fsdevel+bounces-72487-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53128CF85B7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 13:41:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49059302759B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228182F999A;
	Tue,  6 Jan 2026 12:41:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E861A2C04
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jan 2026 12:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767703294; cv=none; b=J8SStVsA1uuZERsSYhVX1/3ovmavEusmIsAemvwPItU9pxTfFoEKrCk2RkOpk2BSHSTYRTU20kPiIrbfmumupYxRu8joyJpLXCgL240YrSCVt+mroz07lSTqbKN70IQ5iHOdlBcv3usg0u3FLYVf8Ta8dB9QDwonOZ1E2xYrSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767703294; c=relaxed/simple;
	bh=bzm+ypZqqwMr5bJKqZb5IiQEa4RGlt/SMXESUZ2hdwg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GS1Ka1iul1JkF7RX7oQHfF6k83auvwP1HZrd1Huh+JduOhjPSkkcCBEtVpbHxufonoGzvFxU3zNaqduw3Z3VCMAiWb9JBjj1xX4uJov0VvAJYkDaz79DKIrR3LiBmCGQtTIIesS0MKdBKjSkbLgqeX49aAZJInTyV/PsAmPDQ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 606CfUaK095527;
	Tue, 6 Jan 2026 21:41:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 606CfU0V095523
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 6 Jan 2026 21:41:30 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <9ae0ff26-2cb5-4b6e-9868-f31229dacbc8@I-love.SAKURA.ne.jp>
Date: Tue, 6 Jan 2026 21:41:29 +0900
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
 <6b89bfd8-feb1-47a1-85cb-d3e16f51d9e3@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <6b89bfd8-feb1-47a1-85cb-d3e16f51d9e3@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean

Mikulas, can we go with the kernel config approach?

On 2025/11/24 19:50, Tetsuo Handa wrote:
> Can we move this forward?
> 
> Since syzkaller is not the only fuzzer, and syz_execute_func() could still find
> check=none option, I prefer disabling dangerous behavior at the kernel config level.
> It would be nice if HPFS for check=none case is implemented using FUSE.
> 
> On 2025/11/06 7:05, Tetsuo Handa wrote:
>> On 2025/11/06 6:16, Aleksandr Nogikh wrote:
>>> Hi Tetsuo,
>>>
>>> Could you please share a link to the original discussion with Mikulas Patocka?
>>> It would be great to know a bit more context.
>>
>> https://lkml.kernel.org/r/889ee229-8f2f-2bd4-c870-fbd11a3c4098@twibright.com
>> https://lkml.kernel.org/r/9ca81125-1c7b-ddaf-09ea-638bc5712632@redhat.com
>>
>>>
>>> On Thu, Oct 16, 2025 at 2:29 PM Tetsuo Handa
>>> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>>>
>>>> Mikulas Patocka (the HPFS maintainer) thinks that check=none option
>>>> should not be used in fuzz testing.
>>>>
>>>> Closes https://syzkaller.appspot.com/bug?extid=fa88eb476e42878f2844
>>>> ---
>>>>  sys/linux/filesystem.txt | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>
>>> FWIW
>>>
>>> Considering how fuzzers work, it's challenging to prevent them from
>>> doing something specific. Removing the descriptions is the necessary
>>> first step, but
>>> 1) Mounts with check=none are already in the fuzzer corpuses, most
>>> likely with multiple mutations on top.
>>> 2) Even without descriptions, syzkaller might discover this mount
>>> option again in the future.
>>
>> Yes, syz_execute_func() (and other fuzzers) would find again.
>> That's why I proposed disabling in the kernel config.
>>
>>>
>>> For cases like this, we unfortunately just keep on stacking the "when
>>> mounting filesystem X, remove the substring Y if it's in the mount
>>> options" rules in the C implementation of the syz_mount_image
>>> pseudo-syscall:
>>> https://github.com/google/syzkaller/blob/master/executor/common_linux.h#L3136
>>>
>>
> 


