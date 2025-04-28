Return-Path: <linux-fsdevel+bounces-47467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E45F0A9E60C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 04:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5AA63A752E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 02:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8215E15747D;
	Mon, 28 Apr 2025 02:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=froggi.es header.i=misyl@froggi.es header.b="E8d7hIhN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63572BD04;
	Mon, 28 Apr 2025 02:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745805954; cv=pass; b=lQRdoTzPz7yiVOX4oeO+kDRCLyd+2/IfxHsBRLzqbJ5Z5bhF9MnRxSv3FIi/JVgzkVTYmFLNAgig+FGh4uo8NtoxDdSHuZwFTRlUq3244jUnd0SjXCkgafMaHckXHF7L/7yy6FXWltfJnsG65/w6dXzaJTUu282kwsoPXg2RtDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745805954; c=relaxed/simple;
	bh=a9Zwzcu75CazHvaU13+zG9dQb/WnwUr/P/o0o9RVXtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GG+5yIbcDAaIj8XSpoqmyDOKuPyo15rXq8ur+3+E0SFRKSKbxEknH692GtQ6JUa00iOkntzJOJ1SBtaZuv7Ur8tybNyK5EDUGh+oieWL5rqSS7BzdoOk9BW4pGMhjVxMjWTfo2zM/nbUZybTC4TGspv+aUmMHl8Z4FTGKlnZmL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es; spf=pass smtp.mailfrom=froggi.es; dkim=pass (1024-bit key) header.d=froggi.es header.i=misyl@froggi.es header.b=E8d7hIhN; arc=pass smtp.client-ip=136.143.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=froggi.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=froggi.es
ARC-Seal: i=1; a=rsa-sha256; t=1745805925; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oAGoo2SgKoQZDf9J9Ly5gF/4BKFHbwT5Fg4PTlhcUbQMjg6ySqpMIt6N+qzrWuNAeV1sFBOd2mdlW6TtR0WLrdjmSrorWOiWDbDGhITuGiHh9JcSXidgV2vwDMXeoYGuKzbkA3DT/ny1WvJroEP3+bJ5hLy7qhJahiuJedTTs+4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1745805925; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=K6s5uRaGq0CWfGbK4B6t7zf7cHAfStjhfCLqB/nnvD0=; 
	b=JWoMXZ747/fIJWsprkMBJ7SLJvtWKGgOGklSLyxLtl/4WlEM9dFIxE+TL/NWgMN9xGfsGZ9Fpmd89sbyS584VG4os5lX9gHer0I+Ltt9dq/lLfml280gePcFalbM+SK+taJR1+Xtp5OAdj06d4JqFNgUMJLVTtNLAzaIlJ6Lsro=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=froggi.es;
	spf=pass  smtp.mailfrom=misyl@froggi.es;
	dmarc=pass header.from=<misyl@froggi.es>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1745805925;
	s=mail; d=froggi.es; i=misyl@froggi.es;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=K6s5uRaGq0CWfGbK4B6t7zf7cHAfStjhfCLqB/nnvD0=;
	b=E8d7hIhNHASXJ329d+063HqpwvjOXwZYyWQ+dc2tQQcaG1/umBH+yBTqhI5yKQ+t
	yIuyxY7rKoncgR8FK6LS53eilDYzD5YIl7jwA4TEUHxJ+TUspy1WFYP85FFGeTzkFuM
	yGLiiPxoy0q+TqkhhKd1vgGIxAdKuRLhWq3JPY04=
Received: by mx.zohomail.com with SMTPS id 1745805922295762.2842408145532;
	Sun, 27 Apr 2025 19:05:22 -0700 (PDT)
Message-ID: <5ea8aeb1-3760-4d00-baac-a81a4c4c3986@froggi.es>
Date: Mon, 28 Apr 2025 03:05:19 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Eric Biggers <ebiggers@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <aAvlM1G1k94kvCs9@casper.infradead.org>
 <ahdxc464lydwmyqugl472r3orhrj5dasevw5f6edsdhj3dm6zc@lolmht6hpi6t>
 <20250428013059.GA6134@sol.localdomain>
 <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
Content-Language: en-US
From: Autumn Ashton <misyl@froggi.es>
In-Reply-To: <ytjddsxe5uy4swchkn2hh56lwqegv6hinmlmipq3xxinqzkjnd@cpdw4thi3fqq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External



