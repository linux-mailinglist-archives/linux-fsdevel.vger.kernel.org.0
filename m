Return-Path: <linux-fsdevel+bounces-47477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 973BBA9E65D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10471673C3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC36118DF6D;
	Mon, 28 Apr 2025 02:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=froggi.es header.i=misyl@froggi.es header.b="HPuwsRKj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2667E1DA4E;
	Mon, 28 Apr 2025 02:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745808998; cv=pass; b=Ggc/3ZwRdZ2JA96vMfFjvTQ6enPCzG0gNcsqNUBOfCsJYrOWa9aLuTfEOp+0zwCLM9hV5fQjDKmFzAi/mHbxMwXwytMfxMvU8qVJ11SIanwjiLOPvR4BqVtS+jt4RxutU6bPnrlk/jVguV3OvKo5+9ZYtLEK6Cba1UasVn7Eivc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745808998; c=relaxed/simple;
	bh=fH3qI3XFE2DEsNQ5IAkdOccOgKRev6Ql/EWFMsF7NjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ng5BcsPslCfH+f2VFwG+loIkssnqMZ6mPXWuS3uWUKf6AViHLY0Kx0DXMx7FxzNBU6X/e6umXhCGIFVpjlnc6FeZXf8cYLavx7bAcifQblQp8NaIU1P1KWj7Lkqe8026qmb2Nqec1IVDlei8M7F9sFlvHhnW0DAiObTgLan3UWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es; spf=pass smtp.mailfrom=froggi.es; dkim=pass (1024-bit key) header.d=froggi.es header.i=misyl@froggi.es header.b=HPuwsRKj; arc=pass smtp.client-ip=136.143.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
ARC-Seal: i=1; a=rsa-sha256; t=1745808987; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ipgjB/CmEGy3ejS9TD5+ujCDw8UG/amzLsfTPJfVHF0qS8UqF3+gQhqLNgHYA7Z+jvd43b9i7IdUxALlMl6QSlaD1iUO6Q8PWRxXrQiZWksJd9WYVeCQhNlcOXMCXMroZw8jf6flkycIm8FiRdxHX+q4palXMtmXFYoZbDFo+bE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745808987; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1yb+OYIn/b4qG+ZJPpww3rWATbp1NUFUz3CJKNrPeGs=; 
	b=ZMeGJbCxGzWaEmzPtR64j2L32sRT1xRtbuKrI1LoDOIoGllEh+2z8EVFhenyK4KSctxvAgTvlwD0o8U6uf/t8d5V1tq1yCE0tVCOW0vZ3NUDWFINJFGGaHxtrkOi+wbOwr7Fv0xLmjmzKUbmWWt0FCQ4ofzFJrUv7b6/lcpLAhM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=froggi.es;
	spf=pass  smtp.mailfrom=misyl@froggi.es;
	dmarc=pass header.from=<misyl@froggi.es>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745808987;
	s=mail; d=froggi.es; i=misyl@froggi.es;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1yb+OYIn/b4qG+ZJPpww3rWATbp1NUFUz3CJKNrPeGs=;
	b=HPuwsRKjhqGSOsczMmiZ64OVOlvb/eSNV075Q+stCX5y330RLuOevoyF64GBKWy6
	qD6g0RVnSd4cWoaC+j5DkttZlqOTDZtXe8OdY69xV8ga9RwtogD+U72RXbQkxgDsoiw
	0Up2VAEloZUpgCXcqzjYyFsjcLwfhJsQrx7loVeQ=
Received: by mx.zohomail.com with SMTPS id 1745808984779377.53546209008414;
	Sun, 27 Apr 2025 19:56:24 -0700 (PDT)
Message-ID: <42a3bda8-bbec-4991-a96e-303636d7bbd1@froggi.es>
Date: Mon, 28 Apr 2025 03:56:21 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Eric Biggers <ebiggers@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Theodore Ts'o <tytso@mit.edu>, Linus Torvalds
 <torvalds@linux-foundation.org>, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
 <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
 <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es>
 <wjj4ld5jpnj57wwe6ygtldm3jazlnlbendzwpe65xce5xfv5tg@im53llnthtxd>
Content-Language: en-US
From: Autumn Ashton <misyl@froggi.es>
In-Reply-To: <wjj4ld5jpnj57wwe6ygtldm3jazlnlbendzwpe65xce5xfv5tg@im53llnthtxd>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External



