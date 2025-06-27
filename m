Return-Path: <linux-fsdevel+bounces-53214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB10EAEC045
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 21:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A542640C5E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 19:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50C1212B1E;
	Fri, 27 Jun 2025 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M1yexdNX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0841A2387
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Jun 2025 19:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053370; cv=none; b=N5ViRzwkKnwFihgwvwDeuHL6A1pk55CGNfO1jkDUZs95zACjkYtM5UvPY6xYJbTs1/ny5uN8v8ZKe1R63aghJVi0q0HKSXYZ09nEtoxvb2DQbz1K61f1tlejSRxZKlBxQqMXB317VxzD4k7FD1xmUTPtEZvW6lo1EbxGUxCMgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053370; c=relaxed/simple;
	bh=OLsiblbD30bMEADwFBTdnq08XDWZ4YNw5yDgXwOvedQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNXpG9IumSFG43FO0EBqkPWL0DEfqG7eekrgIMEWr3wKVWqD+WI0I4Hm74Raeks8pr4Ea8pQeLZM/QeV0NO+jCMortLK3wNm4JO4LFRg6IGO9eRVkJoy1B03V+jJIxpeTGlxesXhktYLLJcohalNACFJXh24cNdXnC9gs7De4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M1yexdNX; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 27 Jun 2025 15:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751053365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h035NnqCX1c3xP4ru1BilXA6CW38PXAnRjGNRfkRM2I=;
	b=M1yexdNXg+CWSBnaA7wfbhjGt1QdUK1sX+l2qF5Opz4iKF+0507R4USBh4Q45MD8nPWvSq
	rdxskb4KflKZh6UeUQmEBK/gWGdtgbuLbYV4Wxaf6PM/d0guetTxA+urU99jTRL+n7tf55
	FCpf77sHEAfZ0oykLEepCdXfiFEtrWE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Kyle Sanderson <kyle.leet@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] bcachefs fixes for 6.16-rc4
Message-ID: <gxpaa7u46vicn5npm4plvvdd3iuowzts4oljuw2djfqny3rqae@n6vi53u6sa43>
References: <ahdf2izzsmggnhlqlojsnqaedlfbhomrxrtwd2accir365aqtt@6q52cm56jmuf>
 <CAHk-=wi+k8E4kWR8c-nREP0+EA4D+=rz5j0Hdk3N6cWgfE03-Q@mail.gmail.com>
 <065f98ab-885d-4f5e-97e3-beef095b93f0@gmail.com>
 <774936dd-32b8-46f1-a849-2f8ea76a24ac@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <774936dd-32b8-46f1-a849-2f8ea76a24ac@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 27, 2025 at 12:16:09PM -0700, Kyle Sanderson wrote:
> On 6/27/2025 12:07 PM, Kyle Sanderson wrote:
> > On 6/26/2025 8:21 PM, Linus Torvalds wrote:
> > > On Thu, 26 Jun 2025 at 19:23, Kent Overstreet
> > > <kent.overstreet@linux.dev> wrote:
> > > > 
> > > > per the maintainer thread discussion and precedent in xfs and btrfs
> > > > for repair code in RCs, journal_rewind is again included
> > > 
> > > I have pulled this, but also as per that discussion, I think we'll be
> > > parting ways in the 6.17 merge window.
> > > 
> > > You made it very clear that I can't even question any bug-fixes and I
> > > should just pull anything and everything.
> > > 
> > > Honestly, at that point, I don't really feel comfortable being
> > > involved at all, and the only thing we both seemed to really
> > > fundamentally agree on in that discussion was "we're done".
> > > 
> > >                Linus
> > 
> > Linus,
> > 
> > The pushback on rewind makes sense, it wasn’t fully integrated and was
> > fsck code written to fix the problems with the retail 6.15 release -
> > this looks like it slipped through Kents CI and there were indeed
> > multiple people hit by it (myself included).
> > 
> > Quoting someone back to themselves is not cool, however I believe it
> > highlights what has gone on here which is why I am breaking my own rule:
> > 
> > "One of the things I liked about the Rust side of the kernel was that
> > there was one maintainer who was clearly much younger than most of the
> > maintainers and that was the Rust maintainer.
> > 
> > We can clearly see that certain areas in the kernel bring in more young
> > people.
> > 
> > At the Maintainer Summit, we had this clear division between the
> > filesystem people, who were very careful and very staid, and cared
> > deeply about their code being 100% correct - because if you have a bug
> > in a filesystem, the data on your disk may be gone - so these people
> > take themselves and their code very seriously.
> > 
> > And then you have the driver people who are a bit more 'okay',
> > especially the GPU folks, 'where anything goes'.
> > You notice that on the driver side it’s much easier to find young
> > people, and that is traditionally how we’ve grown a lot of maintainers.
> > " (1)
> > 
> > Kent is moving like the older days of rapid development - fast and
> > driven - and this style clashes with the mature stable filesystem
> > culture that demands extreme caution today. Almost every single patch
> > has been in response to reported issues, the primary issue here is
> > that’s on IRC where his younger users are (not so young, anymore - it is
> > not tiktok), and not on lkml. The pace of development has kept up, and
> > the "new feature" part of it like changing out the entire hash table in
> > rc6 seems to have stopped. This is still experimental, and he's moving
> > that way now with care and continuing to improve his testing coverage
> > with each bug.
> > 
> > Kent has deep technical experience here, much earlier in the
> > interview(1) regarding the 6.7 merge window this filesystem has been in
> > the works for a decade. Maintainership means adapting to kernel process
> > as much as code quality, that may be closer to the issue here.
> > 
> > If direct pulls aren’t working, maybe a co-maintainer or routing changes
> > through a senior fs maintainer can help. If you're open to it, maybe
> > that is even you.
> > 
> > Dropping bcachefs now would be a monumental step backward from the
> > filesystems we have today. Enterprises simply do not use them for true
> > storage at scale which is why vendors have largely taken over this
> > space. The question is how to balance rigor with supporting new
> > maintainers in the ecosystem. Everything Kent has written around
> > supporting users is true, and publicly visible, if only to the 260 users
> > on irc, and however many more are on matrix. There are plenty more that
> > are offline, and while this is experimental there are a number of public
> > sector agencies testing this now (I have seen reference to a number of
> > emergency service providers, which isn’t great, but for whatever reason
> > they are doing that).
> > 
> > (1) https://youtu.be/OvuEYtkOH88?t=1044
> > 
> > Kyle.
> 
> Re-sending as this thread seems to have typo'd lkml (removing the bad
> entry).

Thanks.

Also, I think I should add, in case my words in the private conversation
were misinterpreted:

I don't think bcachefs should be dropped from the kernel, I think it
would be better for this to be worked out.

I firstly want to reassure people that: if bcachefs has to be shipped as
a DKMS module, that will not kill the project. It will be a giant hassle
(especially if distributions have to scramble), but life will continue.
I remain committed as ever to getting this done - one way or the other.

And I think it is safe to say that going that route would be the better
option for the sanity of myself and Linus, but it wouldn't be the better
option for the users or the rest of the development community.

With that, I am going to take a breather.

