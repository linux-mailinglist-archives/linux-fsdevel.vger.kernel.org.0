Return-Path: <linux-fsdevel+bounces-55652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94475B0D485
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 10:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1B7D16447E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jul 2025 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECBD2D7805;
	Tue, 22 Jul 2025 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZBfk+5Mb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E09321ABCB;
	Tue, 22 Jul 2025 08:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753172810; cv=none; b=bgs8tz2XCWdFa/ZoNWm6Tifxq5qaVDm6Wtj/rr2n08A9O8uSbGEBaAt0TXjXtOT7qU/0VsIW9weJ7hJ0ZsrpTPuoYMycuCjnEOkCl5DHwzpmo4NcQjDRU2J7VYN7h7lScTVSd6dcZ4uJRXXomzTXX6/cVIC+1tqnSlXoB3yPobA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753172810; c=relaxed/simple;
	bh=oxO8YKy3feSCjF6Ji2MAcjOuLOpl/GFU0C/wsId+vXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EzIieKcouwPi8gBJYM2ZvN7ZvDewR0XAY1fHoMs47dCX7SQpCrd4MrIidvLvbnNYGmt860HrkLPQ236FGKCqoX6EKB6aowH/j7ytCSmePutU47tOz3Z0DuliQ9JWhjIPrye2H7YhgcWZ8Q/Q+07RZZg2MyY43to6dSaxjpAFDNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZBfk+5Mb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0143C4CEEB;
	Tue, 22 Jul 2025 08:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753172810;
	bh=oxO8YKy3feSCjF6Ji2MAcjOuLOpl/GFU0C/wsId+vXc=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZBfk+5MbqoLbrRP4SopLMhNdtx97qwxkEqkYEeUQspreRAPnMhLOyxs4rn+tAXNeY
	 KCUm3PcXvPK/aXkZI8Y3i6v7ho+cc/MNxLisrFovdV8S/17ib9jnZg61rdtJU+duit
	 J+xKL0Bhr3LeIklSViSqDgdo/3/rnuU1tlKVBlw9Nrp+PPUyF6NTVyBRnTtLyGIjpW
	 QpqYsykK0UxLIRqHGu+yAT9Ymi69yNkxeTndXAy8MN2dEErWJX6IYDf+xuw+dS2p/0
	 jdQeseU8sABFpXH4Sf99Bep2B7JNEH8YS2jfWeqh20hkWhDlWpskCqc6jdRgJhyk3/
	 W++QGd6OBVbPw==
Message-ID: <49eeff09-993f-42a0-8e3b-b3f95b41dbcf@kernel.org>
Date: Tue, 22 Jul 2025 10:26:43 +0200
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
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Vlastimil Babka <vbabka@suse.cz>, Daniel Gomez <da.gomez@samsung.com>,
 Matthias Maennich <maennich@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
 Peter Zijlstra <peterz@infradead.org>, David Hildenbrand <david@redhat.com>,
 Shivank Garg <shivankg@amd.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20250715-export_modules-v3-1-11fffc67dff7@suse.cz>
 <b340eb9f-a336-461c-befe-6b09c68b731e@kernel.org>
 <24f995fe-df76-4495-b9c6-9339b6afa6be@suse.cz>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <24f995fe-df76-4495-b9c6-9339b6afa6be@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/07/2025 12.40, Vlastimil Babka wrote:
> On 7/15/25 20:58, Daniel Gomez wrote:
>> On 15/07/2025 10.43, Vlastimil Babka wrote:
>>> Christoph suggested that the explicit _GPL_ can be dropped from the
>>> module namespace export macro, as it's intended for in-tree modules
>>> only. It would be possible to restrict it technically, but it was
>>> pointed out [2] that some cases of using an out-of-tree build of an
>>> in-tree module with the same name are legitimate. But in that case those
>>> also have to be GPL anyway so it's unnecessary to spell it out in the
>>> macro name.
>>>
>>> Link: https://lore.kernel.org/all/aFleJN_fE-RbSoFD@infradead.org/ [1]
>>> Link: https://lore.kernel.org/all/CAK7LNATRkZHwJGpojCnvdiaoDnP%2BaeUXgdey5sb_8muzdWTMkA@mail.gmail.com/ [2]
>>> Suggested-by: Christoph Hellwig <hch@infradead.org>
>>> Reviewed-by: Shivank Garg <shivankg@amd.com>
>>> Acked-by: David Hildenbrand <david@redhat.com>
>>> Acked-by: Nicolas Schier <n.schier@avm.de>
>>> Reviewed-by: Daniel Gomez <da.gomez@samsung.com>
>>> Reviewed-by: Christian Brauner <brauner@kernel.org>
>>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>>> ---
>>> Daniel, please clarify if you'll take this via module tree or Christian
>>> can take it via vfs tree?
>>
>> Patch 707f853d7fa3 ("module: Provide EXPORT_SYMBOL_GPL_FOR_MODULES() helper")
>> from Peter was merged through Masahiro in v6.16-rc1. Since this is a related
>> fix/rename/cleanup, it'd make sense for it to go through his kbuild tree as
>> well. Masahiro, please let me know if you'd prefer otherwise. If not, I'll queue
>> it up in the modules tree.
> 
> Maybe with no reply, you can queue it then?

+ Jiri, Stephen and Greg, added to the To: list.

EXPORT_SYMBOL_GPL_FOR_MODULES macro was merged [1] through Masahiro's
pull request in v6.16-rc1. This patch from Vlastimil renames the macro to
EXPORT_SYMBOL_FOR_MODULES. This means Jiri's patch b20d6576cdb3 "serial: 8250:
export RSA functions" will need to be updated accordingly. I'd like like to
know how you prefer to proceed, since it was requested to have this merged as a
fix before Linus releases a new kernel with the former name.

Link: https://lore.kernel.org/all/CAK7LNAQunzxOHR+vMZLf8kqxyRtLx-Z2G2VZquJmndrT9TZjiQ@mail.gmail.com/ [1]


Masahiro, just a heads-up that I plan to merge this through the linux-modules
tree unless you advise otherwise.

