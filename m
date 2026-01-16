Return-Path: <linux-fsdevel+bounces-74235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C760D3862E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 20:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C9F6304AE5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jan 2026 19:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181823A1E78;
	Fri, 16 Jan 2026 19:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7qWBHHL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA763A1E60;
	Fri, 16 Jan 2026 19:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592642; cv=none; b=Kv+uOzZSR5F3A03mycgAdVG+l7TASU5heHm0XQlhch2cNSnr7byFU9DNLtuoxWClkUwylxOkdplMVKpB3dOT5KUGk77X5Xickb143t/ZIUfX6vIpE9fd3t4eg2c0dOOUE14Kfmw/7juyvHO+WolPkc8YSNFyD3YrKnDwc3xY0m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592642; c=relaxed/simple;
	bh=fowYOJgvzlLvh5gpFBgGukEbk2TOO3O7OzynWJwjMOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jLqjrb+BFFPekZW2Emgu3IN6QMv0KB9KAveK2L8fgl2mV+BX/3QMlJYd+DXkpzJ1hxn/hHQuk3TmBvl9kFbD074SBAmifKE17Mfaje747orhIp/MEncA/CIb4g7JjucYqzVgiX+B/59+iKZHQExWp/z1bb+rHUn1/38usHHfQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7qWBHHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E871C19422;
	Fri, 16 Jan 2026 19:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768592642;
	bh=fowYOJgvzlLvh5gpFBgGukEbk2TOO3O7OzynWJwjMOM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=P7qWBHHLohHNVLhF4wKxbIwjBh4GFRad1Y4i0CrXocC7IIB56DGhI0skdKR/DPTC4
	 iYgI7aLccgOlmYb79Y2NctD/2IncTgcXy1PlBGtEEDwMxDn0ZFi9T2oCkqnlku0Tqn
	 7WPVheWI3Y1GeHVpLQPo+FDP9Zh+m4nt5OdWC9Sr4P4WyYkdJkrdOwF/7/fqOxnY0M
	 e9RRXyDPYeZkflUY+DMJrLd45kTY0BtzPiCwjq0Er7qV0GZ8aAYLmNoCw/AGY8ryls
	 ZwiT3mEyftUf5V0aoFDaPcyUan5TzxS/GhVQpLjA+727OFMMMZu/Id6k+SH3OajIMV
	 LWNrgyfeDtoyg==
Message-ID: <683798bf-b7f3-4418-99ce-b15b0788c960@kernel.org>
Date: Fri, 16 Jan 2026 14:43:50 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] kNFSD Signed Filehandles
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
 NeilBrown <neil@brown.name>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, Eric Biggers <ebiggers@kernel.org>,
 Rick Macklem <rick.macklem@gmail.com>, linux-nfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-crypto@vger.kernel.org
References: <cover.1768573690.git.bcodding@hammerspace.com>
 <f8e2d466-7280-4a21-ad71-21bf1e546300@app.fastmail.com>
 <C69B1F13-7248-4CAF-977C-5F0236B0923A@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <cel@kernel.org>
