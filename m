Return-Path: <linux-fsdevel+bounces-6522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BD18191A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 21:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5392884C2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Dec 2023 20:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD8639AEC;
	Tue, 19 Dec 2023 20:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="ByeeiWdZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350AD39AD0;
	Tue, 19 Dec 2023 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=K/lXgN5BftqIB2NPWo5ghozyvDmpveobly1bEzRYtfo=;
  b=ByeeiWdZVs/N8IODVg/UcgtGwAvK+qr1ZWWrOxCRnxdAn7U5qwBy4qI3
   Odb/P86f2dnAjZ9YAR969oYQ2ZodM5xs0YsUs40EOkobCvwIDdgJ55KHz
   LVK6xdjh+8HTNSgLpaRHb8ZqsakIck30oAmF8x81VpnbBqjgLKICGOl8F
   g=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,289,1695679200"; 
   d="scan'208";a="74895525"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 21:39:57 +0100
Date: Tue, 19 Dec 2023 21:39:56 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <linux@weissschuh.net>
cc: Luis Chamberlain <mcgrof@kernel.org>, 
    Joel Granados <j.granados@samsung.com>, 
    Dan Carpenter <dan.carpenter@linaro.org>, 
    Kees Cook <keescook@chromium.org>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    Iurii Zaikin <yzaikin@google.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
    linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/18] sysctl: constify sysctl ctl_tables
In-Reply-To: <a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de>
Message-ID: <alpine.DEB.2.22.394.2312192139150.3196@hadrien>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net> <20231207104357.kndqvzkhxqkwkkjo@localhost> <fa911908-a14d-4746-a58e-caa7e1d4b8d4@t-8ch.de> <20231208095926.aavsjrtqbb5rygmb@localhost> <8509a36b-ac23-4fcd-b797-f8915662d5e1@t-8ch.de>
 <20231212090930.y4omk62wenxgo5by@localhost> <ZXligolK0ekZ+Zuf@bombadil.infradead.org> <20231217120201.z4gr3ksjd4ai2nlk@localhost> <908dc370-7cf6-4b2b-b7c9-066779bc48eb@t-8ch.de> <ZYC37Vco1p4vD8ji@bombadil.infradead.org>
 <a0d96e7b-544f-42d5-b8da-85bc4ca087a9@t-8ch.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-627943610-1703018397=:3196"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-627943610-1703018397=:3196
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT



On Tue, 19 Dec 2023, Thomas Weißschuh wrote:

> Hi Luis and Julia,
>
> (Julia, there is a question and context for you inline, marked with your name)
>
> On 2023-12-18 13:21:49-0800, Luis Chamberlain wrote:
> > So we can split this up concentually in two:
> >
> >  * constificaiton of the table handlers
> >  * constification of the table struct itself
> >
> > On Sun, Dec 17, 2023 at 11:10:15PM +0100, Thomas Weißschuh wrote:
> > > The handlers can already be made const as shown in this series,
> >
> > The series did already produce issues with some builds, and so
> > Julia's point is confirmed that the series only proves hanlders
> > which you did build and for which 0-day has coverage for.
> >
> > The challenge here was to see if we could draw up a test case
> > that would prove this without build tests, and what occurred to
> > me was coccinelle or smatch.
>
> I used the following coccinelle script to find more handlers that I
> missed before:
>
> virtual patch
> virtual context
> virtual report
>
> @@
> identifier func;
> identifier ctl;
> identifier write;
> identifier buffer;
> identifier lenp;
> identifier ppos;
> type loff_t;
> @@
>
> int func(
> - struct ctl_table *ctl,
> + const struct ctl_table *ctl,
>   int write, void *buffer, size_t *lenp, loff_t *ppos) { ... }
>
> It did not find any additional occurrences while it was able to match
> the existing changes.
>
> After that I manually reviewed all handlers that they are not modifying
> their table argument, which they don't.
>
> Should we do more?
>
>
> For Julia:
>
> Maybe you could advise on how to use coccinelle to find where a const
> function argument or one of its members are modified directly or passed
> to some other function as non-const arguments.
> See the coccinelle patch above.
>
> Is this possible?

I will propose something.

>
> > > > If that is indeed what you are proposing, you might not even need the
> > > > un-register step as all the mutability that I have seen occurs before
> > > > the register. So maybe instead of re-registering it, you can so a copy
> > > > (of the changed ctl_table) to a const pointer and then pass that along
> > > > to the register function.
> > >
> > > Tables that are modified, but *not* through the handler, would crop
> > > during the constification of the table structs.
> > > Which should be a second step.
> >
> > Instead of "croping up" at build time again, I wonder if we can do
> > better with coccinelle / smatch.
>
> As for smatch:
>
> Doesn't smatch itself run as part of a normal build [0]?
> So it would have the same visibility issues as the compiler itself.

I also believe that this is the case.

julia

> > Joel, and yes, what you described is what I was suggesting, that is to
> > avoid having to add a non-const handler a first step, instead we modify
> > those callers which do require to modify the table by first a
> > deregistration and later a registration. In fact to make this even
> > easier a new call would be nice so to aslo be able to git grep when
> > this is done in the kernel.
> >
> > But if what you suggest is true that there are no registrations which
> > later modify the table, we don't need that. It is the uncertainty that
> > we might have that this is a true statment that I wanted to challenge
> > to see if we could do better. Can we avoid this being a stupid
> > regression later by doing code analysis with coccinelle / smatch?
> >
> > The template of the above endeavor seems useful not only to this use
> > case but to any place in the kernel where this previously has been done
> > before, and hence my suggestion that this seems like a sensible thing
> > to think over to see if we could generalize.
>
> I'd like to split the series and submit the part up until and including
> the constification of arguments first and on its own.
> It keeps the subsystem maintainers out of the discussion of the core
> sysctl changes.
>
> I'll submit the core sysctl changes after I figure out proper responses
> to all review comments and we can do this in parallel to the tree-wide
> preparation.
>
> What do you think Luis and Joel?
>
> [0] https://repo.or.cz/smatch.git/blob/HEAD:/smatch_scripts/test_kernel.sh
>
--8323329-627943610-1703018397=:3196--

