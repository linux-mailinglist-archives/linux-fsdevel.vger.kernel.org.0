Return-Path: <linux-fsdevel+bounces-13242-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7859A86DA15
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 04:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E244286CC5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Mar 2024 03:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2986A45BEA;
	Fri,  1 Mar 2024 03:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ukfuxDlI";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ukfuxDlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA0244370
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Mar 2024 03:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709264051; cv=none; b=KaF4x0DVKWsjYXiWz+4y+IFcWh7e1WUru6CGVuWjbrb1a/BnBFP7Ww8g9nfQvE/dK8cZI5DdNDTttVRIzw2uJ37BODLvAjUh9mwSFsEQ29MFHlWRWlq/jE3c4s4dLI20GNYBjozSY9PRW5kDa7XEojYomtB+mfrVJVj3Tzo1/cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709264051; c=relaxed/simple;
	bh=3XwkT15FX1PviarX4+OAQ0l8HZ+Hl6lcikZ6nvaLwAw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sghHBINY9NmBz6pKVYKvekxy3cbJ6LRQfyPw4raDKWJn3KwKykFPEJbY7/wame33OO5WNOA/PQAvaIY6mqUvNwSw9BSX8fkghV15jhtL1f4aalDvPnHYK7VcF0znv9Ioy/C+SbdJZyNxoFJHv4PaT3L2Y8ievYSN84SSYzf31/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ukfuxDlI; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ukfuxDlI; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1709264047;
	bh=3XwkT15FX1PviarX4+OAQ0l8HZ+Hl6lcikZ6nvaLwAw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ukfuxDlIlLkSPOlQn+wlblV3hpFMYfCEp5Uy6PxW2JLK04Zs1U8reUlMQW7rD4hOm
	 sOQpD1/Af7knxNp7n7ijEwog9ZfRi9O6Cs26ttT0zES1ArZ/sc1GrgNZOnkWY5QQzk
	 j2ClJELYvO7iULtoIEppTcy1Dp95ZjVpaI2qbDVs=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id BD2E11281C36;
	Thu, 29 Feb 2024 22:34:07 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id P1ZNtldh87bV; Thu, 29 Feb 2024 22:34:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1709264047;
	bh=3XwkT15FX1PviarX4+OAQ0l8HZ+Hl6lcikZ6nvaLwAw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
	b=ukfuxDlIlLkSPOlQn+wlblV3hpFMYfCEp5Uy6PxW2JLK04Zs1U8reUlMQW7rD4hOm
	 sOQpD1/Af7knxNp7n7ijEwog9ZfRi9O6Cs26ttT0zES1ArZ/sc1GrgNZOnkWY5QQzk
	 j2ClJELYvO7iULtoIEppTcy1Dp95ZjVpaI2qbDVs=
Received: from [10.0.15.72] (unknown [49.231.15.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id F3F8D1281BF1;
	Thu, 29 Feb 2024 22:34:03 -0500 (EST)
Message-ID: <a43cf329bcfad3c52540fe33e35e2e65b0635bfd.camel@HansenPartnership.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Kent Overstreet <kent.overstreet@linux.dev>, Matthew Wilcox
	 <willy@infradead.org>
Cc: NeilBrown <neilb@suse.de>, Amir Goldstein <amir73il@gmail.com>, 
	paulmck@kernel.org, lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Jan Kara <jack@suse.cz>
Date: Fri, 01 Mar 2024 10:33:59 +0700
In-Reply-To: <wpof7womk7rzsqeox63pquq7jfx4qdyb3t45tqogcvxvfvdeza@ospqr2yemjah>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
	 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
	 <Zd-LljY351NCrrCP@casper.infradead.org>
	 <170925937840.24797.2167230750547152404@noble.neil.brown.name>
	 <l25hltgrr5epdzrdxsx6lgzvvtzfqxhnnvdru7vfjozdfhl4eh@xvl42xplak3u>
	 <ZeFCFGc8Gncpstd8@casper.infradead.org>
	 <wpof7womk7rzsqeox63pquq7jfx4qdyb3t45tqogcvxvfvdeza@ospqr2yemjah>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2024-02-29 at 22:09 -0500, Kent Overstreet wrote:
> On Fri, Mar 01, 2024 at 02:48:52AM +0000, Matthew Wilcox wrote:
> > On Thu, Feb 29, 2024 at 09:39:17PM -0500, Kent Overstreet wrote:
> > > On Fri, Mar 01, 2024 at 01:16:18PM +1100, NeilBrown wrote:
> > > > Insisting that GFP_KERNEL allocations never returned NULL would
> > > > allow us to remove a lot of untested error handling code....
> > > 
> > > If memcg ever gets enabled for all kernel side allocations we
> > > might start seeing failures of GFP_KERNEL allocations.
> > 
> > Why would we want that behaviour?  A memcg-limited allocation
> > should behave like any other allocation -- block until we've freed
> > some other memory in this cgroup, either by swap or killing or ...
> 
> It's not uncommon to have a more efficient way of doing something if
> you can allocate more memory, but still have the ability to run in a
> more bounded amount of space if you need to; I write code like this
> quite often.

The cgroup design is to do what we do usually, but within settable hard
and soft limits.  So if the kernel could make GFP_KERNEL wait without
failing, the cgroup would mirror that.

> Or maybe you just want the syscall to return an error instead of
> blocking for an unbounded amount of time if userspace asks for
> something silly.

Warn on allocation above a certain size without MAY_FAIL would seem to
cover all those cases.  If there is a case for requiring instant
allocation, you always have GFP_ATOMIC, and, I suppose, we could even
do a bounded reclaim allocation where it tries for a certain time then
fails.

> Honestly, relying on the OOM killer and saying that because that now
> we don't have to write and test your error paths is a lazy cop out.

OOM Killer is the most extreme outcome.  Usually reclaim (hugely
simplified) dumps clean cache first and tries the shrinkers then tries
to write out dirty cache.  Only after that hasn't found anything after
a few iterations will the oom killer get activated.

> The same kind of thinking got us overcommit, where yes we got an
> increase in efficiency, but the cost was that everyone started
> assuming and relying on overcommit, so now it's impossible to run
> without overcommit enabled except in highly controlled environments.

That might be true for your use case, but it certainly isn't true for a
cheap hosting cloud using containers: overcommit is where you make your
money, so it's absolutely standard operating procedure.  I wouldn't
call cheap hosting a "highly controlled environment" they're just
making a bet they won't get caught out too often.

> And that means allocation failure as an effective signal is just
> completely busted in userspace. If you want to write code in
> userspace that uses as much memory as is available and no more, you
> _can't_, because system behaviour goes to shit if you have overcommit
> enabled or a bunch of memory gets wasted if overcommit is disabled
> because everyone assumes that's just what you do.

OK, this seems to be specific to your use case again, because if you
look at what the major user space processes like web browsers do, they
allocate way over the physical memory available to them for cache and
assume the kernel will take care of it.  Making failure a signal for
being over the working set would cause all these applications to
segfault almost immediately.

I think what you're asking for is an API to try to calculate what the
current available headroom in the working set would be?  That's highly
heuristic, but the mm people might have an idea how to do it.

> Let's _not_ go that route in the kernel. I have pointy sticks to
> brandish at people who don't want to deal with properly handling
> errors.

Error legs are the least exercised and most bug, and therefore exploit,
prone pieces of code in C.  If we can get rid of them, we should.

James


