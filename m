Return-Path: <linux-fsdevel+bounces-58035-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9486B28319
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 17:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC779189DECB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Aug 2025 15:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AB2306D3A;
	Fri, 15 Aug 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLtvEjpC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F45305E3D;
	Fri, 15 Aug 2025 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755272405; cv=none; b=uVpLI+6hE854U/SHrXmUcIW7RcPrqV9JPPYkIspD1GSFxerRW9h6NNsI1RkSQgICW22YGlDtktcIWGgefD4955d7lfYivRvF9oW5zCKppUEOUfuq9C5VwR1ivfn7pSnyLhc85xuIvlv3bJP/NZ55En37NCWoGnk4qwGOkYEb78w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755272405; c=relaxed/simple;
	bh=qFFD29Z0bBGyOJ/r8urMn6MWEW61foW7aAMeULHu5cQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a2xy/QlxIynPNEzZxOQX4+wvlIkD8h3pHLlQz8JCcxDfcp+0BVP5J0Rf83ffi00oRbdW28xdg6NHp8OyRUetzUBLVowhmfq/0yjDdE9TGK37uL69uHFbYiUAkOv4cqqZqQsa07xtCq5/od4yAfbSybuY28chSH+hQ8/mO8+S65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLtvEjpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E9CC4CEEB;
	Fri, 15 Aug 2025 15:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755272405;
	bh=qFFD29Z0bBGyOJ/r8urMn6MWEW61foW7aAMeULHu5cQ=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fLtvEjpCpJcL4Br3dGCA310R4Y2FqThotOiDwP4/RNMBJ98DOeQ6jMFavPuxM7u3Z
	 YBee3GcniPTXE8VnxbNAntO0WnrVAlBSPN/Rg+auulmBzReVjKLE2wtJk5WGr9p/bA
	 v+UNwcB1/HCJcruh4liLcSUzkIFGzj0D5zYEE1AXG6Bk3xOVDgSxCTVgfi20L/peGh
	 W5FxJvKHnD4Ces7ML+U4Xa6U1VyeXnxnHxpgLwSOkuc9mVH4pqvhiFujcu52R4pqai
	 z7w2V5CQDgdwyu3IrZ3mvsiUf3zYUspnccKIKH2BgfWuZt+l2P3OJX4xy8OsKJ0J7E
	 gbYclLaeRfxNw==
Message-ID: <6cce2564-04f2-44ab-96d3-2f47fc221591@kernel.org>
Date: Fri, 15 Aug 2025 17:39:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v4] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Christoph Hellwig <hch@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 Shivank Garg <shivankg@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Daniel Gomez <da.gomez@samsung.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
References: <20250808-export_modules-v4-1-426945bcc5e1@suse.cz>
 <20250811-wachen-formel-29492e81ee59@brauner>
 <2472a139-064c-4381-bc6e-a69245be01df@kernel.org>
 <20250815-darstellen-pappen-90a9edb193e5@brauner>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250815-darstellen-pappen-90a9edb193e5@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/08/2025 07.25, Christian Brauner wrote:
> On Tue, Aug 12, 2025 at 09:54:43AM +0200, Daniel Gomez wrote:
>> On 11/08/2025 07.18, Christian Brauner wrote:j
>>> On Fri, 08 Aug 2025 15:28:47 +0200, Vlastimil Babka wrote:
>>>> Christoph suggested that the explicit _GPL_ can be dropped from the
>>>> module namespace export macro, as it's intended for in-tree modules
>>>> only. It would be possible to restrict it technically, but it was
>>>> pointed out [2] that some cases of using an out-of-tree build of an
>>>> in-tree module with the same name are legitimate. But in that case those
>>>> also have to be GPL anyway so it's unnecessary to spell it out in the
>>>> macro name.
>>>>
>>>> [...]
>>>
>>> Ok, so last I remember we said that this is going upstream rather sooner
>>> than later before we keep piling on users. If that's still the case I'll
>>> take it via vfs.fixes unless I hear objections.
>>
>> This used to go through Masahiro's kbuild tree. However, since he is not
>> available anymore [1] I think it makes sense that this goes through the modules
>> tree. The only reason we waited until rc1 was released was because of Greg's
>> advise [2]. Let me know if that makes sense to you and if so, I'll merge this
>> ASAP.
> 
> At this point it would mean messing up all of vfs.fixes to drop it from
> there. So I'd just leave it in there and send it to Linus.

Got it. I was waiting for confirmation before taking it into the modules tree,
and I agree that at this point it makes sense to keep it in vfs.fixes.

> Next time I know where it'll end up.

Can you clarify what you mean by this?

