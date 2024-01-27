Return-Path: <linux-fsdevel+bounces-9188-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA4883EB1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 05:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E415C1C225B8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 04:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B4C13FE0;
	Sat, 27 Jan 2024 04:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YWoJPUSi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954AF14A8C;
	Sat, 27 Jan 2024 04:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706331257; cv=none; b=qjO9KATw77S4ndsld22quAWKyukXSWGpO0FZ4l50acZoaeKrZyNQwZiqWhJox8HXWqb/B8p0iNUCoIPXiT7V8f43EhjhcSGHuRxVPvVsE/rIPRHVZwz8UPdjacF4+j5v8YdI7QQIgTDo8hHc+QjgQlVaAeKjXvxFMjuaz96xZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706331257; c=relaxed/simple;
	bh=88V1hzhbCbfftos6zJaZB0wK6TKkDyBHXpC0wjXxfws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pzp5zOpdW7Um+xrh/bs/jhxdUDYbqzILlv1KaudeNzXoGussP0DDJ5uODPXS4GBe2u0NtnhpOSmGDYlnPOE6zF6ur17fmbrfpDKU3IgYfl8UeVHhJWMvoPqQiVrPRYh8o7bZQIFiL9c2yuQJGmTR6UJurxYLS8gAe5ZcX7ZZCpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YWoJPUSi; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.192.85] (unknown [50.39.103.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id D151B3FE86;
	Sat, 27 Jan 2024 04:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706331245;
	bh=5WPgKmWsxsze4yg1WX8Fw9bzUlXpaO5ltG37GOwu2Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=YWoJPUSiaYGiIC25TTkda9fHpLf0/hC7qRCRUwrLKpauF+d5RavH9uMlpmqVY6+fC
	 msVNW745+H9p13uwfGnAuiVpSlUg9MPO8sWMbOdpSaXwkPT3Qze7vX3pPhECJRH3RL
	 pU1qHhDAuvfrEZtNQvhnoO5+OPebxAUrivRyV2G0rLgXqRfZX/xUyLs90AJoV45m87
	 Tm+SsU80twLuGJOk0B59b/16eHHvqHdhzd6ef7FKMOpZZqHbLS9cnVQeWZ2+MWQU2z
	 YKPQDgJfnc1WFakMzYfSoQrzTYuz7wwva++KKpQycG8KtThacsTHe7+nd/QhABnpRa
	 C48v1ZWXR0Rrw==
Message-ID: <4bb5dd09-9e09-477b-9ea8-d7b9d2fb4760@canonical.com>
Date: Fri, 26 Jan 2024 20:53:58 -0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
Content-Language: en-US
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 Kees Cook <keescook@chromium.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Jann Horn <jannh@google.com>, Josh Triplett <josh@joshtriplett.org>,
 Kevin Locke <kevin@kevinlocke.name>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Eric Biederman <ebiederm@xmission.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240124192228.work.788-kees@kernel.org>
 <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook>
 <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
 <202401241310.0A158998@keescook> <20240125.bais0ieKahz7@digikod.net>
From: John Johansen <john.johansen@canonical.com>
Autocrypt: addr=john.johansen@canonical.com; keydata=
 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 lT9Q
Organization: Canonical
In-Reply-To: <20240125.bais0ieKahz7@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/25/24 08:38, Mickaël Salaün wrote:
> On Wed, Jan 24, 2024 at 01:32:02PM -0800, Kees Cook wrote:
>> On Wed, Jan 24, 2024 at 12:47:34PM -0800, Linus Torvalds wrote:
>>> On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>> Hmpf, and frustratingly Ubuntu (and Debian) still builds with
>>>> CONFIG_USELIB, even though it was reported[2] to them almost 4 years ago.
>>
>> For completeness, Fedora hasn't had CONFIG_USELIB for a while now.
>>
>>> Well, we could just remove the __FMODE_EXEC from uselib.
>>>
>>> It's kind of wrong anyway.
>>
>> Yeah.
>>
>>> So I think just removing __FMODE_EXEC would just do the
>>> RightThing(tm), and changes nothing for any sane situation.
>>
>> Agreed about these:
>>
>> - fs/fcntl.c is just doing a bitfield sanity check.
>>
>> - nfs_open_permission_mask(), as you say, is only checking for
>>    unreadable case.
>>
>> - fsnotify would also see uselib() as a read, but afaict,
>>    that's what it would see for an mmap(), so this should
>>    be functionally safe.
>>
>> This one, though, I need some more time to examine:
>>
>> - AppArmor, TOMOYO, and LandLock will see uselib() as an
>>    open-for-read, so that might still be a problem? As you
>>    say, it's more of a mmap() call, but that would mean
>>    adding something a call like security_mmap_file() into
>>    uselib()...
> 
> If user space can emulate uselib() without opening a file with
> __FMODE_EXEC, then there is no security reason to keep __FMODE_EXEC for
> uselib().
> 
agreed

> Removing __FMODE_EXEC from uselib() looks OK for Landlock.  We use
> __FMODE_EXEC to infer if a file is being open for execution i.e., by
> execve(2).
> 

apparmor the hint should be to avoid doing permission work again that we
are doing in exec. That it regressed anything more than performance here
is a bug, that will get fixed.


> If __FMODE_EXEC is removed from uselib(), I think it should also be
> backported to all stable kernels for consistency though.
> 
hrmmm, I am not opposed to it being backported but I don't know that
it should be backported. Consistency is good but its not a serious
bug fix either

> 
>>
>> The issue isn't an insane "support uselib() under AppArmor" case, but
>> rather "Can uselib() be used to bypass exec/mmap checks?"
>>
>> This totally untested patch might give appropriate coverage:
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index d179abb78a1c..0c9265312c8d 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -143,6 +143,10 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
>>   	if (IS_ERR(file))
>>   		goto out;
>>   
>> +	error = security_mmap_file(file, PROT_READ | PROT_EXEC, MAP_FIXED | MAP_SHARED);
>> +	if (error)
>> +		goto exit;
>> +
>>   	/*
>>   	 * may_open() has already checked for this, so it should be
>>   	 * impossible to trip now. But we need to be extra cautious
>>
>>> Of course, as you say, not having CONFIG_USELIB enabled at all is the
>>> _truly_ sane thing, but the only thing that used the FMODE_EXEC bit
>>> were landlock and some special-case nfs stuff.
>>
>> Do we want to attempt deprecation again? This was suggested last time:
>> https://lore.kernel.org/lkml/20200518130251.zih2s32q2rxhxg6f@wittgenstein/
>>
>> -Kees
>>
>> -- 
>> Kees Cook
>>