On 4/28/25 3:16 AM, Kent Overstreet wrote:
> On Mon, Apr 28, 2025 at 03:05:19AM +0100, Autumn Ashton wrote:
>>
>>
>> On 4/28/25 2:43 AM, Kent Overstreet wrote:
>>> On Sun, Apr 27, 2025 at 06:30:59PM -0700, Eric Biggers wrote:
>>>> On Sun, Apr 27, 2025 at 08:55:30PM -0400, Kent Overstreet wrote:
>>>>> The thing is, that's exactly what we're doing. ext4 and bcachefs both
>>>>> refer to a specific revision of the folding rules: for ext4 it's
>>>>> specified in the superblock, for bcachefs it's hardcoded for the moment.
>>>>>
>>>>> I don't think this is the ideal approach, though.
>>>>>
>>>>> That means the folding rules are "whatever you got when you mkfs'd".
>>>>> Think about what that means if you've got a fleet of machines, of
>>>>> different ages, but all updated in sync: that's a really annoying way
>>>>> for gremlins of the "why does this machine act differently" variety to
>>>>> creep in.
>>>>>
>>>>> What I'd prefer is for the unicode folding rules to be transparently and
>>>>> automatically updated when the kernel is updated, so that behaviour
>>>>> stays in sync. That would behave more the way users would expect.
>>>>>
>>>>> But I only gave this real thought just over the past few days, and doing
>>>>> this safely and correctly would require some fairly significant changes
>>>>> to the way casefolding works.
>>>>>
>>>>> We'd have to ensure that lookups via the case sensitive name always
>>>>> works, even if the casefolding table the dirent was created with give
>>>>> different results that the currently active casefolding table.
>>>>>
>>>>> That would require storing two different "dirents" for each real dirent,
>>>>> one normalized and one un-normalized, because we'd have to do an
>>>>> un-normalized lookup if the normalized lookup fails (and vice versa).
>>>>> Which should be completely fine from a performance POV, assuming we have
>>>>> working negative dentries.
>>>>>
>>>>> But, if the unicode folding rules are stable enough (and one would hope
>>>>> they are), hopefully all this is a non-issue.
>>>>>
>>>>> I'd have to gather more input from users of casefolding on other
>>>>> filesystems before saying what our long term plans (if any) will be.
>>>>
>>>> Wouldn't lookups via the case-sensitive name keep working even if the
>>>> case-insensitivity rules change?  It's lookups via a case-insensitive name that
>>>> could start producing different results.  Applications can depend on
>>>> case-insensitive lookups being done in a certain way, so changing the
>>>> case-insensitivity rules can be risky.
>>>
>>> No, because right now on a case-insensitive filesystem we _only_ do the
>>> lookup with the normalized name.
>>>
>>>> Regardless, the long-term plan for the case-insensitivity rules should be to
>>>> deprecate the current set of rules, which does Unicode normalization which is
>>>> way overkill.  It should be replaced with a simple version of case-insensitivity
>>>> that matches what FAT does.  And *possibly* also a version that matches what
>>>> NTFS does (a u16 upcase_table[65536] indexed by UTF-16 coding units), if someone
>>>> really needs that.
>>>>
>>>> As far as I know, that was all that was really needed in the first place.
>>>>
>>>> People misunderstood the problem as being about language support, rather than
>>>> about compatibility with legacy filesystems.  And as a result they incorrectly
>>>> decided they should do Unicode normalization, which is way too complex and has
>>>> all sorts of weird properties.
>>>
>>> Believe me, I do see the appeal of that.
>>>
>>> One of the things I should really float with e.g. Valve is the
>>> possibility of providing tooling/auditing to make it easy to fix
>>> userspace code that's doing lookups that only work with casefolding.
>>
>> This is not really about fixing userspace code that expects casefolding, or
>> providing some form of stopgap there.
>>
>> The main need there is Proton/Wine, which is a compat layer for Windows
>> apps, which needs to pretend it's on NTFS and everything there expects
>> casefolding to work.
>>
>> No auditing/tooling required, we know the problem. It is unavoidable.
> 
> Does this boil all the way up to e.g. savegames?

Everything, assets, save games.

You can't just patch the games... Doing that for every game on Steam 
with every way they load games would be impossible, especially with 
modern day obfuscated binaries, and anti-cheat and anti-tamper solutions.

- Autumn ✨

> 
> I was imagining predetermined assets, where the name of the file would
> be present in a compiled binary, and it's little more than a search and
> replace. But would only work if it's present as a string literal.
> 
>> I agree with the calling about Unicode normalization being odd though, when
>> I was implementing casefolding for bcachefs, I immediately thought it was a
>> huge hammer to do full normalization for the intended purpose, and not just
>> a big table...
> 
> Samba's historically wanted casefolding, and Windows casefolding is
> Unicode (and it's full, not simple - mostly), so I'd expect that was the
> other main driver.
> 
> I'm sure there's other odd corners besides just Samba where Windows
> compatibility comes up, people cook up all kinds of strange things.




