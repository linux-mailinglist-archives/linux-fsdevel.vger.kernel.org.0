Return-Path: <linux-fsdevel+bounces-57474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1929CB22001
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 09:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621C13B776B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 07:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9122E03F1;
	Tue, 12 Aug 2025 07:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sttdIgbX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697D42DECD8;
	Tue, 12 Aug 2025 07:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754985290; cv=none; b=q4yPMCL6E/GvA9RH2h24GAN80HofkFlZNMOaqcrSOmhx7eXVqVsxo0PPcqDsREprZsrRVkeJIpM2h5z6syF/J38vR7hFGVIGVeCQe42fHmeK/ckoP3X29J5e8GTjZJlLZ7QEBTwu/ldq3o7G7wI/QE7uqMp/mvYOGtdnujUQxKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754985290; c=relaxed/simple;
	bh=BHJ5xoJPn+2ti329G2SFM29twFzww1ODA9PMzU7W59c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fUOtMMqwny8zIPt1P+xARONvwJPkDrwdlC6nZ8DbSqTtgUBbZ6ZNcuJj9uDbaM4PSXoKfSKMuSM7gw3VSdXK7BBglduZXztdvE+rqZ5l2EL55tCYib5XtHnlXBXEsOhzTD6jV44WiKm+2bWWfYPtSzRjeoKGQmwIF4Sp87CISiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sttdIgbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 898A8C4CEF0;
	Tue, 12 Aug 2025 07:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754985290;
	bh=BHJ5xoJPn+2ti329G2SFM29twFzww1ODA9PMzU7W59c=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sttdIgbXR/zMpPwtYWo9tEDHWkvxHIdzXx4mCkeZC+beUlUKcpCZHJHLA8UKGtUse
	 yb61P5jo64FxKOsWma+2ENRYP7aOwn8dcUSn1EaHfRaFvY+CZDfAhBMmUwD9Q5/NDA
	 mc4tJ2CZKRlm+O0uN6BAwWKU/EO6xaJ9LDzdN8a2qIcWUe4wYiLIhTHeGFkrmWGZ0j
	 Tntx4Wm5aFLBOAdaAFK/dtBOppsl0dVHBU4rFIGEE/KhS94frwCgrXD71bU+LtCWzc
	 AJrNZ2UeB+z+55FmgDLu8XmYLXt9yb4i2dcnFthLY6Q6S8ybAiL+zqRxMjgEy+5auA
	 RCM7cnbm584vQ==
Message-ID: <2472a139-064c-4381-bc6e-a69245be01df@kernel.org>
Date: Tue, 12 Aug 2025 09:54:43 +0200
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
To: Christian Brauner <brauner@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>,
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
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20250811-wachen-formel-29492e81ee59@brauner>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/08/2025 07.18, Christian Brauner wrote:
> On Fri, 08 Aug 2025 15:28:47 +0200, Vlastimil Babka wrote:
>> Christoph suggested that the explicit _GPL_ can be dropped from the
>> module namespace export macro, as it's intended for in-tree modules
>> only. It would be possible to restrict it technically, but it was
>> pointed out [2] that some cases of using an out-of-tree build of an
>> in-tree module with the same name are legitimate. But in that case those
>> also have to be GPL anyway so it's unnecessary to spell it out in the
>> macro name.
>>
>> [...]
> 
> Ok, so last I remember we said that this is going upstream rather sooner
> than later before we keep piling on users. If that's still the case I'll
> take it via vfs.fixes unless I hear objections.

This used to go through Masahiro's kbuild tree. However, since he is not
available anymore [1] I think it makes sense that this goes through the modules
tree. The only reason we waited until rc1 was released was because of Greg's
advise [2]. Let me know if that makes sense to you and if so, I'll merge this
ASAP.

Link: https://lore.kernel.org/all/CAK7LNAQW8b_HEQhWBzaQSPy=qDmKkqz6URtpJ+BYG8eq-sWRwA@mail.gmail.com/ [1]
Link: https://lore.kernel.org/all/2025072219-dollhouse-margarita-de67@gregkh/ [2]