Organization: kernel.org
In-Reply-To: <C69B1F13-7248-4CAF-977C-5F0236B0923A@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/26 12:17 PM, Benjamin Coddington wrote:
> On 16 Jan 2026, at 11:56, Chuck Lever wrote:
> 
>> On Fri, Jan 16, 2026, at 9:32 AM, Benjamin Coddington wrote:
>>> The following series enables the linux NFS server to add a Message
>>> Authentication Code (MAC) to the filehandles it gives to clients.  This
>>> provides additional protection to the exported filesystem against filehandle
>>> guessing attacks.
>>>
>>> Filesystems generate their own filehandles through the export_operation
>>> "encode_fh" and a filehandle provides sufficient access to open a file
>>> without needing to perform a lookup.  An NFS client holding a valid
>>> filehandle can remotely open and read the contents of the file referred to
>>> by the filehandle.
>>
>> "open, read, or modify the contents of the file"
>>
>> Btw, referring to "open" here is a little confusing, since NFSv3 does
>> not have an on-the-wire OPEN operation. I'm not sure how to clarify.
>>
>>
>>> In order to acquire a filehandle, you must perform lookup operations on the
>>> parent directory(ies), and the permissions on those directories may
>>> prohibit you from walking into them to find the files within.  This would
>>> normally be considered sufficient protection on a local filesystem to
>>> prohibit users from accessing those files, however when the filesystem is
>>> exported via NFS those files can still be accessed by guessing the correct,
>>> valid filehandles.
>>
>> Instead: "an exported file can be accessed whenever the NFS server is
>> presented with the correct filehandle, which can be guessed or acquired
>> by means other than LOOKUP."
>>
>>
>>> Filehandles are easy to guess because they are well-formed.  The
>>> open_by_handle_at(2) man page contains an example C program
>>> (t_name_to_handle_at.c) that can display a filehandle given a path.  Here's
>>> an example filehandle from a fairly modern XFS:
>>>
>>> # ./t_name_to_handle_at /exports/foo
>>> 57
>>> 12 129    99 00 00 00 00 00 00 00 b4 10 0b 8c
>>>
>>>           ^---------  filehandle  ----------^
>>>           ^------- inode -------^ ^-- gen --^
>>>
>>> This filehandle consists of a 64-bit inode number and 32-bit generation
>>> number.  Because the handle is well-formed, its easy to fabricate
>>> filehandles that match other files within the same filesystem.  You can
>>> simply insert inode numbers and iterate on the generation number.
>>> Eventually you'll be able to access the file using open_by_handle_at(2).
>>> For a local system, open_by_handle_at(2) requires CAP_DAC_READ_SEARCH, which
>>> protects against guessing attacks by unprivileged users.
>>>
>>> In contrast to a local user using open_by_handle(2), the NFS server must
>>> permissively allow remote clients to open by filehandle without being able
>>> to check or trust the remote caller's access.

Btw, "allow ... clients to open by filehandle" is another confusion.

NFSv4 OPEN does do access checking and authorization.

Again, it's NFS READ and WRITE that are not blocked.

NFSv3 READ and WRITE do an intrinsic open.

NFSv4 READ and WRITE permit the use of a special stateid so that an OPEN
isn't necessary to do the I/O (IIRC).


>>> Therefore additional
>>> protection against this attack is needed for NFS case.  We propose to sign
>>> filehandles by appending an 8-byte MAC which is the siphash of the
>>> filehandle from a key set from the nfs-utilities.  NFS server can then
>>> ensure that guessing a valid filehandle+MAC is practically impossible
>>> without knowledge of the MAC's key.  The NFS server performs optional
>>> signing by possessing a key set from userspace and having the "sign_fh"
>>> export option.
>>
>> OK, I guess this is where I got the idea this would be an export option.
>>
>> But I'm unconvinced that this provides any real security. There are
>> other ways of obtaining a filehandle besides guessing, and nothing
>> here suggests that guessing is the premier attack methodology.
> 
> Help me understand you - you're unconvinced that having the server sign
> filehandles and verify filehandles prevents clients from fabricating valid
> ones?

The rationale provided here doesn't convince me that fabrication is the
biggest threat and will give us the biggest bang for our buck if it is
mitigated.

In order to carry out this attack, the attacker has to have access to
the filehandles on an NFS client to examine them. She has to have
access to a valid client IP address to send NFS requests from. Maybe
you can bridge the gap by explaining how a /non-root/ user on an NFS
client might leverage FH fabrication to gain access to another user's
files. I think only the root user has this ability.

I've also tried to convince myself that cryptographic FH validation
could mitigate misdirected WRITEs or READs. An attacker could replace
the FH in a valid NFS request, for example, or a client might send
garbage in an FH. I'm not sure those are real problems, though.

I am keeping in mind that everything here is using AUTH_SYS anyway, so
maybe I'm just an old man yelling at a cloud. Nothing here is blocking
yet, but I want the feature to provide meaningful value (as I think you
do).

Thank you for bearing with me.


-- 
Chuck Lever

