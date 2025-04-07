Return-Path: <linux-fsdevel+bounces-45862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEC8A7DC25
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 13:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429A3188F626
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11ACD23BCF4;
	Mon,  7 Apr 2025 11:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ifa7NOEf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CEF20E6FB;
	Mon,  7 Apr 2025 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744024947; cv=none; b=SVdXIZfX4qYVKri9oWb/ymrGLlhbo43FhbgqyxLR8ZJ6TsS2NPJYhi6fbrUIDfGM5JmnBcHWBpxyeICTs3hZxARIXOIuKZn7itOERRsE2IVuQOpqR/VQx0A7mFvuiWW4B6tsdFDnuKs+LPePJaywnzg8Z8Odg5Qpgip7D8nuz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744024947; c=relaxed/simple;
	bh=r82YfUQKHA8SpPqT1MraF0loP2XAnUryjmxg1o30qAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=la1K4UYMdn6i1hbaRDlUHf/5K9NDEpGlYCp1XPxazpo1uTt6XrCSyfptt8Wk7sZLzp/l/zhpCAxjOw1+KeB6Lm/a6qAyxljR60Q7QL6zrhHLTEPV8Jq+vfQ749MxY67uD5FJYNy2y7MtqpFmz1kXqI65slfW8bVck2tPPnaDkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ifa7NOEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88CFC4CEDD;
	Mon,  7 Apr 2025 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744024946;
	bh=r82YfUQKHA8SpPqT1MraF0loP2XAnUryjmxg1o30qAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ifa7NOEfglT2WxL4l8xfldhVv0NyTkYPtRtC4S2B3MBXNmWMeq+oXhky4STZypUu/
	 6xrxi8nexqrZA4XBtv4yM4HdbEKk7jQa45EPdydv+RQXQspti8MqRNRgGXpNkY5yxt
	 y88Z2J7Bj5N7n5vJ97LRBQ2FNYUMJ/fdwnrt/x+bD2kl1Ueg02yBKjMP2bD+UlwWxS
	 1Rj4oj/5N3lv9MMe8PwXxnPgJQTY9tpHpZvROBtq6ReOMPpDbYZSsU6uobV0sWl7Oa
	 143D3GRKlkaZ1UxCAa1LhJGkoEI2pExei/5W4tNMeuslLe9cA2j9joeRjG9dTSX6Jn
	 iams365nlzE7g==
Date: Mon, 7 Apr 2025 13:22:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Leon Romanovsky <leon@kernel.org>, pr-tracker-bot@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] vfs mount
Message-ID: <20250407-ziegen-heilfroh-f9033bcd8e2f@brauner>
References: <20250322-vfs-mount-b08c842965f4@brauner>
 <174285005920.4171303.15547772549481189907.pr-tracker-bot@kernel.org>
 <20250401170715.GA112019@unreal>
 <20250403-bankintern-unsympathisch-03272ab45229@brauner>
 <20250403-quartal-kaltstart-eb56df61e784@brauner>
 <196c53c26e8f3862567d72ed610da6323e3dba83.camel@HansenPartnership.com>
 <6pfbsqikuizxezhevr2ltp6lk6vqbbmgomwbgqfz256osjwky5@irmbenbudp2s>
 <CAHk-=wjksLMWq8At_atu6uqHEY9MnPRu2EuRpQtAC8ANGg82zw@mail.gmail.com>
 <Z--YEKTkaojFNUQN@infradead.org>
 <CAHk-=wjjGb0Uik101G-B76pp+Xvq5-xa1azJF0EwRxb_kisi2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjjGb0Uik101G-B76pp+Xvq5-xa1azJF0EwRxb_kisi2Q@mail.gmail.com>

On Fri, Apr 04, 2025 at 07:19:27AM -0700, Linus Torvalds wrote:
> On Fri, 4 Apr 2025 at 01:28, Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Or just kill the non-scoped guard because it simply is an insane API.
> 
> The scoped guard may be odd, but it's actually rather a common
> situation. And when used with the proper indentation, it also ends up
> being pretty visually clear about what part of a function is under the
> lock.
> 
> But yeah, if you don't end up using it right, it ends up very very wrong.
> 
> Not that that is any different from "if ()" or any other similar
> construct, but obviously people are much more *used* to 'if ()' and
> friends.
> 
> An 'if ()" without the nested statement looks very wrong - although
> it's certainly not unheard of - while a 'scoped_guard()' without the
> nested statement might visually pass just because it doesn't trigger
> the same visceral "that's not right" reaction.
> 
> So I don't think it's an insane API, I think it's mostly that it's a
> _newish_ API.

Both the scoped and non-scoped guards are very useful. I initially used
a scoped variant but then reworked the code to use a non-scoped one and
fscked it up.

I agree with Linus here it was just me not having the same "Oh right,
that's odd reaction.".

I love the guard infrastructure. It's a massive improvement. Thanks to
Peter for finally bringing this into the kernel after I've worked with
this for years in userspace already. It literally helped obliterate
nearly all memory safety bugs in systemd and I'm confident it will have
positive effects in the kernel long-term as well.

And please, can we (collective we) for once all decide to not turn yet
another issue into a two week thread of New York Times Opinion pieces on
how Things Really Are and Should Have Been Done. :)