On 4/28/25 2:43 AM, Kent Overstreet wrote:
> On Sun, Apr 27, 2025 at 06:30:59PM -0700, Eric Biggers wrote:
>> On Sun, Apr 27, 2025 at 08:55:30PM -0400, Kent Overstreet wrote:
>>> The thing is, that's exactly what we're doing. ext4 and bcachefs both
>>> refer to a specific revision of the folding rules: for ext4 it's
>>> specified in the superblock, for bcachefs it's hardcoded for the moment.
>>>
>>> I don't think this is the ideal approach, though.
>>>
>>> That means the folding rules are "whatever you got when you mkfs'd".
>>> Think about what that means if you've got a fleet of machines, of
>>> different ages, but all updated in sync: that's a really annoying way
>>> for gremlins of the "why does this machine act differently" variety to
>>> creep in.
>>>
>>> What I'd prefer is for the unicode folding rules to be transparently and
>>> automatically updated when the kernel is updated, so that behaviour
>>> stays in sync. That would behave more the way users would expect.
>>>
>>> But I only gave this real thought just over the past few days, and doing
>>> this safely and correctly would require some fairly significant changes
>>> to the way casefolding works.
>>>
>>> We'd have to ensure that lookups via the case sensitive name always
>>> works, even if the casefolding table the dirent was created with give
>>> different results that the currently active casefolding table.
>>>
>>> That would require storing two different "dirents" for each real dirent,
>>> one normalized and one un-normalized, because we'd have to do an
>>> un-normalized lookup if the normalized lookup fails (and vice versa).
>>> Which should be completely fine from a performance POV, assuming we have
>>> working negative dentries.
>>>
>>> But, if the unicode folding rules are stable enough (and one would hope
>>> they are), hopefully all this is a non-issue.
>>>
>>> I'd have to gather more input from users of casefolding on other
>>> filesystems before saying what our long term plans (if any) will be.
>>
>> Wouldn't lookups via the case-sensitive name keep working even if the
>> case-insensitivity rules change?  It's lookups via a case-insensitive name that
>> could start producing different results.  Applications can depend on
>> case-insensitive lookups being done in a certain way, so changing the
>> case-insensitivity rules can be risky.
> 
> No, because right now on a case-insensitive filesystem we _only_ do the
> lookup with the normalized name.
> 
>> Regardless, the long-term plan for the case-insensitivity rules should be to
>> deprecate the current set of rules, which does Unicode normalization which is
>> way overkill.  It should be replaced with a simple version of case-insensitivity
>> that matches what FAT does.  And *possibly* also a version that matches what
>> NTFS does (a u16 upcase_table[65536] indexed by UTF-16 coding units), if someone
>> really needs that.
>>
>> As far as I know, that was all that was really needed in the first place.
>>
>> People misunderstood the problem as being about language support, rather than
>> about compatibility with legacy filesystems.  And as a result they incorrectly
>> decided they should do Unicode normalization, which is way too complex and has
>> all sorts of weird properties.
> 
> Believe me, I do see the appeal of that.
> 
> One of the things I should really float with e.g. Valve is the
> possibility of providing tooling/auditing to make it easy to fix
> userspace code that's doing lookups that only work with casefolding.

This is not really about fixing userspace code that expects casefolding, 
or providing some form of stopgap there.

The main need there is Proton/Wine, which is a compat layer for Windows 
apps, which needs to pretend it's on NTFS and everything there expects 
casefolding to work.

No auditing/tooling required, we know the problem. It is unavoidable.

I agree with the calling about Unicode normalization being odd though, 
when I was implementing casefolding for bcachefs, I immediately thought 
it was a huge hammer to do full normalization for the intended purpose, 
and not just a big table...

FWIR, there is actually two forms of casefolding in unicode, full 
casefolding, C+F, (eg. ß->ss) and the simpler one, simple casefolding 
(C+S), where lengths don't change and it's glyph for glyph.

- Autumn ✨

> 
> And, another thing I'd like is a way to make casefolding per-process, so
> that it could be opt-in for the programs that need it - so that new code
> isn't accidentally depending on casefolding.
> 
> That's something we really should have, anyways.
> 
> But, as much as we might hate it, casefolding is something that users
> like and do expect in other contexts, so if casefolding is going to
> exist (as more than just a compatibility thing for legacy code) - it
> really ought to be unicode, and utf8 really has won at this point.
> 
> Mainly though, it's not a decision I care to revisit, I intend to stick
> with casefolding that's compatible with how it's done on our other
> filesystems where it's widely used.
> 



