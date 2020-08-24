Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCBC250432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Aug 2020 18:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHXQ6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Aug 2020 12:58:17 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:48191 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726701AbgHXQ6G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:58:06 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id DE99F40D;
        Mon, 24 Aug 2020 12:58:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 24 Aug 2020 12:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=date:from:to:cc:subject:message-id:reply-to:references
        :mime-version:content-type:in-reply-to; s=fm2; bh=KKQhtteZSrIZO6
        FRMbhF2/R/3GbYfNV/w4WeKmGtuvA=; b=ISfVwN+g2FN6r0JuDv2yYi0cuZoOtI
        BbvQIiNMq82bmQrUzWAJBWJxDWhZ+8CD3o2Al2e4VnzcjZ9y7xAopAki86d5iZXF
        DlpvNsCKSWQcFiCmvVOF6JETc2mUBd9EUxmzX13UuXnI4WkZjE6Vw/HnNmIIi+9c
        X0ngqm3fJwFYlsoIZrEek4ewjjur5g678Wupihh3HylJGerAJq42COIDCM/+MvMl
        g6Bo6IJPahw5EcBqTJUWMv45i3z2eTgBh+q4Pduf5vua2N3mw76eswVydGVlGgDI
        KELx9Ywo1yMwtxyGe+EDLoi2KzffohfhiKCDCpoWKhCsF42qMBd/2/PA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:reply-to:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=KKQhtteZSrIZO6FRMbhF2/R/3GbYfNV/w4WeKmGtuvA=; b=T4SjkeZU
        YBAk9JKXx5/tabflqrk2UUPz+99vte5ZybJEVqSTsOwdH/RXpGxHbKbh6/AY53lm
        2jNrZikYCzkPF+UQfyi9ach2celwanmJk4+E/zfKqSPGh/FLLBnFsJhrLJ3Qw5DE
        le3J6tTGAeAwZOfhUzjwqIRAMWoE4OOnmU6HOcLkhX5U0f9jOD4rwA0m+/3nbRhW
        2j+8chNdNOPn5+DVv1ooKkktmd0DrYpU5me1wiizAi7DQb7jSSmvzcerlk09VVX0
        sK6T2PORhg9YeIfV6HUol1rWz9y6rU5vTy+V/sdnDTIFKoZ1hk2hBFrK5LqsZxpK
        1RyDMAUFwVquzg==
X-ME-Sender: <xms:nPFDXw63zLqewMcNsGlZgkcKxxLgwYyh23VfpGt6H7VlRVMYn67BHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddukedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhrfhggtggujggfsehttdertddtreejnecuhfhrohhmpeeuvghn
    uceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlhdrnhgvtheqnecuggftrfgrth
    htvghrnhepheegteejgfeifeegvefffeeitdeitdetfffgudeftdfhgeekjeefudfgkedu
    gfeunecuffhomhgrihhnpehonhdrsghrnecukfhppeeiledrvddtgedrudeikedrvdeffe
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvges
    sggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:nPFDXx6hfqJawjBpFhAP2MD-HjD7JCu6mMkom8WSNTz8KZXKxZT5Tg>
    <xmx:nPFDX_fls3dYUSHZDUtgK2XGDbPUGK-TIcdlBlcPj8J4QlnuVgGO5w>
    <xmx:nPFDX1JAzA7IxzE0QstlLwltShipallZp7dqdCQ5FDb0vupE8CCMWw>
    <xmx:nPFDX5EjUkIKlvkCBMFfOeqaw4WWhbglg6AQBk11HoiFNbVR4Ltd_Q>
Received: from localhost (cpe-69-204-168-233.nycap.res.rr.com [69.204.168.233])
        by mail.messagingengine.com (Postfix) with ESMTPA id C62EF30600B1;
        Mon, 24 Aug 2020 12:58:03 -0400 (EDT)
Date:   Mon, 24 Aug 2020 12:58:02 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     David Howells <dhowells@redhat.com>
Cc:     mtk.manpages@gmail.com, torvalds@linux-foundation.org,
        keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Add a manpage for watch_queue(7)
Message-ID: <20200824165802.GB408760@erythro.dev.benboeckel.internal>
Reply-To: me@benboeckel.net
References: <20200807160531.GA1345000@erythro.dev.benboeckel.internal>
 <159681277616.35436.11229310534842613599.stgit@warthog.procyon.org.uk>
 <329586.1598282852@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <329586.1598282852@warthog.procyon.org.uk>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 24, 2020 at 16:27:32 +0100, David Howells wrote:
> Ben Boeckel <me@benboeckel.net> wrote:
> 
> > > +In the case of message loss,
> > > +.BR read (2)
> > > +will fabricate a loss message and pass that to userspace immediately after the
> > > +point at which the loss occurred.
> > 
> > If multiple messages are dropped in a row, is there one loss message per
> > loss message or per loss event?
> 
> One loss message.  I set a flag on the last slot in the pipe ring to say that
> message loss occurred, but there's insufficient space to store a counter
> without making the slot larger (and I really don't want to do that).
> 
> Note that every slot in the pipe ring has such a flag, so you could,
> theoretically, get a loss message after every normal message that you read
> out.

Ah, so a "you lost something" is just a flag on the next event that does
make it into the queue? I read it as a whole message existed indicating
that data was lost. Not sure of the best wording here.

> > > +A notification pipe allocates a certain amount of locked kernel memory (so that
> > > +the kernel can write a notification into it from contexts where allocation is
> > > +restricted), and so is subject to pipe resource limit restrictions.
> > 
> > A reference to the relevant manpage for resource limitations would be
> > nice here. I'd assume `setrlimit(2)`, but I don't see anything
> > pipe-specific there.
> 
> I can change that to:
> 
> 	... and so is subject to pipe resource limit restrictions - see
> 	.BR pipe (7),
> 	in the section on
> 	.BR "/proc files" .

+1

> > > +of interest to the watcher, a filter can be set on a queue to determine whether
> > 
> > "a filter can be set"? If multiple filters are allowed, "filters can be
> > added" might work better here to indicate that multiple filters are
> > allowed. Otherwise, "a single filter" would make it clearer that only
> > one is supported.
> 
> How about:
> 
> 	Because a source can produce a lot of different events, not all of
> 	which may be of interest to the watcher, a single set of filters can
> 	be set on a queue to determine whether a particular event will get
> 	inserted in a queue at the point of posting inside the kernel.

+1

> > Are there macros for extracting these fields available?
> 
> WATCH_INFO_LENGTH, WATCH_INFO_ID and WATCH_INFO_TYPE_INFO are masks.  There
> are also shift macros (you add __SHIFT to the mask macro name).  I'm not sure
> how best to do this in troff.

I think some mention that these things exist is fine. The `__SHIFT` ones
seem like more of an implementation details and can be left out here I
think.

> > Why not also have bitfields for these?
> 
> It makes it a lot simpler to filter.

I guess. In C sure, but it's not the only language that talks to the
kernel these days (Go and Rust being the main ones). Not that I expect
Go to really bind this syscall anytime soon, but who knows.

> > Or is there some ABI issues with
> > non-power-of-2 bitfield sizes? For clarity, which bit is bit 0? Low address
> > or LSB? Is this documented in some other manpage?
> 
> bit 0 is 2^0 in this case.  I'm not sure how better to describe it.

OK, so the bits are in native-endian order in the enclosing bytes. But C
just doesn't have a set ABI for bitfields (AFAIK), so I guess it's
"whatever GCC does" in practice?

> > Also, bit 7 is unused (for alignment I assume)? Is it always 0, 1, or
> > indeterminate?
> 
> It's reserved and should always be 0 - but that's solely at the kernel's
> discretion (ie. userspace doesn't gets to set it).

Makes sense.

> > > +This is used to set filters on the notifications that get written into the
> > 
> > "set" -> "add"? If I call this multiple times, is only the last call
> > effective or do I need to keep a list of all filters myself so I can
> > append in the future (since I see no analogous GET_FILTER call)?
> 
> "Set".  You cannot add filters, you can only set/replace/remove the whole set.
> 
> Also, I didn't provide a GET_FILTER, assuming that you could probably keep
> track of them yourself.

The process itself could, but criu basically gets a snapshot of the
process and has to be able to gather enough information to reconstruct
it.

> > Does this have implications for criu restoring a process?
> 
> Maybe?

It's probably worth asking the criu developers about it.

> > > +	unsigned char buf[128];
> > 
> > Is 128 the maximum message size?
> 
> 127 actually.  This is specified earlier in the manual page.

Ah, I see it now. I think I had forgotten by the time I got here.

> > Do we have a macro for this? If it isn't, shouldn't there be code for
> > detecting ENOBUFS and using a bigger buffer? Or at least not rolling with a
> > busted buffer.
> 
> WATCH_INFO_LENGTH can be used for this.  I'll make the example say:
> 
> 	unsigned char buf[WATCH_INFO_LENGTH];

+1

And that makes the ENOBUFS not a possible thing here, so that's fine.

> > > +	case WATCH_TYPE_META:
> > 
> > From above, if a filter is added, all messages not matching a filter are
> > dropped. Are WATCH_TYPE_META messages special in this case?
> 
> Yes.  They only do two things at the moment: Tell you that something you were
> watching went away and tell you that messages were lost.  I've amended the
> filter section to note that this cannot be filtered.

Thanks.

> > The Rust developer in me wants to see:
> 
> I don't touch Rust ;-)
> 
> > 	default:
> > 		/* Subtypes may be added in future kernel versions. */
> > 		printf("unrecognized meta subtype: %d\n", n->subtype);
> > 		break;
> > 
> > unless we're guaranteeing that no other subtypes exist for this type
> > (updating the docs with new types doesn't help those who copy/paste from
> > here as a seed).
> 
> I'm trying to keep the example small.  It's pseudo-code rather than real code.
> I *could* expand it to a fully working program, but that would make it a lot
> bigger and harder to read.  As you pointed out, I haven't bothered with the
> error checking, for example.

With ENOBUFS not being possible with the messages having a max size, I
think the glaring error about that case is OK to gloss over. I'm fine
with eliding over common error cases one might want to investigate more
(e.g., ENOSYS, EINVAL, etc.) is fine, but bigger things like not having
a big enough buffer would have at least warranted a comment (IMO).

Thanks,

--Ben
