Return-Path: <linux-fsdevel+bounces-55656-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5EFB0D551
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 11:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254C83B9183
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 09:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B322B2DA76F;
	Tue, 22 Jul 2025 09:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTbuEeH4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8C9189F5C;
	Tue, 22 Jul 2025 09:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753175318; cv=none; b=YE2UQ+T9OzyRJ+XaAeWJCDNfocQWXwRCmSmMjDGVHhwkxFcnMCuA0b09MpaQ1T29BXrgEUvynTxlplC28Dp0A5AKk+XFYXIuLx2HqlmQu/pgPo1nF0FE7HXYDDZXxrBMSxGe07JTpv3KZnsBxh93PlnMHHAGoApuIVmL6TeineE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753175318; c=relaxed/simple;
	bh=bpDft6oO+lFmar4gUVFA5oPCPI7YERjD3nM/ltmpdLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pjdhlhy3g5pPMwdQjmW5fDGjp7D0umWxYnAZxPx0X/EfcAgdF9fQA/62GZWHV1dKZuC9syKVfupG4j93b/8tZK4cSB2jK4aNgB/bqG3/O47m9Axubr/8vMWrHQithdgqHPXx58TvM9q80EHl5lTsmE93I0/tQhmUaaVOCIZ9bpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTbuEeH4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B046C4CEEB;
	Tue, 22 Jul 2025 09:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753175317;
	bh=bpDft6oO+lFmar4gUVFA5oPCPI7YERjD3nM/ltmpdLg=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fTbuEeH43Z/f3Fxffb7Z/yQ4rg69ui3KXpFD/Wf9NFdU8u0noTtyC5R6HIZD3cft5
	 rad884nOOJrLawmfJB0M11oQ9L8zlp8VTJSQUKNOfZU66uPEicDqIZcXkBICKZHCez
	 vPxAjcVPQwHExWCD0e6SG7vYSFltb6jWdVlqC/QZvVZnFZtzm+GEAF8zupIanlvTgx
	 1/bH7RomwwB/y5RZTbJlDFY+eiNvW+oSyt6zHd01S0L4ArAFWY2X23CZIWV8wY7L5y
	 42/WKnssfOlr/MJlCk2PNfAN8HfFWZhwnDCuhaWnyP1ju54GRLENyyuHJTUtnPTBXF
	 fHsGSr/ggPm7A==
Message-ID: <946c55cb-4810-4c1f-8f87-4456b6ceb37f@kernel.org>
Date: Tue, 22 Jul 2025 11:08:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH v3] module: Rename EXPORT_SYMBOL_GPL_FOR_MODULES to
 EXPORT_SYMBOL_FOR_MODULES
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Gomez
 <da.gomez@samsung.com>, Matthias Maennich <maennich@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@infradead.org>, Peter Zijlstra
 <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 Shivank Garg <shivankg@amd.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250715-export_modules-v3-1-11fffc67dff7@suse.cz>
 <b340eb9f-a336-461c-befe-6b09c68b731e@kernel.org>
 <24f995fe-df76-4495-b9c6-9339b6afa6be@suse.cz>
 <49eeff09-993f-42a0-8e3b-b3f95b41dbcf@kernel.org>
 <2025072219-dollhouse-margarita-de67@gregkh>
 <9d61a747-2655-4f4c-a8fe-5db51ff33ff7@suse.cz>
 <2025072246-unexpired-deletion-a0f8@gregkh>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <2025072246-unexpired-deletion-a0f8@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 22/07/2025 10.53, Greg Kroah-Hartman wrote:
> On Tue, Jul 22, 2025 at 10:49:48AM +0200, Vlastimil Babka wrote:
>> On 7/22/25 10:46, Greg Kroah-Hartman wrote:
>>> On Tue, Jul 22, 2025 at 10:26:43AM +0200, Daniel Gomez wrote:
>>>>>
>>>>> Maybe with no reply, you can queue it then?
>>>>
>>>> + Jiri, Stephen and Greg, added to the To: list.
>>>>
>>>> EXPORT_SYMBOL_GPL_FOR_MODULES macro was merged [1] through Masahiro's
>>>> pull request in v6.16-rc1. This patch from Vlastimil renames the macro to
>>>> EXPORT_SYMBOL_FOR_MODULES. This means Jiri's patch b20d6576cdb3 "serial: 8250:
>>>> export RSA functions" will need to be updated accordingly. I'd like like to
>>>> know how you prefer to proceed, since it was requested to have this merged as a
>>>> fix before Linus releases a new kernel with the former name.
>>>
>>> So you want this in 6.16-final?  Ok, do so and then someone needs to fix
>>> up the build breakage in linux-next and in all of the pull requests to
>>> Linus for 6.17-rc1 :)
>>>

I see... that doesn't sound like it was the right approach. I didn't expect
follow-up fixes to be needed for the next merge window. Thanks for the heads-up.
I'll hold off on merging this for now.

>>>> Link: https://lore.kernel.org/all/CAK7LNAQunzxOHR+vMZLf8kqxyRtLx-Z2G2VZquJmndrT9TZjiQ@mail.gmail.com/ [1]
>>>>
>>>>
>>>> Masahiro, just a heads-up that I plan to merge this through the linux-modules
>>>> tree unless you advise otherwise.
>>>
>>> Why not just do the rename after 6.17-rc1 is out?  That way all new
>>> users will be able to be caught at that point in time.  There's no issue
>>
>> Hm there might be people basing their new exports for 6.18 on 6.17-rc1. They
>> would have to be told to use rc2 then.
> 
> Yes, that's normal, nothing wrong with that at all, we make api name
> changes across the tree quite often (i.e. almost every-other release.)
> 
>> Maybe the best way would be if Linus
>> did this just before tagging rc1, while fixing up all users merged during
>> the merge window?
> 
> Again, what's wrong with -rc2?  Anyone caught using this on only -rc1
> will get a quick "this broke the build" report in linux-next so it's not
> like this is going to be unnoticed at all.

I think Christian had some renaming candidates. Christian, does this work for
you?

